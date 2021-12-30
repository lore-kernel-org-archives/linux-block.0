Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Dec 2021 03:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhL3Dpr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 22:45:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235449AbhL3Dpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 22:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640835946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZgceoptduseXpkhN3aGAd6Y1g+mAU3eLFSwrtgQNRug=;
        b=KlMcyGwCpjcCkNiANvESYc2S/RZ/mN/IrZFeipd39C6aZnlwfpFhRNuezDBpyDcs4Se7iw
        NkmnjFBrKFxQwtxoD7Ak4VvB8GOnN8EPfSfY57LPqZD1UqeMIYsKtqWSF9tlbhgD+IP4Ag
        AqlBp5FkH9aWkZXj9bdZqffFALtZgGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-SnYPLp_jMmuxBlSmyrQ8bg-1; Wed, 29 Dec 2021 22:45:43 -0500
X-MC-Unique: SnYPLp_jMmuxBlSmyrQ8bg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B05561006AA5;
        Thu, 30 Dec 2021 03:45:41 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55AE5E71C;
        Thu, 30 Dec 2021 03:45:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        lining2020x@163.com, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: [PATCH] block: throttle: charge io re-submission for iops limit
Date:   Thu, 30 Dec 2021 11:45:13 +0800
Message-Id: <20211230034513.131619-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 111be8839817 ("block-throttle: avoid double charge") marks bio as
BIO_THROTTLED unconditionally if __blk_throtl_bio() is called on this bio,
then this bio won't be called into __blk_throtl_bio() any more. This way
is to avoid double charge in case of bio splitting. It is reasonable for
read/write throughput limit, but not reasonable for IOPS limit because
block layer provides io accounting against split bio.

Chunguang Xu has already observed this issue and fixed it in commit
4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios").
However, that patch only covers bio splitting in __blk_queue_split(), and
we have other kind of bio splitting, such as bio_split() & submit_bio_noacct()
and other ways.

This patch tries to fix the issue in one generic way, by always charge
the bio for iops limit in blk_throtl_bio() in case that BIO_THROTTLED
is set. This way is reasonable: re-submission & fast-cloned bio is charged
if it is submitted to same disk/queue, and BIO_THROTTLED will be cleared
if bio->bi_bdev is changed.

Reported-by: lining2020x@163.com
Cc: Tejun Heo <tj@kernel.org>
Cc: Chunguang Xu <brookxu@tencent.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c    | 2 --
 block/blk-throttle.c | 2 +-
 block/blk-throttle.h | 8 +++++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4de34a332c9f..f5255991b773 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -368,8 +368,6 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		trace_block_split(split, (*bio)->bi_iter.bi_sector);
 		submit_bio_noacct(*bio);
 		*bio = split;
-
-		blk_throtl_charge_bio_split(*bio);
 	}
 }
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7c462c006b26..ea532c178385 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2043,7 +2043,7 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
-void blk_throtl_charge_bio_split(struct bio *bio)
+void blk_throtl_charge_for_iops_limit(struct bio *bio)
 {
 	struct blkcg_gq *blkg = bio->bi_blkg;
 	struct throtl_grp *parent = blkg_to_tg(blkg);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 175f03abd9e4..954b9cac19b7 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -158,20 +158,22 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
-static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
+static inline void blk_throtl_charge_for_iops_limit(struct bio *bio) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
 #else /* CONFIG_BLK_DEV_THROTTLING */
 int blk_throtl_init(struct request_queue *q);
 void blk_throtl_exit(struct request_queue *q);
 void blk_throtl_register_queue(struct request_queue *q);
-void blk_throtl_charge_bio_split(struct bio *bio);
+void blk_throtl_charge_for_iops_limit(struct bio *bio);
 bool __blk_throtl_bio(struct bio *bio);
 static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 
-	if (bio_flagged(bio, BIO_THROTTLED))
+	if (bio_flagged(bio, BIO_THROTTLED)) {
+		blk_throtl_charge_for_iops_limit(bio);
 		return false;
+	}
 	if (!tg->has_rules[bio_data_dir(bio)])
 		return false;
 
-- 
2.31.1


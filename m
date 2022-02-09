Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897BAC4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 09:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiBIJlq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:41:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbiBIJhr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 04:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8550E061474
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 01:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRxYrQUcMTAHpCOFEvneOyax/ys6LVRrl1WThC3BbfM=;
        b=h6u6sv1PgmJYyWcZvVFnuuZQvddEZ1kHMFvlRnWJZ+bD5iuCHyFNCSb1wy1h7eORMdNJYe
        kW3JnlGeCinXY3R/V/tB82oOKPHsS15vq6sZlK2ITG7b4gmkJ+dsMUaACwAhzJcmWuPHWF
        IBp6CAA7FZOznZoEcJ3SM8l08R5G1iI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-wBVyGXE7PZCPbQ5UNDsSFQ-1; Wed, 09 Feb 2022 04:15:27 -0500
X-MC-Unique: wBVyGXE7PZCPbQ5UNDsSFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9AF218B9F03;
        Wed,  9 Feb 2022 09:15:26 +0000 (UTC)
Received: from localhost (ovpn-8-35.pek2.redhat.com [10.72.8.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D00BC5DBB4;
        Wed,  9 Feb 2022 09:15:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/7] block: throttle split bio in case of iops limit
Date:   Wed,  9 Feb 2022 17:14:27 +0800
Message-Id: <20220209091429.1929728-6-ming.lei@redhat.com>
In-Reply-To: <20220209091429.1929728-1-ming.lei@redhat.com>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
we have other kind of bio splitting, such as bio_split() &
submit_bio_noacct() and other ways.

This patch tries to fix the issue in one generic way by always charging
the bio for iops limit in blk_throtl_bio(). This way is reasonable:
re-submission & fast-cloned bio is charged if it is submitted to same
disk/queue, and BIO_THROTTLED will be cleared if bio->bi_bdev is changed.

This new approach can get much more smooth/stable iops limit compared with
commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO
scenarios") since that commit can't throttle current split bios actually.

Also this way won't cause new double bio iops charge in
blk_throtl_dispatch_work_fn() in which blk_throtl_bio() won't be called
any more.

Reported-by: Li Ning <lining2020x@163.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Chunguang Xu <brookxu@tencent.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c    |  2 --
 block/blk-throttle.c | 10 +++++++---
 block/blk-throttle.h |  2 --
 3 files changed, 7 insertions(+), 7 deletions(-)

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
index 6cca1715c31e..6f2a8e7801fe 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -808,7 +808,8 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
-	if (bps_limit == U64_MAX) {
+	/* no need to throttle if this bio's bytes have been accounted */
+	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -920,9 +921,12 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* Charge the bio to the group */
-	tg->bytes_disp[rw] += bio_size;
+	if (!bio_flagged(bio, BIO_THROTTLED)) {
+		tg->bytes_disp[rw] += bio_size;
+		tg->last_bytes_disp[rw] += bio_size;
+	}
+
 	tg->io_disp[rw]++;
-	tg->last_bytes_disp[rw] += bio_size;
 	tg->last_io_disp[rw]++;
 
 	/*
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 175f03abd9e4..cb43f4417d6e 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -170,8 +170,6 @@ static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 
-	if (bio_flagged(bio, BIO_THROTTLED))
-		return false;
 	if (!tg->has_rules[bio_data_dir(bio)])
 		return false;
 
-- 
2.31.1


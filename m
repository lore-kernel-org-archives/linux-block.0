Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9770C43217
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 09:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiBIJlr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:41:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbiBIJhq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 04:37:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83C37E01527A
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 01:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHiiFgF4njvaOJoQXN9nZLD4HYyWAAu92dax4mN9PvU=;
        b=FWh7/ndwXcMF1XDwn15/3WwqehN+3HKkyuM0ca5JciVhs96sl92snN4I+D8Cvx0oZmS6o5
        ne5rD4bzYOWU5YwwKIlI1uhWJDO+Ly5oNlx5s0/9ZfRkTiR3PMxuaV+9RK2l0cQgMdYTv0
        HEcqGGrW+7j5J5CC3wFLKWctkMgsBGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-z_on-l2MPaKNGyzlZMoqrw-1; Wed, 09 Feb 2022 04:15:16 -0500
X-MC-Unique: z_on-l2MPaKNGyzlZMoqrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E2A0107B0EF;
        Wed,  9 Feb 2022 09:15:15 +0000 (UTC)
Received: from localhost (ovpn-8-35.pek2.redhat.com [10.72.8.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F85F694D9;
        Wed,  9 Feb 2022 09:15:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/7] block: move blk_crypto_bio_prep() out of blk-mq.c
Date:   Wed,  9 Feb 2022 17:14:24 +0800
Message-Id: <20220209091429.1929728-3-ming.lei@redhat.com>
In-Reply-To: <20220209091429.1929728-1-ming.lei@redhat.com>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_crypto_bio_prep() is called for both bio based and blk-mq drivers,
so move it out of blk-mq.c, then we can unify this kind of handling.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 18 ++++++------------
 block/blk-mq.c   |  3 ---
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bf989b1b3bea..1514dbab0bd8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -786,26 +786,20 @@ noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	return false;
 }
 
-static void __submit_bio_fops(struct gendisk *disk, struct bio *bio)
+static void __submit_bio(struct bio *bio)
 {
 	if (blk_crypto_bio_prep(&bio)) {
-		if (likely(bio_queue_enter(bio) == 0)) {
+		struct gendisk *disk = bio->bi_bdev->bd_disk;
+
+		if (!disk->fops->submit_bio) {
+			blk_mq_submit_bio(bio);
+		} else if (likely(bio_queue_enter(bio) == 0)) {
 			disk->fops->submit_bio(bio);
 			blk_queue_exit(disk->queue);
 		}
 	}
 }
 
-static void __submit_bio(struct bio *bio)
-{
-	struct gendisk *disk = bio->bi_bdev->bd_disk;
-
-	if (!disk->fops->submit_bio)
-		blk_mq_submit_bio(bio);
-	else
-		__submit_bio_fops(disk, bio);
-}
-
 /*
  * The loop in this function may be a bit non-obvious, and so deserves some
  * explanation:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b868e792ba4..fa1c38a05d5a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2786,9 +2786,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
-	if (unlikely(!blk_crypto_bio_prep(&bio)))
-		return;
-
 	blk_queue_bounce(q, &bio);
 	if (blk_may_split(q, bio))
 		__blk_queue_split(q, &bio, &nr_segs);
-- 
2.31.1


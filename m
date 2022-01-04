Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927AFC433EF
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 13:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiADNmg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 08:42:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbiADNmg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jan 2022 08:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641303755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zakyXifonvoZMzYf4EQb+8WeoxPvATZSU3z0Wh0pUOo=;
        b=fx5+9Y4PDbP3u6ziYoUTz2dN1b3eFEbpB3ImdloYRCsvtEGn9S5zMDMtPFLq9tAsNuyEtM
        n04yVH5rc6XZGX/k9UtWaEI8pPwBQ0zzFKvJadGDqfFl+gnVuJlNBi4vuD+vR3b6TMgR2+
        ZE+Q6sGUUpsODwYuUzgBSQ9L11FIkgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-lCZQV6cwM-iUrVQbeu3ucg-1; Tue, 04 Jan 2022 08:42:34 -0500
X-MC-Unique: lCZQV6cwM-iUrVQbeu3ucg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28E7B1926DA1;
        Tue,  4 Jan 2022 13:42:33 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3019E7B6D4;
        Tue,  4 Jan 2022 13:42:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: don't protect submit_bio_checks by q_usage_counter
Date:   Tue,  4 Jan 2022 21:42:23 +0800
Message-Id: <20220104134223.590803-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit cc9c884dd7f4 ("block: call submit_bio_checks under q_usage_counter")
uses q_usage_counter to protect submit_bio_checks for avoiding IO after
disk is deleted by del_gendisk().

Turns out the protection isn't necessary, because once
blk_mq_freeze_queue_wait() in del_gendisk() returns:

1) all in-flight IO has been done

2) all new IO will be failed in __bio_queue_enter() because
   q_usage_counter is dead, and GD_DEAD is set

3) both disk and request queue instance are safe since caller of
submit_bio() guarantees that the disk can't be closed.

Once submit_bio_checks() needn't the protection of q_usage_counter, we can
move submit_bio_checks before calling blk_mq_submit_bio() and
->submit_bio(). With this change, we needn't to throttle queue with
holding one allocated request, then precise driver tag or request won't be
wasted in throttling. Meantime we can unify the bio check for both bio
based and request based driver.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 14 +++++++++-----
 block/blk-mq.c   | 39 +++++++++++++--------------------------
 2 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 10619fd83c1b..97f8bc8d3a79 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -787,17 +787,21 @@ noinline_for_stack bool submit_bio_checks(struct bio *bio)
 
 static void __submit_bio_fops(struct gendisk *disk, struct bio *bio)
 {
-	if (unlikely(bio_queue_enter(bio) != 0))
-		return;
-	if (submit_bio_checks(bio) && blk_crypto_bio_prep(&bio))
-		disk->fops->submit_bio(bio);
-	blk_queue_exit(disk->queue);
+	if (blk_crypto_bio_prep(&bio)) {
+		if (likely(bio_queue_enter(bio) == 0)) {
+			disk->fops->submit_bio(bio);
+			blk_queue_exit(disk->queue);
+		}
+	}
 }
 
 static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
+	if (unlikely(!submit_bio_checks(bio)))
+		return;
+
 	if (!disk->fops->submit_bio)
 		blk_mq_submit_bio(bio);
 	else
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0d7c9d3e0329..a6d4780580fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2714,26 +2714,18 @@ static bool blk_mq_attempt_bio_merge(struct request_queue *q,
 
 static struct request *blk_mq_get_new_requests(struct request_queue *q,
 					       struct blk_plug *plug,
-					       struct bio *bio,
-					       unsigned int nsegs)
+					       struct bio *bio)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.nr_tags	= 1,
+		.cmd_flags	= bio->bi_opf,
 	};
 	struct request *rq;
 
 	if (unlikely(bio_queue_enter(bio)))
 		return NULL;
-	if (unlikely(!submit_bio_checks(bio)))
-		goto queue_exit;
-	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
-		goto queue_exit;
 
-	rq_qos_throttle(q, bio);
-
-	/* ->bi_opf is finalized after submit_bio_checks() returns */
-	data.cmd_flags	= bio->bi_opf;
 	if (plug) {
 		data.nr_tags = plug->nr_ios;
 		plug->nr_ios = 1;
@@ -2746,13 +2738,12 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
-queue_exit:
 	blk_queue_exit(q);
 	return NULL;
 }
 
 static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
-		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
+		struct blk_plug *plug, struct bio *bio)
 {
 	struct request *rq;
 
@@ -2762,21 +2753,14 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	if (!rq || rq->q != q)
 		return NULL;
 
-	if (unlikely(!submit_bio_checks(*bio)))
-		return NULL;
-	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
-		*bio = NULL;
+	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
 		return NULL;
-	}
-	if (blk_mq_get_hctx_type((*bio)->bi_opf) != rq->mq_hctx->type)
-		return NULL;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
 		return NULL;
 
-	rq->cmd_flags = (*bio)->bi_opf;
+	rq->cmd_flags = bio->bi_opf;
 	plug->cached_rq = rq_list_next(rq);
 	INIT_LIST_HEAD(&rq->queuelist);
-	rq_qos_throttle(q, *bio);
 	return rq;
 }
 
@@ -2812,11 +2796,14 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		return;
 
-	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
+	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
+		return;
+
+	rq_qos_throttle(q, bio);
+
+	rq = blk_mq_get_cached_request(q, plug, bio);
 	if (!rq) {
-		if (!bio)
-			return;
-		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
+		rq = blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq))
 			return;
 	}
-- 
2.31.1


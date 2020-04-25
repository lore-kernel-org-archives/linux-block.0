Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F112C55194
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED95E206B6
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t3kK50IK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgDYRKP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYRKP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 13:10:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F30C09B04D
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fu6DZjpYarQXlncpu81JX3wLDkuYFv6dgcITolLsLis=; b=t3kK50IKrNP7/qiOQYXa4dV6ZD
        sxcuxpawmbUSBENpadzw1+yOXmTSk0gVElubvTiOFgX3afV1GsG6fVM/gojijHq1rBsVN/7rxk/2M
        t1RGwYcPcLIUCvXGvvztSm3BX/Gj1qKp3vfoRxXsgGuvAyxsCExDKYPqdPOgP2Q8sKrWjrMKFypwq
        lO1VL7G+QpHt4l45H2+PDfCOXkGG+sbyCzBoO8n7o0PUUzT6T85h0nZdI6ccgyYxJDclWG5DoMO4C
        jnc+LlFHth8pSdaav1XdkPRz2OA59MH5IqI8yPVHhjXwp5TQtVMaQEXouOcdYoVIIUpJ/ycSQG0ca
        TzHcWa0g==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSOJi-0004Dt-Nr; Sat, 25 Apr 2020 17:10:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 11/11] block: allow blk_mq_make_request to consume the q_usage_counter reference
Date:   Sat, 25 Apr 2020 19:09:44 +0200
Message-Id: <20200425170944.968861-12-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425170944.968861-1-hch@lst.de>
References: <20200425170944.968861-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_make_request currently needs to grab an q_usage_counter
reference when allocating a request.  This is because the block layer
grabs one before calling blk_mq_make_request, but also releases it as
soon as blk_mq_make_request returns.  Remove the blk_queue_exit call
after blk_mq_make_request returns, and instead let it consume the
reference.  This works perfectly fine for the block layer caller, just
device mapper needs an extra reference as the old problem still
persists there.  Open code blk_queue_enter_live in device mapper,
as there should be no other callers and this allows better documenting
why we do a non-try get.

Also remove the pointless request_queue argument to blk_mq_make_request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       |  7 +------
 block/blk-mq.c         | 17 +++++++++--------
 block/blk.h            | 11 -----------
 drivers/md/dm.c        | 13 +++++++++++--
 include/linux/blk-mq.h |  2 +-
 5 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d196799e68881..1fda07af3ff3b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1010,14 +1010,9 @@ generic_make_request_checks(struct bio *bio)
 
 static inline blk_qc_t __direct_make_request(struct bio *bio)
 {
-	struct request_queue *q = bio->bi_disk->queue;
-	blk_qc_t ret;
-
 	if (unlikely(bio_queue_enter(bio)))
 		return BLK_QC_T_NONE;
-	ret = blk_mq_make_request(q, bio);
-	blk_queue_exit(q);
-	return ret;
+	return blk_mq_make_request(bio);
 }
 
 static blk_qc_t do_make_request(struct bio *bio,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6375ed55cdfa7..d97f74a82e8f8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1968,7 +1968,6 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 
 /**
  * blk_mq_make_request - Create and send a request to block device.
- * @q: Request queue pointer.
  * @bio: Bio pointer.
  *
  * Builds up a request structure from @q and @bio and send to the device. The
@@ -1982,8 +1981,9 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
  *
  * Returns: Request queue cookie.
  */
-blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
+blk_qc_t blk_mq_make_request(struct bio *bio)
 {
+	struct request_queue *q = bio->bi_disk->queue;
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
 	struct blk_mq_alloc_data data = { .flags = 0};
@@ -1997,26 +1997,24 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	__blk_queue_split(q, &bio, &nr_segs);
 
 	if (!bio_integrity_prep(bio))
-		return BLK_QC_T_NONE;
+		goto queue_exit;
 
 	if (!is_flush_fua && !blk_queue_nomerges(q) &&
 	    blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
-		return BLK_QC_T_NONE;
+		goto queue_exit;
 
 	if (blk_mq_sched_bio_merge(q, bio, nr_segs))
-		return BLK_QC_T_NONE;
+		goto queue_exit;
 
 	rq_qos_throttle(q, bio);
 
 	data.cmd_flags = bio->bi_opf;
-	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, bio, &data);
 	if (unlikely(!rq)) {
-		blk_queue_exit(q);
 		rq_qos_cleanup(q, bio);
 		if (bio->bi_opf & REQ_NOWAIT)
 			bio_wouldblock_error(bio);
-		return BLK_QC_T_NONE;
+		goto queue_exit;
 	}
 
 	trace_block_getrq(q, bio, bio->bi_opf);
@@ -2095,6 +2093,9 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	}
 
 	return cookie;
+queue_exit:
+	blk_queue_exit(q);
+	return BLK_QC_T_NONE;
 }
 EXPORT_SYMBOL_GPL(blk_mq_make_request); /* only for request based dm */
 
diff --git a/block/blk.h b/block/blk.h
index 73bd3b1c69384..f5b271a8a5016 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -62,17 +62,6 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
 
-static inline void blk_queue_enter_live(struct request_queue *q)
-{
-	/*
-	 * Given that running in generic_make_request() context
-	 * guarantees that a live reference against q_usage_counter has
-	 * been established, further references under that same context
-	 * need not check that the queue has been frozen (marked dead).
-	 */
-	percpu_ref_get(&q->q_usage_counter);
-}
-
 static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 0eb93da44ea2a..dc191da217f78 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1788,8 +1788,17 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 	int srcu_idx;
 	struct dm_table *map;
 
-	if (dm_get_md_type(md) == DM_TYPE_REQUEST_BASED)
-		return blk_mq_make_request(q, bio);
+	if (dm_get_md_type(md) == DM_TYPE_REQUEST_BASED) {
+		/*
+		 * We are called with a live reference on q_usage_counter, but
+		 * that one will be released as soon as we return.  Grab an
+		 * extra one as blk_mq_make_request expects to be able to
+		 * consume a reference (which lives until the request is freed
+		 * in case a request is allocated).
+		 */
+		percpu_ref_get(&q->q_usage_counter);
+		return blk_mq_make_request(bio);
+	}
 
 	map = dm_get_live_table(md, &srcu_idx);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d7307795439a4..13038954f67be 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -578,6 +578,6 @@ static inline void blk_mq_cleanup_rq(struct request *rq)
 		rq->q->mq_ops->cleanup_rq(rq);
 }
 
-blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio);
+blk_qc_t blk_mq_make_request(struct bio *bio);
 
 #endif
-- 
2.26.1


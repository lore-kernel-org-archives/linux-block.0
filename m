Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8211BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhKWQHz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbhKWQHz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:07:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556CAC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F3q77HUzKiAGM0C+WY9eO+J/kA//Hz2Zs3PcQcCxdiA=; b=Nofb/d3JywLTOPfOOAuJgo4Xus
        ZDMgOsPGfR+2zi+UhRsgLxRGG6r15X5oHJf9AAvYmXWoONvBU8kp157CGh7cKMXoz1KTuabHd/8dA
        fMUEdvT9nf1jt6gIuURWjyKYgruBIOJMAHdxf5X3NhXfW11jjqsc6Jmyi9CpEnkjaoFkCUq9lVpRk
        GNzz7WyMnVNBZC0kaRBwD40k9BsAyXMd6JxptTaWkeeHWprPa7pAFK8A8/bggBVmkt9Q27XTzz7k+
        YIRMoV4qFHmmaPpIETClRl4byxaAJqmNw7UEmghqwX8dUbFN245//8A/aganOEf/dd3bfqjp4B/2c
        zwEASuag==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpYHk-00FRhu-RM; Tue, 23 Nov 2021 16:04:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/3] blk-mq: simplify the plug handling in blk_mq_submit_bio
Date:   Tue, 23 Nov 2021 17:04:41 +0100
Message-Id: <20211123160443.1315598-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123160443.1315598-1-hch@lst.de>
References: <20211123160443.1315598-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_submit_bio has two different plug cases, one that uses full
plugging and a limited plugging one.

The limited plugging case is only used for a corner case that does
not matter in real life:

 - no ->commit_rqs (so not NVMe)
 - no shared tags (so not SCSI)
 - not rotational (so no old disk or floppy driver)
 - must have multiple queues (so no eMMC)

Remove the limited merging case and all the related junk to simplify
blk_mq_submit_bio and the functions called from it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c |  9 +------
 block/blk-mq.c    | 68 +++++++++--------------------------------------
 block/blk.h       |  2 +-
 3 files changed, 15 insertions(+), 64 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 893c1a60b701f..ba761c3f482ba 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1067,7 +1067,6 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
  * @q: request_queue new bio is being queued at
  * @bio: new bio being queued
  * @nr_segs: number of segments in @bio
- * @same_queue_rq: output value, will be true if there's an existing request
  * from the passed in @q already in the plug list
  *
  * Determine whether @bio being queued on @q can be merged with the previous
@@ -1084,7 +1083,7 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
  * Caller must ensure !blk_queue_nomerges(q) beforehand.
  */
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs, bool *same_queue_rq)
+		unsigned int nr_segs)
 {
 	struct blk_plug *plug;
 	struct request *rq;
@@ -1096,12 +1095,6 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	/* check the previously added entry for a quick merge attempt */
 	rq = rq_list_peek(&plug->mq_list);
 	if (rq->q == q) {
-		/*
-		 * Only blk-mq multiple hardware queues case checks the rq in
-		 * the same queue, there should be only one such rq in a queue
-		 */
-		*same_queue_rq = true;
-
 		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
 				BIO_MERGE_OK)
 			return true;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1feb9ab65f28a..f05c458d983b4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2689,11 +2689,10 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 }
 
 static bool blk_mq_attempt_bio_merge(struct request_queue *q,
-				     struct bio *bio, unsigned int nr_segs,
-				     bool *same_queue_rq)
+				     struct bio *bio, unsigned int nr_segs)
 {
 	if (!blk_queue_nomerges(q) && bio_mergeable(bio)) {
-		if (blk_attempt_plug_merge(q, bio, nr_segs, same_queue_rq))
+		if (blk_attempt_plug_merge(q, bio, nr_segs))
 			return true;
 		if (blk_mq_sched_bio_merge(q, bio, nr_segs))
 			return true;
@@ -2704,8 +2703,7 @@ static bool blk_mq_attempt_bio_merge(struct request_queue *q,
 static struct request *blk_mq_get_new_requests(struct request_queue *q,
 					       struct blk_plug *plug,
 					       struct bio *bio,
-					       unsigned int nsegs,
-					       bool *same_queue_rq)
+					       unsigned int nsegs)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
@@ -2714,7 +2712,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	};
 	struct request *rq;
 
-	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
+	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
 		return NULL;
 
 	rq_qos_throttle(q, bio);
@@ -2751,8 +2749,7 @@ static inline bool blk_mq_can_use_cached_rq(struct request *rq,
 static inline struct request *blk_mq_get_request(struct request_queue *q,
 						 struct blk_plug *plug,
 						 struct bio *bio,
-						 unsigned int nsegs,
-						 bool *same_queue_rq)
+						 unsigned int nsegs)
 {
 	struct request *rq;
 	bool checked = false;
@@ -2763,8 +2760,7 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 		if (rq && rq->q == q) {
 			if (unlikely(!submit_bio_checks(bio)))
 				return NULL;
-			if (blk_mq_attempt_bio_merge(q, bio, nsegs,
-						same_queue_rq))
+			if (blk_mq_attempt_bio_merge(q, bio, nsegs))
 				return NULL;
 			checked = true;
 			if (!blk_mq_can_use_cached_rq(rq, bio))
@@ -2782,7 +2778,7 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 		return NULL;
 	if (!checked && !submit_bio_checks(bio))
 		return NULL;
-	rq = blk_mq_get_new_requests(q, plug, bio, nsegs, same_queue_rq);
+	rq = blk_mq_get_new_requests(q, plug, bio, nsegs);
 	if (!rq)
 		blk_queue_exit(q);
 	return rq;
@@ -2807,7 +2803,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct request *rq;
 	struct blk_plug *plug;
-	bool same_queue_rq = false;
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
@@ -2822,7 +2817,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		return;
 
 	plug = blk_mq_plug(q, bio);
-	rq = blk_mq_get_request(q, plug, bio, nr_segs, &same_queue_rq);
+	rq = blk_mq_get_request(q, plug, bio, nr_segs);
 	if (unlikely(!rq))
 		return;
 
@@ -2843,16 +2838,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
 		return;
 
-	if (plug && (q->nr_hw_queues == 1 ||
-	    blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
-	    q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
-		/*
-		 * Use plugging if we have a ->commit_rqs() hook as well, as
-		 * we know the driver uses bd->last in a smart fashion.
-		 *
-		 * Use normal plugging if this disk is slow HDD, as sequential
-		 * IO may benefit a lot from plug merging.
-		 */
+	if (plug) {
 		unsigned int request_count = plug->rq_count;
 		struct request *last = NULL;
 
@@ -2870,40 +2856,12 @@ void blk_mq_submit_bio(struct bio *bio)
 		}
 
 		blk_add_rq_to_plug(plug, rq);
-	} else if (rq->rq_flags & RQF_ELV) {
-		/* Insert the request at the IO scheduler queue */
+	} else if ((rq->rq_flags & RQF_ELV) ||
+		   (rq->mq_hctx->dispatch_busy &&
+		    (q->nr_hw_queues == 1 || !is_sync))) {
 		blk_mq_sched_insert_request(rq, false, true, true);
-	} else if (plug && !blk_queue_nomerges(q)) {
-		struct request *next_rq = NULL;
-
-		/*
-		 * We do limited plugging. If the bio can be merged, do that.
-		 * Otherwise the existing request in the plug list will be
-		 * issued. So the plug list will have one request at most
-		 * The plug list might get flushed before this. If that happens,
-		 * the plug list is empty, and same_queue_rq is invalid.
-		 */
-		if (same_queue_rq) {
-			next_rq = rq_list_pop(&plug->mq_list);
-			plug->rq_count--;
-		}
-		blk_add_rq_to_plug(plug, rq);
-		trace_block_plug(q);
-
-		if (next_rq) {
-			trace_block_unplug(q, 1, true);
-			blk_mq_try_issue_directly(next_rq->mq_hctx, next_rq);
-		}
-	} else if ((q->nr_hw_queues > 1 && is_sync) ||
-		   !rq->mq_hctx->dispatch_busy) {
-		/*
-		 * There is no scheduler and we can try to send directly
-		 * to the hardware.
-		 */
-		blk_mq_try_issue_directly(rq->mq_hctx, rq);
 	} else {
-		/* Default case. */
-		blk_mq_sched_insert_request(rq, false, true, true);
+		blk_mq_try_issue_directly(rq->mq_hctx, rq);
 	}
 }
 
diff --git a/block/blk.h b/block/blk.h
index 296e3010f8d65..cfac3bdeb77d9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -253,7 +253,7 @@ void blk_add_timer(struct request *req);
 const char *blk_status_to_str(blk_status_t status);
 
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs, bool *same_queue_rq);
+		unsigned int nr_segs);
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 			struct bio *bio, unsigned int nr_segs);
 
-- 
2.30.2


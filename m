Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757634AbdECT7D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 15:59:03 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/5] blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
Date: Thu,  4 May 2017 03:58:35 +0800
Message-Id: <20170503195839.6539-2-ming.lei@redhat.com>
In-Reply-To: <20170503195839.6539-1-ming.lei@redhat.com>
References: <20170503195839.6539-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When blk-mq I/O scheduler is used, we need two tags for
submitting one request. One is called scheduler tag for
allocating request and scheduling I/O, another one is called
driver tag, which is used for dispatching IO to hardware/driver.
This way introduces one extra per-queue allocation for both tags
and request pool, and may not be as efficient as case of none
scheduler.

Also currently we put a default per-hctx limit on schedulable
requests, and this limit may be a bottleneck for some devices,
especialy when these devices have a quite big tag space.

This patch introduces BLK_MQ_F_SCHED_USE_HW_TAG so that we can
allow to use hardware/driver tags directly for IO scheduling if
devices's hardware tag space is big enough. Then we can avoid
the extra resource allocation and make IO submission more
efficient.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/blk-mq-sched.c   | 10 +++++++++-
 block/blk-mq.c         | 35 +++++++++++++++++++++++++++++------
 block/kyber-iosched.c  |  7 ++++++-
 include/linux/blk-mq.h |  1 +
 5 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index bcd2a7d4a3a5..bc390847a60d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -220,6 +220,7 @@ static const char *const hctx_flag_name[] = {
 	[ilog2(BLK_MQ_F_SG_MERGE)]	= "SG_MERGE",
 	[ilog2(BLK_MQ_F_BLOCKING)]	= "BLOCKING",
 	[ilog2(BLK_MQ_F_NO_SCHED)]	= "NO_SCHED",
+	[ilog2(BLK_MQ_F_SCHED_USE_HW_TAG)]	= "SCHED_USE_HW_TAG",
 };
 
 static int hctx_flags_show(struct seq_file *m, void *v)
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e79e9f18d7c2..817c97c88942 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -83,7 +83,12 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 
 	if (e) {
-		data->flags |= BLK_MQ_REQ_INTERNAL;
+		/*
+		 * If BLK_MQ_F_SCHED_USE_HW_TAG is set, we use hardware
+		 * tag for IO scheduler directly.
+		 */
+		if (!(data->hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG))
+			data->flags |= BLK_MQ_REQ_INTERNAL;
 
 		/*
 		 * Flush requests are special and go directly to the
@@ -429,6 +434,9 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
 	struct blk_mq_tag_set *set = q->tag_set;
 	int ret;
 
+	if (hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG)
+		return 0;
+
 	hctx->sched_tags = blk_mq_alloc_rq_map(set, hctx_idx, q->nr_requests,
 					       set->reserved_tags);
 	if (!hctx->sched_tags)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fb6738954b7d..095099df041f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -263,9 +263,19 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 				rq->rq_flags = RQF_MQ_INFLIGHT;
 				atomic_inc(&data->hctx->nr_active);
 			}
-			rq->tag = tag;
-			rq->internal_tag = -1;
-			data->hctx->tags->rqs[rq->tag] = rq;
+			data->hctx->tags->rqs[tag] = rq;
+
+			/*
+			 * If we use hw tag for scheduling, postpone setting
+			 * rq->tag in blk_mq_get_driver_tag().
+			 */
+			if (data->hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG) {
+				rq->tag = -1;
+				rq->internal_tag = tag;
+			} else {
+				rq->tag = tag;
+				rq->internal_tag = -1;
+			}
 		}
 
 		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
@@ -365,7 +375,7 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
-	if (sched_tag != -1)
+	if (sched_tag != -1 && !(hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG))
 		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
@@ -869,6 +879,12 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 	if (rq->tag != -1)
 		goto done;
 
+	/* we buffered driver tag in rq->internal_tag */
+	if (data.hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG) {
+		rq->tag = rq->internal_tag;
+		goto done;
+	}
+
 	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
 		data.flags |= BLK_MQ_REQ_RESERVED;
 
@@ -890,9 +906,15 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 				    struct request *rq)
 {
-	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
+	unsigned tag = rq->tag;
+
 	rq->tag = -1;
 
+	if (hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG)
+		return;
+
+	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, tag);
+
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
 		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
 		atomic_dec(&hctx->nr_active);
@@ -2852,7 +2874,8 @@ bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 		blk_flush_plug_list(plug, false);
 
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
-	if (!blk_qc_t_is_internal(cookie))
+	if (!blk_qc_t_is_internal(cookie) || (hctx->flags &
+			BLK_MQ_F_SCHED_USE_HW_TAG))
 		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
 	else {
 		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 3b0090bc5dd1..1968050c8515 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -275,8 +275,13 @@ static unsigned int kyber_sched_tags_shift(struct kyber_queue_data *kqd)
 	/*
 	 * All of the hardware queues have the same depth, so we can just grab
 	 * the shift of the first one.
+	 *
+	 * Hardware tags may be used for scheduling.
 	 */
-	return kqd->q->queue_hw_ctx[0]->sched_tags->bitmap_tags.sb.shift;
+	if (kqd->q->queue_hw_ctx[0]->sched_tags)
+		return kqd->q->queue_hw_ctx[0]->sched_tags->bitmap_tags.sb.shift;
+	else
+		return kqd->q->queue_hw_ctx[0]->tags->bitmap_tags.sb.shift;
 }
 
 static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7aa1ca5fe659..3597ad40ecc3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -162,6 +162,7 @@ enum {
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
+	BLK_MQ_F_SCHED_USE_HW_TAG	= 1 << 7,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
-- 
2.9.3

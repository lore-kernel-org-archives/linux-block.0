Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] queue stall with blk-mq-sched
To: Hannes Reinecke <hare@suse.de>
References: <aa1c23e1-1beb-a26d-3e77-fe78aa281771@suse.de>
 <762cb508-1de0-93e2-5643-3fe946428eb5@fb.com>
 <8abc2430-e1fd-bece-ad52-c6d1d482c1e0@suse.de>
 <1663de5d-cdf7-a6ed-7539-c7d1f5e98f6c@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <717c595a-a3a6-0508-b537-8cf9e273271e@kernel.dk>
Date: Tue, 24 Jan 2017 15:06:53 -0700
MIME-Version: 1.0
In-Reply-To: <1663de5d-cdf7-a6ed-7539-c7d1f5e98f6c@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/24/2017 12:55 PM, Jens Axboe wrote:
> Try this patch. We only want to bump it for the driver tags, not the
> scheduler side.

More complete version, this one actually tested. I think this should fix
your issue, let me know.

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a49ec77..1b156ca 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -90,9 +90,11 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	return atomic_read(&hctx->nr_active) < depth;
 }
 
-static int __blk_mq_get_tag(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt)
+static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
+			    struct sbitmap_queue *bt)
 {
-	if (!hctx_may_queue(hctx, bt))
+	if (!(data->flags & BLK_MQ_REQ_INTERNAL) &&
+	    !hctx_may_queue(data->hctx, bt))
 		return -1;
 	return __sbitmap_queue_get(bt);
 }
@@ -118,7 +120,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		tag_offset = tags->nr_reserved_tags;
 	}
 
-	tag = __blk_mq_get_tag(data->hctx, bt);
+	tag = __blk_mq_get_tag(data, bt);
 	if (tag != -1)
 		goto found_tag;
 
@@ -129,7 +131,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	do {
 		prepare_to_wait(&ws->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		tag = __blk_mq_get_tag(data->hctx, bt);
+		tag = __blk_mq_get_tag(data, bt);
 		if (tag != -1)
 			break;
 
@@ -144,7 +146,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		 * Retry tag allocation after running the hardware queue,
 		 * as running the queue may also have found completions.
 		 */
-		tag = __blk_mq_get_tag(data->hctx, bt);
+		tag = __blk_mq_get_tag(data, bt);
 		if (tag != -1)
 			break;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ee69e5e..dcb5676 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -230,15 +230,14 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 
 		rq = tags->static_rqs[tag];
 
-		if (blk_mq_tag_busy(data->hctx)) {
-			rq->rq_flags = RQF_MQ_INFLIGHT;
-			atomic_inc(&data->hctx->nr_active);
-		}
-
 		if (data->flags & BLK_MQ_REQ_INTERNAL) {
 			rq->tag = -1;
 			rq->internal_tag = tag;
 		} else {
+			if (blk_mq_tag_busy(data->hctx)) {
+				rq->rq_flags = RQF_MQ_INFLIGHT;
+				atomic_inc(&data->hctx->nr_active);
+			}
 			rq->tag = tag;
 			rq->internal_tag = -1;
 		}
@@ -869,6 +868,10 @@ static bool blk_mq_get_driver_tag(struct request *rq,
 
 	rq->tag = blk_mq_get_tag(&data);
 	if (rq->tag >= 0) {
+		if (blk_mq_tag_busy(data.hctx)) {
+			rq->rq_flags |= RQF_MQ_INFLIGHT;
+			atomic_inc(&data.hctx->nr_active);
+		}
 		data.hctx->tags->rqs[rq->tag] = rq;
 		goto done;
 	}

-- 
Jens Axboe

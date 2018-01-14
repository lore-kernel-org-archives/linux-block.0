Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: don't clear RQF_MQ_INFLIGHT in
 blk_mq_rq_ctx_init()
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Laurence Oberman <loberman@redhat.com>, Mike Snitzer <snitzer@redhat.com>
References: <20180113174915.19404-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5fd4a57e-cc9a-e3da-fe3b-1db2460423f8@kernel.dk>
Date: Sun, 14 Jan 2018 10:38:42 -0700
MIME-Version: 1.0
In-Reply-To: <20180113174915.19404-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/13/18 10:49 AM, Ming Lei wrote:
> In case of no IO scheduler, RQF_MQ_INFLIGHT is set in blk_mq_rq_ctx_init(),
> but 7c3fb70f0341 clears it mistakenly, so fix it.

Oops yeah, that's my bad. However, I think the below fix is cleaner
and avoids a conditional.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index b3b2003b7429..c8f62e6be6b6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -269,13 +269,14 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
+	req_flags_t rq_flags = 0;
 
 	if (data->flags & BLK_MQ_REQ_INTERNAL) {
 		rq->tag = -1;
 		rq->internal_tag = tag;
 	} else {
 		if (blk_mq_tag_busy(data->hctx)) {
-			rq->rq_flags = RQF_MQ_INFLIGHT;
+			rq_flags = RQF_MQ_INFLIGHT;
 			atomic_inc(&data->hctx->nr_active);
 		}
 		rq->tag = tag;
@@ -286,7 +287,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	/* csd/requeue_work/fifo_time is initialized before use */
 	rq->q = data->q;
 	rq->mq_ctx = data->ctx;
-	rq->rq_flags = 0;
+	rq->rq_flags = rq_flags;
 	rq->cpu = -1;
 	rq->cmd_flags = op;
 	if (data->flags & BLK_MQ_REQ_PREEMPT)

-- 
Jens Axboe


-- 
Jens Axboe

Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 12/19] blk-mq: Initialize a request before assigning a tag
Date: Thu, 25 May 2017 11:43:20 -0700
Message-ID: <20170525184327.23570-13-bart.vanassche@sandisk.com>
In-Reply-To: <20170525184327.23570-1-bart.vanassche@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Initialization of blk-mq requests is a bit weird: blk_mq_rq_ctx_init()
is called after a tag has been assigned and .rq_flags is initialized
in __blk_mq_finish_request(). Call blk_mq_rq_ctx_init() before
modifying any struct request members. Initialize .rq_flags in
blk_mq_rq_ctx_init() instead of in __blk_mq_finish_request(). This
patch does not change the behavior of the block layer.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b8092786d42f..1fcc20df1a4e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -212,6 +212,7 @@ void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 	rq->q = q;
 	rq->mq_ctx = ctx;
 	rq->cmd_flags = op;
+	rq->rq_flags = 0;
 	if (blk_queue_io_stat(q))
 		rq->rq_flags |= RQF_IO_STAT;
 	/* do not touch atomic flags, it needs atomic ops against the timer */
@@ -231,7 +232,8 @@ void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 	rq->nr_integrity_segments = 0;
 #endif
 	rq->special = NULL;
-	/* tag was already set */
+	rq->tag = -1;
+	rq->internal_tag = -1;
 	rq->extra_len = 0;
 
 	INIT_LIST_HEAD(&rq->timeout_list);
@@ -260,20 +262,19 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 
 		rq = tags->static_rqs[tag];
 
+		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
+
 		if (data->flags & BLK_MQ_REQ_INTERNAL) {
-			rq->tag = -1;
 			rq->internal_tag = tag;
 		} else {
 			if (blk_mq_tag_busy(data->hctx)) {
-				rq->rq_flags = RQF_MQ_INFLIGHT;
+				rq->rq_flags |= RQF_MQ_INFLIGHT;
 				atomic_inc(&data->hctx->nr_active);
 			}
 			rq->tag = tag;
-			rq->internal_tag = -1;
-			data->hctx->tags->rqs[rq->tag] = rq;
+			data->hctx->tags->rqs[tag] = rq;
 		}
 
-		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
 		return rq;
 	}
 
@@ -364,7 +365,6 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 		atomic_dec(&hctx->nr_active);
 
 	wbt_done(q->rq_wb, &rq->issue_stat);
-	rq->rq_flags = 0;
 
 	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
 	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
-- 
2.12.2

Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, Omar Sandoval
	<osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 10/12] blk-mq: Document locking assumptions
Date: Mon, 19 Jun 2017 15:07:59 -0700
Message-ID: <20170619220801.12557-11-bart.vanassche@wdc.com>
In-Reply-To: <20170619220801.12557-1-bart.vanassche@wdc.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

From: Bart Van Assche <bart.vanassche@sandisk.com>

Document the locking assumptions in functions that modify
blk_mq_ctx.rq_list to make it easier for humans to verify
this code.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 2 ++
 block/blk-mq.c       | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 9f025289da63..191bf82d185e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -150,6 +150,8 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 	struct request *rq;
 	int checked = 8;
 
+	lockdep_assert_held(&ctx->lock);
+
 	list_for_each_entry_reverse(rq, &ctx->rq_list, queuelist) {
 		bool merged = false;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 679b52790bc1..e7b0d69fdf65 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1328,6 +1328,8 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
+	lockdep_assert_held(&ctx->lock);
+
 	trace_block_rq_insert(hctx->queue, rq);
 
 	if (at_head)
@@ -1341,6 +1343,8 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
+	lockdep_assert_held(&ctx->lock);
+
 	__blk_mq_insert_req_list(hctx, rq, at_head);
 	blk_mq_hctx_mark_pending(hctx, ctx);
 }
-- 
2.13.1

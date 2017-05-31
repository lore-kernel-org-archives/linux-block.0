Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 09/12] blk-mq: Document locking assumptions
Date: Wed, 31 May 2017 15:52:43 -0700
Message-ID: <20170531225246.26261-10-bart.vanassche@sandisk.com>
In-Reply-To: <20170531225246.26261-1-bart.vanassche@sandisk.com>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Document the locking assumptions in functions that modify
blk_mq_ctx.rq_list to make it easier for humans to verify
this code.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 2 ++
 block/blk-mq.c       | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c4e2afb9d12d..88aa460b2e8a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -232,6 +232,8 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 	struct request *rq;
 	int checked = 8;
 
+	lockdep_assert_held(&ctx->lock);
+
 	list_for_each_entry_reverse(rq, &ctx->rq_list, queuelist) {
 		bool merged = false;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 488c6ca2ad91..b56cb3d9060f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1274,6 +1274,8 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
+	lockdep_assert_held(&ctx->lock);
+
 	trace_block_rq_insert(hctx->queue, rq);
 
 	if (at_head)
@@ -1287,6 +1289,8 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
+	lockdep_assert_held(&ctx->lock);
+
 	__blk_mq_insert_req_list(hctx, rq, at_head);
 	blk_mq_hctx_mark_pending(hctx, ctx);
 }
-- 
2.12.2

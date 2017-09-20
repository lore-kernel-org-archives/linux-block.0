Return-Path: <prvs=429465c67=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] blk-mq: Fix blk_mq_get_request() error path
Date: Wed, 20 Sep 2017 11:47:04 -0700
Message-Id: <20170920184704.20735-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

blk_mq_get_tag() can modify data->ctx. This means that in the
error path of blk_mq_get_request() data->ctx should be passed to
blk_mq_put_ctx() instead of local_ctx.

Fixes: commit 1ad43c0078b7 ("blk-mq: don't leak preempt counter/q_usage_counter when allocating rq failed")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: <stable@vger.kernel.org> # v4.13+
---
 block/blk-mq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f18cff80050..fc20016f8a9a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -336,12 +336,14 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
 	unsigned int tag;
-	struct blk_mq_ctx *local_ctx = NULL;
+	bool put_ctx_on_error = false;
 
 	blk_queue_enter_live(q);
 	data->q = q;
-	if (likely(!data->ctx))
-		data->ctx = local_ctx = blk_mq_get_ctx(q);
+	if (likely(!data->ctx)) {
+		data->ctx = blk_mq_get_ctx(q);
+		put_ctx_on_error = true;
+	}
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 	if (op & REQ_NOWAIT)
@@ -360,8 +362,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	tag = blk_mq_get_tag(data);
 	if (tag == BLK_MQ_TAG_FAIL) {
-		if (local_ctx) {
-			blk_mq_put_ctx(local_ctx);
+		if (put_ctx_on_error) {
+			blk_mq_put_ctx(data->ctx);
 			data->ctx = NULL;
 		}
 		blk_queue_exit(q);
-- 
2.14.1

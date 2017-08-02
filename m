Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbdHBAB4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Aug 2017 20:01:56 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <minlei@redhat.com>
Subject: [PATCH V2] blk-mq: don't leak preempt counter/q_usage_counter when allocating rq failed
Date: Wed,  2 Aug 2017 08:01:45 +0800
Message-Id: <20170802000145.5996-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Ming Lei <minlei@redhat.com>

When blk_mq_get_request() failed, preempt counter isn't
released, and blk_mq_make_request() doesn't release the counter
too.

This patch fixes the issue, and makes sure that preempt counter
is only held if rq is allocated successfully. The same policy is
applied on .q_usage_counter too.

Signed-off-by: Ming Lei <minlei@redhat.com>
---
 V2: use local_ctx, and clear data->ctx if allocation fails, as
     suggested by Jens.

 block/blk-mq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 041f7b7fa0d6..211ef367345f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -301,11 +301,12 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
 	unsigned int tag;
+	struct blk_mq_ctx *local_ctx = NULL;
 
 	blk_queue_enter_live(q);
 	data->q = q;
 	if (likely(!data->ctx))
-		data->ctx = blk_mq_get_ctx(q);
+		data->ctx = local_ctx = blk_mq_get_ctx(q);
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 	if (op & REQ_NOWAIT)
@@ -324,6 +325,10 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	tag = blk_mq_get_tag(data);
 	if (tag == BLK_MQ_TAG_FAIL) {
+		if (local_ctx) {
+			blk_mq_put_ctx(local_ctx);
+			data->ctx = NULL;
+		}
 		blk_queue_exit(q);
 		return NULL;
 	}
@@ -356,12 +361,12 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 
 	rq = blk_mq_get_request(q, NULL, op, &alloc_data);
 
-	blk_mq_put_ctx(alloc_data.ctx);
-	blk_queue_exit(q);
-
 	if (!rq)
 		return ERR_PTR(-EWOULDBLOCK);
 
+	blk_mq_put_ctx(alloc_data.ctx);
+	blk_queue_exit(q);
+
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
@@ -407,11 +412,11 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 
 	rq = blk_mq_get_request(q, NULL, op, &alloc_data);
 
-	blk_queue_exit(q);
-
 	if (!rq)
 		return ERR_PTR(-EWOULDBLOCK);
 
+	blk_queue_exit(q);
+
 	return rq;
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
-- 
2.9.4

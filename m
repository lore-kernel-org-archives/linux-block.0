Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH V2 1/3] blk-mq: use list_splice_tail_init() to insert requests
Date: Fri, 29 Jun 2018 16:12:50 +0800
Message-Id: <20180629081252.13836-2-ming.lei@redhat.com>
In-Reply-To: <20180629081252.13836-1-ming.lei@redhat.com>
References: <20180629081252.13836-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

list_splice_tail_init() is much more faster than inserting each
request one by one, given all requets in 'list' belong to
same sw queue and ctx->lock is required to insert requests.

Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 22fe394d0b49..359382b59d40 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1545,19 +1545,19 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 			    struct list_head *list)
 
 {
+	struct request *rq;
+
 	/*
 	 * preemption doesn't flush plug list, so it's possible ctx->cpu is
 	 * offline now
 	 */
-	spin_lock(&ctx->lock);
-	while (!list_empty(list)) {
-		struct request *rq;
-
-		rq = list_first_entry(list, struct request, queuelist);
+	list_for_each_entry(rq, list, queuelist) {
 		BUG_ON(rq->mq_ctx != ctx);
-		list_del_init(&rq->queuelist);
-		__blk_mq_insert_req_list(hctx, rq, false);
+		trace_block_rq_insert(hctx->queue, rq);
 	}
+
+	spin_lock(&ctx->lock);
+	list_splice_tail_init(list, &ctx->rq_list);
 	blk_mq_hctx_mark_pending(hctx, ctx);
 	spin_unlock(&ctx->lock);
 }
-- 
2.9.5

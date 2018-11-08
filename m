Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH] blk-mq: provide a helper to check if a queue is busy
Date: Thu,  8 Nov 2018 09:06:07 -0700
Message-Id: <20181108160609.27568-2-axboe@kernel.dk>
In-Reply-To: <20181108160609.27568-1-axboe@kernel.dk>
References: <20181108160609.27568-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Returns true if the queue currently has requests pending,
false if not.

DM can use this to replace the atomic_inc/dec they do per device
to see if a device is busy.

Cc: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 22 ++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4a622c832b31..848adcc51c43 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -790,6 +790,28 @@ struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 }
 EXPORT_SYMBOL(blk_mq_tag_to_rq);
 
+static bool blk_mq_check_busy(struct blk_mq_hw_ctx *hctx, struct request *rq,
+			      void *priv, bool reserved)
+{
+	bool *busy = (bool *) priv;
+
+	/*
+	 * If we find a request, we know the queue is busy. Return false
+	 * to stop the iteration.
+	 */
+	*busy = true;
+	return false;
+}
+
+bool blk_mq_queue_busy(struct request_queue *q)
+{
+	bool busy = false;
+
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_busy, &busy);
+	return busy;
+}
+EXPORT_SYMBOL_GPL(blk_mq_queue_busy);
+
 static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 {
 	req->rq_flags |= RQF_TIMED_OUT;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ff497dfcbbf9..929e8abc5535 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -250,6 +250,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
 void blk_mq_free_request(struct request *rq);
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *);
 
+bool blk_mq_queue_busy(struct request_queue *q);
+
 enum {
 	/* return when out of requests */
 	BLK_MQ_REQ_NOWAIT	= (__force blk_mq_req_flags_t)(1 << 0),
-- 
2.17.1

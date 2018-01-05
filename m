Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] mq-deadline: make it clear that __dd_dispatch_request() works
 on all hw queues
Message-ID: <2c4afe1c-fb16-0d48-7c5c-2b063a16dbd1@kernel.dk>
Date: Fri, 5 Jan 2018 14:56:38 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Don't pass in the hardware queue to __dd_dispatch_request(), since it
leads the reader to believe that we are returning a request for that
specific hardware queue. That's not how mq-deadline works, the state
for determining which request to serve next is shared across all
hardware queues for a device.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index d56972e8ebda..c56f211c8440 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -267,9 +267,8 @@ deadline_next_request(struct deadline_data *dd, int data_dir)
  * deadline_dispatch_requests selects the best request according to
  * read/write expire, fifo_batch, etc
  */
-static struct request *__dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
+static struct request *__dd_dispatch_request(struct deadline_data *dd)
 {
-	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 	struct request *rq, *next_rq;
 	bool reads, writes;
 	int data_dir;
@@ -372,13 +371,19 @@ static struct request *__dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	return rq;
 }
 
+/*
+ * One confusing aspect here is that we get called for a specific
+ * hardware queue, but we return a request that may not be for a
+ * different hardware queue. This is because mq-deadline has shared
+ * state for all hardware queues, in terms of sorting, FIFOs, etc.
+ */
 static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 	struct request *rq;
 
 	spin_lock(&dd->lock);
-	rq = __dd_dispatch_request(hctx);
+	rq = __dd_dispatch_request(dd);
 	spin_unlock(&dd->lock);
 
 	return rq;

-- 
Jens Axboe

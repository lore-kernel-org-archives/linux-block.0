Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 15sm8670767iti.15.2018.01.09.11.47.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 11:47:25 -0800 (PST)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: wire up timeouts
Message-ID: <262d382f-8ce5-7230-fb45-3eb57d48e099@kernel.dk>
Date: Tue, 9 Jan 2018 12:47:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

This is needed to ensure that we actually handle timeouts.
Without it, the queue_mode=1 path will never call blk_add_timer(),
and the queue_mode=2 path will continually just return
EH_RESET_TIMER and we never actually complete the offending request.

This was used to test the new timeout code, and the changes around
killing off REQ_ATOM_COMPLETE.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index b58e506d278b..6388d60c9c0f 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -1341,6 +1341,12 @@ static blk_qc_t null_queue_bio(struct request_queue *q, struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
+static enum blk_eh_timer_return null_rq_timed_out_fn(struct request *rq)
+{
+	pr_info("null: rq %p timed out\n", rq);
+	return BLK_EH_HANDLED;
+}
+
 static int null_rq_prep_fn(struct request_queue *q, struct request *req)
 {
 	struct nullb *nullb = q->queuedata;
@@ -1371,6 +1377,12 @@ static void null_request_fn(struct request_queue *q)
 	}
 }
 
+static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
+{
+	pr_info("null: rq %p timed out\n", rq);
+	return BLK_EH_HANDLED;
+}
+
 static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
@@ -1394,6 +1406,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 static const struct blk_mq_ops null_mq_ops = {
 	.queue_rq       = null_queue_rq,
 	.complete	= null_softirq_done_fn,
+	.timeout	= null_timeout_rq,
 };
 
 static void cleanup_queue(struct nullb_queue *nq)
@@ -1654,6 +1667,7 @@ static int null_add_dev(struct nullb_device *dev)
 		if (rv)
 			goto out_cleanup_queues;
 
+		nullb->tag_set->timeout = 5 * HZ;
 		nullb->q = blk_mq_init_queue(nullb->tag_set);
 		if (IS_ERR(nullb->q)) {
 			rv = -ENOMEM;
@@ -1679,6 +1693,8 @@ static int null_add_dev(struct nullb_device *dev)
 		}
 		blk_queue_prep_rq(nullb->q, null_rq_prep_fn);
 		blk_queue_softirq_done(nullb->q, null_softirq_done_fn);
+		blk_queue_rq_timed_out(nullb->q, null_rq_timed_out_fn);
+		nullb->q->rq_timeout = 5 * HZ;
 		rv = init_driver_queues(nullb);
 		if (rv)
 			goto out_cleanup_blk_queue;

-- 
Jens Axboe

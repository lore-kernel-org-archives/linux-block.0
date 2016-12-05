Return-Path: <prvs=1147fe7fca=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/7] cfq-iosched: use appropriate run queue function
Date: Mon, 5 Dec 2016 11:27:01 -0700
Message-ID: <1480962426-15767-3-git-send-email-axboe@fb.com>
In-Reply-To: <1480962426-15767-1-git-send-email-axboe@fb.com>
References: <1480962426-15767-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

For MQ devices, we have to use other functions to run the queue.
No functional changes in this patch, just a prep patch for
support legacy schedulers on blk-mq.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/cfq-iosched.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index c73a6fcaeb9d..d6d454a72bd4 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -919,8 +919,14 @@ static inline struct cfq_data *cic_to_cfqd(struct cfq_io_cq *cic)
 static inline void cfq_schedule_dispatch(struct cfq_data *cfqd)
 {
 	if (cfqd->busy_queues) {
+		struct request_queue *q = cfqd->queue;
+
 		cfq_log(cfqd, "schedule dispatch");
-		kblockd_schedule_work(&cfqd->unplug_work);
+
+		if (q->mq_ops)
+			blk_mq_run_hw_queues(q, true);
+		else
+			kblockd_schedule_work(&cfqd->unplug_work);
 	}
 }
 
@@ -4086,6 +4092,16 @@ static void cfq_preempt_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 	cfq_mark_cfqq_slice_new(cfqq);
 }
 
+static void cfq_run_queue(struct cfq_data *cfqd)
+{
+	struct request_queue *q = cfqd->queue;
+
+	if (q->mq_ops)
+		blk_mq_run_hw_queues(q, true);
+	else
+		__blk_run_queue(q);
+}
+
 /*
  * Called when a new fs request (rq) is added (to cfqq). Check if there's
  * something we should do about it
@@ -4122,7 +4138,7 @@ cfq_rq_enqueued(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 			    cfqd->busy_queues > 1) {
 				cfq_del_timer(cfqd, cfqq);
 				cfq_clear_cfqq_wait_request(cfqq);
-				__blk_run_queue(cfqd->queue);
+				cfq_run_queue(cfqd);
 			} else {
 				cfqg_stats_update_idle_time(cfqq->cfqg);
 				cfq_mark_cfqq_must_dispatch(cfqq);
@@ -4136,7 +4152,7 @@ cfq_rq_enqueued(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 		 * this new queue is RT and the current one is BE
 		 */
 		cfq_preempt_queue(cfqd, cfqq);
-		__blk_run_queue(cfqd->queue);
+		cfq_run_queue(cfqd);
 	}
 }
 
-- 
2.7.4

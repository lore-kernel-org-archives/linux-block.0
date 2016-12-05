Return-Path: <prvs=1147fe7fca=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/7] block: use appropriate queue running functions
Date: Mon, 5 Dec 2016 11:27:02 -0700
Message-ID: <1480962426-15767-4-git-send-email-axboe@fb.com>
In-Reply-To: <1480962426-15767-1-git-send-email-axboe@fb.com>
References: <1480962426-15767-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Use MQ variants for MQ, legacy ones for legacy.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-core.c  |  5 ++++-
 block/blk-exec.c  | 10 ++++++++--
 block/blk-flush.c | 14 ++++++++++----
 block/elevator.c  |  5 ++++-
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 813c448453bf..f0aa810a5fe2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -340,7 +340,10 @@ void __blk_run_queue(struct request_queue *q)
 	if (unlikely(blk_queue_stopped(q)))
 		return;
 
-	__blk_run_queue_uncond(q);
+	if (WARN_ON_ONCE(q->mq_ops))
+		blk_mq_run_hw_queues(q, true);
+	else
+		__blk_run_queue_uncond(q);
 }
 EXPORT_SYMBOL(__blk_run_queue);
 
diff --git a/block/blk-exec.c b/block/blk-exec.c
index 3356dff5508c..6c3f12b32f86 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -80,8 +80,14 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
 	}
 
 	__elv_add_request(q, rq, where);
-	__blk_run_queue(q);
-	spin_unlock_irq(q->queue_lock);
+
+	if (q->mq_ops) {
+		spin_unlock_irq(q->queue_lock);
+		blk_mq_run_hw_queues(q, false);
+	} else {
+		__blk_run_queue(q);
+		spin_unlock_irq(q->queue_lock);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 040c36b83ef7..8f2354d97e17 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -265,8 +265,10 @@ static void flush_end_io(struct request *flush_rq, int error)
 	 * kblockd.
 	 */
 	if (queued || fq->flush_queue_delayed) {
-		WARN_ON(q->mq_ops);
-		blk_run_queue_async(q);
+		if (q->mq_ops)
+			blk_mq_run_hw_queues(q, true);
+		else
+			blk_run_queue_async(q);
 	}
 	fq->flush_queue_delayed = 0;
 	if (!blk_use_sched_path(q))
@@ -346,8 +348,12 @@ static void flush_data_end_io(struct request *rq, int error)
 	 * After populating an empty queue, kick it to avoid stall.  Read
 	 * the comment in flush_end_io().
 	 */
-	if (blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error))
-		blk_run_queue_async(q);
+	if (blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error)) {
+		if (q->mq_ops)
+			blk_mq_run_hw_queues(q, true);
+		else
+			blk_run_queue_async(q);
+	}
 }
 
 static void mq_flush_data_end_io(struct request *rq, int error)
diff --git a/block/elevator.c b/block/elevator.c
index a18a5db274e4..11d2cfee2bc1 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -627,7 +627,10 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 		 *   with anything.  There's no point in delaying queue
 		 *   processing.
 		 */
-		__blk_run_queue(q);
+		if (q->mq_ops)
+			blk_mq_run_hw_queues(q, true);
+		else
+			__blk_run_queue(q);
 		break;
 
 	case ELEVATOR_INSERT_SORT_MERGE:
-- 
2.7.4

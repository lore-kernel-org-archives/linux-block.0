Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH 1/3] blk-mq: Introduce blk_mq_ops.restart_queues
Date: Fri, 31 Mar 2017 16:12:03 -0700
Message-ID: <20170331231205.16640-2-bart.vanassche@sandisk.com>
In-Reply-To: <20170331231205.16640-1-bart.vanassche@sandisk.com>
References: <20170331231205.16640-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

If a tag set is shared among multiple request queues, leave
it to the block driver to restart queues. Hence remove
QUEUE_FLAG_RESTART and introduce blk_mq_ops.restart_queues.
Remove blk_mq_sched_mark_restart_queue() because this
function has no callers.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 block/blk-mq-sched.c   | 11 +++--------
 block/blk-mq-sched.h   | 14 --------------
 include/linux/blk-mq.h |  4 ++++
 include/linux/blkdev.h |  1 -
 4 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 09af8ff18719..ed9942ee0146 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -329,16 +329,11 @@ static void blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
 void blk_mq_sched_restart_queues(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
-	unsigned int i;
 
-	if (test_bit(QUEUE_FLAG_RESTART, &q->queue_flags)) {
-		if (test_and_clear_bit(QUEUE_FLAG_RESTART, &q->queue_flags)) {
-			queue_for_each_hw_ctx(q, hctx, i)
-				blk_mq_sched_restart_hctx(hctx);
-		}
-	} else {
+	if (q->mq_ops->restart_queues)
+		q->mq_ops->restart_queues(q);
+	else
 		blk_mq_sched_restart_hctx(hctx);
-	}
 }
 
 /*
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index a75b16b123f7..fe62b1eccf4c 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -131,20 +131,6 @@ static inline void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 }
 
-/*
- * Mark a hardware queue and the request queue it belongs to as needing a
- * restart.
- */
-static inline void blk_mq_sched_mark_restart_queue(struct blk_mq_hw_ctx *hctx)
-{
-	struct request_queue *q = hctx->queue;
-
-	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
-		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
-	if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
-		set_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
-}
-
 static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
 {
 	return test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ea2e9dcd3aef..75160e9470cb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -86,6 +86,7 @@ struct blk_mq_queue_data {
 };
 
 typedef int (queue_rq_fn)(struct blk_mq_hw_ctx *, const struct blk_mq_queue_data *);
+typedef void (restart_fn)(struct request_queue *q);
 typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
 typedef int (init_hctx_fn)(struct blk_mq_hw_ctx *, void *, unsigned int);
 typedef void (exit_hctx_fn)(struct blk_mq_hw_ctx *, unsigned int);
@@ -108,6 +109,9 @@ struct blk_mq_ops {
 	 */
 	queue_rq_fn		*queue_rq;
 
+	/* Called upon request completion to rerun all queues */
+	restart_fn		*restart_queues;
+
 	/*
 	 * Called on request timeout
 	 */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a2dc6b390d48..a80543ec8be7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -615,7 +615,6 @@ struct request_queue {
 #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         26	/* device supports DAX */
 #define QUEUE_FLAG_STATS       27	/* track rq completion times */
-#define QUEUE_FLAG_RESTART     28	/* queue needs restart at completion */
 #define QUEUE_FLAG_POLL_STATS  29	/* collecting stats for hybrid polling */
 #define QUEUE_FLAG_REGISTERED  30	/* queue has been registered to a disk */
 
-- 
2.12.0

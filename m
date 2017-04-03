Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH v2 1/5] blk-mq: Export blk_mq_sched_restart_hctx()
Date: Mon, 3 Apr 2017 16:22:24 -0700
Message-ID: <20170403232228.11208-2-bart.vanassche@sandisk.com>
In-Reply-To: <20170403232228.11208-1-bart.vanassche@sandisk.com>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Since a later patch will add a call to this function from the
SCSI core, export this function. Move the BLK_MQ_S_SCHED_RESTART
bit test from blk_mq_sched_restart_hctx() into the callers of
this function. This leads to some code duplication but that will
be addressed in another patch in this series.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 block/blk-mq-sched.c   | 17 +++++++++--------
 include/linux/blk-mq.h |  1 +
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 09af8ff18719..414ed4b3d266 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -317,14 +317,13 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
 	return true;
 }
 
-static void blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
+void blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
 {
-	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
-		clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
-		if (blk_mq_hctx_has_pending(hctx))
-			blk_mq_run_hw_queue(hctx, true);
-	}
+	clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+	if (blk_mq_hctx_has_pending(hctx))
+		blk_mq_run_hw_queue(hctx, true);
 }
+EXPORT_SYMBOL(blk_mq_sched_restart_hctx);
 
 void blk_mq_sched_restart_queues(struct blk_mq_hw_ctx *hctx)
 {
@@ -334,9 +333,11 @@ void blk_mq_sched_restart_queues(struct blk_mq_hw_ctx *hctx)
 	if (test_bit(QUEUE_FLAG_RESTART, &q->queue_flags)) {
 		if (test_and_clear_bit(QUEUE_FLAG_RESTART, &q->queue_flags)) {
 			queue_for_each_hw_ctx(q, hctx, i)
-				blk_mq_sched_restart_hctx(hctx);
+				if (test_bit(BLK_MQ_S_SCHED_RESTART,
+					     &hctx->state))
+					blk_mq_sched_restart_hctx(hctx);
 		}
-	} else {
+	} else if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
 		blk_mq_sched_restart_hctx(hctx);
 	}
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ea2e9dcd3aef..f62f3ce2dc65 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -237,6 +237,7 @@ void blk_mq_stop_hw_queues(struct request_queue *q);
 void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
+void blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
-- 
2.12.0

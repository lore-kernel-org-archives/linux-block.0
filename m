Return-Path: <prvs=5014e5409=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 5/7] blk-mq: Avoid that blk_mq_mark_tag_wait() triggers a queue stall
Date: Thu, 30 Nov 2017 16:08:46 -0800
Message-Id: <20171201000848.2656-6-bart.vanassche@wdc.com>
In-Reply-To: <20171201000848.2656-1-bart.vanassche@wdc.com>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The blk_mq_sched_restart() call from inside blk_mq_free_request()
only runs those queues for which BLK_MQ_S_SCHED_RESTART has been
set. Hence set that flag from inside blk_mq_mark_tag_wait() whether
or not a queue is shared.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq-sched.c | 2 +-
 block/blk-mq.c       | 4 ++--
 block/blk-mq.h       | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c4e0cb5f6f1f..398545d94521 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -54,7 +54,7 @@ void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio)
  * Mark a hardware queue as needing a restart. For shared queues, maintain
  * a count of how many hardware queues are marked for restart.
  */
-static void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
+void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 {
 	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
 		return;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 26fec4dfa40f..3e0ce940377f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1036,9 +1036,9 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	wait_queue_entry_t *wait;
 	bool ret;
 
+	blk_mq_sched_mark_restart_hctx(this_hctx);
+
 	if (!shared_tags) {
-		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state))
-			set_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state);
 		ret = blk_mq_get_driver_tag(rq, hctx, false);
 		/*
 		 * Don't clear RESTART here, someone else could have set it.
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 6c7c3ff5bf62..eb3c93aeb8b3 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -139,6 +139,8 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 			unsigned int inflight[2]);
 
+void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
+
 static inline void blk_mq_put_dispatch_budget(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
-- 
2.15.0

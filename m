Return-Path: <prvs=5639f9be5=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] blk-mq: Fix a race between resetting the timer and completion handling
Date: Thu,  1 Feb 2018 14:49:30 -0800
Message-Id: <20180201224930.17918-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

While injecting errors from the target side I noticed many kinds of
weird behavior at the initiator side, including the call stack shown
below and CPU soft lockup complaints. This patch seems to address all
these issues. This patch not only avoids that a completion can
succeed while the timer is being reset but also shrinks the size of
struct request. The performance impact of this patch should be
minimal: the only change that affects performance of the hot path is
the change of a preempt_disable() / preempt_enable() pair in
blk_mq_start_request() into a local_irq_disable() /
local_irq_enable() pair.

This patch fixes the following kernel crash:

BUG: unable to handle kernel NULL pointer dereference at           (null)
Oops: 0000 [#1] PREEMPT SMP
CPU: 2 PID: 151 Comm: kworker/2:1H Tainted: G        W        4.15.0-dbg+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Workqueue: kblockd blk_mq_timeout_work
RIP: 0010:scsi_times_out+0x17/0x2c0 [scsi_mod]
Call Trace:
blk_mq_terminate_expired+0x42/0x80
bt_iter+0x3d/0x50
blk_mq_queue_tag_busy_iter+0xe9/0x200
blk_mq_timeout_work+0x181/0x2e0
process_one_work+0x21c/0x6d0
worker_thread+0x35/0x380
kthread+0x117/0x130
ret_from_fork+0x24/0x30

Fixes: 1d9bd5161ba3 ("blk-mq: replace timeout synchronization with a RCU and generation based scheme")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
---
 block/blk-core.c       |  1 -
 block/blk-mq.c         | 29 +++++++++++++++--------------
 include/linux/blkdev.h | 12 ++----------
 3 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0d104268f1a..a08355e1dd2a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -127,7 +127,6 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	set_start_time_ns(rq);
 	rq->part = NULL;
 	seqcount_init(&rq->gstate_seq);
-	u64_stats_init(&rq->aborted_gstate_sync);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102e2149..372f0aeb693f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -592,9 +592,9 @@ static void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
 	 * while updating.
 	 */
 	local_irq_save(flags);
-	u64_stats_update_begin(&rq->aborted_gstate_sync);
+	write_seqcount_begin(&rq->gstate_seq);
 	rq->aborted_gstate = gstate;
-	u64_stats_update_end(&rq->aborted_gstate_sync);
+	write_seqcount_end(&rq->gstate_seq);
 	local_irq_restore(flags);
 }
 
@@ -603,10 +603,13 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
 	unsigned int start;
 	u64 aborted_gstate;
 
-	do {
-		start = u64_stats_fetch_begin(&rq->aborted_gstate_sync);
+	while (true) {
+		start = read_seqcount_begin(&rq->gstate_seq);
 		aborted_gstate = rq->aborted_gstate;
-	} while (u64_stats_fetch_retry(&rq->aborted_gstate_sync, start));
+		if (!read_seqcount_retry(&rq->gstate_seq, start))
+			break;
+		cond_resched();
+	}
 
 	return aborted_gstate;
 }
@@ -679,14 +682,14 @@ void blk_mq_start_request(struct request *rq)
 	 * @rq->deadline it reads together under @rq->gstate_seq is
 	 * guaranteed to be the matching one.
 	 */
-	preempt_disable();
+	local_irq_disable();
 	write_seqcount_begin(&rq->gstate_seq);
 
 	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
 	blk_add_timer(rq);
 
 	write_seqcount_end(&rq->gstate_seq);
-	preempt_enable();
+	local_irq_enable();
 
 	if (q->dma_drain_size && blk_rq_bytes(rq)) {
 		/*
@@ -831,13 +834,12 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		__blk_mq_complete_request(req);
 		break;
 	case BLK_EH_RESET_TIMER:
-		/*
-		 * As nothing prevents from completion happening while
-		 * ->aborted_gstate is set, this may lead to ignored
-		 * completions and further spurious timeouts.
-		 */
-		blk_mq_rq_update_aborted_gstate(req, 0);
+		local_irq_disable();
+		write_seqcount_begin(&req->gstate_seq);
 		blk_add_timer(req);
+		req->aborted_gstate = 0;
+		write_seqcount_end(&req->gstate_seq);
+		local_irq_enable();
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
@@ -2074,7 +2076,6 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	}
 
 	seqcount_init(&rq->gstate_seq);
-	u64_stats_init(&rq->aborted_gstate_sync);
 	return 0;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f3df807cf8f..3dcebc046c2e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -231,19 +231,11 @@ struct request {
 	 * generation number which is monotonically incremented and used to
 	 * distinguish the reuse instances.
 	 *
-	 * ->gstate_seq allows updates to ->gstate and other fields
-	 * (currently ->deadline) during request start to be read
-	 * atomically from the timeout path, so that it can operate on a
-	 * coherent set of information.
+	 * ->gstate_seq serializes accesses of ->gstate, ->aborted_gstate and
+	 * ->__deadline.
 	 */
 	seqcount_t gstate_seq;
 	u64 gstate;
-
-	/*
-	 * ->aborted_gstate is used by the timeout to claim a specific
-	 * recycle instance of this request.  See blk_mq_timeout_work().
-	 */
-	struct u64_stats_sync aborted_gstate_sync;
 	u64 aborted_gstate;
 
 	/* access through blk_rq_set_deadline, blk_rq_deadline */
-- 
2.16.0

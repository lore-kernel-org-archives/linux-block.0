Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [RFC PATCH] blk-mq: Fix lost request during timeout
Date: Mon, 18 Sep 2017 18:03:06 -0400
Message-Id: <1505772186-4601-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

I think we've always known it's possible to lose a request during timeout
handling, but just accepted that possibility. It seems to be causing
problems, though, leading to unnecessary error escalation and IO failures.

The possiblity arises when the block layer marks the request complete
prior to running the timeout handler. If that request happens to complete
while the handler is running, the request will be lost, inevitably
triggering a second timeout.

This patch attempts to shorten the window for this race condition by
clearing the started flag when the driver completes a request. The block
layer's timeout handler will then complete the command if it observes
the started flag is no longer set.

Note it's possible to lose the command even with this patch. It's just
less likely to happen.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 98a1860..37144ef 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -566,6 +566,7 @@ void blk_mq_complete_request(struct request *rq)
 
 	if (unlikely(blk_should_fake_timeout(q)))
 		return;
+	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
 	if (!blk_mark_rq_complete(rq))
 		__blk_mq_complete_request(rq);
 }
@@ -605,19 +606,19 @@ void blk_mq_start_request(struct request *rq)
 	 * complete. So be sure to clear complete again when we start
 	 * the request, otherwise we'll ignore the completion event.
 	 */
-	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
+	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
 		set_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
+		if (q->dma_drain_size && blk_rq_bytes(rq)) {
+			/*
+			 * Make sure space for the drain appears.  We know we can do
+			 * this because max_hw_segments has been adjusted to be one
+			 * fewer than the device can handle.
+			 */
+			rq->nr_phys_segments++;
+		}
+	}
 	if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
 		clear_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
-
-	if (q->dma_drain_size && blk_rq_bytes(rq)) {
-		/*
-		 * Make sure space for the drain appears.  We know we can do
-		 * this because max_hw_segments has been adjusted to be one
-		 * fewer than the device can handle.
-		 */
-		rq->nr_phys_segments++;
-	}
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
@@ -637,11 +638,6 @@ static void __blk_mq_requeue_request(struct request *rq)
 	trace_block_rq_requeue(q, rq);
 	wbt_requeue(q->rq_wb, &rq->issue_stat);
 	blk_mq_sched_requeue_request(rq);
-
-	if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
-		if (q->dma_drain_size && blk_rq_bytes(rq))
-			rq->nr_phys_segments--;
-	}
 }
 
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
@@ -763,10 +759,15 @@ void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		__blk_mq_complete_request(req);
 		break;
 	case BLK_EH_RESET_TIMER:
-		blk_add_timer(req);
-		blk_clear_rq_complete(req);
-		break;
+		if (test_bit(REQ_ATOM_STARTED, &req->atomic_flags)) {
+			blk_add_timer(req);
+			blk_clear_rq_complete(req);
+			break;
+		}
+		/* Fall through */
 	case BLK_EH_NOT_HANDLED:
+		if (!test_bit(REQ_ATOM_STARTED, &req->atomic_flags))
+			__blk_mq_complete_request(req);
 		break;
 	default:
 		printk(KERN_ERR "block: bad eh return: %d\n", ret);
-- 
2.5.5

Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	stable@vger.kernel.org
Subject: [PATCH] blk-mq: fix race between complete and BLK_EH_RESET_TIMER
Date: Thu, 12 Apr 2018 04:55:29 +0800
Message-Id: <20180411205529.31145-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The normal request completion can be done before or during handling
BLK_EH_RESET_TIMER, and this race may cause the request to never
be completed since driver's .timeout() may always return
BLK_EH_RESET_TIMER.

This issue can't be fixed completely by driver, since the normal
completion can be done between returning .timeout() and handing
BLK_EH_RESET_TIMER.

This patch fixes this race by introducing rq state of MQ_RQ_COMPLETE_IN_RESET,
and reading/writing rq's state by holding queue lock, which can be
per-request actually, but just not necessary to introduce one lock for
so unusual event.

Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Israel Rukshin <israelr@mellanox.com>,
Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---

This is another way to fix this long-time issue, and turns out this
solution is much simpler.

 block/blk-mq.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 block/blk-mq.h |  1 +
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0dc9e341c2a7..12e8850e3905 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -630,10 +630,27 @@ void blk_mq_complete_request(struct request *rq)
 	 * However, that would complicate paths which want to synchronize
 	 * against us.  Let stay in sync with the issue path so that
 	 * hctx_lock() covers both issue and completion paths.
+	 *
+	 * Cover complete vs BLK_EH_RESET_TIMER race in slow path with
+	 * helding queue lock.
 	 */
 	hctx_lock(hctx, &srcu_idx);
 	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
 		__blk_mq_complete_request(rq);
+	else {
+		unsigned long flags;
+		bool need_complete = false;
+
+		spin_lock_irqsave(q->queue_lock, flags);
+		if (!blk_mq_rq_aborted_gstate(rq))
+			need_complete = true;
+		else
+			blk_mq_rq_update_state(rq, MQ_RQ_COMPLETE_IN_RESET);
+		spin_unlock_irqrestore(q->queue_lock, flags);
+
+		if (need_complete)
+			__blk_mq_complete_request(rq);
+	}
 	hctx_unlock(hctx, srcu_idx);
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
@@ -814,24 +831,41 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 {
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
+	unsigned long flags;
 
 	req->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
 
 	if (ops->timeout)
 		ret = ops->timeout(req, reserved);
 
+again:
 	switch (ret) {
 	case BLK_EH_HANDLED:
 		__blk_mq_complete_request(req);
 		break;
 	case BLK_EH_RESET_TIMER:
 		/*
-		 * As nothing prevents from completion happening while
-		 * ->aborted_gstate is set, this may lead to ignored
-		 * completions and further spurious timeouts.
+		 * The normal completion may happen during handling the
+		 * timeout, or even after returning from .timeout(), so
+		 * once the request has been completed, we can't reset
+		 * timer any more since this request may be handled as
+		 * BLK_EH_RESET_TIMER in next timeout handling too, and
+		 * it has to be completed in this situation.
+		 *
+		 * Holding the queue lock to cover read/write rq's
+		 * aborted_gstate and normal state, so the race can be
+		 * avoided completely.
 		 */
-		blk_mq_rq_update_aborted_gstate(req, 0);
-		blk_add_timer(req);
+		spin_lock_irqsave(req->q->queue_lock, flags);
+		if (blk_mq_rq_state(req) != MQ_RQ_COMPLETE_IN_RESET) {
+			blk_mq_rq_update_aborted_gstate(req, 0);
+			blk_add_timer(req);
+		} else {
+			blk_mq_rq_update_state(req, MQ_RQ_IN_FLIGHT);
+			ret = BLK_EH_HANDLED;
+			goto again;
+		}
+		spin_unlock_irqrestore(req->q->queue_lock, flags);
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 88c558f71819..6dc242fc785a 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -35,6 +35,7 @@ enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
 	MQ_RQ_IN_FLIGHT		= 1,
 	MQ_RQ_COMPLETE		= 2,
+	MQ_RQ_COMPLETE_IN_RESET	= 3,
 
 	MQ_RQ_STATE_BITS	= 2,
 	MQ_RQ_STATE_MASK	= (1 << MQ_RQ_STATE_BITS) - 1,
-- 
2.9.5

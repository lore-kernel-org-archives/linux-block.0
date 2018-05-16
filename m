Return-Path: <hch@lst.de>
Date: Wed, 16 May 2018 14:51:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180516125110.GA32078@lst.de>
References: <20180515225124.20428-1-bart.vanassche@wdc.com> <20180515225124.20428-6-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180515225124.20428-6-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

I've been looking at this carefully, and I don't think we need cmpxchg64
at all, and we don't need anywhere near as many cmpxchg operations either.

The only reason to include the deadline in the atomic operation is the
blk_abort_request case, as the blk_mq_add_timer never modifies the
deadline of a request that someone could be racing with.  So if we
introduce a new aborted state for use by blk_abort_request we can modify
the deadline separately (and in fact have a common field with the legacy
path).

Also anytime we call blk_mq_change_rq_state and don't care about the
previous state it is a pretty clear indicator that we aren't racing
with anyone else  For blk_mq_free_request that obviously is the case
as the request must have completed before, and for the requeue case
we assume that.  If it isn't the case we have a deeper problem going
way back.

Below is a lightly tested patch on top of yours to implement these
suggestions, and also making sure we only access the generation/state
using WRITE_ONCE, READ_ONLY and cmpxchg to avoid any races due to
reordering.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 40c9aa085613..5960e14025e6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -274,6 +274,40 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
 }
 EXPORT_SYMBOL(blk_mq_can_queue);
 
+/**
+ * blk_mq_change_rq_state - atomically test and set request state
+ * @rq: Request pointer.
+ * @old_state: Old request state.
+ * @new_state: New request state.
+ *
+ * Returns %true if and only if the old state was @old and if the state has
+ * been changed into @new.
+ */
+static inline bool blk_mq_change_rq_state(struct request *rq,
+		enum mq_rq_state old_state, enum mq_rq_state new_state)
+{
+	union request_sag sag = READ_ONCE(rq->sag);
+	union request_sag old = sag, new = sag;
+
+	BUILD_BUG_ON(sizeof(union request_sag) != sizeof(u32));
+
+	old.state = old_state;
+	new.state = new_state;
+	return cmpxchg(&rq->sag.val, old.val, new.val) == old.val;
+}
+
+static inline void blk_mq_set_rq_state(struct request *rq,
+		enum mq_rq_state new_state)
+{
+	union request_sag sag = READ_ONCE(rq->sag);
+
+	if (new_state == MQ_RQ_IN_FLIGHT)
+		sag.generation++;
+	sag.state = new_state;
+
+	WRITE_ONCE(rq->sag, sag);
+}
+
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		unsigned int tag, unsigned int op)
 {
@@ -318,7 +352,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->special = NULL;
 	/* tag was already set */
 	rq->extra_len = 0;
-	WARN_ON_ONCE(rq->das.state != MQ_RQ_IDLE);
+	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
 
 	INIT_LIST_HEAD(&rq->timeout_list);
 	rq->timeout = 0;
@@ -494,8 +528,7 @@ void blk_mq_free_request(struct request *rq)
 	if (blk_rq_rl(rq))
 		blk_put_rl(blk_rq_rl(rq));
 
-	if (!blk_mq_change_rq_state(rq, blk_mq_rq_state(rq), MQ_RQ_IDLE))
-		WARN_ON_ONCE(true);
+	blk_mq_set_rq_state(rq, MQ_RQ_IDLE);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
@@ -619,6 +652,14 @@ int blk_mq_request_started(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_request_started);
 
+static inline void __blk_mq_start_request(struct request *rq)
+{
+	rq->__deadline = jiffies +
+		(rq->timeout ? rq->timeout : rq->q->rq_timeout);
+	__blk_add_timer(rq, rq->__deadline);
+	blk_mq_set_rq_state(rq, MQ_RQ_IN_FLIGHT);
+}
+
 void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -636,7 +677,7 @@ void blk_mq_start_request(struct request *rq)
 		wbt_issue(q->rq_wb, rq);
 	}
 
-	blk_mq_add_timer(rq, MQ_RQ_IDLE, MQ_RQ_IN_FLIGHT);
+	__blk_mq_start_request(rq);
 
 	if (q->dma_drain_size && blk_rq_bytes(rq)) {
 		/*
@@ -652,16 +693,18 @@ EXPORT_SYMBOL(blk_mq_start_request);
 static void __blk_mq_requeue_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	enum mq_rq_state old_state = blk_mq_rq_state(rq);
 
 	blk_mq_put_driver_tag(rq);
 
 	trace_block_rq_requeue(q, rq);
 	wbt_requeue(q->rq_wb, rq);
 
-	if (old_state != MQ_RQ_IDLE) {
-		if (!blk_mq_change_rq_state(rq, old_state, MQ_RQ_IDLE))
-			WARN_ON_ONCE(true);
+	/*
+	 * Note: the driver must ensure this doesn't race with completions or
+	 * timeouts.
+	 */
+	if (blk_mq_rq_state(rq) != MQ_RQ_IDLE) {
+		blk_mq_set_rq_state(rq, MQ_RQ_IDLE);
 		if (q->dma_drain_size && blk_rq_bytes(rq))
 			rq->nr_phys_segments--;
 	}
@@ -778,7 +821,7 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		__blk_mq_complete_request(req);
 		break;
 	case BLK_EH_RESET_TIMER:
-		blk_mq_add_timer(req, MQ_RQ_COMPLETE, MQ_RQ_IN_FLIGHT);
+		__blk_mq_start_request(req);
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
@@ -792,23 +835,26 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
 	struct blk_mq_timeout_data *data = priv;
-	union blk_deadline_and_state das = READ_ONCE(rq->das);
 	unsigned long now = jiffies;
-	int32_t diff_jiffies = das.deadline - now;
-	int32_t diff_next = das.deadline - data->next;
-	enum mq_rq_state rq_state = das.state;
+	unsigned long deadline = READ_ONCE(rq->__deadline);
+	union request_sag sag = READ_ONCE(rq->sag);
+	union request_sag aborted_sag = sag;
+	long diff_jiffies = deadline - now;
+	long diff_next = deadline - data->next;
 
 	/*
-	 * Make sure that rq->aborted_gstate != rq->das if rq->deadline has not
+	 * Make sure that rq->aborted_sag != rq->sag if rq->deadline has not
 	 * yet been reached even if a request gets recycled before
-	 * blk_mq_terminate_expired() is called and the value of rq->deadline
+	 * blk_mq_terminate_expired() is called and the value of rq->__deadline
 	 * is not modified due to the request recycling.
 	 */
-	rq->aborted_gstate = das;
-	rq->aborted_gstate.generation ^= (1UL << 29);
-	if (diff_jiffies <= 0 && rq_state == MQ_RQ_IN_FLIGHT) {
-		/* request timed out */
-		rq->aborted_gstate = das;
+	aborted_sag.generation ^= (1u << 29);
+	WRITE_ONCE(rq->aborted_sag, aborted_sag);
+
+	if (sag.state == MQ_RQ_ABORTED ||
+	    (sag.state == MQ_RQ_IN_FLIGHT && diff_jiffies <= 0)) {
+		/* request aborted or timed out */
+		WRITE_ONCE(rq->aborted_sag, sag);
 		data->nr_expired++;
 		hctx->nr_expired++;
 	} else if (!data->next_set) {
@@ -819,23 +865,21 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		/* data->next is later than deadline; reduce data->next. */
 		data->next += diff_next;
 	}
-
 }
 
 static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
-	union blk_deadline_and_state old_val = rq->aborted_gstate;
-	union blk_deadline_and_state new_val = old_val;
-
-	new_val.state = MQ_RQ_COMPLETE;
+	union request_sag old = READ_ONCE(rq->aborted_sag);
+	union request_sag new = old;
 
 	/*
-	 * We marked @rq->aborted_gstate and waited for ongoing .queue_rq()
-	 * calls. If rq->das has not changed that means that it
-	 * is now safe to change the request state and to handle the timeout.
+	 * We marked @rq->aborted_sag and waited for ongoing .queue_rq() calls.
+	 * If rq->sag has not changed that means that it is now safe to change
+	 * the request state and to handle the timeout.
 	 */
-	if (blk_mq_set_rq_state(rq, old_val, new_val))
+	new.state = MQ_RQ_COMPLETE;
+	if (cmpxchg(&rq->sag.val, old.val, new.val) == old.val)
 		blk_mq_rq_timed_out(rq, reserved);
 }
 
@@ -916,6 +960,12 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	blk_queue_exit(q);
 }
 
+void blk_mq_abort_request(struct request *rq)
+{
+	if (blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT, MQ_RQ_ABORTED))
+		kblockd_schedule_work(&rq->q->timeout_work);
+}
+
 struct flush_busy_ctx_data {
 	struct blk_mq_hw_ctx *hctx;
 	struct list_head *list;
@@ -1983,10 +2033,6 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 {
 	int ret;
 
-#ifndef CONFIG_ARCH_HAVE_CMPXCHG64
-	spin_lock_init(&rq->das_lock);
-#endif
-
 	if (set->ops->init_request) {
 		ret = set->ops->init_request(set, rq, hctx_idx, node);
 		if (ret)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 42320011d264..42721d6331df 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -2,7 +2,6 @@
 #ifndef INT_BLK_MQ_H
 #define INT_BLK_MQ_H
 
-#include <asm/cmpxchg.h>
 #include "blk-stat.h"
 #include "blk-mq-tag.h"
 
@@ -31,11 +30,11 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
-/* See also blk_deadline_and_state.state. */
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
 	MQ_RQ_IN_FLIGHT		= 1,
-	MQ_RQ_COMPLETE		= 2,
+	MQ_RQ_ABORTED		= 2,
+	MQ_RQ_COMPLETE		= 3,
 };
 
 void blk_mq_freeze_queue(struct request_queue *q);
@@ -48,6 +47,7 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 				bool wait);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
+void blk_mq_abort_request(struct request *rq);
 
 /*
  * Internal helpers for allocating/freeing the request map
@@ -97,106 +97,13 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
-static inline bool blk_mq_set_rq_state(struct request *rq,
-				       union blk_deadline_and_state old_val,
-				       union blk_deadline_and_state new_val)
-{
-#ifdef CONFIG_ARCH_HAVE_CMPXCHG64
-	return cmpxchg64(&rq->das.das, old_val.das, new_val.das) == old_val.das;
-#else
-	unsigned long flags;
-	bool res = false;
-
-	spin_lock_irqsave(&rq->das_lock, flags);
-	if (rq->das.das == old_val.das) {
-		rq->das = new_val;
-		res = true;
-	}
-	spin_unlock_irqrestore(&rq->das_lock, flags);
-
-	return res;
-#endif
-}
-
-/*
- * If the state of request @rq equals @old_state, update deadline and request
- * state atomically to @time and @new_state. blk-mq only. cmpxchg64() is only
- * used if there could be a concurrent update attempt from another context.
- */
-static inline bool blk_mq_rq_set_deadline(struct request *rq,
-					  unsigned long new_time,
-					  enum mq_rq_state old_state,
-					  enum mq_rq_state new_state)
-{
-	union blk_deadline_and_state old_val, new_val;
-
-	if (old_state != MQ_RQ_IN_FLIGHT) {
-		old_val = READ_ONCE(rq->das);
-		if (old_val.state != old_state)
-			return false;
-		new_val = old_val;
-		new_val.deadline = new_time;
-		new_val.state = new_state;
-		if (new_state == MQ_RQ_IN_FLIGHT)
-			new_val.generation++;
-		WRITE_ONCE(rq->das.das, new_val.das);
-		return true;
-	}
-
-	do {
-		old_val = READ_ONCE(rq->das);
-		if (old_val.state != old_state)
-			return false;
-		new_val = old_val;
-		new_val.deadline = new_time;
-		new_val.state = new_state;
-		if (new_state == MQ_RQ_IN_FLIGHT)
-			new_val.generation++;
-	} while (!blk_mq_set_rq_state(rq, old_val, new_val));
-
-	return true;
-}
-
 /**
  * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
  * @rq: target request.
  */
 static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
 {
-	return rq->das.state;
-}
-
-/**
- * blk_mq_change_rq_state - atomically test and set request state
- * @rq: Request pointer.
- * @old_state: Old request state.
- * @new_state: New request state.
- *
- * Returns %true if and only if the old state was @old and if the state has
- * been changed into @new.
- */
-static inline bool blk_mq_change_rq_state(struct request *rq,
-					  enum mq_rq_state old_state,
-					  enum mq_rq_state new_state)
-{
-	union blk_deadline_and_state das = READ_ONCE(rq->das);
-	union blk_deadline_and_state old_val = das;
-	union blk_deadline_and_state new_val = das;
-
-	old_val.state = old_state;
-	new_val.state = new_state;
-	if (new_state == MQ_RQ_IN_FLIGHT)
-		new_val.generation++;
-	/*
-	 * For transitions from state in-flight to another state cmpxchg64()
-	 * must be used. For other state transitions it is safe to use
-	 * WRITE_ONCE().
-	 */
-	if (old_state != MQ_RQ_IN_FLIGHT) {
-		WRITE_ONCE(rq->das.das, new_val.das);
-		return true;
-	}
-	return blk_mq_set_rq_state(rq, old_val, new_val);
+	return READ_ONCE(rq->sag).state;
 }
 
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 549dfda7190c..19fca827a272 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -157,14 +157,7 @@ void blk_timeout_work(struct work_struct *work)
 void blk_abort_request(struct request *req)
 {
 	if (req->q->mq_ops) {
-		/*
-		 * All we need to ensure is that timeout scan takes place
-		 * immediately and that scan sees the new timeout value.
-		 * No need for fancy synchronizations.
-		 */
-		if (blk_mq_rq_set_deadline(req, jiffies, MQ_RQ_IN_FLIGHT,
-					   MQ_RQ_IN_FLIGHT))
-			kblockd_schedule_work(&req->q->timeout_work);
+		blk_mq_abort_request(req);
 	} else {
 		if (blk_mark_rq_complete(req))
 			return;
@@ -185,7 +178,7 @@ unsigned long blk_rq_timeout(unsigned long timeout)
 	return timeout;
 }
 
-static void __blk_add_timer(struct request *req, unsigned long deadline)
+void __blk_add_timer(struct request *req, unsigned long deadline)
 {
 	struct request_queue *q = req->q;
 	unsigned long expiry;
@@ -238,28 +231,3 @@ void blk_add_timer(struct request *req)
 
 	return __blk_add_timer(req, deadline);
 }
-
-/**
- * blk_mq_add_timer - set the deadline for a single request
- * @req:	request for which to set the deadline.
- * @old:	current request state.
- * @new:	new request state.
- *
- * Sets the deadline of a request if and only if it has state @old and
- * at the same time changes the request state from @old into @new. The caller
- * must guarantee that the request state won't be modified while this function
- * is in progress.
- */
-void blk_mq_add_timer(struct request *req, enum mq_rq_state old,
-		      enum mq_rq_state new)
-{
-	struct request_queue *q = req->q;
-	unsigned long deadline;
-
-	if (!req->timeout)
-		req->timeout = q->rq_timeout;
-	deadline = jiffies + req->timeout;
-	if (!blk_mq_rq_set_deadline(req, deadline, old, new))
-		WARN_ON_ONCE(true);
-	return __blk_add_timer(req, deadline);
-}
diff --git a/block/blk.h b/block/blk.h
index 984367308b11..81a36c96aba2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -170,8 +170,7 @@ static inline bool bio_integrity_endio(struct bio *bio)
 void blk_timeout_work(struct work_struct *work);
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
-void blk_mq_add_timer(struct request *req, enum mq_rq_state old,
-		      enum mq_rq_state new);
+void __blk_add_timer(struct request *req, unsigned long deadline);
 void blk_delete_timer(struct request *);
 
 
@@ -193,21 +192,21 @@ void blk_account_io_done(struct request *req, u64 now);
 /*
  * EH timer and IO completion will both attempt to 'grab' the request, make
  * sure that only one of them succeeds. Steal the bottom bit of the
- * das field for this.
+ * __deadline field for this.
  */
 static inline int blk_mark_rq_complete(struct request *rq)
 {
-	return test_and_set_bit(0, &rq->das.legacy_deadline);
+	return test_and_set_bit(0, &rq->__deadline);
 }
 
 static inline void blk_clear_rq_complete(struct request *rq)
 {
-	clear_bit(0, &rq->das.legacy_deadline);
+	clear_bit(0, &rq->__deadline);
 }
 
 static inline bool blk_rq_is_complete(struct request *rq)
 {
-	return test_bit(0, &rq->das.legacy_deadline);
+	return test_bit(0, &rq->__deadline);
 }
 
 /*
@@ -316,12 +315,12 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
  */
 static inline void blk_rq_set_deadline(struct request *rq, unsigned long time)
 {
-	rq->das.legacy_deadline = time & ~0x1UL;
+	rq->__deadline = time & ~0x1UL;
 }
 
 static inline unsigned long blk_rq_deadline(struct request *rq)
 {
-	return rq->das.legacy_deadline & ~0x1UL;
+	return rq->__deadline & ~0x1UL;
 }
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 771dbdc8758c..5288e9c3fdbf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -130,14 +130,12 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_NOMERGE_FLAGS \
 	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
 
-union blk_deadline_and_state {
+union request_sag {
 	struct {
-		uint32_t generation:30;
-		uint32_t state:2;
-		uint32_t deadline;
+		u32	generation : 30;
+		u32	state : 2;
 	};
-	unsigned long legacy_deadline;
-	uint64_t das;
+	u32		val;
 };
 
 /*
@@ -242,24 +240,19 @@ struct request {
 
 	unsigned int extra_len;	/* length of alignment and padding */
 
-	/*
-	 * ->aborted_gstate is used by the timeout to claim a specific
-	 * recycle instance of this request.  See blk_mq_timeout_work().
-	 */
-	union blk_deadline_and_state aborted_gstate;
-
-#ifndef CONFIG_ARCH_HAVE_CMPXCHG64
-	spinlock_t das_lock;
-#endif
+	 /*
+	  * ->aborted_sagis used by the timeout to claim a specific recycle
+	  * instance of this request.  See blk_mq_timeout_work().
+	  */
+	union request_sag sag;
+	union request_sag aborted_sag;
 
 	/*
 	 * Access through blk_rq_deadline() and blk_rq_set_deadline(),
 	 * blk_mark_rq_complete(), blk_clear_rq_complete() and
-	 * blk_rq_is_complete() for legacy queues or blk_mq_rq_state(),
-	 * blk_mq_change_rq_state() and blk_mq_rq_set_deadline() for
-	 * blk-mq queues.
+	 * blk_rq_is_complete() for legacy queues.
 	 */
-	union blk_deadline_and_state das;
+	unsigned long __deadline;
 
 	struct list_head timeout_list;
 

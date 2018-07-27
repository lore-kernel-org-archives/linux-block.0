Return-Path: <prvs=7391cfe80=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@intel.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 3/5] block: Split blk_add_timer()
Date: Fri, 27 Jul 2018 15:56:18 -0700
Message-Id: <20180727225620.17855-4-bart.vanassche@wdc.com>
In-Reply-To: <20180727225620.17855-1-bart.vanassche@wdc.com>
References: <20180727225620.17855-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Split blk_add_timer() as follows:
- Introduce the helper function __blk_add_timer() that performs the
  tasks that apply both to the legacy block layer core and to blk-mq.
- Duplicate the remaining blk_add_timer() function into the new
  function blk_mq_add_timer().
- Change the blk_mq_timer() calls into blk_mq_add_timer() calls in
  blk-mq code.

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c      |  4 +--
 block/blk-timeout.c | 81 +++++++++++++++++++++++++++++++++++----------
 block/blk.h         |  1 +
 3 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8e9beb4ddeb0..670f8960b88a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -644,7 +644,7 @@ void blk_mq_start_request(struct request *rq)
 
 	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
 
-	blk_add_timer(rq);
+	blk_mq_add_timer(rq);
 	WRITE_ONCE(rq->state, MQ_RQ_IN_FLIGHT);
 
 	if (q->dma_drain_size && blk_rq_bytes(rq)) {
@@ -785,7 +785,7 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		}
 	}
 
-	blk_add_timer(req);
+	blk_mq_add_timer(req);
 }
 
 static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 38992c098026..ac0255a70401 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -188,6 +188,33 @@ unsigned long blk_rq_timeout(unsigned long timeout)
 	return timeout;
 }
 
+static void __blk_add_timer(struct request *req, unsigned long deadline)
+{
+	struct request_queue *q = req->q;
+	unsigned long expiry;
+
+	/*
+	 * If the timer isn't already pending or this timeout is earlier
+	 * than an existing one, modify the timer. Round up to next nearest
+	 * second.
+	 */
+	expiry = blk_rq_timeout(round_jiffies_up(deadline));
+	if (!timer_pending(&q->timeout) ||
+	    time_before(expiry, q->timeout.expires)) {
+		unsigned long diff = q->timeout.expires - expiry;
+
+		/*
+		 * Due to added timer slack to group timers, the timer
+		 * will often be a little in front of what we asked for.
+		 * So apply some tolerance here too, otherwise we keep
+		 * modifying the timer because expires for value X
+		 * will be X + something.
+		 */
+		if (!timer_pending(&q->timeout) || (diff >= HZ / 2))
+			mod_timer(&q->timeout, expiry);
+	}
+}
+
 /**
  * blk_add_timer - Start timeout timer for a single request
  * @req:	request that is about to start running.
@@ -199,7 +226,6 @@ unsigned long blk_rq_timeout(unsigned long timeout)
 void blk_add_timer(struct request *req)
 {
 	struct request_queue *q = req->q;
-	unsigned long expiry;
 
 	if (!q->mq_ops)
 		lockdep_assert_held(q->queue_lock);
@@ -227,26 +253,45 @@ void blk_add_timer(struct request *req)
 	if (!q->mq_ops)
 		list_add_tail(&req->timeout_list, &req->q->timeout_list);
 
+	__blk_add_timer(req, blk_rq_deadline(req));
+}
+
+/**
+ * blk_mq_add_timer - set the deadline for a single request
+ * @req:	request for which to set the deadline.
+ *
+ * Sets the deadline of a request. The caller must guarantee that the request
+ * state won't be modified while this function is in progress.
+ */
+void blk_mq_add_timer(struct request *req)
+{
+	struct request_queue *q = req->q;
+
+	if (!q->mq_ops)
+		lockdep_assert_held(q->queue_lock);
+
+	/* blk-mq has its own handler, so we don't need ->rq_timed_out_fn */
+	if (!q->mq_ops && !q->rq_timed_out_fn)
+		return;
+
+	BUG_ON(!list_empty(&req->timeout_list));
+
 	/*
-	 * If the timer isn't already pending or this timeout is earlier
-	 * than an existing one, modify the timer. Round up to next nearest
-	 * second.
+	 * Some LLDs, like scsi, peek at the timeout to prevent a
+	 * command from being retried forever.
 	 */
-	expiry = blk_rq_timeout(round_jiffies_up(blk_rq_deadline(req)));
+	if (!req->timeout)
+		req->timeout = q->rq_timeout;
 
-	if (!timer_pending(&q->timeout) ||
-	    time_before(expiry, q->timeout.expires)) {
-		unsigned long diff = q->timeout.expires - expiry;
+	req->rq_flags &= ~RQF_TIMED_OUT;
+	blk_rq_set_deadline(req, jiffies + req->timeout);
 
-		/*
-		 * Due to added timer slack to group timers, the timer
-		 * will often be a little in front of what we asked for.
-		 * So apply some tolerance here too, otherwise we keep
-		 * modifying the timer because expires for value X
-		 * will be X + something.
-		 */
-		if (!timer_pending(&q->timeout) || (diff >= HZ / 2))
-			mod_timer(&q->timeout, expiry);
-	}
+	/*
+	 * Only the non-mq case needs to add the request to a protected list.
+	 * For the mq case we simply scan the tag map.
+	 */
+	if (!q->mq_ops)
+		list_add_tail(&req->timeout_list, &req->q->timeout_list);
 
+	__blk_add_timer(req, blk_rq_deadline(req));
 }
diff --git a/block/blk.h b/block/blk.h
index 69b14cd2bb22..6adae8f94279 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -170,6 +170,7 @@ static inline bool bio_integrity_endio(struct bio *bio)
 void blk_timeout_work(struct work_struct *work);
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
+void blk_mq_add_timer(struct request *req);
 void blk_delete_timer(struct request *);
 
 
-- 
2.18.0

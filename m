Return-Path: <prvs=012435efd5=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC: <hch@infradead.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/3] blk-mq: make the polling code adaptive
Date: Fri, 11 Nov 2016 22:11:27 -0700
Message-ID: <1478927487-12998-4-git-send-email-axboe@fb.com>
In-Reply-To: <1478927487-12998-1-git-send-email-axboe@fb.com>
References: <1478927487-12998-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

The previous commit introduced the hybrid sleep/poll mode. Take
that one step further, and use the completion latencies to
automatically sleep for half the mean completion time. This is
a good approximation.

This changes the 'io_poll_delay' sysfs file a bit to expose the
various options. Depending on the value, the polling code will
behave differently:

-1	Never enter hybrid sleep mode
 0	Use half of the completion mean for the sleep delay
>0	Use this specific value as the sleep delay

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++----
 block/blk-sysfs.c      | 26 ++++++++++++------
 include/linux/blkdev.h |  2 +-
 3 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c77a2da123a..70b1b59ed0d3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2125,6 +2125,11 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	 */
 	q->nr_requests = set->queue_depth;
 
+	/*
+	 * Default to classic polling
+	 */
+	q->poll_nsec = -1;
+
 	if (set->ops->complete)
 		blk_queue_softirq_done(q, set->ops->complete);
 
@@ -2462,13 +2467,70 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
+static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
+				       struct blk_mq_hw_ctx *hctx,
+				       struct request *rq)
+{
+	struct blk_rq_stat stat[2];
+	unsigned long ret = 0;
+
+	/*
+	 * If stats collection isn't on, don't sleep but turn it on for
+	 * future users
+	 */
+	if (!blk_stat_enable(q))
+		return 0;
+
+	/*
+	 * We don't have to do this once per IO, should optimize this
+	 * to just use the current window of stats until it changes
+	 */
+	memset(&stat, 0, sizeof(stat));
+	blk_hctx_stat_get(hctx, stat);
+
+	/*
+	 * As an optimistic guess, use half of the mean service time
+	 * for this type of request. We can (and should) make this smarter.
+	 * For instance, if the completion latencies are tight, we can
+	 * get closer than just half the mean. This is especially
+	 * important on devices where the completion latencies are longer
+	 * than ~10 usec.
+	 */
+	if (req_op(rq) == REQ_OP_READ && stat[BLK_STAT_READ].nr_samples)
+		ret = (stat[BLK_STAT_READ].mean + 1) / 2;
+	else if (req_op(rq) == REQ_OP_WRITE && stat[BLK_STAT_WRITE].nr_samples)
+		ret = (stat[BLK_STAT_WRITE].mean + 1) / 2;
+
+	return ret;
+}
+
 static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
+				     struct blk_mq_hw_ctx *hctx,
 				     struct request *rq)
 {
 	struct hrtimer_sleeper hs;
+	enum hrtimer_mode mode;
+	unsigned int nsecs;
 	ktime_t kt;
 
-	if (!q->poll_nsec || test_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags))
+	if (test_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags))
+		return false;
+
+	/*
+	 * poll_nsec can be:
+	 *
+	 * -1:	don't ever hybrid sleep
+	 *  0:	use half of prev avg
+	 * >0:	use this specific value
+	 */
+	if (q->poll_nsec == -1)
+		return false;
+	else if (q->poll_nsec > 0)
+		nsecs = q->poll_nsec;
+	else
+		nsecs = blk_mq_poll_nsecs(q, hctx, rq);
+
+	if (!nsecs)
 		return false;
 
 	set_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
@@ -2477,9 +2539,10 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	 * This will be replaced with the stats tracking code, using
 	 * 'avg_completion_time / 2' as the pre-sleep target.
 	 */
-	kt = ktime_set(0, q->poll_nsec);
+	kt = ktime_set(0, nsecs);
 
-	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	mode = HRTIMER_MODE_REL;
+	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, mode);
 	hrtimer_set_expires(&hs.timer, kt);
 
 	hrtimer_init_sleeper(&hs, current);
@@ -2487,10 +2550,11 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 		if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
 			break;
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		hrtimer_start_expires(&hs.timer, HRTIMER_MODE_REL);
+		hrtimer_start_expires(&hs.timer, mode);
 		if (hs.task)
 			io_schedule();
 		hrtimer_cancel(&hs.timer);
+		mode = HRTIMER_MODE_ABS;
 	} while (hs.task && !signal_pending(current));
 
 	__set_current_state(TASK_RUNNING);
@@ -2510,7 +2574,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	 * the IO isn't complete, we'll get called again and will go
 	 * straight to the busy poll loop.
 	 */
-	if (blk_mq_poll_hybrid_sleep(q, rq))
+	if (blk_mq_poll_hybrid_sleep(q, hctx, rq))
 		return true;
 
 	hctx->poll_considered++;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b87f992fdbd7..652a36eef00c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -352,24 +352,34 @@ queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
 
 static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
 {
-	return queue_var_show(q->poll_nsec / 1000, page);
+	int val;
+
+	if (q->poll_nsec == -1)
+		val = -1;
+	else
+		val = q->poll_nsec / 1000;
+
+	return sprintf(page, "%d\n", val);
 }
 
 static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
 				size_t count)
 {
-	unsigned long poll_usec;
-	ssize_t ret;
+	int err, val;
 
 	if (!q->mq_ops || !q->mq_ops->poll)
 		return -EINVAL;
 
-	ret = queue_var_store(&poll_usec, page, count);
-	if (ret < 0)
-		return ret;
+	err = kstrtoint(page, 10, &val);
+	if (err < 0)
+		return err;
 
-	q->poll_nsec = poll_usec * 1000;
-	return ret;
+	if (val == -1)
+		q->poll_nsec = -1;
+	else
+		q->poll_nsec = val * 1000;
+
+	return count;
 }
 
 static ssize_t queue_poll_show(struct request_queue *q, char *page)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 37ed4ea705c8..85699bc90a51 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -509,7 +509,7 @@ struct request_queue {
 	unsigned int		request_fn_active;
 
 	unsigned int		rq_timeout;
-	unsigned int		poll_nsec;
+	int			poll_nsec;
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 	struct list_head	timeout_list;
-- 
2.7.4

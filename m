Return-Path: <prvs=011358c635=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/4] blk-mq: make the polling code adaptive
Date: Tue, 1 Nov 2016 15:05:25 -0600
Message-ID: <1478034325-28232-5-git-send-email-axboe@fb.com>
In-Reply-To: <1478034325-28232-1-git-send-email-axboe@fb.com>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
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
 block/blk-mq.c         | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 block/blk-sysfs.c      | 28 ++++++++++++++++++++--------
 include/linux/blkdev.h |  2 +-
 3 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index caa55bec9411..2af75b087ebd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2353,13 +2353,57 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
+static unsigned long blk_mq_poll_nsecs(struct blk_mq_hw_ctx *hctx,
+				       struct request *rq)
+{
+	struct blk_rq_stat stat[2];
+	unsigned long ret = 0;
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
+	 * for this type of request
+	 */
+	if (req_op(rq) == REQ_OP_READ && stat[0].nr_samples)
+		ret = (stat[0].mean + 1) / 2;
+	else if (req_op(rq) == REQ_OP_WRITE && stat[1].nr_samples)
+		ret = (stat[1].mean + 1) / 2;
+
+	return ret;
+}
+
 static void blk_mq_poll_hybrid_sleep(struct request_queue *q,
+				     struct blk_mq_hw_ctx *hctx,
 				     struct request *rq)
 {
 	struct hrtimer_sleeper hs;
+	unsigned int nsecs;
 	ktime_t kt;
 
-	if (!q->poll_nsec || test_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags))
+	if (test_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags))
+		return;
+
+	/*
+	 * poll_nsec can be:
+	 *
+	 * -1:	don't ever hybrid sleep
+	 *  0:	use half of prev avg
+	 * >0:	use this specific value
+	 */
+	if (q->poll_nsec == -1)
+		return;
+	else if (q->poll_nsec > 0)
+		nsecs = q->poll_nsec;
+	else
+		nsecs = blk_mq_poll_nsecs(hctx, rq);
+
+	if (!nsecs)
 		return;
 
 	set_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
@@ -2368,7 +2412,7 @@ static void blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	 * This will be replaced with the stats tracking code, using
 	 * 'avg_completion_time / 2' as the pre-sleep target.
 	 */
-	kt = ktime_set(0, q->poll_nsec);
+	kt = ktime_set(0, nsecs);
 
 	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hrtimer_set_expires(&hs.timer, kt);
@@ -2393,7 +2437,7 @@ bool blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	struct request_queue *q = hctx->queue;
 	long state;
 
-	blk_mq_poll_hybrid_sleep(q, rq);
+	blk_mq_poll_hybrid_sleep(q, hctx, rq);
 
 	hctx->poll_considered++;
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 467b81c6713c..c668af57197b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -338,24 +338,36 @@ queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
 
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
+	printk(KERN_ERR "val=%d\n", val);
+
+	if (val == -1)
+		q->poll_nsec = -1;
+	else
+		q->poll_nsec = val * 1000;
+
+	return count;
 }
 
 static ssize_t queue_poll_show(struct request_queue *q, char *page)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6acd220dc3f3..857f866d2751 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -502,7 +502,7 @@ struct request_queue {
 	unsigned int		request_fn_active;
 
 	unsigned int		rq_timeout;
-	unsigned int		poll_nsec;
+	int			poll_nsec;
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 	struct list_head	timeout_list;
-- 
2.7.4

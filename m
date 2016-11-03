Return-Path: <prvs=0115b0b9d1=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/5] blk-mq: implement hybrid poll mode for sync O_DIRECT
Date: Thu, 3 Nov 2016 13:45:06 -0600
Message-ID: <1478202307-1947-5-git-send-email-axboe@fb.com>
In-Reply-To: <1478202307-1947-1-git-send-email-axboe@fb.com>
References: <1478202307-1947-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This patch enables a hybrid polling mode. Instead of polling after IO
submission, we can induce an artificial delay, and then poll after that.
For example, if the IO is presumed to complete in 8 usecs from now, we
can sleep for 4 usecs, wake up, and then do our polling. This still puts
a sleep/wakeup cycle in the IO path, but instead of the wakeup happening
after the IO has completed, it'll happen before. With this hybrid
scheme, we can achieve big latency reductions while still using the same
(or less) amount of CPU.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c         | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-sysfs.c      | 29 +++++++++++++++++++++++++++++
 block/blk.h            |  1 +
 include/linux/blkdev.h |  1 +
 4 files changed, 78 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4883c2d97ea9..4f1748d016a9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -302,6 +302,7 @@ static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
 	rq->rq_flags = 0;
 
 	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
+	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
 	blk_mq_put_tag(hctx, ctx, tag);
 	blk_queue_exit(q);
 }
@@ -2357,11 +2358,57 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
+static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
+				     struct request *rq)
+{
+	struct hrtimer_sleeper hs;
+	ktime_t kt;
+
+	if (!q->poll_nsec || test_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags))
+		return false;
+
+	set_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
+
+	/*
+	 * This will be replaced with the stats tracking code, using
+	 * 'avg_completion_time / 2' as the pre-sleep target.
+	 */
+	kt = ktime_set(0, q->poll_nsec);
+
+	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_set_expires(&hs.timer, kt);
+
+	hrtimer_init_sleeper(&hs, current);
+	do {
+		if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
+			break;
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		hrtimer_start_expires(&hs.timer, HRTIMER_MODE_REL);
+		if (hs.task)
+			io_schedule();
+		hrtimer_cancel(&hs.timer);
+	} while (hs.task && !signal_pending(current));
+
+	__set_current_state(TASK_RUNNING);
+	destroy_hrtimer_on_stack(&hs.timer);
+	return true;
+}
+
 bool blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 {
 	struct request_queue *q = hctx->queue;
 	long state;
 
+	/*
+	 * If we sleep, have the caller restart the poll loop to reset
+	 * the state. Like for the other success return cases, the
+	 * caller is responsible for checking if the IO completed. If
+	 * the IO isn't complete, we'll get called again and will go
+	 * straight to the busy poll loop.
+	 */
+	if (blk_mq_poll_hybrid_sleep(q, rq))
+		return true;
+
 	hctx->poll_considered++;
 
 	state = current->state;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9cdb7247727a..edc0e491ee3b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -336,6 +336,28 @@ queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
+static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->poll_nsec / 1000, page);
+}
+
+static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
+				size_t count)
+{
+	unsigned long poll_usec;
+	ssize_t ret;
+
+	if (!q->mq_ops || !q->mq_ops->poll)
+		return -EINVAL;
+
+	ret = queue_var_store(&poll_usec, page, count);
+	if (ret < 0)
+		return ret;
+
+	q->poll_nsec = poll_usec * 1000;
+	return ret;
+}
+
 static ssize_t queue_poll_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(test_bit(QUEUE_FLAG_POLL, &q->queue_flags), page);
@@ -562,6 +584,12 @@ static struct queue_sysfs_entry queue_poll_entry = {
 	.store = queue_poll_store,
 };
 
+static struct queue_sysfs_entry queue_poll_delay_entry = {
+	.attr = {.name = "io_poll_delay", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_poll_delay_show,
+	.store = queue_poll_delay_store,
+};
+
 static struct queue_sysfs_entry queue_wc_entry = {
 	.attr = {.name = "write_cache", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_wc_show,
@@ -608,6 +636,7 @@ static struct attribute *default_attrs[] = {
 	&queue_wc_entry.attr,
 	&queue_dax_entry.attr,
 	&queue_stats_entry.attr,
+	&queue_poll_delay_entry.attr,
 	NULL,
 };
 
diff --git a/block/blk.h b/block/blk.h
index aa132dea598c..041185e5f129 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -111,6 +111,7 @@ void blk_account_io_done(struct request *req);
 enum rq_atomic_flags {
 	REQ_ATOM_COMPLETE = 0,
 	REQ_ATOM_STARTED,
+	REQ_ATOM_POLL_SLEPT,
 };
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b400c31b4a10..fbd8bb5e064c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -504,6 +504,7 @@ struct request_queue {
 	unsigned int		request_fn_active;
 
 	unsigned int		rq_timeout;
+	unsigned int		poll_nsec;
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 	struct list_head	timeout_list;
-- 
2.7.4

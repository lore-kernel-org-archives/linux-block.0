Return-Path: <sbates@raithlin.com>
From: sbates@raithlin.com
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: osandov@fb.com,
	damien.lemoal@wdc.com,
	Stephen Bates <sbates@raithlin.com>
Subject: [PATCH] blk-mq: Improvements to the hybrid polling sleep time calculation
Date: Mon, 21 Aug 2017 08:35:34 -0600
Message-Id: <1503326134-3862-1-git-send-email-sbates@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: sbates@raithlin.com
List-ID: <linux-block@vger.kernel.org>

From: Stephen Bates <sbates@raithlin.com>

Hybrid polling currently uses half the average completion time as an
estimate of how long to poll for. We can improve upon this by noting
that polling before the minimum completion time makes no sense. Add a
sysfs entry to use this fact to improve CPU utilization in certain
cases.

At the same time the minimum is a bit too long to sleep for since we
must factor in OS wake time for the thread. For now allow the user to
set this via a second sysfs entry (in nanoseconds).

Testing this patch on Intel Optane SSDs showed that using the minimum
rather than half reduced CPU utilization from 59% to 38%. Tuning
this via the wake time adjustment allowed us to trade CPU load for
latency. For example

io_poll	 delay	hyb_use_min adjust	latency	CPU load
1	 -1	N/A	    N/A		8.4	100%
1	 0	0	    N/A		8.4	57%
1	 0	1	    0		10.3	34%
1	 9	1	    1000	9.9	37%
1	 0	1	    2000	8.4	47%
1	 0	1	    10000	8.4	100%

Ideally we will extend this to auto-calculate the wake time rather
than have it set by the user.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 block/blk-mq.c         | 10 +++++++++
 block/blk-sysfs.c      | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  3 +++
 3 files changed, 71 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f84d145..f453a35 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2739,6 +2739,16 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	if (q->poll_stat[bucket].nr_samples)
 		ret = (q->poll_stat[bucket].mean + 1) / 2;
 
+	if (q->poll_hyb_use_min)
+		ret = max(ret, (unsigned long)q->poll_stat[bucket].min);
+
+	if (q->poll_hyb_adjust) {
+		if (ret >= q->poll_hyb_adjust)
+			ret -= q->poll_hyb_adjust;
+		else
+			return 0;
+	}
+
 	return ret;
 }
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 27aceab..51e5853 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -395,6 +395,50 @@ static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
 	return count;
 }
 
+static ssize_t queue_poll_hyb_use_min_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%d\n", q->poll_hyb_use_min);
+}
+
+static ssize_t queue_poll_hyb_use_min_store(struct request_queue *q,
+					    const char *page, size_t count)
+{
+	int err, val;
+
+	if (!q->mq_ops || !q->mq_ops->poll)
+		return -EINVAL;
+
+	err = kstrtoint(page, 10, &val);
+	if (err < 0)
+		return err;
+
+	q->poll_hyb_use_min = val;
+
+	return count;
+}
+
+static ssize_t queue_poll_hyb_adjust_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%d\n", q->poll_hyb_adjust);
+}
+
+static ssize_t queue_poll_hyb_adjust_store(struct request_queue *q,
+					   const char *page, size_t count)
+{
+	int err, val;
+
+	if (!q->mq_ops || !q->mq_ops->poll)
+		return -EINVAL;
+
+	err = kstrtoint(page, 10, &val);
+	if (err < 0)
+		return err;
+
+	q->poll_hyb_adjust = val;
+
+	return count;
+}
+
 static ssize_t queue_poll_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(test_bit(QUEUE_FLAG_POLL, &q->queue_flags), page);
@@ -661,6 +705,18 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	.store = queue_poll_delay_store,
 };
 
+static struct queue_sysfs_entry queue_poll_hyb_use_min_entry = {
+	.attr = {.name = "io_poll_hyb_use_min", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_poll_hyb_use_min_show,
+	.store = queue_poll_hyb_use_min_store,
+};
+
+static struct queue_sysfs_entry queue_poll_hyb_adjust_entry = {
+	.attr = {.name = "io_poll_hyb_adjust", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_poll_hyb_adjust_show,
+	.store = queue_poll_hyb_adjust_store,
+};
+
 static struct queue_sysfs_entry queue_wc_entry = {
 	.attr = {.name = "write_cache", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_wc_show,
@@ -719,6 +775,8 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	&queue_dax_entry.attr,
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
+	&queue_poll_hyb_use_min_entry.attr,
+	&queue_poll_hyb_adjust_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f45f157..97b46ce 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -527,6 +527,9 @@ struct request_queue {
 	unsigned int		rq_timeout;
 	int			poll_nsec;
 
+	int			poll_hyb_use_min;
+	int			poll_hyb_adjust;
+
 	struct blk_stat_callback	*poll_cb;
 	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
 
-- 
1.9.1

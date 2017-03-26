Return-Path: <sbates130272@gmail.com>
Return-Path: <sbates130272@gmail.com>
From: sbates@raithlin.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Damien.LeMoal@wdc.com,
	osandov@osandov.com,
	sbates@raithlin.com
Subject: [PATCH 2/2] blk-stat: add a poll_size value to the request_queue struct
Date: Sat, 25 Mar 2017 20:18:12 -0600
Message-Id: <1490494692-2416-3-git-send-email-sbates@raithlin.com>
In-Reply-To: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
References: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

From: Stephen Bates <sbates@raithlin.com>

In order to bucket IO for the polling algorithm we use a sysfs entry
to set the filter value. It is signed and we will use that as follows:

 0   : No filtering. All IO are considered in stat generation
 > 0 : Filtering based on IO of exactly this size only.
 < 0 : Filtering based on IO less than or equal to -1 time this value.

Use this member to implement a new bucket function for the io polling
stats.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 block/blk-mq.c         | 17 +++++++++++++++--
 block/blk-sysfs.c      | 30 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ff66f2..5ea9481 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2327,6 +2327,18 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	blk_mq_sysfs_register(q);
 }
 
+int blk_mq_poll_stats_bucket(const struct request *rq)
+{
+	int val = rq->q->poll_size;
+
+	if ((val == 0) ||
+	    (val > 0 && blk_rq_bytes(rq) == val) ||
+	    (val < 0 && blk_rq_bytes(rq) <= -val))
+		return (int)rq_data_dir(rq);
+
+	return -1;
+}
+
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
@@ -2338,7 +2350,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		goto err_exit;
 
 	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn,
-					     blk_stat_rq_ddir, 2, q);
+					     blk_mq_poll_stats_bucket, 2, q);
 	if (!q->poll_cb)
 		goto err_exit;
 
@@ -2387,9 +2399,10 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->nr_requests = set->queue_depth;
 
 	/*
-	 * Default to classic polling
+	 * Default to classic polling. Default to considering all IO.
 	 */
 	q->poll_nsec = -1;
+	q->poll_size = 0;
 
 	if (set->ops->complete)
 		blk_queue_softirq_done(q, set->ops->complete);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fa831cb..000d5db 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -394,6 +394,29 @@ static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
 	return count;
 }
 
+static ssize_t queue_poll_size_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%d\n", q->poll_size);
+}
+
+static ssize_t queue_poll_size_store(struct request_queue *q, const char *page,
+				     size_t count)
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
+	q->poll_size = val;
+
+	return count;
+}
+
+
 static ssize_t queue_poll_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(test_bit(QUEUE_FLAG_POLL, &q->queue_flags), page);
@@ -654,6 +677,12 @@ static struct queue_sysfs_entry queue_poll_entry = {
 	.store = queue_poll_store,
 };
 
+static struct queue_sysfs_entry queue_poll_size_entry = {
+	.attr = {.name = "io_poll_size", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_poll_size_show,
+	.store = queue_poll_size_store,
+};
+
 static struct queue_sysfs_entry queue_poll_delay_entry = {
 	.attr = {.name = "io_poll_delay", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_poll_delay_show,
@@ -710,6 +739,7 @@ static struct attribute *default_attrs[] = {
 	&queue_dax_entry.attr,
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
+	&queue_poll_size_entry.attr,
 	NULL,
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1a7dc42..7ff5388 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -517,6 +517,7 @@ struct request_queue {
 
 	unsigned int		rq_timeout;
 	int			poll_nsec;
+	int			poll_size;
 
 	struct blk_stat_callback	*poll_cb;
 	struct blk_rq_stat	poll_stat[2];
-- 
2.7.4

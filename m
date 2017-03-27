Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH V7 09/18] blk-throttle: make throtl_slice tunable
Date: Mon, 27 Mar 2017 10:51:37 -0700
Message-ID: <0c1c990f15fff70b4c0a5a50984f3803420db3f3.1490634565.git.shli@fb.com>
In-Reply-To: <cover.1490634565.git.shli@fb.com>
References: <cover.1490634565.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

throtl_slice is important for blk-throttling. It's called slice
internally but it really is a time window blk-throttling samples data.
blk-throttling will make decision based on the samplings. An example is
bandwidth measurement. A cgroup's bandwidth is measured in the time
interval of throtl_slice.

A small throtl_slice meanse cgroups have smoother throughput but burn
more CPUs. It has 100ms default value, which is not appropriate for all
disks. A fast SSD can dispatch a lot of IOs in 100ms. This patch makes
it tunable.

Since throtl_slice isn't a time slice, the sysfs name
'throttle_sample_time' reflects its character better.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 Documentation/block/queue-sysfs.txt |  6 +++
 block/blk-sysfs.c                   | 11 ++++++
 block/blk-throttle.c                | 79 ++++++++++++++++++++++++++-----------
 block/blk.h                         |  5 +++
 4 files changed, 79 insertions(+), 22 deletions(-)

diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index c0a3bb5..b7f6bdc 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -192,5 +192,11 @@ scaling back writes. Writing a value of '0' to this file disables the
 feature. Writing a value of '-1' to this file resets the value to the
 default setting.
 
+throttle_sample_time (RW)
+-------------------------
+This is the time window that blk-throttle samples data, in millisecond.
+blk-throttle makes decision based on the samplings. Lower time means cgroups
+have more smooth throughput, but higher CPU overhead. This exists only when
+CONFIG_BLK_DEV_THROTTLING_LOW is enabled.
 
 Jens Axboe <jens.axboe@oracle.com>, February 2009
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fa831cb..b315e62 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -677,6 +677,14 @@ static struct queue_sysfs_entry queue_wb_lat_entry = {
 	.store = queue_wb_lat_store,
 };
 
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+static struct queue_sysfs_entry throtl_sample_time_entry = {
+	.attr = {.name = "throttle_sample_time", .mode = S_IRUGO | S_IWUSR },
+	.show = blk_throtl_sample_time_show,
+	.store = blk_throtl_sample_time_store,
+};
+#endif
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -710,6 +718,9 @@ static struct attribute *default_attrs[] = {
 	&queue_dax_entry.attr,
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+	&throtl_sample_time_entry.attr,
+#endif
 	NULL,
 };
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2073b48..93841da 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -19,7 +19,8 @@ static int throtl_grp_quantum = 8;
 static int throtl_quantum = 32;
 
 /* Throttling is performed over 100ms slice and after that slice is renewed */
-static unsigned long throtl_slice = HZ/10;	/* 100 ms */
+#define DFL_THROTL_SLICE (HZ / 10)
+#define MAX_THROTL_SLICE (HZ)
 
 static struct blkcg_policy blkcg_policy_throtl;
 
@@ -162,6 +163,8 @@ struct throtl_data
 	/* Total Number of queued bios on READ and WRITE lists */
 	unsigned int nr_queued[2];
 
+	unsigned int throtl_slice;
+
 	/* Work for dispatching throttled bios */
 	struct work_struct dispatch_work;
 	unsigned int limit_index;
@@ -590,7 +593,7 @@ static void throtl_dequeue_tg(struct throtl_grp *tg)
 static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
 					  unsigned long expires)
 {
-	unsigned long max_expire = jiffies + 8 * throtl_slice;
+	unsigned long max_expire = jiffies + 8 * sq_to_tg(sq)->td->throtl_slice;
 
 	/*
 	 * Since we are adjusting the throttle limit dynamically, the sleep
@@ -658,7 +661,7 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 	if (time_after_eq(start, tg->slice_start[rw]))
 		tg->slice_start[rw] = start;
 
-	tg->slice_end[rw] = jiffies + throtl_slice;
+	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice with credit start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', tg->slice_start[rw],
@@ -670,7 +673,7 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
 	tg->slice_start[rw] = jiffies;
-	tg->slice_end[rw] = jiffies + throtl_slice;
+	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', tg->slice_start[rw],
@@ -680,13 +683,13 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
 static inline void throtl_set_slice_end(struct throtl_grp *tg, bool rw,
 					unsigned long jiffy_end)
 {
-	tg->slice_end[rw] = roundup(jiffy_end, throtl_slice);
+	tg->slice_end[rw] = roundup(jiffy_end, tg->td->throtl_slice);
 }
 
 static inline void throtl_extend_slice(struct throtl_grp *tg, bool rw,
 				       unsigned long jiffy_end)
 {
-	tg->slice_end[rw] = roundup(jiffy_end, throtl_slice);
+	tg->slice_end[rw] = roundup(jiffy_end, tg->td->throtl_slice);
 	throtl_log(&tg->service_queue,
 		   "[%c] extend slice start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', tg->slice_start[rw],
@@ -726,19 +729,20 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	 * is bad because it does not allow new slice to start.
 	 */
 
-	throtl_set_slice_end(tg, rw, jiffies + throtl_slice);
+	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
 
 	time_elapsed = jiffies - tg->slice_start[rw];
 
-	nr_slices = time_elapsed / throtl_slice;
+	nr_slices = time_elapsed / tg->td->throtl_slice;
 
 	if (!nr_slices)
 		return;
-	tmp = tg_bps_limit(tg, rw) * throtl_slice * nr_slices;
+	tmp = tg_bps_limit(tg, rw) * tg->td->throtl_slice * nr_slices;
 	do_div(tmp, HZ);
 	bytes_trim = tmp;
 
-	io_trim = (tg_iops_limit(tg, rw) * throtl_slice * nr_slices) / HZ;
+	io_trim = (tg_iops_limit(tg, rw) * tg->td->throtl_slice * nr_slices) /
+		HZ;
 
 	if (!bytes_trim && !io_trim)
 		return;
@@ -753,7 +757,7 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	else
 		tg->io_disp[rw] = 0;
 
-	tg->slice_start[rw] += nr_slices * throtl_slice;
+	tg->slice_start[rw] += nr_slices * tg->td->throtl_slice;
 
 	throtl_log(&tg->service_queue,
 		   "[%c] trim slice nr=%lu bytes=%llu io=%lu start=%lu end=%lu jiffies=%lu",
@@ -773,9 +777,9 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Slice has just started. Consider one slice interval */
 	if (!jiffy_elapsed)
-		jiffy_elapsed_rnd = throtl_slice;
+		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, throtl_slice);
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
 
 	/*
 	 * jiffy_elapsed_rnd should not be a big value as minimum iops can be
@@ -822,9 +826,9 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Slice has just started. Consider one slice interval */
 	if (!jiffy_elapsed)
-		jiffy_elapsed_rnd = throtl_slice;
+		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, throtl_slice);
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
 
 	tmp = tg_bps_limit(tg, rw) * jiffy_elapsed_rnd;
 	do_div(tmp, HZ);
@@ -890,8 +894,10 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
 		throtl_start_new_slice(tg, rw);
 	else {
-		if (time_before(tg->slice_end[rw], jiffies + throtl_slice))
-			throtl_extend_slice(tg, rw, jiffies + throtl_slice);
+		if (time_before(tg->slice_end[rw],
+		    jiffies + tg->td->throtl_slice))
+			throtl_extend_slice(tg, rw,
+				jiffies + tg->td->throtl_slice);
 	}
 
 	if (tg_with_in_bps_limit(tg, bio, &bps_wait) &&
@@ -1632,7 +1638,7 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 	if (td->limit_index != LIMIT_LOW)
 		return false;
 
-	if (time_before(jiffies, td->low_downgrade_time + throtl_slice))
+	if (time_before(jiffies, td->low_downgrade_time + td->throtl_slice))
 		return false;
 
 	rcu_read_lock();
@@ -1689,8 +1695,9 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
 	 * If cgroup is below low limit, consider downgrade and throttle other
 	 * cgroups
 	 */
-	if (time_after_eq(now, td->low_upgrade_time + throtl_slice) &&
-	    time_after_eq(now, tg_last_low_overflow_time(tg) + throtl_slice))
+	if (time_after_eq(now, td->low_upgrade_time + td->throtl_slice) &&
+	    time_after_eq(now, tg_last_low_overflow_time(tg) +
+					td->throtl_slice))
 		return true;
 	return false;
 }
@@ -1719,13 +1726,14 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 		return;
 	if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children))
 		return;
-	if (time_after(tg->last_check_time + throtl_slice, now))
+	if (time_after(tg->last_check_time + tg->td->throtl_slice, now))
 		return;
 
 	elapsed_time = now - tg->last_check_time;
 	tg->last_check_time = now;
 
-	if (time_before(now, tg_last_low_overflow_time(tg) + throtl_slice))
+	if (time_before(now, tg_last_low_overflow_time(tg) +
+			tg->td->throtl_slice))
 		return;
 
 	if (tg->bps[READ][LIMIT_LOW]) {
@@ -1953,6 +1961,7 @@ int blk_throtl_init(struct request_queue *q)
 
 	q->td = td;
 	td->queue = q;
+	td->throtl_slice = DFL_THROTL_SLICE;
 
 	td->limit_valid[LIMIT_MAX] = true;
 	td->limit_index = LIMIT_MAX;
@@ -1973,6 +1982,32 @@ void blk_throtl_exit(struct request_queue *q)
 	kfree(q->td);
 }
 
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page)
+{
+	if (!q->td)
+		return -EINVAL;
+	return sprintf(page, "%u\n", jiffies_to_msecs(q->td->throtl_slice));
+}
+
+ssize_t blk_throtl_sample_time_store(struct request_queue *q,
+	const char *page, size_t count)
+{
+	unsigned long v;
+	unsigned long t;
+
+	if (!q->td)
+		return -EINVAL;
+	if (kstrtoul(page, 10, &v))
+		return -EINVAL;
+	t = msecs_to_jiffies(v);
+	if (t == 0 || t > MAX_THROTL_SLICE)
+		return -EINVAL;
+	q->td->throtl_slice = t;
+	return count;
+}
+#endif
+
 static int __init throtl_init(void)
 {
 	kthrotld_workqueue = alloc_workqueue("kthrotld", WQ_MEM_RECLAIM, 0);
diff --git a/block/blk.h b/block/blk.h
index d1ea4bd9..bcd3de6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -324,5 +324,10 @@ static inline void blk_throtl_drain(struct request_queue *q) { }
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
+extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
+	const char *page, size_t count);
+#endif
 
 #endif /* BLK_INTERNAL_H */
-- 
2.9.3

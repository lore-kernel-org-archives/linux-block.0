Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43053 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752150AbcJCVUg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 17:20:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.17/8.16.0.17) with SMTP id u93LGc8o024552
        for <linux-block@vger.kernel.org>; Mon, 3 Oct 2016 14:20:35 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 25t8tbef39-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2016 14:20:35 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.223.101.97) with ESMTP id
 37ad4f7889af11e68fdf24be0595f910-daff9a50 for <linux-block@vger.kernel.org>;
        Mon, 03 Oct 2016 14:20:33 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH v3 07/11] blk-throttle: make throtl_slice tunable
Date: Mon, 3 Oct 2016 14:20:26 -0700
Message-ID: <6aa14e81082a403fd54c6f17b2f35798a056144d.1475529372.git.shli@fb.com>
In-Reply-To: <cover.1475529372.git.shli@fb.com>
References: <cover.1475529372.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

throtl_slice is important for blk-throttling. A lot of stuffes depend on
it, for example, throughput measurement. It has 100ms default value,
which is not appropriate for all disks. For example, for SSD we might
use a smaller value to make the throughput smoother. This patch makes it
tunable.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-sysfs.c    | 11 ++++++++
 block/blk-throttle.c | 72 ++++++++++++++++++++++++++++++++++++----------------
 block/blk.h          |  3 +++
 3 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f87a7e7..610f08d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -526,6 +526,14 @@ static struct queue_sysfs_entry queue_dax_entry = {
 	.show = queue_dax_show,
 };
 
+#ifdef CONFIG_BLK_DEV_THROTTLING
+static struct queue_sysfs_entry throtl_slice_entry = {
+	.attr = {.name = "throttling_slice", .mode = S_IRUGO | S_IWUSR },
+	.show = blk_throtl_slice_show,
+	.store = blk_throtl_slice_store,
+};
+#endif
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -553,6 +561,9 @@ static struct attribute *default_attrs[] = {
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
 	&queue_dax_entry.attr,
+#ifdef CONFIG_BLK_DEV_THROTTLING
+	&throtl_slice_entry.attr,
+#endif
 	NULL,
 };
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 778de0b..4263f0c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -19,7 +19,8 @@ static int throtl_grp_quantum = 8;
 static int throtl_quantum = 32;
 
 /* Throttling is performed over 100ms slice and after that slice is renewed */
-static unsigned long throtl_slice = HZ/10;	/* 100 ms */
+#define DFL_THROTL_SLICE (HZ / 10)
+#define MAX_THROTL_SLICE (HZ / 5)
 
 static struct blkcg_policy blkcg_policy_throtl;
 
@@ -158,6 +159,8 @@ struct throtl_data
 	/* Total Number of queued bios on READ and WRITE lists */
 	unsigned int nr_queued[2];
 
+	unsigned int throtl_slice;
+
 	/* Work for dispatching throttled bios */
 	struct work_struct dispatch_work;
 	unsigned int limit_index;
@@ -589,7 +592,7 @@ static void throtl_dequeue_tg(struct throtl_grp *tg)
 static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
 					  unsigned long expires)
 {
-	unsigned long max_expire = jiffies + 8 * throtl_slice;
+	unsigned long max_expire = jiffies + 8 * sq_to_tg(sq)->td->throtl_slice;
 	if (time_after(expires, max_expire))
 		expires = max_expire;
 	mod_timer(&sq->pending_timer, expires);
@@ -649,7 +652,7 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 	if (time_after_eq(start, tg->slice_start[rw]))
 		tg->slice_start[rw] = start;
 
-	tg->slice_end[rw] = jiffies + throtl_slice;
+	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice with credit start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', tg->slice_start[rw],
@@ -661,7 +664,7 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
 	tg->bytes_disp[rw] = 0;
 	tg->io_disp[rw] = 0;
 	tg->slice_start[rw] = jiffies;
-	tg->slice_end[rw] = jiffies + throtl_slice;
+	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', tg->slice_start[rw],
@@ -671,13 +674,13 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
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
@@ -717,19 +720,19 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
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
 
-	io_trim = (tg_iops_limit(tg, rw) * throtl_slice * nr_slices)/HZ;
+	io_trim = (tg_iops_limit(tg, rw) * tg->td->throtl_slice * nr_slices)/HZ;
 
 	if (!bytes_trim && !io_trim)
 		return;
@@ -744,7 +747,7 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	else
 		tg->io_disp[rw] = 0;
 
-	tg->slice_start[rw] += nr_slices * throtl_slice;
+	tg->slice_start[rw] += nr_slices * tg->td->throtl_slice;
 
 	throtl_log(&tg->service_queue,
 		   "[%c] trim slice nr=%lu bytes=%llu io=%lu start=%lu end=%lu jiffies=%lu",
@@ -764,9 +767,9 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Slice has just started. Consider one slice interval */
 	if (!jiffy_elapsed)
-		jiffy_elapsed_rnd = throtl_slice;
+		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, throtl_slice);
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
 
 	/*
 	 * jiffy_elapsed_rnd should not be a big value as minimum iops can be
@@ -813,9 +816,9 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Slice has just started. Consider one slice interval */
 	if (!jiffy_elapsed)
-		jiffy_elapsed_rnd = throtl_slice;
+		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, throtl_slice);
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
 
 	tmp = tg_bps_limit(tg, rw) * jiffy_elapsed_rnd;
 	do_div(tmp, HZ);
@@ -880,8 +883,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
 		throtl_start_new_slice(tg, rw);
 	else {
-		if (time_before(tg->slice_end[rw], jiffies + throtl_slice))
-			throtl_extend_slice(tg, rw, jiffies + throtl_slice);
+		if (time_before(tg->slice_end[rw], jiffies + tg->td->throtl_slice))
+			throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
 	}
 
 	if (tg_with_in_bps_limit(tg, bio, &bps_wait) &&
@@ -1630,7 +1633,7 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 	if (td->limit_index != LIMIT_HIGH)
 		return false;
 
-	if (time_before(jiffies, td->high_downgrade_time + throtl_slice))
+	if (time_before(jiffies, td->high_downgrade_time + td->throtl_slice))
 		return false;
 
 	rcu_read_lock();
@@ -1687,8 +1690,8 @@ static bool throtl_downgrade_check_one(struct throtl_grp *tg)
 	 * If cgroup is below high limit, consider downgrade and throttle other
 	 * cgroups
 	 */
-	if (time_after_eq(now, td->high_upgrade_time + throtl_slice) &&
-	    time_after_eq(now, tg_last_high_overflow_time(tg) + throtl_slice))
+	if (time_after_eq(now, td->high_upgrade_time + td->throtl_slice) &&
+	    time_after_eq(now, tg_last_high_overflow_time(tg) + td->throtl_slice))
 		return true;
 	return false;
 }
@@ -1721,10 +1724,10 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 		return;
 	if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children))
 		return;
-	if (time_after(tg->last_check_time + throtl_slice, now))
+	if (time_after(tg->last_check_time + tg->td->throtl_slice, now))
 		return;
 
-	if (time_before(now, tg_last_high_overflow_time(tg) + throtl_slice))
+	if (time_before(now, tg_last_high_overflow_time(tg) + tg->td->throtl_slice))
 		return;
 
 	elapsed_time = now - tg->last_check_time;
@@ -1962,6 +1965,7 @@ int blk_throtl_init(struct request_queue *q)
 
 	q->td = td;
 	td->queue = q;
+	td->throtl_slice = DFL_THROTL_SLICE;
 
 	td->limit_valid[LIMIT_HIGH] = false;
 	td->limit_valid[LIMIT_MAX] = true;
@@ -1983,6 +1987,30 @@ void blk_throtl_exit(struct request_queue *q)
 	kfree(q->td);
 }
 
+ssize_t blk_throtl_slice_show(struct request_queue *q, char *page)
+{
+	if (!q->td)
+		return -EINVAL;
+	return sprintf(page, "%ums\n", jiffies_to_msecs(q->td->throtl_slice));
+}
+
+ssize_t blk_throtl_slice_store(struct request_queue *q,
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
+
 static int __init throtl_init(void)
 {
 	kthrotld_workqueue = alloc_workqueue("kthrotld", WQ_MEM_RECLAIM, 0);
diff --git a/block/blk.h b/block/blk.h
index c37492f..8ad6068 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -294,6 +294,9 @@ static inline struct io_context *create_io_context(gfp_t gfp_mask, int node)
 extern void blk_throtl_drain(struct request_queue *q);
 extern int blk_throtl_init(struct request_queue *q);
 extern void blk_throtl_exit(struct request_queue *q);
+extern ssize_t blk_throtl_slice_show(struct request_queue *q, char *page);
+extern ssize_t blk_throtl_slice_store(struct request_queue *q,
+	const char *page, size_t count);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline void blk_throtl_drain(struct request_queue *q) { }
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
-- 
2.9.3


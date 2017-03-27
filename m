Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH V7 13/18] blk-throttle: add a simple idle detection
Date: Mon, 27 Mar 2017 10:51:41 -0700
Message-ID: <1723d61e9a4ee905b5c9b7c04e66b430b992f360.1490634565.git.shli@fb.com>
In-Reply-To: <cover.1490634565.git.shli@fb.com>
References: <cover.1490634565.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

A cgroup gets assigned a low limit, but the cgroup could never dispatch
enough IO to cross the low limit. In such case, the queue state machine
will remain in LIMIT_LOW state and all other cgroups will be throttled
according to low limit. This is unfair for other cgroups. We should
treat the cgroup idle and upgrade the state machine to lower state.

We also have a downgrade logic. If the state machine upgrades because of
cgroup idle (real idle), the state machine will downgrade soon as the
cgroup is below its low limit. This isn't what we want. A more
complicated case is cgroup isn't idle when queue is in LIMIT_LOW. But
when queue gets upgraded to lower state, other cgroups could dispatch
more IO and this cgroup can't dispatch enough IO, so the cgroup is below
its low limit and looks like idle (fake idle). In this case, the queue
should downgrade soon. The key to determine if we should do downgrade is
to detect if cgroup is truely idle.

Unfortunately it's very hard to determine if a cgroup is real idle. This
patch uses the 'think time check' idea from CFQ for the purpose. Please
note, the idea doesn't work for all workloads. For example, a workload
with io depth 8 has disk utilization 100%, hence think time is 0, eg,
not idle. But the workload can run higher bandwidth with io depth 16.
Compared to io depth 16, the io depth 8 workload is idle. We use the
idea to roughly determine if a cgroup is idle.

We treat a cgroup idle if its think time is above a threshold (by
default 1ms for SSD and 100ms for HD). The idea is think time above the
threshold will start to harm performance. HD is much slower so a longer
think time is ok.

The patch (and the latter patches) uses 'unsigned long' to track time.
We convert 'ns' to 'us' with 'ns >> 10'. This is fast but loses
precision, should not a big deal.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c               |  2 ++
 block/blk-throttle.c      | 82 ++++++++++++++++++++++++++++++++++++++++++++++-
 block/blk.h               |  3 ++
 include/linux/blk_types.h |  3 ++
 4 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 6194a8c..f1857c0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -30,6 +30,7 @@
 #include <linux/cgroup.h>
 
 #include <trace/events/block.h>
+#include "blk.h"
 
 /*
  * Test patch to inline a certain number of bi_io_vec's inside the bio
@@ -1845,6 +1846,7 @@ void bio_endio(struct bio *bio)
 		goto again;
 	}
 
+	blk_throtl_bio_endio(bio);
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 62984fc..6300f3e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -22,6 +22,9 @@ static int throtl_quantum = 32;
 #define DFL_THROTL_SLICE_HD (HZ / 10)
 #define DFL_THROTL_SLICE_SSD (HZ / 50)
 #define MAX_THROTL_SLICE (HZ)
+#define DFL_IDLE_THRESHOLD_SSD (1000L) /* 1 ms */
+#define DFL_IDLE_THRESHOLD_HD (100L * 1000) /* 100 ms */
+#define MAX_IDLE_TIME (5L * 1000 * 1000) /* 5 s */
 
 static struct blkcg_policy blkcg_policy_throtl;
 
@@ -154,6 +157,11 @@ struct throtl_grp {
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
+
+	unsigned long last_finish_time; /* ns / 1024 */
+	unsigned long checked_last_finish_time; /* ns / 1024 */
+	unsigned long avg_idletime; /* ns / 1024 */
+	unsigned long idletime_threshold; /* us */
 };
 
 struct throtl_data
@@ -468,6 +476,11 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && blkg->parent)
 		sq->parent_sq = &blkg_to_tg(blkg->parent)->service_queue;
 	tg->td = td;
+
+	if (blk_queue_nonrot(td->queue))
+		tg->idletime_threshold = DFL_IDLE_THRESHOLD_SSD;
+	else
+		tg->idletime_threshold = DFL_IDLE_THRESHOLD_HD;
 }
 
 /*
@@ -1644,6 +1657,21 @@ static unsigned long tg_last_low_overflow_time(struct throtl_grp *tg)
 	return ret;
 }
 
+static bool throtl_tg_is_idle(struct throtl_grp *tg)
+{
+	/*
+	 * cgroup is idle if:
+	 * - single idle is too long, longer than a fixed value (in case user
+	 *   configure a too big threshold) or 4 times of slice
+	 * - average think time is more than threshold
+	 */
+	unsigned long time = jiffies_to_usecs(4 * tg->td->throtl_slice);
+
+	time = min_t(unsigned long, MAX_IDLE_TIME, time);
+	return (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
+	       tg->avg_idletime > tg->idletime_threshold;
+}
+
 static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
@@ -1843,6 +1871,19 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 	tg->last_io_disp[WRITE] = 0;
 }
 
+static void blk_throtl_update_idletime(struct throtl_grp *tg)
+{
+	unsigned long now = ktime_get_ns() >> 10;
+	unsigned long last_finish_time = tg->last_finish_time;
+
+	if (now <= last_finish_time || last_finish_time == 0 ||
+	    last_finish_time == tg->checked_last_finish_time)
+		return;
+
+	tg->avg_idletime = (tg->avg_idletime * 7 + now - last_finish_time) >> 3;
+	tg->checked_last_finish_time = last_finish_time;
+}
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -1851,6 +1892,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	struct throtl_service_queue *sq;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
+	int ret;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
@@ -1863,6 +1905,13 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
+	ret = bio_associate_current(bio);
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+	if (ret == 0 || ret == -EBUSY)
+		bio->bi_cg_private = tg;
+#endif
+	blk_throtl_update_idletime(tg);
+
 	sq = &tg->service_queue;
 
 again:
@@ -1923,7 +1972,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	tg->last_low_overflow_time[rw] = jiffies;
 
-	bio_associate_current(bio);
 	tg->td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
 	throttled = true;
@@ -1952,6 +2000,20 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	return throttled;
 }
 
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+void blk_throtl_bio_endio(struct bio *bio)
+{
+	struct throtl_grp *tg;
+
+	tg = bio->bi_cg_private;
+	if (!tg)
+		return;
+	bio->bi_cg_private = NULL;
+
+	tg->last_finish_time = ktime_get_ns() >> 10;
+}
+#endif
+
 /*
  * Dispatch all bios from all children tg's queued on @parent_sq.  On
  * return, @parent_sq is guaranteed to not have any active children tg's
@@ -2035,6 +2097,7 @@ int blk_throtl_init(struct request_queue *q)
 	td->limit_index = LIMIT_MAX;
 	td->low_upgrade_time = jiffies;
 	td->low_downgrade_time = jiffies;
+
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
@@ -2053,6 +2116,8 @@ void blk_throtl_exit(struct request_queue *q)
 void blk_throtl_register_queue(struct request_queue *q)
 {
 	struct throtl_data *td;
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
 
 	td = q->td;
 	BUG_ON(!td);
@@ -2065,6 +2130,21 @@ void blk_throtl_register_queue(struct request_queue *q)
 	/* if no low limit, use previous default */
 	td->throtl_slice = DFL_THROTL_SLICE_HD;
 #endif
+
+	/*
+	 * some tg are created before queue is fully initialized, eg, nonrot
+	 * isn't initialized yet
+	 */
+	rcu_read_lock();
+	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+
+		if (blk_queue_nonrot(q))
+			tg->idletime_threshold = DFL_IDLE_THRESHOLD_SSD;
+		else
+			tg->idletime_threshold = DFL_IDLE_THRESHOLD_HD;
+	}
+	rcu_read_unlock();
 }
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
diff --git a/block/blk.h b/block/blk.h
index 13070c3..3ac833e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -330,6 +330,9 @@ static inline void blk_throtl_register_queue(struct request_queue *q) { }
 extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
 extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
 	const char *page, size_t count);
+extern void blk_throtl_bio_endio(struct bio *bio);
+#else
+static inline void blk_throtl_bio_endio(struct bio *bio) { }
 #endif
 
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 270119a..07a9e96 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -58,6 +58,9 @@ struct bio {
 	 */
 	struct io_context	*bi_ioc;
 	struct cgroup_subsys_state *bi_css;
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+	void			*bi_cg_private;
+#endif
 #endif
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-- 
2.9.3

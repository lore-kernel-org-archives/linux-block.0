Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47695 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756327AbcLOUdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:17 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFKVvOR023892
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:11 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 27bdne5btm-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:11 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.97) with ESMTP  id
 b1013ec2c30511e6b7880002c9931860-7bff7a50 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:09 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 11/17] blk-throttle: add a simple idle detection
Date: Thu, 15 Dec 2016 12:33:02 -0800
Message-ID: <b2a4b3d57a248e406a8687bbe2cce6f37c1b0749.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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
default 50us for SSD and 1ms for HD). The idea is think time above the
threshold will start to harm performance. HD is much slower so a longer
think time is ok.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c               |  2 ++
 block/blk-throttle.c      | 65 ++++++++++++++++++++++++++++++++++++++++++++++-
 block/blk.h               |  2 ++
 include/linux/blk_types.h |  1 +
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 2b37502..948ebc1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -30,6 +30,7 @@
 #include <linux/cgroup.h>
 
 #include <trace/events/block.h>
+#include "blk.h"
 
 /*
  * Test patch to inline a certain number of bi_io_vec's inside the bio
@@ -1813,6 +1814,7 @@ void bio_endio(struct bio *bio)
 		goto again;
 	}
 
+	blk_throtl_bio_endio(bio);
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6b2f365..3cd8400 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -21,6 +21,9 @@ static int throtl_quantum = 32;
 /* Throttling is performed over 100ms slice and after that slice is renewed */
 #define DFL_THROTL_SLICE (HZ / 10)
 #define MAX_THROTL_SLICE (HZ / 5)
+#define DFL_IDLE_THRESHOLD_SSD (50 * 1000) /* 50 us */
+#define DFL_IDLE_THRESHOLD_HD (1000 * 1000) /* 1 ms */
+#define MAX_IDLE_TIME (500L * 1000 * 1000) /* 500 ms */
 
 static struct blkcg_policy blkcg_policy_throtl;
 
@@ -153,6 +156,11 @@ struct throtl_grp {
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
+
+	u64 last_finish_time;
+	u64 checked_last_finish_time;
+	u64 avg_ttime;
+	u64 idle_ttime_threshold;
 };
 
 struct throtl_data
@@ -428,6 +436,7 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 			tg->iops_conf[rw][index] = UINT_MAX;
 		}
 	}
+	tg->idle_ttime_threshold = U64_MAX;
 
 	return &tg->pd;
 }
@@ -1607,6 +1616,20 @@ static unsigned long tg_last_low_overflow_time(struct throtl_grp *tg)
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
+	u64 time = (u64)jiffies_to_usecs(4 * tg->td->throtl_slice) * 1000;
+	time = min_t(u64, MAX_IDLE_TIME, time);
+	return ktime_get_ns() - tg->last_finish_time > time ||
+	       tg->avg_ttime > tg->idle_ttime_threshold;
+}
+
 static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
@@ -1808,6 +1831,19 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 	tg->last_io_disp[WRITE] = 0;
 }
 
+static void blk_throtl_update_ttime(struct throtl_grp *tg)
+{
+	u64 now = ktime_get_ns();
+	u64 last_finish_time = tg->last_finish_time;
+
+	if (now <= last_finish_time || last_finish_time == 0 ||
+	    last_finish_time == tg->checked_last_finish_time)
+		return;
+
+	tg->avg_ttime = (tg->avg_ttime * 7 + now - last_finish_time) >> 3;
+	tg->checked_last_finish_time = last_finish_time;
+}
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -1816,9 +1852,18 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	struct throtl_service_queue *sq;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
+	int ret;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
+	/* nonrot bit isn't set in queue creation */
+	if (tg->idle_ttime_threshold == U64_MAX) {
+		if (blk_queue_nonrot(q))
+			tg->idle_ttime_threshold = DFL_IDLE_THRESHOLD_SSD;
+		else
+			tg->idle_ttime_threshold = DFL_IDLE_THRESHOLD_HD;
+	}
+
 	/* see throtl_charge_bio() */
 	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
 		goto out;
@@ -1828,6 +1873,12 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
+	ret = bio_associate_current(bio);
+	if (ret == 0 || ret == -EBUSY)
+		bio->bi_cg_private = tg;
+
+	blk_throtl_update_ttime(tg);
+
 	sq = &tg->service_queue;
 
 again:
@@ -1888,7 +1939,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	tg->last_low_overflow_time[rw] = jiffies;
 
-	bio_associate_current(bio);
 	tg->td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
 	throttled = true;
@@ -1917,6 +1967,18 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	return throttled;
 }
 
+void blk_throtl_bio_endio(struct bio *bio)
+{
+	struct throtl_grp *tg;
+
+	tg = bio->bi_cg_private;
+	if (!tg)
+		return;
+	bio->bi_cg_private = NULL;
+
+	tg->last_finish_time = ktime_get_ns();
+}
+
 /*
  * Dispatch all bios from all children tg's queued on @parent_sq.  On
  * return, @parent_sq is guaranteed to not have any active children tg's
@@ -2001,6 +2063,7 @@ int blk_throtl_init(struct request_queue *q)
 	td->limit_index = LIMIT_MAX;
 	td->low_upgrade_time = jiffies;
 	td->low_downgrade_time = jiffies;
+
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
diff --git a/block/blk.h b/block/blk.h
index e83e757..921d04f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -293,10 +293,12 @@ extern void blk_throtl_exit(struct request_queue *q);
 extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
 extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
 	const char *page, size_t count);
+extern void blk_throtl_bio_endio(struct bio *bio);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline void blk_throtl_drain(struct request_queue *q) { }
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
+static inline void blk_throtl_bio_endio(struct bio *bio) { }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 519ea2c..01019a7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -58,6 +58,7 @@ struct bio {
 	 */
 	struct io_context	*bi_ioc;
 	struct cgroup_subsys_state *bi_css;
+	void			*bi_cg_private;
 #endif
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-- 
2.9.3


Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36738 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751918AbcIOQXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 12:23:24 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8FGF2r3017717
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:23 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 25fxan8jew-9
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:23 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)     by
 mx-out.facebook.com (10.223.101.97) with ESMTP id
 b75b4f2a7b6011e681d924be0595f910-198f1a50 for <linux-block@vger.kernel.org>;
        Thu, 15 Sep 2016 09:23:20 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH V2 10/11] block-throttle: add a simple idle detection
Date: Thu, 15 Sep 2016 09:23:17 -0700
Message-ID: <82a4ce97db9eef0ad9d74c86dfde75d7afbeaa2b.1473953743.git.shli@fb.com>
In-Reply-To: <cover.1473953743.git.shli@fb.com>
References: <cover.1473953743.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A cgroup gets assigned a high limit, but the cgroup could never dispatch
enough IO to cross the high limit. In such case, the queue state machine
will remain in LIMIT_HIGH state and all other cgroups will be throttled
according to high limit. This is unfair for other cgroups. We should
treat the cgroup idle and upgrade the state machine to higher state.

We also have a downgrade logic. If the state machine upgrades because of
cgroup idle (real idle), the state machine will downgrade soon as the
cgroup is below its high limit. This isn't what we want. A more
complicated case is cgroup isn't idle when queue is in LIMIT_HIGH. But
when queue gets upgraded to higher state, other cgroups could dispatch
more IO and this cgroup can't dispatch enough IO, so the cgroup is below
its high limit and looks like idle (fake idle). In this case, the queue
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
default 50us). 50us is choosen arbitrarily so far, but seems ok in
test and should allow the cpu does a lot of things before dispatch IO.
There is a knob to let user configure the threshold too.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c               |  2 ++
 block/blk-sysfs.c         |  7 ++++
 block/blk-throttle.c      | 86 ++++++++++++++++++++++++++++++++++++++++++++++-
 block/blk.h               |  6 ++++
 include/linux/blk_types.h |  1 +
 5 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index aa73540..06e414c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -30,6 +30,7 @@
 #include <linux/cgroup.h>
 
 #include <trace/events/block.h>
+#include "blk.h"
 
 /*
  * Test patch to inline a certain number of bi_io_vec's inside the bio
@@ -1758,6 +1759,7 @@ void bio_endio(struct bio *bio)
 		goto again;
 	}
 
+	blk_throtl_bio_endio(bio);
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 610f08d..209b67c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -532,6 +532,12 @@ static struct queue_sysfs_entry throtl_slice_entry = {
 	.show = blk_throtl_slice_show,
 	.store = blk_throtl_slice_store,
 };
+
+static struct queue_sysfs_entry throtl_idle_threshold_entry = {
+	.attr = {.name = "throttling_idle_threshold", .mode = S_IRUGO | S_IWUSR },
+	.show = blk_throtl_idle_threshold_show,
+	.store = blk_throtl_idle_threshold_store,
+};
 #endif
 
 static struct attribute *default_attrs[] = {
@@ -563,6 +569,7 @@ static struct attribute *default_attrs[] = {
 	&queue_dax_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING
 	&throtl_slice_entry.attr,
+	&throtl_idle_threshold_entry.attr,
 #endif
 	NULL,
 };
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d956831..0810e1b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -21,6 +21,7 @@ static int throtl_quantum = 32;
 /* Throttling is performed over 100ms slice and after that slice is renewed */
 #define DFL_THROTL_SLICE (HZ / 10)
 #define MAX_THROTL_SLICE (HZ / 5)
+#define DFL_IDLE_THRESHOLD (50 * 1000)
 
 static struct blkcg_policy blkcg_policy_throtl;
 
@@ -149,6 +150,10 @@ struct throtl_grp {
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
+
+	u64 last_finish_time;
+	u64 checked_last_finish_time;
+	u64 avg_ttime;
 };
 
 struct throtl_data
@@ -172,6 +177,8 @@ struct throtl_data
 	unsigned long high_downgrade_time;
 
 	unsigned int scale;
+
+	u64 idle_ttime_threshold;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -1624,6 +1631,14 @@ static unsigned long tg_last_high_overflow_time(struct throtl_grp *tg)
 	return ret;
 }
 
+static bool throtl_tg_is_idle(struct throtl_grp *tg)
+{
+	/* cgroup is idle if average think time is more than 50us */
+	return ktime_get_ns() - tg->last_finish_time >
+		4 * tg->td->idle_ttime_threshold ||
+	       tg->avg_ttime > tg->td->idle_ttime_threshold;
+}
+
 static bool throtl_upgrade_check_one(struct throtl_grp *tg)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
@@ -1828,6 +1843,19 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
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
+	tg->avg_ttime = (tg->avg_ttime * 31 + now - last_finish_time) >> 5;
+	tg->checked_last_finish_time = last_finish_time;
+}
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -1848,6 +1876,11 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
+	bio_associate_current(bio);
+	bio->bi_cg_private = q;
+
+	blk_throtl_update_ttime(tg);
+
 	sq = &tg->service_queue;
 
 again:
@@ -1907,7 +1940,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	tg->last_high_overflow_time[rw] = jiffies;
 
-	bio_associate_current(bio);
 	tg->td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
 	throttled = true;
@@ -1936,6 +1968,34 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	return throttled;
 }
 
+void blk_throtl_bio_endio(struct bio *bio)
+{
+	struct blkcg *blkcg;
+	struct blkcg_gq *blkg;
+	struct throtl_grp *tg;
+	struct request_queue *q;
+
+	q = bio->bi_cg_private;
+	if (!q)
+		return;
+	bio->bi_cg_private = NULL;
+
+	rcu_read_lock();
+	blkcg = bio_blkcg(bio);
+	if (!blkcg)
+		goto end;
+	blkg = blkg_lookup(blkcg, q);
+	if (!blkg)
+		goto end;
+
+	tg = blkg_to_tg(blkg ?: q->root_blkg);
+
+	tg->last_finish_time = ktime_get_ns();
+
+end:
+	rcu_read_unlock();
+}
+
 /*
  * Dispatch all bios from all children tg's queued on @parent_sq.  On
  * return, @parent_sq is guaranteed to not have any active children tg's
@@ -2021,6 +2081,8 @@ int blk_throtl_init(struct request_queue *q)
 	td->limit_index = LIMIT_MAX;
 	td->high_upgrade_time = jiffies;
 	td->high_downgrade_time = jiffies;
+
+	td->idle_ttime_threshold = DFL_IDLE_THRESHOLD;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
@@ -2060,6 +2122,28 @@ ssize_t blk_throtl_slice_store(struct request_queue *q,
 	return count;
 }
 
+ssize_t blk_throtl_idle_threshold_show(struct request_queue *q, char *page)
+{
+	if (!q->td)
+		return -EINVAL;
+	return sprintf(page, "%lluus\n", q->td->idle_ttime_threshold / 1000);
+}
+
+ssize_t blk_throtl_idle_threshold_store(struct request_queue *q,
+	const char *page, size_t count)
+{
+	unsigned long v;
+
+	if (!q->td)
+		return -EINVAL;
+	if (kstrtoul(page, 10, &v))
+		return -EINVAL;
+	if (v == 0)
+		return -EINVAL;
+	q->td->idle_ttime_threshold = v * 1000;
+	return count;
+}
+
 static int __init throtl_init(void)
 {
 	kthrotld_workqueue = alloc_workqueue("kthrotld", WQ_MEM_RECLAIM, 0);
diff --git a/block/blk.h b/block/blk.h
index 8ad6068..8e1aeca 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -297,10 +297,16 @@ extern void blk_throtl_exit(struct request_queue *q);
 extern ssize_t blk_throtl_slice_show(struct request_queue *q, char *page);
 extern ssize_t blk_throtl_slice_store(struct request_queue *q,
 	const char *page, size_t count);
+extern ssize_t blk_throtl_idle_threshold_show(struct request_queue *q,
+	char *page);
+extern ssize_t blk_throtl_idle_threshold_store(struct request_queue *q,
+	const char *page, size_t count);
+extern void blk_throtl_bio_endio(struct bio *bio);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline void blk_throtl_drain(struct request_queue *q) { }
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
+static inline void blk_throtl_bio_endio(struct bio *bio) { }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 436f43f..be9d10d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -60,6 +60,7 @@ struct bio {
 	 */
 	struct io_context	*bi_ioc;
 	struct cgroup_subsys_state *bi_css;
+	void *bi_cg_private;
 #endif
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-- 
2.8.0.rc2


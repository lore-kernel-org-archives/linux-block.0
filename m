Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
From: Dennis Zhou <dennisszhou@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <jbacik@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: kernel-team@fb.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH v3] block: make iolatency avg_lat exponentially decay
Date: Wed,  1 Aug 2018 23:15:41 -0700
Message-Id: <20180802061541.49173-1-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Currently, avg_lat is calculated by accumulating the mean of every
window in a long running cumulative average. As time goes on, the metric
becomes less and less useful due to the accumulated history.

This patch reuses the same calculation done in load averages to make the
avg_lat metric more lively. Unlike load averages, the avg only advances
when a window elapses (due to an io). Idle periods extend the most
recent window. Bucketing is used to limit the history of avg_lat by
binding it to the window size. So, the window range for 1/exp (decay
rate) is [1 min, 2.5 min) when windows elapse immediately.

The current sample window size is exposed in the debug info to enable
calculation of the window range.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 21 +++++----
 block/blk-iolatency.c                   | 60 ++++++++++++++++++-------
 2 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3afe10fa82bc..1746131bc9cb 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1474,11 +1474,9 @@ So the ideal way to configure this is to set io.latency in groups A, B, and C.
 Generally you do not want to set a value lower than the latency your device
 supports.  Experiment to find the value that works best for your workload.
 Start at higher than the expected latency for your device and watch the
-total_lat_avg value in io.stat for your workload group to get an idea of the
-latency you see during normal operation.  Use this value as a basis for your
-real setting, setting at 10-15% higher than the value in io.stat.
-Experimentation is key here because total_lat_avg is a running total, so is the
-"statistics" portion of "lies, damned lies, and statistics."
+avg_lat value in io.stat for your workload group to get an idea of the
+latency you see during normal operation.  Use the avg_lat value as a basis for
+your real setting, setting at 10-15% higher than the value in io.stat.
 
 How IO Latency Throttling Works
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -1522,10 +1520,15 @@ IO Latency Interface Files
 		This is the current queue depth for the group.
 
 	  avg_lat
-		The running average IO latency for this group in microseconds.
-		Running average is generally flawed, but will give an
-		administrator a general idea of the overall latency they can
-		expect for their workload on the given disk.
+		This is an exponential moving average with a decay rate of 1/exp
+		bound by the sampling interval.  The decay rate interval can be
+		calculated by multiplying the win value in io.stat by the
+		corresponding number of samples based on the win value.
+
+	  win
+		The sampling window size in milliseconds.  This is the minimum
+		duration of time between evaluation events.  Windows only elapse
+		with IO activity.  Idle periods extend the most recent window.
 
 PID
 ---
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index b0dc4fc64b3e..19923f8a029d 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -69,6 +69,7 @@
 #include <linux/module.h>
 #include <linux/timer.h>
 #include <linux/memcontrol.h>
+#include <linux/sched/loadavg.h>
 #include <linux/sched/signal.h>
 #include <trace/events/block.h>
 #include "blk-rq-qos.h"
@@ -126,8 +127,7 @@ struct iolatency_grp {
 	u64 cur_win_nsec;
 
 	/* total running average of our io latency. */
-	u64 total_lat_avg;
-	u64 total_lat_nr;
+	u64 lat_avg;
 
 	/* Our current number of IO's for the last summation. */
 	u64 nr_samples;
@@ -135,6 +135,28 @@ struct iolatency_grp {
 	struct child_latency_info child_lat;
 };
 
+#define BLKIOLATENCY_MIN_WIN_SIZE (100 * NSEC_PER_MSEC)
+#define BLKIOLATENCY_MAX_WIN_SIZE NSEC_PER_SEC
+/*
+ * These are the constants used to fake the fixed-point moving average
+ * calculation just like load average.  The call to CALC_LOAD folds
+ * (FIXED_1 (2048) - exp_factor) * new_sample into lat_avg.  The sampling
+ * window size is bucketed to try to approximately calculate average
+ * latency such that 1/exp (decay rate) is [1 min, 2.5 min) when windows
+ * elapse immediately.  Note, windows only elapse with IO activity.  Idle
+ * periods extend the most recent window.
+ */
+#define BLKIOLATENCY_NR_EXP_FACTORS 5
+#define BLKIOLATENCY_EXP_BUCKET_SIZE (BLKIOLATENCY_MAX_WIN_SIZE / \
+				      (BLKIOLATENCY_NR_EXP_FACTORS - 1))
+static const u64 iolatency_exp_factors[BLKIOLATENCY_NR_EXP_FACTORS] = {
+	2045, // exp(1/600) - 600 samples
+	2039, // exp(1/240) - 240 samples
+	2031, // exp(1/120) - 120 samples
+	2023, // exp(1/80)  - 80 samples
+	2014, // exp(1/60)  - 60 samples
+};
+
 static inline struct iolatency_grp *pd_to_lat(struct blkg_policy_data *pd)
 {
 	return pd ? container_of(pd, struct iolatency_grp, pd) : NULL;
@@ -462,7 +484,7 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	struct child_latency_info *lat_info;
 	struct blk_rq_stat stat;
 	unsigned long flags;
-	int cpu;
+	int cpu, exp_idx;
 
 	blk_rq_stat_init(&stat);
 	preempt_disable();
@@ -480,11 +502,17 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 
 	lat_info = &parent->child_lat;
 
-	iolat->total_lat_avg =
-		div64_u64((iolat->total_lat_avg * iolat->total_lat_nr) +
-			  stat.mean, iolat->total_lat_nr + 1);
-
-	iolat->total_lat_nr++;
+	/*
+	 * CALC_LOAD takes in a number stored in fixed point representation.
+	 * Because we are using this for IO time in ns, the values stored
+	 * are significantly larger than the FIXED_1 denominator (2048).
+	 * Therefore, rounding errors in the calculation are negligible and
+	 * can be ignored.
+	 */
+	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
+			div64_u64(iolat->cur_win_nsec,
+				  BLKIOLATENCY_EXP_BUCKET_SIZE));
+	CALC_LOAD(iolat->lat_avg, iolatency_exp_factors[exp_idx], stat.mean);
 
 	/* Everything is ok and we don't need to adjust the scale. */
 	if (stat.mean <= iolat->min_lat_nsec &&
@@ -700,8 +728,9 @@ static void iolatency_set_min_lat_nsec(struct blkcg_gq *blkg, u64 val)
 	u64 oldval = iolat->min_lat_nsec;
 
 	iolat->min_lat_nsec = val;
-	iolat->cur_win_nsec = max_t(u64, val << 4, 100 * NSEC_PER_MSEC);
-	iolat->cur_win_nsec = min_t(u64, iolat->cur_win_nsec, NSEC_PER_SEC);
+	iolat->cur_win_nsec = max_t(u64, val << 4, BLKIOLATENCY_MIN_WIN_SIZE);
+	iolat->cur_win_nsec = min_t(u64, iolat->cur_win_nsec,
+				    BLKIOLATENCY_MAX_WIN_SIZE);
 
 	if (!oldval && val)
 		atomic_inc(&blkiolat->enabled);
@@ -810,14 +839,15 @@ static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
 				size_t size)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
-	unsigned long long avg_lat = div64_u64(iolat->total_lat_avg, NSEC_PER_USEC);
+	unsigned long long avg_lat = div64_u64(iolat->lat_avg, NSEC_PER_USEC);
+	unsigned long long cur_win = div64_u64(iolat->cur_win_nsec, NSEC_PER_MSEC);
 
 	if (iolat->rq_depth.max_depth == UINT_MAX)
-		return scnprintf(buf, size, " depth=max avg_lat=%llu",
-				 avg_lat);
+		return scnprintf(buf, size, " depth=max avg_lat=%llu win=%llu",
+				 avg_lat, cur_win);
 
-	return scnprintf(buf, size, " depth=%u avg_lat=%llu",
-			 iolat->rq_depth.max_depth, avg_lat);
+	return scnprintf(buf, size, " depth=%u avg_lat=%llu win=%llu",
+			 iolat->rq_depth.max_depth, avg_lat, cur_win);
 }
 
 
-- 
2.17.1

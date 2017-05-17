Return-Path: <prvs=631096caf0=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, <Kernel-team@fb.com>
Subject: [PATCH 2/4] blk-throttle: output some debug info in trace
Date: Wed, 17 May 2017 13:07:25 -0700
Message-ID: <6e507e6429463f59bcb7f11ca89ba4d41c59ec56.1495050247.git.shli@fb.com>
In-Reply-To: <cover.1495050247.git.shli@fb.com>
References: <cover.1495050247.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

These info are important to understand what's happening and help debug.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 16174f8..1f8d62f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1748,12 +1748,18 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
 	 * - IO latency is largely below threshold
 	 */
 	unsigned long time = jiffies_to_usecs(4 * tg->td->throtl_slice);
+	bool ret;
 
 	time = min_t(unsigned long, MAX_IDLE_TIME, time);
-	return (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
+	ret = (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
 	       tg->avg_idletime > tg->idletime_threshold ||
 	       (tg->latency_target && tg->bio_cnt &&
 		tg->bad_bio_cnt * 5 < tg->bio_cnt);
+	throtl_log(&tg->service_queue,
+		"avg_idle=%ld, idle_threshold=%ld, bad_bio=%d, total_bio=%d, is_idle=%d, scale=%d",
+		tg->avg_idletime, tg->idletime_threshold, tg->bad_bio_cnt,
+		tg->bio_cnt, ret, tg->td->scale);
+	return ret;
 }
 
 static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
@@ -1849,6 +1855,7 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
 
+	throtl_log(&td->service_queue, "upgrade to max");
 	td->limit_index = LIMIT_MAX;
 	td->low_upgrade_time = jiffies;
 	td->scale = 0;
@@ -1871,6 +1878,7 @@ static void throtl_downgrade_state(struct throtl_data *td, int new)
 {
 	td->scale /= 2;
 
+	throtl_log(&td->service_queue, "downgrade, scale %d", td->scale);
 	if (td->scale) {
 		td->low_upgrade_time = jiffies - td->scale * td->throtl_slice;
 		return;
@@ -2044,6 +2052,11 @@ static void throtl_update_latency_buckets(struct throtl_data *td)
 		td->avg_buckets[i].valid = true;
 		last_latency = td->avg_buckets[i].latency;
 	}
+
+	for (i = 0; i < LATENCY_BUCKET_SIZE; i++)
+		throtl_log(&td->service_queue,
+			"Latency bucket %d: latency=%ld, valid=%d", i,
+			td->avg_buckets[i].latency, td->avg_buckets[i].valid);
 }
 #else
 static inline void throtl_update_latency_buckets(struct throtl_data *td)
-- 
2.9.3

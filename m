Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH][v2] blk-iolatency: fix max_depth comparisons
Date: Wed, 11 Jul 2018 10:34:42 -0400
Message-Id: <20180711143442.16566-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

max_depth used to be a u64, but I changed it to a unsigned int but
didn't convert my comparisons over everywhere.  Fix by using UINT_MAX
everywhere instead of (u64)-1.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- use UINT_MAX instead of INT_MAX.

 block/blk-iolatency.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index a35a1f580337..3ae647d9203f 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -9,8 +9,8 @@
  * - We use the mean latency over the 100ms window.  This is because writes can
  *   be particularly fast, which could give us a false sense of the impact of
  *   other workloads on our protected workload.
- * - By default there's no throttling, we set the queue_depth to INT_MAX so that
- *   we can have as many outstanding bio's as we're allowed to.  Only at
+ * - By default there's no throttling, we set the queue_depth to UINT_MAX so
+ *   that we can have as many outstanding bio's as we're allowed to.  Only at
  *   throttle time do we pay attention to the actual queue depth.
  *
  * The hierarchy works like the cpu controller does, we track the latency at
@@ -361,7 +361,7 @@ static void check_scale_change(struct iolatency_grp *iolat)
 	/* We're back to the default cookie, unthrottle all the things. */
 	if (cur_cookie == DEFAULT_SCALE_COOKIE) {
 		blkcg_clear_delay(lat_to_blkg(iolat));
-		iolat->rq_depth.max_depth = INT_MAX;
+		iolat->rq_depth.max_depth = UINT_MAX;
 		wake_up_all(&iolat->rq_wait.wait);
 		return;
 	}
@@ -434,7 +434,7 @@ static void iolatency_record_time(struct iolatency_grp *iolat,
 	 * We don't want to count issue_as_root bio's in the cgroups latency
 	 * statistics as it could skew the numbers downwards.
 	 */
-	if (unlikely(issue_as_root && iolat->rq_depth.max_depth != (u64)-1)) {
+	if (unlikely(issue_as_root && iolat->rq_depth.max_depth != UINT_MAX)) {
 		u64 sub = iolat->min_lat_nsec;
 		if (req_time < sub)
 			blkcg_add_delay(lat_to_blkg(iolat), now, sub - req_time);
@@ -817,7 +817,7 @@ static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	unsigned long long avg_lat = div64_u64(iolat->total_lat_avg, NSEC_PER_USEC);
 
-	if (iolat->rq_depth.max_depth == (u64)-1)
+	if (iolat->rq_depth.max_depth == UINT_MAX)
 		return scnprintf(buf, size, " depth=max avg_lat=%llu",
 				 avg_lat);
 
@@ -860,7 +860,7 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 	rq_wait_init(&iolat->rq_wait);
 	spin_lock_init(&iolat->child_lat.lock);
 	iolat->rq_depth.queue_depth = blk_queue_depth(blkg->q);
-	iolat->rq_depth.max_depth = INT_MAX;
+	iolat->rq_depth.max_depth = UINT_MAX;
 	iolat->rq_depth.default_depth = iolat->rq_depth.queue_depth;
 	iolat->blkiolat = blkiolat;
 	iolat->cur_win_nsec = 100 * NSEC_PER_MSEC;
-- 
2.14.3

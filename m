Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] blk-iolatency: fix max_depth comparisons
Date: Wed, 11 Jul 2018 09:30:11 -0400
Message-Id: <20180711133012.15552-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

max_depth used to be a u64, but I changed it to a unsigned int but
didn't convert my comparisons over everywhere.  Fix by comparing to
INT_MAX instead of (u64)-1.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index a35a1f580337..5aabcb746f01 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -434,7 +434,7 @@ static void iolatency_record_time(struct iolatency_grp *iolat,
 	 * We don't want to count issue_as_root bio's in the cgroups latency
 	 * statistics as it could skew the numbers downwards.
 	 */
-	if (unlikely(issue_as_root && iolat->rq_depth.max_depth != (u64)-1)) {
+	if (unlikely(issue_as_root && iolat->rq_depth.max_depth != INT_MAX)) {
 		u64 sub = iolat->min_lat_nsec;
 		if (req_time < sub)
 			blkcg_add_delay(lat_to_blkg(iolat), now, sub - req_time);
@@ -817,7 +817,7 @@ static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	unsigned long long avg_lat = div64_u64(iolat->total_lat_avg, NSEC_PER_USEC);
 
-	if (iolat->rq_depth.max_depth == (u64)-1)
+	if (iolat->rq_depth.max_depth == INT_MAX)
 		return scnprintf(buf, size, " depth=max avg_lat=%llu",
 				 avg_lat);
 
-- 
2.14.3

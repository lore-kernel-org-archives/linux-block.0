Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Josef Bacik <jbacik@fb.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][block-next] block: iolatency: fix comparison of unsigned int max_depth with a (u64)-1
Date: Wed, 11 Jul 2018 15:21:48 +0100
Message-Id: <20180711142148.3949-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The comparison max_depth != (u64)-1 is always true as max_depth is a
unsigned int and so its upper 32 bits are 0. Fix this by using the
a comparison of (unsigned int)-1 to ensure like types are compared.
Note, if max_depth is changed to a wider type then this will need
fixing again.

Detected by CoverityScan, CID#1471763 ("Operands don't affect result")

Fixes: commit d70675121546 ("block: introduce blk-iolatency io controller")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/blk-iolatency.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 56ddb2c68752..9a6427372da0 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -434,7 +434,7 @@ static void iolatency_record_time(struct iolatency_grp *iolat,
 	 * We don't want to count issue_as_root bio's in the cgroups latency
 	 * statistics as it could skew the numbers downwards.
 	 */
-	if (unlikely(issue_as_root && iolat->rq_depth.max_depth != (u64)-1)) {
+	if (unlikely(issue_as_root && iolat->rq_depth.max_depth != (unsigned int)-1)) {
 		u64 sub = iolat->min_lat_nsec;
 		if (req_time < sub)
 			blkcg_add_delay(lat_to_blkg(iolat), now, sub - req_time);
@@ -816,7 +816,7 @@ static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	unsigned long long avg_lat = div64_u64(iolat->total_lat_avg, NSEC_PER_USEC);
 
-	if (iolat->rq_depth.max_depth == (u64)-1)
+	if (iolat->rq_depth.max_depth == (unsigned int)-1)
 		return scnprintf(buf, size, " depth=max avg_lat=%llu",
 				 avg_lat);
 
-- 
2.17.1

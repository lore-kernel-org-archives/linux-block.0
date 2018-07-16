Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 1/2] blk-iolatency: don't change the latency window
Date: Mon, 16 Jul 2018 12:12:22 -0400
Message-Id: <20180716161223.21486-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

Early versions of these patches had us waiting for seconds at a time
during submission, so we had to adjust the timing window we monitored
for latency.  Now we don't do things like that so this is unnecessary
code.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/blk-iolatency.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index b59e5451680b..893f888eebb1 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -468,16 +468,6 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	}
 	preempt_enable();
 
-	/*
-	 * Our average exceeded our window, scale up our window so we are more
-	 * accurate, but not more than the global timer.
-	 */
-	if (stat.mean > iolat->cur_win_nsec) {
-		iolat->cur_win_nsec <<= 1;
-		iolat->cur_win_nsec =
-			max_t(u64, iolat->cur_win_nsec, NSEC_PER_SEC);
-	}
-
 	parent = blkg_to_lat(blkg->parent);
 	if (!parent)
 		return;
-- 
2.14.3

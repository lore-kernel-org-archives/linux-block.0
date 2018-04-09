Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, shli@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-throttle: discard stale last_low_overflow_time
Date: Mon,  9 Apr 2018 14:15:46 +0800
Message-Id: <1523254546-1951-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

When there is only one type of traffic, the associated
last_low_overflow_time will not be updated, so the value is
stale and invalid and we should discard it. Otherwise,
__tg_last_low_overflow_time always return the stale value because
it is smaller, and then we always get bps/iops has been below low
limit for 1 throtl_slice, and limit_index will jump down and up
between LOW and MAX, the actual bps/iops stays on low_limit.

Add last_submit_time[2] into tg to track the time when bio enters
into blk_throtl_bio. If there is no bio entering during past 5
throtl_slices, and the actual dispatching bps/iops are indeed lower
than low limit, return 0 as the last_low_overflow_time which
indicates it is stale. We will discard the stale last_low_overflow_time,
but if both types are stale, return 0, Otherwise, the cgroups which
don't have any traffic will prevent upgrade.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-throttle.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c5a1316..851aa16 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -158,6 +158,7 @@ struct throtl_grp {
 	unsigned int io_disp[2];
 
 	unsigned long last_low_overflow_time[2];
+	unsigned long last_submit_time[2];
 
 	uint64_t last_bytes_disp[2];
 	unsigned int last_io_disp[2];
@@ -1752,15 +1753,42 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
+/*
+ * If there is no any traffic of type 'rw' into blk_throtl_bio during
+ * past 5 throtl_slice, AND the actual dispatching bps/iops of type 'rw'
+ * is indeed lower than low limit, we return 0 as the last_low_overflow_time
+ * which indicates it is stale.
+ */
+static inline unsigned long tg_return_lloft(struct throtl_grp *tg,
+		unsigned int rw)
+{
+	unsigned long time = tg->last_low_overflow_time[rw];
+	unsigned long now = jiffies;
+
+	if (!time_after(now,
+		tg->last_submit_time[rw] + 5 * tg->td->throtl_slice))
+		return time;
+
+	if (!time_after(now, time + 5 * tg->td->throtl_slice))
+		return time;
+
+	return 0;
+}
+
 static unsigned long __tg_last_low_overflow_time(struct throtl_grp *tg)
 {
 	unsigned long rtime = jiffies, wtime = jiffies;
 
 	if (tg->bps[READ][LIMIT_LOW] || tg->iops[READ][LIMIT_LOW])
-		rtime = tg->last_low_overflow_time[READ];
+		rtime = tg_return_lloft(tg, READ);
 	if (tg->bps[WRITE][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW])
-		wtime = tg->last_low_overflow_time[WRITE];
-	return min(rtime, wtime);
+		wtime = tg_return_lloft(tg, WRITE);
+
+	/*
+	 * A cgroup w/o any traffic could have two stale value, return 0 instead
+	 * of 'now', otherwise, it will prevent upgrade.
+	 */
+	return (rtime && wtime) ? min(rtime, wtime) : (rtime + wtime);
 }
 
 /* tg should not be an intermediate node */
@@ -2175,8 +2203,11 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	while (true) {
 		if (tg->last_low_overflow_time[rw] == 0)
 			tg->last_low_overflow_time[rw] = jiffies;
+		if (unlikely(tg->last_submit_time[rw] == 0))
+			tg->last_submit_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
 		throtl_upgrade_check(tg);
+		tg->last_submit_time[rw] = jiffies;
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
-- 
2.7.4

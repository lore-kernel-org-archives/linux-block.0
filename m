Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH V7 15/18] blk-throttle: ignore idle cgroup limit
Date: Mon, 27 Mar 2017 10:51:43 -0700
Message-ID: <2f5854e9b8a29324f6faa7c96fb7796ceabe8f81.1490634565.git.shli@fb.com>
In-Reply-To: <cover.1490634565.git.shli@fb.com>
References: <cover.1490634565.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Last patch introduces a way to detect idle cgroup. We use it to make
upgrade/downgrade decision. And the new algorithm can detect completely
idle cgroup too, so we can delete the corresponding code.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f03e158..0ea8698 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -152,8 +152,6 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
-	unsigned long last_dispatch_time[2];
-
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -508,8 +506,6 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	 * Update has_rules[] after a new group is brought online.
 	 */
 	tg_update_has_rules(tg);
-	tg->last_dispatch_time[READ] = jiffies;
-	tg->last_dispatch_time[WRITE] = jiffies;
 }
 
 static void blk_throtl_update_limit_valid(struct throtl_data *td)
@@ -1708,9 +1704,8 @@ static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
 		return true;
 
 	if (time_after_eq(jiffies,
-	     tg->last_dispatch_time[READ] + tg->td->throtl_slice) &&
-	    time_after_eq(jiffies,
-	     tg->last_dispatch_time[WRITE] + tg->td->throtl_slice))
+		tg_last_low_overflow_time(tg) + tg->td->throtl_slice) &&
+	    throtl_tg_is_idle(tg))
 		return true;
 	return false;
 }
@@ -1756,6 +1751,26 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 	return true;
 }
 
+static void throtl_upgrade_check(struct throtl_grp *tg)
+{
+	unsigned long now = jiffies;
+
+	if (tg->td->limit_index != LIMIT_LOW)
+		return;
+
+	if (time_after(tg->last_check_time + tg->td->throtl_slice, now))
+		return;
+
+	tg->last_check_time = now;
+
+	if (!time_after_eq(now,
+	     __tg_last_low_overflow_time(tg) + tg->td->throtl_slice))
+		return;
+
+	if (throtl_can_upgrade(tg->td, NULL))
+		throtl_upgrade_state(tg->td);
+}
+
 static void throtl_upgrade_state(struct throtl_data *td)
 {
 	struct cgroup_subsys_state *pos_css;
@@ -1797,18 +1812,15 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
 	struct throtl_data *td = tg->td;
 	unsigned long now = jiffies;
 
-	if (time_after_eq(now, tg->last_dispatch_time[READ] +
-					td->throtl_slice) &&
-	    time_after_eq(now, tg->last_dispatch_time[WRITE] +
-					td->throtl_slice))
-		return false;
 	/*
 	 * If cgroup is below low limit, consider downgrade and throttle other
 	 * cgroups
 	 */
 	if (time_after_eq(now, td->low_upgrade_time + td->throtl_slice) &&
 	    time_after_eq(now, tg_last_low_overflow_time(tg) +
-					td->throtl_slice))
+					td->throtl_slice) &&
+	    (!throtl_tg_is_idle(tg) ||
+	     !list_empty(&tg_to_blkg(tg)->blkcg->css.children)))
 		return true;
 	return false;
 }
@@ -1931,10 +1943,10 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 again:
 	while (true) {
-		tg->last_dispatch_time[rw] = jiffies;
 		if (tg->last_low_overflow_time[rw] == 0)
 			tg->last_low_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
+		throtl_upgrade_check(tg);
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
-- 
2.9.3

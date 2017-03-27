Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH V7 11/18] blk-throttle: detect completed idle cgroup
Date: Mon, 27 Mar 2017 10:51:39 -0700
Message-ID: <b644f21f62ae79d87a07d58908728d04c43d46e9.1490634565.git.shli@fb.com>
In-Reply-To: <cover.1490634565.git.shli@fb.com>
References: <cover.1490634565.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

cgroup could be assigned a limit, but doesn't dispatch enough IO, eg the
cgroup is idle. When this happens, the cgroup doesn't hit its limit, so
we can't move the state machine to higher level and all cgroups will be
throttled to their lower limit, so we waste bandwidth. Detecting idle
cgroup is hard. This patch handles a simple case, a cgroup doesn't
dispatch any IO. We ignore such cgroup's limit, so other cgroups can use
the bandwidth.

Please note this will be replaced with a more sophisticated algorithm
later, but this demonstrates the idea how we handle idle cgroups, so I
leave it here.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d00c1c1..014b2e9 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -149,6 +149,8 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
+	unsigned long last_dispatch_time[2];
+
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -445,11 +447,14 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 
 static void throtl_pd_online(struct blkg_policy_data *pd)
 {
+	struct throtl_grp *tg = pd_to_tg(pd);
 	/*
 	 * We don't want new groups to escape the limits of its ancestors.
 	 * Update has_rules[] after a new group is brought online.
 	 */
-	tg_update_has_rules(pd_to_tg(pd));
+	tg_update_has_rules(tg);
+	tg->last_dispatch_time[READ] = jiffies;
+	tg->last_dispatch_time[WRITE] = jiffies;
 }
 
 static void blk_throtl_update_limit_valid(struct throtl_data *td)
@@ -1615,6 +1620,12 @@ static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
 	if (write_limit && sq->nr_queued[WRITE] &&
 	    (!read_limit || sq->nr_queued[READ]))
 		return true;
+
+	if (time_after_eq(jiffies,
+	     tg->last_dispatch_time[READ] + tg->td->throtl_slice) &&
+	    time_after_eq(jiffies,
+	     tg->last_dispatch_time[WRITE] + tg->td->throtl_slice))
+		return true;
 	return false;
 }
 
@@ -1692,6 +1703,11 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
 	struct throtl_data *td = tg->td;
 	unsigned long now = jiffies;
 
+	if (time_after_eq(now, tg->last_dispatch_time[READ] +
+					td->throtl_slice) &&
+	    time_after_eq(now, tg->last_dispatch_time[WRITE] +
+					td->throtl_slice))
+		return false;
 	/*
 	 * If cgroup is below low limit, consider downgrade and throttle other
 	 * cgroups
@@ -1800,6 +1816,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 again:
 	while (true) {
+		tg->last_dispatch_time[rw] = jiffies;
 		if (tg->last_low_overflow_time[rw] == 0)
 			tg->last_low_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
-- 
2.9.3

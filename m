Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61743 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752720AbcEKAQp (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:16:45 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.16.0.11/8.16.0.11) with SMTP id u4B0FgWC017994
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:45 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0089730.ppops.net with ESMTP id 22ur09gj36-1
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:45 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.236.89) with ESMTP	id
 a3a50d2a170d11e6a00f0002c95209d8-9c4f7c50 for <linux-block@vger.kernel.org>;
	Tue, 10 May 2016 17:16:43 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <vgoyal@redhat.com>, <axboe@fb.com>,
	<jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 06/10] block-throttle: idle detection
Date: Tue, 10 May 2016 17:16:36 -0700
Message-ID: <e135c0f296be44a42644cc743f1b37aa20d1fedc.1462923578.git.shli@fb.com>
In-Reply-To: <cover.1462923578.git.shli@fb.com>
References: <cover.1462923578.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A cgroup gets assigned a low limit, but the cgroup could never dispatch
enough IO to cross the low limit. In such case, the queue state machine
will remain in LIMIT_LOW state and all other cgroups will be throttled
according to low limit. This is unfair for other cgroups. We will treat
the cgroup idle and upgrade the state machine to higher state.

We also have a downgrade logic. If the state machine upgrades because of
cgroup idle (real idle), the state machine will downgrade soon as the
cgroup is below its low limit. This isn't what we want. A more
complicated case is cgroup isn't idle when queue is in LIMIT_LOW. But
when queue gets upgraded to higher state, other cgroups could dispatch
more IO and this cgroup can't dispatch enough IO, so the cgroup is below
its low limit and looks like idle (fake idle). In this case, the queue
should downgrade soon. The key to determine if we should do downgrade is
to detect if cgroup is truely idle.

Unfortunately I can't find a good way to destinguish the two kinds of
idle. One possible way is the think time check of CFQ. CFQ checks
request submit time and last request completion time and if the
difference of the time (think time) is positive the cgroup is idle.
This technique doesn't work for high queue depth disk. For example, a
workload with io depth 8 has disk utilization 100%, hence think time is
0, eg, not idle. But the workload can run higher bandwidth with io depth
16. Compared to io depth 16, the io depth 8 workload is idle. Think time
can't be used to detect idle here. Another possible way is detecting if
disk reaches maximum bandwidth (then we can detect fake idle). But
detecting maximum bandwidth is hard since maximum bandwidth isn't fixed
for a specific workload. we could only use a feedback system to detect
the maximum bandwidth, which isn't suitable for a limit based
scheduling.

This patch doesn't try to precisely detect idle, because if we wrongly
detect idle, the queue will never get downgrade/upgrade, hence we can't
guarantee low limit or sacrifice performance. If cgroup is below its low
limit, the queue state machine will do upgrade/downgrade continuously.
But we will make the upgrade/downgrade time interval adaptive. We
maintain a history of disk upgrade. If queue upgrades because cgroup
hits low limit, future downgrade is likely because of fake idle, hence
future upgrade should run slowly and future downgrade should run
quickly. Otherwise future downgrade is likely because of real idle,
hence future upgrade should run quickly and future downgrade should run
slowly. The adaptive upgrade/downgrade time means disk downgrade in real
idle happens rarely and disk upgrade in fake idle happens rarely. But we
will still see cgroup throughput jump up and down if some cgroups run
below their low limit.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 5806507..a462e2f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -12,6 +12,7 @@
 #include <linux/blk-cgroup.h>
 #include "blk.h"
 
+#define DEFAULT_HISTORY (0xAA) /* 0/1 bits are equal */
 /* Max dispatch from a group in 1 round */
 static int throtl_grp_quantum = 8;
 
@@ -171,6 +172,7 @@ struct throtl_data
 
 	unsigned long low_upgrade_time;
 	unsigned long low_downgrade_time;
+	unsigned char low_history;
 	unsigned int low_upgrade_interval;
 	unsigned int low_downgrade_interval;
 };
@@ -1572,10 +1574,40 @@ static unsigned long tg_last_low_overflow_time(struct throtl_grp *tg)
 	return ret;
 }
 
-static bool throtl_upgrade_check_one(struct throtl_grp *tg)
+static void throtl_calculate_low_interval(struct throtl_data *td)
+{
+	unsigned long history = td->low_history;
+	unsigned int ubits = bitmap_weight(&history,
+		sizeof(td->low_history) * 8);
+	unsigned int dbits = sizeof(td->low_history) * 8 - ubits;
+
+	ubits = max(1U, ubits);
+	dbits = max(1U, dbits);
+
+	if (ubits >= dbits) {
+		td->low_upgrade_interval = ubits / dbits * cg_check_time;
+		td->low_downgrade_interval = cg_check_time;
+	} else {
+		td->low_upgrade_interval = cg_check_time;
+		td->low_downgrade_interval = dbits / ubits * cg_check_time;
+	}
+}
+
+static bool throtl_upgrade_check_one(struct throtl_grp *tg, bool *idle)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
 
+	if (!tg->bps[READ][LIMIT_LOW] && !tg->bps[WRITE][LIMIT_LOW] &&
+	    !tg->iops[READ][LIMIT_LOW] && !tg->iops[WRITE][LIMIT_LOW])
+		return true;
+
+	/* if cgroup is below low limit for a long time, consider it idle */
+	if (time_after(jiffies,
+	    tg_last_low_overflow_time(tg) + tg->td->low_upgrade_interval)) {
+		*idle = true;
+		return true;
+	}
+
 	if (tg->bps[READ][LIMIT_LOW] != 0 && !sq->nr_queued[READ])
 		return false;
 	if (tg->bps[WRITE][LIMIT_LOW] != 0 && !sq->nr_queued[WRITE])
@@ -1587,15 +1619,15 @@ static bool throtl_upgrade_check_one(struct throtl_grp *tg)
 	return true;
 }
 
-static bool throtl_upgrade_check_hierarchy(struct throtl_grp *tg)
+static bool throtl_upgrade_check_hierarchy(struct throtl_grp *tg, bool *idle)
 {
-	if (throtl_upgrade_check_one(tg))
+	if (throtl_upgrade_check_one(tg, idle))
 		return true;
 	while (true) {
 		if (!tg || (cgroup_subsys_on_dfl(io_cgrp_subsys) &&
 				!tg_to_blkg(tg)->parent))
 			return false;
-		if (throtl_upgrade_check_one(tg))
+		if (throtl_upgrade_check_one(tg, idle))
 			return true;
 		tg = sq_to_tg(tg->service_queue.parent_sq);
 	}
@@ -1607,6 +1639,7 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 {
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
+	bool idle = false;
 
 	if (td->limit_index != LIMIT_LOW)
 		return false;
@@ -1622,9 +1655,15 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 			continue;
 		if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children))
 			continue;
-		if (!throtl_upgrade_check_hierarchy(tg))
+		if (!throtl_upgrade_check_hierarchy(tg, &idle))
 			return false;
 	}
+	if (td->limit_index == LIMIT_LOW) {
+		td->low_history <<= 1;
+		if (!idle)
+			td->low_history |= 1;
+		throtl_calculate_low_interval(td);
+	}
 	return true;
 }
 
@@ -1648,6 +1687,21 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	queue_work(kthrotld_workqueue, &td->dispatch_work);
 }
 
+static void throtl_upgrade_check(struct throtl_grp *tg)
+{
+	if (tg->td->limit_index != LIMIT_LOW)
+		return;
+
+	if (!(tg->bps[READ][LIMIT_LOW] || tg->bps[WRITE][LIMIT_LOW] ||
+	      tg->iops[READ][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW]) ||
+	    !time_after(jiffies,
+	     tg_last_low_overflow_time(tg) + tg->td->low_upgrade_interval))
+		return;
+
+	if (throtl_can_upgrade(tg->td, NULL))
+		throtl_upgrade_state(tg->td);
+}
+
 static void throtl_downgrade_state(struct throtl_data *td, int new)
 {
 	td->limit_index = new;
@@ -1773,6 +1827,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		if (tg->last_low_overflow_time[rw] == 0)
 			tg->last_low_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
+		throtl_upgrade_check(tg);
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
@@ -1937,8 +1992,8 @@ int blk_throtl_init(struct request_queue *q)
 	td->limit_index = LIMIT_MAX;
 	td->low_upgrade_time = jiffies;
 	td->low_downgrade_time = jiffies;
-	td->low_upgrade_interval = cg_check_time;
-	td->low_downgrade_interval = cg_check_time;
+	td->low_history = DEFAULT_HISTORY;
+	throtl_calculate_low_interval(td);
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
-- 
2.8.0.rc2


Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39558 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403AbcEKAQo (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:16:44 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4B0CNDb026368
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:44 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 22usxn80xx-4
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:44 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.232.59) with ESMTP	id
 a3c8e218170d11e6b52d0002c991e86a-d50dec50 for <linux-block@vger.kernel.org>;
	Tue, 10 May 2016 17:16:43 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <vgoyal@redhat.com>, <axboe@fb.com>,
	<jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 08/10] block-throttle: handle high limit
Date: Tue, 10 May 2016 17:16:38 -0700
Message-ID: <097677a8a1e3e2bf89da63e35dc7314126cc9791.1462923578.git.shli@fb.com>
In-Reply-To: <cover.1462923578.git.shli@fb.com>
References: <cover.1462923578.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Handle high limit like we handle low limit including
downgrade/upgrade/idle detection logic. If cgroup has high limit, its
throttling limit is high limit. Otherwise the throttling limit is max
limit.

queue downgrades from LIMIT_HIGH/LIMIT_MAX to LIMIT_LOW if cgroup is below
low limit. queue upgrades from LIMIT_HIGH to LIMIT_MAX if all cgroups
reach high limit (max limit if no high limit). queue downgrades from
LIMIT_MAX to LIMIT_HIGH if cgroup is below high limit.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 278 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 230 insertions(+), 48 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 5736d1b..0aed049 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -140,6 +140,7 @@ struct throtl_grp {
 	unsigned int io_disp[2];
 
 	unsigned long last_low_overflow_time[2];
+	unsigned long last_high_overflow_time[2];
 
 	uint64_t last_bytes_disp[2];
 	unsigned int last_io_disp[2];
@@ -176,6 +177,12 @@ struct throtl_data
 	unsigned char low_history;
 	unsigned int low_upgrade_interval;
 	unsigned int low_downgrade_interval;
+
+	unsigned long high_upgrade_time;
+	unsigned long high_downgrade_time;
+	unsigned char high_history;
+	unsigned int high_upgrade_interval;
+	unsigned int high_downgrade_interval;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -1637,6 +1644,52 @@ static unsigned long tg_last_low_overflow_time(struct throtl_grp *tg)
 	return ret;
 }
 
+static unsigned long __tg_last_high_overflow_time(struct throtl_grp *tg)
+{
+	unsigned long rtime = -1, wtime = -1;
+	if (tg->bps[READ][LIMIT_HIGH] != -1 || tg->iops[READ][LIMIT_HIGH] != -1 ||
+	    tg->bps[READ][LIMIT_MAX] != -1 || tg->iops[READ][LIMIT_MAX] != -1)
+		rtime = tg->last_high_overflow_time[READ];
+	if (tg->bps[WRITE][LIMIT_HIGH] != -1 || tg->iops[WRITE][LIMIT_HIGH] != -1 ||
+	    tg->bps[WRITE][LIMIT_MAX] != -1 || tg->iops[WRITE][LIMIT_MAX] != -1)
+		wtime = tg->last_high_overflow_time[WRITE];
+	return min(rtime, wtime);
+}
+
+static unsigned long tg_last_high_overflow_time(struct throtl_grp *tg)
+{
+	struct throtl_service_queue *parent_sq;
+	struct throtl_grp *parent = tg;
+	unsigned long ret = __tg_last_high_overflow_time(tg);
+
+	while (true) {
+		parent_sq = parent->service_queue.parent_sq;
+		parent = sq_to_tg(parent_sq);
+		if (!parent)
+			break;
+		if (((parent->bps[READ][LIMIT_HIGH] != -1 &&
+		      parent->bps[READ][LIMIT_HIGH] > tg->bps[READ][LIMIT_HIGH]) ||
+		     (parent->bps[READ][LIMIT_HIGH] == -1 &&
+		      parent->bps[READ][LIMIT_MAX] > tg->bps[READ][LIMIT_HIGH])) &&
+		    ((parent->bps[WRITE][LIMIT_HIGH] != -1 &&
+		      parent->bps[WRITE][LIMIT_HIGH] > tg->bps[WRITE][LIMIT_HIGH]) ||
+		     (parent->bps[WRITE][LIMIT_HIGH] == -1 &&
+		      parent->bps[WRITE][LIMIT_MAX] > tg->bps[WRITE][LIMIT_HIGH])) &&
+		    ((parent->iops[READ][LIMIT_HIGH] != -1 &&
+		      parent->iops[READ][LIMIT_HIGH] > tg->iops[READ][LIMIT_HIGH]) ||
+		     (parent->iops[READ][LIMIT_HIGH] == -1 &&
+		      parent->iops[READ][LIMIT_MAX] > tg->iops[READ][LIMIT_HIGH])) &&
+		    ((parent->iops[WRITE][LIMIT_HIGH] != -1 &&
+		      parent->iops[WRITE][LIMIT_HIGH] > tg->iops[WRITE][LIMIT_HIGH]) ||
+		     (parent->iops[WRITE][LIMIT_HIGH] == -1 &&
+		      parent->iops[WRITE][LIMIT_MAX] > tg->iops[WRITE][LIMIT_HIGH])))
+			break;
+		if (time_after(__tg_last_high_overflow_time(parent), ret))
+			ret = __tg_last_high_overflow_time(parent);
+	}
+	return ret;
+}
+
 static void throtl_calculate_low_interval(struct throtl_data *td)
 {
 	unsigned long history = td->low_history;
@@ -1656,10 +1709,32 @@ static void throtl_calculate_low_interval(struct throtl_data *td)
 	}
 }
 
+static void throtl_calculate_high_interval(struct throtl_data *td)
+{
+	unsigned long history = td->high_history;
+	unsigned int ubits = bitmap_weight(&history,
+		sizeof(td->high_history) * 8);
+	unsigned int dbits = sizeof(td->high_history) * 8 - ubits;
+
+	ubits = max(1U, ubits);
+	dbits = max(1U, dbits);
+
+	if (ubits >= dbits) {
+		td->high_upgrade_interval = ubits / dbits * cg_check_time;
+		td->high_downgrade_interval = cg_check_time;
+	} else {
+		td->high_upgrade_interval = cg_check_time;
+		td->high_downgrade_interval = dbits / ubits * cg_check_time;
+	}
+}
+
 static bool throtl_upgrade_check_one(struct throtl_grp *tg, bool *idle)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
 
+	if (tg->td->limit_index == LIMIT_HIGH)
+		goto check_high;
+
 	if (!tg->bps[READ][LIMIT_LOW] && !tg->bps[WRITE][LIMIT_LOW] &&
 	    !tg->iops[READ][LIMIT_LOW] && !tg->iops[WRITE][LIMIT_LOW])
 		return true;
@@ -1680,6 +1755,18 @@ static bool throtl_upgrade_check_one(struct throtl_grp *tg, bool *idle)
 	if (tg->iops[WRITE][LIMIT_LOW] != 0 && !sq->nr_queued[WRITE])
 		return false;
 	return true;
+check_high:
+	/* if cgroup is below high limit for a long time, consider it idle */
+	if (time_after(jiffies,
+	    tg_last_high_overflow_time(tg) + tg->td->high_upgrade_interval)) {
+		*idle = true;
+		return true;
+	}
+
+	/* if cgroup reaches high/max limit, it's ok to next limit */
+	if (sq->nr_queued[READ] || sq->nr_queued[WRITE])
+		return true;
+	return false;
 }
 
 static bool throtl_upgrade_check_hierarchy(struct throtl_grp *tg, bool *idle)
@@ -1704,11 +1791,15 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 	struct blkcg_gq *blkg;
 	bool idle = false;
 
-	if (td->limit_index != LIMIT_LOW)
+	if (td->limit_index != LIMIT_LOW && td->limit_index != LIMIT_HIGH)
 		return false;
 
-	if (td->limit_index == LIMIT_LOW && time_before(jiffies,
-	    td->low_downgrade_time + td->low_upgrade_interval))
+	if ((td->limit_index == LIMIT_LOW &&
+	     time_before(jiffies,
+	      td->low_downgrade_time + td->low_upgrade_interval)) ||
+	    (td->limit_index == LIMIT_HIGH &&
+	     time_before(jiffies,
+	      td->high_downgrade_time + td->high_upgrade_interval)))
 		return false;
 
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
@@ -1726,6 +1817,11 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 		if (!idle)
 			td->low_history |= 1;
 		throtl_calculate_low_interval(td);
+	} else {
+		td->high_history <<= 1;
+		if (!idle)
+			td->high_history |= 1;
+		throtl_calculate_high_interval(td);
 	}
 	return true;
 }
@@ -1734,9 +1830,21 @@ static void throtl_upgrade_state(struct throtl_data *td)
 {
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
+	int old = td->limit_index;
 
-	td->limit_index = LIMIT_MAX;
+	td->limit_index++;
+	while (!td->limit_valid[td->limit_index])
+		td->limit_index++;
 	td->low_upgrade_time = jiffies;
+	if (td->limit_index == LIMIT_HIGH)
+		td->high_downgrade_time = jiffies;
+	if (td->limit_index >= LIMIT_HIGH)
+		td->high_upgrade_time = jiffies;
+	/* high to max */
+	if (td->limit_index == LIMIT_MAX && old == LIMIT_HIGH) {
+		td->low_history = DEFAULT_HISTORY;
+		throtl_calculate_low_interval(td);
+	}
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 		struct throtl_service_queue *sq = &tg->service_queue;
@@ -1752,13 +1860,18 @@ static void throtl_upgrade_state(struct throtl_data *td)
 
 static void throtl_upgrade_check(struct throtl_grp *tg)
 {
-	if (tg->td->limit_index != LIMIT_LOW)
+	if (tg->td->limit_index != LIMIT_LOW &&
+	    tg->td->limit_index != LIMIT_HIGH)
 		return;
 
-	if (!(tg->bps[READ][LIMIT_LOW] || tg->bps[WRITE][LIMIT_LOW] ||
-	      tg->iops[READ][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW]) ||
-	    !time_after(jiffies,
-	     tg_last_low_overflow_time(tg) + tg->td->low_upgrade_interval))
+	if ((tg->td->limit_index == LIMIT_LOW &&
+	     (!(tg->bps[READ][LIMIT_LOW] || tg->bps[WRITE][LIMIT_LOW] ||
+	        tg->iops[READ][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW]) ||
+	      !time_after(jiffies,
+	       tg_last_low_overflow_time(tg) + tg->td->low_upgrade_interval))) ||
+	    (tg->td->limit_index == LIMIT_HIGH &&
+	     !time_after(jiffies,
+	      tg_last_high_overflow_time(tg) + tg->td->high_upgrade_interval)))
 		return;
 
 	if (throtl_can_upgrade(tg->td, NULL))
@@ -1767,11 +1880,32 @@ static void throtl_upgrade_check(struct throtl_grp *tg)
 
 static void throtl_downgrade_state(struct throtl_data *td, int new)
 {
+	int old = td->limit_index;
+
 	td->limit_index = new;
+	/* max crosses high to low */
+	if (new == LIMIT_LOW && old == LIMIT_MAX && td->limit_valid[LIMIT_HIGH]) {
+		td->low_downgrade_time = jiffies;
+		td->low_upgrade_time = jiffies;
+		td->low_history = 0xFF; /* do less upgrade later */
+		throtl_calculate_low_interval(td);
+
+		td->high_downgrade_time = jiffies;
+		td->high_upgrade_time = jiffies;
+		td->high_history = 0xFF; /* do less upgrade later */
+		throtl_calculate_high_interval(td);
+		return;
+	}
+	/* max to high */
+	if (new == LIMIT_HIGH) {
+		td->high_downgrade_time = jiffies;
+		return;
+	}
+
 	td->low_downgrade_time = jiffies;
 }
 
-static bool throtl_downgrade_check_one(struct throtl_grp *tg)
+static bool throtl_downgrade_check_one(struct throtl_grp *tg, bool check_low)
 {
 	struct throtl_data *td = tg->td;
 	unsigned long now = jiffies;
@@ -1780,24 +1914,30 @@ static bool throtl_downgrade_check_one(struct throtl_grp *tg)
 	 * If cgroup is below low limit, consider downgrade and throttle other
 	 * cgroups
 	 */
-	if (time_after(now,
-	     td->low_upgrade_time + td->low_downgrade_interval) &&
-	    time_after(now,
-	     tg_last_low_overflow_time(tg) + td->low_downgrade_interval))
+	if ((check_low &&
+	     time_after(now,
+	      td->low_upgrade_time + td->low_downgrade_interval) &&
+	     time_after(now,
+	      tg_last_low_overflow_time(tg) + td->low_downgrade_interval)) ||
+	    (!check_low &&
+	     time_after(now,
+	      td->high_upgrade_time + td->high_downgrade_interval) &&
+	     time_after(now,
+	      tg_last_high_overflow_time(tg) + td->high_downgrade_interval)))
 		return true;
 	return false;
 }
 
-static bool throtl_downgrade_check_hierarchy(struct throtl_grp *tg)
+static bool throtl_downgrade_check_hierarchy(struct throtl_grp *tg, bool check_low)
 {
-	if (!throtl_downgrade_check_one(tg))
+	if (!throtl_downgrade_check_one(tg, check_low))
 		return false;
 	while (true) {
 		if (!tg || (cgroup_subsys_on_dfl(io_cgrp_subsys) &&
 			    !tg_to_blkg(tg)->parent))
 			break;
 
-		if (!throtl_downgrade_check_one(tg))
+		if (!throtl_downgrade_check_one(tg, check_low))
 			return false;
 		tg = sq_to_tg(tg->service_queue.parent_sq);
 	}
@@ -1810,52 +1950,84 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 	unsigned int iops;
 	unsigned long elapsed_time;
 	unsigned long now = jiffies;
+	bool check_low;
+	bool check_high;
 
-	if (tg->td->limit_index != LIMIT_MAX)
+	if (tg->td->limit_index == LIMIT_LOW)
 		return;
-	if (!(tg->bps[READ][LIMIT_LOW] ||
-	      tg->bps[WRITE][LIMIT_LOW] ||
-	      tg->iops[WRITE][LIMIT_LOW] ||
-	      tg->iops[READ][LIMIT_LOW]))
+	if (!tg->td->limit_valid[LIMIT_LOW] && !tg->td->limit_valid[LIMIT_HIGH])
 		return;
-
 	if (time_after(tg->last_check_time + throtl_slice, now))
 		return;
+	check_low = tg->bps[READ][LIMIT_LOW] ||
+		    tg->bps[WRITE][LIMIT_LOW] ||
+		    tg->iops[READ][LIMIT_LOW] ||
+		    tg->iops[WRITE][LIMIT_LOW];
+	check_high = tg->bps[READ][LIMIT_HIGH] != -1 ||
+		     tg->bps[WRITE][LIMIT_HIGH] != -1 ||
+		     tg->iops[READ][LIMIT_HIGH] != -1 ||
+		     tg->iops[WRITE][LIMIT_HIGH] != -1 ||
+		     (tg->td->limit_valid[LIMIT_HIGH] &&
+		      (tg->bps[READ][LIMIT_MAX] != -1 ||
+		       tg->bps[WRITE][LIMIT_MAX] != -1 ||
+		       tg->iops[READ][LIMIT_MAX] != -1 ||
+		       tg->iops[WRITE][LIMIT_MAX] != -1) &&
+		      time_before(now, tg_last_high_overflow_time(tg) +
+		       tg->td->high_downgrade_interval));
+
 	elapsed_time = now - tg->last_check_time;
 	tg->last_check_time = now;
 
-	if (tg->bps[READ][LIMIT_LOW]) {
-		bps = tg->last_bytes_disp[READ] * HZ;
-		do_div(bps, elapsed_time);
-		if (bps >= tg->bps[READ][LIMIT_LOW])
-			tg->last_low_overflow_time[READ] = now;
-	}
-
-	if (tg->bps[WRITE][LIMIT_LOW]) {
-		bps = tg->last_bytes_disp[WRITE] * HZ;
-		do_div(bps, elapsed_time);
-		if (bps >= tg->bps[WRITE][LIMIT_LOW])
-			tg->last_low_overflow_time[WRITE] = now;
-	}
-
-	if (tg->iops[READ][LIMIT_LOW]) {
-		iops = tg->last_io_disp[READ] * HZ / elapsed_time;
-		if (iops >= tg->iops[READ][LIMIT_LOW])
-			tg->last_low_overflow_time[READ] = now;
-	}
+	if (!check_low && !check_high)
+		return;
 
-	if (tg->iops[WRITE][LIMIT_LOW]) {
-		iops = tg->last_io_disp[WRITE] * HZ / elapsed_time;
-		if (iops >= tg->iops[WRITE][LIMIT_LOW])
-			tg->last_low_overflow_time[WRITE] = now;
-	}
+	bps = tg->last_bytes_disp[READ] * HZ;
+	do_div(bps, elapsed_time);
+	if (tg->bps[READ][LIMIT_LOW] != 0 &&
+	    bps >= tg->bps[READ][LIMIT_LOW])
+		tg->last_low_overflow_time[READ] = now;
+	if ((tg->bps[READ][LIMIT_HIGH] != -1 &&
+	     bps >= tg->bps[READ][LIMIT_HIGH]) ||
+	    bps >= tg->bps[READ][LIMIT_MAX])
+		tg->last_high_overflow_time[READ] = now;
+
+	bps = tg->last_bytes_disp[WRITE] * HZ;
+	do_div(bps, elapsed_time);
+	if (tg->bps[WRITE][LIMIT_LOW] != 0 &&
+	    bps >= tg->bps[WRITE][LIMIT_LOW])
+		tg->last_low_overflow_time[WRITE] = now;
+	if ((tg->bps[WRITE][LIMIT_HIGH] != -1 &&
+	     bps >= tg->bps[WRITE][LIMIT_HIGH]) ||
+	    bps >= tg->bps[WRITE][LIMIT_MAX])
+		tg->last_high_overflow_time[WRITE] = now;
+
+	iops = tg->last_io_disp[READ] * HZ / elapsed_time;
+	if (tg->iops[READ][LIMIT_LOW] != 0 &&
+	    iops >= tg->iops[READ][LIMIT_LOW])
+		tg->last_low_overflow_time[READ] = now;
+	if ((tg->iops[READ][LIMIT_HIGH] != -1 &&
+	     iops >= tg->iops[READ][LIMIT_HIGH]) ||
+	    iops >= tg->iops[READ][LIMIT_MAX])
+		tg->last_high_overflow_time[READ] = now;
+
+	iops = tg->last_io_disp[WRITE] * HZ / elapsed_time;
+	if (tg->iops[WRITE][LIMIT_LOW] != 0 &&
+	    iops >= tg->iops[WRITE][LIMIT_LOW])
+		tg->last_low_overflow_time[WRITE] = now;
+	if ((tg->iops[WRITE][LIMIT_HIGH] != -1 &&
+	     iops >= tg->iops[WRITE][LIMIT_HIGH]) ||
+	    iops >= tg->iops[WRITE][LIMIT_MAX])
+		tg->last_high_overflow_time[WRITE] = now;
 
 	/*
 	 * If cgroup is below low limit, consider downgrade and throttle other
 	 * cgroups
 	 */
-	if (throtl_downgrade_check_hierarchy(tg))
+	if (check_low && throtl_downgrade_check_hierarchy(tg, true))
 		throtl_downgrade_state(tg->td, LIMIT_LOW);
+	else if (tg->td->limit_index == LIMIT_MAX && check_high &&
+		   throtl_downgrade_check_hierarchy(tg, false))
+		throtl_downgrade_state(tg->td, LIMIT_HIGH);
 
 	tg->last_bytes_disp[READ] = 0;
 	tg->last_bytes_disp[WRITE] = 0;
@@ -1889,6 +2061,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	while (true) {
 		if (tg->last_low_overflow_time[rw] == 0)
 			tg->last_low_overflow_time[rw] = jiffies;
+		if (tg->last_high_overflow_time[rw] == 0)
+			tg->last_high_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
 		throtl_upgrade_check(tg);
 		/* throtl is FIFO - if bios are already queued, should queue */
@@ -1898,6 +2072,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		/* if above limits, break to queue */
 		if (!tg_may_dispatch(tg, bio, NULL)) {
 			tg->last_low_overflow_time[rw] = jiffies;
+			if (tg->td->limit_index >= LIMIT_HIGH)
+				tg->last_high_overflow_time[rw] = jiffies;
 			if (throtl_can_upgrade(tg->td, tg)) {
 				throtl_upgrade_state(tg->td);
 				goto again;
@@ -1941,6 +2117,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
 	tg->last_low_overflow_time[rw] = jiffies;
+	if (tg->td->limit_index >= LIMIT_HIGH)
+		tg->last_high_overflow_time[rw] = jiffies;
 
 	bio_associate_current(bio);
 	tg->td->nr_queued[rw]++;
@@ -2058,6 +2236,10 @@ int blk_throtl_init(struct request_queue *q)
 	td->low_downgrade_time = jiffies;
 	td->low_history = DEFAULT_HISTORY;
 	throtl_calculate_low_interval(td);
+	td->high_upgrade_time = jiffies;
+	td->high_downgrade_time = jiffies;
+	td->high_history = DEFAULT_HISTORY;
+	throtl_calculate_high_interval(td);
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
-- 
2.8.0.rc2


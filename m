Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15007 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752551AbcEKAQp (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:16:45 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4B0CPVJ026380
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:44 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 22usxn80xy-6
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:44 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.236.87) with ESMTP	id
 a3accf74170d11e686830002c9521c9e-7ddfcc50 for <linux-block@vger.kernel.org>;
	Tue, 10 May 2016 17:16:43 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <vgoyal@redhat.com>, <axboe@fb.com>,
	<jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 05/10] block-throttle: add downgrade logic
Date: Tue, 10 May 2016 17:16:35 -0700
Message-ID: <a177d5a8ac4b38094beb1e72b70a3505fd00e4ea.1462923578.git.shli@fb.com>
In-Reply-To: <cover.1462923578.git.shli@fb.com>
References: <cover.1462923578.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When queue state machine is in higher state, say LIMIT_MAX state without
LIMIT_HIGH state, but a cgroup is below its low limit for some time, the
queue should be downgraded to lower state as cgroup's low limit doesn't
meet.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index df9cd13e..5806507 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -21,6 +21,7 @@ static int throtl_quantum = 32;
 /* Throttling is performed over 100ms slice and after that slice is renewed */
 static unsigned long throtl_slice = HZ/10;	/* 100 ms */
 
+static unsigned long cg_check_time = HZ/10;
 static struct blkcg_policy blkcg_policy_throtl;
 
 /* A workqueue to queue throttle related work */
@@ -136,6 +137,13 @@ struct throtl_grp {
 	/* Number of bio's dispatched in current slice */
 	unsigned int io_disp[2];
 
+	unsigned long last_low_overflow_time[2];
+
+	uint64_t last_bytes_disp[2];
+	unsigned int last_io_disp[2];
+
+	unsigned long last_check_time;
+
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -160,6 +168,11 @@ struct throtl_data
 	struct work_struct dispatch_work;
 	unsigned int limit_index;
 	bool limit_valid[LIMIT_CNT];
+
+	unsigned long low_upgrade_time;
+	unsigned long low_downgrade_time;
+	unsigned int low_upgrade_interval;
+	unsigned int low_downgrade_interval;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -906,6 +919,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	/* Charge the bio to the group */
 	tg->bytes_disp[rw] += bio->bi_iter.bi_size;
 	tg->io_disp[rw]++;
+	tg->last_bytes_disp[rw] += bio->bi_iter.bi_size;
+	tg->last_io_disp[rw]++;
 
 	/*
 	 * REQ_THROTTLED is used to prevent the same bio to be throttled
@@ -1525,6 +1540,38 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
+static unsigned long __tg_last_low_overflow_time(struct throtl_grp *tg)
+{
+	unsigned long rtime = -1, wtime = -1;
+	if (tg->bps[READ][LIMIT_LOW] || tg->iops[READ][LIMIT_LOW])
+		rtime = tg->last_low_overflow_time[READ];
+	if (tg->bps[WRITE][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW])
+		wtime = tg->last_low_overflow_time[WRITE];
+	return min(rtime, wtime);
+}
+
+static unsigned long tg_last_low_overflow_time(struct throtl_grp *tg)
+{
+	struct throtl_service_queue *parent_sq;
+	struct throtl_grp *parent = tg;
+	unsigned long ret = __tg_last_low_overflow_time(tg);
+
+	while (true) {
+		parent_sq = parent->service_queue.parent_sq;
+		parent = sq_to_tg(parent_sq);
+		if (!parent)
+			break;
+		if (parent->bps[READ][LIMIT_LOW] > tg->bps[READ][LIMIT_LOW] &&
+		    parent->bps[WRITE][LIMIT_LOW] > tg->bps[WRITE][LIMIT_LOW] &&
+		    parent->iops[READ][LIMIT_LOW] > tg->iops[READ][LIMIT_LOW] &&
+		    parent->iops[WRITE][LIMIT_LOW] > tg->iops[WRITE][LIMIT_LOW])
+			break;
+		if (time_after(__tg_last_low_overflow_time(parent), ret))
+			ret = __tg_last_low_overflow_time(parent);
+	}
+	return ret;
+}
+
 static bool throtl_upgrade_check_one(struct throtl_grp *tg)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
@@ -1564,6 +1611,10 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 	if (td->limit_index != LIMIT_LOW)
 		return false;
 
+	if (td->limit_index == LIMIT_LOW && time_before(jiffies,
+	    td->low_downgrade_time + td->low_upgrade_interval))
+		return false;
+
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 
@@ -1583,6 +1634,7 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	struct blkcg_gq *blkg;
 
 	td->limit_index = LIMIT_MAX;
+	td->low_upgrade_time = jiffies;
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 		struct throtl_service_queue *sq = &tg->service_queue;
@@ -1596,6 +1648,104 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	queue_work(kthrotld_workqueue, &td->dispatch_work);
 }
 
+static void throtl_downgrade_state(struct throtl_data *td, int new)
+{
+	td->limit_index = new;
+	td->low_downgrade_time = jiffies;
+}
+
+static bool throtl_downgrade_check_one(struct throtl_grp *tg)
+{
+	struct throtl_data *td = tg->td;
+	unsigned long now = jiffies;
+
+	/*
+	 * If cgroup is below low limit, consider downgrade and throttle other
+	 * cgroups
+	 */
+	if (time_after(now,
+	     td->low_upgrade_time + td->low_downgrade_interval) &&
+	    time_after(now,
+	     tg_last_low_overflow_time(tg) + td->low_downgrade_interval))
+		return true;
+	return false;
+}
+
+static bool throtl_downgrade_check_hierarchy(struct throtl_grp *tg)
+{
+	if (!throtl_downgrade_check_one(tg))
+		return false;
+	while (true) {
+		if (!tg || (cgroup_subsys_on_dfl(io_cgrp_subsys) &&
+			    !tg_to_blkg(tg)->parent))
+			break;
+
+		if (!throtl_downgrade_check_one(tg))
+			return false;
+		tg = sq_to_tg(tg->service_queue.parent_sq);
+	}
+	return true;
+}
+
+static void throtl_downgrade_check(struct throtl_grp *tg)
+{
+	uint64_t bps;
+	unsigned int iops;
+	unsigned long elapsed_time;
+	unsigned long now = jiffies;
+
+	if (tg->td->limit_index != LIMIT_MAX)
+		return;
+	if (!(tg->bps[READ][LIMIT_LOW] ||
+	      tg->bps[WRITE][LIMIT_LOW] ||
+	      tg->iops[WRITE][LIMIT_LOW] ||
+	      tg->iops[READ][LIMIT_LOW]))
+		return;
+
+	if (time_after(tg->last_check_time + throtl_slice, now))
+		return;
+	elapsed_time = now - tg->last_check_time;
+	tg->last_check_time = now;
+
+	if (tg->bps[READ][LIMIT_LOW]) {
+		bps = tg->last_bytes_disp[READ] * HZ;
+		do_div(bps, elapsed_time);
+		if (bps >= tg->bps[READ][LIMIT_LOW])
+			tg->last_low_overflow_time[READ] = now;
+	}
+
+	if (tg->bps[WRITE][LIMIT_LOW]) {
+		bps = tg->last_bytes_disp[WRITE] * HZ;
+		do_div(bps, elapsed_time);
+		if (bps >= tg->bps[WRITE][LIMIT_LOW])
+			tg->last_low_overflow_time[WRITE] = now;
+	}
+
+	if (tg->iops[READ][LIMIT_LOW]) {
+		iops = tg->last_io_disp[READ] * HZ / elapsed_time;
+		if (iops >= tg->iops[READ][LIMIT_LOW])
+			tg->last_low_overflow_time[READ] = now;
+	}
+
+	if (tg->iops[WRITE][LIMIT_LOW]) {
+		iops = tg->last_io_disp[WRITE] * HZ / elapsed_time;
+		if (iops >= tg->iops[WRITE][LIMIT_LOW])
+			tg->last_low_overflow_time[WRITE] = now;
+	}
+
+	/*
+	 * If cgroup is below low limit, consider downgrade and throttle other
+	 * cgroups
+	 */
+	if (throtl_downgrade_check_hierarchy(tg))
+		throtl_downgrade_state(tg->td, LIMIT_LOW);
+
+	tg->last_bytes_disp[READ] = 0;
+	tg->last_bytes_disp[WRITE] = 0;
+	tg->last_io_disp[READ] = 0;
+	tg->last_io_disp[WRITE] = 0;
+}
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -1620,12 +1770,16 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 again:
 	while (true) {
+		if (tg->last_low_overflow_time[rw] == 0)
+			tg->last_low_overflow_time[rw] = jiffies;
+		throtl_downgrade_check(tg);
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
 
 		/* if above limits, break to queue */
 		if (!tg_may_dispatch(tg, bio, NULL)) {
+			tg->last_low_overflow_time[rw] = jiffies;
 			if (throtl_can_upgrade(tg->td, tg)) {
 				throtl_upgrade_state(tg->td);
 				goto again;
@@ -1668,6 +1822,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		   tg->io_disp[rw], tg_iops_limit(tg, rw),
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
+	tg->last_low_overflow_time[rw] = jiffies;
+
 	bio_associate_current(bio);
 	tg->td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
@@ -1779,6 +1935,10 @@ int blk_throtl_init(struct request_queue *q)
 	td->limit_valid[LIMIT_LOW] = false;
 	td->limit_valid[LIMIT_MAX] = true;
 	td->limit_index = LIMIT_MAX;
+	td->low_upgrade_time = jiffies;
+	td->low_downgrade_time = jiffies;
+	td->low_upgrade_interval = cg_check_time;
+	td->low_downgrade_interval = cg_check_time;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
-- 
2.8.0.rc2


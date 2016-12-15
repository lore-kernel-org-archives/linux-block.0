Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60164 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756279AbcLOUdL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:11 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.17/8.16.0.17) with SMTP id uBFKUVno003250
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:10 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 27bvqb475d-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:10 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.97) with ESMTP  id
 b0c7b198c30511e6aff80002c9931860-7b7f6a50 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:08 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 06/17] blk-throttle: add downgrade logic
Date: Thu, 15 Dec 2016 12:32:57 -0800
Message-ID: <5c22098d912d73388bc214c1d7e404f25cfdad13.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When queue state machine is in LIMIT_MAX state, but a cgroup is below
its low limit for some time, the queue should be downgraded to lower
state as one cgroup's low limit isn't met.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index cfd74cfc..0f65fce 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -140,6 +140,13 @@ struct throtl_grp {
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
@@ -159,6 +166,9 @@ struct throtl_data
 	struct work_struct dispatch_work;
 	unsigned int limit_index;
 	bool limit_valid[LIMIT_CNT];
+
+	unsigned long low_upgrade_time;
+	unsigned long low_downgrade_time;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -896,6 +906,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	/* Charge the bio to the group */
 	tg->bytes_disp[rw] += bio->bi_iter.bi_size;
 	tg->io_disp[rw]++;
+	tg->last_bytes_disp[rw] += bio->bi_iter.bi_size;
+	tg->last_io_disp[rw]++;
 
 	/*
 	 * BIO_THROTTLED is used to prevent the same bio to be throttled
@@ -1511,6 +1523,36 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
+static unsigned long __tg_last_low_overflow_time(struct throtl_grp *tg)
+{
+	unsigned long rtime = -1, wtime = -1;
+
+	if (tg->bps[READ][LIMIT_LOW] != U64_MAX ||
+	    tg->iops[READ][LIMIT_LOW] != UINT_MAX)
+		rtime = tg->last_low_overflow_time[READ];
+	if (tg->bps[WRITE][LIMIT_LOW] != U64_MAX ||
+	    tg->iops[WRITE][LIMIT_LOW] != UINT_MAX)
+		wtime = tg->last_low_overflow_time[WRITE];
+	return min(rtime, wtime) == -1 ? 0 : min(rtime, wtime);
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
+		if (time_after(__tg_last_low_overflow_time(parent), ret))
+			ret = __tg_last_low_overflow_time(parent);
+	}
+	return ret;
+}
+
 static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
@@ -1555,6 +1597,9 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 	if (td->limit_index != LIMIT_LOW)
 		return false;
 
+	if (time_before(jiffies, td->low_downgrade_time + throtl_slice))
+		return false;
+
 	rcu_read_lock();
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
@@ -1578,6 +1623,7 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	struct blkcg_gq *blkg;
 
 	td->limit_index = LIMIT_MAX;
+	td->low_upgrade_time = jiffies;
 	rcu_read_lock();
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
@@ -1593,6 +1639,100 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	queue_work(kthrotld_workqueue, &td->dispatch_work);
 }
 
+static void throtl_downgrade_state(struct throtl_data *td, int new)
+{
+	td->limit_index = new;
+	td->low_downgrade_time = jiffies;
+}
+
+static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
+{
+	struct throtl_data *td = tg->td;
+	unsigned long now = jiffies;
+
+	/*
+	 * If cgroup is below low limit, consider downgrade and throttle other
+	 * cgroups
+	 */
+	if (time_after_eq(now, td->low_upgrade_time + throtl_slice) &&
+	    time_after_eq(now, tg_last_low_overflow_time(tg) + throtl_slice))
+		return true;
+	return false;
+}
+
+static bool throtl_hierarchy_can_downgrade(struct throtl_grp *tg)
+{
+	while (true) {
+		if (!throtl_tg_can_downgrade(tg))
+			return false;
+		tg = sq_to_tg(tg->service_queue.parent_sq);
+		if (!tg || (cgroup_subsys_on_dfl(io_cgrp_subsys) &&
+			    !tg_to_blkg(tg)->parent))
+			break;
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
+	if (tg->td->limit_index != LIMIT_MAX ||
+	    !tg->td->limit_valid[LIMIT_LOW])
+		return;
+	if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children))
+		return;
+	if (time_after(tg->last_check_time + throtl_slice, now))
+		return;
+
+	elapsed_time = now - tg->last_check_time;
+	tg->last_check_time = now;
+
+	if (time_before(now, tg_last_low_overflow_time(tg) + throtl_slice))
+		return;
+
+	if (tg->bps[READ][LIMIT_LOW] != U64_MAX) {
+		bps = tg->last_bytes_disp[READ] * HZ;
+		do_div(bps, elapsed_time);
+		if (bps >= tg->bps[READ][LIMIT_LOW])
+			tg->last_low_overflow_time[READ] = now;
+	}
+
+	if (tg->bps[WRITE][LIMIT_LOW] != U64_MAX) {
+		bps = tg->last_bytes_disp[WRITE] * HZ;
+		do_div(bps, elapsed_time);
+		if (bps >= tg->bps[WRITE][LIMIT_LOW])
+			tg->last_low_overflow_time[WRITE] = now;
+	}
+
+	if (tg->iops[READ][LIMIT_LOW] != UINT_MAX) {
+		iops = tg->last_io_disp[READ] * HZ / elapsed_time;
+		if (iops >= tg->iops[READ][LIMIT_LOW])
+			tg->last_low_overflow_time[READ] = now;
+	}
+
+	if (tg->iops[WRITE][LIMIT_LOW] != UINT_MAX) {
+		iops = tg->last_io_disp[WRITE] * HZ / elapsed_time;
+		if (iops >= tg->iops[WRITE][LIMIT_LOW])
+			tg->last_low_overflow_time[WRITE] = now;
+	}
+
+	/*
+	 * If cgroup is below low limit, consider downgrade and throttle other
+	 * cgroups
+	 */
+	if (throtl_hierarchy_can_downgrade(tg))
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
@@ -1617,12 +1757,16 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
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
@@ -1666,6 +1810,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		   tg->io_disp[rw], tg_iops_limit(tg, rw),
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
+	tg->last_low_overflow_time[rw] = jiffies;
+
 	bio_associate_current(bio);
 	tg->td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
@@ -1776,6 +1922,8 @@ int blk_throtl_init(struct request_queue *q)
 
 	td->limit_valid[LIMIT_MAX] = true;
 	td->limit_index = LIMIT_MAX;
+	td->low_upgrade_time = jiffies;
+	td->low_downgrade_time = jiffies;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
-- 
2.9.3


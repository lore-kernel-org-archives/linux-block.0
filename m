Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36499 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752597AbcJCVUg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 17:20:36 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.17/8.16.0.17) with SMTP id u93LIbXq020896
        for <linux-block@vger.kernel.org>; Mon, 3 Oct 2016 14:20:35 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 25t8mmx0jx-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2016 14:20:35 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.223.100.97) with ESMTP id
 379b525a89af11e6a23724be0593f280-71df7a50 for <linux-block@vger.kernel.org>;
        Mon, 03 Oct 2016 14:20:32 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH v3 05/11] block-throttle: add downgrade logic
Date: Mon, 3 Oct 2016 14:20:24 -0700
Message-ID: <ec1ea93a29a885c823da34217fb0ad7b83a982ab.1475529372.git.shli@fb.com>
In-Reply-To: <cover.1475529372.git.shli@fb.com>
References: <cover.1475529372.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When queue state machine is in LIMIT_MAX state, but a cgroup is below
its high limit for some time, the queue should be downgraded to lower
state as one cgroup's high limit isn't met.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index db2ea15..41b75a3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -136,6 +136,13 @@ struct throtl_grp {
 	/* Number of bio's dispatched in current slice */
 	unsigned int io_disp[2];
 
+	unsigned long last_high_overflow_time[2];
+
+	uint64_t last_bytes_disp[2];
+	unsigned int last_io_disp[2];
+
+	unsigned long last_check_time;
+
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -155,6 +162,9 @@ struct throtl_data
 	struct work_struct dispatch_work;
 	unsigned int limit_index;
 	bool limit_valid[LIMIT_CNT];
+
+	unsigned long high_upgrade_time;
+	unsigned long high_downgrade_time;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -896,6 +906,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	/* Charge the bio to the group */
 	tg->bytes_disp[rw] += bio->bi_iter.bi_size;
 	tg->io_disp[rw]++;
+	tg->last_bytes_disp[rw] += bio->bi_iter.bi_size;
+	tg->last_io_disp[rw]++;
 
 	/*
 	 * REQ_THROTTLED is used to prevent the same bio to be throttled
@@ -1510,6 +1522,64 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
+static unsigned long __tg_last_high_overflow_time(struct throtl_grp *tg)
+{
+	unsigned long rtime = -1, wtime = -1;
+	if (tg->bps[READ][LIMIT_HIGH] != -1 ||
+	    tg->iops[READ][LIMIT_HIGH] != -1 ||
+	    tg->bps[READ][LIMIT_MAX] != -1 ||
+	    tg->iops[READ][LIMIT_MAX] != -1)
+		rtime = tg->last_high_overflow_time[READ];
+	if (tg->bps[WRITE][LIMIT_HIGH] != -1 ||
+	    tg->iops[WRITE][LIMIT_HIGH] != -1 ||
+	    tg->bps[WRITE][LIMIT_MAX] != -1 ||
+	    tg->iops[WRITE][LIMIT_MAX] != -1)
+		wtime = tg->last_high_overflow_time[WRITE];
+	return min(rtime, wtime) == -1 ? 0 : min(rtime, wtime);
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
+		      parent->bps[READ][LIMIT_HIGH] >=
+		       tg->bps[READ][LIMIT_HIGH]) ||
+		     (parent->bps[READ][LIMIT_HIGH] == -1 &&
+		      parent->bps[READ][LIMIT_MAX] >=
+		       tg->bps[READ][LIMIT_HIGH])) &&
+		    ((parent->bps[WRITE][LIMIT_HIGH] != -1 &&
+		      parent->bps[WRITE][LIMIT_HIGH] >=
+		       tg->bps[WRITE][LIMIT_HIGH]) ||
+		     (parent->bps[WRITE][LIMIT_HIGH] == -1 &&
+		      parent->bps[WRITE][LIMIT_MAX] >=
+		       tg->bps[WRITE][LIMIT_HIGH])) &&
+		    ((parent->iops[READ][LIMIT_HIGH] != -1 &&
+		      parent->iops[READ][LIMIT_HIGH] >=
+		       tg->iops[READ][LIMIT_HIGH]) ||
+		     (parent->iops[READ][LIMIT_HIGH] == -1 &&
+		      parent->iops[READ][LIMIT_MAX] >=
+		       tg->iops[READ][LIMIT_HIGH])) &&
+		    ((parent->iops[WRITE][LIMIT_HIGH] != -1 &&
+		      parent->iops[WRITE][LIMIT_HIGH] >=
+		       tg->iops[WRITE][LIMIT_HIGH]) ||
+		     (parent->iops[WRITE][LIMIT_HIGH] == -1 &&
+		      parent->iops[WRITE][LIMIT_MAX] >=
+		       tg->iops[WRITE][LIMIT_HIGH])))
+			break;
+		if (time_after(__tg_last_high_overflow_time(parent), ret))
+			ret = __tg_last_high_overflow_time(parent);
+	}
+	return ret;
+}
+
 static bool throtl_upgrade_check_one(struct throtl_grp *tg)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
@@ -1557,6 +1627,9 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 	if (td->limit_index != LIMIT_HIGH)
 		return false;
 
+	if (time_before(jiffies, td->high_downgrade_time + throtl_slice))
+		return false;
+
 	rcu_read_lock();
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
@@ -1580,6 +1653,7 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	struct blkcg_gq *blkg;
 
 	td->limit_index = LIMIT_MAX;
+	td->high_upgrade_time = jiffies;
 	rcu_read_lock();
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
@@ -1595,6 +1669,111 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	queue_work(kthrotld_workqueue, &td->dispatch_work);
 }
 
+static void throtl_downgrade_state(struct throtl_data *td, int new)
+{
+	td->limit_index = new;
+	td->high_downgrade_time = jiffies;
+}
+
+static bool throtl_downgrade_check_one(struct throtl_grp *tg)
+{
+	struct throtl_data *td = tg->td;
+	unsigned long now = jiffies;
+
+	/*
+	 * If cgroup is below high limit, consider downgrade and throttle other
+	 * cgroups
+	 */
+	if (time_after_eq(now, td->high_upgrade_time + throtl_slice) &&
+	    time_after_eq(now, tg_last_high_overflow_time(tg) + throtl_slice))
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
+	if (tg->td->limit_index != LIMIT_MAX ||
+	    !tg->td->limit_valid[LIMIT_HIGH])
+		return;
+	if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children))
+		return;
+	if (time_after(tg->last_check_time + throtl_slice, now))
+		return;
+
+	if (time_before(now, tg_last_high_overflow_time(tg) + throtl_slice))
+		return;
+
+	elapsed_time = now - tg->last_check_time;
+	tg->last_check_time = now;
+
+	if (tg->bps[READ][LIMIT_HIGH] != -1 ||
+	    tg->bps[READ][LIMIT_MAX] != -1) {
+		bps = tg->last_bytes_disp[READ] * HZ;
+		do_div(bps, elapsed_time);
+		if (bps >= tg->bps[READ][LIMIT_HIGH] ||
+		    bps >= tg->bps[READ][LIMIT_MAX])
+			tg->last_high_overflow_time[READ] = now;
+	}
+
+	if (tg->bps[WRITE][LIMIT_HIGH] != -1 ||
+	    tg->bps[WRITE][LIMIT_MAX] != -1) {
+		bps = tg->last_bytes_disp[WRITE] * HZ;
+		do_div(bps, elapsed_time);
+		if (bps >= tg->bps[WRITE][LIMIT_HIGH] ||
+		    bps >= tg->bps[WRITE][LIMIT_MAX])
+			tg->last_high_overflow_time[WRITE] = now;
+	}
+
+	if (tg->iops[READ][LIMIT_HIGH] != -1 ||
+	    tg->iops[READ][LIMIT_MAX] != -1) {
+		iops = tg->last_io_disp[READ] * HZ / elapsed_time;
+		if (iops >= tg->iops[READ][LIMIT_HIGH] ||
+		    iops >= tg->iops[READ][LIMIT_MAX])
+			tg->last_high_overflow_time[READ] = now;
+	}
+
+	if (tg->iops[WRITE][LIMIT_HIGH] != -1 ||
+	    tg->iops[WRITE][LIMIT_MAX] != -1) {
+		iops = tg->last_io_disp[WRITE] * HZ / elapsed_time;
+		if (iops >= tg->iops[WRITE][LIMIT_HIGH] ||
+		    iops >= tg->iops[WRITE][LIMIT_MAX])
+			tg->last_high_overflow_time[WRITE] = now;
+	}
+
+	/*
+	 * If cgroup is below high limit, consider downgrade and throttle other
+	 * cgroups
+	 */
+	if (throtl_downgrade_check_hierarchy(tg))
+		throtl_downgrade_state(tg->td, LIMIT_HIGH);
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
@@ -1619,12 +1798,16 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 again:
 	while (true) {
+		if (tg->last_high_overflow_time[rw] == 0)
+			tg->last_high_overflow_time[rw] = jiffies;
+		throtl_downgrade_check(tg);
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
 
 		/* if above limits, break to queue */
 		if (!tg_may_dispatch(tg, bio, NULL)) {
+			tg->last_high_overflow_time[rw] = jiffies;
 			if (throtl_can_upgrade(tg->td, tg)) {
 				throtl_upgrade_state(tg->td);
 				goto again;
@@ -1667,6 +1850,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		   tg->io_disp[rw], tg_iops_limit(tg, rw),
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
+	tg->last_high_overflow_time[rw] = jiffies;
+
 	bio_associate_current(bio);
 	tg->td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
@@ -1778,6 +1963,8 @@ int blk_throtl_init(struct request_queue *q)
 	td->limit_valid[LIMIT_HIGH] = false;
 	td->limit_valid[LIMIT_MAX] = true;
 	td->limit_index = LIMIT_MAX;
+	td->high_upgrade_time = jiffies;
+	td->high_downgrade_time = jiffies;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
-- 
2.9.3


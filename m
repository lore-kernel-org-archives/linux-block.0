Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756275AbcLOUdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:10 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFKVvON023892
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:10 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 27bdne5btm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:10 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.97) with ESMTP id
 b0bb7cacc30511e682860002c99331b0-87bf4a50 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:08 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 05/17] blk-throttle: add upgrade logic for LIMIT_LOW state
Date: Thu, 15 Dec 2016 12:32:56 -0800
Message-ID: <75685643afd126cbccefe894ca56fd5dd83fe8cf.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When queue is in LIMIT_LOW state and all cgroups with low limit cross
the bps/iops limitation, we will upgrade queue's state to
LIMIT_MAX

For a cgroup hierarchy, there are two cases. Children has lower low
limit than parent. Parent's low limit is meaningless. If children's
bps/iops cross low limit, we can upgrade queue state. The other case is
children has higher low limit than parent. Children's low limit is
meaningless. As long as parent's bps/iops cross low limit, we can
upgrade queue state.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e55bd36..cfd74cfc 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -455,6 +455,7 @@ static void blk_throtl_update_valid_limit(struct throtl_data *td)
 		td->limit_valid[LIMIT_LOW] = false;
 }
 
+static void throtl_upgrade_state(struct throtl_data *td);
 static void throtl_pd_offline(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
@@ -466,9 +467,8 @@ static void throtl_pd_offline(struct blkg_policy_data *pd)
 
 	blk_throtl_update_valid_limit(tg->td);
 
-	if (tg->td->limit_index == LIMIT_LOW &&
-	    !tg->td->limit_valid[LIMIT_LOW])
-		tg->td->limit_index = LIMIT_MAX;
+	if (!tg->td->limit_valid[tg->td->limit_index])
+		throtl_upgrade_state(tg->td);
 }
 
 static void throtl_pd_free(struct blkg_policy_data *pd)
@@ -1077,6 +1077,8 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 	return nr_disp;
 }
 
+static bool throtl_can_upgrade(struct throtl_data *td,
+	struct throtl_grp *this_tg);
 /**
  * throtl_pending_timer_fn - timer function for service_queue->pending_timer
  * @arg: the throtl_service_queue being serviced
@@ -1103,6 +1105,9 @@ static void throtl_pending_timer_fn(unsigned long arg)
 	int ret;
 
 	spin_lock_irq(q->queue_lock);
+	if (throtl_can_upgrade(td, NULL))
+		throtl_upgrade_state(td);
+
 again:
 	parent_sq = sq->parent_sq;
 	dispatched = false;
@@ -1506,6 +1511,88 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
+static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
+{
+	struct throtl_service_queue *sq = &tg->service_queue;
+	bool read_limit, write_limit;
+
+	/*
+	 * if cgroup reaches low/max limit (max >= low), it's ok to next
+	 * limit
+	 */
+	read_limit = tg->bps[READ][LIMIT_LOW] != U64_MAX ||
+		     tg->iops[READ][LIMIT_LOW] != UINT_MAX;
+	write_limit = tg->bps[WRITE][LIMIT_LOW] != U64_MAX ||
+		      tg->iops[WRITE][LIMIT_LOW] != UINT_MAX;
+	if (read_limit && sq->nr_queued[READ] &&
+	    (!write_limit || sq->nr_queued[WRITE]))
+		return true;
+	if (write_limit && sq->nr_queued[WRITE] &&
+	    (!read_limit || sq->nr_queued[READ]))
+		return true;
+	return false;
+}
+
+static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
+{
+	while (true) {
+		if (throtl_tg_can_upgrade(tg))
+			return true;
+		tg = sq_to_tg(tg->service_queue.parent_sq);
+		if (!tg || (cgroup_subsys_on_dfl(io_cgrp_subsys) &&
+				!tg_to_blkg(tg)->parent))
+			return false;
+	}
+	return false;
+}
+
+static bool throtl_can_upgrade(struct throtl_data *td,
+	struct throtl_grp *this_tg)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+
+	if (td->limit_index != LIMIT_LOW)
+		return false;
+
+	rcu_read_lock();
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+
+		if (tg == this_tg)
+			continue;
+		if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children))
+			continue;
+		if (!throtl_hierarchy_can_upgrade(tg)) {
+			rcu_read_unlock();
+			return false;
+		}
+	}
+	rcu_read_unlock();
+	return true;
+}
+
+static void throtl_upgrade_state(struct throtl_data *td)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+
+	td->limit_index = LIMIT_MAX;
+	rcu_read_lock();
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+		struct throtl_service_queue *sq = &tg->service_queue;
+
+		tg->disptime = jiffies - 1;
+		throtl_select_dispatch(sq);
+		throtl_schedule_next_dispatch(sq, false);
+	}
+	rcu_read_unlock();
+	throtl_select_dispatch(&td->service_queue);
+	throtl_schedule_next_dispatch(&td->service_queue, false);
+	queue_work(kthrotld_workqueue, &td->dispatch_work);
+}
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -1528,14 +1615,20 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	sq = &tg->service_queue;
 
+again:
 	while (true) {
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
 
 		/* if above limits, break to queue */
-		if (!tg_may_dispatch(tg, bio, NULL))
+		if (!tg_may_dispatch(tg, bio, NULL)) {
+			if (throtl_can_upgrade(tg->td, tg)) {
+				throtl_upgrade_state(tg->td);
+				goto again;
+			}
 			break;
+		}
 
 		/* within limits, let's charge and dispatch directly */
 		throtl_charge_bio(tg, bio);
-- 
2.9.3


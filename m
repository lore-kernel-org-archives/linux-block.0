Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56673 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752092AbcEKAQp (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:16:45 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.16.0.11/8.16.0.11) with SMTP id u4B0FgWA017994
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:44 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0089730.ppops.net with ESMTP id 22ur09gj34-3
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:44 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.232.59) with ESMTP	id
 a3a9d9e0170d11e6b37b0002c991e86a-d20d8c50 for <linux-block@vger.kernel.org>;
	Tue, 10 May 2016 17:16:43 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <vgoyal@redhat.com>, <axboe@fb.com>,
	<jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 04/10] block-throttle: add upgrade logic for LIMIT_LOW state
Date: Tue, 10 May 2016 17:16:34 -0700
Message-ID: <a7deac556b6f0185b198e4f19c56c9b2137445b5.1462923578.git.shli@fb.com>
In-Reply-To: <cover.1462923578.git.shli@fb.com>
References: <cover.1462923578.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When queue is in LIMIT_LOW state and all cgroups with low limit cross
the bps/iops limitation, we will upgrade queue's state to
LIMIT_HIGH/LIMIT_MAX

For a cgroup hierarchy, there are two cases. Children has lower low
limit than parent. Parent's low limit is meaningless. If children's
bps/iops cross low limit, we can upgrade queue state. The other case is
children has higher low limit than parent. Children's low limit is
meaningless. As long as parent's bps/iops cross low limit, we can
upgrade queue state.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index bdcf1b7..df9cd13e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -468,6 +468,7 @@ static void blk_throtl_update_valid_limit(struct throtl_data *td)
 		td->limit_valid[LIMIT_LOW] = false;
 }
 
+static void throtl_upgrade_state(struct throtl_data *td);
 static void throtl_pd_offline(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
@@ -479,9 +480,8 @@ static void throtl_pd_offline(struct blkg_policy_data *pd)
 
 	blk_throtl_update_valid_limit(tg->td);
 
-	if (tg->td->limit_index == LIMIT_LOW &&
-	    !tg->td->limit_valid[LIMIT_LOW])
-		tg->td->limit_index = LIMIT_MAX;
+	if (!tg->td->limit_valid[tg->td->limit_index])
+		throtl_upgrade_state(tg->td);
 }
 
 static void throtl_pd_free(struct blkg_policy_data *pd)
@@ -1087,6 +1087,8 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 	return nr_disp;
 }
 
+static bool throtl_can_upgrade(struct throtl_data *td,
+	struct throtl_grp *this_tg);
 /**
  * throtl_pending_timer_fn - timer function for service_queue->pending_timer
  * @arg: the throtl_service_queue being serviced
@@ -1113,6 +1115,9 @@ static void throtl_pending_timer_fn(unsigned long arg)
 	int ret;
 
 	spin_lock_irq(q->queue_lock);
+	if (throtl_can_upgrade(td, NULL))
+		throtl_upgrade_state(td);
+
 again:
 	parent_sq = sq->parent_sq;
 	dispatched = false;
@@ -1520,6 +1525,77 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
+static bool throtl_upgrade_check_one(struct throtl_grp *tg)
+{
+	struct throtl_service_queue *sq = &tg->service_queue;
+
+	if (tg->bps[READ][LIMIT_LOW] != 0 && !sq->nr_queued[READ])
+		return false;
+	if (tg->bps[WRITE][LIMIT_LOW] != 0 && !sq->nr_queued[WRITE])
+		return false;
+	if (tg->iops[READ][LIMIT_LOW] != 0 && !sq->nr_queued[READ])
+		return false;
+	if (tg->iops[WRITE][LIMIT_LOW] != 0 && !sq->nr_queued[WRITE])
+		return false;
+	return true;
+}
+
+static bool throtl_upgrade_check_hierarchy(struct throtl_grp *tg)
+{
+	if (throtl_upgrade_check_one(tg))
+		return true;
+	while (true) {
+		if (!tg || (cgroup_subsys_on_dfl(io_cgrp_subsys) &&
+				!tg_to_blkg(tg)->parent))
+			return false;
+		if (throtl_upgrade_check_one(tg))
+			return true;
+		tg = sq_to_tg(tg->service_queue.parent_sq);
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
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+
+		if (tg == this_tg)
+			continue;
+		if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children))
+			continue;
+		if (!throtl_upgrade_check_hierarchy(tg))
+			return false;
+	}
+	return true;
+}
+
+static void throtl_upgrade_state(struct throtl_data *td)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+
+	td->limit_index = LIMIT_MAX;
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+		struct throtl_service_queue *sq = &tg->service_queue;
+
+		tg->disptime = jiffies - 1;
+		throtl_select_dispatch(sq);
+		throtl_schedule_next_dispatch(sq, false);
+	}
+	throtl_select_dispatch(&td->service_queue);
+	throtl_schedule_next_dispatch(&td->service_queue, false);
+	queue_work(kthrotld_workqueue, &td->dispatch_work);
+}
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -1542,14 +1618,20 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
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
2.8.0.rc2


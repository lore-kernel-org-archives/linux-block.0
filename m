Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33474 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754834AbcIOQXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 12:23:22 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8FGFFc8022599
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:21 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 25fww30vgy-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:21 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)     by
 mx-out.facebook.com (10.223.101.97) with ESMTP id
 b68c699e7b6011e6ab6e24be0595f910-1bdfaa50 for <linux-block@vger.kernel.org>;
        Thu, 15 Sep 2016 09:23:19 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH V2 04/11] block-throttle: add upgrade logic for LIMIT_HIGH state
Date: Thu, 15 Sep 2016 09:23:11 -0700
Message-ID: <6218af07fac14a75bd922ccaab81698c511f1b25.1473953743.git.shli@fb.com>
In-Reply-To: <cover.1473953743.git.shli@fb.com>
References: <cover.1473953743.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When queue is in LIMIT_HIGH state and all cgroups with high limit cross
the bps/iops limitation, we will upgrade queue's state to
LIMIT_MAX

For a cgroup hierarchy, there are two cases. Children has lower high
limit than parent. Parent's high limit is meaningless. If children's
bps/iops cross high limit, we can upgrade queue state. The other case is
children has higher high limit than parent. Children's high limit is
meaningless. As long as parent's bps/iops cross high limit, we can
upgrade queue state.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6bae1b4..80b50cc 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -456,6 +456,7 @@ static void blk_throtl_update_valid_limit(struct throtl_data *td)
 		td->limit_valid[LIMIT_HIGH] = false;
 }
 
+static void throtl_upgrade_state(struct throtl_data *td);
 static void throtl_pd_offline(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
@@ -467,9 +468,8 @@ static void throtl_pd_offline(struct blkg_policy_data *pd)
 
 	blk_throtl_update_valid_limit(tg->td);
 
-	if (tg->td->limit_index == LIMIT_HIGH &&
-	    !tg->td->limit_valid[LIMIT_HIGH])
-		tg->td->limit_index = LIMIT_MAX;
+	if (!tg->td->limit_valid[tg->td->limit_index])
+		throtl_upgrade_state(tg->td);
 }
 
 static void throtl_pd_free(struct blkg_policy_data *pd)
@@ -1075,6 +1075,8 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 	return nr_disp;
 }
 
+static bool throtl_can_upgrade(struct throtl_data *td,
+	struct throtl_grp *this_tg);
 /**
  * throtl_pending_timer_fn - timer function for service_queue->pending_timer
  * @arg: the throtl_service_queue being serviced
@@ -1101,6 +1103,9 @@ static void throtl_pending_timer_fn(unsigned long arg)
 	int ret;
 
 	spin_lock_irq(q->queue_lock);
+	if (throtl_can_upgrade(td, NULL))
+		throtl_upgrade_state(td);
+
 again:
 	parent_sq = sq->parent_sq;
 	dispatched = false;
@@ -1503,6 +1508,91 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
+static bool throtl_upgrade_check_one(struct throtl_grp *tg)
+{
+	struct throtl_service_queue *sq = &tg->service_queue;
+	bool read_limit, write_limit;
+
+	/* if cgroup reaches high/max limit, it's ok to next limit */
+	read_limit = tg->bps[READ][LIMIT_HIGH] != -1 ||
+		     tg->iops[READ][LIMIT_HIGH] != -1 ||
+		     tg->bps[READ][LIMIT_MAX] != -1 ||
+		     tg->iops[READ][LIMIT_MAX] != -1;
+	write_limit = tg->bps[WRITE][LIMIT_HIGH] != -1 ||
+		      tg->iops[WRITE][LIMIT_HIGH] != -1 ||
+		      tg->bps[WRITE][LIMIT_MAX] != -1 ||
+		      tg->iops[WRITE][LIMIT_MAX] != -1;
+	if (read_limit && sq->nr_queued[READ] &&
+	    (!write_limit || sq->nr_queued[WRITE]))
+		return true;
+	if (write_limit && sq->nr_queued[WRITE] &&
+	    (!read_limit || sq->nr_queued[READ]))
+		return true;
+	return false;
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
+	if (td->limit_index != LIMIT_HIGH)
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
+		if (!throtl_upgrade_check_hierarchy(tg)) {
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
@@ -1525,14 +1615,20 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
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


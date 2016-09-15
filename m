Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33485 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754891AbcIOQXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 12:23:22 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8FGFE6a022591
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:22 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 25fww30vgw-6
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:22 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)     by
 mx-out.facebook.com (10.223.100.99) with ESMTP id
 b76616447b6011e680c424be05956610-7b8e2a50 for <linux-block@vger.kernel.org>;
        Thu, 15 Sep 2016 09:23:20 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH V2 11/11] blk-throttle: ignore idle cgroup limit
Date: Thu, 15 Sep 2016 09:23:18 -0700
Message-ID: <8c687c3d686fda706084b748e757e8b9e1cffd47.1473953743.git.shli@fb.com>
In-Reply-To: <cover.1473953743.git.shli@fb.com>
References: <cover.1473953743.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Last patch introduces a way to detect idle cgroup. We use it to make
upgrade/downgrade decision.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 0810e1b..276e71e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -145,8 +145,6 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
-	unsigned long last_dispatch_time[2];
-
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -488,8 +486,6 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	 * Update has_rules[] after a new group is brought online.
 	 */
 	tg_update_has_rules(tg);
-	tg->last_dispatch_time[READ] = jiffies;
-	tg->last_dispatch_time[WRITE] = jiffies;
 }
 
 static void blk_throtl_update_valid_limit(struct throtl_data *td)
@@ -1661,9 +1657,8 @@ static bool throtl_upgrade_check_one(struct throtl_grp *tg)
 		return true;
 
 	if (time_after_eq(jiffies,
-	     tg->last_dispatch_time[READ] + tg->td->throtl_slice) &&
-	    time_after_eq(jiffies,
-	     tg->last_dispatch_time[WRITE] + tg->td->throtl_slice))
+		tg_last_high_overflow_time(tg) + tg->td->throtl_slice) &&
+	    throtl_tg_is_idle(tg))
 		return true;
 	return false;
 }
@@ -1712,6 +1707,19 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 	return true;
 }
 
+static void throtl_upgrade_check(struct throtl_grp *tg)
+{
+	if (tg->td->limit_index != LIMIT_HIGH)
+		return;
+
+	if (!time_after_eq(jiffies,
+	     __tg_last_high_overflow_time(tg) + tg->td->throtl_slice))
+		return;
+
+	if (throtl_can_upgrade(tg->td, NULL))
+		throtl_upgrade_state(tg->td);
+}
+
 static void throtl_upgrade_state(struct throtl_data *td)
 {
 	struct cgroup_subsys_state *pos_css;
@@ -1746,15 +1754,13 @@ static bool throtl_downgrade_check_one(struct throtl_grp *tg)
 	struct throtl_data *td = tg->td;
 	unsigned long now = jiffies;
 
-	if (time_after_eq(now, tg->last_dispatch_time[READ] + td->throtl_slice) &&
-	    time_after_eq(now, tg->last_dispatch_time[WRITE] + td->throtl_slice))
-		return false;
 	/*
 	 * If cgroup is below high limit, consider downgrade and throttle other
 	 * cgroups
 	 */
 	if (time_after_eq(now, td->high_upgrade_time + td->throtl_slice) &&
-	    time_after_eq(now, tg_last_high_overflow_time(tg) + td->throtl_slice))
+	    time_after_eq(now, tg_last_high_overflow_time(tg) + td->throtl_slice) &&
+	    !throtl_tg_is_idle(tg))
 		return true;
 	return false;
 }
@@ -1885,10 +1891,10 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 again:
 	while (true) {
-		tg->last_dispatch_time[rw] = jiffies;
 		if (tg->last_high_overflow_time[rw] == 0)
 			tg->last_high_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
+		throtl_upgrade_check(tg);
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
-- 
2.8.0.rc2


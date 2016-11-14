Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55726 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965102AbcKNWW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 17:22:27 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAEMJNK1008040
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:27 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 26qkrj8s6a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:27 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.223.100.99) with ESMTP id
 d1b8cd84aab811e6822c24be05956610-870e8a50 for <linux-block@vger.kernel.org>;
        Mon, 14 Nov 2016 14:22:25 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V4 12/15] blk-throttle: ignore idle cgroup limit
Date: Mon, 14 Nov 2016 14:22:19 -0800
Message-ID: <81c80afa8e1124e53d67f2d61dade2ce9768e4c7.1479161136.git.shli@fb.com>
In-Reply-To: <cover.1479161136.git.shli@fb.com>
References: <cover.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Last patch introduces a way to detect idle cgroup. We use it to make
upgrade/downgrade decision. And the new algorithm can detect completely
idle cgroup too, so we can delete the corresponding code.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e403e88..01b494d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -146,8 +146,7 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
-	unsigned long last_dispatch_time[2];
-
+	int upgrade_check_batch;
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -487,8 +486,6 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	 * Update has_rules[] after a new group is brought online.
 	 */
 	tg_update_has_rules(tg);
-	tg->last_dispatch_time[READ] = jiffies;
-	tg->last_dispatch_time[WRITE] = jiffies;
 }
 
 static void blk_throtl_update_valid_limit(struct throtl_data *td)
@@ -1667,9 +1664,8 @@ static bool throtl_upgrade_check_one(struct throtl_grp *tg)
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
@@ -1718,6 +1714,24 @@ static bool throtl_can_upgrade(struct throtl_data *td,
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
+	tg->upgrade_check_batch++;
+	if (tg->upgrade_check_batch < 16)
+		return;
+	tg->upgrade_check_batch = 0;
+
+	if (throtl_can_upgrade(tg->td, NULL))
+		throtl_upgrade_state(tg->td);
+}
+
 static void throtl_upgrade_state(struct throtl_data *td)
 {
 	struct cgroup_subsys_state *pos_css;
@@ -1752,18 +1766,15 @@ static bool throtl_downgrade_check_one(struct throtl_grp *tg)
 	struct throtl_data *td = tg->td;
 	unsigned long now = jiffies;
 
-	if (time_after_eq(now, tg->last_dispatch_time[READ] +
-					td->throtl_slice) &&
-	    time_after_eq(now, tg->last_dispatch_time[WRITE] +
-					td->throtl_slice))
-		return false;
 	/*
 	 * If cgroup is below high limit, consider downgrade and throttle other
 	 * cgroups
 	 */
 	if (time_after_eq(now, td->high_upgrade_time + td->throtl_slice) &&
 	    time_after_eq(now, tg_last_high_overflow_time(tg) +
-					td->throtl_slice))
+					td->throtl_slice) &&
+	    (!throtl_tg_is_idle(tg) ||
+	     !list_empty(&tg_to_blkg(tg)->blkcg->css.children)))
 		return true;
 	return false;
 }
@@ -1902,10 +1913,10 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
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
2.9.3


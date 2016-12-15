Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47706 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756361AbcLOUdS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:18 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFKVvxD023894
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:13 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 27bdne5btj-11
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:13 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.97) with ESMTP  id
 b115b046c30511e68ab30002c9931860-7e7fca50 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:09 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 13/17] blk-throttle: ignore idle cgroup limit
Date: Thu, 15 Dec 2016 12:33:04 -0800
Message-ID: <c577fd0ec47f2e301bba98eacfd0de66f13ed7e2.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Last patch introduces a way to detect idle cgroup. We use it to make
upgrade/downgrade decision. And the new algorithm can detect completely
idle cgroup too, so we can delete the corresponding code.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 0218ff9..62fe72ea 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -151,8 +151,6 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
-	unsigned long last_dispatch_time[2];
-
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -495,8 +493,6 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	 * Update has_rules[] after a new group is brought online.
 	 */
 	tg_update_has_rules(tg);
-	tg->last_dispatch_time[READ] = jiffies;
-	tg->last_dispatch_time[WRITE] = jiffies;
 }
 
 static void blk_throtl_update_valid_limit(struct throtl_data *td)
@@ -1669,9 +1665,8 @@ static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
 		return true;
 
 	if (time_after_eq(jiffies,
-	     tg->last_dispatch_time[READ] + tg->td->throtl_slice) &&
-	    time_after_eq(jiffies,
-	     tg->last_dispatch_time[WRITE] + tg->td->throtl_slice))
+		tg_last_low_overflow_time(tg) + tg->td->throtl_slice) &&
+	    throtl_tg_is_idle(tg))
 		return true;
 	return false;
 }
@@ -1718,6 +1713,26 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 	return true;
 }
 
+static void throtl_upgrade_check(struct throtl_grp *tg)
+{
+	unsigned long now = jiffies;
+
+	if (tg->td->limit_index != LIMIT_LOW)
+		return;
+
+	if (time_after(tg->last_check_time + tg->td->throtl_slice, now))
+		return;
+
+	tg->last_check_time = now;
+
+	if (!time_after_eq(now,
+	     __tg_last_low_overflow_time(tg) + tg->td->throtl_slice))
+		return;
+
+	if (throtl_can_upgrade(tg->td, NULL))
+		throtl_upgrade_state(tg->td);
+}
+
 static void throtl_upgrade_state(struct throtl_data *td)
 {
 	struct cgroup_subsys_state *pos_css;
@@ -1759,18 +1774,15 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
 	struct throtl_data *td = tg->td;
 	unsigned long now = jiffies;
 
-	if (time_after_eq(now, tg->last_dispatch_time[READ] +
-					td->throtl_slice) &&
-	    time_after_eq(now, tg->last_dispatch_time[WRITE] +
-					td->throtl_slice))
-		return false;
 	/*
 	 * If cgroup is below low limit, consider downgrade and throttle other
 	 * cgroups
 	 */
 	if (time_after_eq(now, td->low_upgrade_time + td->throtl_slice) &&
 	    time_after_eq(now, tg_last_low_overflow_time(tg) +
-					td->throtl_slice))
+					td->throtl_slice) &&
+	    (!throtl_tg_is_idle(tg) ||
+	     !list_empty(&tg_to_blkg(tg)->blkcg->css.children)))
 		return true;
 	return false;
 }
@@ -1904,10 +1916,10 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 again:
 	while (true) {
-		tg->last_dispatch_time[rw] = jiffies;
 		if (tg->last_low_overflow_time[rw] == 0)
 			tg->last_low_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
+		throtl_upgrade_check(tg);
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
-- 
2.9.3


Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50093 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750892AbdAODmi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:38 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0F3dQ4a016909
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:37 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27yjkk1c0x-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:37 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.99) with ESMTP id
 a786e04adad411e6a53b0002c99293a0-d826b6d0 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:35 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 10/18] blk-throttle: detect completed idle cgroup
Date: Sat, 14 Jan 2017 19:42:27 -0800
Message-ID: <cc2ae49f8c867be9adefa4491db56613ae142278.1484451062.git.shli@fb.com>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
References: <cover.1484451062.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

cgroup could be assigned a limit, but doesn't dispatch enough IO, eg the
cgroup is idle. When this happens, the cgroup doesn't hit its limit, so
we can't move the state machine to higher level and all cgroups will be
throttled to their lower limit, so we waste bandwidth. Detecting idle
cgroup is hard. This patch handles a simple case, a cgroup doesn't
dispatch any IO. We ignore such cgroup's limit, so other cgroups can use
the bandwidth.

Please note this will be replaced with a more sophisticated algorithm
later, but this demonstrates the idea how we handle idle cgroups, so I
leave it here.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2d05c91..b3ce176 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -149,6 +149,8 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
+	unsigned long last_dispatch_time[2];
+
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -445,11 +447,14 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 
 static void throtl_pd_online(struct blkg_policy_data *pd)
 {
+	struct throtl_grp *tg = pd_to_tg(pd);
 	/*
 	 * We don't want new groups to escape the limits of its ancestors.
 	 * Update has_rules[] after a new group is brought online.
 	 */
-	tg_update_has_rules(pd_to_tg(pd));
+	tg_update_has_rules(tg);
+	tg->last_dispatch_time[READ] = jiffies;
+	tg->last_dispatch_time[WRITE] = jiffies;
 }
 
 static void blk_throtl_update_limit_valid(struct throtl_data *td)
@@ -1611,6 +1616,12 @@ static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
 	if (write_limit && sq->nr_queued[WRITE] &&
 	    (!read_limit || sq->nr_queued[READ]))
 		return true;
+
+	if (time_after_eq(jiffies,
+	     tg->last_dispatch_time[READ] + tg->td->throtl_slice) &&
+	    time_after_eq(jiffies,
+	     tg->last_dispatch_time[WRITE] + tg->td->throtl_slice))
+		return true;
 	return false;
 }
 
@@ -1688,6 +1699,11 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
 	struct throtl_data *td = tg->td;
 	unsigned long now = jiffies;
 
+	if (time_after_eq(now, tg->last_dispatch_time[READ] +
+					td->throtl_slice) &&
+	    time_after_eq(now, tg->last_dispatch_time[WRITE] +
+					td->throtl_slice))
+		return false;
 	/*
 	 * If cgroup is below low limit, consider downgrade and throttle other
 	 * cgroups
@@ -1796,6 +1812,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 again:
 	while (true) {
+		tg->last_dispatch_time[rw] = jiffies;
 		if (tg->last_low_overflow_time[rw] == 0)
 			tg->last_low_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
-- 
2.9.3


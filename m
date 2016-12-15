Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60167 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756281AbcLOUdL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:11 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.17/8.16.0.17) with SMTP id uBFKUVnp003250
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:11 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 27bvqb475d-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:11 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.99) with ESMTP  id
 b0ea7124c30511e699290002c9dfb610-2d9f5a50 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:09 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 09/17] blk-throttle: detect completed idle cgroup
Date: Thu, 15 Dec 2016 12:33:00 -0800
Message-ID: <9c3254d92f47a5172e83fc1e84c09fca8243a1e7.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
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

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index cd10c65..a0ba961 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -148,6 +148,8 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
+	unsigned long last_dispatch_time[2];
+
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -437,11 +439,14 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 
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
 
 static void blk_throtl_update_valid_limit(struct throtl_data *td)
@@ -1582,6 +1587,12 @@ static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
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
 
@@ -1660,6 +1671,11 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
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
@@ -1769,6 +1785,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 again:
 	while (true) {
+		tg->last_dispatch_time[rw] = jiffies;
 		if (tg->last_low_overflow_time[rw] == 0)
 			tg->last_low_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
-- 
2.9.3


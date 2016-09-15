Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33483 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754868AbcIOQXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 12:23:22 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8FGFCYk022570
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:22 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 25fww30vgx-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:22 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)     by
 mx-out.facebook.com (10.223.100.97) with ESMTP id
 b6fb9e4a7b6011e6a8e524be0593f280-f85fba50 for <linux-block@vger.kernel.org>;
        Thu, 15 Sep 2016 09:23:20 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH V2 08/11] blk-throttle: detect completed idle cgroup
Date: Thu, 15 Sep 2016 09:23:15 -0700
Message-ID: <9519a7a7ff79d702b9a4d6591734e17b4e39f92f.1473953743.git.shli@fb.com>
In-Reply-To: <cover.1473953743.git.shli@fb.com>
References: <cover.1473953743.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

cgroup could be assigned a limit, but doesn't dispatch enough IO, eg the
cgroup is idle. When this happens, the cgroup doesn't hit its limit, so
we can't move the state machine to higher level and all cgroups will be
throttled to thier lower limit, so we waste bandwidth. Detecting idle
cgroup is hard. This patch handles a simple case, a cgroup doesn't
dispatch any IO. We ignore such cgroup's limit, so other cgroups can use
the bandwidth.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index bc94086..e4713b1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -144,6 +144,8 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
+	unsigned long last_dispatch_time[2];
+
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -438,11 +440,14 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 
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
@@ -1604,6 +1609,12 @@ static bool throtl_upgrade_check_one(struct throtl_grp *tg)
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
 
@@ -1684,6 +1695,9 @@ static bool throtl_downgrade_check_one(struct throtl_grp *tg)
 	struct throtl_data *td = tg->td;
 	unsigned long now = jiffies;
 
+	if (time_after_eq(now, tg->last_dispatch_time[READ] + td->throtl_slice) &&
+	    time_after_eq(now, tg->last_dispatch_time[WRITE] + td->throtl_slice))
+		return false;
 	/*
 	 * If cgroup is below high limit, consider downgrade and throttle other
 	 * cgroups
@@ -1802,6 +1816,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 again:
 	while (true) {
+		tg->last_dispatch_time[rw] = jiffies;
 		if (tg->last_high_overflow_time[rw] == 0)
 			tg->last_high_overflow_time[rw] = jiffies;
 		throtl_downgrade_check(tg);
-- 
2.8.0.rc2


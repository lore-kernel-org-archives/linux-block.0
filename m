Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33482 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754881AbcIOQXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 12:23:22 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8FGFE6Y022591
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:22 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 25fww30vgw-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:22 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)     by
 mx-out.facebook.com (10.223.100.97) with ESMTP id
 b7654bb07b6011e6a8e524be0593f280-f85fba50 for <linux-block@vger.kernel.org>;
        Thu, 15 Sep 2016 09:23:20 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH V2 09/11] block-throttle: make bandwidth change smooth
Date: Thu, 15 Sep 2016 09:23:16 -0700
Message-ID: <451324f5936db27b69eca2ddf9b273794e743617.1473953743.git.shli@fb.com>
In-Reply-To: <cover.1473953743.git.shli@fb.com>
References: <cover.1473953743.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When cgroups all reach high limit, cgroups can dispatch more IO. This
could make some cgroups dispatch more IO but others not, and even some
cgroups could dispatch less IO than their high limit. For example, cg1
high limit 10MB/s, cg2 limit 80MB/s, assume disk maximum bandwidth is
120M/s for the workload. Their bps could something like this:

cg1/cg2 bps: T1: 10/80 -> T2: 60/60 -> T3: 10/80

At T1, all cgroups reach high limit, so they can dispatch more IO later.
Then cg1 dispatch more IO and cg2 has no room to dispatch enough IO. At
T2, cg2 only dispatches 60M/s. Since We detect cg2 dispatches less IO
than its high limit 80M/s, we downgrade the queue from LIMIT_MAX to
LIMIT_HIGH, then all cgroups are throttled to their high limit (T3). cg2
will have bandwidth below its high limit at most time.

The big problem here is we don't know the maximum bandwidth of the
workload, so we can't make smart decision to avoid the situation. This
patch makes cgroup bandwidth change smooth. After disk upgrades from
LIMIT_HIGH to LIMIT_MAX, we don't allow cgroups use all bandwidth upto
their max limit immediately. Their bandwidth limit will be increased
gradually to avoid above situation. So above example will became
something like:

cg1/cg2 bps: 10/80 -> 15/105 -> 20/100 -> 25/95 -> 30/90 -> 35/85 -> 40/80
-> 45/75 -> 10/80

In this way cgroups bandwidth will be above their limit in majority
time, this still doesn't fully utilize disk bandwidth, but that's
something we pay for sharing.

Note this doesn't completely avoid cgroup running under its high limit.
The best way to guarantee cgroup doesn't run under its limit is to set
max limit. For example, if we set cg1 max limit to 40, cg2 will never
run under its high limit.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e4713b1..d956831 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -170,6 +170,8 @@ struct throtl_data
 
 	unsigned long high_upgrade_time;
 	unsigned long high_downgrade_time;
+
+	unsigned int scale;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -224,12 +226,28 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 {
 	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	struct throtl_data *td;
 	uint64_t ret;
 
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
 		return -1;
-	ret = tg->bps[rw][tg->td->limit_index];
-	if (ret == -1 && tg->td->limit_index == LIMIT_HIGH)
+	td = tg->td;
+	ret = tg->bps[rw][td->limit_index];
+	if (td->limit_index == LIMIT_MAX && tg->bps[rw][LIMIT_HIGH] != -1) {
+		uint64_t increase;
+
+		if (td->scale < 4096 && time_after_eq(jiffies,
+		    td->high_upgrade_time + td->scale * td->throtl_slice)) {
+			uint64_t time = jiffies - td->high_upgrade_time;
+
+			do_div(time, td->throtl_slice);
+			td->scale = time;
+		}
+		increase = (tg->bps[rw][LIMIT_HIGH] >> 1) * td->scale;
+		ret = min(tg->bps[rw][LIMIT_MAX],
+			tg->bps[rw][LIMIT_HIGH] + increase);
+	}
+	if (ret == -1 && td->limit_index == LIMIT_HIGH)
 		return tg->bps[rw][LIMIT_MAX];
 
 	return ret;
@@ -238,12 +256,29 @@ static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 {
 	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	struct throtl_data *td;
 	unsigned int ret;
 
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
 		return -1;
-	ret = tg->iops[rw][tg->td->limit_index];
-	if (ret == -1 && tg->td->limit_index == LIMIT_HIGH)
+	td = tg->td;
+	ret = tg->iops[rw][td->limit_index];
+	if (td->limit_index == LIMIT_MAX && tg->iops[rw][LIMIT_HIGH] != -1) {
+		uint64_t increase;
+
+		if (td->scale < 4096 && time_after_eq(jiffies,
+		    td->high_upgrade_time + td->scale * td->throtl_slice)) {
+			uint64_t time = jiffies - td->high_upgrade_time;
+
+			do_div(time, td->throtl_slice);
+			td->scale = time;
+		}
+
+		increase = (tg->iops[rw][LIMIT_HIGH] >> 1) * td->scale;
+		ret = min(tg->iops[rw][LIMIT_MAX],
+			tg->iops[rw][LIMIT_HIGH] + (unsigned int)increase);
+	}
+	if (ret == -1 && td->limit_index == LIMIT_HIGH)
 		return tg->iops[rw][LIMIT_MAX];
 	return ret;
 }
@@ -1669,6 +1704,7 @@ static void throtl_upgrade_state(struct throtl_data *td)
 
 	td->limit_index = LIMIT_MAX;
 	td->high_upgrade_time = jiffies;
+	td->scale = 0;
 	rcu_read_lock();
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
-- 
2.8.0.rc2


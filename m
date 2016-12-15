Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57272 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754508AbcLOUdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:22 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFKUZH9024779
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:16 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27bxsyagmv-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:16 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.99) with ESMTP  id
 b0f5d730c30511e6b9200002c9dfb610-2e9f7a50 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:09 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 10/17] blk-throttle: make bandwidth change smooth
Date: Thu, 15 Dec 2016 12:33:01 -0800
Message-ID: <390c68366acef5f3ce6ac6c5ce868826f07fd993.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When cgroups all reach low limit, cgroups can dispatch more IO. This
could make some cgroups dispatch more IO but others not, and even some
cgroups could dispatch less IO than their low limit. For example, cg1
low limit 10MB/s, cg2 limit 80MB/s, assume disk maximum bandwidth is
120M/s for the workload. Their bps could something like this:

cg1/cg2 bps: T1: 10/80 -> T2: 60/60 -> T3: 10/80

At T1, all cgroups reach low limit, so they can dispatch more IO later.
Then cg1 dispatch more IO and cg2 has no room to dispatch enough IO. At
T2, cg2 only dispatches 60M/s. Since We detect cg2 dispatches less IO
than its low limit 80M/s, we downgrade the queue from LIMIT_MAX to
LIMIT_LOW, then all cgroups are throttled to their low limit (T3). cg2
will have bandwidth below its low limit at most time.

The big problem here is we don't know the maximum bandwidth of the
workload, so we can't make smart decision to avoid the situation. This
patch makes cgroup bandwidth change smooth. After disk upgrades from
LIMIT_LOW to LIMIT_MAX, we don't allow cgroups use all bandwidth upto
their max limit immediately. Their bandwidth limit will be increased
gradually to avoid above situation. So above example will became
something like:

cg1/cg2 bps: 10/80 -> 15/105 -> 20/100 -> 25/95 -> 30/90 -> 35/85 -> 40/80
-> 45/75 -> 22/98

In this way cgroups bandwidth will be above their limit in majority
time, this still doesn't fully utilize disk bandwidth, but that's
something we pay for sharing.

Note this doesn't completely avoid cgroup running under its low limit.
The best way to guarantee cgroup doesn't run under its limit is to set
max limit. For example, if we set cg1 max limit to 40, cg2 will never
run under its low limit.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a0ba961..6b2f365 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -174,6 +174,8 @@ struct throtl_data
 
 	unsigned long low_upgrade_time;
 	unsigned long low_downgrade_time;
+
+	unsigned int scale;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -228,21 +230,58 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 {
 	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	struct throtl_data *td;
 	uint64_t ret;
 
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
 		return U64_MAX;
-	return tg->bps[rw][tg->td->limit_index];
+
+	td = tg->td;
+	ret = tg->bps[rw][td->limit_index];
+	if (td->limit_index == LIMIT_MAX && tg->bps[rw][LIMIT_LOW] !=
+	    tg->bps[rw][LIMIT_MAX]) {
+		uint64_t increase;
+
+		if (td->scale < 4096 && time_after_eq(jiffies,
+		    td->low_upgrade_time + td->scale * td->throtl_slice)) {
+			unsigned int time = jiffies - td->low_upgrade_time;
+
+			td->scale = time / td->throtl_slice;
+		}
+		increase = (tg->bps[rw][LIMIT_LOW] >> 1) * td->scale;
+		ret = min(tg->bps[rw][LIMIT_MAX],
+			tg->bps[rw][LIMIT_LOW] + increase);
+	}
+	return ret;
 }
 
 static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 {
 	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	struct throtl_data *td;
 	unsigned int ret;
 
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
 		return UINT_MAX;
-	return tg->iops[rw][tg->td->limit_index];
+
+	td = tg->td;
+	ret = tg->iops[rw][td->limit_index];
+	if (td->limit_index == LIMIT_MAX && tg->iops[rw][LIMIT_LOW] !=
+	    tg->iops[rw][LIMIT_MAX]) {
+		uint64_t increase;
+
+		if (td->scale < 4096 && time_after_eq(jiffies,
+		    td->low_upgrade_time + td->scale * td->throtl_slice)) {
+			unsigned int time = jiffies - td->low_upgrade_time;
+
+			td->scale = time / td->throtl_slice;
+		}
+
+		increase = (tg->iops[rw][LIMIT_LOW] >> 1) * td->scale;
+		ret = min(tg->iops[rw][LIMIT_MAX],
+			tg->iops[rw][LIMIT_LOW] + (unsigned int)increase);
+	}
+	return ret;
 }
 
 /**
@@ -1645,6 +1684,7 @@ static void throtl_upgrade_state(struct throtl_data *td)
 
 	td->limit_index = LIMIT_MAX;
 	td->low_upgrade_time = jiffies;
+	td->scale = 0;
 	rcu_read_lock();
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
@@ -1662,6 +1702,13 @@ static void throtl_upgrade_state(struct throtl_data *td)
 
 static void throtl_downgrade_state(struct throtl_data *td, int new)
 {
+	td->scale /= 2;
+
+	if (td->scale) {
+		td->low_upgrade_time = jiffies - td->scale * td->throtl_slice;
+		return;
+	}
+
 	td->limit_index = new;
 	td->low_downgrade_time = jiffies;
 }
-- 
2.9.3


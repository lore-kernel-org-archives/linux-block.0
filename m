Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59156 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750900AbdAODmi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:38 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0F3eDI7002202
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:37 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27ygw69px9-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:37 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.99) with ESMTP id
 a79f65a2dad411e69b370002c99293a0-749fba50 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:36 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 11/18] blk-throttle: make bandwidth change smooth
Date: Sat, 14 Jan 2017 19:42:28 -0800
Message-ID: <5c9cdfc541acc0d254dba4e985c60260b246c746.1484451062.git.shli@fb.com>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
References: <cover.1484451062.git.shli@fb.com>
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

Scale up is linear. The limit scales up 1/2 .low limit every
throtl_slice after upgrade. The scale up will stop if the adjusted limit
hits .max limit. Scale down is exponential. We cut the scale value half
if a cgroup doesn't hit its .low limit. If the scale becomes 0, we then
fully downgrade the queue to LIMIT_LOW state.

Note this doesn't completely avoid cgroup running under its low limit.
The best way to guarantee cgroup doesn't run under its limit is to set
max limit. For example, if we set cg1 max limit to 40, cg2 will never
run under its low limit.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b3ce176..a9eb03b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -175,6 +175,8 @@ struct throtl_data
 
 	unsigned long low_upgrade_time;
 	unsigned long low_downgrade_time;
+
+	unsigned int scale;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -226,29 +228,70 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 		return container_of(sq, struct throtl_data, service_queue);
 }
 
+/*
+ * cgroup's limit in LIMIT_MAX is scaled if low limit is set. This scale is to
+ * make the IO dispatch more smooth.
+ * Scale up: linearly scale up according to lapsed time since upgrade. For
+ *           every throtl_slice, the limit scales up 1/2 .low limit till the
+ *           limit hits .max limit
+ * Scale down: exponentially scale down if a cgroup doesn't hit its .low limit
+ */
+static uint64_t throtl_adjusted_limit(uint64_t low, struct throtl_data *td)
+{
+	/* arbitrary value to avoid too big scale */
+	if (td->scale < 4096 && time_after_eq(jiffies,
+	    td->low_upgrade_time + td->scale * td->throtl_slice))
+		td->scale = (jiffies - td->low_upgrade_time) / td->throtl_slice;
+
+	return low + (low >> 1) * td->scale;
+}
+
 static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 {
 	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	struct throtl_data *td;
 	uint64_t ret;
 
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
 		return U64_MAX;
-	ret = tg->bps[rw][tg->td->limit_index];
-	if (ret == 0 && tg->td->limit_index == LIMIT_LOW)
+
+	td = tg->td;
+	ret = tg->bps[rw][td->limit_index];
+	if (ret == 0 && td->limit_index == LIMIT_LOW)
 		return tg->bps[rw][LIMIT_MAX];
+
+	if (td->limit_index == LIMIT_MAX && tg->bps[rw][LIMIT_LOW] &&
+	    tg->bps[rw][LIMIT_LOW] != tg->bps[rw][LIMIT_MAX]) {
+		uint64_t adjusted;
+
+		adjusted = throtl_adjusted_limit(tg->bps[rw][LIMIT_LOW], td);
+		ret = min(tg->bps[rw][LIMIT_MAX], adjusted);
+	}
 	return ret;
 }
 
 static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 {
 	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	struct throtl_data *td;
 	unsigned int ret;
 
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
 		return UINT_MAX;
-	ret = tg->iops[rw][tg->td->limit_index];
+	td = tg->td;
+	ret = tg->iops[rw][td->limit_index];
 	if (ret == 0 && tg->td->limit_index == LIMIT_LOW)
 		return tg->iops[rw][LIMIT_MAX];
+
+	if (td->limit_index == LIMIT_MAX && tg->iops[rw][LIMIT_LOW] &&
+	    tg->iops[rw][LIMIT_LOW] != tg->iops[rw][LIMIT_MAX]) {
+		uint64_t adjusted;
+
+		adjusted = throtl_adjusted_limit(tg->iops[rw][LIMIT_LOW], td);
+		if (adjusted > UINT_MAX)
+			adjusted = UINT_MAX;
+		ret = min(tg->iops[rw][LIMIT_MAX], (unsigned int)adjusted);
+	}
 	return ret;
 }
 
@@ -1673,6 +1716,7 @@ static void throtl_upgrade_state(struct throtl_data *td)
 
 	td->limit_index = LIMIT_MAX;
 	td->low_upgrade_time = jiffies;
+	td->scale = 0;
 	rcu_read_lock();
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
@@ -1690,6 +1734,13 @@ static void throtl_upgrade_state(struct throtl_data *td)
 
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


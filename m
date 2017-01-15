Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750905AbdAODmi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:38 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0F3eDI9002202
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:38 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27ygw69px9-9
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:38 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.99) with ESMTP id
 a7ca5082dad411e682c00002c99293a0-709f3a50 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:36 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 15/18] blk-throttle: add interface for per-cgroup target latency
Date: Sat, 14 Jan 2017 19:42:32 -0800
Message-ID: <dde691d5d80723f4e2308f6162b9e0088d58bb59.1484451062.git.shli@fb.com>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
References: <cover.1484451062.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Here we introduce per-cgroup latency target. The target determines how a
cgroup can afford latency increasement. We will use the target latency
to calculate a threshold and use it to schedule IO for cgroups. If a
cgroup's bandwidth is below its low limit but its average latency is
below the threshold, other cgroups can safely dispatch more IO even
their bandwidth is higher than their low limits. On the other hand, if
the first cgroup's latency is higher than the threshold, other cgroups
are throttled to their low limits. So the target latency determines how
we efficiently utilize free disk resource without sacifice of worload's
IO latency.

For example, assume 4k IO average latency is 50us when disk isn't
congested. A cgroup sets the target latency to 30us. Then the cgroup can
accept 50+30=80us IO latency. If the cgroupt's average IO latency is
90us and its bandwidth is below low limit, other cgroups are throttled
to their low limit. If the cgroup's average IO latency is 60us, other
cgroups are allowed to dispatch more IO. When other cgroups dispatch
more IO, the first cgroup's IO latency will increase. If it increases to
81us, we then throttle other cgroups.

User will configure the interface in this way:
echo "8:16 rbps=2097152 wbps=max latency=100 idle=200" > io.low

latency is in microsecond unit

By default, latency target is 0, which means to guarantee IO latency.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index cf8d386..b2fab58 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -25,6 +25,8 @@ static int throtl_quantum = 32;
 #define DFL_IDLE_THRESHOLD_SSD (1000L) /* 1 ms */
 #define DFL_IDLE_THRESHOLD_HD (100L * 1000) /* 100 ms */
 #define MAX_IDLE_TIME (5L * 1000 * 1000) /* 5 s */
+/* default latency target is 0, eg, guarantee IO latency by default */
+#define DFL_LATENCY_TARGET (0)
 
 static struct blkcg_policy blkcg_policy_throtl;
 
@@ -152,6 +154,7 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
+	unsigned long latency_target; /* us */
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -449,6 +452,8 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 	tg->iops_conf[WRITE][LIMIT_MAX] = UINT_MAX;
 	/* LIMIT_LOW will have default value 0 */
 
+	tg->latency_target = DFL_LATENCY_TARGET;
+
 	return &tg->pd;
 }
 
@@ -1443,6 +1448,7 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	u64 bps_dft;
 	unsigned int iops_dft;
 	char idle_time[26] = "";
+	char latency_time[26] = "";
 
 	if (!dname)
 		return 0;
@@ -1459,8 +1465,9 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	    tg->bps_conf[WRITE][off] == bps_dft &&
 	    tg->iops_conf[READ][off] == iops_dft &&
 	    tg->iops_conf[WRITE][off] == iops_dft &&
-	    (off != LIMIT_LOW || tg->idletime_threshold ==
-				  tg->td->dft_idletime_threshold))
+	    (off != LIMIT_LOW ||
+	     (tg->idletime_threshold == tg->td->dft_idletime_threshold &&
+	      tg->latency_target == DFL_LATENCY_TARGET)))
 		return 0;
 
 	if (tg->bps_conf[READ][off] != bps_dft)
@@ -1481,10 +1488,17 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 		else
 			snprintf(idle_time, sizeof(idle_time), " idle=%lu",
 				tg->idletime_threshold);
+
+		if (tg->latency_target == ULONG_MAX)
+			strcpy(latency_time, " latency=max");
+		else
+			snprintf(latency_time, sizeof(latency_time),
+				" latency=%lu", tg->latency_target);
 	}
 
-	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s\n",
-		   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time);
+	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s%s\n",
+		   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time,
+		   latency_time);
 	return 0;
 }
 
@@ -1503,6 +1517,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	struct throtl_grp *tg;
 	u64 v[4];
 	unsigned long idle_time;
+	unsigned long latency_time;
 	int ret;
 	int index = of_cft(of)->private;
 
@@ -1518,6 +1533,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	v[3] = tg->iops_conf[WRITE][index];
 
 	idle_time = tg->idletime_threshold;
+	latency_time = tg->latency_target;
 	while (true) {
 		char tok[27];	/* wiops=18446744073709551616 */
 		char *p;
@@ -1551,6 +1567,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			v[3] = min_t(u64, val, UINT_MAX);
 		else if (off == LIMIT_LOW && !strcmp(tok, "idle"))
 			idle_time = val;
+		else if (off == LIMIT_LOW && !strcmp(tok, "latency"))
+			latency_time = val;
 		else
 			goto out_finish;
 	}
@@ -1581,6 +1599,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			tg->td->limit_index = LIMIT_LOW;
 		tg->idletime_threshold = (idle_time == ULONG_MAX) ?
 			ULONG_MAX : idle_time;
+		tg->latency_target = (latency_time == ULONG_MAX) ?
+			ULONG_MAX : latency_time;
 	}
 	tg_conf_updated(tg);
 	ret = 0;
-- 
2.9.3


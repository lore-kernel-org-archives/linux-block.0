Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47697 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756338AbcLOUdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:17 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFKVvOS023892
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:11 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 27bdne5btm-6
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:11 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.97) with ESMTP id
 b121db14c30511e6b7cf0002c99331b0-ee00b6d0 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:09 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 14/17] blk-throttle: add interface for per-cgroup target latency
Date: Thu, 15 Dec 2016 12:33:05 -0800
Message-ID: <780b07f3e3163f5fbacaa32a4eb808e3b7940f2e.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
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

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 62fe72ea..3431b1d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -151,6 +151,7 @@ struct throtl_grp {
 
 	unsigned long last_check_time;
 
+	u64 latency_target;
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -438,6 +439,11 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 	}
 	tg->idle_ttime_threshold = U64_MAX;
 
+	/*
+	 * target latency default 0, eg, latency threshold is 0, which means
+	 * cgroup's latency is always higher than threshold
+	 */
+
 	return &tg->pd;
 }
 
@@ -1426,6 +1432,7 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	const char *dname = blkg_dev_name(pd->blkg);
 	char bufs[4][21] = { "max", "max", "max", "max" };
 	char idle_time[26] = "";
+	char latency_time[26] = "";
 
 	if (!dname)
 		return 0;
@@ -1434,8 +1441,9 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	    tg->bps_conf[WRITE][off] == U64_MAX &&
 	    tg->iops_conf[READ][off] == UINT_MAX &&
 	    tg->iops_conf[WRITE][off] == UINT_MAX &&
-	    (off != LIMIT_LOW || tg->idle_ttime_threshold ==
-				  tg->td->dft_idle_ttime_threshold))
+	    (off != LIMIT_LOW ||
+	     (tg->idle_ttime_threshold == tg->td->dft_idle_ttime_threshold &&
+	      tg->latency_target == 0)))
 		return 0;
 
 	if (tg->bps_conf[READ][off] != U64_MAX)
@@ -1456,10 +1464,18 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 		else
 			snprintf(idle_time, sizeof(idle_time), " idle=%llu",
 				div_u64(tg->idle_ttime_threshold, 1000));
+
+		if (tg->latency_target == U64_MAX)
+			strcpy(latency_time, " latency=max");
+		else
+			snprintf(latency_time, sizeof(latency_time),
+				" latency=%llu",
+				div_u64(tg->latency_target, 1000));
 	}
 
-	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s\n",
-		   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time);
+	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s%s\n",
+		   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time,
+		   latency_time);
 	return 0;
 }
 
@@ -1478,6 +1494,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	struct throtl_grp *tg;
 	u64 v[4];
 	u64 idle_time;
+	u64 latency_time;
 	int ret;
 	int index = of_cft(of)->private;
 
@@ -1493,6 +1510,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	v[3] = tg->iops_conf[WRITE][index];
 
 	idle_time = tg->idle_ttime_threshold;
+	latency_time = tg->latency_target;
 	while (true) {
 		char tok[27];	/* wiops=18446744073709551616 */
 		char *p;
@@ -1526,6 +1544,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			v[3] = min_t(u64, val, UINT_MAX);
 		else if (off == LIMIT_LOW && !strcmp(tok, "idle"))
 			idle_time = val;
+		else if (off == LIMIT_LOW && !strcmp(tok, "latency"))
+			latency_time = val;
 		else
 			goto out_finish;
 	}
@@ -1556,6 +1576,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			tg->td->limit_index = LIMIT_LOW;
 		tg->idle_ttime_threshold = (idle_time == U64_MAX) ?
 			U64_MAX : idle_time * 1000;
+		tg->latency_target = (latency_time == U64_MAX) ?
+			U64_MAX : latency_time * 1000;
 	}
 	tg_conf_updated(tg);
 	ret = 0;
-- 
2.9.3


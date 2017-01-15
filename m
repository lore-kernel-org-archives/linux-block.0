Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50236 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750818AbdAODmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:37 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0F3csrh030055
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:37 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27yg5uss72-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:37 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.97) with ESMTP  id
 a7c082d2dad411e6b7880002c9931860-7bff7a50 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:36 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 13/18] blk-throttle: add interface to configure idle time threshold
Date: Sat, 14 Jan 2017 19:42:30 -0800
Message-ID: <1e7c0d54c9bc716a32d43ef0688ee0ab868e6be7.1484451062.git.shli@fb.com>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
References: <cover.1484451062.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add interface to configure the threshold. The io.low interface will
like:
echo "8:16 rbps=2097152 wbps=max idle=2000" > io.low

idle is in microsecond unit.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 974ec9d..88c0d1e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -181,6 +181,8 @@ struct throtl_data
 	unsigned int limit_index;
 	bool limit_valid[LIMIT_CNT];
 
+	unsigned long dft_idletime_threshold; /* us */
+
 	unsigned long low_upgrade_time;
 	unsigned long low_downgrade_time;
 
@@ -477,10 +479,7 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 		sq->parent_sq = &blkg_to_tg(blkg->parent)->service_queue;
 	tg->td = td;
 
-	if (blk_queue_nonrot(td->queue))
-		tg->idletime_threshold = DFL_IDLE_THRESHOLD_SSD;
-	else
-		tg->idletime_threshold = DFL_IDLE_THRESHOLD_HD;
+	tg->idletime_threshold = td->dft_idletime_threshold;
 }
 
 /*
@@ -1447,6 +1446,7 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	char bufs[4][21] = { "max", "max", "max", "max" };
 	u64 bps_dft;
 	unsigned int iops_dft;
+	char idle_time[26] = "";
 
 	if (!dname)
 		return 0;
@@ -1462,7 +1462,9 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	if (tg->bps_conf[READ][off] == bps_dft &&
 	    tg->bps_conf[WRITE][off] == bps_dft &&
 	    tg->iops_conf[READ][off] == iops_dft &&
-	    tg->iops_conf[WRITE][off] == iops_dft)
+	    tg->iops_conf[WRITE][off] == iops_dft &&
+	    (off != LIMIT_LOW || tg->idletime_threshold ==
+				  tg->td->dft_idletime_threshold))
 		return 0;
 
 	if (tg->bps_conf[READ][off] != bps_dft)
@@ -1477,9 +1479,16 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	if (tg->iops_conf[WRITE][off] != iops_dft)
 		snprintf(bufs[3], sizeof(bufs[3]), "%u",
 			tg->iops_conf[WRITE][off]);
+	if (off == LIMIT_LOW) {
+		if (tg->idletime_threshold == ULONG_MAX)
+			strcpy(idle_time, " idle=max");
+		else
+			snprintf(idle_time, sizeof(idle_time), " idle=%lu",
+				tg->idletime_threshold);
+	}
 
-	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s\n",
-		   dname, bufs[0], bufs[1], bufs[2], bufs[3]);
+	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s\n",
+		   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time);
 	return 0;
 }
 
@@ -1497,6 +1506,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	struct blkg_conf_ctx ctx;
 	struct throtl_grp *tg;
 	u64 v[4];
+	unsigned long idle_time;
 	int ret;
 	int index = of_cft(of)->private;
 
@@ -1511,6 +1521,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	v[2] = tg->iops_conf[READ][index];
 	v[3] = tg->iops_conf[WRITE][index];
 
+	idle_time = tg->idletime_threshold;
 	while (true) {
 		char tok[27];	/* wiops=18446744073709551616 */
 		char *p;
@@ -1542,6 +1553,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			v[2] = min_t(u64, val, UINT_MAX);
 		else if (!strcmp(tok, "wiops"))
 			v[3] = min_t(u64, val, UINT_MAX);
+		else if (off == LIMIT_LOW && !strcmp(tok, "idle"))
+			idle_time = val;
 		else
 			goto out_finish;
 	}
@@ -1570,6 +1583,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		blk_throtl_update_limit_valid(tg->td);
 		if (tg->td->limit_valid[LIMIT_LOW])
 			tg->td->limit_index = LIMIT_LOW;
+		tg->idletime_threshold = (idle_time == ULONG_MAX) ?
+			ULONG_MAX : idle_time;
 	}
 	tg_conf_updated(tg);
 	ret = 0;
@@ -2114,10 +2129,13 @@ void blk_throtl_register_queue(struct request_queue *q)
 
 	td = q->td;
 	BUG_ON(!td);
-	if (blk_queue_nonrot(q))
+	if (blk_queue_nonrot(q)) {
 		td->throtl_slice = DFL_THROTL_SLICE_SSD;
-	else
+		td->dft_idletime_threshold = DFL_IDLE_THRESHOLD_SSD;
+	} else {
 		td->throtl_slice = DFL_THROTL_SLICE_HD;
+		td->dft_idletime_threshold = DFL_IDLE_THRESHOLD_HD;
+	}
 
 	/*
 	 * some tg are created before queue is fully initialized, eg, nonrot
@@ -2127,10 +2145,7 @@ void blk_throtl_register_queue(struct request_queue *q)
 	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 
-		if (blk_queue_nonrot(q))
-			tg->idletime_threshold = DFL_IDLE_THRESHOLD_SSD;
-		else
-			tg->idletime_threshold = DFL_IDLE_THRESHOLD_HD;
+		tg->idletime_threshold = td->dft_idletime_threshold;
 	}
 	rcu_read_unlock();
 }
-- 
2.9.3


Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57273 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756342AbcLOUdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:17 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFKUZHA024779
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:17 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27bxsyagmv-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:17 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.97) with ESMTP  id
 b10b7df6c30511e68eb30002c9931860-7cff9a50 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:09 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 12/17] blk-throttle: add interface to configure idle time threshold
Date: Thu, 15 Dec 2016 12:33:03 -0800
Message-ID: <d950668d79d27d585faed9fc8747ed806d4e1031.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
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
 block/blk-throttle.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 3cd8400..0218ff9 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -180,6 +180,8 @@ struct throtl_data
 	unsigned int limit_index;
 	bool limit_valid[LIMIT_CNT];
 
+	u64 dft_idle_ttime_threshold;
+
 	unsigned long low_upgrade_time;
 	unsigned long low_downgrade_time;
 
@@ -1427,6 +1429,7 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	struct throtl_grp *tg = pd_to_tg(pd);
 	const char *dname = blkg_dev_name(pd->blkg);
 	char bufs[4][21] = { "max", "max", "max", "max" };
+	char idle_time[26] = "";
 
 	if (!dname)
 		return 0;
@@ -1434,7 +1437,9 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	if (tg->bps_conf[READ][off] == U64_MAX &&
 	    tg->bps_conf[WRITE][off] == U64_MAX &&
 	    tg->iops_conf[READ][off] == UINT_MAX &&
-	    tg->iops_conf[WRITE][off] == UINT_MAX)
+	    tg->iops_conf[WRITE][off] == UINT_MAX &&
+	    (off != LIMIT_LOW || tg->idle_ttime_threshold ==
+				  tg->td->dft_idle_ttime_threshold))
 		return 0;
 
 	if (tg->bps_conf[READ][off] != U64_MAX)
@@ -1449,9 +1454,16 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	if (tg->iops_conf[WRITE][off] != UINT_MAX)
 		snprintf(bufs[3], sizeof(bufs[3]), "%u",
 			tg->iops_conf[WRITE][off]);
+	if (off == LIMIT_LOW) {
+		if (tg->idle_ttime_threshold == U64_MAX)
+			strcpy(idle_time, " idle=max");
+		else
+			snprintf(idle_time, sizeof(idle_time), " idle=%llu",
+				div_u64(tg->idle_ttime_threshold, 1000));
+	}
 
-	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s\n",
-		   dname, bufs[0], bufs[1], bufs[2], bufs[3]);
+	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s\n",
+		   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time);
 	return 0;
 }
 
@@ -1469,6 +1481,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	struct blkg_conf_ctx ctx;
 	struct throtl_grp *tg;
 	u64 v[4];
+	u64 idle_time;
 	int ret;
 	int index = of_cft(of)->private;
 
@@ -1483,6 +1496,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	v[2] = tg->iops_conf[READ][index];
 	v[3] = tg->iops_conf[WRITE][index];
 
+	idle_time = tg->idle_ttime_threshold;
 	while (true) {
 		char tok[27];	/* wiops=18446744073709551616 */
 		char *p;
@@ -1514,6 +1528,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			v[2] = min_t(u64, val, UINT_MAX);
 		else if (!strcmp(tok, "wiops"))
 			v[3] = min_t(u64, val, UINT_MAX);
+		else if (off == LIMIT_LOW && !strcmp(tok, "idle"))
+			idle_time = val;
 		else
 			goto out_finish;
 	}
@@ -1542,6 +1558,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		blk_throtl_update_valid_limit(tg->td);
 		if (tg->td->limit_valid[LIMIT_LOW])
 			tg->td->limit_index = LIMIT_LOW;
+		tg->idle_ttime_threshold = (idle_time == U64_MAX) ?
+			U64_MAX : idle_time * 1000;
 	}
 	tg_conf_updated(tg);
 	ret = 0;
@@ -1862,6 +1880,9 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 			tg->idle_ttime_threshold = DFL_IDLE_THRESHOLD_SSD;
 		else
 			tg->idle_ttime_threshold = DFL_IDLE_THRESHOLD_HD;
+		if (tg->td->dft_idle_ttime_threshold == 0)
+			tg->td->dft_idle_ttime_threshold =
+				tg->idle_ttime_threshold;
 	}
 
 	/* see throtl_charge_bio() */
-- 
2.9.3


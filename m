Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36335 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752803AbcEKAQq (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:16:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.16.0.11/8.16.0.11) with SMTP id u4B0FgWF017994
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:45 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0089730.ppops.net with ESMTP id 22ur09gj36-2
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:45 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.236.87) with ESMTP	id
 a42b830a170d11e686830002c9521c9e-7ddfcc50 for <linux-block@vger.kernel.org>;
	Tue, 10 May 2016 17:16:44 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <vgoyal@redhat.com>, <axboe@fb.com>,
	<jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 07/10] block-throttle: add .high interface
Date: Tue, 10 May 2016 17:16:37 -0700
Message-ID: <9e2fe776af3949942833f0040fc19e5797b5fc9c.1462923578.git.shli@fb.com>
In-Reply-To: <cover.1462923578.git.shli@fb.com>
References: <cover.1462923578.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add high limit for cgroup and corresponding cgroup interface.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a462e2f..5736d1b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -87,8 +87,9 @@ enum tg_state_flags {
 
 enum {
 	LIMIT_LOW = 0,
-	LIMIT_MAX = 1,
-	LIMIT_CNT = 2,
+	LIMIT_HIGH = 1,
+	LIMIT_MAX = 2,
+	LIMIT_CNT = 3,
 };
 
 struct throtl_grp {
@@ -240,6 +241,8 @@ static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 		/* assign a small default */
 		return 64 * 1024;
 	}
+	if (ret == -1 && tg->td->limit_index == LIMIT_HIGH)
+		return tg->bps[rw][LIMIT_MAX];
 
 	return ret;
 }
@@ -258,6 +261,8 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 		/* assign a small default */
 		return 16;
 	}
+	if (ret == -1 && tg->td->limit_index == LIMIT_HIGH)
+		return tg->iops[rw][LIMIT_MAX];
 	return ret;
 }
 
@@ -399,7 +404,7 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 
 	RB_CLEAR_NODE(&tg->rb_node);
 	for (rw = READ; rw <= WRITE; rw++) {
-		for (index = LIMIT_MAX; index < LIMIT_CNT; index++) {
+		for (index = LIMIT_HIGH; index < LIMIT_CNT; index++) {
 			tg->bps[rw][index] = -1;
 			tg->iops[rw][index] = -1;
 		}
@@ -466,6 +471,7 @@ static void blk_throtl_update_valid_limit(struct throtl_data *td)
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
 	bool low_valid = false;
+	bool high_valid = false;
 
 	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
 		struct throtl_grp *tg = blkg_to_tg(blkg);
@@ -475,12 +481,21 @@ static void blk_throtl_update_valid_limit(struct throtl_data *td)
 		    tg->iops[READ][LIMIT_LOW] ||
 		    tg->iops[WRITE][LIMIT_LOW])
 			low_valid = true;
+		if (tg->bps[READ][LIMIT_HIGH] != -1 ||
+		    tg->bps[WRITE][LIMIT_HIGH] != -1 ||
+		    tg->iops[READ][LIMIT_HIGH] != -1 ||
+		    tg->iops[WRITE][LIMIT_HIGH] != -1)
+			high_valid = true;
 	}
 
 	if (low_valid)
 		td->limit_valid[LIMIT_LOW] = true;
 	else
 		td->limit_valid[LIMIT_LOW] = false;
+	if (high_valid)
+		td->limit_valid[LIMIT_HIGH] = true;
+	else
+		td->limit_valid[LIMIT_HIGH] = false;
 }
 
 static void throtl_upgrade_state(struct throtl_data *td);
@@ -492,6 +507,10 @@ static void throtl_pd_offline(struct blkg_policy_data *pd)
 	tg->bps[WRITE][LIMIT_LOW] = 0;
 	tg->iops[READ][LIMIT_LOW] = 0;
 	tg->iops[WRITE][LIMIT_LOW] = 0;
+	tg->bps[READ][LIMIT_HIGH] = -1;
+	tg->bps[WRITE][LIMIT_HIGH] = -1;
+	tg->iops[READ][LIMIT_HIGH] = -1;
+	tg->iops[WRITE][LIMIT_HIGH] = -1;
 
 	blk_throtl_update_valid_limit(tg->td);
 
@@ -1476,7 +1495,15 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		if (v[0] < tg->bps[READ][LIMIT_LOW] ||
 		    v[1] < tg->bps[WRITE][LIMIT_LOW] ||
 		    v[2] < tg->iops[READ][LIMIT_LOW] ||
-		    v[3] < tg->iops[WRITE][LIMIT_LOW]) {
+		    v[3] < tg->iops[WRITE][LIMIT_LOW] ||
+		    (tg->bps[READ][LIMIT_HIGH] != -1 &&
+		     v[0] < tg->bps[READ][LIMIT_HIGH]) ||
+		    (tg->bps[WRITE][LIMIT_HIGH] != -1 &&
+		     v[1] < tg->bps[WRITE][LIMIT_HIGH]) ||
+		    (tg->iops[READ][LIMIT_HIGH] != -1 &&
+		     v[2] < tg->iops[READ][LIMIT_HIGH]) ||
+		    (tg->iops[WRITE][LIMIT_HIGH] != -1 &&
+		     v[3] < tg->iops[WRITE][LIMIT_HIGH])) {
 			ret = -EINVAL;
 			goto out_finish;
 		}
@@ -1484,7 +1511,27 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		if (v[0] > tg->bps[READ][LIMIT_MAX] ||
 		    v[1] > tg->bps[WRITE][LIMIT_MAX] ||
 		    v[2] > tg->iops[READ][LIMIT_MAX] ||
-		    v[3] > tg->iops[WRITE][LIMIT_MAX]) {
+		    v[3] > tg->iops[WRITE][LIMIT_MAX] ||
+		    (tg->bps[READ][LIMIT_HIGH] != -1 &&
+		     v[0] > tg->bps[READ][LIMIT_HIGH]) ||
+		    (tg->bps[WRITE][LIMIT_HIGH] != -1 &&
+		     v[1] > tg->bps[WRITE][LIMIT_HIGH]) ||
+		    (tg->iops[READ][LIMIT_HIGH] != -1 &&
+		     v[2] > tg->iops[READ][LIMIT_HIGH]) ||
+		    (tg->iops[WRITE][LIMIT_HIGH] != -1 &&
+		     v[3] > tg->iops[WRITE][LIMIT_HIGH])) {
+			ret = -EINVAL;
+			goto out_finish;
+		}
+	} else if (index == LIMIT_HIGH) {
+		if ((v[0] != -1 && (v[0] < tg->bps[READ][LIMIT_LOW] ||
+				    v[0] > tg->bps[READ][LIMIT_MAX])) ||
+		    (v[1] != -1 && (v[1] < tg->bps[WRITE][LIMIT_LOW] ||
+				    v[1] > tg->bps[WRITE][LIMIT_MAX])) ||
+		    (v[2] != -1 && (v[2] < tg->iops[READ][LIMIT_LOW] ||
+				    v[2] > tg->iops[READ][LIMIT_MAX])) ||
+		    (v[3] != -1 && (v[3] < tg->iops[WRITE][LIMIT_LOW] ||
+				    v[3] > tg->iops[WRITE][LIMIT_MAX]))) {
 			ret = -EINVAL;
 			goto out_finish;
 		}
@@ -1499,6 +1546,15 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		if (tg->td->limit_valid[LIMIT_LOW])
 			tg->td->limit_index = LIMIT_LOW;
 	}
+	if (index == LIMIT_HIGH) {
+		blk_throtl_update_valid_limit(tg->td);
+		if (tg->td->limit_valid[LIMIT_HIGH] &&
+		    tg->td->limit_index == LIMIT_MAX)
+			tg->td->limit_index = LIMIT_HIGH;
+	}
+	if (index == LIMIT_MAX && tg->td->limit_index == LIMIT_MAX &&
+	    tg->td->limit_valid[LIMIT_HIGH])
+		tg->td->limit_index = LIMIT_HIGH;
 	tg_conf_updated(tg);
 	ret = 0;
 out_finish:
@@ -1515,6 +1571,13 @@ static struct cftype throtl_files[] = {
 		.private = LIMIT_LOW,
 	},
 	{
+		.name = "high",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = tg_print_limit,
+		.write = tg_set_limit,
+		.private = LIMIT_HIGH,
+	},
+	{
 		.name = "max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = tg_print_limit,
@@ -1988,6 +2051,7 @@ int blk_throtl_init(struct request_queue *q)
 	td->queue = q;
 
 	td->limit_valid[LIMIT_LOW] = false;
+	td->limit_valid[LIMIT_HIGH] = false;
 	td->limit_valid[LIMIT_MAX] = true;
 	td->limit_index = LIMIT_MAX;
 	td->low_upgrade_time = jiffies;
-- 
2.8.0.rc2


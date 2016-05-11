Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1646 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752092AbcEKAQo (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:16:44 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4B0CNDY026368
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:43 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 22usxn80xx-1
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:43 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.232.59) with ESMTP	id
 a31b948c170d11e685ef0002c991e86a-d70e2c50 for <linux-block@vger.kernel.org>;
	Tue, 10 May 2016 17:16:42 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <vgoyal@redhat.com>, <axboe@fb.com>,
	<jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 02/10] block-throttle: add .low interface
Date: Tue, 10 May 2016 17:16:32 -0700
Message-ID: <1ef5e2908cacd9fad68fbacddddfbba7c86176b3.1462923578.git.shli@fb.com>
In-Reply-To: <cover.1462923578.git.shli@fb.com>
References: <cover.1462923578.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add low limit for cgroup and corresponding cgroup interface.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 142 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 110 insertions(+), 32 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 162d54c..e69a3db 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -84,8 +84,9 @@ enum tg_state_flags {
 #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
 
 enum {
-	LIMIT_MAX = 0,
-	LIMIT_CNT = 1,
+	LIMIT_LOW = 0,
+	LIMIT_MAX = 1,
+	LIMIT_CNT = 2,
 };
 
 struct throtl_grp {
@@ -358,7 +359,7 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 
 	RB_CLEAR_NODE(&tg->rb_node);
 	for (rw = READ; rw <= WRITE; rw++) {
-		for (index = 0; index < LIMIT_CNT; index++) {
+		for (index = LIMIT_MAX; index < LIMIT_CNT; index++) {
 			tg->bps[rw][index] = -1;
 			tg->iops[rw][index] = -1;
 		}
@@ -420,6 +421,44 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	tg_update_has_rules(pd_to_tg(pd));
 }
 
+static void blk_throtl_update_valid_limit(struct throtl_data *td)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+	bool low_valid = false;
+
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+
+		if (tg->bps[READ][LIMIT_LOW] ||
+		    tg->bps[WRITE][LIMIT_LOW] ||
+		    tg->iops[READ][LIMIT_LOW] ||
+		    tg->iops[WRITE][LIMIT_LOW])
+			low_valid = true;
+	}
+
+	if (low_valid)
+		td->limit_valid[LIMIT_LOW] = true;
+	else
+		td->limit_valid[LIMIT_LOW] = false;
+}
+
+static void throtl_pd_offline(struct blkg_policy_data *pd)
+{
+	struct throtl_grp *tg = pd_to_tg(pd);
+
+	tg->bps[READ][LIMIT_LOW] = 0;
+	tg->bps[WRITE][LIMIT_LOW] = 0;
+	tg->iops[READ][LIMIT_LOW] = 0;
+	tg->iops[WRITE][LIMIT_LOW] = 0;
+
+	blk_throtl_update_valid_limit(tg->td);
+
+	if (tg->td->limit_index == LIMIT_LOW &&
+	    !tg->td->limit_valid[LIMIT_LOW])
+		tg->td->limit_index = LIMIT_MAX;
+}
+
 static void throtl_pd_free(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
@@ -1287,45 +1326,50 @@ static struct cftype throtl_legacy_files[] = {
 	{ }	/* terminate */
 };
 
-static u64 tg_prfill_max(struct seq_file *sf, struct blkg_policy_data *pd,
+static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 			 int off)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
 	const char *dname = blkg_dev_name(pd->blkg);
 	char bufs[4][21] = { "max", "max", "max", "max" };
+	uint64_t target = -1;
 
 	if (!dname)
 		return 0;
-	if (tg->bps[READ][LIMIT_MAX] == -1 && tg->bps[WRITE][LIMIT_MAX] == -1 &&
-	    tg->iops[READ][LIMIT_MAX] == -1 && tg->iops[WRITE][LIMIT_MAX] == -1)
+	if (off == LIMIT_LOW) {
+		int i;
+		for (i = 0; i < 4; i++)
+			strcpy(bufs[i], "0");
+		target = 0;
+	}
+
+	if (tg->bps[READ][off] == target && tg->bps[WRITE][off] == target &&
+	    tg->iops[READ][off] == (unsigned int)target &&
+	    tg->iops[WRITE][off] == (unsigned int)target)
 		return 0;
 
-	if (tg->bps[READ][LIMIT_MAX] != -1)
-		snprintf(bufs[0], sizeof(bufs[0]), "%llu",
-			tg->bps[READ][LIMIT_MAX]);
-	if (tg->bps[WRITE][LIMIT_MAX] != -1)
-		snprintf(bufs[1], sizeof(bufs[1]), "%llu",
-			tg->bps[WRITE][LIMIT_MAX]);
-	if (tg->iops[READ][LIMIT_MAX] != -1)
-		snprintf(bufs[2], sizeof(bufs[2]), "%u",
-			tg->iops[READ][LIMIT_MAX]);
-	if (tg->iops[WRITE][LIMIT_MAX] != -1)
-		snprintf(bufs[3], sizeof(bufs[3]), "%u",
-			tg->iops[WRITE][LIMIT_MAX]);
+	if (tg->bps[READ][off] != target)
+		snprintf(bufs[0], sizeof(bufs[0]), "%llu", tg->bps[READ][off]);
+	if (tg->bps[WRITE][off] != target)
+		snprintf(bufs[1], sizeof(bufs[1]), "%llu", tg->bps[WRITE][off]);
+	if (tg->iops[READ][off] != (unsigned int)target)
+		snprintf(bufs[2], sizeof(bufs[2]), "%u", tg->iops[READ][off]);
+	if (tg->iops[WRITE][off] != (unsigned int)target)
+		snprintf(bufs[3], sizeof(bufs[3]), "%u", tg->iops[WRITE][off]);
 
 	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s\n",
 		   dname, bufs[0], bufs[1], bufs[2], bufs[3]);
 	return 0;
 }
 
-static int tg_print_max(struct seq_file *sf, void *v)
+static int tg_print_limit(struct seq_file *sf, void *v)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), tg_prfill_max,
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), tg_prfill_limit,
 			  &blkcg_policy_throtl, seq_cft(sf)->private, false);
 	return 0;
 }
 
-static ssize_t tg_set_max(struct kernfs_open_file *of,
+static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			  char *buf, size_t nbytes, loff_t off)
 {
 	struct blkcg *blkcg = css_to_blkcg(of_css(of));
@@ -1333,6 +1377,7 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 	struct throtl_grp *tg;
 	u64 v[4];
 	int ret;
+	int index = of_cft(of)->private;
 
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
 	if (ret)
@@ -1340,10 +1385,10 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 
 	tg = blkg_to_tg(ctx.blkg);
 
-	v[0] = tg->bps[READ][LIMIT_MAX];
-	v[1] = tg->bps[WRITE][LIMIT_MAX];
-	v[2] = tg->iops[READ][LIMIT_MAX];
-	v[3] = tg->iops[WRITE][LIMIT_MAX];
+	v[0] = tg->bps[READ][index];
+	v[1] = tg->bps[WRITE][index];
+	v[2] = tg->iops[READ][index];
+	v[3] = tg->iops[WRITE][index];
 
 	while (true) {
 		char tok[27];	/* wiops=18446744073709551616 */
@@ -1380,11 +1425,33 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 			goto out_finish;
 	}
 
-	tg->bps[READ][LIMIT_MAX] = v[0];
-	tg->bps[WRITE][LIMIT_MAX] = v[1];
-	tg->iops[READ][LIMIT_MAX] = v[2];
-	tg->iops[WRITE][LIMIT_MAX] = v[3];
-
+	if (index == LIMIT_MAX) {
+		if (v[0] < tg->bps[READ][LIMIT_LOW] ||
+		    v[1] < tg->bps[WRITE][LIMIT_LOW] ||
+		    v[2] < tg->iops[READ][LIMIT_LOW] ||
+		    v[3] < tg->iops[WRITE][LIMIT_LOW]) {
+			ret = -EINVAL;
+			goto out_finish;
+		}
+	} else if (index == LIMIT_LOW) {
+		if (v[0] > tg->bps[READ][LIMIT_MAX] ||
+		    v[1] > tg->bps[WRITE][LIMIT_MAX] ||
+		    v[2] > tg->iops[READ][LIMIT_MAX] ||
+		    v[3] > tg->iops[WRITE][LIMIT_MAX]) {
+			ret = -EINVAL;
+			goto out_finish;
+		}
+	}
+	tg->bps[READ][index] = v[0];
+	tg->bps[WRITE][index] = v[1];
+	tg->iops[READ][index] = v[2];
+	tg->iops[WRITE][index] = v[3];
+
+	if (index == LIMIT_LOW) {
+		blk_throtl_update_valid_limit(tg->td);
+		if (tg->td->limit_valid[LIMIT_LOW])
+			tg->td->limit_index = LIMIT_LOW;
+	}
 	tg_conf_updated(tg);
 	ret = 0;
 out_finish:
@@ -1394,10 +1461,18 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 
 static struct cftype throtl_files[] = {
 	{
+		.name = "low",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = tg_print_limit,
+		.write = tg_set_limit,
+		.private = LIMIT_LOW,
+	},
+	{
 		.name = "max",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = tg_print_max,
-		.write = tg_set_max,
+		.seq_show = tg_print_limit,
+		.write = tg_set_limit,
+		.private = LIMIT_MAX,
 	},
 	{ }	/* terminate */
 };
@@ -1416,6 +1491,7 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_alloc_fn		= throtl_pd_alloc,
 	.pd_init_fn		= throtl_pd_init,
 	.pd_online_fn		= throtl_pd_online,
+	.pd_offline_fn		= throtl_pd_offline,
 	.pd_free_fn		= throtl_pd_free,
 };
 
@@ -1593,7 +1669,9 @@ int blk_throtl_init(struct request_queue *q)
 	q->td = td;
 	td->queue = q;
 
+	td->limit_valid[LIMIT_LOW] = false;
 	td->limit_valid[LIMIT_MAX] = true;
+	td->limit_index = LIMIT_MAX;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
-- 
2.8.0.rc2


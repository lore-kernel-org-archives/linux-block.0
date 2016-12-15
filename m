Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57295 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756428AbcLOUdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:21 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFKUYSD024749
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:21 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27bxsyagmy-11
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:21 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.99) with ESMTP  id
 b0b0624ac30511e6828c0002c9dfb610-2f1f8a50 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:08 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 03/17] blk-throttle: add .low interface
Date: Thu, 15 Dec 2016 12:32:54 -0800
Message-ID: <c4179e0d7e8f2e36455db1a639911ab9aca374b1.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add low limit for cgroup and corresponding cgroup interface.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 134 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 106 insertions(+), 28 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a75bfa2..fcc4199 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -84,6 +84,7 @@ enum tg_state_flags {
 #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
 
 enum {
+	LIMIT_LOW,
 	LIMIT_MAX,
 	LIMIT_CNT,
 };
@@ -124,11 +125,15 @@ struct throtl_grp {
 	/* are there any throtl rules between this group and td? */
 	bool has_rules[2];
 
-	/* bytes per second rate limits */
+	/* internally used bytes per second rate limits */
 	uint64_t bps[2][LIMIT_CNT];
+	/* user configured bps limits */
+	uint64_t bps_conf[2][LIMIT_CNT];
 
-	/* IOPS limits */
+	/* internally used IOPS limits */
 	unsigned int iops[2][LIMIT_CNT];
+	/* user configured IOPS limits */
+	unsigned int iops_conf[2][LIMIT_CNT];
 
 	/* Number of bytes disptached in current slice */
 	uint64_t bytes_disp[2];
@@ -355,6 +360,8 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 		for (index = 0; index < LIMIT_CNT; index++) {
 			tg->bps[rw][index] = U64_MAX;
 			tg->iops[rw][index] = UINT_MAX;
+			tg->bps_conf[rw][index] = U64_MAX;
+			tg->iops_conf[rw][index] = UINT_MAX;
 		}
 	}
 
@@ -414,6 +421,46 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	tg_update_has_rules(pd_to_tg(pd));
 }
 
+static void blk_throtl_update_valid_limit(struct throtl_data *td)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+	bool low_valid = false;
+
+	rcu_read_lock();
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+
+		if (tg->bps[READ][LIMIT_LOW] != U64_MAX ||
+		    tg->bps[WRITE][LIMIT_LOW] != U64_MAX ||
+		    tg->iops[READ][LIMIT_LOW] != UINT_MAX ||
+		    tg->iops[WRITE][LIMIT_LOW] != UINT_MAX)
+			low_valid = true;
+	}
+	rcu_read_unlock();
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
+	tg->bps[READ][LIMIT_LOW] = U64_MAX;
+	tg->bps[WRITE][LIMIT_LOW] = U64_MAX;
+	tg->iops[READ][LIMIT_LOW] = UINT_MAX;
+	tg->iops[WRITE][LIMIT_LOW] = UINT_MAX;
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
@@ -1284,7 +1331,7 @@ static struct cftype throtl_legacy_files[] = {
 	{ }	/* terminate */
 };
 
-static u64 tg_prfill_max(struct seq_file *sf, struct blkg_policy_data *pd,
+static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 			 int off)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
@@ -1294,38 +1341,38 @@ static u64 tg_prfill_max(struct seq_file *sf, struct blkg_policy_data *pd,
 	if (!dname)
 		return 0;
 
-	if (tg->bps[READ][LIMIT_MAX] == U64_MAX &&
-	    tg->bps[WRITE][LIMIT_MAX] == U64_MAX &&
-	    tg->iops[READ][LIMIT_MAX] == UINT_MAX &&
-	    tg->iops[WRITE][LIMIT_MAX] == UINT_MAX)
+	if (tg->bps_conf[READ][off] == U64_MAX &&
+	    tg->bps_conf[WRITE][off] == U64_MAX &&
+	    tg->iops_conf[READ][off] == UINT_MAX &&
+	    tg->iops_conf[WRITE][off] == UINT_MAX)
 		return 0;
 
-	if (tg->bps[READ][LIMIT_MAX] != U64_MAX)
+	if (tg->bps_conf[READ][off] != U64_MAX)
 		snprintf(bufs[0], sizeof(bufs[0]), "%llu",
-			tg->bps[READ][LIMIT_MAX]);
-	if (tg->bps[WRITE][LIMIT_MAX] != U64_MAX)
+			tg->bps_conf[READ][off]);
+	if (tg->bps_conf[WRITE][off] != U64_MAX)
 		snprintf(bufs[1], sizeof(bufs[1]), "%llu",
-			tg->bps[WRITE][LIMIT_MAX]);
-	if (tg->iops[READ][LIMIT_MAX] != UINT_MAX)
+			tg->bps_conf[WRITE][off]);
+	if (tg->iops_conf[READ][off] != UINT_MAX)
 		snprintf(bufs[2], sizeof(bufs[2]), "%u",
-			tg->iops[READ][LIMIT_MAX]);
-	if (tg->iops[WRITE][LIMIT_MAX] != UINT_MAX)
+			tg->iops_conf[READ][off]);
+	if (tg->iops_conf[WRITE][off] != UINT_MAX)
 		snprintf(bufs[3], sizeof(bufs[3]), "%u",
-			tg->iops[WRITE][LIMIT_MAX]);
+			tg->iops_conf[WRITE][off]);
 
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
@@ -1333,6 +1380,7 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 	struct throtl_grp *tg;
 	u64 v[4];
 	int ret;
+	int index = of_cft(of)->private;
 
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
 	if (ret)
@@ -1340,10 +1388,10 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 
 	tg = blkg_to_tg(ctx.blkg);
 
-	v[0] = tg->bps[READ][LIMIT_MAX];
-	v[1] = tg->bps[WRITE][LIMIT_MAX];
-	v[2] = tg->iops[READ][LIMIT_MAX];
-	v[3] = tg->iops[WRITE][LIMIT_MAX];
+	v[0] = tg->bps_conf[READ][index];
+	v[1] = tg->bps_conf[WRITE][index];
+	v[2] = tg->iops_conf[READ][index];
+	v[3] = tg->iops_conf[WRITE][index];
 
 	while (true) {
 		char tok[27];	/* wiops=18446744073709551616 */
@@ -1380,11 +1428,31 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 			goto out_finish;
 	}
 
-	tg->bps[READ][LIMIT_MAX] = v[0];
-	tg->bps[WRITE][LIMIT_MAX] = v[1];
-	tg->iops[READ][LIMIT_MAX] = v[2];
-	tg->iops[WRITE][LIMIT_MAX] = v[3];
+	tg->bps_conf[READ][index] = v[0];
+	tg->bps_conf[WRITE][index] = v[1];
+	tg->iops_conf[READ][index] = v[2];
+	tg->iops_conf[WRITE][index] = v[3];
 
+	if (index == LIMIT_MAX) {
+		tg->bps[READ][index] = v[0];
+		tg->bps[WRITE][index] = v[1];
+		tg->iops[READ][index] = v[2];
+		tg->iops[WRITE][index] = v[3];
+	}
+	tg->bps[READ][LIMIT_LOW] = min(tg->bps_conf[READ][LIMIT_LOW],
+		tg->bps_conf[READ][LIMIT_MAX]);
+	tg->bps[WRITE][LIMIT_LOW] = min(tg->bps_conf[WRITE][LIMIT_LOW],
+		tg->bps_conf[WRITE][LIMIT_MAX]);
+	tg->iops[READ][LIMIT_LOW] = min(tg->iops_conf[READ][LIMIT_LOW],
+		tg->iops_conf[READ][LIMIT_MAX]);
+	tg->iops[WRITE][LIMIT_LOW] = min(tg->iops_conf[WRITE][LIMIT_LOW],
+		tg->iops_conf[WRITE][LIMIT_MAX]);
+
+	if (index == LIMIT_LOW) {
+		blk_throtl_update_valid_limit(tg->td);
+		if (tg->td->limit_valid[LIMIT_LOW])
+			tg->td->limit_index = LIMIT_LOW;
+	}
 	tg_conf_updated(tg);
 	ret = 0;
 out_finish:
@@ -1394,10 +1462,18 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 
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
@@ -1416,6 +1492,7 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_alloc_fn		= throtl_pd_alloc,
 	.pd_init_fn		= throtl_pd_init,
 	.pd_online_fn		= throtl_pd_online,
+	.pd_offline_fn		= throtl_pd_offline,
 	.pd_free_fn		= throtl_pd_free,
 };
 
@@ -1595,6 +1672,7 @@ int blk_throtl_init(struct request_queue *q)
 	td->queue = q;
 
 	td->limit_valid[LIMIT_MAX] = true;
+	td->limit_index = LIMIT_MAX;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
-- 
2.9.3


Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36059 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750802AbdAODmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:37 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0F3ganD008634
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:36 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27ym5khbh9-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:36 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.97) with ESMTP  id
 a7471a28dad411e69f840002c9931860-7aff5a50 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:35 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 03/18] blk-throttle: add .low interface
Date: Sat, 14 Jan 2017 19:42:20 -0800
Message-ID: <3c1d48916094786f20e092dc248a0d3d7c77dfa8.1484451062.git.shli@fb.com>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
References: <cover.1484451062.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add low limit for cgroup and corresponding cgroup interface. To be
consistent with memcg, we allow users configure .low limit higher than
.max limit. But the internal logic always assumes .low limit is lower
than .max limit. So we add extra bps/iops_conf fields in throtl_grp for
userspace configuration. Old bps/iops fields in throtl_grp will be the
actual limit we use for throttling.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 142 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 28 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b08369b..d3ad43c 100644
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
@@ -355,6 +360,11 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 	tg->bps[WRITE][LIMIT_MAX] = U64_MAX;
 	tg->iops[READ][LIMIT_MAX] = UINT_MAX;
 	tg->iops[WRITE][LIMIT_MAX] = UINT_MAX;
+	tg->bps_conf[READ][LIMIT_MAX] = U64_MAX;
+	tg->bps_conf[WRITE][LIMIT_MAX] = U64_MAX;
+	tg->iops_conf[READ][LIMIT_MAX] = UINT_MAX;
+	tg->iops_conf[WRITE][LIMIT_MAX] = UINT_MAX;
+	/* LIMIT_LOW will have default value 0 */
 
 	return &tg->pd;
 }
@@ -412,6 +422,41 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	tg_update_has_rules(pd_to_tg(pd));
 }
 
+static void blk_throtl_update_limit_valid(struct throtl_data *td)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+	bool low_valid = false;
+
+	rcu_read_lock();
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+
+		if (tg->bps[READ][LIMIT_LOW] || tg->bps[WRITE][LIMIT_LOW] ||
+		    tg->iops[READ][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW])
+			low_valid = true;
+	}
+	rcu_read_unlock();
+
+	td->limit_valid[LIMIT_LOW] = low_valid;
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
+	blk_throtl_update_limit_valid(tg->td);
+
+	if (tg->td->limit_index == LIMIT_LOW &&
+	    !tg->td->limit_valid[LIMIT_LOW])
+		tg->td->limit_index = LIMIT_MAX;
+}
+
 static void throtl_pd_free(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
@@ -1282,48 +1327,58 @@ static struct cftype throtl_legacy_files[] = {
 	{ }	/* terminate */
 };
 
-static u64 tg_prfill_max(struct seq_file *sf, struct blkg_policy_data *pd,
+static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 			 int off)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
 	const char *dname = blkg_dev_name(pd->blkg);
 	char bufs[4][21] = { "max", "max", "max", "max" };
+	u64 bps_dft;
+	unsigned int iops_dft;
 
 	if (!dname)
 		return 0;
 
-	if (tg->bps[READ][LIMIT_MAX] == U64_MAX &&
-	    tg->bps[WRITE][LIMIT_MAX] == U64_MAX &&
-	    tg->iops[READ][LIMIT_MAX] == UINT_MAX &&
-	    tg->iops[WRITE][LIMIT_MAX] == UINT_MAX)
+	if (off == LIMIT_LOW) {
+		bps_dft = 0;
+		iops_dft = 0;
+	} else {
+		bps_dft = U64_MAX;
+		iops_dft = UINT_MAX;
+	}
+
+	if (tg->bps_conf[READ][off] == bps_dft &&
+	    tg->bps_conf[WRITE][off] == bps_dft &&
+	    tg->iops_conf[READ][off] == iops_dft &&
+	    tg->iops_conf[WRITE][off] == iops_dft)
 		return 0;
 
-	if (tg->bps[READ][LIMIT_MAX] != U64_MAX)
+	if (tg->bps_conf[READ][off] != bps_dft)
 		snprintf(bufs[0], sizeof(bufs[0]), "%llu",
-			tg->bps[READ][LIMIT_MAX]);
-	if (tg->bps[WRITE][LIMIT_MAX] != U64_MAX)
+			tg->bps_conf[READ][off]);
+	if (tg->bps_conf[WRITE][off] != bps_dft)
 		snprintf(bufs[1], sizeof(bufs[1]), "%llu",
-			tg->bps[WRITE][LIMIT_MAX]);
-	if (tg->iops[READ][LIMIT_MAX] != UINT_MAX)
+			tg->bps_conf[WRITE][off]);
+	if (tg->iops_conf[READ][off] != iops_dft)
 		snprintf(bufs[2], sizeof(bufs[2]), "%u",
-			tg->iops[READ][LIMIT_MAX]);
-	if (tg->iops[WRITE][LIMIT_MAX] != UINT_MAX)
+			tg->iops_conf[READ][off]);
+	if (tg->iops_conf[WRITE][off] != iops_dft)
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
@@ -1331,6 +1386,7 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 	struct throtl_grp *tg;
 	u64 v[4];
 	int ret;
+	int index = of_cft(of)->private;
 
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
 	if (ret)
@@ -1338,10 +1394,10 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 
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
@@ -1378,11 +1434,31 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
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
+		blk_throtl_update_limit_valid(tg->td);
+		if (tg->td->limit_valid[LIMIT_LOW])
+			tg->td->limit_index = LIMIT_LOW;
+	}
 	tg_conf_updated(tg);
 	ret = 0;
 out_finish:
@@ -1392,10 +1468,18 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 
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
@@ -1414,6 +1498,7 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_alloc_fn		= throtl_pd_alloc,
 	.pd_init_fn		= throtl_pd_init,
 	.pd_online_fn		= throtl_pd_online,
+	.pd_offline_fn		= throtl_pd_offline,
 	.pd_free_fn		= throtl_pd_free,
 };
 
@@ -1593,6 +1678,7 @@ int blk_throtl_init(struct request_queue *q)
 	td->queue = q;
 
 	td->limit_valid[LIMIT_MAX] = true;
+	td->limit_index = LIMIT_MAX;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
-- 
2.9.3


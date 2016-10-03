Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54297 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753623AbcJCVV3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 17:21:29 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u93LEKGU023818
        for <linux-block@vger.kernel.org>; Mon, 3 Oct 2016 14:21:28 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 25t8y8mss2-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2016 14:21:22 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.223.101.97) with ESMTP id
 370ae2ba89af11e6ab9124be0595f910-dc7fca50 for <linux-block@vger.kernel.org>;
        Mon, 03 Oct 2016 14:20:32 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH v3 02/11] block-throttle: add .high interface
Date: Mon, 3 Oct 2016 14:20:21 -0700
Message-ID: <d531e23e4d0a756884d7cfc18fb53fbda09c65af.1475529372.git.shli@fb.com>
In-Reply-To: <cover.1475529372.git.shli@fb.com>
References: <cover.1475529372.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add high limit for cgroup and corresponding cgroup interface.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 139 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 107 insertions(+), 32 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 964b713..59d4b4c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -84,8 +84,9 @@ enum tg_state_flags {
 #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
 
 enum {
-	LIMIT_MAX = 0,
-	LIMIT_CNT = 1,
+	LIMIT_HIGH = 0,
+	LIMIT_MAX = 1,
+	LIMIT_CNT = 2,
 };
 
 struct throtl_grp {
@@ -352,7 +353,7 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 
 	RB_CLEAR_NODE(&tg->rb_node);
 	for (rw = READ; rw <= WRITE; rw++) {
-		for (index = LIMIT_MAX; index < LIMIT_CNT; index++) {
+		for (index = LIMIT_HIGH; index < LIMIT_CNT; index++) {
 			tg->bps[rw][index] = -1;
 			tg->iops[rw][index] = -1;
 		}
@@ -414,6 +415,46 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	tg_update_has_rules(pd_to_tg(pd));
 }
 
+static void blk_throtl_update_valid_limit(struct throtl_data *td)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+	bool high_valid = false;
+
+	rcu_read_lock();
+	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+
+		if (tg->bps[READ][LIMIT_HIGH] != -1 ||
+		    tg->bps[WRITE][LIMIT_HIGH] != -1 ||
+		    tg->iops[READ][LIMIT_HIGH] != -1 ||
+		    tg->iops[WRITE][LIMIT_HIGH] != -1)
+			high_valid = true;
+	}
+	rcu_read_unlock();
+
+	if (high_valid)
+		td->limit_valid[LIMIT_HIGH] = true;
+	else
+		td->limit_valid[LIMIT_HIGH] = false;
+}
+
+static void throtl_pd_offline(struct blkg_policy_data *pd)
+{
+	struct throtl_grp *tg = pd_to_tg(pd);
+
+	tg->bps[READ][LIMIT_HIGH] = -1;
+	tg->bps[WRITE][LIMIT_HIGH] = -1;
+	tg->iops[READ][LIMIT_HIGH] = -1;
+	tg->iops[WRITE][LIMIT_HIGH] = -1;
+
+	blk_throtl_update_valid_limit(tg->td);
+
+	if (tg->td->limit_index == LIMIT_HIGH &&
+	    !tg->td->limit_valid[LIMIT_HIGH])
+		tg->td->limit_index = LIMIT_MAX;
+}
+
 static void throtl_pd_free(struct blkg_policy_data *pd)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
@@ -1283,7 +1324,7 @@ static struct cftype throtl_legacy_files[] = {
 	{ }	/* terminate */
 };
 
-static u64 tg_prfill_max(struct seq_file *sf, struct blkg_policy_data *pd,
+static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 			 int off)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
@@ -1292,36 +1333,32 @@ static u64 tg_prfill_max(struct seq_file *sf, struct blkg_policy_data *pd,
 
 	if (!dname)
 		return 0;
-	if (tg->bps[READ][LIMIT_MAX] == -1 && tg->bps[WRITE][LIMIT_MAX] == -1 &&
-	    tg->iops[READ][LIMIT_MAX] == -1 && tg->iops[WRITE][LIMIT_MAX] == -1)
+	if (tg->bps[READ][off] == -1 && tg->bps[WRITE][off] == -1 &&
+	    tg->iops[READ][off] == -1 && tg->iops[WRITE][off] == -1)
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
+	if (tg->bps[READ][off] != -1)
+		snprintf(bufs[0], sizeof(bufs[0]), "%llu", tg->bps[READ][off]);
+	if (tg->bps[WRITE][off] != -1)
+		snprintf(bufs[1], sizeof(bufs[1]), "%llu", tg->bps[WRITE][off]);
+	if (tg->iops[READ][off] != -1)
+		snprintf(bufs[2], sizeof(bufs[2]), "%u", tg->iops[READ][off]);
+	if (tg->iops[WRITE][off] != -1)
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
@@ -1329,6 +1366,7 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 	struct throtl_grp *tg;
 	u64 v[4];
 	int ret;
+	int index = of_cft(of)->private;
 
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
 	if (ret)
@@ -1336,10 +1374,10 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 
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
@@ -1376,11 +1414,37 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 			goto out_finish;
 	}
 
-	tg->bps[READ][LIMIT_MAX] = v[0];
-	tg->bps[WRITE][LIMIT_MAX] = v[1];
-	tg->iops[READ][LIMIT_MAX] = v[2];
-	tg->iops[WRITE][LIMIT_MAX] = v[3];
-
+	if (index == LIMIT_MAX) {
+		if ((v[0] < tg->bps[READ][LIMIT_HIGH] &&
+		       tg->bps[READ][LIMIT_HIGH] != -1) ||
+		    (v[1] < tg->bps[WRITE][LIMIT_HIGH] &&
+		       tg->bps[WRITE][LIMIT_HIGH] != -1) ||
+		    (v[2] < tg->iops[READ][LIMIT_HIGH] &&
+		       tg->iops[READ][LIMIT_HIGH] != -1) ||
+		    (v[3] < tg->iops[WRITE][LIMIT_HIGH] &&
+		       tg->iops[WRITE][LIMIT_HIGH] != -1)) {
+			ret = -EINVAL;
+			goto out_finish;
+		}
+	} else if (index == LIMIT_HIGH) {
+		if ((v[0] > tg->bps[READ][LIMIT_MAX] && v[0] != -1) ||
+		    (v[1] > tg->bps[WRITE][LIMIT_MAX] && v[1] != -1) ||
+		    (v[2] > tg->iops[READ][LIMIT_MAX] && v[2] != -1) ||
+		    (v[3] > tg->iops[WRITE][LIMIT_MAX] && v[3] != -1)) {
+			ret = -EINVAL;
+			goto out_finish;
+		}
+	}
+	tg->bps[READ][index] = v[0];
+	tg->bps[WRITE][index] = v[1];
+	tg->iops[READ][index] = v[2];
+	tg->iops[WRITE][index] = v[3];
+
+	if (index == LIMIT_HIGH) {
+		blk_throtl_update_valid_limit(tg->td);
+		if (tg->td->limit_valid[LIMIT_HIGH])
+			tg->td->limit_index = LIMIT_HIGH;
+	}
 	tg_conf_updated(tg);
 	ret = 0;
 out_finish:
@@ -1390,10 +1454,18 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 
 static struct cftype throtl_files[] = {
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
-		.seq_show = tg_print_max,
-		.write = tg_set_max,
+		.seq_show = tg_print_limit,
+		.write = tg_set_limit,
+		.private = LIMIT_MAX,
 	},
 	{ }	/* terminate */
 };
@@ -1412,6 +1484,7 @@ static struct blkcg_policy blkcg_policy_throtl = {
 	.pd_alloc_fn		= throtl_pd_alloc,
 	.pd_init_fn		= throtl_pd_init,
 	.pd_online_fn		= throtl_pd_online,
+	.pd_offline_fn		= throtl_pd_offline,
 	.pd_free_fn		= throtl_pd_free,
 };
 
@@ -1589,7 +1662,9 @@ int blk_throtl_init(struct request_queue *q)
 	q->td = td;
 	td->queue = q;
 
+	td->limit_valid[LIMIT_HIGH] = false;
 	td->limit_valid[LIMIT_MAX] = true;
+	td->limit_index = LIMIT_MAX;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
 	if (ret)
-- 
2.9.3


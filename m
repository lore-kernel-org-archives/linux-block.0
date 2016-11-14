Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55988 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965101AbcKNWW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 17:22:27 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAEMJX9n003030
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:27 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 26qjtr93s3-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:27 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.223.100.99) with ESMTP id
 d1d1d0ccaab811e6b87124be05956610-860e6a50 for <linux-block@vger.kernel.org>;
        Mon, 14 Nov 2016 14:22:25 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V4 14/15] blk-throttle: add interface for per-cgroup target latency
Date: Mon, 14 Nov 2016 14:22:21 -0800
Message-ID: <93c7f38eb0d18995cd4d743cb15d986190e5f750.1479161136.git.shli@fb.com>
In-Reply-To: <cover.1479161136.git.shli@fb.com>
References: <cover.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add interface for per-cgroup target latency. This latency is for 4k
request.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a05d351..ac4d9ea 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -147,6 +147,8 @@ struct throtl_grp {
 	unsigned long last_check_time;
 
 	int upgrade_check_batch;
+
+	u64 latency_target;
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -463,6 +465,7 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 			tg->iops[rw][index] = -1;
 		}
 	}
+	/* target latency default 0, eg, always not meet */
 
 	return &tg->pd;
 }
@@ -1572,6 +1575,64 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static u64 tg_prfill_latency_target(struct seq_file *sf,
+	struct blkg_policy_data *pd, int off)
+{
+	struct throtl_grp *tg = pd_to_tg(pd);
+	const char *dname = blkg_dev_name(pd->blkg);
+
+	if (!dname)
+		return 0;
+	if (tg->latency_target == 0)
+		return 0;
+
+	seq_printf(sf, "%s 4k_lat=%llu\n", dname, tg->latency_target);
+	return 0;
+}
+
+static int tg_print_latency_target(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+		tg_prfill_latency_target, &blkcg_policy_throtl,
+		seq_cft(sf)->private, false);
+	return 0;
+}
+
+static ssize_t tg_set_latency_target(struct kernfs_open_file *of,
+				     char *buf, size_t nbytes, loff_t off)
+{
+	struct blkcg *blkcg = css_to_blkcg(of_css(of));
+	struct blkg_conf_ctx ctx;
+	struct throtl_grp *tg;
+	int ret = -EINVAL;
+	char tok[27];
+	char *p;
+	u64 val;
+
+	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
+	if (ret)
+		return ret;
+
+	tg = blkg_to_tg(ctx.blkg);
+
+	if (sscanf(ctx.body, "%26s", tok) != 1)
+		goto out_finish;
+
+	p = tok;
+	strsep(&p, "=");
+	if (!p || kstrtou64(p, 10, &val))
+		goto out_finish;
+
+	if (strcmp(tok, "4k_lat"))
+		goto out_finish;
+
+	tg->latency_target = val;
+	ret = 0;
+out_finish:
+	blkg_conf_finish(&ctx);
+	return ret ?: nbytes;
+}
+
 static struct cftype throtl_files[] = {
 	{
 		.name = "high",
@@ -1587,6 +1648,12 @@ static struct cftype throtl_files[] = {
 		.write = tg_set_limit,
 		.private = LIMIT_MAX,
 	},
+	{
+		.name = "latency_target",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = tg_print_latency_target,
+		.write = tg_set_latency_target,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.9.3


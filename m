Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57811 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965031AbcKNWWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 17:22:25 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAEMLP3d016476
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:24 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 26p2f2t49u-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:24 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.223.100.99) with ESMTP id
 d06a7194aab811e6985324be05956610-81dfda50 for <linux-block@vger.kernel.org>;
        Mon, 14 Nov 2016 14:22:23 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V4 03/15] blk-throttle: configure bps/iops limit for cgroup in high limit
Date: Mon, 14 Nov 2016 14:22:10 -0800
Message-ID: <7a4f1b1b0f67bb02d0caadae808c1a89413c202d.1479161136.git.shli@fb.com>
In-Reply-To: <cover.1479161136.git.shli@fb.com>
References: <cover.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

each queue will have a state machine. Initially queue is in LIMIT_HIGH
state, which means all cgroups will be throttled according to their high
limit. After all cgroups with high limit cross the limit, the queue state
gets upgraded to LIMIT_MAX state.
cgroups without high limit will use max limit for their high limit.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a564215..ec53671 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -208,12 +208,29 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 
 static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 {
-	return tg->bps[rw][tg->td->limit_index];
+	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	uint64_t ret;
+
+	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
+		return -1;
+	ret = tg->bps[rw][tg->td->limit_index];
+	if (ret == -1 && tg->td->limit_index == LIMIT_HIGH)
+		return tg->bps[rw][LIMIT_MAX];
+
+	return ret;
 }
 
 static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 {
-	return tg->iops[rw][tg->td->limit_index];
+	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	unsigned int ret;
+
+	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
+		return -1;
+	ret = tg->iops[rw][tg->td->limit_index];
+	if (ret == -1 && tg->td->limit_index == LIMIT_HIGH)
+		return tg->iops[rw][LIMIT_MAX];
+	return ret;
 }
 
 /**
-- 
2.9.3


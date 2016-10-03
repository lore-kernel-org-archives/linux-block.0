Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43226 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752074AbcJCVVT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 17:21:19 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.17/8.16.0.17) with SMTP id u93LJ4Nt027461
        for <linux-block@vger.kernel.org>; Mon, 3 Oct 2016 14:21:18 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 25t8tbef7s-12
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2016 14:21:18 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.223.100.97) with ESMTP id
 3792d2b089af11e69e6224be0593f280-6eae7a50 for <linux-block@vger.kernel.org>;
        Mon, 03 Oct 2016 14:20:32 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH v3 03/11] block-throttle: configure bps/iops limit for cgroup in high limit
Date: Mon, 3 Oct 2016 14:20:22 -0700
Message-ID: <c3230437bee26afcf2938421a35471d1bca56daf.1475529372.git.shli@fb.com>
In-Reply-To: <cover.1475529372.git.shli@fb.com>
References: <cover.1475529372.git.shli@fb.com>
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
index 59d4b4c..e2b3704 100644
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


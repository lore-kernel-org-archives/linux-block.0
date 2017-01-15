Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59141 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750812AbdAODmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:37 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0F3eDI1002202
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:36 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27ygw69px9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:36 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.99) with ESMTP id
 a7510f88dad411e68df70002c99293a0-729f7a50 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:35 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 04/18] blk-throttle: configure bps/iops limit for cgroup in low limit
Date: Sat, 14 Jan 2017 19:42:21 -0800
Message-ID: <f2c640aba4ba65d364fb26b300850d2531619c7d.1484451062.git.shli@fb.com>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
References: <cover.1484451062.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

each queue will have a state machine. Initially queue is in LIMIT_LOW
state, which means all cgroups will be throttled according to their low
limit. After all cgroups with low limit cross the limit, the queue state
gets upgraded to LIMIT_MAX state.
For max limit, cgroup will use the limit configured by user.
For low limit, cgroup will use the minimal value between low limit and
max limit configured by user. If the minimal value is 0, which means the
cgroup doesn't configure low limit, we will use max limit to throttle
the cgroup and the cgroup is ready to upgrade to LIMIT_MAX

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d3ad43c..3bc6deb 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -212,12 +212,28 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 
 static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 {
-	return tg->bps[rw][tg->td->limit_index];
+	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	uint64_t ret;
+
+	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
+		return U64_MAX;
+	ret = tg->bps[rw][tg->td->limit_index];
+	if (ret == 0 && tg->td->limit_index == LIMIT_LOW)
+		return tg->bps[rw][LIMIT_MAX];
+	return ret;
 }
 
 static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 {
-	return tg->iops[rw][tg->td->limit_index];
+	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	unsigned int ret;
+
+	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
+		return UINT_MAX;
+	ret = tg->iops[rw][tg->td->limit_index];
+	if (ret == 0 && tg->td->limit_index == LIMIT_LOW)
+		return tg->iops[rw][LIMIT_MAX];
+	return ret;
 }
 
 /**
-- 
2.9.3


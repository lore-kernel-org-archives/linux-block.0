Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57243 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756214AbcLOUdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:10 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFKUZH2024779
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:09 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27bxsyagm7-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:09 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.99) with ESMTP id
 b0a4f798c30511e6b4950002c99293a0-741faa50 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:08 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 04/17] blk-throttle: configure bps/iops limit for cgroup in low limit
Date: Thu, 15 Dec 2016 12:32:55 -0800
Message-ID: <04bae2f6239c13d3160d7c0196c97217c5e4b4c3.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

each queue will have a state machine. Initially queue is in LIMIT_LOW
state, which means all cgroups will be throttled according to their low
limit. After all cgroups with low limit cross the limit, the queue state
gets upgraded to LIMIT_MAX state.
For max limit, cgroup will use the limit configured by user.
For low limit, cgroup will use the minimal between low limit and max
limit configured by user. Last patch already did the convertion.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index fcc4199..e55bd36 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -212,11 +212,21 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 
 static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 {
+	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	uint64_t ret;
+
+	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
+		return U64_MAX;
 	return tg->bps[rw][tg->td->limit_index];
 }
 
 static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 {
+	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	unsigned int ret;
+
+	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
+		return UINT_MAX;
 	return tg->iops[rw][tg->td->limit_index];
 }
 
-- 
2.9.3


Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33475 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754872AbcIOQXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 12:23:22 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8FGFE6W022591
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:21 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 25fww30vgw-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 09:23:21 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)     by
 mx-out.facebook.com (10.223.100.97) with ESMTP id
 b68feb007b6011e6a8e524be0593f280-f85fba50 for <linux-block@vger.kernel.org>;
        Thu, 15 Sep 2016 09:23:19 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH V2 03/11] block-throttle: configure bps/iops limit for cgroup in high limit
Date: Thu, 15 Sep 2016 09:23:10 -0700
Message-ID: <3d5ec2c037901f7e30478b1d5a3f8d7cacf657cf.1473953743.git.shli@fb.com>
In-Reply-To: <cover.1473953743.git.shli@fb.com>
References: <cover.1473953743.git.shli@fb.com>
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
index 02323fb..6bae1b4 100644
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
2.8.0.rc2


Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52723 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753210AbcEKAQ7 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:16:59 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4B0Gvbq018072
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:58 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 22usuar1v4-4
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:58 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.236.89) with ESMTP	id
 a3414524170d11e6a00f0002c95209d8-9c4f7c50 for <linux-block@vger.kernel.org>;
	Tue, 10 May 2016 17:16:42 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <vgoyal@redhat.com>, <axboe@fb.com>,
	<jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 03/10] block-throttle: configure bps/iops limit for cgroup in low limit
Date: Tue, 10 May 2016 17:16:33 -0700
Message-ID: <25831792648e40834563bac2e81a449260a52c20.1462923578.git.shli@fb.com>
In-Reply-To: <cover.1462923578.git.shli@fb.com>
References: <cover.1462923578.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

each queue will have a state machine. Initially queue is in LOW_LIMIT
state, which means all cgroups will be throttled according to their low
limit. After all cgroups with low limit cross the limit, the queue state
gets upgraded to high/max state. This will guarantee cgroups with low
limit have at least low limit bandwidth/iops before other cgroups can
use the disk.
For cgroups without low limit, they are assigned a small bps/iops to
avoid completed stall.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e69a3db..bdcf1b7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -213,12 +213,37 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 
 static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 {
-	return tg->bps[rw][tg->td->limit_index];
+	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	uint64_t ret;
+
+	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
+		return -1;
+	ret = tg->bps[rw][tg->td->limit_index];
+	if (ret == 0 && tg->td->limit_index == LIMIT_LOW) {
+		if (tg->iops[rw][LIMIT_LOW])
+			return -1;
+		/* assign a small default */
+		return 64 * 1024;
+	}
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
+	if (ret == 0 && tg->td->limit_index == LIMIT_LOW) {
+		if (tg->bps[rw][LIMIT_LOW])
+			return -1;
+		/* assign a small default */
+		return 16;
+	}
+	return ret;
 }
 
 /**
-- 
2.8.0.rc2


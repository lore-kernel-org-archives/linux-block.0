Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:7825 "EHLO
        BJEXCAS005.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965224AbdJQP4c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2017 11:56:32 -0400
Date: Tue, 17 Oct 2017 23:56:21 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <jthumshirn@suse.de>, <linux-block@vger.kernel.org>
Subject: [PATCH v4] blkcg: add sanity check for blkcg policy operations
Message-ID: <20171017155621.GA38911@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blkcg policy should keep cpd/pd's alloc_fn and free_fn in pairs,
otherwise policy would register fail.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
Changes since V4:
 * merge "if(cpd->xxx)" and "if(pd->xxx)" together

Changes since V3:
 * make if more cleaner by using !pold->cpd_alloc_fn ^ !pol->cpd_free_fn

Chagnes since V2:
 * merge blkcg_policy_check_ops into the caller blkcg_policy_register

V1:
 * add blkcg_policy_check_ops to check cpd/pd's alloc_fn and free_fn in
 * pairs.

 block/blk-cgroup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e7ec676..4117524 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1419,6 +1419,11 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	if (i >= BLKCG_MAX_POLS)
 		goto err_unlock;
 
+	/* Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs */
+	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
+		(!pol->pd_alloc_fn ^ !pol->pd_free_fn))
+		goto err_unlock;
+
 	/* register @pol */
 	pol->plid = i;
 	blkcg_policy[pol->plid] = pol;
-- 
2.9.4

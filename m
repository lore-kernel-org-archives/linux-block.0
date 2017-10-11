Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:14758 "EHLO
        BJEXCAS002.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751415AbdJKJqc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2017 05:46:32 -0400
Date: Wed, 11 Oct 2017 17:46:23 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jthumshirn@suse.de>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH v2] blkcg: add sanity check for blkcg policy operations
Message-ID: <20171011094619.GA37417@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blkcg policy should keep cpd/pd's alloc_fn and free_fn in pairs,
otherwise policy would register fail.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-cgroup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e7ec676..67b01c5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1419,6 +1419,16 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	if (i >= BLKCG_MAX_POLS)
 		goto err_unlock;
 
+	/* Make sure cpd_alloc_fn and cpd_free_fn in pairs */
+	if ((pol->cpd_alloc_fn && !pol->cpd_free_fn) ||
+		(!pol->cpd_alloc_fn && pol->cpd_free_fn))
+		goto err_unlock;
+
+	/* Make sure pd_alloc_fn and pd_free_fn in pairs */
+	if ((pol->pd_alloc_fn && !pol->pd_free_fn) ||
+		(!pol->pd_alloc_fn && pol->pd_free_fn))
+		goto err_unlock;
+
 	/* register @pol */
 	pol->plid = i;
 	blkcg_policy[pol->plid] = pol;
-- 
2.9.4

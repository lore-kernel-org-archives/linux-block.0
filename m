Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 12 Oct 2017 14:47:24 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jthumshirn@suse.de>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH v3] blkcg: add sanity check for blkcg policy operations
Message-ID: <20171012064714.GA3069@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

blkcg policy should keep cpd/pd's alloc_fn and free_fn in pairs,
otherwise policy would register fail.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-cgroup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e7ec676..6c5f5f3 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1419,6 +1419,13 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	if (i >= BLKCG_MAX_POLS)
 		goto err_unlock;
 
+	/* Make sure cpd_alloc_fn and cpd_free_fn in pairs */
+	if (!pol->cpd_alloc_fn ^ !pol->cpd_free_fn)
+		goto err_unlock;
+
+	if (!pol->pd_alloc_fn ^ !pol->pd_free_fn)
+		goto err_unlock;
+
 	/* register @pol */
 	pol->plid = i;
 	blkcg_policy[pol->plid] = pol;
-- 
2.9.4

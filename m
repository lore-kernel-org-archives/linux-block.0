Return-Path: <zhangweiping@didichuxing.com>
Date: Wed, 11 Oct 2017 00:00:55 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blkcg: add sanity check for blkcg policy operations
Message-ID: <20171010160050.GA1601@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

blkcg policy should keep cpd/pd's alloc_fn and free_fn in pairs,
otherwise policy would register fail.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-cgroup.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e7ec676..557c122 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1397,6 +1397,26 @@ void blkcg_deactivate_policy(struct request_queue *q,
 EXPORT_SYMBOL_GPL(blkcg_deactivate_policy);
 
 /**
+ * blkcg_policy_check_ops - check policy's operations
+ * @pol: blkcg policy to check
+ *
+ * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs.
+ * Return true on success and false on failure.
+ */
+static bool blkcg_policy_check_ops(struct blkcg_policy *pol)
+{
+	if ((pol->cpd_alloc_fn && !pol->cpd_free_fn) ||
+		(!pol->cpd_alloc_fn && pol->cpd_free_fn))
+		return false;
+
+	if ((pol->pd_alloc_fn && !pol->pd_free_fn) ||
+		(!pol->pd_alloc_fn && pol->pd_free_fn))
+		return false;
+
+	return true;
+}
+
+/**
  * blkcg_policy_register - register a blkcg policy
  * @pol: blkcg policy to register
  *
@@ -1419,6 +1439,9 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	if (i >= BLKCG_MAX_POLS)
 		goto err_unlock;
 
+	if (!blkcg_policy_check_ops(pol))
+		goto err_unlock;
+
 	/* register @pol */
 	pol->plid = i;
 	blkcg_policy[pol->plid] = pol;
-- 
2.9.4

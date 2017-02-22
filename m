Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36625 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbdBVKO3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 05:14:29 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@osandov.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 3/4] blk-mq: make lifetime consistent between hctx and its kobject
Date: Wed, 22 Feb 2017 18:14:01 +0800
Message-Id: <1487758442-5855-4-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
References: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch removes kobject_put() over hctx in __blk_mq_unregister_dev(),
and trys to keep lifetime consistent between hctx and hctx's kobject.

Now blk_mq_sysfs_register() and blk_mq_sysfs_unregister() become
totally symmetrical, and kobject's refcounter drops to zero just
when the hctx is freed.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-mq-sysfs.c | 15 ++++++++++-----
 block/blk-mq.c       |  5 +----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 77fb238af2be..cb19ec16a7fc 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -17,6 +17,14 @@ static void blk_mq_sysfs_release(struct kobject *kobj)
 {
 }
 
+static void blk_mq_hw_sysfs_release(struct kobject *kobj)
+{
+	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
+						  kobj);
+	kfree(hctx->ctxs);
+	kfree(hctx);
+}
+
 struct blk_mq_ctx_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct blk_mq_ctx *, char *);
@@ -200,7 +208,7 @@ static struct kobj_type blk_mq_ctx_ktype = {
 static struct kobj_type blk_mq_hw_ktype = {
 	.sysfs_ops	= &blk_mq_hw_sysfs_ops,
 	.default_attrs	= default_hw_ctx_attrs,
-	.release	= blk_mq_sysfs_release,
+	.release	= blk_mq_hw_sysfs_release,
 };
 
 static void blk_mq_unregister_hctx(struct blk_mq_hw_ctx *hctx)
@@ -244,12 +252,9 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
+	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
-		kobject_put(&hctx->kobj);
-	}
-
 	blk_mq_debugfs_unregister_hctxs(q);
 
 	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bc45736d70ba..993bb4d4d909 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2152,8 +2152,7 @@ void blk_mq_release(struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx)
 			continue;
-		kfree(hctx->ctxs);
-		kfree(hctx);
+		kobject_put(&hctx->kobj);
 	}
 
 	q->mq_map = NULL;
@@ -2232,8 +2231,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			blk_mq_exit_hctx(q, set, hctx, j);
 			free_cpumask_var(hctx->cpumask);
 			kobject_put(&hctx->kobj);
-			kfree(hctx->ctxs);
-			kfree(hctx);
 			hctxs[j] = NULL;
 
 		}
-- 
2.7.4

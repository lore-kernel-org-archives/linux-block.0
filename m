Return-Path: <linux-block-owner@vger.kernel.org>
Received: from m50-138.163.com ([123.125.50.138]:34535 "EHLO m50-138.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475AbcEWJK7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 23 May 2016 05:10:59 -0400
From: Wenwei Tao <wwtao0320@163.com>
To: mb@lightnvm.io
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	ww.tao0320@gmail.com
Subject: [PATCH v2 1/2] lightnvm: hold lock until finish the target creation
Date: Mon, 23 May 2016 17:13:33 +0800
Message-Id: <1463994814-3388-1-git-send-email-wwtao0320@163.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Wenwei Tao <ww.tao0320@gmail.com>

When create a target, we check whether the target is
already exist first. If the answer is no, we release
the lock and continue the creation. This cannot prevent
concurrent creation of the same target, so hold the lock
until finish the target creation.

Signed-off-by: Wenwei Tao <ww.tao0320@gmail.com>
---
Changes since v1
-rebase to for-4.8/core

 drivers/lightnvm/gennvm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index c65fb67..39ff0af 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -44,6 +44,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	struct nvm_tgt_type *tt;
 	struct nvm_target *t;
 	void *targetdata;
+	int ret = -ENOMEM;
 
 	tt = nvm_find_target_type(create->tgttype, 1);
 	if (!tt) {
@@ -55,14 +56,13 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	t = gen_find_target(gn, create->tgtname);
 	if (t) {
 		pr_err("nvm: target name already exists.\n");
-		mutex_unlock(&gn->lock);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unlock;
 	}
-	mutex_unlock(&gn->lock);
 
 	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
 	if (!t)
-		return -ENOMEM;
+		goto err_unlock;
 
 	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
 	if (!tqueue)
@@ -95,8 +95,6 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	t->type = tt;
 	t->disk = tdisk;
 	t->dev = dev;
-
-	mutex_lock(&gn->lock);
 	list_add_tail(&t->list, &gn->targets);
 	mutex_unlock(&gn->lock);
 
@@ -107,7 +105,9 @@ err_queue:
 	blk_cleanup_queue(tqueue);
 err_t:
 	kfree(t);
-	return -ENOMEM;
+err_unlock:
+	mutex_unlock(&gn->lock);
+	return ret;
 }
 
 static void __gen_remove_target(struct nvm_target *t)
-- 
1.8.3.1



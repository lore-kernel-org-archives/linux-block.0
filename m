Return-Path: <linux-block-owner@vger.kernel.org>
Received: from m50-138.163.com ([123.125.50.138]:44371 "EHLO m50-138.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849AbcESGhW (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 19 May 2016 02:37:22 -0400
From: Wenwei Tao <wwtao0320@163.com>
To: mb@lightnvm.io
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	ww.tao0320@gmail.com
Subject: [PATCH 2/2] lightnvm: hold nvm_lock until finish the target creation
Date: Thu, 19 May 2016 14:38:41 +0800
Message-Id: <1463639921-1824-2-git-send-email-wwtao0320@163.com>
In-Reply-To: <1463639921-1824-1-git-send-email-wwtao0320@163.com>
References: <1463639921-1824-1-git-send-email-wwtao0320@163.com>
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
 drivers/lightnvm/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 160c1a6..a622081 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -791,6 +791,7 @@ static int nvm_create_target(struct nvm_dev *dev,
 	struct nvm_tgt_type *tt;
 	struct nvm_target *t;
 	void *targetdata;
+	int ret = -ENOMEM;
 
 	if (!dev->mt) {
 		pr_info("nvm: device has no media manager registered.\n");
@@ -801,21 +802,20 @@ static int nvm_create_target(struct nvm_dev *dev,
 	tt = nvm_find_target_type(create->tgttype);
 	if (!tt) {
 		pr_err("nvm: target type %s not found\n", create->tgttype);
-		up_write(&nvm_lock);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unlock;
 	}
 
 	t = nvm_find_target(create->tgtname);
 	if (t) {
 		pr_err("nvm: target name already exists.\n");
-		up_write(&nvm_lock);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unlock;
 	}
-	up_write(&nvm_lock);
 
 	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
 	if (!t)
-		return -ENOMEM;
+		goto err_unlock;
 
 	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
 	if (!tqueue)
@@ -848,8 +848,6 @@ static int nvm_create_target(struct nvm_dev *dev,
 	t->type = tt;
 	t->disk = tdisk;
 	t->dev = dev;
-
-	down_write(&nvm_lock);
 	list_add_tail(&t->list, &nvm_targets);
 	up_write(&nvm_lock);
 
@@ -860,7 +858,9 @@ err_queue:
 	blk_cleanup_queue(tqueue);
 err_t:
 	kfree(t);
-	return -ENOMEM;
+err_unlock:
+	up_write(&nvm_lock);
+	return ret;
 }
 
 static int __nvm_configure_create(struct nvm_ioctl_create *create)
-- 
1.8.3.1



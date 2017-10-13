Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51262 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbdJMMrI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so21572221wme.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:07 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 01/58] lightnvm: prevent target type module removal when in use
Date: Fri, 13 Oct 2017 14:45:50 +0200
Message-Id: <20171013124647.32668-2-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

If target type module e.g. pblk here is unloaded (rmmod) while module
is in use (after creating target) system crashes.  We fix this by
using module API refcnt.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c      | 4 ++++
 drivers/lightnvm/pblk-init.c | 1 +
 include/linux/lightnvm.h     | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index ddae430..60e163b 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 #include <linux/sem.h>
 #include <linux/bitmap.h>
+#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/miscdevice.h>
 #include <linux/lightnvm.h>
@@ -316,6 +317,8 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	list_add_tail(&t->list, &dev->targets);
 	mutex_unlock(&dev->mlock);
 
+	__module_get(tt->owner);
+
 	return 0;
 err_sysfs:
 	if (tt->exit)
@@ -351,6 +354,7 @@ static void __nvm_remove_target(struct nvm_target *t)
 
 	nvm_remove_tgt_dev(t->dev, 1);
 	put_disk(tdisk);
+	module_put(t->type->owner);
 
 	list_del(&t->list);
 	kfree(t);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 1b0f612..6df65d1 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1044,6 +1044,7 @@ static struct nvm_tgt_type tt_pblk = {
 
 	.sysfs_init	= pblk_sysfs_init,
 	.sysfs_exit	= pblk_sysfs_exit,
+	.owner		= THIS_MODULE,
 };
 
 static int __init pblk_module_init(void)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 7dfa56e..7b80ac9 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -460,6 +460,7 @@ struct nvm_tgt_type {
 
 	/* For internal use */
 	struct list_head list;
+	struct module *owner;
 };
 
 extern struct nvm_tgt_type *nvm_find_target_type(const char *, int);
-- 
2.9.3

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:44241 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932110AbdIHMfa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Sep 2017 08:35:30 -0400
Date: Fri, 8 Sep 2017 15:35:28 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH] lightnvm: prevent target type module removal when in use
Message-ID: <20170908123527.GA48728@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If target type module e.g. pblk here is unloaded (rmmod) while module
is in use (after creating target) system crashes.  We fix this by
using module API refcnt.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/core.c      | 4 ++++
 drivers/lightnvm/pblk-init.c | 1 +
 include/linux/lightnvm.h     | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index bbea2c8..c39f87d 100644
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
index 5fe926b..77d6120 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1059,6 +1059,7 @@ static struct nvm_tgt_type tt_pblk = {
 
 	.sysfs_init	= pblk_sysfs_init,
 	.sysfs_exit	= pblk_sysfs_exit,
+	.owner		= THIS_MODULE,
 };
 
 static int __init pblk_module_init(void)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 81b71c6d..78a22e0 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -461,6 +461,7 @@ struct nvm_tgt_type {
 
 	/* For internal use */
 	struct list_head list;
+	struct module *owner;
 };
 
 extern struct nvm_tgt_type *nvm_find_target_type(const char *, int);
-- 
2.7.4

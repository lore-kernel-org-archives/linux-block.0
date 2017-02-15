Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46734 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbdBOAjT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2017 19:39:19 -0500
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: David.Laight@ACULAB.COM, arnd@arndb.de, axboe@fb.com,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH V6 2/3] Move stack parameters for sed_ioctl to prevent oversized stack with CONFIG_KASAN
Date: Tue, 14 Feb 2017 17:29:36 -0700
Message-Id: <1487118577-1719-2-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1487118577-1719-1-git-send-email-scott.bauer@intel.com>
References: <1487118577-1719-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When CONFIG_KASAN is enabled, compilation fails:

block/sed-opal.c: In function 'sed_ioctl':
block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Moved all the ioctl structures off the stack and dynamically allocate
using _IOC_SIZE()

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 block/sed-opal.c         | 133 ++++++++++++++++-------------------------------
 drivers/nvme/host/core.c |   3 +-
 include/linux/sed-opal.h |   4 +-
 3 files changed, 50 insertions(+), 90 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index bf1406e..e95b8a5 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2344,9 +2344,10 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 }
 EXPORT_SYMBOL(opal_unlock_from_suspend);
 
-int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
+int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 {
-	void __user *arg = (void __user *)ptr;
+	void *p;
+	int ret = -ENOTTY;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -2355,94 +2356,52 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
 		return -ENOTSUPP;
 	}
 
-	switch (cmd) {
-	case IOC_OPAL_SAVE: {
-		struct opal_lock_unlock lk_unlk;
-
-		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
-			return -EFAULT;
-		return opal_save(dev, &lk_unlk);
-	}
-	case IOC_OPAL_LOCK_UNLOCK: {
-		struct opal_lock_unlock lk_unlk;
-
-		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
-			return -EFAULT;
-		return opal_lock_unlock(dev, &lk_unlk);
-	}
-	case IOC_OPAL_TAKE_OWNERSHIP: {
-		struct opal_key opal_key;
-
-		if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
-			return -EFAULT;
-		return opal_take_ownership(dev, &opal_key);
-	}
-	case IOC_OPAL_ACTIVATE_LSP: {
-		struct opal_lr_act opal_lr_act;
-
-		if (copy_from_user(&opal_lr_act, arg, sizeof(opal_lr_act)))
-			return -EFAULT;
-		return opal_activate_lsp(dev, &opal_lr_act);
-	}
-	case IOC_OPAL_SET_PW: {
-		struct opal_new_pw opal_pw;
-
-		if (copy_from_user(&opal_pw, arg, sizeof(opal_pw)))
-			return -EFAULT;
-		return opal_set_new_pw(dev, &opal_pw);
-	}
-	case IOC_OPAL_ACTIVATE_USR: {
-		struct opal_session_info session;
-
-		if (copy_from_user(&session, arg, sizeof(session)))
-			return -EFAULT;
-		return opal_activate_user(dev, &session);
-	}
-	case IOC_OPAL_REVERT_TPR: {
-		struct opal_key opal_key;
-
-		if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
-			return -EFAULT;
-		return opal_reverttper(dev, &opal_key);
-	}
-	case IOC_OPAL_LR_SETUP: {
-		struct opal_user_lr_setup lrs;
+	p = memdup_user(arg,  _IOC_SIZE(cmd));
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
-		if (copy_from_user(&lrs, arg, sizeof(lrs)))
-			return -EFAULT;
-		return opal_setup_locking_range(dev, &lrs);
-	}
-	case IOC_OPAL_ADD_USR_TO_LR: {
-		struct opal_lock_unlock lk_unlk;
-
-		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
-			return -EFAULT;
-		return opal_add_user_to_lr(dev, &lk_unlk);
-	}
-	case IOC_OPAL_ENABLE_DISABLE_MBR: {
-		struct opal_mbr_data mbr;
-
-		if (copy_from_user(&mbr, arg, sizeof(mbr)))
-			return -EFAULT;
-		return opal_enable_disable_shadow_mbr(dev, &mbr);
-	}
-	case IOC_OPAL_ERASE_LR: {
-		struct opal_session_info session;
-
-		if (copy_from_user(&session, arg, sizeof(session)))
-			return -EFAULT;
-		return opal_erase_locking_range(dev, &session);
-	}
-	case IOC_OPAL_SECURE_ERASE_LR: {
-		struct opal_session_info session;
-
-		if (copy_from_user(&session, arg, sizeof(session)))
-			return -EFAULT;
-		return opal_secure_erase_locking_range(dev, &session);
-	}
+	switch (cmd) {
+	case IOC_OPAL_SAVE:
+		ret = opal_save(dev, p);
+		break;
+	case IOC_OPAL_LOCK_UNLOCK:
+		ret = opal_lock_unlock(dev, p);
+		break;
+	case IOC_OPAL_TAKE_OWNERSHIP:
+		ret = opal_take_ownership(dev, p);
+		break;
+	case IOC_OPAL_ACTIVATE_LSP:
+		ret = opal_activate_lsp(dev, p);
+		break;
+	case IOC_OPAL_SET_PW:
+		ret = opal_set_new_pw(dev, p);
+		break;
+	case IOC_OPAL_ACTIVATE_USR:
+		ret = opal_activate_user(dev, p);
+		break;
+	case IOC_OPAL_REVERT_TPR:
+		ret = opal_reverttper(dev, p);
+		break;
+	case IOC_OPAL_LR_SETUP:
+		ret = opal_setup_locking_range(dev, p);
+		break;
+	case IOC_OPAL_ADD_USR_TO_LR:
+		ret = opal_add_user_to_lr(dev, p);
+		break;
+	case IOC_OPAL_ENABLE_DISABLE_MBR:
+		ret = opal_enable_disable_shadow_mbr(dev, p);
+		break;
+	case IOC_OPAL_ERASE_LR:
+		ret = opal_erase_locking_range(dev, p);
+		break;
+	case IOC_OPAL_SECURE_ERASE_LR:
+		ret = opal_secure_erase_locking_range(dev, p);
+		break;
 	default:
 		pr_warn("No such Opal Ioctl %u\n", cmd);
 	}
-	return -ENOTTY;
+
+	kfree(p);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sed_ioctl);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d9f4903..04c48e7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -811,7 +811,8 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 			return nvme_nvm_ioctl(ns, cmd, arg);
 #endif
 		if (is_sed_ioctl(cmd))
-			return sed_ioctl(&ns->ctrl->opal_dev, cmd, arg);
+			return sed_ioctl(&ns->ctrl->opal_dev, cmd,
+					 (void __user *) arg);
 		return -ENOTTY;
 	}
 }
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index af1a85e..205d520 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -132,7 +132,7 @@ struct opal_dev {
 #ifdef CONFIG_BLK_SED_OPAL
 bool opal_unlock_from_suspend(struct opal_dev *dev);
 void init_opal_dev(struct opal_dev *opal_dev, sec_send_recv *send_recv);
-int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr);
+int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *ioctl_ptr);
 
 static inline bool is_sed_ioctl(unsigned int cmd)
 {
@@ -160,7 +160,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 }
 
 static inline int sed_ioctl(struct opal_dev *dev, unsigned int cmd,
-			    unsigned long ptr)
+			    void __user *ioctl_ptr)
 {
 	return 0;
 }
-- 
2.7.4

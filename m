Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 2/2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
Date: Thu,  9 Feb 2017 10:20:01 -0700
Message-Id: <1486660801-5105-3-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, arnd@arndb.de, hch@infradead.org,
 linux-kernel@vger.kernel.org, axboe@fb.com, David.Laight@ACULAB.COM,
 linux-block@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>,
 jonathan.derrick@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

When CONFIG_KASAN is enabled, compilation fails:

block/sed-opal.c: In function 'sed_ioctl':
block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Moved all the ioctl structures off the stack and dynamically activate
using _IOC_SIZE()

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 block/sed-opal.c | 134 +++++++++++++++++++++----------------------------------
 1 file changed, 50 insertions(+), 84 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index bf1406e..4985d95 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2346,7 +2346,10 @@ EXPORT_SYMBOL(opal_unlock_from_suspend);
 
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
 {
+	void *ioctl_ptr;
+	int ret = -ENOTTY;
 	void __user *arg = (void __user *)ptr;
+	unsigned int cmd_size = _IOC_SIZE(cmd);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -2355,94 +2358,57 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
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
-
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
+	ioctl_ptr = kzalloc(cmd_size, GFP_KERNEL);
+	if (!ioctl_ptr)
+		return -ENOMEM;
+	if (copy_from_user(ioctl_ptr, arg, cmd_size)) {
+		ret = -EFAULT;
+		goto out;
 	}
-	case IOC_OPAL_SECURE_ERASE_LR: {
-		struct opal_session_info session;
 
-		if (copy_from_user(&session, arg, sizeof(session)))
-			return -EFAULT;
-		return opal_secure_erase_locking_range(dev, &session);
-	}
+	switch (cmd) {
+	case IOC_OPAL_SAVE:
+		ret = opal_save(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_LOCK_UNLOCK:
+		ret = opal_lock_unlock(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_TAKE_OWNERSHIP:
+		ret = opal_take_ownership(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_ACTIVATE_LSP:
+		ret = opal_activate_lsp(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_SET_PW:
+		ret = opal_set_new_pw(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_ACTIVATE_USR:
+		ret = opal_activate_user(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_REVERT_TPR:
+		ret = opal_reverttper(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_LR_SETUP:
+		ret = opal_setup_locking_range(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_ADD_USR_TO_LR:
+		ret = opal_add_user_to_lr(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_ENABLE_DISABLE_MBR:
+		ret = opal_enable_disable_shadow_mbr(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_ERASE_LR:
+		ret = opal_erase_locking_range(dev, ioctl_ptr);
+		break;
+	case IOC_OPAL_SECURE_ERASE_LR:
+		ret = opal_secure_erase_locking_range(dev, ioctl_ptr);
+		break;
 	default:
 		pr_warn("No such Opal Ioctl %u\n", cmd);
 	}
-	return -ENOTTY;
+
+out:
+	kfree(ioctl_ptr);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sed_ioctl);
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] Move stack parameters for sed_ioctl to prevent oversized
 stack with CONFIG_KASAN
Date: Wed,  8 Feb 2017 15:56:16 -0700
Message-Id: <1486594576-1621-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, hch@infradead.org, linux-kernel@vger.kernel.org,
 axboe@fb.com, linux-block@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>,
 jonathan.derrick@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

When CONFIG_KASAN is enabled, compilation fails:

block/sed-opal.c: In function 'sed_ioctl':
block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Moved all the ioctl structures off the stack to a static
union to prevent oversized stack frame size.

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 block/sed-opal.c | 187 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 102 insertions(+), 85 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index bf1406e..b88867d 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2344,8 +2344,21 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 }
 EXPORT_SYMBOL(opal_unlock_from_suspend);
 
+static union {
+	struct opal_lock_unlock lk_unlk;
+	struct opal_key opal_key;
+	struct opal_lr_act opal_lr_act;
+	struct opal_new_pw opal_pw;
+	struct opal_session_info session;
+	struct opal_user_lr_setup lrs;
+	struct opal_mbr_data mbr;
+} u;
+
+DEFINE_MUTEX(ioctl_lock);
+
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
 {
+	int ret = -ENOTTY;
 	void __user *arg = (void __user *)ptr;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -2355,94 +2368,98 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
 		return -ENOTSUPP;
 	}
 
+	mutex_lock(&ioctl_lock);
 	switch (cmd) {
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
-	}
-	case IOC_OPAL_SECURE_ERASE_LR: {
-		struct opal_session_info session;
-
-		if (copy_from_user(&session, arg, sizeof(session)))
-			return -EFAULT;
-		return opal_secure_erase_locking_range(dev, &session);
-	}
+	case IOC_OPAL_SAVE:
+		if (copy_from_user(&u.lk_unlk, arg, sizeof(u.lk_unlk))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_save(dev, &u.lk_unlk);
+		break;
+	case IOC_OPAL_LOCK_UNLOCK:
+		if (copy_from_user(&u.lk_unlk, arg, sizeof(u.lk_unlk))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_lock_unlock(dev, &u.lk_unlk);
+		break;
+	case IOC_OPAL_TAKE_OWNERSHIP:
+		if (copy_from_user(&u.opal_key, arg, sizeof(u.opal_key))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_take_ownership(dev, &u.opal_key);
+		break;
+	case IOC_OPAL_ACTIVATE_LSP:
+		if (copy_from_user(&u.opal_lr_act, arg, sizeof(u.opal_lr_act))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_activate_lsp(dev, &u.opal_lr_act);
+		break;
+	case IOC_OPAL_SET_PW:
+		if (copy_from_user(&u.opal_pw, arg, sizeof(u.opal_pw))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_set_new_pw(dev, &u.opal_pw);
+		break;
+	case IOC_OPAL_ACTIVATE_USR:
+		if (copy_from_user(&u.session, arg, sizeof(u.session))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_activate_user(dev, &u.session);
+		break;
+	case IOC_OPAL_REVERT_TPR:
+		if (copy_from_user(&u.opal_key, arg, sizeof(u.opal_key))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_reverttper(dev, &u.opal_key);
+		break;
+	case IOC_OPAL_LR_SETUP:
+		if (copy_from_user(&u.lrs, arg, sizeof(u.lrs))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_setup_locking_range(dev, &u.lrs);
+		break;
+	case IOC_OPAL_ADD_USR_TO_LR:
+		if (copy_from_user(&u.lk_unlk, arg, sizeof(u.lk_unlk))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_add_user_to_lr(dev, &u.lk_unlk);
+		break;
+	case IOC_OPAL_ENABLE_DISABLE_MBR:
+		if (copy_from_user(&u.mbr, arg, sizeof(u.mbr))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_enable_disable_shadow_mbr(dev, &u.mbr);
+		break;
+	case IOC_OPAL_ERASE_LR:
+		if (copy_from_user(&u.session, arg, sizeof(u.session))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_erase_locking_range(dev, &u.session);
+		break;
+	case IOC_OPAL_SECURE_ERASE_LR:
+		if (copy_from_user(&u.session, arg, sizeof(u.session))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = opal_secure_erase_locking_range(dev, &u.session);
+		break;
 	default:
 		pr_warn("No such Opal Ioctl %u\n", cmd);
 	}
-	return -ENOTTY;
+
+		out:
+	mutex_unlock(&ioctl_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sed_ioctl);
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

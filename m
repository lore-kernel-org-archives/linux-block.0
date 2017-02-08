Return-Path: <scott.bauer@intel.com>
Date: Wed, 8 Feb 2017 14:58:28 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
	Rafael Antognolli <rafael.antognolli@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCH] block: sed-opal: reduce stack size of ioctl handler
Message-ID: <20170208215827.GA9733@sbauer-Z170X-UD5>
References: <20170208211546.2789607-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170208211546.2789607-1-arnd@arndb.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 08, 2017 at 10:15:28PM +0100, Arnd Bergmann wrote:
> When CONFIG_KASAN is in use, the sed_ioctl function uses unusually large stack,
> as each possible ioctl argument gets its own stack area plus redzone:
> 
> block/sed-opal.c: In function 'sed_ioctl':
> block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> 
> Moving the copy_from_user() calls into the individual functions has little
> effect on readablility, but significantly reduces the stack size, with the
> largest individual function (opal_enable_disable_shadow_mbr) now at
> reasonable 456 bytes.
> 
> Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Hi Arnd,

Thank you for the report. We want to keep the function calls agnostic to userland.
In the future we will have in-kernel callers and I don't want to have to do any
get_fs(KERNEL_DS) wizardry.

Instead I think we can use a union to lessen the stack burden. I tested this patch just now
with config_ksasan and was able to build.


>From dfa6a2c842a6e45cab198c9058e753835a81521e Mon Sep 17 00:00:00 2001
From: Scott Bauer <scott.bauer@intel.com>
Date: Wed, 8 Feb 2017 14:49:32 -0700
Subject: [PATCH] Unionize stack parameters for sed_ioctl to prevent oversized
 stack

block/sed-opal.c: In function 'sed_ioctl':
block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Moved all the ioctl structures into a union to prevent oversized stack frame size.

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 block/sed-opal.c | 118 ++++++++++++++++++++++---------------------------------
 1 file changed, 46 insertions(+), 72 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index bf1406e..f509168 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2347,6 +2347,15 @@ EXPORT_SYMBOL(opal_unlock_from_suspend);
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
 {
 	void __user *arg = (void __user *)ptr;
+	union {
+		struct opal_lock_unlock lk_unlk;
+		struct opal_key opal_key;
+		struct opal_lr_act opal_lr_act;
+		struct opal_new_pw opal_pw;
+		struct opal_session_info session;
+		struct opal_user_lr_setup lrs;
+		struct opal_mbr_data mbr;
+	}u;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -2355,91 +2364,56 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
 		return -ENOTSUPP;
 	}
 
+	memset(&u, 0, sizeof(u));
 	switch (cmd) {
-	case IOC_OPAL_SAVE: {
-		struct opal_lock_unlock lk_unlk;
-
-		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+	case IOC_OPAL_SAVE:
+		if (copy_from_user(&u.lk_unlk, arg, sizeof(u.lk_unlk)))
 			return -EFAULT;
-		return opal_save(dev, &lk_unlk);
-	}
-	case IOC_OPAL_LOCK_UNLOCK: {
-		struct opal_lock_unlock lk_unlk;
-
-		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+		return opal_save(dev, &u.lk_unlk);
+	case IOC_OPAL_LOCK_UNLOCK:
+		if (copy_from_user(&u.lk_unlk, arg, sizeof(u.lk_unlk)))
 			return -EFAULT;
-		return opal_lock_unlock(dev, &lk_unlk);
-	}
-	case IOC_OPAL_TAKE_OWNERSHIP: {
-		struct opal_key opal_key;
-
-		if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
+		return opal_lock_unlock(dev, &u.lk_unlk);
+	case IOC_OPAL_TAKE_OWNERSHIP:
+		if (copy_from_user(&u.opal_key, arg, sizeof(u.opal_key)))
 			return -EFAULT;
-		return opal_take_ownership(dev, &opal_key);
-	}
-	case IOC_OPAL_ACTIVATE_LSP: {
-		struct opal_lr_act opal_lr_act;
-
-		if (copy_from_user(&opal_lr_act, arg, sizeof(opal_lr_act)))
+		return opal_take_ownership(dev, &u.opal_key);
+	case IOC_OPAL_ACTIVATE_LSP:
+		if (copy_from_user(&u.opal_lr_act, arg, sizeof(u.opal_lr_act)))
 			return -EFAULT;
-		return opal_activate_lsp(dev, &opal_lr_act);
-	}
-	case IOC_OPAL_SET_PW: {
-		struct opal_new_pw opal_pw;
-
-		if (copy_from_user(&opal_pw, arg, sizeof(opal_pw)))
+		return opal_activate_lsp(dev, &u.opal_lr_act);
+	case IOC_OPAL_SET_PW:
+		if (copy_from_user(&u.opal_pw, arg, sizeof(u.opal_pw)))
 			return -EFAULT;
-		return opal_set_new_pw(dev, &opal_pw);
-	}
-	case IOC_OPAL_ACTIVATE_USR: {
-		struct opal_session_info session;
-
-		if (copy_from_user(&session, arg, sizeof(session)))
+		return opal_set_new_pw(dev, &u.opal_pw);
+	case IOC_OPAL_ACTIVATE_USR:
+		if (copy_from_user(&u.session, arg, sizeof(u.session)))
 			return -EFAULT;
-		return opal_activate_user(dev, &session);
-	}
-	case IOC_OPAL_REVERT_TPR: {
-		struct opal_key opal_key;
-
-		if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
+		return opal_activate_user(dev, &u.session);
+	case IOC_OPAL_REVERT_TPR:
+		if (copy_from_user(&u.opal_key, arg, sizeof(u.opal_key)))
 			return -EFAULT;
-		return opal_reverttper(dev, &opal_key);
-	}
-	case IOC_OPAL_LR_SETUP: {
-		struct opal_user_lr_setup lrs;
-
-		if (copy_from_user(&lrs, arg, sizeof(lrs)))
+		return opal_reverttper(dev, &u.opal_key);
+	case IOC_OPAL_LR_SETUP:
+		if (copy_from_user(&u.lrs, arg, sizeof(u.lrs)))
 			return -EFAULT;
-		return opal_setup_locking_range(dev, &lrs);
-	}
-	case IOC_OPAL_ADD_USR_TO_LR: {
-		struct opal_lock_unlock lk_unlk;
-
-		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+		return opal_setup_locking_range(dev, &u.lrs);
+	case IOC_OPAL_ADD_USR_TO_LR:
+		if (copy_from_user(&u.lk_unlk, arg, sizeof(u.lk_unlk)))
 			return -EFAULT;
-		return opal_add_user_to_lr(dev, &lk_unlk);
-	}
-	case IOC_OPAL_ENABLE_DISABLE_MBR: {
-		struct opal_mbr_data mbr;
-
-		if (copy_from_user(&mbr, arg, sizeof(mbr)))
+		return opal_add_user_to_lr(dev, &u.lk_unlk);
+	case IOC_OPAL_ENABLE_DISABLE_MBR:
+		if (copy_from_user(&u.mbr, arg, sizeof(u.mbr)))
 			return -EFAULT;
-		return opal_enable_disable_shadow_mbr(dev, &mbr);
-	}
-	case IOC_OPAL_ERASE_LR: {
-		struct opal_session_info session;
-
-		if (copy_from_user(&session, arg, sizeof(session)))
+		return opal_enable_disable_shadow_mbr(dev, &u.mbr);
+	case IOC_OPAL_ERASE_LR:
+		if (copy_from_user(&u.session, arg, sizeof(u.session)))
 			return -EFAULT;
-		return opal_erase_locking_range(dev, &session);
-	}
-	case IOC_OPAL_SECURE_ERASE_LR: {
-		struct opal_session_info session;
-
-		if (copy_from_user(&session, arg, sizeof(session)))
+		return opal_erase_locking_range(dev, &u.session);
+	case IOC_OPAL_SECURE_ERASE_LR:
+		if (copy_from_user(&u.session, arg, sizeof(u.session)))
 			return -EFAULT;
-		return opal_secure_erase_locking_range(dev, &session);
-	}
+		return opal_secure_erase_locking_range(dev, &u.session);
 	default:
 		pr_warn("No such Opal Ioctl %u\n", cmd);
 	}
-- 
2.7.4

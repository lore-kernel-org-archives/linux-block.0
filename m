Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Rafael Antognolli <rafael.antognolli@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: sed-opal: reduce stack size of ioctl handler
Date: Wed,  8 Feb 2017 22:15:28 +0100
Message-Id: <20170208211546.2789607-1-arnd@arndb.de>
List-ID: <linux-block@vger.kernel.org>

When CONFIG_KASAN is in use, the sed_ioctl function uses unusually large stack,
as each possible ioctl argument gets its own stack area plus redzone:

block/sed-opal.c: In function 'sed_ioctl':
block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Moving the copy_from_user() calls into the individual functions has little
effect on readablility, but significantly reduces the stack size, with the
largest individual function (opal_enable_disable_shadow_mbr) now at
reasonable 456 bytes.

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/sed-opal.c | 256 +++++++++++++++++++++++++++----------------------------
 1 file changed, 128 insertions(+), 128 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index bf1406e5159b..6b33d970ce5e 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1957,7 +1957,7 @@ void init_opal_dev(struct opal_dev *opal_dev, sec_send_recv *send_recv)
 EXPORT_SYMBOL(init_opal_dev);
 
 static int opal_secure_erase_locking_range(struct opal_dev *dev,
-					   struct opal_session_info *opal_session)
+					   struct opal_session_info __user *arg)
 {
 	void *data[3] = { NULL };
 	static const opal_step erase_funcs[] = {
@@ -1968,14 +1968,18 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 		end_opal_session,
 		NULL,
 	};
+	struct opal_session_info opal_session;
 	int ret;
 
+	if (copy_from_user(&opal_session, arg, sizeof(opal_session)))
+		return -EFAULT;
+
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, erase_funcs);
 
 	dev->func_data = data;
-	dev->func_data[1] = opal_session;
-	dev->func_data[2] = &opal_session->opal_key.lr;
+	dev->func_data[1] = &opal_session;
+	dev->func_data[2] = &opal_session.opal_key.lr;
 
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
@@ -1983,7 +1987,7 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 }
 
 static int opal_erase_locking_range(struct opal_dev *dev,
-				    struct opal_session_info *opal_session)
+				    struct opal_session_info __user *arg)
 {
 	void *data[3] = { NULL };
 	static const opal_step erase_funcs[] = {
@@ -1993,14 +1997,18 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 		end_opal_session,
 		NULL,
 	};
+	struct opal_session_info opal_session;
 	int ret;
 
+	if (copy_from_user(&opal_session, arg, sizeof(opal_session)))
+		return -EFAULT;
+
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, erase_funcs);
 
 	dev->func_data = data;
-	dev->func_data[1] = opal_session;
-	dev->func_data[2] = opal_session;
+	dev->func_data[1] = &opal_session;
+	dev->func_data[2] = &opal_session;
 
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
@@ -2008,7 +2016,7 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 }
 
 static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
-					  struct opal_mbr_data *opal_mbr)
+					  struct opal_mbr_data __user *arg)
 {
 	void *func_data[6] = { NULL };
 	static const opal_step mbr_funcs[] = {
@@ -2021,34 +2029,42 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 		end_opal_session,
 		NULL,
 	};
+	struct opal_mbr_data opal_mbr;
 	int ret;
 
-	if (opal_mbr->enable_disable != OPAL_MBR_ENABLE &&
-	    opal_mbr->enable_disable != OPAL_MBR_DISABLE)
+	if (copy_from_user(&opal_mbr, arg, sizeof(opal_mbr)))
+		return -EFAULT;
+
+	if (opal_mbr.enable_disable != OPAL_MBR_ENABLE &&
+	    opal_mbr.enable_disable != OPAL_MBR_DISABLE)
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, mbr_funcs);
 	dev->func_data = func_data;
-	dev->func_data[1] = &opal_mbr->key;
-	dev->func_data[2] = &opal_mbr->enable_disable;
-	dev->func_data[4] = &opal_mbr->key;
-	dev->func_data[5] = &opal_mbr->enable_disable;
+	dev->func_data[1] = &opal_mbr.key;
+	dev->func_data[2] = &opal_mbr.enable_disable;
+	dev->func_data[4] = &opal_mbr.key;
+	dev->func_data[5] = &opal_mbr.enable_disable;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
 
-static int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
+static int opal_save(struct opal_dev *dev, struct opal_lock_unlock __user *arg)
 {
 	struct opal_suspend_data *suspend;
+	struct opal_lock_unlock lk_unlk;
+
+	if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+		return -EFAULT;
 
 	suspend = kzalloc(sizeof(*suspend), GFP_KERNEL);
 	if (!suspend)
 		return -ENOMEM;
 
-	suspend->unlk = *lk_unlk;
-	suspend->lr = lk_unlk->session.opal_key.lr;
+	suspend->unlk = lk_unlk;
+	suspend->lr = lk_unlk.session.opal_key.lr;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, NULL);
@@ -2058,7 +2074,7 @@ static int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
 }
 
 static int opal_add_user_to_lr(struct opal_dev *dev,
-			       struct opal_lock_unlock *lk_unlk)
+			       struct opal_lock_unlock *arg)
 {
 	void *func_data[3] = { NULL };
 	static const opal_step funcs[] = {
@@ -2068,20 +2084,24 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 		end_opal_session,
 		NULL
 	};
+	struct opal_lock_unlock lk_unlk;
 	int ret;
 
-	if (lk_unlk->l_state != OPAL_RO &&
-	    lk_unlk->l_state != OPAL_RW) {
+	if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+		return -EFAULT;
+
+	if (lk_unlk.l_state != OPAL_RO &&
+	    lk_unlk.l_state != OPAL_RW) {
 		pr_err("Locking state was not RO or RW\n");
 		return -EINVAL;
 	}
-	if (lk_unlk->session.who < OPAL_USER1 &&
-	    lk_unlk->session.who > OPAL_USER9) {
+	if (lk_unlk.session.who < OPAL_USER1 &&
+	    lk_unlk.session.who > OPAL_USER9) {
 		pr_err("Authority was not within the range of users: %d\n",
-		       lk_unlk->session.who);
+		       lk_unlk.session.who);
 		return -EINVAL;
 	}
-	if (lk_unlk->session.sum) {
+	if (lk_unlk.session.sum) {
 		pr_err("%s not supported in sum. Use setup locking range\n",
 		       __func__);
 		return -EINVAL;
@@ -2090,14 +2110,14 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, funcs);
 	dev->func_data = func_data;
-	dev->func_data[1] = &lk_unlk->session.opal_key;
-	dev->func_data[2] = lk_unlk;
+	dev->func_data[1] = &lk_unlk.session.opal_key;
+	dev->func_data[2] = &lk_unlk;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
 
-static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
+static int opal_reverttper(struct opal_dev *dev, struct opal_key __user *arg)
 {
 	void *data[2] = { NULL };
 	static const opal_step revert_funcs[] = {
@@ -2106,12 +2126,16 @@ static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 		revert_tper, /* controller will terminate session */
 		NULL,
 	};
+	struct opal_key opal_key;
 	int ret;
 
+	if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
+		return -EFAULT;
+
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, revert_funcs);
 	dev->func_data = data;
-	dev->func_data[1] = opal;
+	dev->func_data[1] = &opal_key;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2145,22 +2169,26 @@ static int __opal_lock_unlock(struct opal_dev *dev)
 	return next(dev);
 }
 
-static int opal_lock_unlock(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
+static int opal_lock_unlock(struct opal_dev *dev, struct opal_lock_unlock __user *arg)
 {
+	struct opal_lock_unlock lk_unlk;
 	void *func_data[3] = { NULL };
 	int ret;
 
-	if (lk_unlk->session.who < OPAL_ADMIN1 ||
-	    lk_unlk->session.who > OPAL_USER9)
+	if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
+		return -EFAULT;
+
+	if (lk_unlk.session.who < OPAL_ADMIN1 ||
+	    lk_unlk.session.who > OPAL_USER9)
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, NULL);
 	dev->func_data = func_data;
-	dev->func_data[1] = &lk_unlk->session;
-	dev->func_data[2] = lk_unlk;
+	dev->func_data[1] = &lk_unlk.session;
+	dev->func_data[2] = &lk_unlk;
 
-	if (lk_unlk->session.sum)
+	if (lk_unlk.session.sum)
 		ret = __opal_lock_unlock_sum(dev);
 	else
 		ret = __opal_lock_unlock(dev);
@@ -2169,7 +2197,7 @@ static int opal_lock_unlock(struct opal_dev *dev, struct opal_lock_unlock *lk_un
 	return ret;
 }
 
-static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
+static int opal_take_ownership(struct opal_dev *dev, struct opal_key __user *arg)
 {
 	static const opal_step owner_funcs[] = {
 		opal_discovery0,
@@ -2182,22 +2210,26 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 		NULL
 	};
 	void *data[6] = { NULL };
+	struct opal_key opal;
 	int ret;
 
+	if (copy_from_user(&opal, arg, sizeof(opal)))
+		return -EFAULT;
+
 	if (!dev)
 		return -ENODEV;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, owner_funcs);
 	dev->func_data = data;
-	dev->func_data[4] = opal;
-	dev->func_data[5] = opal;
+	dev->func_data[4] = &opal;
+	dev->func_data[5] = &opal;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
 
-static int opal_activate_lsp(struct opal_dev *dev, struct opal_lr_act *opal_lr_act)
+static int opal_activate_lsp(struct opal_dev *dev, struct opal_lr_act __user *arg)
 {
 	void *data[4] = { NULL };
 	static const opal_step active_funcs[] = {
@@ -2208,23 +2240,27 @@ static int opal_activate_lsp(struct opal_dev *dev, struct opal_lr_act *opal_lr_a
 		end_opal_session,
 		NULL
 	};
+	struct opal_lr_act opal_lr_act;
 	int ret;
 
-	if (!opal_lr_act->num_lrs || opal_lr_act->num_lrs > OPAL_MAX_LRS)
+	if (copy_from_user(&opal_lr_act, arg, sizeof(opal_lr_act)))
+		return -EFAULT;
+
+	if (!opal_lr_act.num_lrs || opal_lr_act.num_lrs > OPAL_MAX_LRS)
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, active_funcs);
 	dev->func_data = data;
-	dev->func_data[1] = &opal_lr_act->key;
-	dev->func_data[3] = opal_lr_act;
+	dev->func_data[1] = &opal_lr_act.key;
+	dev->func_data[3] = &opal_lr_act;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
 
 static int opal_setup_locking_range(struct opal_dev *dev,
-				    struct opal_user_lr_setup *opal_lrs)
+				    struct opal_user_lr_setup __user *arg)
 {
 	void *data[3] = { NULL };
 	static const opal_step lr_funcs[] = {
@@ -2234,19 +2270,23 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 		end_opal_session,
 		NULL,
 	};
+	struct opal_user_lr_setup opal_lrs;
 	int ret;
 
+	if (copy_from_user(&opal_lrs, arg, sizeof(opal_lrs)))
+		return -EFAULT;
+
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, lr_funcs);
 	dev->func_data = data;
-	dev->func_data[1] = &opal_lrs->session;
-	dev->func_data[2] = opal_lrs;
+	dev->func_data[1] = &opal_lrs.session;
+	dev->func_data[2] = &opal_lrs;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
 
-static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
+static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw __user *arg)
 {
 	static const opal_step pw_funcs[] = {
 		opal_discovery0,
@@ -2256,19 +2296,23 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 		NULL
 	};
 	void *data[3] = { NULL };
+	struct opal_new_pw opal_pw;
 	int ret;
 
-	if (opal_pw->session.who < OPAL_ADMIN1 ||
-	    opal_pw->session.who > OPAL_USER9  ||
-	    opal_pw->new_user_pw.who < OPAL_ADMIN1 ||
-	    opal_pw->new_user_pw.who > OPAL_USER9)
+	if (copy_from_user(&opal_pw, arg, sizeof(opal_pw)))
+		return -EFAULT;
+
+	if (opal_pw.session.who < OPAL_ADMIN1 ||
+	    opal_pw.session.who > OPAL_USER9  ||
+	    opal_pw.new_user_pw.who < OPAL_ADMIN1 ||
+	    opal_pw.new_user_pw.who > OPAL_USER9)
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, pw_funcs);
 	dev->func_data = data;
-	dev->func_data[1] = (void *) &opal_pw->session;
-	dev->func_data[2] = (void *) &opal_pw->new_user_pw;
+	dev->func_data[1] = (void *) &opal_pw.session;
+	dev->func_data[2] = (void *) &opal_pw.new_user_pw;
 
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
@@ -2276,7 +2320,7 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 }
 
 static int opal_activate_user(struct opal_dev *dev,
-			      struct opal_session_info *opal_session)
+			      struct opal_session_info __user *arg)
 {
 	static const opal_step act_funcs[] = {
 		opal_discovery0,
@@ -2286,20 +2330,24 @@ static int opal_activate_user(struct opal_dev *dev,
 		NULL
 	};
 	void *data[3] = { NULL };
+	struct opal_session_info opal_session;
 	int ret;
 
+	if (copy_from_user(&opal_session, arg, sizeof(opal_session)))
+		return -EFAULT;
+
 	/* We can't activate Admin1 it's active as manufactured */
-	if (opal_session->who < OPAL_USER1 &&
-	    opal_session->who > OPAL_USER9) {
-		pr_err("Who was not a valid user: %d\n", opal_session->who);
+	if (opal_session.who < OPAL_USER1 &&
+	    opal_session.who > OPAL_USER9) {
+		pr_err("Who was not a valid user: %d\n", opal_session.who);
 		return -EINVAL;
 	}
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, act_funcs);
 	dev->func_data = data;
-	dev->func_data[1] = &opal_session->opal_key;
-	dev->func_data[2] = opal_session;
+	dev->func_data[1] = &opal_session.opal_key;
+	dev->func_data[2] = &opal_session;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2356,90 +2404,42 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
 	}
 
 	switch (cmd) {
-	case IOC_OPAL_SAVE: {
-		struct opal_lock_unlock lk_unlk;
+	case IOC_OPAL_SAVE:
+		return opal_save(dev, arg);
 
-		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
-			return -EFAULT;
-		return opal_save(dev, &lk_unlk);
-	}
-	case IOC_OPAL_LOCK_UNLOCK: {
-		struct opal_lock_unlock lk_unlk;
+	case IOC_OPAL_LOCK_UNLOCK:
+		return opal_lock_unlock(dev, arg);
 
-		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
-			return -EFAULT;
-		return opal_lock_unlock(dev, &lk_unlk);
-	}
-	case IOC_OPAL_TAKE_OWNERSHIP: {
-		struct opal_key opal_key;
+	case IOC_OPAL_TAKE_OWNERSHIP: 
+		return opal_take_ownership(dev, arg);
 
-		if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
-			return -EFAULT;
-		return opal_take_ownership(dev, &opal_key);
-	}
-	case IOC_OPAL_ACTIVATE_LSP: {
-		struct opal_lr_act opal_lr_act;
+	case IOC_OPAL_ACTIVATE_LSP:
+		return opal_activate_lsp(dev, arg);
 
-		if (copy_from_user(&opal_lr_act, arg, sizeof(opal_lr_act)))
-			return -EFAULT;
-		return opal_activate_lsp(dev, &opal_lr_act);
-	}
-	case IOC_OPAL_SET_PW: {
-		struct opal_new_pw opal_pw;
+	case IOC_OPAL_SET_PW:
+		return opal_set_new_pw(dev, arg);
 
-		if (copy_from_user(&opal_pw, arg, sizeof(opal_pw)))
-			return -EFAULT;
-		return opal_set_new_pw(dev, &opal_pw);
-	}
-	case IOC_OPAL_ACTIVATE_USR: {
-		struct opal_session_info session;
+	case IOC_OPAL_ACTIVATE_USR:
+		return opal_activate_user(dev, arg);
 
-		if (copy_from_user(&session, arg, sizeof(session)))
-			return -EFAULT;
-		return opal_activate_user(dev, &session);
-	}
-	case IOC_OPAL_REVERT_TPR: {
-		struct opal_key opal_key;
+	case IOC_OPAL_REVERT_TPR:
+		return opal_reverttper(dev, arg);
 
-		if (copy_from_user(&opal_key, arg, sizeof(opal_key)))
-			return -EFAULT;
-		return opal_reverttper(dev, &opal_key);
-	}
-	case IOC_OPAL_LR_SETUP: {
-		struct opal_user_lr_setup lrs;
+	case IOC_OPAL_LR_SETUP:
+		return opal_setup_locking_range(dev, arg);
 
-		if (copy_from_user(&lrs, arg, sizeof(lrs)))
-			return -EFAULT;
-		return opal_setup_locking_range(dev, &lrs);
-	}
-	case IOC_OPAL_ADD_USR_TO_LR: {
-		struct opal_lock_unlock lk_unlk;
+	case IOC_OPAL_ADD_USR_TO_LR:
+		return opal_add_user_to_lr(dev, arg);
 
-		if (copy_from_user(&lk_unlk, arg, sizeof(lk_unlk)))
-			return -EFAULT;
-		return opal_add_user_to_lr(dev, &lk_unlk);
-	}
-	case IOC_OPAL_ENABLE_DISABLE_MBR: {
-		struct opal_mbr_data mbr;
+	case IOC_OPAL_ENABLE_DISABLE_MBR:
+		return opal_enable_disable_shadow_mbr(dev, arg);
 
-		if (copy_from_user(&mbr, arg, sizeof(mbr)))
-			return -EFAULT;
-		return opal_enable_disable_shadow_mbr(dev, &mbr);
-	}
-	case IOC_OPAL_ERASE_LR: {
-		struct opal_session_info session;
+	case IOC_OPAL_ERASE_LR:
+		return opal_erase_locking_range(dev, arg);
 
-		if (copy_from_user(&session, arg, sizeof(session)))
-			return -EFAULT;
-		return opal_erase_locking_range(dev, &session);
-	}
-	case IOC_OPAL_SECURE_ERASE_LR: {
-		struct opal_session_info session;
+	case IOC_OPAL_SECURE_ERASE_LR:
+		return opal_secure_erase_locking_range(dev, arg);
 
-		if (copy_from_user(&session, arg, sizeof(session)))
-			return -EFAULT;
-		return opal_secure_erase_locking_range(dev, &session);
-	}
 	default:
 		pr_warn("No such Opal Ioctl %u\n", cmd);
 	}
-- 
2.9.0

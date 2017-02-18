Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:7552 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbdBRAAi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 19:00:38 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 4/5] block/sed: Embed function data into the function sequence
Date: Fri, 17 Feb 2017 17:00:28 -0700
Message-Id: <1487376029-22662-5-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
References: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

By embedding the function data with the function sequence, this
eliminates a lot of the code that needs to set it in other places.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 358 +++++++++++++++++++++----------------------------------
 1 file changed, 138 insertions(+), 220 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 4fc4d7b..e2e3228 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -34,7 +34,11 @@
 #define IO_BUFFER_LENGTH 2048
 #define MAX_TOKS 64
 
-typedef int (*opal_step)(struct opal_dev *dev);
+typedef struct opal_step {
+	int (*fn)(struct opal_dev *dev, void *data);
+	void *data;
+} opal_step;
+typedef int (cont_fn)(struct opal_dev *dev);
 
 enum opal_atom_width {
 	OPAL_WIDTH_TINY,
@@ -80,8 +84,7 @@ struct opal_dev {
 	void *data;
 	sec_send_recv *send_recv;
 
-	const opal_step *funcs;
-	void **func_data;
+	opal_step *funcs;
 	int state;
 	struct mutex dev_lock;
 	u16 comid;
@@ -213,8 +216,6 @@ struct opal_dev {
 		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x08, 0x03 },
 };
 
-typedef int (cont_fn)(struct opal_dev *dev);
-
 static int end_opal_session_error(struct opal_dev *dev);
 
 struct opal_suspend_data {
@@ -375,15 +376,15 @@ static void check_geometry(struct opal_dev *dev, const void *data)
 
 static int next(struct opal_dev *dev)
 {
-	opal_step func;
+	opal_step *func;
 	int error = 0;
 
 	do {
-		func = dev->funcs[dev->state];
-		if (!func)
+		func = &dev->funcs[dev->state];
+		if (!func->fn)
 			break;
 
-		error = func(dev);
+		error = func->fn(dev, func->data);
 		if (error) {
 			pr_err("Error on step function: %d with error %d: %s\n",
 			       dev->state, error,
@@ -483,7 +484,7 @@ static int opal_discovery0_end(struct opal_dev *dev)
 	return 0;
 }
 
-static int opal_discovery0(struct opal_dev *dev)
+static int opal_discovery0(struct opal_dev *dev, void *data)
 {
 	int ret;
 
@@ -1018,7 +1019,7 @@ static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
 	return opal_send_recv(dev, cont);
 }
 
-static int gen_key(struct opal_dev *dev)
+static int gen_key(struct opal_dev *dev, void *data)
 {
 	const u8 *method;
 	u8 uid[OPAL_UID_LENGTH];
@@ -1072,15 +1073,14 @@ static int get_active_key_cont(struct opal_dev *dev)
 	return 0;
 }
 
-static int get_active_key(struct opal_dev *dev)
+static int get_active_key(struct opal_dev *dev, void *data)
 {
 	u8 uid[OPAL_UID_LENGTH];
 	int err = 0;
-	u8 *lr;
+	u8 *lr = data;
 
 	clear_opal_cmd(dev);
 	set_comid(dev, dev->comid);
-	lr = dev->func_data[dev->state];
 
 	err = build_locking_range(uid, sizeof(uid), *lr);
 	if (err)
@@ -1163,17 +1163,16 @@ static inline int enable_global_lr(struct opal_dev *dev, u8 *uid,
 	return err;
 }
 
-static int setup_locking_range(struct opal_dev *dev)
+static int setup_locking_range(struct opal_dev *dev, void *data)
 {
 	u8 uid[OPAL_UID_LENGTH];
-	struct opal_user_lr_setup *setup;
+	struct opal_user_lr_setup *setup = data;
 	u8 lr;
 	int err = 0;
 
 	clear_opal_cmd(dev);
 	set_comid(dev, dev->comid);
 
-	setup = dev->func_data[dev->state];
 	lr = setup->session.opal_key.lr;
 	err = build_locking_range(uid, sizeof(uid), lr);
 	if (err)
@@ -1286,20 +1285,19 @@ static int start_generic_opal_session(struct opal_dev *dev,
 	return finalize_and_send(dev, start_opal_session_cont);
 }
 
-static int start_anybodyASP_opal_session(struct opal_dev *dev)
+static int start_anybodyASP_opal_session(struct opal_dev *dev, void *data)
 {
 	return start_generic_opal_session(dev, OPAL_ANYBODY_UID,
 					  OPAL_ADMINSP_UID, NULL, 0);
 }
 
-static int start_SIDASP_opal_session(struct opal_dev *dev)
+static int start_SIDASP_opal_session(struct opal_dev *dev, void *data)
 {
 	int ret;
 	const u8 *key = dev->prev_data;
-	struct opal_key *okey;
 
 	if (!key) {
-		okey = dev->func_data[dev->state];
+		const struct opal_key *okey = data;
 		ret = start_generic_opal_session(dev, OPAL_SID_UID,
 						 OPAL_ADMINSP_UID,
 						 okey->key,
@@ -1314,22 +1312,21 @@ static int start_SIDASP_opal_session(struct opal_dev *dev)
 	return ret;
 }
 
-static inline int start_admin1LSP_opal_session(struct opal_dev *dev)
+static inline int start_admin1LSP_opal_session(struct opal_dev *dev, void *data)
 {
-	struct opal_key *key = dev->func_data[dev->state];
-
+	struct opal_key *key = data;
 	return start_generic_opal_session(dev, OPAL_ADMIN1_UID,
 					  OPAL_LOCKINGSP_UID,
 					  key->key, key->key_len);
 }
 
-static int start_auth_opal_session(struct opal_dev *dev)
+static int start_auth_opal_session(struct opal_dev *dev, void *data)
 {
+	struct opal_session_info *session = data;
 	u8 lk_ul_user[OPAL_UID_LENGTH];
+	size_t keylen = session->opal_key.key_len;
 	int err = 0;
 
-	struct opal_session_info *session = dev->func_data[dev->state];
-	size_t keylen = session->opal_key.key_len;
 	u8 *key = session->opal_key.key;
 	u32 hsn = GENERIC_HOST_SESSION_NUM;
 
@@ -1379,7 +1376,7 @@ static int start_auth_opal_session(struct opal_dev *dev)
 	return finalize_and_send(dev, start_opal_session_cont);
 }
 
-static int revert_tper(struct opal_dev *dev)
+static int revert_tper(struct opal_dev *dev, void *data)
 {
 	int err = 0;
 
@@ -1401,9 +1398,9 @@ static int revert_tper(struct opal_dev *dev)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int internal_activate_user(struct opal_dev *dev)
+static int internal_activate_user(struct opal_dev *dev, void *data)
 {
-	struct opal_session_info *session = dev->func_data[dev->state];
+	struct opal_session_info *session = data;
 	u8 uid[OPAL_UID_LENGTH];
 	int err = 0;
 
@@ -1436,15 +1433,14 @@ static int internal_activate_user(struct opal_dev *dev)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int erase_locking_range(struct opal_dev *dev)
+static int erase_locking_range(struct opal_dev *dev, void *data)
 {
-	struct opal_session_info *session;
+	struct opal_session_info *session = data;
 	u8 uid[OPAL_UID_LENGTH];
 	int err = 0;
 
 	clear_opal_cmd(dev);
 	set_comid(dev, dev->comid);
-	session = dev->func_data[dev->state];
 
 	if (build_locking_range(uid, sizeof(uid), session->opal_key.lr) < 0)
 		return -ERANGE;
@@ -1463,9 +1459,9 @@ static int erase_locking_range(struct opal_dev *dev)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int set_mbr_done(struct opal_dev *dev)
+static int set_mbr_done(struct opal_dev *dev, void *data)
 {
-	u8 mbr_done_tf = *(u8 *)dev->func_data[dev->state];
+	u8 mbr_done_tf = *(u8 *)data;
 	int err = 0;
 
 	clear_opal_cmd(dev);
@@ -1495,9 +1491,9 @@ static int set_mbr_done(struct opal_dev *dev)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int set_mbr_enable_disable(struct opal_dev *dev)
+static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 {
-	u8 mbr_en_dis = *(u8 *)dev->func_data[dev->state];
+	u8 mbr_en_dis = *(u8 *)data;
 	int err = 0;
 
 	clear_opal_cmd(dev);
@@ -1554,11 +1550,10 @@ static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
 	return err;
 }
 
-static int set_new_pw(struct opal_dev *dev)
+static int set_new_pw(struct opal_dev *dev, void *data)
 {
 	u8 cpin_uid[OPAL_UID_LENGTH];
-	struct opal_session_info *usr = dev->func_data[dev->state];
-
+	struct opal_session_info *usr = data;
 
 	memcpy(cpin_uid, opaluid[OPAL_C_PIN_ADMIN1], OPAL_UID_LENGTH);
 
@@ -1579,10 +1574,10 @@ static int set_new_pw(struct opal_dev *dev)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int set_sid_cpin_pin(struct opal_dev *dev)
+static int set_sid_cpin_pin(struct opal_dev *dev, void *data)
 {
 	u8 cpin_uid[OPAL_UID_LENGTH];
-	struct opal_key *key = dev->func_data[dev->state];
+	struct opal_key *key = data;
 
 	memcpy(cpin_uid, opaluid[OPAL_C_PIN_SID], OPAL_UID_LENGTH);
 
@@ -1593,18 +1588,16 @@ static int set_sid_cpin_pin(struct opal_dev *dev)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int add_user_to_lr(struct opal_dev *dev)
+static int add_user_to_lr(struct opal_dev *dev, void *data)
 {
 	u8 lr_buffer[OPAL_UID_LENGTH];
 	u8 user_uid[OPAL_UID_LENGTH];
-	struct opal_lock_unlock *lkul;
+	struct opal_lock_unlock *lkul = data;
 	int err = 0;
 
 	clear_opal_cmd(dev);
 	set_comid(dev, dev->comid);
 
-	lkul = dev->func_data[dev->state];
-
 	memcpy(lr_buffer, opaluid[OPAL_LOCKINGRANGE_ACE_RDLOCKED],
 	       OPAL_UID_LENGTH);
 
@@ -1671,11 +1664,11 @@ static int add_user_to_lr(struct opal_dev *dev)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int lock_unlock_locking_range(struct opal_dev *dev)
+static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 {
 	u8 lr_buffer[OPAL_UID_LENGTH];
 	const u8 *method;
-	struct opal_lock_unlock *lkul;
+	struct opal_lock_unlock *lkul = data;
 	u8 read_locked = 1, write_locked = 1;
 	int err = 0;
 
@@ -1683,7 +1676,6 @@ static int lock_unlock_locking_range(struct opal_dev *dev)
 	set_comid(dev, dev->comid);
 
 	method = opalmethod[OPAL_SET];
-	lkul = dev->func_data[dev->state];
 	if (build_locking_range(lr_buffer, sizeof(lr_buffer),
 				lkul->session.opal_key.lr) < 0)
 		return -ERANGE;
@@ -1735,19 +1727,18 @@ static int lock_unlock_locking_range(struct opal_dev *dev)
 }
 
 
-static int lock_unlock_locking_range_sum(struct opal_dev *dev)
+static int lock_unlock_locking_range_sum(struct opal_dev *dev, void *data)
 {
 	u8 lr_buffer[OPAL_UID_LENGTH];
 	u8 read_locked = 1, write_locked = 1;
 	const u8 *method;
-	struct opal_lock_unlock *lkul;
+	struct opal_lock_unlock *lkul = data;
 	int ret;
 
 	clear_opal_cmd(dev);
 	set_comid(dev, dev->comid);
 
 	method = opalmethod[OPAL_SET];
-	lkul = dev->func_data[dev->state];
 	if (build_locking_range(lr_buffer, sizeof(lr_buffer),
 				lkul->session.opal_key.lr) < 0)
 		return -ERANGE;
@@ -1778,9 +1769,9 @@ static int lock_unlock_locking_range_sum(struct opal_dev *dev)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int activate_lsp(struct opal_dev *dev)
+static int activate_lsp(struct opal_dev *dev, void *data)
 {
-	struct opal_lr_act *opal_act;
+	struct opal_lr_act *opal_act = data;
 	u8 user_lr[OPAL_UID_LENGTH];
 	u8 uint_3 = 0x83;
 	int err = 0, i;
@@ -1788,8 +1779,6 @@ static int activate_lsp(struct opal_dev *dev)
 	clear_opal_cmd(dev);
 	set_comid(dev, dev->comid);
 
-	opal_act = dev->func_data[dev->state];
-
 	add_token_u8(&err, dev, OPAL_CALL);
 	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
 			     OPAL_UID_LENGTH);
@@ -1854,7 +1843,7 @@ static int get_lsp_lifecycle_cont(struct opal_dev *dev)
 }
 
 /* Determine if we're in the Manufactured Inactive or Active state */
-static int get_lsp_lifecycle(struct opal_dev *dev)
+static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
 {
 	int err = 0;
 
@@ -1915,14 +1904,13 @@ static int get_msid_cpin_pin_cont(struct opal_dev *dev)
 	return 0;
 }
 
-static int get_msid_cpin_pin(struct opal_dev *dev)
+static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
 {
 	int err = 0;
 
 	clear_opal_cmd(dev);
 	set_comid(dev, dev->comid);
 
-
 	add_token_u8(&err, dev, OPAL_CALL);
 	add_token_bytestring(&err, dev, opaluid[OPAL_C_PIN_MSID],
 			     OPAL_UID_LENGTH);
@@ -1963,7 +1951,7 @@ static int build_end_opal_session(struct opal_dev *dev)
 	return err;
 }
 
-static int end_opal_session(struct opal_dev *dev)
+static int end_opal_session(struct opal_dev *dev, void *data)
 {
 	int ret = build_end_opal_session(dev);
 
@@ -1974,9 +1962,9 @@ static int end_opal_session(struct opal_dev *dev)
 
 static int end_opal_session_error(struct opal_dev *dev)
 {
-	const opal_step error_end_session[] = {
-		end_opal_session,
-		NULL,
+	opal_step error_end_session[] = {
+		{ end_opal_session, },
+		{ NULL, }
 	};
 	dev->funcs = error_end_session;
 	dev->state = 0;
@@ -1984,21 +1972,20 @@ static int end_opal_session_error(struct opal_dev *dev)
 }
 
 static inline void setup_opal_dev(struct opal_dev *dev,
-				  const opal_step *funcs)
+				  opal_step *funcs)
 {
 	dev->state = 0;
 	dev->funcs = funcs;
 	dev->tsn = 0;
 	dev->hsn = 0;
-	dev->func_data = NULL;
 	dev->prev_data = NULL;
 }
 
 static int check_opal_support(struct opal_dev *dev)
 {
-	static const opal_step funcs[] = {
-		opal_discovery0,
-		NULL
+	opal_step funcs[] = {
+		{ opal_discovery0, },
+		{ NULL, }
 	};
 	int ret;
 
@@ -2034,24 +2021,18 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 static int opal_secure_erase_locking_range(struct opal_dev *dev,
 					   struct opal_session_info *opal_session)
 {
-	void *data[3] = { NULL };
-	static const opal_step erase_funcs[] = {
-		opal_discovery0,
-		start_auth_opal_session,
-		get_active_key,
-		gen_key,
-		end_opal_session,
-		NULL,
+	opal_step erase_funcs[] = {
+		{ opal_discovery0, },
+		{ start_auth_opal_session, opal_session },
+		{ get_active_key, &opal_session->opal_key.lr },
+		{ gen_key, },
+		{ end_opal_session, },
+		{ NULL, }
 	};
 	int ret;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, erase_funcs);
-
-	dev->func_data = data;
-	dev->func_data[1] = opal_session;
-	dev->func_data[2] = &opal_session->opal_key.lr;
-
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2060,23 +2041,17 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 static int opal_erase_locking_range(struct opal_dev *dev,
 				    struct opal_session_info *opal_session)
 {
-	void *data[3] = { NULL };
-	static const opal_step erase_funcs[] = {
-		opal_discovery0,
-		start_auth_opal_session,
-		erase_locking_range,
-		end_opal_session,
-		NULL,
+	opal_step erase_funcs[] = {
+		{ opal_discovery0, },
+		{ start_auth_opal_session, opal_session },
+		{ erase_locking_range, opal_session },
+		{ end_opal_session, },
+		{ NULL, }
 	};
 	int ret;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, erase_funcs);
-
-	dev->func_data = data;
-	dev->func_data[1] = opal_session;
-	dev->func_data[2] = opal_session;
-
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2085,16 +2060,15 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 					  struct opal_mbr_data *opal_mbr)
 {
-	void *func_data[6] = { NULL };
-	static const opal_step mbr_funcs[] = {
-		opal_discovery0,
-		start_admin1LSP_opal_session,
-		set_mbr_done,
-		end_opal_session,
-		start_admin1LSP_opal_session,
-		set_mbr_enable_disable,
-		end_opal_session,
-		NULL,
+	opal_step mbr_funcs[] = {
+		{ opal_discovery0, },
+		{ start_admin1LSP_opal_session, &opal_mbr->key },
+		{ set_mbr_done, &opal_mbr->enable_disable },
+		{ end_opal_session, },
+		{ start_admin1LSP_opal_session, &opal_mbr->key },
+		{ set_mbr_enable_disable, &opal_mbr->enable_disable },
+		{ end_opal_session, },
+		{ NULL, }
 	};
 	int ret;
 
@@ -2104,11 +2078,6 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, mbr_funcs);
-	dev->func_data = func_data;
-	dev->func_data[1] = &opal_mbr->key;
-	dev->func_data[2] = &opal_mbr->enable_disable;
-	dev->func_data[4] = &opal_mbr->key;
-	dev->func_data[5] = &opal_mbr->enable_disable;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2135,13 +2104,12 @@ static int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
 static int opal_add_user_to_lr(struct opal_dev *dev,
 			       struct opal_lock_unlock *lk_unlk)
 {
-	void *func_data[3] = { NULL };
-	static const opal_step funcs[] = {
-		opal_discovery0,
-		start_admin1LSP_opal_session,
-		add_user_to_lr,
-		end_opal_session,
-		NULL
+	opal_step funcs[] = {
+		{ opal_discovery0, },
+		{ start_admin1LSP_opal_session, &lk_unlk->session.opal_key },
+		{ add_user_to_lr, lk_unlk },
+		{ end_opal_session, },
+		{ NULL, }
 	};
 	int ret;
 
@@ -2164,9 +2132,6 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, funcs);
-	dev->func_data = func_data;
-	dev->func_data[1] = &lk_unlk->session.opal_key;
-	dev->func_data[2] = lk_unlk;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2174,55 +2139,44 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 
 static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 {
-	void *data[2] = { NULL };
-	static const opal_step revert_funcs[] = {
-		opal_discovery0,
-		start_SIDASP_opal_session,
-		revert_tper, /* controller will terminate session */
-		NULL,
+	opal_step revert_funcs[] = {
+		{ opal_discovery0, },
+		{ start_SIDASP_opal_session, opal },
+		{ revert_tper, }, /* controller will terminate session */
+		{ NULL, }
 	};
 	int ret;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, revert_funcs);
-	dev->func_data = data;
-	dev->func_data[1] = opal;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
 
-static int __opal_lock_unlock_sum(struct opal_dev *dev)
+static int __opal_lock_unlock(struct opal_dev *dev,
+			      struct opal_lock_unlock *lk_unlk)
 {
-	static const opal_step ulk_funcs_sum[] = {
-		opal_discovery0,
-		start_auth_opal_session,
-		lock_unlock_locking_range_sum,
-		end_opal_session,
-		NULL
+	opal_step _unlock_funcs[] = {
+		{ opal_discovery0, },
+		{ start_auth_opal_session, &lk_unlk->session },
+		{ NULL, lk_unlk },
+		{ end_opal_session, },
+		{ NULL, }
 	};
 
-	dev->funcs = ulk_funcs_sum;
-	return next(dev);
-}
-
-static int __opal_lock_unlock(struct opal_dev *dev)
-{
-	static const opal_step _unlock_funcs[] = {
-		opal_discovery0,
-		start_auth_opal_session,
-		lock_unlock_locking_range,
-		end_opal_session,
-		NULL
-	};
+	if (lk_unlk->session.sum)
+		_unlock_funcs[2].fn = lock_unlock_locking_range_sum;
+	else
+		_unlock_funcs[2].fn = lock_unlock_locking_range;
 
 	dev->funcs = _unlock_funcs;
 	return next(dev);
 }
 
-static int opal_lock_unlock(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
+static int opal_lock_unlock(struct opal_dev *dev,
+			    struct opal_lock_unlock *lk_unlk)
 {
-	void *func_data[3] = { NULL };
 	int ret;
 
 	if (lk_unlk->session.who < OPAL_ADMIN1 ||
@@ -2231,32 +2185,23 @@ static int opal_lock_unlock(struct opal_dev *dev, struct opal_lock_unlock *lk_un
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, NULL);
-	dev->func_data = func_data;
-	dev->func_data[1] = &lk_unlk->session;
-	dev->func_data[2] = lk_unlk;
-
-	if (lk_unlk->session.sum)
-		ret = __opal_lock_unlock_sum(dev);
-	else
-		ret = __opal_lock_unlock(dev);
-
+	ret = __opal_lock_unlock(dev, lk_unlk);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
 
 static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 {
-	static const opal_step owner_funcs[] = {
-		opal_discovery0,
-		start_anybodyASP_opal_session,
-		get_msid_cpin_pin,
-		end_opal_session,
-		start_SIDASP_opal_session,
-		set_sid_cpin_pin,
-		end_opal_session,
-		NULL
+	opal_step owner_funcs[] = {
+		{ opal_discovery0, },
+		{ start_anybodyASP_opal_session, },
+		{ get_msid_cpin_pin, },
+		{ end_opal_session, },
+		{ start_SIDASP_opal_session, opal },
+		{ set_sid_cpin_pin, opal },
+		{ end_opal_session, },
+		{ NULL, }
 	};
-	void *data[6] = { NULL };
 	int ret;
 
 	if (!dev)
@@ -2264,9 +2209,6 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, owner_funcs);
-	dev->func_data = data;
-	dev->func_data[4] = opal;
-	dev->func_data[5] = opal;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2274,14 +2216,13 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 
 static int opal_activate_lsp(struct opal_dev *dev, struct opal_lr_act *opal_lr_act)
 {
-	void *data[4] = { NULL };
-	static const opal_step active_funcs[] = {
-		opal_discovery0,
-		start_SIDASP_opal_session, /* Open session as SID auth */
-		get_lsp_lifecycle,
-		activate_lsp,
-		end_opal_session,
-		NULL
+	opal_step active_funcs[] = {
+		{ opal_discovery0, },
+		{ start_SIDASP_opal_session, &opal_lr_act->key },
+		{ get_lsp_lifecycle, },
+		{ activate_lsp, opal_lr_act },
+		{ end_opal_session, },
+		{ NULL, }
 	};
 	int ret;
 
@@ -2290,9 +2231,6 @@ static int opal_activate_lsp(struct opal_dev *dev, struct opal_lr_act *opal_lr_a
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, active_funcs);
-	dev->func_data = data;
-	dev->func_data[1] = &opal_lr_act->key;
-	dev->func_data[3] = opal_lr_act;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2301,21 +2239,17 @@ static int opal_activate_lsp(struct opal_dev *dev, struct opal_lr_act *opal_lr_a
 static int opal_setup_locking_range(struct opal_dev *dev,
 				    struct opal_user_lr_setup *opal_lrs)
 {
-	void *data[3] = { NULL };
-	static const opal_step lr_funcs[] = {
-		opal_discovery0,
-		start_auth_opal_session,
-		setup_locking_range,
-		end_opal_session,
-		NULL,
+	opal_step lr_funcs[] = {
+		{ opal_discovery0, },
+		{ start_auth_opal_session, &opal_lrs->session },
+		{ setup_locking_range, opal_lrs },
+		{ end_opal_session, },
+		{ NULL, }
 	};
 	int ret;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, lr_funcs);
-	dev->func_data = data;
-	dev->func_data[1] = &opal_lrs->session;
-	dev->func_data[2] = opal_lrs;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2323,14 +2257,13 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 
 static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 {
-	static const opal_step pw_funcs[] = {
-		opal_discovery0,
-		start_auth_opal_session,
-		set_new_pw,
-		end_opal_session,
-		NULL
+	opal_step pw_funcs[] = {
+		{ opal_discovery0, },
+		{ start_auth_opal_session, &opal_pw->session },
+		{ set_new_pw, &opal_pw->new_user_pw },
+		{ end_opal_session, },
+		{ NULL }
 	};
-	void *data[3] = { NULL };
 	int ret;
 
 	if (opal_pw->session.who < OPAL_ADMIN1 ||
@@ -2341,10 +2274,6 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, pw_funcs);
-	dev->func_data = data;
-	dev->func_data[1] = (void *) &opal_pw->session;
-	dev->func_data[2] = (void *) &opal_pw->new_user_pw;
-
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2353,14 +2282,13 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 static int opal_activate_user(struct opal_dev *dev,
 			      struct opal_session_info *opal_session)
 {
-	static const opal_step act_funcs[] = {
-		opal_discovery0,
-		start_admin1LSP_opal_session,
-		internal_activate_user,
-		end_opal_session,
-		NULL
+	opal_step act_funcs[] = {
+		{ opal_discovery0, },
+		{ start_admin1LSP_opal_session, &opal_session->opal_key },
+		{ internal_activate_user, opal_session },
+		{ end_opal_session, },
+		{ NULL, }
 	};
-	void *data[3] = { NULL };
 	int ret;
 
 	/* We can't activate Admin1 it's active as manufactured */
@@ -2372,9 +2300,6 @@ static int opal_activate_user(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, act_funcs);
-	dev->func_data = data;
-	dev->func_data[1] = &opal_session->opal_key;
-	dev->func_data[2] = opal_session;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -2383,7 +2308,6 @@ static int opal_activate_user(struct opal_dev *dev,
 bool opal_unlock_from_suspend(struct opal_dev *dev)
 {
 	struct opal_suspend_data *suspend;
-	void *func_data[3] = { NULL };
 	bool was_failure = false;
 	int ret = 0;
 
@@ -2394,19 +2318,13 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev, NULL);
-	dev->func_data = func_data;
 
 	list_for_each_entry(suspend, &dev->unlk_lst, node) {
 		dev->state = 0;
-		dev->func_data[1] = &suspend->unlk.session;
-		dev->func_data[2] = &suspend->unlk;
 		dev->tsn = 0;
 		dev->hsn = 0;
 
-		if (suspend->unlk.session.sum)
-			ret = __opal_lock_unlock_sum(dev);
-		else
-			ret = __opal_lock_unlock(dev);
+		ret = __opal_lock_unlock(dev, &suspend->unlk);
 		if (ret) {
 			pr_warn("Failed to unlock LR %hhu with sum %d\n",
 				suspend->unlk.session.opal_key.lr,
-- 
1.8.3.1

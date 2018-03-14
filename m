Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] block: sed-opal: unify cmd start and finalize
Date: Wed, 14 Mar 2018 07:26:06 +0100
Message-Id: <20180314062606.2316-1-jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <20180313150102.g47bzsqyy2ueazqu@sbauer-Z170X-UD5>
References: <20180313150102.g47bzsqyy2ueazqu@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <0d64b284cd6e78d61b1c8ef5a49ae13bd4b1dfee.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <20180313150102.g47bzsqyy2ueazqu@sbauer-Z170X-UD5>
List-ID: <linux-block@vger.kernel.org>

Every step starts with resetting the cmd buffer as well as the comid and
constructs the appropriate OPAL_CALL command. Consequently, those
actions may be combined into one generic function.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 250 ++++++++++++++++---------------------------------------
 1 file changed, 70 insertions(+), 180 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index a228a13f0a08..3bf685884fbf 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -659,6 +659,9 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
 	struct opal_header *hdr;
 	int err = 0;
 
+	/* close the parameter list opened from start_opal_cmd */
+	add_token_u8(&err, cmd, OPAL_ENDLIST);
+
 	add_token_u8(&err, cmd, OPAL_ENDOFDATA);
 	add_token_u8(&err, cmd, OPAL_STARTLIST);
 	add_token_u8(&err, cmd, 0);
@@ -1001,6 +1004,26 @@ static void clear_opal_cmd(struct opal_dev *dev)
 	memset(dev->cmd, 0, IO_BUFFER_LENGTH);
 }
 
+static int start_opal_cmd(struct opal_dev *dev, const u8 *uid, const u8 *method)
+{
+	int err = 0;
+
+	clear_opal_cmd(dev);
+	set_comid(dev, dev->comid);
+
+	add_token_u8(&err, dev, OPAL_CALL);
+	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
+	add_token_bytestring(&err, dev, method, OPAL_METHOD_LENGTH);
+
+	/* every method call is followed by its parameters enclosed within
+	 * OPAL_STARTLIST and OPAL_ENDLIST tokens. We automatically open the
+	 * parameter list here and close it later in cmd_finalize
+	 */
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+
+	return err;
+}
+
 static int start_opal_session_cont(struct opal_dev *dev)
 {
 	u32 hsn, tsn;
@@ -1063,21 +1086,13 @@ static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
 static int gen_key(struct opal_dev *dev, void *data)
 {
 	u8 uid[OPAL_UID_LENGTH];
-	int err = 0;
-
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	int err;
 
 	memcpy(uid, dev->prev_data, min(sizeof(uid), dev->prev_d_len));
 	kfree(dev->prev_data);
 	dev->prev_data = NULL;
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_GENKEY],
-			     OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
+	err = start_opal_cmd(dev, uid, opalmethod[OPAL_GENKEY]);
 
 	if (err) {
 		pr_debug("Error building gen key command\n");
@@ -1115,21 +1130,14 @@ static int get_active_key_cont(struct opal_dev *dev)
 static int get_active_key(struct opal_dev *dev, void *data)
 {
 	u8 uid[OPAL_UID_LENGTH];
-	int err = 0;
+	int err;
 	u8 *lr = data;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
-
 	err = build_locking_range(uid, sizeof(uid), *lr);
 	if (err)
 		return err;
 
-	err = 0;
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
+	err = start_opal_cmd(dev, uid, opalmethod[OPAL_GET]);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, 3); /* startCloumn */
@@ -1140,7 +1148,6 @@ static int get_active_key(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, 10); /* ActiveKey */
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 	if (err) {
 		pr_debug("Error building get active key command\n");
 		return err;
@@ -1153,13 +1160,10 @@ static int generic_lr_enable_disable(struct opal_dev *dev,
 				     u8 *uid, bool rle, bool wle,
 				     bool rl, bool wl)
 {
-	int err = 0;
+	int err;
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
+	err = start_opal_cmd(dev, uid, opalmethod[OPAL_SET]);
 
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1186,7 +1190,6 @@ static int generic_lr_enable_disable(struct opal_dev *dev,
 
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 	return err;
 }
 
@@ -1207,10 +1210,7 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
 	u8 uid[OPAL_UID_LENGTH];
 	struct opal_user_lr_setup *setup = data;
 	u8 lr;
-	int err = 0;
-
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	int err;
 
 	lr = setup->session.opal_key.lr;
 	err = build_locking_range(uid, sizeof(uid), lr);
@@ -1220,12 +1220,8 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
 	if (lr == 0)
 		err = enable_global_lr(dev, uid, setup);
 	else {
-		add_token_u8(&err, dev, OPAL_CALL);
-		add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
-		add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
-				     OPAL_UID_LENGTH);
+		err = start_opal_cmd(dev, uid, opalmethod[OPAL_SET]);
 
-		add_token_u8(&err, dev, OPAL_STARTLIST);
 		add_token_u8(&err, dev, OPAL_STARTNAME);
 		add_token_u8(&err, dev, OPAL_VALUES);
 		add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1252,8 +1248,6 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
 
 		add_token_u8(&err, dev, OPAL_ENDLIST);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
-		add_token_u8(&err, dev, OPAL_ENDLIST);
-
 	}
 	if (err) {
 		pr_debug("Error building Setup Locking range command.\n");
@@ -1271,29 +1265,21 @@ static int start_generic_opal_session(struct opal_dev *dev,
 				      u8 key_len)
 {
 	u32 hsn;
-	int err = 0;
+	int err;
 
 	if (key == NULL && auth != OPAL_ANYBODY_UID)
 		return OPAL_INVAL_PARAM;
 
-	clear_opal_cmd(dev);
-
-	set_comid(dev, dev->comid);
 	hsn = GENERIC_HOST_SESSION_NUM;
+	err = start_opal_cmd(dev, opaluid[OPAL_SMUID_UID],
+			     opalmethod[OPAL_STARTSESSION]);
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_SMUID_UID],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_STARTSESSION],
-			     OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u64(&err, dev, hsn);
 	add_token_bytestring(&err, dev, opaluid[sp_type], OPAL_UID_LENGTH);
 	add_token_u8(&err, dev, 1);
 
 	switch (auth) {
 	case OPAL_ANYBODY_UID:
-		add_token_u8(&err, dev, OPAL_ENDLIST);
 		break;
 	case OPAL_ADMIN1_UID:
 	case OPAL_SID_UID:
@@ -1306,7 +1292,6 @@ static int start_generic_opal_session(struct opal_dev *dev,
 		add_token_bytestring(&err, dev, opaluid[auth],
 				     OPAL_UID_LENGTH);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
-		add_token_u8(&err, dev, OPAL_ENDLIST);
 		break;
 	default:
 		pr_debug("Cannot start Admin SP session with auth %d\n", auth);
@@ -1366,30 +1351,21 @@ static int start_auth_opal_session(struct opal_dev *dev, void *data)
 	u8 *key = session->opal_key.key;
 	u32 hsn = GENERIC_HOST_SESSION_NUM;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
-
-	if (session->sum) {
+	if (session->sum)
 		err = build_locking_user(lk_ul_user, sizeof(lk_ul_user),
 					 session->opal_key.lr);
-		if (err)
-			return err;
-
-	} else if (session->who != OPAL_ADMIN1 && !session->sum) {
+	else if (session->who != OPAL_ADMIN1 && !session->sum)
 		err = build_locking_user(lk_ul_user, sizeof(lk_ul_user),
 					 session->who - 1);
-		if (err)
-			return err;
-	} else
+	else
 		memcpy(lk_ul_user, opaluid[OPAL_ADMIN1_UID], OPAL_UID_LENGTH);
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_SMUID_UID],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_STARTSESSION],
-			     OPAL_UID_LENGTH);
+	if (err)
+		return err;
+
+	err = start_opal_cmd(dev, opaluid[OPAL_SMUID_UID],
+			     opalmethod[OPAL_STARTSESSION]);
 
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u64(&err, dev, hsn);
 	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
 			     OPAL_UID_LENGTH);
@@ -1402,7 +1378,6 @@ static int start_auth_opal_session(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, 3);
 	add_token_bytestring(&err, dev, lk_ul_user, OPAL_UID_LENGTH);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error building STARTSESSION command.\n");
@@ -1414,18 +1389,10 @@ static int start_auth_opal_session(struct opal_dev *dev, void *data)
 
 static int revert_tper(struct opal_dev *dev, void *data)
 {
-	int err = 0;
-
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	int err;
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_ADMINSP_UID],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_REVERT],
-			     OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
+	err = start_opal_cmd(dev, opaluid[OPAL_ADMINSP_UID],
+			     opalmethod[OPAL_REVERT]);
 	if (err) {
 		pr_debug("Error building REVERT TPER command.\n");
 		return err;
@@ -1438,18 +1405,12 @@ static int internal_activate_user(struct opal_dev *dev, void *data)
 {
 	struct opal_session_info *session = data;
 	u8 uid[OPAL_UID_LENGTH];
-	int err = 0;
-
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	int err;
 
 	memcpy(uid, opaluid[OPAL_USER1_UID], OPAL_UID_LENGTH);
 	uid[7] = session->who;
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
+	err = start_opal_cmd(dev, uid, opalmethod[OPAL_SET]);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1459,7 +1420,6 @@ static int internal_activate_user(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error building Activate UserN command.\n");
@@ -1473,20 +1433,12 @@ static int erase_locking_range(struct opal_dev *dev, void *data)
 {
 	struct opal_session_info *session = data;
 	u8 uid[OPAL_UID_LENGTH];
-	int err = 0;
-
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	int err;
 
 	if (build_locking_range(uid, sizeof(uid), session->opal_key.lr) < 0)
 		return -ERANGE;
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_ERASE],
-			     OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
+	err = start_opal_cmd(dev, uid, opalmethod[OPAL_ERASE]);
 
 	if (err) {
 		pr_debug("Error building Erase Locking Range Command.\n");
@@ -1498,16 +1450,11 @@ static int erase_locking_range(struct opal_dev *dev, void *data)
 static int set_mbr_done(struct opal_dev *dev, void *data)
 {
 	u8 *mbr_done_tf = data;
-	int err = 0;
+	int err;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	err = start_opal_cmd(dev, opaluid[OPAL_MBRCONTROL],
+			     opalmethod[OPAL_SET]);
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_MBRCONTROL],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1517,7 +1464,6 @@ static int set_mbr_done(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error Building set MBR Done command\n");
@@ -1530,16 +1476,11 @@ static int set_mbr_done(struct opal_dev *dev, void *data)
 static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 {
 	u8 *mbr_en_dis = data;
-	int err = 0;
+	int err;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	err = start_opal_cmd(dev, opaluid[OPAL_MBRCONTROL],
+			     opalmethod[OPAL_SET]);
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_MBRCONTROL],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1549,7 +1490,6 @@ static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error Building set MBR done command\n");
@@ -1562,16 +1502,10 @@ static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
 			  struct opal_dev *dev)
 {
-	int err = 0;
+	int err;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	err = start_opal_cmd(dev, cpin_uid, opalmethod[OPAL_SET]);
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, cpin_uid, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
-			     OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1581,7 +1515,6 @@ static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	return err;
 }
@@ -1629,10 +1562,7 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 	u8 lr_buffer[OPAL_UID_LENGTH];
 	u8 user_uid[OPAL_UID_LENGTH];
 	struct opal_lock_unlock *lkul = data;
-	int err = 0;
-
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	int err;
 
 	memcpy(lr_buffer, opaluid[OPAL_LOCKINGRANGE_ACE_RDLOCKED],
 	       OPAL_UID_LENGTH);
@@ -1647,12 +1577,8 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 
 	user_uid[7] = lkul->session.who;
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, lr_buffer, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
-			     OPAL_UID_LENGTH);
+	err = start_opal_cmd(dev, lr_buffer, opalmethod[OPAL_SET]);
 
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 
@@ -1690,7 +1616,6 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error building add user to locking range command.\n");
@@ -1707,9 +1632,6 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 	u8 read_locked = 1, write_locked = 1;
 	int err = 0;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
-
 	if (build_locking_range(lr_buffer, sizeof(lr_buffer),
 				lkul->session.opal_key.lr) < 0)
 		return -ERANGE;
@@ -1731,10 +1653,8 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 		return OPAL_INVAL_PARAM;
 	}
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, lr_buffer, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
+	err = start_opal_cmd(dev, lr_buffer, opalmethod[OPAL_SET]);
+
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1751,7 +1671,6 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error building SET command.\n");
@@ -1806,17 +1725,10 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 	struct opal_lr_act *opal_act = data;
 	u8 user_lr[OPAL_UID_LENGTH];
 	u8 uint_3 = 0x83;
-	int err = 0, i;
-
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
-
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_ACTIVATE],
-			     OPAL_UID_LENGTH);
+	int err, i;
 
+	err = start_opal_cmd(dev, opaluid[OPAL_LOCKINGSP_UID],
+			     opalmethod[OPAL_ACTIVATE]);
 
 	if (opal_act->sum) {
 		err = build_locking_range(user_lr, sizeof(user_lr),
@@ -1824,7 +1736,6 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 		if (err)
 			return err;
 
-		add_token_u8(&err, dev, OPAL_STARTLIST);
 		add_token_u8(&err, dev, OPAL_STARTNAME);
 		add_token_u8(&err, dev, uint_3);
 		add_token_u8(&err, dev, 6);
@@ -1839,11 +1750,6 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 		}
 		add_token_u8(&err, dev, OPAL_ENDLIST);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
-		add_token_u8(&err, dev, OPAL_ENDLIST);
-
-	} else {
-		add_token_u8(&err, dev, OPAL_STARTLIST);
-		add_token_u8(&err, dev, OPAL_ENDLIST);
 	}
 
 	if (err) {
@@ -1877,17 +1783,11 @@ static int get_lsp_lifecycle_cont(struct opal_dev *dev)
 /* Determine if we're in the Manufactured Inactive or Active state */
 static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
 {
-	int err = 0;
+	int err;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
-
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
+	err = start_opal_cmd(dev, opaluid[OPAL_LOCKINGSP_UID],
+			     opalmethod[OPAL_GET]);
 
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 
 	add_token_u8(&err, dev, OPAL_STARTNAME);
@@ -1900,7 +1800,6 @@ static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, 6); /* Lifecycle Column */
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
@@ -1938,19 +1837,12 @@ static int get_msid_cpin_pin_cont(struct opal_dev *dev)
 
 static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
 {
-	int err = 0;
+	int err;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	err = start_opal_cmd(dev, opaluid[OPAL_C_PIN_MSID],
+			     opalmethod[OPAL_GET]);
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_C_PIN_MSID],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
-
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
-
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, 3); /* Start Column */
 	add_token_u8(&err, dev, 3); /* PIN */
@@ -1960,8 +1852,6 @@ static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, 4); /* End Column */
 	add_token_u8(&err, dev, 3); /* Lifecycle Column */
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-- 
2.16.1

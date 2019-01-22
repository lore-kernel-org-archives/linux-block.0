Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C32EC282C4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 22:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5255420866
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 22:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="NbMCc9Xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfAVWcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:32:41 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:45608 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfAVWck (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 17:32:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id D4196B0687;
        Tue, 22 Jan 2019 23:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1548196356; i=@fjfi.cvut.cz;
        bh=NOvhr8m701cfzD7hZgXfm8SkYRzicQ617snfATqlX30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NbMCc9Xa/SZPhFEnlINTClLzcrQEMepKRMVhmS7ErPBz15jrwKsebImz2PxUU3u61
         wcWKSO98E4ix21vg88PYewAHu7I6VkvjFC3tOmxdhBEQgWTm9QdrHBRseAJaBS3FRY
         A5Km6n82CK2oKLoti9ocq9X5uDhYeaMZWwvpgHtE=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id 4rE0Ufx-L9QT; Tue, 22 Jan 2019 23:32:27 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id B3DF6B066A;
        Tue, 22 Jan 2019 23:32:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz B3DF6B066A
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 99CED6004E; Tue, 22 Jan 2019 23:32:27 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH v3 05/16] block: sed-opal: unify cmd start
Date:   Tue, 22 Jan 2019 23:31:36 +0100
Message-Id: <1548196307-12987-6-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548196307-12987-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1548196307-12987-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Every step starts with resetting the cmd buffer as well as the comid and
constructs the appropriate OPAL_CALL command. Consequently, those
actions may be combined into one generic function. On should take care
that the opening and closing tokens for the argument list are already
emitted by cmd_start and cmd_finalize respectively and thus must not be
additionally added.

Co-authored-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 228 ++++++++++++++---------------------------------
 1 file changed, 69 insertions(+), 159 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 35b1747b650f..e29cb2f445ff 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -661,7 +661,7 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
 	struct opal_header *hdr;
 	int err = 0;
 
-	/* close parameter list */
+	/* close the parameter list opened from cmd_start */
 	add_token_u8(&err, cmd, OPAL_ENDLIST);
 
 	add_token_u8(&err, cmd, OPAL_ENDOFDATA);
@@ -1006,6 +1006,27 @@ static void clear_opal_cmd(struct opal_dev *dev)
 	memset(dev->cmd, 0, IO_BUFFER_LENGTH);
 }
 
+static int cmd_start(struct opal_dev *dev, const u8 *uid, const u8 *method)
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
+	/*
+	 * Every method call is followed by its parameters enclosed within
+	 * OPAL_STARTLIST and OPAL_ENDLIST tokens. We automatically open the
+	 * parameter list here and close it later in cmd_finalize.
+	 */
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+
+	return err;
+}
+
 static int start_opal_session_cont(struct opal_dev *dev)
 {
 	u32 hsn, tsn;
@@ -1068,20 +1089,13 @@ static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
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
+	err = cmd_start(dev, uid, opalmethod[OPAL_GENKEY]);
 
 	if (err) {
 		pr_debug("Error building gen key command\n");
@@ -1119,21 +1133,14 @@ static int get_active_key_cont(struct opal_dev *dev)
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
+	err = cmd_start(dev, uid, opalmethod[OPAL_GET]);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, 3); /* startCloumn */
@@ -1156,13 +1163,10 @@ static int generic_lr_enable_disable(struct opal_dev *dev,
 				     u8 *uid, bool rle, bool wle,
 				     bool rl, bool wl)
 {
-	int err = 0;
+	int err;
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
+	err = cmd_start(dev, uid, opalmethod[OPAL_SET]);
 
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1209,10 +1213,7 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
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
@@ -1222,12 +1223,8 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
 	if (lr == 0)
 		err = enable_global_lr(dev, uid, setup);
 	else {
-		add_token_u8(&err, dev, OPAL_CALL);
-		add_token_bytestring(&err, dev, uid, OPAL_UID_LENGTH);
-		add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
-				     OPAL_UID_LENGTH);
+		err = cmd_start(dev, uid, opalmethod[OPAL_SET]);
 
-		add_token_u8(&err, dev, OPAL_STARTLIST);
 		add_token_u8(&err, dev, OPAL_STARTNAME);
 		add_token_u8(&err, dev, OPAL_VALUES);
 		add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1271,22 +1268,15 @@ static int start_generic_opal_session(struct opal_dev *dev,
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
+	err = cmd_start(dev, opaluid[OPAL_SMUID_UID],
+			opalmethod[OPAL_STARTSESSION]);
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_SMUID_UID],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_STARTSESSION],
-			     OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u64(&err, dev, hsn);
 	add_token_bytestring(&err, dev, opaluid[sp_type], OPAL_UID_LENGTH);
 	add_token_u8(&err, dev, 1);
@@ -1366,30 +1356,21 @@ static int start_auth_opal_session(struct opal_dev *dev, void *data)
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
+	err = cmd_start(dev, opaluid[OPAL_SMUID_UID],
+			opalmethod[OPAL_STARTSESSION]);
 
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u64(&err, dev, hsn);
 	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
 			     OPAL_UID_LENGTH);
@@ -1413,17 +1394,10 @@ static int start_auth_opal_session(struct opal_dev *dev, void *data)
 
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
+	err = cmd_start(dev, opaluid[OPAL_ADMINSP_UID],
+			opalmethod[OPAL_REVERT]);
 	if (err) {
 		pr_debug("Error building REVERT TPER command.\n");
 		return err;
@@ -1436,18 +1410,12 @@ static int internal_activate_user(struct opal_dev *dev, void *data)
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
+	err = cmd_start(dev, uid, opalmethod[OPAL_SET]);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1470,19 +1438,12 @@ static int erase_locking_range(struct opal_dev *dev, void *data)
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
+	err = cmd_start(dev, uid, opalmethod[OPAL_ERASE]);
 
 	if (err) {
 		pr_debug("Error building Erase Locking Range Command.\n");
@@ -1494,16 +1455,11 @@ static int erase_locking_range(struct opal_dev *dev, void *data)
 static int set_mbr_done(struct opal_dev *dev, void *data)
 {
 	u8 *mbr_done_tf = data;
-	int err = 0;
+	int err;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	err = cmd_start(dev, opaluid[OPAL_MBRCONTROL],
+			opalmethod[OPAL_SET]);
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_MBRCONTROL],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1525,16 +1481,11 @@ static int set_mbr_done(struct opal_dev *dev, void *data)
 static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 {
 	u8 *mbr_en_dis = data;
-	int err = 0;
+	int err;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	err = cmd_start(dev, opaluid[OPAL_MBRCONTROL],
+			opalmethod[OPAL_SET]);
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_MBRCONTROL],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1556,16 +1507,10 @@ static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
 			  struct opal_dev *dev)
 {
-	int err = 0;
+	int err;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	err = cmd_start(dev, cpin_uid, opalmethod[OPAL_SET]);
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, cpin_uid, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
-			     OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1622,10 +1567,7 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
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
@@ -1640,12 +1582,8 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 
 	user_uid[7] = lkul->session.who;
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, lr_buffer, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET],
-			     OPAL_UID_LENGTH);
+	err = cmd_start(dev, lr_buffer, opalmethod[OPAL_SET]);
 
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 
@@ -1699,9 +1637,6 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 	u8 read_locked = 1, write_locked = 1;
 	int err = 0;
 
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
-
 	if (build_locking_range(lr_buffer, sizeof(lr_buffer),
 				lkul->session.opal_key.lr) < 0)
 		return -ERANGE;
@@ -1723,10 +1658,8 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 		return OPAL_INVAL_PARAM;
 	}
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, lr_buffer, OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_SET], OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
+	err = cmd_start(dev, lr_buffer, opalmethod[OPAL_SET]);
+
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
@@ -1797,17 +1730,10 @@ static int activate_lsp(struct opal_dev *dev, void *data)
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
 
+	err = cmd_start(dev, opaluid[OPAL_LOCKINGSP_UID],
+			opalmethod[OPAL_ACTIVATE]);
 
 	if (opal_act->sum) {
 		err = build_locking_range(user_lr, sizeof(user_lr),
@@ -1815,7 +1741,6 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 		if (err)
 			return err;
 
-		add_token_u8(&err, dev, OPAL_STARTLIST);
 		add_token_u8(&err, dev, OPAL_STARTNAME);
 		add_token_u8(&err, dev, uint_3);
 		add_token_u8(&err, dev, 6);
@@ -1830,8 +1755,6 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 		}
 		add_token_u8(&err, dev, OPAL_ENDLIST);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
-	} else {
-		add_token_u8(&err, dev, OPAL_STARTLIST);
 	}
 
 	if (err) {
@@ -1865,17 +1788,11 @@ static int get_lsp_lifecycle_cont(struct opal_dev *dev)
 /* Determine if we're in the Manufactured Inactive or Active state */
 static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
 {
-	int err = 0;
-
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	int err;
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_LOCKINGSP_UID],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
+	err = cmd_start(dev, opaluid[OPAL_LOCKINGSP_UID],
+			opalmethod[OPAL_GET]);
 
-	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 
 	add_token_u8(&err, dev, OPAL_STARTNAME);
@@ -1925,19 +1842,12 @@ static int get_msid_cpin_pin_cont(struct opal_dev *dev)
 
 static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
 {
-	int err = 0;
-
-	clear_opal_cmd(dev);
-	set_comid(dev, dev->comid);
+	int err;
 
-	add_token_u8(&err, dev, OPAL_CALL);
-	add_token_bytestring(&err, dev, opaluid[OPAL_C_PIN_MSID],
-			     OPAL_UID_LENGTH);
-	add_token_bytestring(&err, dev, opalmethod[OPAL_GET], OPAL_UID_LENGTH);
+	err = cmd_start(dev, opaluid[OPAL_C_PIN_MSID],
+			opalmethod[OPAL_GET]);
 
 	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
-
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, 3); /* Start Column */
 	add_token_u8(&err, dev, 3); /* PIN */
-- 
2.20.1


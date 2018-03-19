Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D2C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169F020675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfAPXEr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:04:47 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:45698 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfAPXD7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:03:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 1EB74B042B;
        Wed, 16 Jan 2019 23:55:59 +0100 (CET)
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id O7X07mjw-zWT; Wed, 16 Jan 2019 23:55:50 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 06C67B0430;
        Wed, 16 Jan 2019 23:55:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 06C67B0430
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id D96AD6004E; Wed, 16 Jan 2019 23:55:46 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Date:   Mon, 19 Mar 2018 19:36:51 +0100
Subject: [PATCH 12/16] block: sed-opal: unify retrieval of table columns
To:     Jens Axboe <axboe@kernel.dk>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-Id: <20190116225546.D96AD6004E@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of having multiple places defining the same argument list to get
a specific column of a sed-opal table, provide a generic version and
call it from those functions.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/opal_proto.h |   2 +
 block/sed-opal.c   | 132 +++++++++++++++++----------------------------
 2 files changed, 50 insertions(+), 84 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index e20be8258854..b6e352cfe982 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -170,6 +170,8 @@ enum opal_token {
 	OPAL_READLOCKED = 0x07,
 	OPAL_WRITELOCKED = 0x08,
 	OPAL_ACTIVEKEY = 0x0A,
+	/* lockingsp table */
+	OPAL_LIFECYCLE = 0x06,
 	/* locking info table */
 	OPAL_MAXRANGES = 0x04,
 	 /* mbr control */
diff --git a/block/sed-opal.c b/block/sed-opal.c
index ee24e4e7ad6e..034cb940b34a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1089,6 +1089,37 @@ static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
 	return opal_send_recv(dev, cont);
 }
 
+/*
+ * request @column from table @table on device @dev. On success, the column
+ * data will be available in dev->resp->tok[4]
+ */
+static int generic_get_column(struct opal_dev *dev, const u8 *table,
+			      u64 column)
+{
+	int err;
+
+	err = cmd_start(dev, table, opalmethod[OPAL_GET]);
+
+	add_token_u8(&err, dev, OPAL_STARTLIST);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_STARTCOLUMN);
+	add_token_u64(&err, dev, column);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u8(&err, dev, OPAL_ENDCOLUMN);
+	add_token_u64(&err, dev, column);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	add_token_u8(&err, dev, OPAL_ENDLIST);
+
+	if (err)
+		return err;
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
 static int gen_key(struct opal_dev *dev, void *data)
 {
 	u8 uid[OPAL_UID_LENGTH];
@@ -1143,23 +1174,11 @@ static int get_active_key(struct opal_dev *dev, void *data)
 	if (err)
 		return err;
 
-	err = cmd_start(dev, uid, opalmethod[OPAL_GET]);
-	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 3); /* startCloumn */
-	add_token_u8(&err, dev, 10); /* ActiveKey */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 4); /* endColumn */
-	add_token_u8(&err, dev, 10); /* ActiveKey */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
-	if (err) {
-		pr_debug("Error building get active key command\n");
+	err = generic_get_column(dev, uid, OPAL_ACTIVEKEY);
+	if (err)
 		return err;
-	}
 
-	return finalize_and_send(dev, get_active_key_cont);
+	return get_active_key_cont(dev);
 }
 
 static int generic_lr_enable_disable(struct opal_dev *dev,
@@ -1819,17 +1838,19 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int get_lsp_lifecycle_cont(struct opal_dev *dev)
+/* Determine if we're in the Manufactured Inactive or Active state */
+static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
 {
 	u8 lc_status;
-	int error = 0;
+	int err;
 
-	error = parse_and_check_status(dev);
-	if (error)
-		return error;
+	err = generic_get_column(dev, opaluid[OPAL_LOCKINGSP_UID],
+				 OPAL_LIFECYCLE);
+	if (err)
+		return err;
 
 	lc_status = response_get_u64(&dev->parsed, 4);
-	/* 0x08 is Manufacured Inactive */
+	/* 0x08 is Manufactured Inactive */
 	/* 0x09 is Manufactured */
 	if (lc_status != OPAL_MANUFACTURED_INACTIVE) {
 		pr_debug("Couldn't determine the status of the Lifecycle state\n");
@@ -1839,49 +1860,19 @@ static int get_lsp_lifecycle_cont(struct opal_dev *dev)
 	return 0;
 }
 
-/* Determine if we're in the Manufactured Inactive or Active state */
-static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
-{
-	int err;
-
-	err = cmd_start(dev, opaluid[OPAL_LOCKINGSP_UID],
-			opalmethod[OPAL_GET]);
-
-	add_token_u8(&err, dev, OPAL_STARTLIST);
-
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 3); /* Start Column */
-	add_token_u8(&err, dev, 6); /* Lifecycle Column */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 4); /* End Column */
-	add_token_u8(&err, dev, 6); /* Lifecycle Column */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-	add_token_u8(&err, dev, OPAL_ENDLIST);
-
-	if (err) {
-		pr_debug("Error Building GET Lifecycle Status command\n");
-		return err;
-	}
-
-	return finalize_and_send(dev, get_lsp_lifecycle_cont);
-}
-
-static int get_msid_cpin_pin_cont(struct opal_dev *dev)
+static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
 {
 	const char *msid_pin;
 	size_t strlen;
-	int error = 0;
+	int err;
 
-	error = parse_and_check_status(dev);
-	if (error)
-		return error;
+	err = generic_get_column(dev, opaluid[OPAL_C_PIN_MSID], OPAL_PIN);
+	if (err)
+		return err;
 
 	strlen = response_get_string(&dev->parsed, 4, &msid_pin);
 	if (!msid_pin) {
-		pr_debug("%s: Couldn't extract PIN from response\n", __func__);
+		pr_debug("Couldn't extract MSID_CPIN from response\n");
 		return OPAL_INVAL_PARAM;
 	}
 
@@ -1894,33 +1885,6 @@ static int get_msid_cpin_pin_cont(struct opal_dev *dev)
 	return 0;
 }
 
-static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
-{
-	int err;
-
-	err = cmd_start(dev, opaluid[OPAL_C_PIN_MSID],
-			opalmethod[OPAL_GET]);
-
-	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 3); /* Start Column */
-	add_token_u8(&err, dev, 3); /* PIN */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 4); /* End Column */
-	add_token_u8(&err, dev, 3); /* Lifecycle Column */
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
-
-	if (err) {
-		pr_debug("Error building Get MSID CPIN PIN command.\n");
-		return err;
-	}
-
-	return finalize_and_send(dev, get_msid_cpin_pin_cont);
-}
-
 static int end_opal_session(struct opal_dev *dev, void *data)
 {
 	int err = 0;
-- 
2.20.1


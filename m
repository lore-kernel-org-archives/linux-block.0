Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25301C4360F
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E877C21920
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="JXE9/kfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404799AbfBNARV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:17:21 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47784 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390394AbfBNARV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:17:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id D1D9BAA295;
        Thu, 14 Feb 2019 01:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103437; i=@fjfi.cvut.cz;
        bh=6GQlzOV2DrNL5ZtNla7VpcLrv3v2VYXKr7TbGAYZkyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JXE9/kfa5MHvivw0GJPsTjyazAeGVlsjwj5+uWWdRrtrKSextMVm7F9233TH4n6p1
         ks5I+BcEmnThbbHSNIlaXtqExSppWOng1oeD4LcgUMDF2u8NApI0w2/kqyKmKiReY8
         I8cSIA6pgpzPaP07jvQFsjzQ7S2W3pbOCctc9duw=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id Fo0xre6kLhCK; Thu, 14 Feb 2019 01:17:05 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 39108AA286;
        Thu, 14 Feb 2019 01:17:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 39108AA286
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 21A7A6004E; Thu, 14 Feb 2019 01:17:02 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 12/16] block: sed-opal: unify retrieval of table columns
Date:   Thu, 14 Feb 2019 01:16:04 +0100
Message-Id: <1550103368-4605-13-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of having multiple places defining the same argument list to get
a specific column of a sed-opal table, provide a generic version and
call it from those functions.

Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 130 +++++++++++++++++------------------------------
 1 file changed, 47 insertions(+), 83 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 7f02e50e2bce..5395ab1c5248 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1075,6 +1075,37 @@ static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
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
@@ -1129,23 +1160,11 @@ static int get_active_key(struct opal_dev *dev, void *data)
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
@@ -1754,14 +1773,16 @@ static int activate_lsp(struct opal_dev *dev, void *data)
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
 	/* 0x08 is Manufactured Inactive */
@@ -1774,49 +1795,19 @@ static int get_lsp_lifecycle_cont(struct opal_dev *dev)
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
-	add_token_u8(&err, dev, OPAL_LIFECYCLE);
-	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 4); /* End Column */
-	add_token_u8(&err, dev, OPAL_LIFECYCLE);
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
 
@@ -1829,33 +1820,6 @@ static int get_msid_cpin_pin_cont(struct opal_dev *dev)
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


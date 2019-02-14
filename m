Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFEDC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2846222C9
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="d6cU8igt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391902AbfBNASH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:18:07 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47436 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404676AbfBNARA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:17:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 0F732AA230;
        Thu, 14 Feb 2019 01:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103417; i=@fjfi.cvut.cz;
        bh=wO4aKfNItbnDzj3mOMLRac+VXQYP/Mvk0/HT9bzbPIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=d6cU8igtdxR0jkeVyvjFkEJ1WCoNVuo0xbSRUhQRnDseYI1bUapAhXMP1RaOZbon4
         8ntyCLxeOKLY6baqIlcTw8zlYRF5Da8yrdtjl6jTQ9zqdNJCUtjdqDsPeP1tAr4aVJ
         hoOpsTeA72Zs0KFLhAWn6jObgjMv/K5MkJh/0LdU=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id 0M7iZb0eV2jl; Thu, 14 Feb 2019 01:16:48 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 3C0CDAA286;
        Thu, 14 Feb 2019 01:16:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 3C0CDAA286
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 200F96004E; Thu, 14 Feb 2019 01:16:48 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 05/16] block: sed-opal: close parameter list in cmd_finalize
Date:   Thu, 14 Feb 2019 01:15:57 +0100
Message-Id: <1550103368-4605-6-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Every step ends by calling cmd_finalize (via finalize_and_send)
yet every step adds the token OPAL_ENDLIST on its own. Moving
this into cmd_finalize decreases code duplication.

Co-authored-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index d285bd4b2b9b..c5dff6199bd6 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -655,6 +655,9 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
 	struct opal_header *hdr;
 	int err = 0;
 
+	/* close parameter list */
+	add_token_u8(&err, cmd, OPAL_ENDLIST);
+
 	add_token_u8(&err, cmd, OPAL_ENDOFDATA);
 	add_token_u8(&err, cmd, OPAL_STARTLIST);
 	add_token_u8(&err, cmd, 0);
@@ -1073,7 +1076,6 @@ static int gen_key(struct opal_dev *dev, void *data)
 	add_token_bytestring(&err, dev, opalmethod[OPAL_GENKEY],
 			     OPAL_UID_LENGTH);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error building gen key command\n");
@@ -1136,7 +1138,6 @@ static int get_active_key(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, 10); /* ActiveKey */
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 	if (err) {
 		pr_debug("Error building get active key command\n");
 		return err;
@@ -1182,7 +1183,6 @@ static int generic_lr_enable_disable(struct opal_dev *dev,
 
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 	return err;
 }
 
@@ -1248,8 +1248,6 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
 
 		add_token_u8(&err, dev, OPAL_ENDLIST);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
-		add_token_u8(&err, dev, OPAL_ENDLIST);
-
 	}
 	if (err) {
 		pr_debug("Error building Setup Locking range command.\n");
@@ -1289,7 +1287,6 @@ static int start_generic_opal_session(struct opal_dev *dev,
 
 	switch (auth) {
 	case OPAL_ANYBODY_UID:
-		add_token_u8(&err, dev, OPAL_ENDLIST);
 		break;
 	case OPAL_ADMIN1_UID:
 	case OPAL_SID_UID:
@@ -1302,7 +1299,6 @@ static int start_generic_opal_session(struct opal_dev *dev,
 		add_token_bytestring(&err, dev, opaluid[auth],
 				     OPAL_UID_LENGTH);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
-		add_token_u8(&err, dev, OPAL_ENDLIST);
 		break;
 	default:
 		pr_debug("Cannot start Admin SP session with auth %d\n", auth);
@@ -1400,7 +1396,6 @@ static int start_auth_opal_session(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, 3);
 	add_token_bytestring(&err, dev, lk_ul_user, OPAL_UID_LENGTH);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error building STARTSESSION command.\n");
@@ -1423,7 +1418,6 @@ static int revert_tper(struct opal_dev *dev, void *data)
 	add_token_bytestring(&err, dev, opalmethod[OPAL_REVERT],
 			     OPAL_UID_LENGTH);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 	if (err) {
 		pr_debug("Error building REVERT TPER command.\n");
 		return err;
@@ -1457,7 +1451,6 @@ static int internal_activate_user(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error building Activate UserN command.\n");
@@ -1484,7 +1477,6 @@ static int erase_locking_range(struct opal_dev *dev, void *data)
 	add_token_bytestring(&err, dev, opalmethod[OPAL_ERASE],
 			     OPAL_UID_LENGTH);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error building Erase Locking Range Command.\n");
@@ -1515,7 +1507,6 @@ static int set_mbr_done(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error Building set MBR Done command\n");
@@ -1547,7 +1538,6 @@ static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error Building set MBR done command\n");
@@ -1579,7 +1569,6 @@ static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	return err;
 }
@@ -1688,7 +1677,6 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error building add user to locking range command.\n");
@@ -1749,7 +1737,6 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
 		pr_debug("Error building SET command.\n");
@@ -1837,11 +1824,8 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 		}
 		add_token_u8(&err, dev, OPAL_ENDLIST);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
-		add_token_u8(&err, dev, OPAL_ENDLIST);
-
 	} else {
 		add_token_u8(&err, dev, OPAL_STARTLIST);
-		add_token_u8(&err, dev, OPAL_ENDLIST);
 	}
 
 	if (err) {
@@ -1898,7 +1882,6 @@ static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, 6); /* Lifecycle Column */
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
@@ -1958,8 +1941,6 @@ static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, 4); /* End Column */
 	add_token_u8(&err, dev, 3); /* Lifecycle Column */
 	add_token_u8(&err, dev, OPAL_ENDNAME);
-
-	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 
 	if (err) {
-- 
2.20.1


Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8358C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F652146E
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="q5AAW7Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404643AbfBNAQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:16:49 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47226 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBNAQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:16:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 8236AAA285;
        Thu, 14 Feb 2019 01:16:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103405; i=@fjfi.cvut.cz;
        bh=CV/lUT7VJkI5FIlbMOcrEXFkZgRToBUYw3ufyzqSN2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=q5AAW7AdxkiYHQlOve0ldMCdX2rTuUedBbqNg8BqGI4WHV/IgJNibtGuQKfjsKaFe
         zjNlsTpXjb21zHCZAEMiSlEsWNbofmMG8boYfXeAeXd6ggTgc6f9qCBhAdcJTa+xlw
         6V3wBprxy7L4WNBr4lPi8sINbVkV5HEBD+19QvQQ=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id LBu2eDisybra; Thu, 14 Feb 2019 01:16:42 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id D8892AA26F;
        Thu, 14 Feb 2019 01:16:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz D8892AA26F
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 88B6A6004E; Thu, 14 Feb 2019 01:16:41 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 02/16] block: sed-opal: fix typos and formatting
Date:   Thu, 14 Feb 2019 01:15:54 +0100
Message-Id: <1550103368-4605-3-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This should make no change in functionality.
The formatting changes were triggered by checkpatch.pl.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c              | 18 ++++++++++--------
 include/uapi/linux/sed-opal.h |  2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 119640897293..d12a910e06cb 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -157,7 +157,7 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 
 	/* C_PIN_TABLE object ID's */
 
-        [OPAL_C_PIN_MSID] =
+	[OPAL_C_PIN_MSID] =
 		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02},
 	[OPAL_C_PIN_SID] =
 		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x01},
@@ -551,7 +551,6 @@ static void add_medium_atom_header(struct opal_dev *cmd, bool bytestring,
 
 static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 {
-
 	size_t len;
 	int msb;
 
@@ -623,7 +622,7 @@ static int build_locking_range(u8 *buffer, size_t length, u8 lr)
 static int build_locking_user(u8 *buffer, size_t length, u8 lr)
 {
 	if (length > OPAL_UID_LENGTH) {
-		pr_debug("Can't build locking range user, Length OOB\n");
+		pr_debug("Can't build locking range user. Length OOB\n");
 		return -ERANGE;
 	}
 
@@ -1324,6 +1323,7 @@ static int start_SIDASP_opal_session(struct opal_dev *dev, void *data)
 
 	if (!key) {
 		const struct opal_key *okey = data;
+
 		ret = start_generic_opal_session(dev, OPAL_SID_UID,
 						 OPAL_ADMINSP_UID,
 						 okey->key,
@@ -1341,6 +1341,7 @@ static int start_SIDASP_opal_session(struct opal_dev *dev, void *data)
 static int start_admin1LSP_opal_session(struct opal_dev *dev, void *data)
 {
 	struct opal_key *key = data;
+
 	return start_generic_opal_session(dev, OPAL_ADMIN1_UID,
 					  OPAL_LOCKINGSP_UID,
 					  key->key, key->key_len);
@@ -1714,7 +1715,7 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 		write_locked = 0;
 		break;
 	case OPAL_LK:
-		/* vars are initalized to locked */
+		/* vars are initialized to locked */
 		break;
 	default:
 		pr_debug("Tried to set an invalid locking state... returning to uland\n");
@@ -1775,7 +1776,7 @@ static int lock_unlock_locking_range_sum(struct opal_dev *dev, void *data)
 		write_locked = 0;
 		break;
 	case OPAL_LK:
-		/* vars are initalized to locked */
+		/* vars are initialized to locked */
 		break;
 	default:
 		pr_debug("Tried to set an invalid locking state.\n");
@@ -1854,7 +1855,7 @@ static int get_lsp_lifecycle_cont(struct opal_dev *dev)
 		return error;
 
 	lc_status = response_get_u64(&dev->parsed, 4);
-	/* 0x08 is Manufacured Inactive */
+	/* 0x08 is Manufactured Inactive */
 	/* 0x09 is Manufactured */
 	if (lc_status != OPAL_MANUFACTURED_INACTIVE) {
 		pr_debug("Couldn't determine the status of the Lifecycle state\n");
@@ -2225,7 +2226,7 @@ static int __opal_lock_unlock(struct opal_dev *dev,
 static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 {
 	u8 mbr_done_tf = OPAL_TRUE;
-	const struct opal_step mbrdone_step [] = {
+	const struct opal_step mbrdone_step[] = {
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, key },
 		{ set_mbr_done, &mbr_done_tf },
@@ -2276,7 +2277,8 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 	return ret;
 }
 
-static int opal_activate_lsp(struct opal_dev *dev, struct opal_lr_act *opal_lr_act)
+static int opal_activate_lsp(struct opal_dev *dev,
+			     struct opal_lr_act *opal_lr_act)
 {
 	const struct opal_step active_steps[] = {
 		{ opal_discovery0, },
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 627624d35030..e092e124dd16 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -58,7 +58,7 @@ struct opal_key {
 struct opal_lr_act {
 	struct opal_key key;
 	__u32 sum;
-	__u8    num_lrs;
+	__u8 num_lrs;
 	__u8 lr[OPAL_MAX_LRS];
 	__u8 align[2]; /* Align to 8 byte boundary */
 };
-- 
2.20.1


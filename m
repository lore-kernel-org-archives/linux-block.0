Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E86CC432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C74420672
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 16:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKVQTm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:19:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:33453 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKVQTm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 11:19:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 08:19:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="219511381"
Received: from unknown (HELO linux-machine.lm.intel.com) ([10.232.117.69])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2019 08:19:41 -0800
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH] block: sed-opal: Cleanup trivial patch
Date:   Fri, 22 Nov 2019 09:18:54 -0700
Message-Id: <20191122161854.70939-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch aims at line length and trivial cleanups for
sed-opal code reported by checkpatch script.

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/opal_proto.h |  2 +-
 block/sed-opal.c   | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 325cbba2465f..6b75018dd4b3 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -404,7 +404,7 @@ struct d0_single_user_mode {
 };
 
 /*
- * Additonal Datastores feature
+ * Additional Datastores feature
  *
  * code == 0x0202
  */
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 880cc57a5f6b..8da8ef866f36 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -142,9 +142,9 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 	[OPAL_MBR] =
 		{ 0x00, 0x00, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00 },
 	[OPAL_AUTHORITY_TABLE] =
-		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00},
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00 },
 	[OPAL_C_PIN_TABLE] =
-		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x00},
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x00 },
 	[OPAL_LOCKING_INFO_TABLE] =
 		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_ENTERPRISE_LOCKING_INFO_TABLE] =
@@ -154,11 +154,11 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 
 	/* C_PIN_TABLE object ID's */
 	[OPAL_C_PIN_MSID] =
-		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02},
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02 },
 	[OPAL_C_PIN_SID] =
-		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x01},
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_C_PIN_ADMIN1] =
-		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x01, 0x00, 0x01},
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x01, 0x00, 0x01 },
 
 	/* half UID's (only first 4 bytes used) */
 	[OPAL_HALF_UID_AUTHORITY_OBJ_REF] =
@@ -168,7 +168,7 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 
 	/* special value for omitted optional parameter */
 	[OPAL_UID_HEXFF] =
-		{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+		{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
 };
 
 /*
@@ -1904,7 +1904,8 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 		add_token_bytestring(&err, dev, user_lr, OPAL_UID_LENGTH);
 		for (i = 1; i < opal_act->num_lrs; i++) {
 			user_lr[7] = opal_act->lr[i];
-			add_token_bytestring(&err, dev, user_lr, OPAL_UID_LENGTH);
+			add_token_bytestring(&err, dev, user_lr,
+					     OPAL_UID_LENGTH);
 		}
 		add_token_u8(&err, dev, OPAL_ENDLIST);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
@@ -2161,7 +2162,7 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 EXPORT_SYMBOL(init_opal_dev);
 
 static int opal_secure_erase_locking_range(struct opal_dev *dev,
-					   struct opal_session_info *opal_session)
+					struct opal_session_info *opal_session)
 {
 	const struct opal_step erase_steps[] = {
 		{ start_auth_opal_session, opal_session },
@@ -2327,7 +2328,8 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 	return ret;
 }
 
-static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal, bool psid)
+static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal,
+			   bool psid)
 {
 	/* controller will terminate session */
 	const struct opal_step revert_steps[] = {
@@ -2547,7 +2549,8 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 		}
 
 		if (dev->mbr_enabled) {
-			ret = __opal_set_mbr_done(dev, &suspend->unlk.session.opal_key);
+			ret = __opal_set_mbr_done(dev,
+					      &suspend->unlk.session.opal_key);
 			if (ret)
 				pr_debug("Failed to set MBR Done in S3 resume\n");
 		}
-- 
2.17.1


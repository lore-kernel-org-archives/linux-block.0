Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E9DECE59D
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 23:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C732067B
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 23:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfJOXAO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:00:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:53365 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbfJOXAN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 19:00:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 16:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,301,1566889200"; 
   d="scan'208";a="395700677"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by fmsmga005.fm.intel.com with ESMTP; 15 Oct 2019 16:00:12 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH v2 1/3] block: sed-opal: Expose enum opal_uid and opaluid
Date:   Tue, 15 Oct 2019 17:02:44 -0600
Message-Id: <20191015230246.10171-2-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015230246.10171-1-revanth.rajashekar@intel.com>
References: <20191015230246.10171-1-revanth.rajashekar@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch exposes UIDs to UAPI to allow userspace to use the
UIDs as IOCTL arguments.

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/opal_proto.h            |  39 ------------
 block/sed-opal.c              |  71 ----------------------
 include/uapi/linux/sed-opal.h | 110 ++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 5532412d567c..d6697fd4d178 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -76,49 +76,10 @@ enum opal_response_token {
  * Derived from: TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
  * Section: 6.3 Assigned UIDs
  */
-#define OPAL_UID_LENGTH 8
 #define OPAL_METHOD_LENGTH 8
 #define OPAL_MSID_KEYLEN 15
 #define OPAL_UID_LENGTH_HALF 4

-/* Enum to index OPALUID array */
-enum opal_uid {
-	/* users */
-	OPAL_SMUID_UID,
-	OPAL_THISSP_UID,
-	OPAL_ADMINSP_UID,
-	OPAL_LOCKINGSP_UID,
-	OPAL_ENTERPRISE_LOCKINGSP_UID,
-	OPAL_ANYBODY_UID,
-	OPAL_SID_UID,
-	OPAL_ADMIN1_UID,
-	OPAL_USER1_UID,
-	OPAL_USER2_UID,
-	OPAL_PSID_UID,
-	OPAL_ENTERPRISE_BANDMASTER0_UID,
-	OPAL_ENTERPRISE_ERASEMASTER_UID,
-	/* tables */
-	OPAL_TABLE_TABLE,
-	OPAL_LOCKINGRANGE_GLOBAL,
-	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
-	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
-	OPAL_MBRCONTROL,
-	OPAL_MBR,
-	OPAL_AUTHORITY_TABLE,
-	OPAL_C_PIN_TABLE,
-	OPAL_LOCKING_INFO_TABLE,
-	OPAL_ENTERPRISE_LOCKING_INFO_TABLE,
-	/* C_PIN_TABLE object ID's */
-	OPAL_C_PIN_MSID,
-	OPAL_C_PIN_SID,
-	OPAL_C_PIN_ADMIN1,
-	/* half UID's (only first 4 bytes used) */
-	OPAL_HALF_UID_AUTHORITY_OBJ_REF,
-	OPAL_HALF_UID_BOOLEAN_ACE,
-	/* omitted optional parameter */
-	OPAL_UID_HEXFF,
-};
-
 /* Enum for indexing the OPALMETHOD array */
 enum opal_method {
 	OPAL_PROPERTIES,
diff --git a/block/sed-opal.c b/block/sed-opal.c
index b4c761973ac1..e3e8d41d86fa 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -98,77 +98,6 @@ struct opal_dev {
 	struct list_head unlk_lst;
 };

-
-static const u8 opaluid[][OPAL_UID_LENGTH] = {
-	/* users */
-	[OPAL_SMUID_UID] =
-		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff },
-	[OPAL_THISSP_UID] =
-		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 },
-	[OPAL_ADMINSP_UID] =
-		{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00, 0x01 },
-	[OPAL_LOCKINGSP_UID] =
-		{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00, 0x02 },
-	[OPAL_ENTERPRISE_LOCKINGSP_UID] =
-		{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x01, 0x00, 0x01 },
-	[OPAL_ANYBODY_UID] =
-		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x01 },
-	[OPAL_SID_UID] =
-		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x06 },
-	[OPAL_ADMIN1_UID] =
-		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x01, 0x00, 0x01 },
-	[OPAL_USER1_UID] =
-		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x03, 0x00, 0x01 },
-	[OPAL_USER2_UID] =
-		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x03, 0x00, 0x02 },
-	[OPAL_PSID_UID] =
-		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x01, 0xff, 0x01 },
-	[OPAL_ENTERPRISE_BANDMASTER0_UID] =
-		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x80, 0x01 },
-	[OPAL_ENTERPRISE_ERASEMASTER_UID] =
-		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x84, 0x01 },
-
-	/* tables */
-	[OPAL_TABLE_TABLE] =
-		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01 },
-	[OPAL_LOCKINGRANGE_GLOBAL] =
-		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 },
-	[OPAL_LOCKINGRANGE_ACE_RDLOCKED] =
-		{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE0, 0x01 },
-	[OPAL_LOCKINGRANGE_ACE_WRLOCKED] =
-		{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE8, 0x01 },
-	[OPAL_MBRCONTROL] =
-		{ 0x00, 0x00, 0x08, 0x03, 0x00, 0x00, 0x00, 0x01 },
-	[OPAL_MBR] =
-		{ 0x00, 0x00, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00 },
-	[OPAL_AUTHORITY_TABLE] =
-		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00},
-	[OPAL_C_PIN_TABLE] =
-		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x00},
-	[OPAL_LOCKING_INFO_TABLE] =
-		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x01 },
-	[OPAL_ENTERPRISE_LOCKING_INFO_TABLE] =
-		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 },
-
-	/* C_PIN_TABLE object ID's */
-	[OPAL_C_PIN_MSID] =
-		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02},
-	[OPAL_C_PIN_SID] =
-		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x01},
-	[OPAL_C_PIN_ADMIN1] =
-		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x01, 0x00, 0x01},
-
-	/* half UID's (only first 4 bytes used) */
-	[OPAL_HALF_UID_AUTHORITY_OBJ_REF] =
-		{ 0x00, 0x00, 0x0C, 0x05, 0xff, 0xff, 0xff, 0xff },
-	[OPAL_HALF_UID_BOOLEAN_ACE] =
-		{ 0x00, 0x00, 0x04, 0x0E, 0xff, 0xff, 0xff, 0xff },
-
-	/* special value for omitted optional parameter */
-	[OPAL_UID_HEXFF] =
-		{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
-};
-
 /*
  * TCG Storage SSC Methods.
  * Derived from: TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index c6d035fa1b6c..068c77d6095a 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -38,6 +38,116 @@ enum opal_user {
 	OPAL_USER9 = 0x09,
 };

+/* Enum to index OPALUID array */
+enum opal_uid {
+	/* users */
+	OPAL_SMUID_UID,
+	OPAL_THISSP_UID,
+	OPAL_ADMINSP_UID,
+	OPAL_LOCKINGSP_UID,
+	OPAL_ENTERPRISE_LOCKINGSP_UID,
+	OPAL_ANYBODY_UID,
+	OPAL_SID_UID,
+	OPAL_ADMIN1_UID,
+	OPAL_USER1_UID,
+	OPAL_USER2_UID,
+	OPAL_PSID_UID,
+	OPAL_ENTERPRISE_BANDMASTER0_UID,
+	OPAL_ENTERPRISE_ERASEMASTER_UID,
+	/* tables */
+	OPAL_TABLE_TABLE,
+	OPAL_LOCKINGRANGE_GLOBAL,
+	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
+	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
+	OPAL_MBRCONTROL,
+	OPAL_MBR,
+	OPAL_AUTHORITY_TABLE,
+	OPAL_C_PIN_TABLE,
+	OPAL_LOCKING_INFO_TABLE,
+	OPAL_ENTERPRISE_LOCKING_INFO_TABLE,
+	/* C_PIN_TABLE object ID's */
+	OPAL_C_PIN_MSID,
+	OPAL_C_PIN_SID,
+	OPAL_C_PIN_ADMIN1,
+	/* half UID's (only first 4 bytes used) */
+	OPAL_HALF_UID_AUTHORITY_OBJ_REF,
+	OPAL_HALF_UID_BOOLEAN_ACE,
+	/* omitted optional parameter */
+	OPAL_UID_HEXFF,
+};
+
+#define OPAL_UID_LENGTH 8
+
+static const u8 opaluid[][OPAL_UID_LENGTH] = {
+	/* users */
+	[OPAL_SMUID_UID] =
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff },
+	[OPAL_THISSP_UID] =
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_ADMINSP_UID] =
+		{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_LOCKINGSP_UID] =
+		{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00, 0x02 },
+	[OPAL_ENTERPRISE_LOCKINGSP_UID] =
+		{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x01, 0x00, 0x01 },
+	[OPAL_ANYBODY_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_SID_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x06 },
+	[OPAL_ADMIN1_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x01, 0x00, 0x01 },
+	[OPAL_USER1_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x03, 0x00, 0x01 },
+	[OPAL_USER2_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x03, 0x00, 0x02 },
+	[OPAL_PSID_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x01, 0xff, 0x01 },
+	[OPAL_ENTERPRISE_BANDMASTER0_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x80, 0x01 },
+	[OPAL_ENTERPRISE_ERASEMASTER_UID] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x84, 0x01 },
+
+	/* tables */
+	[OPAL_TABLE_TABLE] =
+		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_LOCKINGRANGE_GLOBAL] =
+		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_LOCKINGRANGE_ACE_RDLOCKED] =
+		{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE0, 0x01 },
+	[OPAL_LOCKINGRANGE_ACE_WRLOCKED] =
+		{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE8, 0x01 },
+	[OPAL_MBRCONTROL] =
+		{ 0x00, 0x00, 0x08, 0x03, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_MBR] =
+		{ 0x00, 0x00, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00 },
+	[OPAL_AUTHORITY_TABLE] =
+		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00},
+	[OPAL_C_PIN_TABLE] =
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x00},
+	[OPAL_LOCKING_INFO_TABLE] =
+		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_ENTERPRISE_LOCKING_INFO_TABLE] =
+		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 },
+
+	/* C_PIN_TABLE object ID's */
+	[OPAL_C_PIN_MSID] =
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02},
+	[OPAL_C_PIN_SID] =
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x01},
+	[OPAL_C_PIN_ADMIN1] =
+		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x01, 0x00, 0x01},
+
+	/* half UID's (only first 4 bytes used) */
+	[OPAL_HALF_UID_AUTHORITY_OBJ_REF] =
+		{ 0x00, 0x00, 0x0C, 0x05, 0xff, 0xff, 0xff, 0xff },
+	[OPAL_HALF_UID_BOOLEAN_ACE] =
+		{ 0x00, 0x00, 0x04, 0x0E, 0xff, 0xff, 0xff, 0xff },
+
+	/* special value for omitted optional parameter */
+	[OPAL_UID_HEXFF] =
+		{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+};
+
 enum opal_lock_state {
 	OPAL_RO = 0x01, /* 0001 */
 	OPAL_RW = 0x02, /* 0010 */
--
2.17.1


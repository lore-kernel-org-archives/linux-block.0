Return-Path: <SRS0=SW/x=55=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676EBC2BA2B
	for <linux-block@archiver.kernel.org>; Mon, 13 Apr 2020 23:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CD5206DA
	for <linux-block@archiver.kernel.org>; Mon, 13 Apr 2020 23:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389966AbgDMXNx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Apr 2020 19:13:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:37165 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389929AbgDMXNw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Apr 2020 19:13:52 -0400
IronPort-SDR: Ge/f0QwmpveczHOmmENzg6YO8F4jEjD+KOdebaTTisN4R0Z+InI6l4EjT8g6L++GqjK29gii7I
 0fPmmo1NYAaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 16:13:51 -0700
IronPort-SDR: lD4iG5Obl61CJo+2Yxn1SoKG3LQ4OjlUf8fdQ9MM5wYUgTBMwtTU38d/jyWPdr+n7BgO2DiZUn
 jEZNn+N/m1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="253025102"
Received: from unknown (HELO linux-machine.lm.intel.com) ([10.232.116.103])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2020 16:13:51 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        =?UTF-8?q?Andrzej=20Jakowski=C2=BB?= <andrzej.jakowski@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH] block: sed-opal: Implement RevertSP IOCTL
Date:   Mon, 13 Apr 2020 17:11:21 -0600
Message-Id: <20200413231121.8207-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch implements an ioctl for Reverting SP functionality.
RevertSP fucntionality can be used under scenarios where user
data shall not be erased after TPer reverting.

The pacth adds a new optional parameter 'keep_glbl_rn_key' to opal_key struct.
If the optional parameter, keep_glbl_rn_key(KeepGlobalRangeKey),is provided
with a value of TRUE, then the media encryption key associated with
Locking_GlobalRange is preserved. Else, all user data is cryptographically
erased.

Test Scenarios:
RevertSP(keep_glbl_rn_key = true)  + RevertTper => Data is retained
RevertSP(keep_glbl_rn_key = false) + RevertTper => Data is erased
RevertSP(no keep_glbl_rn_key)      + RevertTper => Data is erased

Reference:
1. Section 5.1.3 of https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_SSC_v2.01_rev1.00.pdf
2. Section 3.2.12.2 of https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Opal_SSC_Application_Note_1-00_1-00-Final.pdf

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/opal_proto.h            |  6 ++++
 block/sed-opal.c              | 52 +++++++++++++++++++++++++++++++----
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  4 ++-
 4 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index b486b3ec7dc4..8c6faa418ab4 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -140,6 +140,12 @@ enum opal_method {
 	OPAL_ERASE,
 };

+enum opal_revert_method {
+	OPAL_REVERT_TPER,
+	OPAL_REVERT_PSID,
+	OPAL_REVERT_SP,
+};
+
 enum opal_token {
 	/* Boolean */
 	OPAL_TRUE = 0x01,
diff --git a/block/sed-opal.c b/block/sed-opal.c
index daafadbb88ca..1939df83c45e 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1552,6 +1552,28 @@ static int revert_tper(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }

+static int revert_sp(struct opal_dev *dev, void *data)
+{
+	int err;
+	struct opal_key *key = data;
+
+	err = cmd_start(dev, opaluid[OPAL_THISSP_UID],
+			opalmethod[OPAL_REVERTSP]);
+
+	add_token_u8(&err, dev, OPAL_STARTNAME);
+	add_token_u64(&err, dev, OPAL_SUM_SET_LIST);
+
+	/*
+	 * If KeepGlobalRangeKey is true, then the media encryption key
+	 * associated with Locking_GlobalRange is preserved.
+	 * If not true, then all user data is cryptographically erased.
+	 */
+	add_token_u8(&err, dev, key->keep_glbl_rn_key ? OPAL_TRUE : OPAL_FALSE);
+	add_token_u8(&err, dev, OPAL_ENDNAME);
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
 static int internal_activate_user(struct opal_dev *dev, void *data)
 {
 	struct opal_session_info *session = data;
@@ -2327,7 +2349,8 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 	return ret;
 }

-static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal, bool psid)
+static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal,
+			   enum opal_revert_method revert_type)
 {
 	/* controller will terminate session */
 	const struct opal_step revert_steps[] = {
@@ -2338,17 +2361,33 @@ static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal, bool psi
 		{ start_PSID_opal_session, opal },
 		{ revert_tper, }
 	};
+	const struct opal_step revertsp_steps[] = {
+		{ start_admin1LSP_opal_session, opal },
+		{ revert_sp, opal }
+	};

 	int ret;

 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	if (psid)
+	switch (revert_type) {
+	case OPAL_REVERT_PSID:
 		ret = execute_steps(dev, psid_revert_steps,
 				    ARRAY_SIZE(psid_revert_steps));
-	else
+		break;
+	case OPAL_REVERT_TPER:
 		ret = execute_steps(dev, revert_steps,
 				    ARRAY_SIZE(revert_steps));
+		break;
+	case OPAL_REVERT_SP:
+		ret = execute_steps(dev, revertsp_steps,
+				    ARRAY_SIZE(revertsp_steps));
+		break;
+	default:
+		pr_debug("Invalid revert type\n");
+		ret = -EINVAL;
+		break;
+	}
 	mutex_unlock(&dev->dev_lock);

 	/*
@@ -2656,7 +2695,7 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 		ret = opal_activate_user(dev, p);
 		break;
 	case IOC_OPAL_REVERT_TPR:
-		ret = opal_reverttper(dev, p, false);
+		ret = opal_reverttper(dev, p, OPAL_REVERT_TPER);
 		break;
 	case IOC_OPAL_LR_SETUP:
 		ret = opal_setup_locking_range(dev, p);
@@ -2680,11 +2719,14 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 		ret = opal_secure_erase_locking_range(dev, p);
 		break;
 	case IOC_OPAL_PSID_REVERT_TPR:
-		ret = opal_reverttper(dev, p, true);
+		ret = opal_reverttper(dev, p, OPAL_REVERT_PSID);
 		break;
 	case IOC_OPAL_GENERIC_TABLE_RW:
 		ret = opal_generic_read_write_table(dev, p);
 		break;
+	case IOC_OPAL_REVERT_SP:
+		ret = opal_reverttper(dev, p, OPAL_REVERT_SP);
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 1ac0d712a9c3..85ad7bb7da41 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -43,6 +43,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_MBR_DONE:
 	case IOC_OPAL_WRITE_SHADOW_MBR:
 	case IOC_OPAL_GENERIC_TABLE_RW:
+	case IOC_OPAL_REVERT_SP:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 6f5af1a84213..ac59fbc1d06b 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -47,7 +47,8 @@ enum opal_lock_state {
 struct opal_key {
 	__u8 lr;
 	__u8 key_len;
-	__u8 __align[6];
+	__u8 keep_glbl_rn_key;
+	__u8 __align[5];
 	__u8 key[OPAL_KEY_MAX];
 };

@@ -148,5 +149,6 @@ struct opal_read_write_table {
 #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
 #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
 #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
+#define IOC_OPAL_REVERT_SP          _IOW('p', 236, struct opal_key)

 #endif /* _UAPI_SED_OPAL_H */
--
2.17.1


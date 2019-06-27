Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A5C4321A
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 22:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9058B2063F
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 22:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfF0W2u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:28:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:12615 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfF0W2u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 18:28:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 15:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,425,1557212400"; 
   d="scan'208";a="361315641"
Received: from revanth-x299-aorus-gaming-3-pro.lm.intel.com ([10.232.116.91])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2019 15:28:49 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH] block: sed-opal: PSID reverttper capability
Date:   Thu, 27 Jun 2019 16:30:02 -0600
Message-Id: <20190627223002.8094-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PSID is a 32 character password printed on the drive label,
to prove its physical access. This PSID reverttper function
is very useful to regain the control over the drive when it
is locked and the user can no longer access it because of some
failures. However, *all the data on the drive is completely
erased*. This method is advisable only when the user is exhausted
of all other recovery methods.

PSID capabilities are described in:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_Feature_Set_PSID_v1.00_r1.00.pdf

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/sed-opal.c              | 33 +++++++++++++++++++++++++++++----
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  1 +
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index a46e8d13e16d..bb8ef7963d11 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1307,6 +1307,7 @@ static int start_generic_opal_session(struct opal_dev *dev,
 		break;
 	case OPAL_ADMIN1_UID:
 	case OPAL_SID_UID:
+	case OPAL_PSID_UID:
 		add_token_u8(&err, dev, OPAL_STARTNAME);
 		add_token_u8(&err, dev, 0); /* HostChallenge */
 		add_token_bytestring(&err, dev, key, key_len);
@@ -1367,6 +1368,16 @@ static int start_admin1LSP_opal_session(struct opal_dev *dev, void *data)
 					  key->key, key->key_len);
 }

+static int start_PSID_opal_session(struct opal_dev *dev, void *data)
+{
+	const struct opal_key *okey = data;
+
+	return start_generic_opal_session(dev, OPAL_PSID_UID,
+					  OPAL_ADMINSP_UID,
+					  okey->key,
+					  okey->key_len);
+}
+
 static int start_auth_opal_session(struct opal_dev *dev, void *data)
 {
 	struct opal_session_info *session = data;
@@ -2030,17 +2041,28 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 	return ret;
 }

-static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
+static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal, bool psid)
 {
+	/* controller will terminate session */
 	const struct opal_step revert_steps[] = {
 		{ start_SIDASP_opal_session, opal },
-		{ revert_tper, } /* controller will terminate session */
+		{ revert_tper, }
 	};
+	const struct opal_step psid_revert_steps[] = {
+		{ start_PSID_opal_session, opal },
+		{ revert_tper, }
+	};
+
 	int ret;

 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = execute_steps(dev, revert_steps, ARRAY_SIZE(revert_steps));
+	if (psid)
+		ret = execute_steps(dev, psid_revert_steps,
+				    ARRAY_SIZE(psid_revert_steps));
+	else
+		ret = execute_steps(dev, revert_steps,
+				    ARRAY_SIZE(revert_steps));
 	mutex_unlock(&dev->dev_lock);

 	/*
@@ -2280,7 +2302,7 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 		ret = opal_activate_user(dev, p);
 		break;
 	case IOC_OPAL_REVERT_TPR:
-		ret = opal_reverttper(dev, p);
+		ret = opal_reverttper(dev, p, false);
 		break;
 	case IOC_OPAL_LR_SETUP:
 		ret = opal_setup_locking_range(dev, p);
@@ -2297,6 +2319,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_SECURE_ERASE_LR:
 		ret = opal_secure_erase_locking_range(dev, p);
 		break;
+	case IOC_OPAL_PSID_REVERT_TPR:
+		ret = opal_reverttper(dev, p, true);
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 3e76b6d7d97f..f03bbffd3281 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -39,6 +39,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_ENABLE_DISABLE_MBR:
 	case IOC_OPAL_ERASE_LR:
 	case IOC_OPAL_SECURE_ERASE_LR:
+	case IOC_OPAL_PSID_REVERT_TPR:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 33e53b80cd1f..7a03e5b4df6e 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -107,5 +107,6 @@ struct opal_mbr_data {
 #define IOC_OPAL_ENABLE_DISABLE_MBR _IOW('p', 229, struct opal_mbr_data)
 #define IOC_OPAL_ERASE_LR           _IOW('p', 230, struct opal_session_info)
 #define IOC_OPAL_SECURE_ERASE_LR    _IOW('p', 231, struct opal_session_info)
+#define IOC_OPAL_PSID_REVERT_TPR    _IOW('p', 232, struct opal_key)

 #endif /* _UAPI_SED_OPAL_H */
--
2.17.1


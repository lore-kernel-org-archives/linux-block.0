Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136F8C282DA
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 20:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B51218AF
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 20:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="J2slrDUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfBAUvm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:51:42 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:33810 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbfBAUvl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 15:51:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 89CD2AD13F;
        Fri,  1 Feb 2019 21:51:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549054299; i=@fjfi.cvut.cz;
        bh=mpS2jFxkjw3h1uFS0n9dMbrTC1cyGakeTQAXErAuyGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=J2slrDUG4XnmZl5zKuk1HoYltbYlJGtbr+tK8MEAjRmPHiO7DLy5YGDxMP+mY9sPm
         LidRwcd1QXdNeDU6NJ27HuCwxIHulMKEWIv1oAkpFR7xyzZTGLLL6nfYOhgOlawdZp
         dXljMorq/u/NVeQeK8m0b7Tdp968E0nJo6LgZucI=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id UbJu48C-dS6K; Fri,  1 Feb 2019 21:51:34 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id CE68EAD125;
        Fri,  1 Feb 2019 21:50:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz CE68EAD125
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id A66946004E; Fri,  1 Feb 2019 21:50:52 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH v4 10/16] block: sed-opal: add ioctl for done-mark of shadow mbr
Date:   Fri,  1 Feb 2019 21:50:17 +0100
Message-Id: <1549054223-12220-11-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Enable users to mark the shadow mbr as done without completely
deactivating the shadow mbr feature. This may be useful on reboots,
when the power to the disk is not disconnected in between and the shadow
mbr stores the required boot files. Of course, this saves also the
(few) commands required to enable the feature if it is already enabled
and one only wants to mark the shadow mbr as done.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
---
 block/sed-opal.c              | 33 +++++++++++++++++++++++++++++++--
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 4b0a63b9d7c9..e03838cfd31b 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1996,13 +1996,39 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 					  struct opal_mbr_data *opal_mbr)
 {
+	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
+		? OPAL_TRUE : OPAL_FALSE;
 	const struct opal_step mbr_steps[] = {
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
-		{ set_mbr_done, &opal_mbr->enable_disable },
+		{ set_mbr_done, &token },
 		{ end_opal_session, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
-		{ set_mbr_enable_disable, &opal_mbr->enable_disable },
+		{ set_mbr_enable_disable, &token },
+		{ end_opal_session, },
+		{ NULL, }
+	};
+	int ret;
+
+	if (opal_mbr->enable_disable != OPAL_MBR_ENABLE &&
+	    opal_mbr->enable_disable != OPAL_MBR_DISABLE)
+		return -EINVAL;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, mbr_steps);
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_mbr_status(struct opal_dev *dev, struct opal_mbr_data *opal_mbr)
+{
+	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
+		? OPAL_TRUE : OPAL_FALSE;
+	const struct opal_step mbr_steps[] = {
+		{ opal_discovery0, },
+		{ start_admin1LSP_opal_session, &opal_mbr->key },
+		{ set_mbr_done, &token },
 		{ end_opal_session, },
 		{ NULL, }
 	};
@@ -2349,6 +2375,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_ENABLE_DISABLE_MBR:
 		ret = opal_enable_disable_shadow_mbr(dev, p);
 		break;
+	case IOC_OPAL_MBR_STATUS:
+		ret = opal_mbr_status(dev, p);
+		break;
 	case IOC_OPAL_ERASE_LR:
 		ret = opal_erase_locking_range(dev, p);
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 04b124fca51e..b38dc602cae3 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -47,6 +47,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_ENABLE_DISABLE_MBR:
 	case IOC_OPAL_ERASE_LR:
 	case IOC_OPAL_SECURE_ERASE_LR:
+	case IOC_OPAL_MBR_STATUS:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 627624d35030..0cb9890cdc04 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -116,5 +116,6 @@ struct opal_mbr_data {
 #define IOC_OPAL_ENABLE_DISABLE_MBR _IOW('p', 229, struct opal_mbr_data)
 #define IOC_OPAL_ERASE_LR           _IOW('p', 230, struct opal_session_info)
 #define IOC_OPAL_SECURE_ERASE_LR    _IOW('p', 231, struct opal_session_info)
+#define IOC_OPAL_MBR_STATUS         _IOW('p', 232, struct opal_mbr_data)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.20.1


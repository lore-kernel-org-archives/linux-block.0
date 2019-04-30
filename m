Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97623C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 23:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270D52177B
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 23:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="OWW4MOfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfD3Xa6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 19:30:58 -0400
Received: from mailgw2.fjfi.cvut.cz ([147.32.9.131]:59470 "EHLO
        mailgw2.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfD3Xa6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 19:30:58 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2019 19:30:56 EDT
Received: from localhost (localhost [127.0.0.1])
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTP id DF98BA02BC;
        Wed,  1 May 2019 01:21:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1556666464; i=@fjfi.cvut.cz;
        bh=wk0H6UjZ3ZRLgaB+qQbvaTPB8cjejRZ9ZwlWfLnZ2vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OWW4MOfYYWRUrkN/PQlhZc35TYGYPqsBqBbYF/U2ZeOR8YZWlFSHR9S9YLLQRrFc2
         8ty/QItxthh0Cf2WC/1qlddnqYjH4p8jCSP6V3HVZAFfS7INVFbJjb+PXWUf/YqdKV
         PpTMToMJXvOBOeB7/OqbtXpVSxchlWfDmAlv5pYs=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw2.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw2.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id hkAN_t-_uT0y; Wed,  1 May 2019 01:21:00 +0200 (CEST)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTPS id 906D7A02AE;
        Wed,  1 May 2019 01:20:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw2.fjfi.cvut.cz 906D7A02AE
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 43C066002A; Wed,  1 May 2019 01:20:59 +0200 (CEST)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 1/3] block: sed-opal: add ioctl for done-mark of shadow mbr
Date:   Wed,  1 May 2019 01:20:57 +0200
Message-Id: <1556666459-17948-2-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
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

Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
---
 block/sed-opal.c              | 27 +++++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index b1aa0cc25803..f1eb9c18e335 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1986,6 +1986,30 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 	return ret;
 }
 
+static int opal_set_mbr_done(struct opal_dev *dev,
+			     struct opal_mbr_done *mbr_done)
+{
+	u8 mbr_done_tf = mbr_done->done_flag == OPAL_MBR_DONE ?
+		OPAL_TRUE : OPAL_FALSE;
+
+	const struct opal_step mbr_steps[] = {
+		{ start_admin1LSP_opal_session, &mbr_done->key },
+		{ set_mbr_done, &mbr_done_tf },
+		{ end_opal_session, }
+	};
+	int ret;
+
+	if (mbr_done->done_flag != OPAL_MBR_DONE &&
+	    mbr_done->done_flag != OPAL_MBR_NOT_DONE)
+		return -EINVAL;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
 static int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
 {
 	struct opal_suspend_data *suspend;
@@ -2299,6 +2323,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_ENABLE_DISABLE_MBR:
 		ret = opal_enable_disable_shadow_mbr(dev, p);
 		break;
+	case IOC_OPAL_MBR_DONE:
+		ret = opal_set_mbr_done(dev, p);
+		break;
 	case IOC_OPAL_ERASE_LR:
 		ret = opal_erase_locking_range(dev, p);
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 04b124fca51e..42b2ce5da7b3 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -47,6 +47,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_ENABLE_DISABLE_MBR:
 	case IOC_OPAL_ERASE_LR:
 	case IOC_OPAL_SECURE_ERASE_LR:
+	case IOC_OPAL_MBR_DONE:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index e092e124dd16..81dd0e8886a1 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -29,6 +29,11 @@ enum opal_mbr {
 	OPAL_MBR_DISABLE = 0x01,
 };
 
+enum opal_mbr_done_flag {
+	OPAL_MBR_NOT_DONE = 0x0,
+	OPAL_MBR_DONE = 0x01
+};
+
 enum opal_user {
 	OPAL_ADMIN1 = 0x0,
 	OPAL_USER1 = 0x01,
@@ -104,6 +109,12 @@ struct opal_mbr_data {
 	__u8 __align[7];
 };
 
+struct opal_mbr_done {
+	struct opal_key key;
+	__u8 done_flag;
+	__u8 __align[7];
+};
+
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -116,5 +127,6 @@ struct opal_mbr_data {
 #define IOC_OPAL_ENABLE_DISABLE_MBR _IOW('p', 229, struct opal_mbr_data)
 #define IOC_OPAL_ERASE_LR           _IOW('p', 230, struct opal_session_info)
 #define IOC_OPAL_SECURE_ERASE_LR    _IOW('p', 231, struct opal_session_info)
+#define IOC_OPAL_MBR_DONE           _IOW('p', 232, struct opal_mbr_done)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.20.1


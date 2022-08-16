Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1801C25B0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Aug 2022 14:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiHPOHW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiHPOHU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Aug 2022 10:07:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A4EAF48D
        for <linux-block@vger.kernel.org>; Tue, 16 Aug 2022 07:07:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a4so1041453wrq.1
        for <linux-block@vger.kernel.org>; Tue, 16 Aug 2022 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+LTOMzXw8v0ScwG6RsTU1mjk1haEuTJHtL6/3BbYL/8=;
        b=LEhb0B1Z6PlxTz+UF4FHtnTDmrlji03p0XiuItEjbwQ66Nys/cGG9Hxe2teIc2QmJD
         wQHh8UOYh4YSoc9OZPHj62UYtk0FbX/NT56IGTdFKG7ebGWEU0n4PmtvhoC7cGL3Vab0
         o2BQhqR574czYarnoBlYKtMAMxoJNHDtUtLfDIUJ9VICLnHmcWwk6+Yz3+q1Bw2FCMiQ
         zFRcznImtw0+LwwSugLncHaDIUbwPLq+V2drbZ+S0mwlDz84mpucDzV8XyApV6BdYVx8
         Ku/yFr4A9OMXPeycp8jsdTYn/i+KWdQ48ljW8E7oW87ZgQKzEnTADvt3g/VucLxoGw+B
         mjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+LTOMzXw8v0ScwG6RsTU1mjk1haEuTJHtL6/3BbYL/8=;
        b=RZAsp6pWRAb2ddJqeu67c/Y0NKrOvRNExB4HuvnYS2/U+xnLUDTAyrBiIlec4VVhjM
         16ikPfNZmrxKr1bOc2OxcimT1AZ3xe/ZxmJ4Wc7v0tv/FCAUjitwfIvnmij12JX5k6xQ
         bG9hOIaEgFpyG0MvYOmh3XpQF5zMd8tqVOJhm0bAOqVBhXWA+w8Cxv806W3KwTK3MnlG
         xs9vkW+woRguXXGOzq0tBYyq8bL/9wKw76nTDCHnijNtLBMTkvu+uIqlGv1NBeOXiCeR
         COVVffTIfQFRiSzkr8DyhN6uZuH9KWMoPIDQwz6x2AfkEkzDOqwF39VipMjCorqVG6a/
         QISA==
X-Gm-Message-State: ACgBeo0iliE9qVxJMlYsRbBorrZmQJiHvfXmXGgRqa7tIqHqJYweZmPs
        ZHKOdgOCPgaaM7X/7m+Hdg6OfuCCWcs=
X-Google-Smtp-Source: AA6agR56tSN5vlwj90U3Gy4UFSFZAiNmFLYBBTMytuZZXh2+QeXcYBgsy59ohy7Yab0iOMaDI9MCBw==
X-Received: by 2002:adf:d1e2:0:b0:223:611b:3f18 with SMTP id g2-20020adfd1e2000000b00223611b3f18mr11323506wrd.236.1660658837391;
        Tue, 16 Aug 2022 07:07:17 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d4e0e000000b0020fff0ea0a3sm10251773wrt.116.2022.08.16.07.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 07:07:16 -0700 (PDT)
From:   luca.boccassi@gmail.com
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jonathan.Derrick@solidigmtechnology.com,
        dougmill@linux.vnet.ibm.com, gmazyland@gmail.com, axboe@kernel.dk
Subject: [PATCH v7] block: sed-opal: Add ioctl to return device status
Date:   Tue, 16 Aug 2022 15:07:13 +0100
Message-Id: <20220816140713.84893-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>

Provide a mechanism to retrieve basic status information about
the device, including the "supported" flag indicating whether
SED-OPAL is supported. The information returned is from the various
feature descriptors received during the discovery0 step, and so
this ioctl does nothing more than perform the discovery0 step
and then save the information received. See "struct opal_status"
and OPAL_FL_* bits for the status information currently returned.

This is necessary to be able to check whether a device is OPAL
enabled, set up, locked or unlocked from userspace programs
like systemd-cryptsetup and libcryptsetup. Right now we just
have to assume the user 'knows' or blindly attempt setup/lock/unlock
operations.

Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
Tested-by: Luca Boccassi <bluca@debian.org>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
v3: resend on request, after rebasing and testing on my machine
    https://patchwork.kernel.org/project/linux-block/patch/20220125215248.6489-1-luca.boccassi@gmail.com/
v4: it's been more than 7 months and no alternative approach has appeared.
    we really need to be able to identify and query the status of a sed-opal
    device, so rebased and resending.
v5: as requested by reviewer, add __32 reserved to the UAPI ioctl struct to align to 64
    bits and to reserve space for future expansion
v6: as requested by reviewer, update commit message with use case
v7: as requested by reviewer, remove braces around single-line 'if'
    added received acked-by/reviewed-by tags

 block/opal_proto.h            |  5 ++
 block/sed-opal.c              | 89 ++++++++++++++++++++++++++++++-----
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h | 13 +++++
 4 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index b486b3ec7dc4..7152aa1f1a49 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -39,7 +39,12 @@ enum opal_response_token {
 #define FIRST_TPER_SESSION_NUM	4096
 
 #define TPER_SYNC_SUPPORTED 0x01
+/* FC_LOCKING features */
+#define LOCKING_SUPPORTED_MASK 0x01
+#define LOCKING_ENABLED_MASK 0x02
+#define LOCKED_MASK 0x04
 #define MBR_ENABLED_MASK 0x10
+#define MBR_DONE_MASK 0x20
 
 #define TINY_ATOM_DATA_MASK 0x3F
 #define TINY_ATOM_SIGNED 0x40
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9700197000f2..2c5327a0543a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -74,8 +74,7 @@ struct parsed_resp {
 };
 
 struct opal_dev {
-	bool supported;
-	bool mbr_enabled;
+	u32 flags;
 
 	void *data;
 	sec_send_recv *send_recv;
@@ -280,6 +279,30 @@ static bool check_tper(const void *data)
 	return true;
 }
 
+static bool check_lcksuppt(const void *data)
+{
+	const struct d0_locking_features *lfeat = data;
+	u8 sup_feat = lfeat->supported_features;
+
+	return !!(sup_feat & LOCKING_SUPPORTED_MASK);
+}
+
+static bool check_lckenabled(const void *data)
+{
+	const struct d0_locking_features *lfeat = data;
+	u8 sup_feat = lfeat->supported_features;
+
+	return !!(sup_feat & LOCKING_ENABLED_MASK);
+}
+
+static bool check_locked(const void *data)
+{
+	const struct d0_locking_features *lfeat = data;
+	u8 sup_feat = lfeat->supported_features;
+
+	return !!(sup_feat & LOCKED_MASK);
+}
+
 static bool check_mbrenabled(const void *data)
 {
 	const struct d0_locking_features *lfeat = data;
@@ -288,6 +311,14 @@ static bool check_mbrenabled(const void *data)
 	return !!(sup_feat & MBR_ENABLED_MASK);
 }
 
+static bool check_mbrdone(const void *data)
+{
+	const struct d0_locking_features *lfeat = data;
+	u8 sup_feat = lfeat->supported_features;
+
+	return !!(sup_feat & MBR_DONE_MASK);
+}
+
 static bool check_sum(const void *data)
 {
 	const struct d0_single_user_mode *sum = data;
@@ -435,7 +466,7 @@ static int opal_discovery0_end(struct opal_dev *dev)
 	u32 hlen = be32_to_cpu(hdr->length);
 
 	print_buffer(dev->resp, hlen);
-	dev->mbr_enabled = false;
+	dev->flags &= OPAL_FL_SUPPORTED;
 
 	if (hlen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
 		pr_debug("Discovery length overflows buffer (%zu+%u)/%u\n",
@@ -461,7 +492,16 @@ static int opal_discovery0_end(struct opal_dev *dev)
 			check_geometry(dev, body);
 			break;
 		case FC_LOCKING:
-			dev->mbr_enabled = check_mbrenabled(body->features);
+			if (check_lcksuppt(body->features))
+				dev->flags |= OPAL_FL_LOCKING_SUPPORTED;
+			if (check_lckenabled(body->features))
+				dev->flags |= OPAL_FL_LOCKING_ENABLED;
+			if (check_locked(body->features))
+				dev->flags |= OPAL_FL_LOCKED;
+			if (check_mbrenabled(body->features))
+				dev->flags |= OPAL_FL_MBR_ENABLED;
+			if (check_mbrdone(body->features))
+				dev->flags |= OPAL_FL_MBR_DONE;
 			break;
 		case FC_ENTERPRISE:
 		case FC_DATASTORE:
@@ -2109,7 +2149,8 @@ static int check_opal_support(struct opal_dev *dev)
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = opal_discovery0_step(dev);
-	dev->supported = !ret;
+	if (!ret)
+		dev->flags |= OPAL_FL_SUPPORTED;
 	mutex_unlock(&dev->dev_lock);
 
 	return ret;
@@ -2148,6 +2189,7 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 
 	INIT_LIST_HEAD(&dev->unlk_lst);
 	mutex_init(&dev->dev_lock);
+	dev->flags = 0;
 	dev->data = data;
 	dev->send_recv = send_recv;
 	if (check_opal_support(dev) != 0) {
@@ -2528,7 +2570,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 	if (!dev)
 		return false;
 
-	if (!dev->supported)
+	if (!(dev->flags & OPAL_FL_SUPPORTED))
 		return false;
 
 	mutex_lock(&dev->dev_lock);
@@ -2546,7 +2588,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 			was_failure = true;
 		}
 
-		if (dev->mbr_enabled) {
+		if (dev->flags & OPAL_FL_MBR_ENABLED) {
 			ret = __opal_set_mbr_done(dev, &suspend->unlk.session.opal_key);
 			if (ret)
 				pr_debug("Failed to set MBR Done in S3 resume\n");
@@ -2620,6 +2662,23 @@ static int opal_generic_read_write_table(struct opal_dev *dev,
 	return ret;
 }
 
+static int opal_get_status(struct opal_dev *dev, void __user *data)
+{
+	struct opal_status sts = {0};
+
+	/*
+	 * check_opal_support() error is not fatal,
+	 * !dev->supported is a valid condition
+	 */
+	if (!check_opal_support(dev))
+		sts.flags = dev->flags;
+	if (copy_to_user(data, &sts, sizeof(sts))) {
+		pr_debug("Error copying status to userspace\n");
+		return -EFAULT;
+	}
+	return 0;
+}
+
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 {
 	void *p;
@@ -2629,12 +2688,14 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 		return -EACCES;
 	if (!dev)
 		return -ENOTSUPP;
-	if (!dev->supported)
+	if (!(dev->flags & OPAL_FL_SUPPORTED))
 		return -ENOTSUPP;
 
-	p = memdup_user(arg, _IOC_SIZE(cmd));
-	if (IS_ERR(p))
-		return PTR_ERR(p);
+	if (cmd & IOC_IN) {
+		p = memdup_user(arg, _IOC_SIZE(cmd));
+		if (IS_ERR(p))
+			return PTR_ERR(p);
+	}
 
 	switch (cmd) {
 	case IOC_OPAL_SAVE:
@@ -2685,11 +2746,15 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_GENERIC_TABLE_RW:
 		ret = opal_generic_read_write_table(dev, p);
 		break;
+	case IOC_OPAL_GET_STATUS:
+		ret = opal_get_status(dev, arg);
+		break;
 	default:
 		break;
 	}
 
-	kfree(p);
+	if (cmd & IOC_IN)
+		kfree(p);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sed_ioctl);
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 1ac0d712a9c3..6f837bb6c715 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -43,6 +43,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_MBR_DONE:
 	case IOC_OPAL_WRITE_SHADOW_MBR:
 	case IOC_OPAL_GENERIC_TABLE_RW:
+	case IOC_OPAL_GET_STATUS:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 6f5af1a84213..2573772e2fb3 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -132,6 +132,18 @@ struct opal_read_write_table {
 	__u64 priv;
 };
 
+#define OPAL_FL_SUPPORTED		0x00000001
+#define OPAL_FL_LOCKING_SUPPORTED	0x00000002
+#define OPAL_FL_LOCKING_ENABLED		0x00000004
+#define OPAL_FL_LOCKED			0x00000008
+#define OPAL_FL_MBR_ENABLED		0x00000010
+#define OPAL_FL_MBR_DONE		0x00000020
+
+struct opal_status {
+	__u32 flags;
+	__u32 reserved;
+};
+
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -148,5 +160,6 @@ struct opal_read_write_table {
 #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
 #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
 #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
+#define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.34.1


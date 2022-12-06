Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2038C4708C
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 00:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiLFAEE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Dec 2022 19:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiLFAED (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Dec 2022 19:04:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F93B1901C
        for <linux-block@vger.kernel.org>; Mon,  5 Dec 2022 16:04:01 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso13120036wme.5
        for <linux-block@vger.kernel.org>; Mon, 05 Dec 2022 16:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPXjlFrf/YOtlGmi1wkEoafvRrz0ROX5u/OWMdpqmNY=;
        b=QHD/UdR6QYwBXYzunv/sIt6LIO/agVv4nEnBn3G+m5P4A9lMu/K2JjAsWew6B9JADg
         KfiOSaw+I87YUjfo6m6qrWp0xrZYphFtOSk/cwrohFzS+k0QourzW4lrIMcye1usJLLk
         troWsXE0b3el2pTj1RUjrYNGjaf8L3rRR7Cot93yoJeBIeAL0Ty3WVyxxPhuIxvwXI27
         2OUed3DhPjYxd9z1l7hd6OMvM7eIw7be4qpfddMLhdICicba3e6gIza5lXy/eIusBuHw
         tYzk6dNDCUVPMK+EYPKLd/5cazgEg1E4bpLo+n58sRhMTbGclnmTMLUlxkePZ8jJACR0
         UY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPXjlFrf/YOtlGmi1wkEoafvRrz0ROX5u/OWMdpqmNY=;
        b=U7I3KJiuyvX8u7E5bh9cTH2bPYfNyVaM/lqpkPhqVP+J+5Vf/uzO/rJyDLUVgTvOQ6
         NkSNQBtrpWzwEawYxSabMVYEafyFLFZmYBuSJUZiCa2qtzNA8u7b9v78U4zj0u06/R1h
         hHTeXvMIJtP1X/T22b+0mEcCXUUnRdIQV0B2SKK5NL7VnNqFyJxwOspu4Por8HKdmGSH
         eVwHtmfVSv6A7UzviVVkJ0FXCrcoz/8zHbEn0Qw4uxQALTEu6wzm4wRjNTn44zY4jGmk
         Cdxpe4oh0PgP/5bs5zIlF5vNSIYr1lyH8PXKz25Qpn2uM+yGW1RwqmY+5XhFeqnh+3z1
         Z0wA==
X-Gm-Message-State: ANoB5pmj6DXBJTV+y9rykble0jIqTWjP4Ki+uQNhWKG8chU3ttE7RwPu
        6ERkxe4OBqAdlI4oM5gcjj4deoAa4/U=
X-Google-Smtp-Source: AA0mqf4YLigbzDvmULBt0lvxQBT+YD2Z17f0DdawKkrF81L+xl5RaC1WMeMGBLanoFYu3G+/y5pYTA==
X-Received: by 2002:a05:600c:6545:b0:3cf:baef:e92a with SMTP id dn5-20020a05600c654500b003cfbaefe92amr48109453wmb.178.1670285039658;
        Mon, 05 Dec 2022 16:03:59 -0800 (PST)
Received: from localhost ([2a01:4b00:d307:1000:6f15:7230:d519:3286])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b00241e8d00b79sm18962228wrw.54.2022.12.05.16.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:03:59 -0800 (PST)
From:   luca.boccassi@gmail.com
To:     linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev, gmazyland@gmail.com, axboe@kernel.dk,
        brauner@kernel.org, stepan.horacek@gmail.com, hch@infradead.org
Subject: [PATCH v3] sed-opal: allow using IOC_OPAL_SAVE for locking too
Date:   Tue,  6 Dec 2022 00:03:46 +0000
Message-Id: <20221206000346.7465-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221202003610.100024-1-luca.boccassi@gmail.com>
References: <20221202003610.100024-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luca Boccassi <bluca@debian.org>

Usually when closing a crypto device (eg: dm-crypt with LUKS) the
volume key is not required, as it requires root privileges anyway, and
root can deny access to a disk in many ways regardless. Requiring the
volume key to lock the device is a peculiarity of the OPAL
specification.

Given we might already have saved the key if the user requested it via
the 'IOC_OPAL_SAVE' ioctl, we can use that key to lock the device if no
key was provided here and the locking range matches, and the user sets
the appropriate flag with 'IOC_OPAL_SAVE'. This allows integrating OPAL
with tools and libraries that are used to the common behaviour and do
not ask for the volume key when closing a device.

Callers can always pass a non-zero key and it will be used regardless,
as before.

Suggested-by: Štěpán Horáček <stepan.horacek@gmail.com>
Signed-off-by: Luca Boccassi <bluca@debian.org>
---
v3: split out static helper, switch from bitfield to flags field (leaving
    two bytes for future use, u16 should be enough for flags for this ioctl)

 block/sed-opal.c              | 39 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/sed-opal.h |  8 ++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9bdb833e5817..463873f61e01 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2461,6 +2461,44 @@ static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 	return execute_steps(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
 }
 
+static void opal_lock_check_for_saved_key(struct opal_dev *dev,
+			    struct opal_lock_unlock *lk_unlk)
+{
+	struct opal_suspend_data *iter;
+
+	if (lk_unlk->l_state != OPAL_LK ||
+			lk_unlk->session.opal_key.key_len > 0)
+		return;
+
+	/*
+	 * Usually when closing a crypto device (eg: dm-crypt with LUKS) the
+	 * volume key is not required, as it requires root privileges anyway,
+	 * and root can deny access to a disk in many ways regardless.
+	 * Requiring the volume key to lock the device is a peculiarity of the
+	 * OPAL specification. Given we might already have saved the key if
+	 * the user requested it via the 'IOC_OPAL_SAVE' ioctl, we can use
+	 * that key to lock the device if no key was provided here, the
+	 * locking range matches and the appropriate flag was passed with
+	 * 'IOC_OPAL_SAVE'.
+	 * This allows integrating OPAL with tools and libraries that are used
+	 * to the common behaviour and do not ask for the volume key when
+	 * closing a device.
+	 */
+	setup_opal_dev(dev);
+	list_for_each_entry(iter, &dev->unlk_lst, node) {
+		if ((iter->unlk.flags & OPAL_SAVE_FOR_LOCK) &&
+				iter->lr == lk_unlk->session.opal_key.lr &&
+				iter->unlk.session.opal_key.key_len > 0) {
+			lk_unlk->session.opal_key.key_len =
+				iter->unlk.session.opal_key.key_len;
+			memcpy(lk_unlk->session.opal_key.key,
+				iter->unlk.session.opal_key.key,
+				iter->unlk.session.opal_key.key_len);
+			break;
+		}
+	}
+}
+
 static int opal_lock_unlock(struct opal_dev *dev,
 			    struct opal_lock_unlock *lk_unlk)
 {
@@ -2470,6 +2508,7 @@ static int opal_lock_unlock(struct opal_dev *dev,
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
+	opal_lock_check_for_saved_key(dev, lk_unlk);
 	ret = __opal_lock_unlock(dev, lk_unlk);
 	mutex_unlock(&dev->dev_lock);
 
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 2573772e2fb3..1fed3c9294fc 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -44,6 +44,11 @@ enum opal_lock_state {
 	OPAL_LK = 0x04, /* 0100 */
 };
 
+enum opal_lock_flags {
+	/* IOC_OPAL_SAVE will also store the provided key for locking */
+	OPAL_SAVE_FOR_LOCK = 0x01,
+};
+
 struct opal_key {
 	__u8 lr;
 	__u8 key_len;
@@ -76,7 +81,8 @@ struct opal_user_lr_setup {
 struct opal_lock_unlock {
 	struct opal_session_info session;
 	__u32 l_state;
-	__u8 __align[4];
+	__u16 flags;
+	__u8 __align[2];
 };
 
 struct opal_new_pw {
-- 
2.35.1


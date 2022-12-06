Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96553C47090
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 09:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiLFJ3Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 04:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiLFJ3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 04:29:23 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A367C1CFDA
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 01:29:21 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y16so22600565wrm.2
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 01:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmTRt7YDs57sWJDVE7fhRVC9OoYTIqsOQpeQA08LOIs=;
        b=N4D2y9Hj/QPNn4zdlIwdjtcYwKpBuhy45yBtjEwOYjmh+xziCUXZYflvGEWH2BzN8e
         qDt9jEAGqtReBFN1lBKEZqqu4r/CFFzltUsE1iY9xMmhbn41yd5rOKygnY1z6jueZvux
         a+mDY/RcB0PAtHmmx3e5WUtrvAjCbtlc5PPQrlq/81/L7HpP4dAS9rhhmvj5BM5kcOtz
         3DRPXX7epJ+dYogKnJCBHZJIPIo5k5xDMlNBaIidbRHPWELN6SfiH5Zo7ECMcwET3E5q
         nVS8PW7rtQI5FDgR6ymvuyShqe1vUTkV43lJAICVSzTeeHedY9MDA8lghaJx4w6Xgp1h
         5kBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmTRt7YDs57sWJDVE7fhRVC9OoYTIqsOQpeQA08LOIs=;
        b=z4zK/PZIde+gK8kV6JanM6I6bepX0uU8OrgphQHIPogdiUvD1XGelLZ7ZUi1Awe957
         GxFwOwp5pVPeaaFWAgJmrLKWUisLYJiXB4XmzOYeoQUIY3mKqm2VllV0AmCMbpefifNb
         3xr5zWoMfsvJXRW+0QbTAIRBDQjjPg0dDOU8fKMz/qatBX49ojKZ+NRbva8a18hwBuhQ
         bjEqI7vUzRUrDjb1X5ub4JRq/tmqzAJefgxWQqsARzAmEs/cN9uJhWl2wy190gv/A+3f
         Ah36H+hMudY998Bhj14W065dY2r8DbU/Z0iM0l1dz/gMJS2XAx3VXWAOfmPC8boFaKfe
         rmNA==
X-Gm-Message-State: ANoB5pnXRp1stzDMPzoUCnASgUP3NKa+SZ33arAE6O65hjMCxd2DAYFt
        u5w8LXG7/oI6npCjLWsagtnt8aCez/c=
X-Google-Smtp-Source: AA0mqf4a0SKKJ7R5h/t+LW2njhnlRKOKvqADcAqQzOUseGA9rd3JiGeVDUsQwLIrHVE4jbCtvFy2DA==
X-Received: by 2002:a5d:4283:0:b0:242:55fd:2511 with SMTP id k3-20020a5d4283000000b0024255fd2511mr7513101wrq.7.1670318959669;
        Tue, 06 Dec 2022 01:29:19 -0800 (PST)
Received: from localhost ([2a01:4b00:d307:1000:6f15:7230:d519:3286])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c199100b003c7087f6c9asm25483601wmq.32.2022.12.06.01.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 01:29:19 -0800 (PST)
From:   luca.boccassi@gmail.com
To:     linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev, axboe@kernel.dk
Subject: [PATCH v4] sed-opal: allow using IOC_OPAL_SAVE for locking too
Date:   Tue,  6 Dec 2022 09:29:13 +0000
Message-Id: <20221206092913.4625-1-luca.boccassi@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v4: add reviewed-by tags, no other changes

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


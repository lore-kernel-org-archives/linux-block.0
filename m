Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4155CC4321E
	for <linux-block@archiver.kernel.org>; Sat,  3 Dec 2022 00:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiLCANA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 19:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiLCAM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 19:12:59 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174C21C41C
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 16:12:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w15so10232676wrl.9
        for <linux-block@vger.kernel.org>; Fri, 02 Dec 2022 16:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqICc+sLFTiAZysNz4hCIy/gO3TMGIefNrTwHR8Qsgg=;
        b=G6k1/H08waU2Tqt74B+F7sP8rZOrQR+GqCLfchoOwZDvBDAbFBAQzjjPOith7oWwJO
         lZDbiECxACHbzFXcwN3Iz44JE1Xw4ySf0jKC6F/oyspeF/XBxGNaNrTyW9+QY8RVuzp7
         bDmQY/aEQH8xalEURmTxJqGn6x9jMZaOOzTyCrPKgUrFZw5/owfvvezDBHnah6JMnR0o
         o2THIrYu8JCz4jmOsF0hMH6qDuR3/ctw7uUanjWin9ZjT0eHWdxkeKtnL5ANln8aJP+R
         G5QtsTo4WDQA/mBPgiHEigaKf54wUrJu+4Fts3PmJ34psBYH30zr9Y8XWgrcyEOsyl8v
         U5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqICc+sLFTiAZysNz4hCIy/gO3TMGIefNrTwHR8Qsgg=;
        b=ovbI7yTi+yuYZBak5/Dr4ruRTVXtutI3wo5U8/FjZaucou2/qJnSNaOkFNJqmq1KY4
         ZQDKyt2z4OkavcMOuWViVLTsSfZF8AXEufc/jeBdv2C5SiYeqN7b4yXLAZvffixKrfIX
         xYZ0emXyoJC3yZmxnC4T57RH3C7xuAd0kAPav4bPch/RIhVPoL0ioxAf/WFNW+3fttBL
         w6vilcdcViW5u6s/gqIMTGynpes6xrxjREi+Tzyle9rLGiHm9XvUJTKPOJwMJROGoiAG
         6ecjRI4cRSyQypBmXG+FplSrEOWUQllIuBeUK/WSXXxiiFiM3RuqPA5TAD1agEiXBlwQ
         vwfg==
X-Gm-Message-State: ANoB5pnx0emYO9DXxX+jMhmOo3xtXHZFZD/VyV/69+YMzrst7PpVKg2V
        t7+74ixbzZo2xqfACIyAyRnhqNGfTJEdIQ==
X-Google-Smtp-Source: AA0mqf4UGxlPGL5uMvSKOskqm6MukD4I0e43Adf4AgBUTPw0E7Pv3V0CLl+1e6xz7pZ7sYqG2JBcwQ==
X-Received: by 2002:adf:bd90:0:b0:241:edf6:e198 with SMTP id l16-20020adfbd90000000b00241edf6e198mr29769051wrh.492.1670026376077;
        Fri, 02 Dec 2022 16:12:56 -0800 (PST)
Received: from localhost ([2a01:4b00:d307:1000:6f15:7230:d519:3286])
        by smtp.gmail.com with ESMTPSA id k12-20020adfe8cc000000b00241b5af8697sm8317260wrn.85.2022.12.02.16.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 16:12:55 -0800 (PST)
From:   luca.boccassi@gmail.com
To:     linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev, gmazyland@gmail.com, axboe@kernel.dk,
        brauner@kernel.org, stepan.horacek@gmail.com
Subject: [PATCH v2] sed-opal: allow using IOC_OPAL_SAVE for locking too
Date:   Sat,  3 Dec 2022 00:12:43 +0000
Message-Id: <20221203001243.16482-1-luca.boccassi@gmail.com>
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
v2: break on 80chr for optimal rendering on 1970s green monochrome monitors
    make the new functionality dependent on a new flag that has to be
    passed to IOC_OPAL_SAVE, using reserved bits in its ioctl struct

 block/sed-opal.c              | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/sed-opal.h |  3 ++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9bdb833e5817..3a81754a0fdf 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2470,6 +2470,38 @@ static int opal_lock_unlock(struct opal_dev *dev,
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
+
+	/*
+	 * Usually when closing a crypto device (eg: dm-crypt with LUKS) the volume
+	 * key is not required, as it requires root privileges anyway, and root can
+	 * deny access to a disk in many ways regardless. Requiring the volume key
+	 * to lock the device is a peculiarity of the OPAL specification.
+	 * Given we might already have saved the key if the user requested it via
+	 * the 'IOC_OPAL_SAVE' ioctl, we can use that key to lock the device if no
+	 * key was provided here, the locking range matches and the appropriate
+	 * flag was passed with 'IOC_OPAL_SAVE'. This allows integrating OPAL with
+	 * tools and libraries that are used to the common behaviour and do not ask
+	 * for the volume key when closing a device.
+	 */
+	if (lk_unlk->l_state == OPAL_LK &&
+			lk_unlk->session.opal_key.key_len == 0) {
+		struct opal_suspend_data *iter;
+
+		setup_opal_dev(dev);
+		list_for_each_entry(iter, &dev->unlk_lst, node) {
+			if (iter->unlk.save_for_lock &&
+					iter->lr == lk_unlk->session.opal_key.lr &&
+					iter->unlk.session.opal_key.key_len > 0) {
+				lk_unlk->session.opal_key.key_len =
+					iter->unlk.session.opal_key.key_len;
+				memcpy(lk_unlk->session.opal_key.key,
+					iter->unlk.session.opal_key.key,
+					iter->unlk.session.opal_key.key_len);
+				break;
+			}
+		}
+	}
+
 	ret = __opal_lock_unlock(dev, lk_unlk);
 	mutex_unlock(&dev->dev_lock);
 
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 2573772e2fb3..fa604fb07f50 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -76,7 +76,8 @@ struct opal_user_lr_setup {
 struct opal_lock_unlock {
 	struct opal_session_info session;
 	__u32 l_state;
-	__u8 __align[4];
+	__u8 save_for_lock:1; /* if in IOC_OPAL_SAVE will also use key to lock */
+	__u8 __align[3];
 };
 
 struct opal_new_pw {
-- 
2.35.1


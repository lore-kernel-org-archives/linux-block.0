Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84D0C55186
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 10:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8ED2076C
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 10:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Bp+KHoub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgDVKGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgDVKGs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03939C03C1AB
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 03:06:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k13so1667296wrw.7
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8LewY0CJ3zmj/qBloX8wsPTmFOoGjdsxqYE008qJjA=;
        b=Bp+KHoubwkHeZZ228s+sgr4DZ5C3NJTH5MLyc44DQowU3ZY3VhQASe18vLjho6x6Ib
         lN8atbbQQlybjTqfYPLc3VOhLOBfLyKiCz/QUcguF4GOiSVBD70AinjE5lhWPiDwFz94
         kl3TESXniGyaRPZJ2XY6SePh2FetITjivd7+DQdIA6dVJrYdbSOqVZwNwr7lh8TLCCvF
         pSASfdWCVtNaREj8K2adiRjsx1qvGwy0DmYsaMQldtIOGnV+eLPOL/H/hmjQb5fXSvJ3
         /PH9kAVWMeorrEfiKG1SJTw6qEZKs+hghgir+/+cDtoTcAw5fVTatr2cmXu293SakmaN
         OGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8LewY0CJ3zmj/qBloX8wsPTmFOoGjdsxqYE008qJjA=;
        b=joNVk/Ao+omUCAs4j8Pqp8VGq+JQPDFWWTmeSxhL8A9mIMfCeLdLwWjLWX36scw0VC
         Pa7YwvsZl0/uCZ/mRu3q4jCPWBD3GoR65wAh5wZ0BUJdLDrMupXALnRBfykOKdc/4MO+
         IPNoHKbriFuVhcVh1aAA0PvJa0j5mCY+gL5rI6rvib4sNHuH3JUcdUowDFf7Mg5vIo09
         bxLOj7bYyNXF3VU/1yc029j3G4DLjA5UK/wiBdXtI6mPB5X7calRICxbOSun1wQCD6d1
         KCwPooiocysBYyuXAg5SskX3kb4pKNIkcJIQgVlbWaQFUFyYa/bejEjCejo/cp+a9qFp
         TFnQ==
X-Gm-Message-State: AGi0Puari1+tzVstm/BNSuXS34yGDefwErj8kEX4ftJh4GDZOml7EcAN
        +7X9JbWKUD4EfccbohS2FyZ7MA==
X-Google-Smtp-Source: APiQypLSuhLBBh4+dc7cEnCse/Gbu4xt3oQ8YGm3MRsMhB3dTsGz/+705SocdG3+e1SzFzwScv5A6A==
X-Received: by 2002:adf:edcc:: with SMTP id v12mr29558991wro.317.1587550006735;
        Wed, 22 Apr 2020 03:06:46 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id j13sm7812462wrq.24.2020.04.22.03.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:06:45 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v2 3/5] loop: Move loop_set_status_from_info() and friends up
Date:   Wed, 22 Apr 2020 12:06:34 +0200
Message-Id: <20200422100636.46357-4-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200422100636.46357-1-maco@android.com>
References: <20200422100636.46357-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So we can use it without forward declaration. This is a separate commit
to make it easier to verify that this is just a move, without functional
modifications.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 206 +++++++++++++++++++++----------------------
 1 file changed, 103 insertions(+), 103 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3f8051d3115e..f6c6036324bf 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -971,6 +971,109 @@ static void loop_update_rotational(struct loop_device *lo)
 		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
 }
 
+static int
+loop_release_xfer(struct loop_device *lo)
+{
+	int err = 0;
+	struct loop_func_table *xfer = lo->lo_encryption;
+
+	if (xfer) {
+		if (xfer->release)
+			err = xfer->release(lo);
+		lo->transfer = NULL;
+		lo->lo_encryption = NULL;
+		module_put(xfer->owner);
+	}
+	return err;
+}
+
+static int
+loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
+	       const struct loop_info64 *i)
+{
+	int err = 0;
+
+	if (xfer) {
+		struct module *owner = xfer->owner;
+
+		if (!try_module_get(owner))
+			return -EINVAL;
+		if (xfer->init)
+			err = xfer->init(lo, i);
+		if (err)
+			module_put(owner);
+		else
+			lo->lo_encryption = xfer;
+	}
+	return err;
+}
+
+/**
+ * loop_set_status_from_info - configure device from loop_info
+ * @lo: struct loop_device to configure
+ * @info: struct loop_info64 to configure the device with
+ *
+ * Configures the loop device parameters according to the passed
+ * in loop_info64 configuration.
+ */
+static int
+loop_set_status_from_info(struct loop_device *lo,
+			  const struct loop_info64 *info)
+{
+	int err;
+	struct loop_func_table *xfer;
+	kuid_t uid = current_uid();
+
+	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
+		return -EINVAL;
+
+	err = loop_release_xfer(lo);
+	if (err)
+		return err;
+
+	if (info->lo_encrypt_type) {
+		unsigned int type = info->lo_encrypt_type;
+
+		if (type >= MAX_LO_CRYPT)
+			return -EINVAL;
+		xfer = xfer_funcs[type];
+		if (xfer == NULL)
+			return -EINVAL;
+	} else
+		xfer = NULL;
+
+	err = loop_init_xfer(lo, xfer, info);
+	if (err)
+		return err;
+
+	lo->lo_offset = info->lo_offset;
+	lo->lo_sizelimit = info->lo_sizelimit;
+	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
+	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
+	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
+	lo->lo_crypt_name[LO_NAME_SIZE-1] = 0;
+
+	if (!xfer)
+		xfer = &none_funcs;
+	lo->transfer = xfer->transfer;
+	lo->ioctl = xfer->ioctl;
+
+	if ((lo->lo_flags & LO_FLAGS_AUTOCLEAR) !=
+	     (info->lo_flags & LO_FLAGS_AUTOCLEAR))
+		lo->lo_flags ^= LO_FLAGS_AUTOCLEAR;
+
+	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
+	lo->lo_init[0] = info->lo_init[0];
+	lo->lo_init[1] = info->lo_init[1];
+	if (info->lo_encrypt_key_size) {
+		memcpy(lo->lo_encrypt_key, info->lo_encrypt_key,
+		       info->lo_encrypt_key_size);
+		lo->lo_key_owner = uid;
+	}
+
+	return 0;
+}
+
 static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		       struct block_device *bdev, unsigned int arg)
 {
@@ -1094,43 +1197,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	return error;
 }
 
-static int
-loop_release_xfer(struct loop_device *lo)
-{
-	int err = 0;
-	struct loop_func_table *xfer = lo->lo_encryption;
-
-	if (xfer) {
-		if (xfer->release)
-			err = xfer->release(lo);
-		lo->transfer = NULL;
-		lo->lo_encryption = NULL;
-		module_put(xfer->owner);
-	}
-	return err;
-}
-
-static int
-loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
-	       const struct loop_info64 *i)
-{
-	int err = 0;
-
-	if (xfer) {
-		struct module *owner = xfer->owner;
-
-		if (!try_module_get(owner))
-			return -EINVAL;
-		if (xfer->init)
-			err = xfer->init(lo, i);
-		if (err)
-			module_put(owner);
-		else
-			lo->lo_encryption = xfer;
-	}
-	return err;
-}
-
 static int __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp = NULL;
@@ -1275,72 +1341,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	return __loop_clr_fd(lo, false);
 }
 
-/**
- * loop_set_status_from_info - configure device from loop_info
- * @lo: struct loop_device to configure
- * @info: struct loop_info64 to configure the device with
- *
- * Configures the loop device parameters according to the passed
- * in loop_info64 configuration.
- */
-static int
-loop_set_status_from_info(struct loop_device *lo,
-			  const struct loop_info64 *info)
-{
-	int err;
-	struct loop_func_table *xfer;
-	kuid_t uid = current_uid();
-
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
-		return -EINVAL;
-
-	err = loop_release_xfer(lo);
-	if (err)
-		return err;
-
-	if (info->lo_encrypt_type) {
-		unsigned int type = info->lo_encrypt_type;
-
-		if (type >= MAX_LO_CRYPT)
-			return -EINVAL;
-		xfer = xfer_funcs[type];
-		if (xfer == NULL)
-			return -EINVAL;
-	} else
-		xfer = NULL;
-
-	err = loop_init_xfer(lo, xfer, info);
-	if (err)
-		return err;
-
-	lo->lo_offset = info->lo_offset;
-	lo->lo_sizelimit = info->lo_sizelimit;
-	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
-	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
-	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
-	lo->lo_crypt_name[LO_NAME_SIZE-1] = 0;
-
-	if (!xfer)
-		xfer = &none_funcs;
-	lo->transfer = xfer->transfer;
-	lo->ioctl = xfer->ioctl;
-
-	if ((lo->lo_flags & LO_FLAGS_AUTOCLEAR) !=
-	     (info->lo_flags & LO_FLAGS_AUTOCLEAR))
-		lo->lo_flags ^= LO_FLAGS_AUTOCLEAR;
-
-	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
-	lo->lo_init[0] = info->lo_init[0];
-	lo->lo_init[1] = info->lo_init[1];
-	if (info->lo_encrypt_key_size) {
-		memcpy(lo->lo_encrypt_key, info->lo_encrypt_key,
-		       info->lo_encrypt_key_size);
-		lo->lo_key_owner = uid;
-	}
-
-	return 0;
-}
-
 static int
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
-- 
2.26.2.303.gf8c07b1a785-goog


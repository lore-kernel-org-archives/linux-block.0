Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE26FC83006
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A435C208FE
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="LE9BhdJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgD2OEO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728120AbgD2OD5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AD2C035494
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 07:03:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so2159124wma.4
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmU3PBXf6dhWHFQlW8YZGbPLjN065hLB6uprJoU2IF0=;
        b=LE9BhdJ0/TmpLlVMtxtt6RToML+PfaNi4fMHhei9MClgSqIW9ok01yn4G2P9d1gvE0
         kI0+x/hdrPCUp3rf5B6dgOhPlyFuGzDtHA0ibLtShdxyvTsmbrsiZgvUKfgW4P4yrEfC
         793mnY4YMGpcvwbtpTeIYY1XNja31PeA7X3GQzt9dSuSNInJ29YqYN/gzNUl+DPzXtrK
         xqtZxXTYFtbiA8QhcuUss1wB6O/rIhiey5euIx6P5Zfmnywn9kCJ3I0u5mwOcGWNEvym
         BYwNZTlp5o8S8IYbaGEkpMbxu/mgp14r4rR8JpSpOP4pnhWtAcILpxM9T3gvWBfyaVuB
         t3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmU3PBXf6dhWHFQlW8YZGbPLjN065hLB6uprJoU2IF0=;
        b=lBP+1lul+UpAoX7hKwpn2NLF5odC3wCMdT1B7g6m28g1uOdSB3aO9sDLYCnqmfjiWT
         c1iol8cMlQkbAfrqvABibPoaPhoxJ+YYNhhJ22fzenKAtyxxTE4arvjFTmB/NLLtk0qc
         TUiamtkqejS7d3rSj+KFsGp/g2HuonDsxuYPE9ji3GX0cYLMCAK8CoKnEszeRzHWP2Qi
         B8OyOJ8TIWVPgrHwaybKUkY2ZHcCqr+DMxjSQZHPKIcC9iGNQ2vrjj1jBoyLVxea2sh3
         EeXhmrOWFdOwO2Yi9rBHMSx239OMtP3+Z0Mo4YZhvUHCFx2qO5h6DFWbuwGZazRCP4t3
         EmWg==
X-Gm-Message-State: AGi0PuaFA+bckkYgPW7xtJnEYhdmB7uiN2ycjrJVJ5s6os8aC+9CKM8w
        1ajyGCk5yGL/pdjU7oLVz89nzw==
X-Google-Smtp-Source: APiQypJKTvAtLG7slROxyNfQknjkesDM9yKf/JC72SKZhVuC+bDDogyptbmnCLXSBW+dKWmD/6S7mQ==
X-Received: by 2002:a1c:48c:: with SMTP id 134mr3236527wme.47.1588169034570;
        Wed, 29 Apr 2020 07:03:54 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:53 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 07/10] loop: Move loop_set_status_from_info() and friends up
Date:   Wed, 29 Apr 2020 16:03:38 +0200
Message-Id: <20200429140341.13294-8-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200429140341.13294-1-maco@android.com>
References: <20200429140341.13294-1-maco@android.com>
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
index 4a36a3f47503..60ba1ed95d77 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -962,6 +962,109 @@ static void loop_update_rotational(struct loop_device *lo)
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
@@ -1085,43 +1188,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
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
@@ -1266,72 +1332,6 @@ static int loop_clr_fd(struct loop_device *lo)
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


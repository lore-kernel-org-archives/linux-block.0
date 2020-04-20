Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE28C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 08:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4BB21D79
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 08:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="D2rOL6OR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgDTIFH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgDTIEs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 04:04:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36615C0610D5
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 01:04:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t14so10860126wrw.12
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=srpwwZicRuHBaaZczdyiKE9b7NuCR4Sz5/p3TPFLESI=;
        b=D2rOL6ORsWExuyJKdQ0qmNjMSCtCedN18tQBrtmS1+oejMNKf5FHFRJGNul1HOrNCI
         5qtd9pGVSGFhu2ZjszBRq8FtfVL9a0rsUe2Df9yeIpFoxbEcnAlOqEuq2BSa6sgr5btq
         zQ/nYtyFk+XjqpEhsDKXsEK9IV3g2LMYQJJVZRR9ZzwAoIWm38Ug+zQjCL/W8IKMczHE
         MRv8o5e6qZ1O2TeKp8DQ47JCJbSo5hCKM3nVl99hDdksGaqpGFd2eQTpRAI6owoPPapp
         oIIHvE6P4/AN5mANLYsEGnO95rLd2Yv2w1QO3zJqXbajF+NHseOuubdRjvrAfosS4vVc
         7UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=srpwwZicRuHBaaZczdyiKE9b7NuCR4Sz5/p3TPFLESI=;
        b=hM6Qru45uNr0M2Xt1hT+e3x76cVLUigksh4ltEYhtS+Gj5bizcHURlU1Mn9sPKjsnE
         76F8wl0kWo4ESWga71Bm8uAmobX/Z62rHlsP2PW7VcQLeaLhtwnPY8piH4lMrpNtlAhd
         e6fGy6MiUtRBLTQDK3MG86Q0S3G1SfadwHpLAVXlymRdbIY3mEQnS8J8eKKu49Ydqf1w
         oqnzMwLc01Iq1i73dKUx2QzpNeswt7fTJNApGk/Kdi2pFM+T33wYKtbBozZ0joHSc6YF
         GWUYdAouc/m+ac8HCEBkCwBCa9SDFm2xKaoWkuxPAIxQxrA5Gqlg+nxKUrPXKCyoQEJd
         ktQg==
X-Gm-Message-State: AGi0Pua28VC4VV0zkz3ry7hM59J011OAJs/aCAWNsVgNpl+zB63BG2Zb
        p4Pr53DQ8YsZkA3x4LecHlVVZA==
X-Google-Smtp-Source: APiQypIvClCsiATXQsfdANkumpU6IrAtquSg5QOsnzdnkNuHCIoh2CZE66ozOTEgiQdNZciRfgG48Q==
X-Received: by 2002:adf:84c2:: with SMTP id 60mr16995427wrg.65.1587369886949;
        Mon, 20 Apr 2020 01:04:46 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a67sm335827wmc.30.2020.04.20.01.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:04:46 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH 3/4] loop: Move loop_set_from_status() and friends up.
Date:   Mon, 20 Apr 2020 10:04:08 +0200
Message-Id: <20200420080409.111693-4-maco@android.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420080409.111693-1-maco@android.com>
References: <20200420080409.111693-1-maco@android.com>
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
 drivers/block/loop.c | 188 +++++++++++++++++++++----------------------
 1 file changed, 94 insertions(+), 94 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e0f9674fe568..6e656390b285 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -971,6 +971,100 @@ static void loop_update_rotational(struct loop_device *lo)
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
+static int
+loop_set_from_status(struct loop_device *lo, const struct loop_info64 *info)
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
@@ -1094,43 +1188,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
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
@@ -1275,63 +1332,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	return __loop_clr_fd(lo, false);
 }
 
-static int
-loop_set_from_status(struct loop_device *lo, const struct loop_info64 *info)
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
2.26.1.301.g55bc3eb7cb9-goog


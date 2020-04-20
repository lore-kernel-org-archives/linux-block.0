Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8229BC3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 08:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CCB21927
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 08:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="s5PqRrTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgDTIEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDTIEr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 04:04:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3D3C061A0F
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 01:04:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so10226557wmh.3
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tLGYKYNZspGp5vH+8esZkJWR5Txoi8BijnV5hDWvAE=;
        b=s5PqRrTKvQ0QBwzyadlxMwsha2g1UnMKNFECfpxRYJOKWFJhNteHrGVrVl5KhpTC5Y
         xdIezQIrPmTLEqroZxFKDy9ludXsow7UVOz7Q1Eq1hF485V19TgWPEPIqLs0FylnjRtF
         vWNeKZouwWrI9H+kHYIZaJGiM3VydudX8acm99LZi1KvK7SDed1olxrgZ9mOBNjnmhN0
         on0t07gWf8LtT7sd+fq7IxCldYg3Hl1NSmnoms2+DVava80S/MDvZC3mteWPhqpW1YPk
         1GHcYI5IHO5TSK6h3i/ShbhZNGT+d6ujoiyi974Q96mIKNR3DO9lah8I7CkdZxWVpw3M
         gu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tLGYKYNZspGp5vH+8esZkJWR5Txoi8BijnV5hDWvAE=;
        b=UuK91yJLFnsWayOIUl1mIdfQNIxNbMh5Y3DWh6+HGdjMPSeNK1GzMpanRGwO9cuA8F
         WDdl4bvwrHg3OBhNmEoxfVXoFD37atDqCzSEN+uL4yT7cjFzd2k1xOkjwYiikA+0nLxM
         eDZtv4j4tSUh8Z0xDsOcmDmP0xgytHJ/kkoQSOSDLO3SjJVizyjIhdmFHYX+TSHlA1z1
         vMdwMZtbEl0y9SctQ7M6MP8zQGjMnWjVVIAEtqdWDMCAoFSCz4PVFsWTL1G9zD6G9gTz
         SFaRD5SfPyawzb8MZh70Z/0WXJVPEUw0EQOxA6Ugvm9lt32sbIAoVlSX3Vh7KHwxDuG2
         VB0Q==
X-Gm-Message-State: AGi0PuaUWwUcZLrIdBY1K+xYXAJkiT5MO5yzhMxRNNgpInoHApNtnrDg
        5T/RW+4NPRnFD05L7gdCMpU0sA==
X-Google-Smtp-Source: APiQypK01//hkdHaPKNXR+Bhan3NLsECdKYvcmATa5IoCDMimXPNJzXRTZhc1Kk7Gbptou95Pd/GNA==
X-Received: by 2002:a1c:e242:: with SMTP id z63mr17045252wmg.72.1587369885689;
        Mon, 20 Apr 2020 01:04:45 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a67sm335827wmc.30.2020.04.20.01.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:04:44 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH 2/4] loop: Factor out configuring loop from status.
Date:   Mon, 20 Apr 2020 10:04:07 +0200
Message-Id: <20200420080409.111693-3-maco@android.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420080409.111693-1-maco@android.com>
References: <20200420080409.111693-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out this code into a separate function, so it can be reused by
other code more easily.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 108 +++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d934d65dbe92..e0f9674fe568 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1276,12 +1276,68 @@ static int loop_clr_fd(struct loop_device *lo)
 }
 
 static int
-loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+loop_set_from_status(struct loop_device *lo, const struct loop_info64 *info)
 {
 	int err;
 	struct loop_func_table *xfer;
 	kuid_t uid = current_uid();
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
+static int
+loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+{
+	int err;
 	struct block_device *bdev;
+	kuid_t uid = current_uid();
 	bool partscan = false;
 	bool size_changed = false;
 	loff_t validated_size;
@@ -1299,10 +1355,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		err = -ENXIO;
 		goto out_unlock;
 	}
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
@@ -1330,54 +1382,10 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto out_unfreeze;
 	}
 
-	err = loop_release_xfer(lo);
-	if (err)
-		goto out_unfreeze;
-
-	if (info->lo_encrypt_type) {
-		unsigned int type = info->lo_encrypt_type;
-
-		if (type >= MAX_LO_CRYPT) {
-			err = -EINVAL;
-			goto out_unfreeze;
-		}
-		xfer = xfer_funcs[type];
-		if (xfer == NULL) {
-			err = -EINVAL;
-			goto out_unfreeze;
-		}
-	} else
-		xfer = NULL;
-
-	err = loop_init_xfer(lo, xfer, info);
+	err = loop_set_from_status(lo, info);
 	if (err)
 		goto out_unfreeze;
 
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
 	if (size_changed)
 		loop_set_size(lo, validated_size);
 
-- 
2.26.1.301.g55bc3eb7cb9-goog


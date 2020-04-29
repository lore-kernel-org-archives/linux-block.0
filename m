Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A802FC83006
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A77208FE
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="R0DwcNb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgD2OEU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728102AbgD2ODz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736BAC03C1AD
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 07:03:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b11so2679935wrs.6
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HC08dUHVOBIjJahrhCZVwxh1xu6QFmdAnccVqLD3gg=;
        b=R0DwcNb379f900LA16sf6jG4SWkLq/2xQL+qN7tElj7ZFiQNFqvQf0zH1wjKlWfEjR
         sRQbQT2T1J16XwicUS3/Z2un3jV3lu/4sFb35zv4LIPc/RFL63s9vvf5Kl4DS41XabHz
         l5V4uFJxg9yKfp1ipBl9DMTamCHhgdPFt3SnlOkib5kBFLykkBfCMYN1ePxiiGb+r4D1
         ubd+FySlJQB1Rj5VG7R8O8TCFuFLceidrIAcJpEIiWESB+7aTfEU2yJdbiYsuaM7iY+4
         PFYaFZrdJLJTifaXQpccywEeK7lQM6QZ4NP4vee7yZtC4neSUcE4rTeL2SVekohewYfn
         qzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HC08dUHVOBIjJahrhCZVwxh1xu6QFmdAnccVqLD3gg=;
        b=sDWXYlnJWGz7rzZ+xx43nFljgKmMKCoNdvJIj91Y9qsHQHIO7Yn2nuDA4sAzmq/taz
         szaXHo3WxfoKPlEPoKEHZJxKcB5Pnptiv6vCs72kqvAb0Wz36GmhqfPKFSi1s+A+zgFJ
         dvt31s8dcr1pXPaqtSv4sQjjuBMZ5Xj8B/xze8kjZ7VDab/gUkimfc0ZnOEpjZmBaCTF
         z0jWASZuiUzIuH8cvoNDbDcIDWmTAPFE2SuQ3tCI1AMw0ZpdoHK1NhQ4ootP7tlmVQ/1
         lIKlQ9WcUaTxivosa878Ezim+waR5EezfrnoebB3pNAF5owBBYqg0WF5+FaeeNx0ibBk
         1aNA==
X-Gm-Message-State: AGi0PuY/13/tfEfkqDOFMKag5EcVzvwCcWWo8Y6okZKbg3F7w4RdiRSo
        kQSxByLljfnc0Cnx3JGUgbtwtg==
X-Google-Smtp-Source: APiQypJZibuLny3Lo7URMsqeXYQiMnJb3tO5aJv9bpGM4hSzfrTV2Mi1xp8ZsRwizK8SkX2hOvEhYw==
X-Received: by 2002:a5d:634f:: with SMTP id b15mr37706649wrw.46.1588169033159;
        Wed, 29 Apr 2020 07:03:53 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:52 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 06/10] loop: Factor out configuring loop from status
Date:   Wed, 29 Apr 2020 16:03:37 +0200
Message-Id: <20200429140341.13294-7-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200429140341.13294-1-maco@android.com>
References: <20200429140341.13294-1-maco@android.com>
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
 drivers/block/loop.c | 117 +++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 50 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 32755e874326..4a36a3f47503 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1266,13 +1266,78 @@ static int loop_clr_fd(struct loop_device *lo)
 	return __loop_clr_fd(lo, false);
 }
 
+/**
+ * loop_set_status_from_info - configure device from loop_info
+ * @lo: struct loop_device to configure
+ * @info: struct loop_info64 to configure the device with
+ *
+ * Configures the loop device parameters according to the passed
+ * in loop_info64 configuration.
+ */
 static int
-loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+loop_set_status_from_info(struct loop_device *lo,
+			  const struct loop_info64 *info)
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
@@ -1290,10 +1355,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		err = -ENXIO;
 		goto out_unlock;
 	}
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
@@ -1320,54 +1381,10 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto out_unfreeze;
 	}
 
-	err = loop_release_xfer(lo);
+	err = loop_set_status_from_info(lo, info);
 	if (err)
 		goto out_unfreeze;
 
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
-	if (err)
-		goto out_unfreeze;
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
 	if (size_changed)
 		loop_set_size(lo, validated_size);
 
-- 
2.26.2.303.gf8c07b1a785-goog


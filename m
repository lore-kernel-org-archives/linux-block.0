Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97027C7C7E2
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774712087E
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="gVLXq5UT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgD0HnE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgD0Hmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 03:42:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D267CC061A10
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 00:42:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so18395548wmj.1
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 00:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPVCBcZ+vxq/vE4PZ944u0smAG80GpkLUfGejPD/RBc=;
        b=gVLXq5UTLy0Ky0X9RXtF7PmsN+x21+1ldkywUzJDwSyOyLmpHneDPQ2I+VDgFJ/mn7
         XuC4a8Kaiz+KkMu4MSvu+lqv+7aY3X1rc96lLpuBhsKGWTWEa6voZHHh8/5dA0q65fVd
         dX4V2Yt1Z+y9vkCTwk4Q7IJ1JD6U/4ggynoMWpUsIdYeWwzLRp+N1MwjaJEQuRxxTrx5
         AKz5M/dllwEAHos70YtDbiHgGSaS3ll5T6UzwFIS7FvC1Icfo4sENqlzM80dgdXYkpPm
         OFpfaCmFtir8qeTArrTCXBCySxDTy2jyHHXn25HSYy8CoHx48mnCNNTq3duMpcfsjV1H
         iVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPVCBcZ+vxq/vE4PZ944u0smAG80GpkLUfGejPD/RBc=;
        b=IvdOt37KTcs9IJceVN4a/H3Ak5hckYxI63z9w2JIvEojWxXcBwS+0drLDb/gKrJKHh
         ullCE8WKR7v8vfn0mS9L70ufoK+cXMwon4JP/MkXwkZ8mQ4r4vF5i3eqgsLEcBRsa50v
         Rf5X4SWk1PzpKgU6bwoFN1+pGVOMXvqir8QJKRljyvzkqCk561I5uER70T+QD+UHmn1G
         F/cQOSv2dPifLS3TR3w3sQcoNn7WCcmFra5sb8HUgeeZoqGLP3SDRFGtj2IMXTOP2bJf
         eW0FkXscDafHlmjUODCxGw5qPKKG1gOt8IKV+xpRNDVN/DlKnUOQxWIg7RzUOgmDgy0K
         u4Rw==
X-Gm-Message-State: AGi0PuZ+G/cXjXwTTNHQ5/nA7MxgCJC1PzSHRho++Un903Z/oUltsyi2
        NqnfUCIBtDloKJf27QU9SKhhrQ==
X-Google-Smtp-Source: APiQypLpcwPdjusrbnmQUpHn2u+iuCu0JjOhCwJKZM9cdOEV08wmidKyKi1vkkGnkx6Ew9J/oslyXQ==
X-Received: by 2002:a1c:49:: with SMTP id 70mr23488300wma.184.1587973360626;
        Mon, 27 Apr 2020 00:42:40 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id x132sm15091658wmg.33.2020.04.27.00.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:42:39 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v3 6/9] loop: Factor out configuring loop from status
Date:   Mon, 27 Apr 2020 09:42:19 +0200
Message-Id: <20200427074222.65369-7-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200427074222.65369-1-maco@android.com>
References: <20200427074222.65369-1-maco@android.com>
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
index d9a1a7e8b192..b55569fce975 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1267,13 +1267,78 @@ static int loop_clr_fd(struct loop_device *lo)
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
@@ -1291,10 +1356,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		err = -ENXIO;
 		goto out_unlock;
 	}
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
@@ -1321,54 +1382,10 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
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


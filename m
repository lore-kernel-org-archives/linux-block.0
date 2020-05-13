Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1876FCA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BE022384
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="bMtNP9ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbgEMNjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388325AbgEMNi7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 09:38:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BBDC061A0E
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:38:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m12so21680217wmc.0
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyRGlbI4Ky3Dk3+EyeqNaJIIfLuLQ5HFlEzVPTO9nr4=;
        b=bMtNP9htiHa4g6CO0FhlyLgjdmVg2uoH/JS6A+XeeQjNSsWHJ8U8m0wdZGnw1Y+0aL
         kW8OYvE+eNBeWbbm/5Gab5wkT1yO1e6mIJUToNMcIPXRt7iTR0/vCIetz/nAJn27FLLz
         jhPPpIRzrjCO7NAduITv9ZIwigQhrw9Qrd7XSq6ZHbMgGPCG8DIfXLK4Mz26e6UyQIsC
         kFE/QS0MJpOZwOAHP/JmflUOLkHqqpPF2Ucefo9KzZkVgBFzOPS1UsPF3YxZe44yFlfI
         eGemUuSFNmHex8uVKB8LTn1f6/I4kJhidJrkgjKQ+bDuFwMnHX66Mv8lS/yNh7KxVHHy
         5Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyRGlbI4Ky3Dk3+EyeqNaJIIfLuLQ5HFlEzVPTO9nr4=;
        b=g2LETOytIrcKylW+6J9D8NgmlCDUXN3OXsfSjtePcA7fXlp0CDpeyKnrTAh8ottgD/
         h9L6Kab6upPAkm/JZC3dy/KfyFFitrHDJ/0mW0+OOKwQIy7msK1q55GYEZuYYgCqS/GO
         8TunBVtNan4lS0KPVygf8/GiarQJ1lCZzRWY3nhclNDjAJqjsog/ae2vE8SdzAVfQN6y
         B9FURi9qS2PaxPs85rbkGhlzIx3pVbjovmU5MgOTiJ2/ncL08r+xZjtARkUMz76iPU1P
         YDkF9ck+j4pqNZBBr1baitOkvRn2Dqk8QlgEGUN6zphMi/Y0ZpXTtEwrn+gave08gm8E
         KLPg==
X-Gm-Message-State: AGi0PuYB4zFP0ht83srE6THaDqvtt3CBpmhE2OExWh+e//hCQQqdGi1r
        Nj7Rvbo4bl0S7KC7dJhpYx9TqA==
X-Google-Smtp-Source: APiQypIjxnkrTUJVBpGMV8YOgo+iI7d5niRSc7PWL+lVfFV/KjhGlb+A6PRiT5dOGTNyca62+5s28w==
X-Received: by 2002:a1c:3581:: with SMTP id c123mr32473872wma.150.1589377130947;
        Wed, 13 May 2020 06:38:50 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:50 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH v5 01/11] loop: Call loop_config_discard() only after new config is applied
Date:   Wed, 13 May 2020 15:38:35 +0200
Message-Id: <20200513133845.244903-2-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_set_status() calls loop_config_discard() to configure discard for
the loop device; however, the discard configuration depends on whether
the loop device uses encryption, and when we call it the encryption
configuration has not been updated yet. Move the call down so we apply
the correct discard configuration based on the new configuration.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e..f1754262fc94 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1334,8 +1334,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		}
 	}
 
-	loop_config_discard(lo);
-
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
@@ -1359,6 +1357,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	loop_config_discard(lo);
+
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
-- 
2.26.2.645.ge9eca65c58-goog


Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E699C433E1
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 20:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2272067B
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 20:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="evhiSuNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgFDUZc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbgFDUZ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 16:25:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D733C08C5C5
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 13:25:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k11so7513258ejr.9
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wp1xYo6k4Ed0Q77xnwXh8flp1gyMGXgNyJfMwsgW+Kg=;
        b=evhiSuNKpPTp+xlYhHPUN38Ox9A/NzzEV4h1KCTaNexej2sn7dmxexT5wPV6QE9RGz
         8s+clTM3p1CcSW8UaFOs+qvckgUkMZCWKQTkyDHU6S/fz724e8Vq0r4vnPsuXTIqOTMo
         ImpLlbekhGKaz1aCRFpAKp2RoYziWLrVBv+kPju1pOuBuubQ+yvuGmBZxTi0FgAL/xGs
         bstbfB866bgWjvF5BP1/Gb+lQVOxGlNCNdLiVkaiEjXFC1758lqtSdf2UsrBgT3xnK84
         kIqKVoUgb2UoS9fHTo26sqjDx8ivjPSW9RvxOOS99pfOPNahG8izNyr51/w+pRl6e4bJ
         3R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wp1xYo6k4Ed0Q77xnwXh8flp1gyMGXgNyJfMwsgW+Kg=;
        b=DqEsGcQVUuRaQ0TSZ/3bkLTkqjZOBs3vJAxQ86549TvTDUkEBHEY+5G6exEMNpg077
         tfzuP3u7GUC4BFGA3zuKj0Y1Ys6qxXtUSgl5yozpdH46St+r7PkHQxO7mVHzWSBg2RqE
         8mEGlZZoAeSSBxDDHvAfxt3OHXXA5lk7LVlqT449wp2O97mjgr6bicV2pnMnLtjpep3N
         p+xDdUFzXnIWQ0uNrNsPU9nCc+I442o9BQEfWQY+Wn5zw26CE+Dl2CuFcRe56vBdaGbQ
         /CxU7UaukIcQNKxh3j0uWD3e/kFkh7PpcmMD5XgfnPR/7+nUAKOn0vCeo3rrXm9iHObb
         V9oQ==
X-Gm-Message-State: AOAM531hwccVHPPt9KgU0dAoVFX0Zb31cnGsbPgiBmGqAH55wju3z6PS
        XB20ffqKIzxOAcFenJkCIVNuzQ==
X-Google-Smtp-Source: ABdhPJy0rnfMZ1ArAXpFdTF1Mqx8GK4Oc26nrumSGoUgDRR2u9udOp68JVQC+ShGFy3J/lNOJiw52w==
X-Received: by 2002:a17:906:3844:: with SMTP id w4mr5771829ejc.313.1591302327676;
        Thu, 04 Jun 2020 13:25:27 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id gx8sm2792246ejb.86.2020.06.04.13.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:25:26 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, naresh.kamboju@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] loop: Fix wrong masking of status flags
Date:   Thu,  4 Jun 2020 22:25:20 +0200
Message-Id: <20200604202520.66459-1-maco@android.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In faf1d25440d6, loop_set_status() now assigns lo_status directly from
the passed in lo_flags, but then fixes it up by masking out flags that
can't be set by LOOP_SET_STATUS; unfortunately the mask was negated.

Re-ran all ltp ioctl_loop tests, and they all passed.

Pass run of the previously failing one:

tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
tst_device.c:88: INFO: Found free device 0 '/dev/loop0'
ioctl_loop01.c:49: PASS: /sys/block/loop0/loop/partscan = 0
ioctl_loop01.c:50: PASS: /sys/block/loop0/loop/autoclear = 0
ioctl_loop01.c:51: PASS: /sys/block/loop0/loop/backing_file =
'/tmp/ZRJ6H4/test.img'
ioctl_loop01.c:65: PASS: get expected lo_flag 12
ioctl_loop01.c:67: PASS: /sys/block/loop0/loop/partscan = 1
ioctl_loop01.c:68: PASS: /sys/block/loop0/loop/autoclear = 1
ioctl_loop01.c:77: PASS: access /dev/loop0p1 succeeds
ioctl_loop01.c:83: PASS: access /sys/block/loop0/loop0p1 succeeds

Summary:
passed   8
failed   0
skipped  0
warnings 0

Fixes: faf1d25440d6 ("loop: Clean up LOOP_SET_STATUS lo_flags handling")
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4212288ab157..ad63e4247868 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1390,7 +1390,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto out_unfreeze;
 
 	/* Mask out flags that can't be set using LOOP_SET_STATUS. */
-	lo->lo_flags &= ~LOOP_SET_STATUS_SETTABLE_FLAGS;
+	lo->lo_flags &= LOOP_SET_STATUS_SETTABLE_FLAGS;
 	/* For those flags, use the previous values instead */
 	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_SETTABLE_FLAGS;
 	/* For flags that can't be cleared, use previous values too */
-- 
2.27.0.278.ge193c7cf3a9-goog


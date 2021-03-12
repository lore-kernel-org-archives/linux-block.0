Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ABEC4161F
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F996500D
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhCLK4C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbhCLKzs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1ADC061763
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y124-20020a1c32820000b029010c93864955so15516184wmy.5
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ChpkgDvC00jlcyTpzmO/AxUi3IFbRKq2Rr45Vj3i/Mk=;
        b=M7HIi8f+gB/JI8PhrAXj82T0nj05L6LxfnxpB9qnEn5uMRXJ6CB95P0Xr79R4BKzAp
         oJq2DYDFa3UK8r5lVDLHFzKF0MIkdbHt3U2SjDf3Pyb9fS5fyaS1KpK0ja7B3nvMXRFE
         bKFLwSPRhVig3OaTQ+x9C3G+Sw47s0lkTmPwGLgV10lyhINnpPyl5X+vKGbJbY/WuuDp
         vEbXQOx6WEsgGazJtFIRFqznDnQSMOO91Mm8LBTMJeLUafj/fFKQ1TnGVtcxjV4CPkgM
         Obyjv2plNvWObSL2wRfSXNZaPq6fciMow1nJCzNhfs+o6ue6XZLEEX6jnCXlgCVn3+bA
         NHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ChpkgDvC00jlcyTpzmO/AxUi3IFbRKq2Rr45Vj3i/Mk=;
        b=JRT7ubBr7rbzbAZg6uioVie5Z15mMozbiNf8hQ+tcvUncNGCXgAt5IoWyIElFkftol
         7RqB5sXY4JszqaruZOk3rOWeVTOdt1UtQlhzzhyLiihXrfryxrtqoBsIynBcduXudwQq
         LwrVlata+/AbZ6KprzuC94b2T+YXamUooY0glstQfectOtyf493DcLrIzsT4t0MluYnc
         ZEDHvEBrV03xw9etmDaeirQkITi+l/PWwoMcz9EhgBQ9RTDRxIoqzn7sW7NWh+RqMhe9
         VR6KXDb3aj6ur5C+CSjeW9ARGrwfs9sbvFICvO3fFcDN83Y2bIrsl4U50l765UBYuKE9
         s72A==
X-Gm-Message-State: AOAM532vVq65lh3NlIOMOyiuDkaEPx697C7uTbpNHnKH5cW9x7ppdhom
        oJOM+DarKK72X+5ndybEz3mddg==
X-Google-Smtp-Source: ABdhPJwC/cvyVmhhLtpqzhs4+UAHBO67pW6y4yjeQq1dW5Hf2tw1TaVh9srGIIR86iZZVMjXPPD57g==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr12767958wma.39.1615546546556;
        Fri, 12 Mar 2021 02:55:46 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH 11/11] block: drbd: drbd_nl: Demote half-complete kernel-doc headers
Date:   Fri, 12 Mar 2021 10:55:30 +0000
Message-Id: <20210312105530.2219008-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 from drivers/block/drbd/drbd_nl.c:24:
 drivers/block/drbd/drbd_nl.c: In function ‘drbd_adm_attach’:
 drivers/block/drbd/drbd_nl.c:1968:10: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]
 drivers/block/drbd/drbd_nl.c:930: warning: Function parameter or member 'flags' not described in 'drbd_determine_dev_size'
 drivers/block/drbd/drbd_nl.c:930: warning: Function parameter or member 'rs' not described in 'drbd_determine_dev_size'
 drivers/block/drbd/drbd_nl.c:1148: warning: Function parameter or member 'dc' not described in 'drbd_check_al_size'

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_nl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 31902304ddac7..e7d0e637e6321 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -918,7 +918,7 @@ void drbd_resume_io(struct drbd_device *device)
 		wake_up(&device->misc_wait);
 }
 
-/**
+/*
  * drbd_determine_dev_size() -  Sets the right device size obeying all constraints
  * @device:	DRBD device.
  *
@@ -1136,7 +1136,7 @@ drbd_new_dev_size(struct drbd_device *device, struct drbd_backing_dev *bdev,
 	return size;
 }
 
-/**
+/*
  * drbd_check_al_size() - Ensures that the AL is of the right size
  * @device:	DRBD device.
  *
-- 
2.27.0


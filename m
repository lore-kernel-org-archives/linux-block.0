Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2D2C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 02:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355682AbiFVCfL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 22:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiFVCfK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 22:35:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59764302
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 19:35:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso15364156pjh.4
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 19:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGl5+ehxGLowleALKzjeGZ3rc803Ngllm888LIuNvsg=;
        b=VnSeM+TIr/QKBFk6gml/hHQpsnIEappV2NO0YNXNvzqho/5OwT2bSkTkgVw7aBqaqj
         WBmAErFIKMAcMurvSHpjhakvBhtB9ttIM2zdqaVRZ8L+ervOtdO8ERPa9fVyHQ+GF4pV
         fgY8bpVPoxVuaZIDRoyNgZouHIMQ24/OmUW14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGl5+ehxGLowleALKzjeGZ3rc803Ngllm888LIuNvsg=;
        b=d5FdARFoquWd0/46wwmbp5Zvai+wOlgSN/zcy4ENw1I2Ssp6ZXpcS4QOl+xxg/P4h9
         O4x/JXO9WCzh0lij+py6Is/V1N6GkW5zzxvjAuAqUoTz4IMaVtKXWM1cpPMmawAfqjoV
         M9s4QT7Z24Wc0+OoJaZ1ELzrpJDOGRonAeIiOcdXv8VsyMbKMJ0TWYyuGzX60DGq8NRl
         PGDBxRxOXvglMap4fjXp7i9FIdQaDxWmFz8jnvyPUZmCVC0IXINZQYB70FVM+4yd7IxR
         30b5T+md1tyrdOJCPuE1Cngx6CDWoH9CMAqGyski9SVCjBzuVxeD2f+Hr9XFwJcCSRxO
         /srQ==
X-Gm-Message-State: AJIora8U3KthRMtFdyTEw74c/JFcpesLkCukhzHSbkD2jIhYuNNQDv50
        FIHrYxWXEsocaFsi1zPC9bt0Ww==
X-Google-Smtp-Source: AGRyM1ve8EpdrHDDtoCMYvUHnzTm2dlt4MX4QTcOCfexmssRE74lOtugg9gSecI8FR/TbYd4g4O9eA==
X-Received: by 2002:a17:902:c2ca:b0:168:db72:16a with SMTP id c10-20020a170902c2ca00b00168db72016amr32526387pla.171.1655865308850;
        Tue, 21 Jun 2022 19:35:08 -0700 (PDT)
Received: from senozhatsky.kddi.com ([240f:75:7537:3187:1922:709:82a7:e4d3])
        by smtp.gmail.com with ESMTPSA id c11-20020a62f84b000000b0051844a64d3dsm11991277pfm.25.2022.06.21.19.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 19:35:08 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: do not lookup algorithm in backends table
Date:   Wed, 22 Jun 2022 11:35:01 +0900
Message-Id: <20220622023501.517125-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Always use crypto_has_comp() so that crypto can lookup module,
call usermodhelper to load the modules, wait for usermodhelper
to finish and so on. Otherwise crypto will do all of these steps
under CPU hot-plug lock and this looks like too much stuff to
handle under the CPU hot-plug lock. Besides this can end up in
a deadlock when usermodhelper triggers a code path that attempts
to lock the CPU hot-plug lock, that zram already holds.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 052aa3f65514..398eb9e24eff 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -63,12 +63,6 @@ static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
 
 bool zcomp_available_algorithm(const char *comp)
 {
-	int i;
-
-	i = sysfs_match_string(backends, comp);
-	if (i >= 0)
-		return true;
-
 	/*
 	 * Crypto does not ignore a trailing new line symbol,
 	 * so make sure you don't supply a string containing
-- 
2.37.0.rc0.104.g0611611a94-goog


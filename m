Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96892C43460
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6972A61447
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhDUKcu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhDUKcp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 06:32:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2812DC06174A
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 03:32:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r128so39127365lff.4
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 03:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CK5ZIEcklumCxnJNLBKoSlxqImVpYTzG5Udsn4Ishsw=;
        b=NfwbLuvjkQ46lE3tfHiUd1UVjBQdEFZFRmA85If0MapK4xLiIpe9e769dDZ/tMC55c
         OyNMD5PBJoUa/4ir6pJ9ZQyPlIGEGyfxJb0MZMAwX0tPdyNGhesy465To4aNY/gdyCkN
         6Sjv0cUpOy7IO3sA8bLNhdru1DzjPFf3fwuHOaZt7usJBpmYnnqK8z2j91sxoOMsbhAu
         T3foVqNKF/vmvUCgp001jS/hjrFtgafpPQExxU0uRl/WLqrcjZVTdiA3y7+0kDTPlHQm
         ZThmzbXndKWHk2E/lVdMzao4cQ4vY1yUIASaLlRVPNyme5YkJHkJveGXTZTOQlrzRq4U
         x1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CK5ZIEcklumCxnJNLBKoSlxqImVpYTzG5Udsn4Ishsw=;
        b=ggt42XCUxmIySIefgTYhEhMozzBldLUHxuS/id2+B1dRpAqkxjCjLWSsU3sM/wHtnU
         7mIoYmAt2q4sfosXMDY/y7cXoaQFvbYSzqVheZCcuBaOnFCkStGWjLbo3LGWUR8WLyy/
         kZxF1RmlCftGcyaQeJ0VsbgJoSI+8ybHJxkmsXRwW/MjARTBhwAsoKQOCmUoa6t51nAt
         61MzAsAli2S60D7cIUgv9sXRN/pmwsNbQY1+guBxyDHRZwSV/TT8e+24jGzDeG4T3c9U
         +zbYBu5EsyIZjIjJlIqQI1zEgqy/723ie+D4PqV0Es0h3dLwjLxfzM6+xPk7ZTsEPrVg
         3lPA==
X-Gm-Message-State: AOAM533j43nznnIfxKSMRLkJwmoKFiXVyLyFNcEBPXCprxeG+A4rneoB
        9lT72qyEH1H6751Rl4eiS+phDA==
X-Google-Smtp-Source: ABdhPJw9+YrZ+qOFFIfvbAx57atTu7H7oJy61BBb5cvZnyc5yynow4ONRd/Z65zuDWLe+Mk9NaNP7w==
X-Received: by 2002:a19:7704:: with SMTP id s4mr20262774lfc.268.1619001127623;
        Wed, 21 Apr 2021 03:32:07 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id u13sm170603lfg.139.2021.04.21.03.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:32:06 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mmc: core: Parse the SD SCR register for support of CMD48/49 and CMD58/59
Date:   Wed, 21 Apr 2021 12:31:51 +0200
Message-Id: <20210421103154.169410-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421103154.169410-1-ulf.hansson@linaro.org>
References: <20210421103154.169410-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In SD spec v4.x the support for CMD48/49 and CMD58/59 were introduced as
optional features. To let the card announce whether it supports the
commands, the SCR register has been extended with corresponding support
bits. Let's parse and store the information.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c    | 4 +++-
 include/linux/mmc/card.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 2c48d6504101..de7b5f8df550 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -222,7 +222,9 @@ static int mmc_decode_scr(struct mmc_card *card)
 	else
 		card->erased_byte = 0x0;
 
-	if (scr->sda_spec3)
+	if (scr->sda_spec4)
+		scr->cmds = UNSTUFF_BITS(resp, 32, 4);
+	else if (scr->sda_spec3)
 		scr->cmds = UNSTUFF_BITS(resp, 32, 2);
 
 	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f9ad35dd6012..858fc4d11240 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -139,6 +139,8 @@ struct sd_scr {
 	unsigned char		cmds;
 #define SD_SCR_CMD20_SUPPORT   (1<<0)
 #define SD_SCR_CMD23_SUPPORT   (1<<1)
+#define SD_SCR_CMD48_SUPPORT   (1<<2)
+#define SD_SCR_CMD58_SUPPORT   (1<<3)
 };
 
 struct sd_ssr {
-- 
2.25.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D65BC433B4
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E769611AC
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhEDQNz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 May 2021 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhEDQNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 May 2021 12:13:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD97C06138E
        for <linux-block@vger.kernel.org>; Tue,  4 May 2021 09:12:50 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j10so14068958lfb.12
        for <linux-block@vger.kernel.org>; Tue, 04 May 2021 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YPvSgtMwuWKmsANJZN3wDrqLMspZZxchfU1o9bNBS0=;
        b=mQphSbjpUQsny9Y+iTx74acCw2RC/7Rw66VAAOnWDQUbQN8E9LjjfCVAzjwDg73JYA
         2IIFyaDZjid8qqdoeGQAIR3C515ImGXr120DHipM+PWv/A7IWFOERw4csxR8Xz3MfWLM
         BXA++rt0qv0y7yOl7xPOtANwFhnssW285d9b7MaIeL/719Jnyeb7Fl7m9GuBgfjiVELN
         ofhx+tgSVyM2kJoNjey09xJSfBxoagBzS0jZrS5u5+1y1oM7dYuX66Vx3x778dqu120z
         AIVs+p3XrD8Ngj1UbGm3GJ74xLM090JwCD/Eh0r13hdXrw6GlBAK/t+2pAA/afENElZM
         c5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YPvSgtMwuWKmsANJZN3wDrqLMspZZxchfU1o9bNBS0=;
        b=VmT0a+di5X9NYGJxy3Gu0O+KjcWisz0yBhvgKa5DtMjadZw8jOECxCnn/Jy8GEqR3R
         MKlQprNWZCcDJY7TLHk+DXUmjmsCNrk6k/NobZmQJJ66iDEjJ/SO+QsMFTtzrJxN4gtc
         qjoo1fdiovsnKq/J46r9Okln2O5ed30IKOL5PUpem/ifaXvyiEiY+umJVElKpasA9H59
         PGex2cRIFobI/QpM9+an43FaZ3wvxJeOImlmaomOx5kq5w3kdprx67kiI2LBeiES++WE
         lEk7f/5iJ+/y/67LHc6ruTvAnMo8EqBIme2DALVQMN7Um3zhWpjPXYxVjSJLmuWtY5+W
         wghA==
X-Gm-Message-State: AOAM5310D4VHYJFyYHDX6CrGiMdzrMBYqPgiCN4rn264HZhPuJ/DVTJH
        XNa56P6DYAmGx08n+ZgKTjIoKA==
X-Google-Smtp-Source: ABdhPJzEg4JyZbtiP7/8bkCcH2v8n2BiNms886QzrgiideGRN2RshaK0sMxOvd1N+Ux3WM8cYYi4Ig==
X-Received: by 2002:a05:6512:c0a:: with SMTP id z10mr17587062lfu.467.1620144768925;
        Tue, 04 May 2021 09:12:48 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:48 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] mmc: core: Parse the SD SCR register for support of CMD48/49 and CMD58/59
Date:   Tue,  4 May 2021 18:12:19 +0200
Message-Id: <20210504161222.101536-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In SD spec v4.x the support for CMD48/49 and CMD58/59 were introduced as
optional features. To let the card announce whether it supports the
commands, the SCR register has been extended with corresponding support
bits. Let's parse and store this information for later use.

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


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E836C433B4
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33376613B3
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhEDQNg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 May 2021 12:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhEDQNe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 May 2021 12:13:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C8C061761
        for <linux-block@vger.kernel.org>; Tue,  4 May 2021 09:12:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j10so14067987lfb.12
        for <linux-block@vger.kernel.org>; Tue, 04 May 2021 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EaNyrJPx800SxJDWlIRfuBN901wRckS9/iskflhAQE=;
        b=rLqzdYDt2bR1nt+32bTw5Wj2OBKwKaY9mrTO+TeMNsCSJDdsSHogYHXYq5aVUojavE
         3LCmWXYW2vY3UAjcjB/f3iKc/sj6kaqqMUPm4/EO9RaJa6D6V5mAWSivkj7fGhnKWuAV
         UrvtBimlKBhnhYKItjnUr1wwzR9g4K7+MjnfkHv9MyLN6ZNtmBhyFXD1gUiCVeObhn8R
         9rT7bJ6X7D4bzJG7yDkJ6XVoqMPt1cZICN+UiFYlAIS0c8ftRV2e172076Fxst9vrAo7
         VralKmATjvw3d4BaT3+vwxzZPv4NA3r48RUgGFmcu+i085fi3Cdgy0POR82KLLN+201j
         36hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EaNyrJPx800SxJDWlIRfuBN901wRckS9/iskflhAQE=;
        b=rCsJr6qhu010+9iIGOiJnlXDOkd00Na+OpJpxcVgb7caAyn1H27uC4arRlUjbKp1bg
         cYJkarouTz7mEYYLDnmjOx5Oh/HaE9o/xM7+aiIMlDS0w+tteEKaUOBeG6+2bXh0q62+
         x6xIwz8IYtA8ioGxiOjZM29JCRiRT8VfO4a2aF0RI9rxy0huS9D5Pofy0EYMI+4UyLE4
         skmbzQYsdaysAu6sCT9RP5Qv+Liiz5KQyY6GZRKrEQ3etSrTS3xSzPeIidxPkpokr376
         gJumqAyDPceysI/QI1QiuRmrRaG8WrnpLFmLjKkeRqPYr9+aNNb/jvNRnmZD+EHIPcmt
         PLWA==
X-Gm-Message-State: AOAM533oP+ETMQ132RQQWtctyOb/ocnANTCBLc+Q+/dMDtuSB9hovhsw
        63DwxAshuPKuRnQ3FtTMsMXJ/A==
X-Google-Smtp-Source: ABdhPJwJgHrJrftbsHwgtxIfiKijEzdjusVilj+/efOsaaWnqgmRssrUyapG+NpbSFPTrxS8x3rgWA==
X-Received: by 2002:ac2:5fcb:: with SMTP id q11mr17218402lfg.248.1620144756714;
        Tue, 04 May 2021 09:12:36 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:35 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] mmc: core: Take into account MMC_CAP_NEED_RSP_BUSY for eMMC HPI commands
Date:   Tue,  4 May 2021 18:12:13 +0200
Message-Id: <20210504161222.101536-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In mmc_send_hpi_cmd() the host->max_busy_timeout is being validated towards
the timeout for the eMMC HPI command, as to decide whether an R1 or R1B
response should be used.

Although, it has turned out the some host can't cope with that conversion,
but needs R1B, which means MMC_CAP_NEED_RSP_BUSY is set for them. Let's
take this into account, via using the common mmc_prepare_busy_cmd() when
doing the validation, which also avoids some open coding.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 025a4134d5c7..66ae699a410f 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -817,28 +817,17 @@ static int mmc_send_hpi_cmd(struct mmc_card *card)
 {
 	unsigned int busy_timeout_ms = card->ext_csd.out_of_int_time;
 	struct mmc_host *host = card->host;
-	bool use_r1b_resp = true;
+	bool use_r1b_resp = false;
 	struct mmc_command cmd = {};
 	int err;
 
 	cmd.opcode = card->ext_csd.hpi_cmd;
 	cmd.arg = card->rca << 16 | 1;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 
-	/*
-	 * Make sure the host's max_busy_timeout fit the needed timeout for HPI.
-	 * In case it doesn't, let's instruct the host to avoid HW busy
-	 * detection, by using a R1 response instead of R1B.
-	 */
-	if (host->max_busy_timeout && busy_timeout_ms > host->max_busy_timeout)
-		use_r1b_resp = false;
-
-	if (cmd.opcode == MMC_STOP_TRANSMISSION && use_r1b_resp) {
-		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
-		cmd.busy_timeout = busy_timeout_ms;
-	} else {
-		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
-		use_r1b_resp = false;
-	}
+	if (cmd.opcode == MMC_STOP_TRANSMISSION)
+		use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd,
+						    busy_timeout_ms);
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err) {
-- 
2.25.1


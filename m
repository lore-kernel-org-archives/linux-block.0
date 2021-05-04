Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5BCC433ED
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E40613BE
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhEDQNu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 May 2021 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhEDQNo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 May 2021 12:13:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9190EC06138A
        for <linux-block@vger.kernel.org>; Tue,  4 May 2021 09:12:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x2so14090086lff.10
        for <linux-block@vger.kernel.org>; Tue, 04 May 2021 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnseO+HlWfm8PnP329KlCqz9KF+klL6BviqqSWTWuio=;
        b=lgIb6O2YX+Ez0RMKw2US7fma0pchqhR4ksTVapAcxtj4ryBpTR93IrbfTqcGMVMAPL
         rxvWkxeBiHUzjrxc52/H0TDvuEw7y3w9XqDH59uP0LDM0HAEKWVvDGpvznJ1Tp0YjcKE
         lDHoyyuqx+7iGXZv3dfcz6jCik43KPq46pPmTKQvyOwQUxjm+ECvEDM5G6F7fRyNt5+z
         IEmxzZi8sEODp1XIe5hTgspTD+ANs14cC7FGdv4E5JURrrQwm3uRAEhM7hDtwl51KInE
         J9+zp26pXYSmhtdunLd728m1ItkWJLG4+ytaYzejqFlLqiJVzhr8EK6vyhM5/nc7mMEM
         VRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnseO+HlWfm8PnP329KlCqz9KF+klL6BviqqSWTWuio=;
        b=Elsqw9iYhe6b3OAIzlgxU+HlD256wV/7hVvH6zFGo90xXW2cX3yp1dbsslm1ptQMJz
         7WufWc9hSu9UoZpep+qJlYlpKbN5fZiLnN2R8TUEOugZlsjgNRHTtiGySV2QjpOP41cP
         jJcVcm2UrHSYkInZuCL+oZPO8/g8kMgv904rS5SOL1zYH/nxQ5OE0kE2SncA2WdBSvgL
         NBtyrOBVC8iwnWP1+D6Jcn+H61Qom0J0Us2RFLRXlDI5z7O/vQl6EMXARS7ccDzRrIXv
         jK4LZL8Y4+OT0ubsYlRftnGGd5jOQvCl9QuzGszUgM3NAWKKAi67VuQTMLjwiOhwKFMy
         4YDg==
X-Gm-Message-State: AOAM532wkWMLtxmP7yrJGqCFoBNHOODuf03lZHVjOEHhV7xaucSUzJKE
        iK4jwU3oyntjf6druyOUuzOokw==
X-Google-Smtp-Source: ABdhPJztL23XdscbpvYGwlpduSQ+/7dS5kub7ci6q1CTV7oAB7WUi7fOy7SpxGt3MMA8cz6xqA4yOw==
X-Received: by 2002:ac2:5289:: with SMTP id q9mr3001194lfm.141.1620144766986;
        Tue, 04 May 2021 09:12:46 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:45 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] mmc: core: Drop open coding in mmc_sd_switch()
Date:   Tue,  4 May 2021 18:12:18 +0200
Message-Id: <20210504161222.101536-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The SD_SWITCH (CMD6) is an ADTC type of command with an R1 response, which
can be sent by using the mmc_send_adtc_data(). Let's do that and drop the
open coding in mmc_sd_switch().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd_ops.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index d61ff811218c..ef8d1dce5af1 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -17,6 +17,7 @@
 
 #include "core.h"
 #include "sd_ops.h"
+#include "mmc_ops.h"
 
 int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 {
@@ -309,43 +310,18 @@ int mmc_app_send_scr(struct mmc_card *card)
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp)
 {
-	struct mmc_request mrq = {};
-	struct mmc_command cmd = {};
-	struct mmc_data data = {};
-	struct scatterlist sg;
+	u32 cmd_args;
 
 	/* NOTE: caller guarantees resp is heap-allocated */
 
 	mode = !!mode;
 	value &= 0xF;
+	cmd_args = mode << 31 | 0x00FFFFFF;
+	cmd_args &= ~(0xF << (group * 4));
+	cmd_args |= value << (group * 4);
 
-	mrq.cmd = &cmd;
-	mrq.data = &data;
-
-	cmd.opcode = SD_SWITCH;
-	cmd.arg = mode << 31 | 0x00FFFFFF;
-	cmd.arg &= ~(0xF << (group * 4));
-	cmd.arg |= value << (group * 4);
-	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
-
-	data.blksz = 64;
-	data.blocks = 1;
-	data.flags = MMC_DATA_READ;
-	data.sg = &sg;
-	data.sg_len = 1;
-
-	sg_init_one(&sg, resp, 64);
-
-	mmc_set_data_timeout(&data, card);
-
-	mmc_wait_for_req(card->host, &mrq);
-
-	if (cmd.error)
-		return cmd.error;
-	if (data.error)
-		return data.error;
-
-	return 0;
+	return mmc_send_adtc_data(card, card->host, SD_SWITCH, cmd_args, resp,
+				  64);
 }
 
 int mmc_app_sd_status(struct mmc_card *card, void *ssr)
-- 
2.25.1


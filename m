Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D3C2BB1D
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4377720738
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzBGmC2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgCPKB6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:01:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39478 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbgCPKB6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 06:01:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id b22so3465273pgb.6;
        Mon, 16 Mar 2020 03:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Q4WERU23Ab7PcOBZcBpvQyi0PCrcF6eJaP+MB28aUbM=;
        b=SzBGmC2xzyNqEKrq6zmZ/gWFxo0axM7r5PoB4ZwwLa3UCvtF7iagYTXmDw2qwnZl4i
         UYVwBE82t0vztwiTjzcaVqBdTVKFUNHz8wYcgWBcuDhqsUlAxdUnt/DFBR91js6Mg0tC
         QDZqI7lhpCIMIfVmyRzh1UOYhIXBVvr0xFb8lMgOqSf4UyTuEUlTEArpcYTJVIPiGGB1
         77C9KW4gV0GYi60w0vtRFbwHkMuRTNuf4NAfeYpN71svZdGX0cW6ZRQXAQoXFc3Q9Hib
         gjSGmTQ9XGMsvAymXl23yLdbdMh4MRYmvQUM25qgRYmrXBZE5KyFSet+rLNOfcaKbe4m
         xP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Q4WERU23Ab7PcOBZcBpvQyi0PCrcF6eJaP+MB28aUbM=;
        b=X2Iuugui9LE2Rs0C9aoB3QWDe/3hcoVscoSKN9tzX5pr7EotJjdo/V1vI9LU+ATzQd
         VcDBaF1va0nrOTMxsw6z3qK7aOlxEMeDZnNLZ/3owg88jKm7ECH2GSk5LeKOF5VCbxLm
         r4B52coRwM6UzLtS+QacKgSWB4V8Wul+p8oEL9WdBrsaHCuKrkdXK/LtA89tAVM3fEV8
         7C9Nwrh66UCPAhrDTRkr3zv9FfrUjLgd0L8/0GDZuarR5Kcp9tNGmYPNLRTnRh5qALcH
         c4wxXaGTG9Co96liYmV1mu1GuIpO1hDepHOIM/cB09mC0bx4vRdsGsxIbvjklnxPrtUO
         uPng==
X-Gm-Message-State: ANhLgQ1CisC2l9gCoyPOxZ7nqqDeXU9gW0qVwR3nLmIcIgEqCyrYiyOM
        FCLsJ2nMUlQ3AegIQlqY5ke4hZzp
X-Google-Smtp-Source: ADFU+vsOjwgwiCflCAIn/1XeF2qeFlGf02DBu2ZzA6GEmI3RFf8htlNOgtkFopSKF3oVBRfW0yySEg==
X-Received: by 2002:a63:7c4:: with SMTP id 187mr25515308pgh.369.1584352917078;
        Mon, 16 Mar 2020 03:01:57 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 136sm63970411pgh.26.2020.03.16.03.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 03:01:56 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     ming.lei@redhat.com, arnd@arndb.de, linus.walleij@linaro.org,
        baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH 5/8] mmc: host: sdhci: Factor out the command configuration
Date:   Mon, 16 Mar 2020 18:01:22 +0800
Message-Id: <c8695e335acf59fc098f9ba238ba8cb33d9fd5eb.1584350380.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the SD command configuration into one separate function to simplify
the sdhci_send_command(). Moreover this function can be used to support
ADMA3 transfer mode in following patches.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c | 65 ++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6238b5c..4de0f48 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1546,9 +1546,43 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	}
 }
 
-void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+static int sdhci_get_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
+
+	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
+		pr_err("%s: Unsupported response type!\n",
+			mmc_hostname(host->mmc));
+		cmd->error = -EINVAL;
+		sdhci_finish_mrq(host, cmd->mrq);
+		return -EINVAL;
+	}
+
+	if (!(cmd->flags & MMC_RSP_PRESENT))
+		flags = SDHCI_CMD_RESP_NONE;
+	else if (cmd->flags & MMC_RSP_136)
+		flags = SDHCI_CMD_RESP_LONG;
+	else if (cmd->flags & MMC_RSP_BUSY)
+		flags = SDHCI_CMD_RESP_SHORT_BUSY;
+	else
+		flags = SDHCI_CMD_RESP_SHORT;
+
+	if (cmd->flags & MMC_RSP_CRC)
+		flags |= SDHCI_CMD_CRC;
+	if (cmd->flags & MMC_RSP_OPCODE)
+		flags |= SDHCI_CMD_INDEX;
+
+	/* CMD19 is special in that the Data Present Select should be set */
+	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
+		flags |= SDHCI_CMD_DATA;
+
+	return SDHCI_MAKE_CMD(cmd->opcode, flags);
+}
+
+void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int command;
 	u32 mask;
 	unsigned long timeout;
 
@@ -1605,32 +1639,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_mode(host, cmd);
 
-	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
-		pr_err("%s: Unsupported response type!\n",
-			mmc_hostname(host->mmc));
-		cmd->error = -EINVAL;
-		sdhci_finish_mrq(host, cmd->mrq);
+	command = sdhci_get_command(host, cmd);
+	if (command < 0)
 		return;
-	}
-
-	if (!(cmd->flags & MMC_RSP_PRESENT))
-		flags = SDHCI_CMD_RESP_NONE;
-	else if (cmd->flags & MMC_RSP_136)
-		flags = SDHCI_CMD_RESP_LONG;
-	else if (cmd->flags & MMC_RSP_BUSY)
-		flags = SDHCI_CMD_RESP_SHORT_BUSY;
-	else
-		flags = SDHCI_CMD_RESP_SHORT;
-
-	if (cmd->flags & MMC_RSP_CRC)
-		flags |= SDHCI_CMD_CRC;
-	if (cmd->flags & MMC_RSP_OPCODE)
-		flags |= SDHCI_CMD_INDEX;
-
-	/* CMD19 is special in that the Data Present Select should be set */
-	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
-	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
-		flags |= SDHCI_CMD_DATA;
 
 	timeout = jiffies;
 	if (host->data_timeout)
@@ -1644,7 +1655,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (host->use_external_dma)
 		sdhci_external_dma_pre_transfer(host, cmd);
 
-	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+	sdhci_writew(host, command, SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
-- 
1.9.1


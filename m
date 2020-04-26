Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27299C55191
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039832087E
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiR2f8Xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDZJjq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDZJjp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 05:39:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC64C061A0C;
        Sun, 26 Apr 2020 02:39:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t4so5690330plq.12;
        Sun, 26 Apr 2020 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+QEhf3M5Igm5iNJj2Bt8CwRfIM8IHL4FnOPbueXCCPo=;
        b=hiR2f8XgdQ4I4r71PfG/KeE3EZ47aPHssKMJU89Wr1lDfX6ijt6JPrw9Lbwc2OQG6O
         +bA7LiZhSe0B+gIp2wvEpb9x4tTrZ5zFSPBLMcpteDJ7s30klQV9xo/KbzThWZaKtot2
         NrEoFprn7ZmnxQx042ee4ecdyIA0i21JWRixBeT4TuH7gsRSSWmOe+omGrUO+gO6JyEn
         0nhP8zbtA7AzSNO5SStNfT8EzZmDKe2QTu09A01khKjrjy/GTpxGaNSaPl/FGiJwiEC6
         2kZg+kzrLe8PYmIOMeviJgZvWEeThEtEo9h/QbG0Xq9b0sqa67VU4k8yT5YXpA11uEvu
         uGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+QEhf3M5Igm5iNJj2Bt8CwRfIM8IHL4FnOPbueXCCPo=;
        b=bOThbyz/yF/fKZRglwyhul3cdVhrJACQlLKV11VHcW2YUQ1QvIWkgGG2p9dqz/NIyu
         NY66SEE/vi8XV0B0PyyH0TRGjKpRNST8pSUkTwqCKdn3hWEpdKeRXULZohm+p9Df8DIT
         luARaIj4gZBg+qDD75Oi8pe44lr7nG6f8a58//1KC6WewN51T1xLR8dyU1ibMb8fgBVw
         V6R9Q439TMfhiB/KQxeDcAoqj8C7Hn95tTs20U0shSFFDYEIpSBsJtBSIwDfJSZ/dhhq
         dzXGkmB1lYPA8joWT4Tlk3aT+0zZLCpgGeuTH+ti7OybB4siSfH6lrarUGFnsX4/Ibua
         LWjg==
X-Gm-Message-State: AGi0Puavaa8mNQTT4sKd1UtZwIETISKuTVbkjGIAmrSK32Jy0t/uJ1R3
        /Sd2yxdgqOFcJWypyWHh6hk=
X-Google-Smtp-Source: APiQypJvMEOJoozchy31fePl6Vzd0HO0P2V8U0e4UIDo1s895zEIYSUmgGRJeRzTUrfOmDv6sfsL6g==
X-Received: by 2002:a17:902:8543:: with SMTP id d3mr17492120plo.314.1587893985373;
        Sun, 26 Apr 2020 02:39:45 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id m129sm1835245pga.47.2020.04.26.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 02:39:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, linus.walleij@linaro.org, paolo.valente@linaro.org,
        ming.lei@redhat.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/7] mmc: host: sdhci: Factor out the command configuration
Date:   Sun, 26 Apr 2020 17:38:57 +0800
Message-Id: <c021fa8991c8be8aa28d1268a44be559e94db2de.1587888520.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the SD command configuration into one separate function to simplify
the sdhci_send_command(). Moreover this function can be used to support
ADMA3 transfer mode in following patches.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c | 69 +++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index afea8393c71f..3d4cdf0e0535 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1579,9 +1579,45 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	__sdhci_finish_data(host, false);
 }
 
-static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+static int sdhci_get_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
+
+	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
+		WARN_ONCE(1, "Unsupported response type!\n");
+		/*
+		 * This does not happen in practice because 136-bit response
+		 * commands never have busy waiting, so rather than complicate
+		 * the error path, just remove busy waiting and continue.
+		 */
+		cmd->flags &= ~MMC_RSP_BUSY;
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
+static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int command;
 	u32 mask;
 	unsigned long timeout;
 
@@ -1625,34 +1661,7 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_mode(host, cmd);
 
-	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
-		WARN_ONCE(1, "Unsupported response type!\n");
-		/*
-		 * This does not happen in practice because 136-bit response
-		 * commands never have busy waiting, so rather than complicate
-		 * the error path, just remove busy waiting and continue.
-		 */
-		cmd->flags &= ~MMC_RSP_BUSY;
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
+	command = sdhci_get_command(host, cmd);
 
 	timeout = jiffies;
 	if (host->data_timeout)
@@ -1666,7 +1675,7 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (host->use_external_dma)
 		sdhci_external_dma_pre_transfer(host, cmd);
 
-	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+	sdhci_writew(host, command, SDHCI_COMMAND);
 
 	return true;
 }
-- 
2.17.1


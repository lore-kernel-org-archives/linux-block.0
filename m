Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD06DC43461
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF352613BA
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhEDQNc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 May 2021 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhEDQNb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 May 2021 12:13:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD5C061574
        for <linux-block@vger.kernel.org>; Tue,  4 May 2021 09:12:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t11so12589616lfl.11
        for <linux-block@vger.kernel.org>; Tue, 04 May 2021 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3a82EmNZunJK3ZJbNP0JbGj7NLetG3uE0s2MHagCq3U=;
        b=wxyfiIk9ZRKFFMu7Qtt5D/PUwNqqFhRB8Wcgj+YyHPHc5cUKgZgwxGiMfRwQCKCNM8
         EgWBJpOWPBZhW+XZQhEd32rkfi5DSS9AD3cI21p5SQcsSpTZAhlcmllGAhet3/MF/J3p
         s33FUkYxOw0T+Z5SMErf9E6yFlscuq5QRNlfX9bnJsKOZ4FjvE6BYu+6TLz4IiAnoSeR
         bz2shSeX3nc3ijfLvYIiNwG89kPrzMh7qZzQNtb4eX/tiLyb7DpOV6oJHln6oWaOvv3D
         yN6TRqQNfZfq+1iiZUayBPeByWBNMGnWz10iGW9p55E/ULKjQL6XKyZptpm0iXpKmcva
         116Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3a82EmNZunJK3ZJbNP0JbGj7NLetG3uE0s2MHagCq3U=;
        b=Juok99ARx5+E6M4KW2mH9aLEeFgpUuKVJZbx7Km6N2v1DTKY3H1zlSoZxTv2vxwGlX
         p1KYCUPxElo1BCfQCRMa2LaKe4ymyXDqum++weZOpxoj0mJamDDxUN9wboohZqcMN7m2
         NNSmjhRpJ6p4EVNCE9Wb3yMqJRprpJVrCekUkdJsEUMhN3Dp/44xIlYJc03MppDW/Zla
         SaXqpdt13Ecb2RMqGV8a9z8dlGg4D1jSbPSn3FwfQw8yCIBAOncxwVHls+US/28cjZ/E
         vEtX2y3f5KQxjt59tf5GrBaYRQAG1JaLkJUWVuKo3W7UKBnHzfiw4yNkqnCGQ+Q5rscj
         vT+g==
X-Gm-Message-State: AOAM532WYFUsnTh2FVEt55FgwuGj+qMH5iMaRRoeZArjT/vLlmQ+e52K
        QG70kMgKxlIBqu8bDmwjNz8njQ==
X-Google-Smtp-Source: ABdhPJy5ytaKbLf4TX6lQSUesKQr3QHIJFShNZOFpX3OXVXBNCo7ueewQGWviNbTDs02xbIDL2YzkQ==
X-Received: by 2002:a19:c510:: with SMTP id w16mr17895584lfe.433.1620144754632;
        Tue, 04 May 2021 09:12:34 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:33 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] mmc: core: Drop open coding when preparing commands with busy signaling
Date:   Tue,  4 May 2021 18:12:12 +0200
Message-Id: <20210504161222.101536-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similar code for validating the host->max_busy_timeout towards the current
command's busy timeout, exists in mmc_do_erase(), mmc_sleep() and
__mmc_switch(). Let's move the common code into a helper function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    | 20 ++----------------
 drivers/mmc/core/mmc.c     | 20 +++---------------
 drivers/mmc/core/mmc_ops.c | 42 +++++++++++++++++++++-----------------
 drivers/mmc/core/mmc_ops.h |  3 +++
 4 files changed, 31 insertions(+), 54 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f194940c5974..b00c84ea8441 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1582,7 +1582,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 {
 	struct mmc_command cmd = {};
 	unsigned int qty = 0, busy_timeout = 0;
-	bool use_r1b_resp = false;
+	bool use_r1b_resp;
 	int err;
 
 	mmc_retune_hold(card->host);
@@ -1650,23 +1650,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	cmd.opcode = MMC_ERASE;
 	cmd.arg = arg;
 	busy_timeout = mmc_erase_timeout(card, arg, qty);
-	/*
-	 * If the host controller supports busy signalling and the timeout for
-	 * the erase operation does not exceed the max_busy_timeout, we should
-	 * use R1B response. Or we need to prevent the host from doing hw busy
-	 * detection, which is done by converting to a R1 response instead.
-	 * Note, some hosts requires R1B, which also means they are on their own
-	 * when it comes to deal with the busy timeout.
-	 */
-	if (!(card->host->caps & MMC_CAP_NEED_RSP_BUSY) &&
-	    card->host->max_busy_timeout &&
-	    busy_timeout > card->host->max_busy_timeout) {
-		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
-	} else {
-		cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-		cmd.busy_timeout = busy_timeout;
-		use_r1b_resp = true;
-	}
+	use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout);
 
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8674c3e0c02c..63a7bd0b239c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1910,6 +1910,7 @@ static int mmc_sleep(struct mmc_host *host)
 	struct mmc_command cmd = {};
 	struct mmc_card *card = host->card;
 	unsigned int timeout_ms = DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000);
+	bool use_r1b_resp;
 	int err;
 
 	/* Re-tuning can't be done once the card is deselected */
@@ -1922,22 +1923,7 @@ static int mmc_sleep(struct mmc_host *host)
 	cmd.opcode = MMC_SLEEP_AWAKE;
 	cmd.arg = card->rca << 16;
 	cmd.arg |= 1 << 15;
-
-	/*
-	 * If the max_busy_timeout of the host is specified, validate it against
-	 * the sleep cmd timeout. A failure means we need to prevent the host
-	 * from doing hw busy detection, which is done by converting to a R1
-	 * response instead of a R1B. Note, some hosts requires R1B, which also
-	 * means they are on their own when it comes to deal with the busy
-	 * timeout.
-	 */
-	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
-	    (timeout_ms > host->max_busy_timeout)) {
-		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
-	} else {
-		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
-		cmd.busy_timeout = timeout_ms;
-	}
+	use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err)
@@ -1949,7 +1935,7 @@ static int mmc_sleep(struct mmc_host *host)
 	 * SEND_STATUS command to poll the status because that command (and most
 	 * others) is invalid while the card sleeps.
 	 */
-	if (!cmd.busy_timeout || !(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
+	if (!use_r1b_resp || !(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
 		mmc_delay(timeout_ms);
 
 out_release:
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5756781fef37..025a4134d5c7 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -521,6 +521,27 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	return __mmc_poll_for_busy(card, timeout_ms, true, false, busy_cmd);
 }
 
+bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
+			  unsigned int timeout_ms)
+{
+	/*
+	 * If the max_busy_timeout of the host is specified, make sure it's
+	 * enough to fit the used timeout_ms. In case it's not, let's instruct
+	 * the host to avoid HW busy detection, by converting to a R1 response
+	 * instead of a R1B. Note, some hosts requires R1B, which also means
+	 * they are on their own when it comes to deal with the busy timeout.
+	 */
+	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
+	    (timeout_ms > host->max_busy_timeout)) {
+		cmd->flags = MMC_CMD_AC | MMC_RSP_SPI_R1 | MMC_RSP_R1;
+		return false;
+	}
+
+	cmd->flags = MMC_CMD_AC | MMC_RSP_SPI_R1B | MMC_RSP_R1B;
+	cmd->busy_timeout = timeout_ms;
+	return true;
+}
+
 /**
  *	__mmc_switch - modify EXT_CSD register
  *	@card: the MMC card associated with the data transfer
@@ -543,7 +564,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	struct mmc_host *host = card->host;
 	int err;
 	struct mmc_command cmd = {};
-	bool use_r1b_resp = true;
+	bool use_r1b_resp;
 	unsigned char old_timing = host->ios.timing;
 
 	mmc_retune_hold(host);
@@ -554,29 +575,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		timeout_ms = card->ext_csd.generic_cmd6_time;
 	}
 
-	/*
-	 * If the max_busy_timeout of the host is specified, make sure it's
-	 * enough to fit the used timeout_ms. In case it's not, let's instruct
-	 * the host to avoid HW busy detection, by converting to a R1 response
-	 * instead of a R1B. Note, some hosts requires R1B, which also means
-	 * they are on their own when it comes to deal with the busy timeout.
-	 */
-	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
-	    (timeout_ms > host->max_busy_timeout))
-		use_r1b_resp = false;
-
 	cmd.opcode = MMC_SWITCH;
 	cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
 		  (index << 16) |
 		  (value << 8) |
 		  set;
-	cmd.flags = MMC_CMD_AC;
-	if (use_r1b_resp) {
-		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
-		cmd.busy_timeout = timeout_ms;
-	} else {
-		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
-	}
+	use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
 
 	err = mmc_wait_for_cmd(host, &cmd, retries);
 	if (err)
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 7bc1cfb0654c..ba898c435658 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -18,6 +18,7 @@ enum mmc_busy_cmd {
 
 struct mmc_host;
 struct mmc_card;
+struct mmc_command;
 
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
@@ -35,6 +36,8 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width);
 int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
+bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
+			  unsigned int timeout_ms);
 int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		      enum mmc_busy_cmd busy_cmd);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
-- 
2.25.1


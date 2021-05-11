Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F109CC433ED
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 10:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C1361925
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 10:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhEKKPO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhEKKPO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 06:15:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4866C061574
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 03:14:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x20so27842753lfu.6
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvnmS1XNpYi/1Cs5zdQrt1BI+Y4XJuywPnU5ry3BGJw=;
        b=Ga33qqoqQpQYHEJ9OCV813urk8/X4ETDke9bsUDntYHxsvNx4fxYT1DJJALFLwhtgm
         TER2U3K8IO5ycBsuJsUyE77paYSwwMAsd/RWk68+G9oe02jJQMfjF6sI2mbuCA3APJBX
         NcR5Pr8GMcPOXLNGY/X43rTfFnnV6MozNDuKukxVfSq8lXF0OkI7M/X7e+q7HrcV1Pyl
         GQlIBoxb7NoHAp5uq/RBNlSmHLhuOJYc5J/xvX55eOVlvHUOiQSUxbB2vV/6d53XDrS3
         VVpfOGPLY0DqJxW1sDJrtlf10LSinw2uKN0i+N+TTHF8BHhlDE/XGFF9/qkkcqT2C35d
         h7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvnmS1XNpYi/1Cs5zdQrt1BI+Y4XJuywPnU5ry3BGJw=;
        b=K0DPemQ2kMlrT5xpkKq84c7HcsK6idcTf1jtD6RPJO3KUbvU/6NHYnbA7otIkU+0JX
         9nAlTeuGTB2zd5X56NYM4lViKEqkYEGsETC206qfU4vm5V4w+NeaLrrqjORKSA2lsXEB
         KSKae9TMKjg0zLM0scKcAwiSscptCbLaZfu/vlnxl2xm81Z0xNgyghHcW3H1OHaRsoL6
         2DmS+rN1H7nAOOeDt/+RDWjY0xaaNcaWWNPxiRRa8Vo7eNxqAx0VqBD4NwHxHAE+f0WI
         YysnPgGqyHiojMJiLRx12F8p0zpFeN2yfJdjZQNpZOaWDDxuXJy5Ql8cbfqheNILSeXK
         Zowg==
X-Gm-Message-State: AOAM533pn0R7K7CtndZ6vsuBc1XqusTPrBt8tZNqzQmA+bvZ9m6bLjFt
        LN8oKiJPsX3xO+3B77xxH+xIyg==
X-Google-Smtp-Source: ABdhPJwl4rNi9VWZDhhm6VA5/PkL5tMu1aDKCgx4P2kmP6mUPTQN+h5SaBJOOuaZUqW5BYx3COPDUw==
X-Received: by 2002:a05:6512:239b:: with SMTP id c27mr12988472lfv.284.1620728045362;
        Tue, 11 May 2021 03:14:05 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id y13sm2570660lfl.252.2021.05.11.03.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 03:14:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: core: Add support for cache ctrl for SD cards
Date:   Tue, 11 May 2021 12:13:59 +0200
Message-Id: <20210511101359.83521-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In SD spec v6.x the SD function extension registers for performance
enhancements were introduced. As a part of this an optional internal cache
on the SD card, can be used to improve performance.

The let the SD card use the cache, the host needs to enable it and manage
flushing of the cache, so let's add support for this.

Note that for an SD card supporting the cache it's mandatory for it, to
also support the poweroff notification feature. According to the SD spec,
if the cache has been enabled and a poweroff notification is sent to the
card, that implicitly also means that the card should flush its internal
cache. Therefore, dealing with cache flushing for REQ_OP_FLUSH block
requests is sufficient.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
 - Converted to use the BIT() macro for clarification, as suggested by Linus.
 - Reset SD_EXT_PERF_CACHE bit when cache enable fails, as suggested by Avri.

Note that:
 - I decided to keep the error path when failing to enable the cache. It's
seems more robust, as it's unclear what happens with the SD card at failure.
Additionally, if improvements are needed we can make it on top.

---
 drivers/mmc/core/mmc_ops.c |   1 +
 drivers/mmc/core/mmc_ops.h |   1 +
 drivers/mmc/core/sd.c      | 100 +++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h   |   1 +
 4 files changed, 103 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index af423acc4c88..3c58f6d0f482 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -456,6 +456,7 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
 		err = R1_STATUS(status) ? -EIO : 0;
 		break;
 	case MMC_BUSY_HPI:
+	case MMC_BUSY_EXTR_SINGLE:
 		break;
 	default:
 		err = -EINVAL;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index c3c1d9c2577e..41ab4f573a31 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -14,6 +14,7 @@ enum mmc_busy_cmd {
 	MMC_BUSY_CMD6,
 	MMC_BUSY_ERASE,
 	MMC_BUSY_HPI,
+	MMC_BUSY_EXTR_SINGLE,
 };
 
 struct mmc_host;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index bd40c682d264..781c1e24308c 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -67,6 +67,7 @@ static const unsigned int sd_au_size[] = {
 	})
 
 #define SD_POWEROFF_NOTIFY_TIMEOUT_MS 2000
+#define SD_WRITE_EXTR_SINGLE_TIMEOUT_MS 1000
 
 struct sd_busy_data {
 	struct mmc_card *card;
@@ -1287,6 +1288,96 @@ static int sd_read_ext_regs(struct mmc_card *card)
 	return err;
 }
 
+static bool sd_cache_enabled(struct mmc_host *host)
+{
+	return host->card->ext_perf.feature_enabled & SD_EXT_PERF_CACHE;
+}
+
+static int sd_flush_cache(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+	u8 *reg_buf, fno, page;
+	u16 offset;
+	int err;
+
+	if (!sd_cache_enabled(host))
+		return 0;
+
+	reg_buf = kzalloc(512, GFP_KERNEL);
+	if (!reg_buf)
+		return -ENOMEM;
+
+	/*
+	 * Set Flush Cache at bit 0 in the performance enhancement register at
+	 * 261 bytes offset.
+	 */
+	fno = card->ext_perf.fno;
+	page = card->ext_perf.page;
+	offset = card->ext_perf.offset + 261;
+
+	err = sd_write_ext_reg(card, fno, page, offset, BIT(0));
+	if (err) {
+		pr_warn("%s: error %d writing Cache Flush bit\n",
+			mmc_hostname(host), err);
+		goto out;
+	}
+
+	err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
+				MMC_BUSY_EXTR_SINGLE);
+	if (err)
+		goto out;
+
+	/*
+	 * Read the Flush Cache bit. The card shall reset it, to confirm that
+	 * it's has completed the flushing of the cache.
+	 */
+	err = sd_read_ext_reg(card, fno, page, offset, 1, reg_buf);
+	if (err) {
+		pr_warn("%s: error %d reading Cache Flush bit\n",
+			mmc_hostname(host), err);
+		goto out;
+	}
+
+	if (reg_buf[0] & BIT(0))
+		err = -ETIMEDOUT;
+out:
+	kfree(reg_buf);
+	return err;
+}
+
+static int sd_enable_cache(struct mmc_card *card)
+{
+	u8 *reg_buf;
+	int err;
+
+	card->ext_perf.feature_enabled &= ~SD_EXT_PERF_CACHE;
+
+	reg_buf = kzalloc(512, GFP_KERNEL);
+	if (!reg_buf)
+		return -ENOMEM;
+
+	/*
+	 * Set Cache Enable at bit 0 in the performance enhancement register at
+	 * 260 bytes offset.
+	 */
+	err = sd_write_ext_reg(card, card->ext_perf.fno, card->ext_perf.page,
+			       card->ext_perf.offset + 260, BIT(0));
+	if (err) {
+		pr_warn("%s: error %d writing Cache Enable bit\n",
+			mmc_hostname(card->host), err);
+		goto out;
+	}
+
+	err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
+				MMC_BUSY_EXTR_SINGLE);
+	if (!err)
+		card->ext_perf.feature_enabled |= SD_EXT_PERF_CACHE;
+
+out:
+	kfree(reg_buf);
+	return err;
+}
+
 /*
  * Handle the detection and initialisation of a card.
  *
@@ -1442,6 +1533,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
+	/* Enable internal SD cache if supported. */
+	if (card->ext_perf.feature_support & SD_EXT_PERF_CACHE) {
+		err = sd_enable_cache(card);
+		if (err)
+			goto free_card;
+	}
+
 	if (host->cqe_ops && !host->cqe_enabled) {
 		err = host->cqe_ops->cqe_enable(host, card);
 		if (!err) {
@@ -1694,6 +1792,8 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.alive = mmc_sd_alive,
 	.shutdown = mmc_sd_suspend,
 	.hw_reset = mmc_sd_hw_reset,
+	.cache_enabled = sd_cache_enabled,
+	.flush_cache = sd_flush_cache,
 };
 
 /*
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 2867af0635f8..74e6c0624d27 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -196,6 +196,7 @@ struct sd_ext_reg {
 	u8			page;
 	u16			offset;
 	u8			rev;
+	u8			feature_enabled;
 	u8			feature_support;
 /* Power Management Function. */
 #define SD_EXT_POWER_OFF_NOTIFY	(1<<0)
-- 
2.25.1


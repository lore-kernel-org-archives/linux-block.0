Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABCCC43611
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8A661450
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhDUKcy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbhDUKct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 06:32:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C052C06138D
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 03:32:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d27so9264424lfv.9
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 03:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcsktzE2LmD65+1hOHiSw/mP2z1mU2lSfJMjIjsWTl8=;
        b=MeDREFOXhXuJmdNkZlfNo6r09BtFQhtpatiA2dLOAjjAx9WJX57MEqtOeMptwJzzxg
         KcFM8UVx0SBV4dYxGqW+lMn/XOuElbSINB3SPmjzyeEr36jWpVyIwgfPxwa8ssflH2mJ
         Oxolx5TZP8FqxdkDpcOeNYrs4SB5XroN/kGPdRGF9BF/qijCo8EDgYg6VMySHJfVq2hA
         z29f+TyFBf1pCEfF7kx9mvQBUWc32kJJuNY5XG87OR7ZsqmuKlJ0GbDGfTS98sSe2gAb
         i8ZRbFepki5l8v/b9AHTV32HDeKv1wZbpuFH0314bcqBTpdBW9PE+iVZ4ltSbO6R/x/G
         M/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcsktzE2LmD65+1hOHiSw/mP2z1mU2lSfJMjIjsWTl8=;
        b=sSLG7v9vy4cMsJWQJp2/bpPg7CnLd7oclICG2P4ZPlf+JTDFW0R3Z1EtbKZDg5Ahdy
         8N3brxzHe3pN6nvgPvXUfBSj+doYAI1SP65jRwMX3dKbP96yGL3Q4fGQtwfw+Fzwiai0
         w2qGmWVQBGA5bSwypW+ollJxgnKSZjShuuZxOaDtdSp4ILoQswtjt7ClCw/3wSGkgeic
         gKX6cEzMxJnADnpzvmRn1gFq+L6lgxFy2OqnFOUlOSJFhWYFx8pcBKzkqEPRV/Ikozsb
         1Fu1QHGSsZDzFp6Wd+egxI4qZJBCD5gb1yLjRXflSB7PfoDFLzpKoqRekdMnrOJoiR8Q
         KzRw==
X-Gm-Message-State: AOAM532+pbbUbjT1TI/9i5iYY1wEuG9Ofbbq5ejSHmlXxKY2m2EnpVfC
        PIFsonKVVQblDIhJpXzhr0Vmwg==
X-Google-Smtp-Source: ABdhPJxV6dxPVTt9qygoUmgvT6O4ATvKPQcYo7j/3FM4lE7OAyE15x7FJ/923njgXMQ0S3Iy0/lpcQ==
X-Received: by 2002:a05:6512:12c3:: with SMTP id p3mr12128089lfg.595.1619001133570;
        Wed, 21 Apr 2021 03:32:13 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id u13sm170603lfg.139.2021.04.21.03.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:32:12 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mmc: core: Read performance enhancements registers for SD cards
Date:   Wed, 21 Apr 2021 12:31:54 +0200
Message-Id: <20210421103154.169410-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421103154.169410-1-ulf.hansson@linaro.org>
References: <20210421103154.169410-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In SD spec v6.x the SD function extension registers for performance
enhancements were introduced. These registers let the SD card announce
supports for various performance related features, like "self-maintenance",
"cache" and "command queuing".

Let's extend the parsing of SD function extension registers and store the
information in the struct mmc_card. This allows subsequent changes to
easier implement the complete support for new the performance enhancement
features.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c    | 46 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |  7 ++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d6e838b7c895..0e946afd6d22 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1063,6 +1063,48 @@ static int sd_decode_ext_reg_power(struct mmc_card *card, u8 fno, u32 reg_addr)
 	return 0;
 }
 
+static int sd_decode_ext_reg_perf(struct mmc_card *card, u8 fno, u32 reg_addr)
+{
+	int err;
+	u8 *reg_buf;
+
+	err = sd_read_ext_reg_fno(card, fno, reg_addr, &reg_buf);
+	if (err) {
+		pr_warn("%s: error %d reading PERF func of ext reg\n",
+			mmc_hostname(card->host), err);
+		return err;
+	}
+
+	/* PERF revision. */
+	card->ext_perf.rev = reg_buf[0];
+
+	/* FX_EVENT support at bit 0. */
+	if (reg_buf[1] & 0x1)
+		card->ext_perf.feature_support |= SD_EXT_PERF_FX_EVENT;
+
+	/* Card initiated self-maintenance support at bit 0. */
+	if (reg_buf[2] & 0x1)
+		card->ext_perf.feature_support |= SD_EXT_PERF_CARD_MAINT;
+
+	/* Host initiated self-maintenance support at bit 1. */
+	if (reg_buf[2] & 0x2)
+		card->ext_perf.feature_support |= SD_EXT_PERF_HOST_MAINT;
+
+	/* Cache support at bit 0. */
+	if (reg_buf[4] & 0x1)
+		card->ext_perf.feature_support |= SD_EXT_PERF_CACHE;
+
+	/* Command queue support indicated via queue depth bits (0 to 4). */
+	if (reg_buf[6] & 0x1f)
+		card->ext_perf.feature_support |= SD_EXT_PERF_CMD_QUEUE;
+
+	card->ext_perf.reg_addr = reg_addr;
+	card->ext_perf.fno = fno;
+
+	kfree(reg_buf);
+	return 0;
+}
+
 static int sd_decode_ext_reg(struct mmc_card *card, u8 *gen_info_buf,
 			     u16 *next_ext_addr)
 {
@@ -1103,6 +1145,10 @@ static int sd_decode_ext_reg(struct mmc_card *card, u8 *gen_info_buf,
 	if (sfc == 0x1)
 		return sd_decode_ext_reg_power(card, fno, reg_addr);
 
+	/* Standard Function Code for performance enhancement. */
+	if (sfc == 0x2)
+		return sd_decode_ext_reg_perf(card, fno, reg_addr);
+
 	return 0;
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6a1d64fba0f3..8e21eebe704d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -200,6 +200,12 @@ struct sd_ext_reg {
 #define SD_EXT_POWER_OFF_NOTIFY	(1<<0)
 #define SD_EXT_POWER_SUSTENANCE	(1<<1)
 #define SD_EXT_POWER_DOWN_MODE	(1<<2)
+/* Performance Enhancement Function. */
+#define SD_EXT_PERF_FX_EVENT	(1<<0)
+#define SD_EXT_PERF_CARD_MAINT	(1<<1)
+#define SD_EXT_PERF_HOST_MAINT	(1<<2)
+#define SD_EXT_PERF_CACHE	(1<<3)
+#define SD_EXT_PERF_CMD_QUEUE	(1<<4)
 };
 
 struct sdio_cccr {
@@ -304,6 +310,7 @@ struct mmc_card {
 	struct sd_ssr		ssr;		/* yet more SD information */
 	struct sd_switch_caps	sw_caps;	/* switch (CMD6) caps */
 	struct sd_ext_reg	ext_power;	/* SD extension reg for PM */
+	struct sd_ext_reg	ext_perf;	/* SD extension reg for PERF */
 
 	unsigned int		sdio_funcs;	/* number of SDIO functions */
 	atomic_t		sdio_funcs_probed; /* number of probed SDIO funcs */
-- 
2.25.1


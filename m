Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D60C43460
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92146613C0
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhEDQOM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 May 2021 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhEDQNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 May 2021 12:13:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF043C061761
        for <linux-block@vger.kernel.org>; Tue,  4 May 2021 09:12:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v5so3079216ljg.12
        for <linux-block@vger.kernel.org>; Tue, 04 May 2021 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUlKHRwg9oGMLgy4OD6Eu0j2Eug1Mwe4w1pydrhg7ho=;
        b=eudWWkPW46AfVF42Ji3LQad4suEzOF8chyrMlQvLTVKVJlEiNz0Zt5m9WE2sGi4tXW
         3lDI+6R3sVzCk7t+3f8l7oXqP3i+zGd/qnJ0n/IroLLWHUgJt1rqVa8Kon5h0+lQSk91
         cKc4yfeh8aIZgeCURHcSAQoDNEbOdMfjBNV30AwXPkXWMsMVc18Yk5+5KRFH63xBFOTj
         yUiP94xIuaZccP3loU3WY0WjuNNlw3iIw93yK1D3PHcBf2ydx9f8YV3xULD8Yk5/kJ9D
         YDmflZGuOgbeUGOY3qtH3a8CD72uYcOYS2K0Ve22hLHi7GvCaSwQZngZyR38hBKauoZl
         Ft2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUlKHRwg9oGMLgy4OD6Eu0j2Eug1Mwe4w1pydrhg7ho=;
        b=IqKoIAv61/6R8gF4dBkHKX+oCmVty8yP2EKnRHHSMJUJPjWnRELhpdIo+bMp+r62sA
         V8SqQZ4EpG9Y7AraRSjmmFKPZ2SPjpB/t34e38831ScmcgWy93/n+j+x+lMBB5Cy68cg
         9YUlRPY+ZvJFUMMIocs/DryqTKmrU9HYlmcbYlzfYnwaFEEgzeLu4PJmCBE8g2E8QCjj
         HpOoybfPCmbcq1m1THCGWyOz8j9ZVJAmfHZYLg93xnNQ2SSiJhWsD81vveS5k4zGIwAh
         tzQckglXc+WoH/2eRuX/yzzsOEc0HOBICHN9um7X1BCjJYMbc2o3BwMV+NnIolTGcZ3U
         ViRw==
X-Gm-Message-State: AOAM532N7mvWMZxggwZelSsOVgOFNai9E4hY7Fpg80wVNfvDj1klMfi3
        gLUHp6kX9r6aYRg2C22oLZanCA==
X-Google-Smtp-Source: ABdhPJwt+ggDdDdmydD0bGx9A/9b6AOE49jrzu2HOeXIrEHlxkxG/fTv1rd5w+WfVYIiMK0VVqvq6g==
X-Received: by 2002:a2e:161a:: with SMTP id w26mr16293287ljd.436.1620144770395;
        Tue, 04 May 2021 09:12:50 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] mmc: core: Read the SD function extension registers for power management
Date:   Tue,  4 May 2021 18:12:20 +0200
Message-Id: <20210504161222.101536-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In SD spec v4.x the SD function extension registers were introduced. A
specific function register were added to let the card announce support for
optional features in regards to power management. The features that were
added are "Power Off Notification", "Power Down Mode" and "Power
Sustenance".

As a first step, let's read and parse this register for power management
during the SD card initialization and store the information about the
supported features in the struct mmc_card. In this way, we prepare for
subsequent changes to implement the complete support for the new features.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c    | 178 +++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |  13 +++
 include/linux/mmc/sd.h   |   3 +
 3 files changed, 194 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index de7b5f8df550..cb5e8b2fc32f 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -996,6 +996,177 @@ static bool mmc_sd_card_using_v18(struct mmc_card *card)
 	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
 }
 
+static int sd_read_ext_reg(struct mmc_card *card, u8 fno, u8 page,
+			   u16 offset, u16 len, u8 *reg_buf)
+{
+	u32 cmd_args;
+
+	/*
+	 * Command arguments of CMD48:
+	 * [31:31] MIO (0 = memory).
+	 * [30:27] FNO (function number).
+	 * [26:26] reserved (0).
+	 * [25:18] page number.
+	 * [17:9] offset address.
+	 * [8:0] length (0 = 1 byte, 1ff = 512 bytes).
+	 */
+	cmd_args = fno << 27 | page << 18 | offset << 9 | (len -1);
+
+	return mmc_send_adtc_data(card, card->host, SD_READ_EXTR_SINGLE,
+				  cmd_args, reg_buf, 512);
+}
+
+static int sd_parse_ext_reg_power(struct mmc_card *card, u8 fno, u8 page,
+				  u16 offset)
+{
+	int err;
+	u8 *reg_buf;
+
+	reg_buf = kzalloc(512, GFP_KERNEL);
+	if (!reg_buf)
+		return -ENOMEM;
+
+	/* Read the extension register for power management function. */
+	err = sd_read_ext_reg(card, fno, page, offset, 512, reg_buf);
+	if (err) {
+		pr_warn("%s: error %d reading PM func of ext reg\n",
+			mmc_hostname(card->host), err);
+		goto out;
+	}
+
+	/* PM revision consists of 4 bits. */
+	card->ext_power.rev = reg_buf[0] & 0xf;
+
+	/* Power Off Notification support at bit 4. */
+	if (reg_buf[1] & 0x10)
+		card->ext_power.feature_support |= SD_EXT_POWER_OFF_NOTIFY;
+
+	/* Power Sustenance support at bit 5. */
+	if (reg_buf[1] & 0x20)
+		card->ext_power.feature_support |= SD_EXT_POWER_SUSTENANCE;
+
+	/* Power Down Mode support at bit 6. */
+	if (reg_buf[1] & 0x40)
+		card->ext_power.feature_support |= SD_EXT_POWER_DOWN_MODE;
+
+	card->ext_power.fno = fno;
+	card->ext_power.page = page;
+	card->ext_power.offset = offset;
+
+out:
+	kfree(reg_buf);
+	return err;
+}
+
+static int sd_parse_ext_reg(struct mmc_card *card, u8 *gen_info_buf,
+			    u16 *next_ext_addr)
+{
+	u8 num_regs, fno, page;
+	u16 sfc, offset, ext = *next_ext_addr;
+	u32 reg_addr;
+
+	/*
+	 * Parse only one register set per extension, as that is sufficient to
+	 * support the standard functions. This means another 48 bytes in the
+	 * buffer must be available.
+	 */
+	if (ext + 48 > 512)
+		return -EFAULT;
+
+	/* Standard Function Code */
+	memcpy(&sfc, &gen_info_buf[ext], 2);
+
+	/* Address to the next extension. */
+	memcpy(next_ext_addr, &gen_info_buf[ext + 40], 2);
+
+	/* Number of registers for this extension. */
+	num_regs = gen_info_buf[ext + 42];
+
+	/* We support only one register per extension. */
+	if (num_regs != 1)
+		return 0;
+
+	/* Extension register address. */
+	memcpy(&reg_addr, &gen_info_buf[ext + 44], 4);
+
+	/* 9 bits (0 to 8) contains the offset address. */
+	offset = reg_addr & 0x1ff;
+
+	/* 8 bits (9 to 16) contains the page number. */
+	page = reg_addr >> 9 & 0xff ;
+
+	/* 4 bits (18 to 21) contains the function number. */
+	fno = reg_addr >> 18 & 0xf;
+
+	/* Standard Function Code for power management. */
+	if (sfc == 0x1)
+		return sd_parse_ext_reg_power(card, fno, page, offset);
+
+	return 0;
+}
+
+static int sd_read_ext_regs(struct mmc_card *card)
+{
+	int err, i;
+	u8 num_ext, *gen_info_buf;
+	u16 rev, len, next_ext_addr;
+
+	if (mmc_host_is_spi(card->host))
+		return 0;
+
+	if (!(card->scr.cmds & SD_SCR_CMD48_SUPPORT))
+		return 0;
+
+	gen_info_buf = kzalloc(512, GFP_KERNEL);
+	if (!gen_info_buf)
+		return -ENOMEM;
+
+	/*
+	 * Read 512 bytes of general info, which is found at function number 0,
+	 * at page 0 and with no offset.
+	 */
+	err = sd_read_ext_reg(card, 0, 0, 0, 512, gen_info_buf);
+	if (err) {
+		pr_warn("%s: error %d reading general info of SD ext reg\n",
+			mmc_hostname(card->host), err);
+		goto out;
+	}
+
+	/* General info structure revision. */
+	memcpy(&rev, &gen_info_buf[0], 2);
+
+	/* Length of general info in bytes. */
+	memcpy(&len, &gen_info_buf[2], 2);
+
+	/* Number of extensions to be find. */
+	num_ext = gen_info_buf[4];
+
+	/* We support revision 0, but limit it to 512 bytes for simplicity. */
+	if (rev != 0 || len > 512) {
+		pr_warn("%s: non-supported SD ext reg layout\n",
+			mmc_hostname(card->host));
+		goto out;
+	}
+
+	/*
+	 * Parse the extension registers. The first extension should start
+	 * immediately after the general info header (16 bytes).
+	 */
+	next_ext_addr = 16;
+	for (i = 0; i < num_ext; i++) {
+		err = sd_parse_ext_reg(card, gen_info_buf, &next_ext_addr);
+		if (err) {
+			pr_warn("%s: error %d parsing SD ext reg\n",
+				mmc_hostname(card->host), err);
+			goto out;
+		}
+	}
+
+out:
+	kfree(gen_info_buf);
+	return err;
+}
+
 /*
  * Handle the detection and initialisation of a card.
  *
@@ -1144,6 +1315,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	if (!oldcard) {
+		/* Read/parse the extension registers. */
+		err = sd_read_ext_regs(card);
+		if (err)
+			goto free_card;
+	}
+
 	if (host->cqe_ops && !host->cqe_enabled) {
 		err = host->cqe_ops->cqe_enable(host, card);
 		if (!err) {
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 858fc4d11240..03a862e93594 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -191,6 +191,18 @@ struct sd_switch_caps {
 #define SD_MAX_CURRENT_800	(1 << SD_SET_CURRENT_LIMIT_800)
 };
 
+struct sd_ext_reg {
+	u8			fno;
+	u8			page;
+	u16			offset;
+	u8			rev;
+	u8			feature_support;
+/* Power Management Function. */
+#define SD_EXT_POWER_OFF_NOTIFY	(1<<0)
+#define SD_EXT_POWER_SUSTENANCE	(1<<1)
+#define SD_EXT_POWER_DOWN_MODE	(1<<2)
+};
+
 struct sdio_cccr {
 	unsigned int		sdio_vsn;
 	unsigned int		sd_vsn;
@@ -292,6 +304,7 @@ struct mmc_card {
 	struct sd_scr		scr;		/* extra SD information */
 	struct sd_ssr		ssr;		/* yet more SD information */
 	struct sd_switch_caps	sw_caps;	/* switch (CMD6) caps */
+	struct sd_ext_reg	ext_power;	/* SD extension reg for PM */
 
 	unsigned int		sdio_funcs;	/* number of SDIO functions */
 	atomic_t		sdio_funcs_probed; /* number of probed SDIO funcs */
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 2236aa540faa..43bfc5c39ad4 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -29,6 +29,9 @@
 #define SD_APP_OP_COND           41   /* bcr  [31:0] OCR         R3  */
 #define SD_APP_SEND_SCR          51   /* adtc                    R1  */
 
+  /* class 11 */
+#define SD_READ_EXTR_SINGLE      48   /* adtc [31:0]             R1  */
+
 /* OCR bit definitions */
 #define SD_OCR_S18R		(1 << 24)    /* 1.8V switching request */
 #define SD_ROCR_S18A		SD_OCR_S18R  /* 1.8V switching accepted by card */
-- 
2.25.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62B3C43462
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A636144D
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhDUKcx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhDUKct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 06:32:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C64C06138A
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 03:32:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t14so8996828lfe.1
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p42aSuTP9ycrpt9alD1QzOosKqJLUbQFJmk5Gcksb8o=;
        b=dtcEWguWKgPrkE0BoroYBUokeGvPeP+oZCK8Rx+QarSqm3C3e8plUV/y5nsEG8tkSv
         H5jrhQpkXvr8EfB1ZfNRXRKaeH9UmED/KrPcwRoAn1SRclhwzY+We0XRcCsJspR7ob//
         MaxwmDnRCKCoIRkmyBRCKd9h3XAm2Hjd20cCx7jLmObzYk/Ig8KUYEww7ZoYhXUXwvvA
         zwz3v7CvW/oyuq66dPLJ6je/V8i+dsBq9+vd9oOFpe5bS6I7fGJfunUXvIDY/nJq1ZtB
         fLmML9N7kKhkChhnqfbhfZzdq9VgOeOMU8qpGB7njTgEwqiwoiZExoQ6mHf6+yQ0wU5M
         m8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p42aSuTP9ycrpt9alD1QzOosKqJLUbQFJmk5Gcksb8o=;
        b=Pt9BxquktEQozHicQ25N4Cqhpqt2eLdupPCsxNEfLtrcxM/4py1TUmQVSOScSQmG9P
         hjdR6M0q36linpgOr/G6EJ9K0Ejku6/2XVbhFsdzEpNG/PUZdiSdajYKxj8+rcyp5aiA
         iLPZ8vG3SgRUbnNhwgXK2RFD3xATvNPqPpOtjtz5riCgyS/C3YC9sORDELITpkYqbI7j
         qomPeXN9P2kxQ8sVDlEn4wL7zYzO3wyPOak/k2/xnJN5Q5weSzEfpjK9O8dcfAF3lNjB
         4zXhd3uZuIYNoHUxP3Vj36aBam3at9vrDBDGrGqJtwo5zbN0kOGB73Z7expGS8yqLf+Q
         JFgw==
X-Gm-Message-State: AOAM5339RwvjqiDLCxNDfIjKLAU36vztJ5/5cHU7gGwbpRWn85pKgU0N
        1za9QahR17GrogOOAQhRPFcXBA==
X-Google-Smtp-Source: ABdhPJy2JtntEDgBLncqUuq+UlgbGEoS2hh9aOE8NnVsMaj+KsyfLMdFl1plsd1kB9E96qTBmi+LdQ==
X-Received: by 2002:a19:e309:: with SMTP id a9mr18805329lfh.222.1619001131641;
        Wed, 21 Apr 2021 03:32:11 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id u13sm170603lfg.139.2021.04.21.03.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:32:10 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mmc: core: Read the SD function extension registers for power management
Date:   Wed, 21 Apr 2021 12:31:53 +0200
Message-Id: <20210421103154.169410-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421103154.169410-1-ulf.hansson@linaro.org>
References: <20210421103154.169410-1-ulf.hansson@linaro.org>
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
supported features in the struct mmc_card. In this way, it becomes easier
for subsequent changes to implement the complete support.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c    | 172 +++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |  12 +++
 include/linux/mmc/sd.h   |   3 +
 3 files changed, 187 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index de7b5f8df550..d6e838b7c895 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -996,6 +996,171 @@ static bool mmc_sd_card_using_v18(struct mmc_card *card)
 	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
 }
 
+static int sd_read_ext_reg_fno(struct mmc_card *card, u8 fno, u32 reg_addr,
+			       u8 **buf)
+{
+	int err;
+	u8 *tmp_buf;
+	u32 cmd_args;
+
+	/*
+	 * Arguments of CMD48 to read a page of 512 bytes:
+	 * [31:31] MIO (0 = memory).
+	 * [30:27] FNO (function number).
+	 * [26:26] reserved (0).
+	 * [25:18] page number.
+	 * [17:9] offset address.
+	 * [8:0] length (1FF = 512 bytes data).
+	 */
+	cmd_args = 0x000001ff | fno << 27 | reg_addr << 9;
+
+	tmp_buf = kzalloc(512, GFP_KERNEL);
+	if (!tmp_buf)
+		return -ENOMEM;
+
+	err = mmc_send_adtc_data(card, card->host, SD_READ_EXTR_SINGLE,
+				 cmd_args, tmp_buf, 512);
+	if (err)
+		kfree(tmp_buf);
+	else
+		*buf = tmp_buf;
+
+	return err;
+}
+
+static int sd_decode_ext_reg_power(struct mmc_card *card, u8 fno, u32 reg_addr)
+{
+	int err;
+	u8 *reg_buf;
+
+	/* Read the extension register for power management function. */
+	err = sd_read_ext_reg_fno(card, fno, reg_addr, &reg_buf);
+	if (err) {
+		pr_warn("%s: error %d reading PM func of ext reg\n",
+			mmc_hostname(card->host), err);
+		return err;
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
+	card->ext_power.reg_addr = reg_addr;
+	card->ext_power.fno = fno;
+
+	kfree(reg_buf);
+	return 0;
+}
+
+static int sd_decode_ext_reg(struct mmc_card *card, u8 *gen_info_buf,
+			     u16 *next_ext_addr)
+{
+	u8 num_reg_sets, fno;
+	u16 ext = *next_ext_addr, sfc;
+	u32 reg_set_addr, reg_addr;
+
+	/*
+	 * Parse only one register set per extension, as that is sufficient to
+	 * support the Standard Functions. This means another 48 bytes in the
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
+	/* Number of registers sets for this extension. */
+	num_reg_sets = gen_info_buf[ext + 42];
+
+	if (num_reg_sets != 1)
+		return 0;
+
+	/* Extension register address. */
+	memcpy(&reg_set_addr, &gen_info_buf[ext + 44], 4);
+
+	/* First 17 bits contains the page and the offset. */
+	reg_addr = reg_set_addr & 0x1FFFF;
+
+	/* 4 bits (18 to 21) contains the Function Number. */
+	fno = reg_set_addr >> 18 & 0xf;
+
+	/* Standard Function Code for power management. */
+	if (sfc == 0x1)
+		return sd_decode_ext_reg_power(card, fno, reg_addr);
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
+	/* Read general info at page 0, with no offset and FNO=0. */
+	err = sd_read_ext_reg_fno(card, 0, 0, &gen_info_buf);
+	if (err) {
+		pr_warn("%s: error %d reading general info of SD ext reg\n",
+			mmc_hostname(card->host), err);
+		return err;
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
+	/* We support revision 0, but limit it to 512 bytes - for simplicity. */
+	if (rev != 0 || len > 512) {
+		pr_warn("%s: non-supported SD ext reg layout\n",
+			mmc_hostname(card->host));
+		goto out;
+	}
+
+	/*
+	 * Read/parse the extension registers. The first extension should start
+	 * immediately after the general info header (16 bytes).
+	 */
+	next_ext_addr = 16;
+	for (i = 0; i < num_ext; i++) {
+		err = sd_decode_ext_reg(card, gen_info_buf, &next_ext_addr);
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
@@ -1144,6 +1309,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
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
index 858fc4d11240..6a1d64fba0f3 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -191,6 +191,17 @@ struct sd_switch_caps {
 #define SD_MAX_CURRENT_800	(1 << SD_SET_CURRENT_LIMIT_800)
 };
 
+struct sd_ext_reg {
+	u32			reg_addr;
+	u8			fno;
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
@@ -292,6 +303,7 @@ struct mmc_card {
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


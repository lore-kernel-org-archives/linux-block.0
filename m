Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D6C54EEB
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C7C20658
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG5Hq3wW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgCWQfq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:35:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40008 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCWQfq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so10756612lfe.7;
        Mon, 23 Mar 2020 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkYPIPdOfV7br4C4RHUcphVGjfFEoNa4bM1BVezoPBk=;
        b=rG5Hq3wWvpFqgAS9rq9wpDrYRFkZtPlx87cRxnzG6q8IHm5vYnFrMkt+57dJND+mNc
         WSoNJf2y6rVAuBSeRYTAposgo3Rjhu1myiVTZedwXbRZdHZ20Ps7+LyESzNkAbHqw40s
         oedHQ378rv2wH2q2B2zPzvMTfTWPuk5qWn6Is5gE5zo9oyeXVSk6+Ndi4R2yL7qy8U8O
         jJd4bpGGWwDp6DnvaepPrwqFeQ9nd9pXSDL/+QFjz6IKIxOmvXSOfAxv5cPTr1yBWTSO
         eit1KUMzdGp3X0/MajYzM+xc0mXDb/9PH9wkKcxktz6K24RyobU4ZR8yqNhZVlm8QYGd
         xp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkYPIPdOfV7br4C4RHUcphVGjfFEoNa4bM1BVezoPBk=;
        b=BEZO3gGvQ55pT97vS214sQWPyDolmQCtGWbYb3peO/N8t5bkujI6OiX9YIAN6qBuFd
         elA/2c+5qfk5vpIJR5sX4s9Ba1dtiYLoDcGLGrpxad5LAeOPazzR5AKvrkucoxqGq63E
         B0ZOgkRxZlaN2udgPoKruF4Ib/tPUjMfuNBFHmnp3GDZKv1fDvHJHYtn9CRZdblaJg1V
         LhzhclkvVoMofS0YaTWtHXkPOfEoi2KPqLPzUjUAI9VBm3Go2PEWRj7w8ulUeAvn23hf
         HLvhCToPTg1d+GJNPgUyqKFz+HOL5rY2xMdnmTJVUd4VyWiNUn3rg6InIiaUq9iR6SWX
         f4mg==
X-Gm-Message-State: ANhLgQ1+ijkA2nO1lrgnClx3eCzTLbWd3XrMDui15Nr38jfOdb6ZYVkm
        gk4Y5jTpL+Ope4owxoVB5Ro=
X-Google-Smtp-Source: ADFU+vtCz1E3FwWgwg/vbftXiI9QdeSSSVnbOJ9AhJmWkWw2WyRvdU/qRlRfzyhbeUClGTO342m4PA==
X-Received: by 2002:a19:c005:: with SMTP id q5mr4712508lff.216.1584981344049;
        Mon, 23 Mar 2020 09:35:44 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] mmc: sdhci-tegra: Enable boot partitions scanning on Tegra20 and Tegra30
Date:   Mon, 23 Mar 2020 19:34:30 +0300
Message-Id: <20200323163431.7678-10-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
References: <20200323163431.7678-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Consumer-grade devices usually have a custom NVIDIA Tegra Partition table
used by built-in eMMC storage. On some devices partition table resides on
a boot eMMC partition, and thus, the boot partitions need to be scanned.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 3e2c5101291d..364572eaed8a 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -100,6 +100,7 @@
 #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
 #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
 #define NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING		BIT(9)
+#define NVQUIRK_SCAN_BOOT_PARTITIONS			BIT(10)
 
 /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
 #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
@@ -1304,7 +1305,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
 	.pdata = &sdhci_tegra20_pdata,
 	.dma_mask = DMA_BIT_MASK(32),
 	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
-		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
+		    NVQUIRK_ENABLE_BLOCK_GAP_DET |
+		    NVQUIRK_SCAN_BOOT_PARTITIONS,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
@@ -1333,7 +1335,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
-		    NVQUIRK_HAS_PADCALIB,
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_SCAN_BOOT_PARTITIONS,
 };
 
 static const struct sdhci_ops tegra114_sdhci_ops = {
@@ -1586,6 +1589,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	/* HW busy detection is supported, but R1B responses are required. */
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
 
+	if (tegra_host->soc_data->nvquirks & NVQUIRK_SCAN_BOOT_PARTITIONS)
+		host->mmc->scan_mmc_boot_partitions = true;
+
 	tegra_sdhci_parse_dt(host);
 
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
-- 
2.25.1


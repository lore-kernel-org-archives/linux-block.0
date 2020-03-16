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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF37CC2BB1D
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EC820724
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ0wj7QE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgCPKCK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:02:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45016 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgCPKCJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 06:02:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so7762499plo.11;
        Mon, 16 Mar 2020 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zVsXEMQ2cvDxi1JSi+7AbphOA0QjROre8VLRlUq3vMI=;
        b=gJ0wj7QE4LJ/lVMZEDr7b6mqq5iHAVeEw621yxmOe5eoW5GOKHH6hEO/5GH3Zc9ptd
         p5G7l1lmL7KQed6+O0bxjMYWd/4Pi2LZQXD13nrJMcruN6CaXSPfYh93f16O5YVX13F5
         95tCItZ5ZT7afSEMUDzpb1VwidhfVQW9sD3ViCD9G99pDFTigo5yehXgJyN7Z7jjW5cq
         8AL7fT4TeWYsYPYpxc4M7xzVt90edBEyTssMbLeTrZXiuLx4KbZMCCR29m84CqXptPqO
         4eUJH7W2F1YXX6ADHjipzc6a6KLFil1xyX+yDMtEvPrygtb3u8Q+d/0L6sJb3p9MQN0a
         nT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zVsXEMQ2cvDxi1JSi+7AbphOA0QjROre8VLRlUq3vMI=;
        b=gpSkQZfnuo8V3totvwcWULIsa7a861gG2bwA2uL+zGQOHLFw7+rcZ9jNIy13XtPsus
         HOBL5luhccs65BEKk6fhE87rEPGN94M1iZWiVEsEl86eCATmD5tyHMckwpDvjpkxFd/M
         FfnEcAaeqr3ZGk72JsU51pA+u4Jz+XDuYWoO7Cn9dUBU3sHzGnaiZzQ1aoPOo7ALdbkr
         1MbToat8zTj47hrrNqATGHs8bjF55M/VQ1wHXRe2Bu1doXTsRqdCa1TM5cXLx/T5eC6M
         6AknjtXacN/4wveAHVeAAp0UaQzpOIiskcdoDNRpNC/gpJqR5khHMjC+vD2YokxrAO9n
         4nfw==
X-Gm-Message-State: ANhLgQ2BPP5b3AGsZQrHIgXxr/rFG7LOVYYbh2EZ/4JfkROqEOmynk6E
        +7jJek+vqpxT/lQiTx3BHFg=
X-Google-Smtp-Source: ADFU+vuwddfeOJxssCBTiAilwq4VXdcEO12xHfGzz1b4kKNTo02ClU1t1DL+tBP+ytkEmiiBga1oAQ==
X-Received: by 2002:a17:902:740b:: with SMTP id g11mr12870239pll.166.1584352929118;
        Mon, 16 Mar 2020 03:02:09 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 136sm63970411pgh.26.2020.03.16.03.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 03:02:08 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     ming.lei@redhat.com, arnd@arndb.de, linus.walleij@linaro.org,
        baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH 8/8] mmc: host: sdhci-sprd: Add MMC packed request support
Date:   Mon, 16 Mar 2020 18:01:25 +0800
Message-Id: <060083eadc085cc93149475f3259cf2eb9d81d83.1584350380.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Enable the ADMA3 transfer mode as well as adding packed operations
to support MMC packed requests to improve IO performance.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 49afe1c..daa38ed 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -390,6 +390,12 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	 mmc_request_done(host->mmc, mrq);
 }
 
+static void sdhci_sprd_packed_request_done(struct sdhci_host *host,
+					   struct mmc_packed_request *prq)
+{
+	mmc_hsq_finalize_packed_request(host->mmc, prq);
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -404,6 +410,7 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
 	.get_ro = sdhci_sprd_get_ro,
 	.request_done = sdhci_sprd_request_done,
+	.packed_request_done = sdhci_sprd_packed_request_done,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -546,10 +553,18 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 		  SDHCI_QUIRK_MISSING_CAPS,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
 		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
-		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_USE_ADMA3_SUPPORT,
 	.ops = &sdhci_sprd_ops,
 };
 
+static const struct hsq_packed_ops packed_ops = {
+	.packed_algo = mmc_hsq_packed_algo_rw,
+	.prepare_hardware = sdhci_prepare_packed,
+	.unprepare_hardware = sdhci_unprepare_packed,
+	.packed_request = sdhci_packed_request,
+};
+
 static int sdhci_sprd_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -676,7 +691,18 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 		goto err_cleanup_host;
 	}
 
-	ret = mmc_hsq_init(hsq, host->mmc, NULL, 0);
+	/*
+	 * If the host controller can support ADMA3 mode, we can enable the
+	 * packed request mode to improve the read/write performance.
+	 *
+	 * Considering the maximum ADMA3 entries (default is 16) and the request
+	 * latency, we set the default maximum packed requests number is 8.
+	 */
+	if (host->flags & SDHCI_USE_ADMA3)
+		ret = mmc_hsq_init(hsq, host->mmc, &packed_ops,
+				   SDHCI_MAX_ADMA3_ENTRIES / 2);
+	else
+		ret = mmc_hsq_init(hsq, host->mmc, NULL, 0);
 	if (ret)
 		goto err_cleanup_host;
 
-- 
1.9.1


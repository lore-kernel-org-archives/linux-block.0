Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B89FC33CB6
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E682C2072E
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaZz1WJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgAQFZn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:25:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42794 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbgAQFZm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 00:25:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so9367587plk.9;
        Thu, 16 Jan 2020 21:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VFz24DYx+AJEk47BONRgaGsS8LjnX5pSIY7Tnm7mCJo=;
        b=KaZz1WJ9hDeSXfTdPY7q2phDBHVx1zx6FJU5x0Ubzj8AzyPoxeeJiz/Urrw17TAlKI
         Gq79vwsd16J/wD9/LemeFpLRrXcXd6XJomy5sjrc5LWb97jYVScFWabJZUuIa+blgnSH
         PXQjvfDKqyN+eN6+JOake8O4SJRgByeedVV/HxpqfEBb2IhGBkaukEWnb/IZfpRqRSrL
         njAyXEEoZ4jII4GskFjGjxH3md5eF4OpDIdd+SW/cQ4qGUM5AEzNj4LeShxCMBSSaIPn
         BLDyN4C3nebqdFrjyhJ6UpUBrkFbU1sLSrFWwCDEGSPjVgG3+pRYoJSWwWbLXtGAasXx
         vu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VFz24DYx+AJEk47BONRgaGsS8LjnX5pSIY7Tnm7mCJo=;
        b=fS93deDR51PliemLJREXfux1PBkPPAE/fH6veK9fhEB9rcsA33f3vgJC1jfw3bk9Vw
         Kn6DwLwR7OHR8JEg0L+ZYVpuxLapMWSsfxmts7wgnuzob4FgsSmcRcGQTRCBkOgfZGeW
         VGyE/3Y27LgKGCa2kThU0e73GOxGL+PwVXc4WR7YQHaQZkLma9jB7aBuGLhAPD+Fi0uO
         aO0HGrTdjt2+adIhRVAIGbQpw6E6MyL6WBRp3og6xnw7T6prgZzhWeKqiT0d1JtneSq2
         Q8ynPCCC3LB1Qr2PZhxeP1LN4Yy5EkrPacFN+v8IZGLUqvoRj+ZVg96R7b+Rv0bUaa+6
         hKEg==
X-Gm-Message-State: APjAAAU2pUIXHWOHwkXGTxAhGV6HzTVx+9pfTg2JMDOlcngYBmd+dUC6
        EwzllqhM/vejn3qSFfghQ7Q=
X-Google-Smtp-Source: APXvYqyMgiGlD9tGbi7+t2vq6IqNQC4YNjC/LY/EYxbj4BpulT+k0yA4i62+ylI7hYpLwFvlbpGCog==
X-Received: by 2002:a17:90a:c211:: with SMTP id e17mr3767593pjt.14.1579238742145;
        Thu, 16 Jan 2020 21:25:42 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c26sm28844756pfj.101.2020.01.16.21.25.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jan 2020 21:25:41 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [RFC PATCH 8/8] mmc: host: sdhci-sprd: Add MMC packed request support
Date:   Fri, 17 Jan 2020 13:24:27 +0800
Message-Id: <96e3ad74f2717029e5705fbf00bf3e61db90211d.1579164456.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Enable the ADMA3 transfer mode as well as adding packed operations
to support MMC packed requests to improve IO performance.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c |   30 ++++++++++++++++++++++++++++--
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
1.7.9.5


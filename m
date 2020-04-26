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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE260C5519A
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4EF2087E
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2PtoCaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgDZJkH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDZJkG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 05:40:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63474C061A0C;
        Sun, 26 Apr 2020 02:40:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so5703051plp.9;
        Sun, 26 Apr 2020 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dF9vBv8fHdzWcDfbioKI9l9ht6OgNKAeJ6Bytjb91dE=;
        b=G2PtoCaWAC8B+RFGxEyNH2BLhxRiYVi7STCy4+ZmXu8krqjYAte8jG55eHVoj7m5V0
         5ISC7KkiaKE+BIvKtxUWvE5gsfPdk8JaiswNl2JJz6nGhyTFz02cYmJ5TdPKqKudD+I6
         W26u1oeXpeiuTnJMYIaL4g8E88kzwa8seXvMOvEjXt7oShTfS9dOUAD88fKhZEVMBvRj
         JJ+hVNeN88J8nijoLIU/UzSTnCsrG2ZKXnpwxc4WPVeNuYNxlODKEH9DPneJ4ZXyfNi7
         GuaKoSbhF/YXrGcEQsGZI0wPwHxr0xnugssNnHvXl12lJTxaNB02bqMpIBFxBcOHTlfG
         tmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dF9vBv8fHdzWcDfbioKI9l9ht6OgNKAeJ6Bytjb91dE=;
        b=tJkRVf+eU72M+5i3ms5AyTyGQKPaOHDf8xiS5sliRPHndf6Gr/hkyWIi22tisar7A6
         CJve8VtGAUH3ADJcNkE29SqAzxCjQTUL+j84MaxTf+2YipVtbI59y9fNsSFFbZrANauO
         Hf0nyNwYPyf8ROY43jdROS9w960nJFZ2VFdX+oOM8x9olbPuNzCw87nv4G4eXGZuw9uZ
         s2UedLuYGOiMiC2jWQki3WN4VyJZGYUad9AISvYlz6I4qn2eXZZADWdtXBHtyObjGYtu
         KeOG5HBE28ZuqdvCscUEi5khacAhuJZFDXf3829o1oE9+peoqX6Y9aL9nvVCj3xkL1xC
         21wg==
X-Gm-Message-State: AGi0PuZ/ZnH/sGNEfQb5fHjdjX8WbppEmRErY8PdrGBRsXoeCHQyWDWr
        p9HA31Cn1fUzNAu8qkfjiMM=
X-Google-Smtp-Source: APiQypKSn/FS5LNkHV9D/obsGLzioz+Uq1ZBGvtyBF5qZ2MEkIy2SHoYCyBZZRfhLxjNWTi3zFDE8g==
X-Received: by 2002:a17:90a:a0c:: with SMTP id o12mr17496030pjo.29.1587894005948;
        Sun, 26 Apr 2020 02:40:05 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id m129sm1835245pga.47.2020.04.26.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 02:40:05 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, linus.walleij@linaro.org, paolo.valente@linaro.org,
        ming.lei@redhat.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 7/7] mmc: host: sdhci-sprd: Add MMC packed request support
Date:   Sun, 26 Apr 2020 17:39:00 +0800
Message-Id: <1804a345730443f483a352004fa58994f843ac1b.1587888520.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
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
index ad0981e19571..3409fa64ba37 100644
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
@@ -404,6 +410,7 @@ static struct sdhci_ops sdhci_sprd_ops = {
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
 	.get_ro = sdhci_sprd_get_ro,
 	.request_done = sdhci_sprd_request_done,
+	.packed_request_done = sdhci_sprd_packed_request_done,
 };
 
 static void sdhci_sprd_check_auto_cmd23(struct mmc_host *mmc,
@@ -539,10 +546,18 @@ static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
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
@@ -669,7 +684,18 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
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
2.17.1


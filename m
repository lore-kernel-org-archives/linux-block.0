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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F42C55199
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E22020A8B
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmcUKMko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgDZJjx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDZJjx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 05:39:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB4CC061A0C;
        Sun, 26 Apr 2020 02:39:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so3568821pfx.7;
        Sun, 26 Apr 2020 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ys8pJjvENjFyC/qZ0NY5rUPCOkwIJQ68i5iMM76qELU=;
        b=UmcUKMkod08HHtRovIaP4WSOWK5qwUOZnpGh94V0T/rmLV3TRGI7l+OQI4CHngqDlX
         N1yH2UXFyN8MAv/WoO8MpBhEsfJGtrJ1xvzAmE0xxxW9JBdFRvvwqywk4fJopLoMHIkV
         yDLv11NKKaGhK34rBFggpg4ijDvffUHODVl154SOH9dFGy9C9kiWzqrn6ngVDfKpbRHL
         ytQzNb3UU+Jc8fwBMm4cO5gxlpFW6LeEdkBMD792SSW+0N4xVk1sYSO0Ytz56q/qYKfT
         KeE4y89BxDjJ9oWo2copksZGPeMGSe0aMHl6bEwrUrx9Jvsx7cmTdlypEa7x3/yMIq41
         gtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ys8pJjvENjFyC/qZ0NY5rUPCOkwIJQ68i5iMM76qELU=;
        b=lmq6ONiQEaz6sdJExOjDHZZVj2rCS55jdZ9OWhXKVNFngMqw797brsjWVzoXSrMSGv
         vLF2ErmFFmsKHhvPEIJkXmZrqeZKvHVtGzfmHRET7jyLZsWMLoZx+MixmqLeEYYpkmPn
         fNrC+LssuoWzqm7kuU5+O/4fX4aZpKrpXslNT02f6a8dDrz76Xx6VdigDCe83iiNmLE4
         sNoJs38tCHBX4jojg99gp/iB0DKg2EFQrXk2KdgrFyTFkEmjHtGsdkEeos9QXCOGvseA
         Ya9bcsFuY/tYiK6XttnLzge7973BuJcFvPpw9PFk9MDE+lkBD8GR/UY1zGy2ZN6UsuwI
         JfnQ==
X-Gm-Message-State: AGi0PuYYIjrgU3HHE2vpnui8wnOG1+8zLtylUm8UETOjNrENzoCTuB26
        w9pUobFTe3rHxenYU4GmvZc=
X-Google-Smtp-Source: APiQypIRA+w6he4JacAmG4VYmR9Tl6ikvu1A7E4mRRT6Q4Cvei+Gr+TpcdgJboDGb2uUGrDMawVvkA==
X-Received: by 2002:a63:7d5d:: with SMTP id m29mr17215183pgn.65.1587893992509;
        Sun, 26 Apr 2020 02:39:52 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id m129sm1835245pga.47.2020.04.26.02.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 02:39:51 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, linus.walleij@linaro.org, paolo.valente@linaro.org,
        ming.lei@redhat.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 5/7] mmc: host: sdhci: Remove redundant sg_count member of struct sdhci_host
Date:   Sun, 26 Apr 2020 17:38:58 +0800
Message-Id: <1f925715f487e53a56d8ea650d990c91f2a5b4e4.1587888520.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The mmc_data structure has a member to save the mapped sg count, so
no need introduce a redundant sg_count of struct sdhci_host, remove it.
This is also a preparation patch to support ADMA3 transfer mode.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c | 12 +++++-------
 drivers/mmc/host/sdhci.h |  2 --
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3d4cdf0e0535..ad7e2442f120 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -709,7 +709,7 @@ static void sdhci_adma_mark_end(void *desc)
 }
 
 static void sdhci_adma_table_pre(struct sdhci_host *host,
-	struct mmc_data *data, int sg_count)
+	struct mmc_data *data)
 {
 	struct scatterlist *sg;
 	unsigned long flags;
@@ -723,14 +723,12 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	 * We currently guess that it is LE.
 	 */
 
-	host->sg_count = sg_count;
-
 	desc = host->adma_table;
 	align = host->align_buffer;
 
 	align_addr = host->align_addr;
 
-	for_each_sg(data->sg, sg, host->sg_count, i) {
+	for_each_sg(data->sg, sg, data->sg_count, i) {
 		addr = sg_dma_address(sg);
 		len = sg_dma_len(sg);
 
@@ -802,7 +800,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 		bool has_unaligned = false;
 
 		/* Do a quick scan of the SG list for any unaligned mappings */
-		for_each_sg(data->sg, sg, host->sg_count, i)
+		for_each_sg(data->sg, sg, data->sg_count, i)
 			if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
 				has_unaligned = true;
 				break;
@@ -814,7 +812,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 
 			align = host->align_buffer;
 
-			for_each_sg(data->sg, sg, host->sg_count, i) {
+			for_each_sg(data->sg, sg, data->sg_count, i) {
 				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
 					size = SDHCI_ADMA2_ALIGN -
 					       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
@@ -1134,7 +1132,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			WARN_ON(1);
 			host->flags &= ~SDHCI_REQ_USE_DMA;
 		} else if (host->flags & SDHCI_USE_ADMA) {
-			sdhci_adma_table_pre(host, data, sg_cnt);
+			sdhci_adma_table_pre(host, data);
 			sdhci_set_adma_addr(host, host->adma_addr);
 		} else {
 			WARN_ON(sg_cnt != 1);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5cade9a7b53a..51207072d1ec 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -588,8 +588,6 @@ struct sdhci_host {
 	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
 	unsigned int blocks;	/* remaining PIO blocks */
 
-	int sg_count;		/* Mapped sg entries */
-
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
 	void *integr_table;	/* ADMA3 intergrate descriptor table */
-- 
2.17.1


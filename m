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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27B3C33CB6
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C5A214AF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia2y461W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgAQFZg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:25:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36412 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgAQFZf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 00:25:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so9385626plm.3;
        Thu, 16 Jan 2020 21:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vshR8ZZS65iuxTZnSrp2TIMyJRg+REwdcMvoNFK8Uas=;
        b=Ia2y461WWqsew/Nr0qQp/XeD57dkMTXASnn1DHFrRDSCoOUf9ZWqHP29B40IwljdiW
         c7fwiMwpu0DuUBZ0j+20I2vqt70/3Ga8kpwaORFwFjwI8JdeO96uOKcAMotMG/SKzcmf
         ZEp7gGEmQcB6a+iQ3i7udYPPME8CkGLAxt4hTHp0I6lTDgOoOBvSr8UOTpEFl3l63KpE
         z962g7q80l6nH+/55zrcZpyAv05Qb/GkFbqXZna0FOSo+QPCDvrIJVk3vh0EU92d0GM2
         U9lMFrKVLHNWuv7xpzsIakdqsTu+JVzk6vIJ4romGMlzK1TICpGQw+WsXoRn6ML0/guy
         Lz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vshR8ZZS65iuxTZnSrp2TIMyJRg+REwdcMvoNFK8Uas=;
        b=q1/rhe7/7Va+VS2PV/I6Z8HQfk0UIM0ikpIAuU5agQto7CgB7WMvJD+Etyojj/XsDA
         1YReenJUStS01NXYIfDWKBkTceTLeoh9O65qAGwR2aFA9m5/sbHst5m207E/wZcrhcbA
         k3iKUrxeS+6mHNpI/uboYKtTO+89923FCKmJtJAwf43+qvrfNZFpmQU1H6C77YiQl65m
         TouPs+AOpel83/bQ1xwf4SUTN+QoHSZ2qrj7pS3aoX+RkYaDnlndOq8E69UZGWuq+qzu
         8hLhglwXYAiLPWsCLaibOEwDOS4lYZGn+lp6FK94Rg+5vqUDmJG/kUuqVXdtIGVtLYhB
         lRWw==
X-Gm-Message-State: APjAAAX3YOw2O4I2QqzgkjacveEF7yDK2nnBKPd8XaqhzQVf0NY+5EUV
        aLwsbxrlftCu/m2OzDmITAY=
X-Google-Smtp-Source: APXvYqz+7uHPswUe5D1+F7j/RyQcwdr1sC1jzDwbyO/TfPqswW7E23SRHl7atkmaCnGuxMSHbqgtlA==
X-Received: by 2002:a17:90a:d0c5:: with SMTP id y5mr3544709pjw.126.1579238734646;
        Thu, 16 Jan 2020 21:25:34 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c26sm28844756pfj.101.2020.01.16.21.25.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jan 2020 21:25:34 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [RFC PATCH 6/8] mmc: host: sdhci: Remove redundant sg_count member of struct sdhci_host
Date:   Fri, 17 Jan 2020 13:24:25 +0800
Message-Id: <07402baeaf54340483c8aa15c324939ba31e0473.1579164456.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The mmc_data structure has a member to save the mapped sg count, so
no need introduce a redundant sg_count of struct sdhci_host, remove it.
This is also a preparation patch to support ADMA3 transfer mode.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c |   12 +++++-------
 drivers/mmc/host/sdhci.h |    2 --
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f517121..645785d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -707,7 +707,7 @@ static void sdhci_adma_mark_end(void *desc)
 }
 
 static void sdhci_adma_table_pre(struct sdhci_host *host,
-	struct mmc_data *data, int sg_count)
+	struct mmc_data *data)
 {
 	struct scatterlist *sg;
 	unsigned long flags;
@@ -721,14 +721,12 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
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
 
@@ -800,7 +798,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 		bool has_unaligned = false;
 
 		/* Do a quick scan of the SG list for any unaligned mappings */
-		for_each_sg(data->sg, sg, host->sg_count, i)
+		for_each_sg(data->sg, sg, data->sg_count, i)
 			if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
 				has_unaligned = true;
 				break;
@@ -812,7 +810,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 
 			align = host->align_buffer;
 
-			for_each_sg(data->sg, sg, host->sg_count, i) {
+			for_each_sg(data->sg, sg, data->sg_count, i) {
 				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
 					size = SDHCI_ADMA2_ALIGN -
 					       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
@@ -1110,7 +1108,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			WARN_ON(1);
 			host->flags &= ~SDHCI_REQ_USE_DMA;
 		} else if (host->flags & SDHCI_USE_ADMA) {
-			sdhci_adma_table_pre(host, data, sg_cnt);
+			sdhci_adma_table_pre(host, data);
 			sdhci_set_adma_addr(host, host->adma_addr);
 		} else {
 			WARN_ON(sg_cnt != 1);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a5df807..7bbdd8a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -585,8 +585,6 @@ struct sdhci_host {
 	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
 	unsigned int blocks;	/* remaining PIO blocks */
 
-	int sg_count;		/* Mapped sg entries */
-
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
 	void *integr_table;	/* ADMA3 intergrate descriptor table */
-- 
1.7.9.5


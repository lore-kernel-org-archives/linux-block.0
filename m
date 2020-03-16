Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9F9C4CECE
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D181E2073E
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjmMvZhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgCPKCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:02:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34349 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbgCPKCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 06:02:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so9661060pfj.1;
        Mon, 16 Mar 2020 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Jgo0d3vEPmoCBuLf1d1sp68b+JTwTvOBHLLcoJyrr8E=;
        b=tjmMvZhxu/mSrGirbVRx5fo8xS8jT6FjQPq/z4yNglpRg0FIcybH7NNG0PLb5e90Xe
         clamxokZsdGyj5wL/l4O/CJB+9ub1g797PKktMbqfuO6cPkLAbncWZ4tTjSKyc/61HbG
         uH7hy+utSTf00J7dds3dUmE+tHuPoOCerpZbNun4R9veCI2Y4XhAfQ3wHo1tbE9U2qX4
         D2Ag7JyvH86FTnteCnKeMhnpJCHc4wxoP+9DfvKw7LHsWNGMlHqYp7+TEMGkEIBx6mv3
         3mMclnASsphfiY/Ialioxa/Rm9UQB6JCchh9gMZS0gbKsGR/qkyOv8Wxa+WfMdtJySyY
         D2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Jgo0d3vEPmoCBuLf1d1sp68b+JTwTvOBHLLcoJyrr8E=;
        b=mXFbFBS0+X30kk9I9yYnV/xTQe18pqAN9UFA+DAmn9M2BqxSHCSLm7r0mZcbd2c2EM
         bU57BUuH+PlcR632v+nLLynCNPVPV5H6kZ5I1i/CnmPJobEh+QVcEQhm6AmoSkjWoG40
         acD1udKOi8GVgZ6AEmH77PFs6smbp8npJBOmV6BSOnxBwcCZaxenTFlRlUfwX7j/EIkt
         1FJVr42At5FAS+EfkUHehMjsaEVeZ95Od9oag6A3o82+J//rCZL2uvatYkIinFLfDWlW
         yVcp0a0KF24myj9cVkoXuffbLPqZyfLJ/PkeLhFo04Iuc38OOFKglGuA875mp791m2ek
         VtZw==
X-Gm-Message-State: ANhLgQ05VQxr29y829HVZD1ZoLhnmYqmPK0e7bUI2hYpMyGeKiSK8VGT
        ZOT3Q+WWmY6uOmBrJwDptbA=
X-Google-Smtp-Source: ADFU+vvJKjfSS2AVPuGPLSABsTJewnEtqB8dX+PErlGFo8y6OtwPJGrEg2007aWa0Uf5HlChZ5s8Pg==
X-Received: by 2002:a65:4d0e:: with SMTP id i14mr11465430pgt.358.1584352920735;
        Mon, 16 Mar 2020 03:02:00 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 136sm63970411pgh.26.2020.03.16.03.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 03:02:00 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     ming.lei@redhat.com, arnd@arndb.de, linus.walleij@linaro.org,
        baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH 6/8] mmc: host: sdhci: Remove redundant sg_count member of struct sdhci_host
Date:   Mon, 16 Mar 2020 18:01:23 +0800
Message-Id: <537851f05fb3411859ff0196433635dbaf8b59aa.1584350380.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
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
index 4de0f48..6d6f450 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -708,7 +708,7 @@ static void sdhci_adma_mark_end(void *desc)
 }
 
 static void sdhci_adma_table_pre(struct sdhci_host *host,
-	struct mmc_data *data, int sg_count)
+	struct mmc_data *data)
 {
 	struct scatterlist *sg;
 	unsigned long flags;
@@ -722,14 +722,12 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
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
 
@@ -801,7 +799,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 		bool has_unaligned = false;
 
 		/* Do a quick scan of the SG list for any unaligned mappings */
-		for_each_sg(data->sg, sg, host->sg_count, i)
+		for_each_sg(data->sg, sg, data->sg_count, i)
 			if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
 				has_unaligned = true;
 				break;
@@ -813,7 +811,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 
 			align = host->align_buffer;
 
-			for_each_sg(data->sg, sg, host->sg_count, i) {
+			for_each_sg(data->sg, sg, data->sg_count, i) {
 				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
 					size = SDHCI_ADMA2_ALIGN -
 					       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
@@ -1133,7 +1131,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			WARN_ON(1);
 			host->flags &= ~SDHCI_REQ_USE_DMA;
 		} else if (host->flags & SDHCI_USE_ADMA) {
-			sdhci_adma_table_pre(host, data, sg_cnt);
+			sdhci_adma_table_pre(host, data);
 			sdhci_set_adma_addr(host, host->adma_addr);
 		} else {
 			WARN_ON(sg_cnt != 1);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 96aed99..f33830b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -589,8 +589,6 @@ struct sdhci_host {
 	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
 	unsigned int blocks;	/* remaining PIO blocks */
 
-	int sg_count;		/* Mapped sg entries */
-
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
 	void *integr_table;	/* ADMA3 intergrate descriptor table */
-- 
1.9.1


Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E19C5519A
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B8720700
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf3GbWb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgDZJjj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDZJji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 05:39:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68F6C061A0C;
        Sun, 26 Apr 2020 02:39:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x26so7109849pgc.10;
        Sun, 26 Apr 2020 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jfYR5evifG0fUU56UBT/HWVRBw1BzDqvHK4BrBvEEGE=;
        b=jf3GbWb8HTymZ+9VP/P5zcR3rqP8Is9+Vly5c7GHzkGwKxHxZIbz9LwN9v3Kgaq0Mr
         yQfKNBF5XmHceTXJ4hJjnuqfPiEc9q6exdkPTArEz5IIbW9bxtBiDUeGpi79xcC5h/fw
         C3XcUBo1G+2FfXS6TjQF/u9i7QBcX/Vv8ObuBCQCcURYP8JbqiwuBbKvXkiDjmrkQeDa
         tWU3TLuqSyk79E69ZrdJEwzyWcH5aYzyI+aifhiw1yDDfofC8ki30IE6mjiuEcbie1OC
         2Kp6sIzKddqrHBWScwOghAZIAy5Wm35gIf3VctFPZ5vpORHTbtTxXhXA+ngjQ6o1C8rW
         CtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jfYR5evifG0fUU56UBT/HWVRBw1BzDqvHK4BrBvEEGE=;
        b=sXgNbfkDdOFvVJtPDbfatMLSBxvPWLM95VYoS5X1xh8CTWBPnQJI9IaBS3pjb+lXQk
         GWPjiyZLTWQimEsfXWXeipZlaTKyHIaQMS2WN/nOgtB4fIN+5Ukspw8ChBRSj6zgzc9e
         Cy1RWiCwFS+zl7wXCe4yxWazSd7wzcgrmhHrwzNFjw89xafMQ4nIFwOSKenBtaNJTo3g
         aj0wguFsnfzEqvtqwZBrBEbIeaaVTGGvauzDFSjmEy3nz9cUt5RiFbx97gpmXR3yOp50
         tS4nNOQsIi8KAN31skatkFZF7XXS9FGsrYA8yNZgF7GFK39XGCoWepZFDh3X8BHrkiTu
         2ubg==
X-Gm-Message-State: AGi0Pub2YYdrv+Qh+jR85SiIKBMAj7pRztOEWdoAAgG1yCeooMC6BQWU
        KjJtNGEIH4NXGFbbGwbLRIk=
X-Google-Smtp-Source: APiQypL5yj7QTT/W8xhQKttgmDDKCVnKhl+IM6Z+wfSchjuOXgnS7Ld5y/T5IUaY+GGW5q+KZhSbsA==
X-Received: by 2002:a65:6704:: with SMTP id u4mr18202080pgf.263.1587893978252;
        Sun, 26 Apr 2020 02:39:38 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id m129sm1835245pga.47.2020.04.26.02.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 02:39:37 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, linus.walleij@linaro.org, paolo.valente@linaro.org,
        ming.lei@redhat.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/7] mmc: host: sdhci: Introduce ADMA3 transfer mode
Date:   Sun, 26 Apr 2020 17:38:56 +0800
Message-Id: <54c1eb01f4685ed4ef457ce93a08e354c65837d0.1587888520.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The standard SD host controller can support ADMA3 transfer mode optionally.
The ADMA3 uses command descriptor to issue an SD command, and a multi-block
data transfer is programmed by using a pair of command descriptor and ADMA2
descriptor. ADMA3 performs multiple of multi-block data transfer by using
integrated descriptor.

This is a preparation patch to add ADMA3 structures and help to expand the
ADMA buffer for support ADMA3 transfer mode.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c | 106 ++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.h |  48 ++++++++++++++++++
 2 files changed, 137 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0baef595de26..afea8393c71f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -773,7 +773,8 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 		 * If this triggers then we have a calculation bug
 		 * somewhere. :/
 		 */
-		WARN_ON((desc - host->adma_table) >= host->adma_table_sz);
+		WARN_ON((desc - host->adma_table) >=
+			host->adma_table_sz * host->adma3_table_cnt);
 	}
 
 	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
@@ -4148,10 +4149,17 @@ int sdhci_setup_host(struct sdhci_host *host)
 		(host->caps & SDHCI_CAN_DO_ADMA2))
 		host->flags |= SDHCI_USE_ADMA;
 
+	if ((host->quirks2 & SDHCI_QUIRK2_USE_ADMA3_SUPPORT) &&
+	    (host->flags & SDHCI_USE_ADMA) &&
+	    (host->caps1 & SDHCI_CAN_DO_ADMA3)) {
+		DBG("Enable ADMA3 mode for data transfer\n");
+		host->flags |= SDHCI_USE_ADMA3;
+	}
+
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA) &&
 		(host->flags & SDHCI_USE_ADMA)) {
 		DBG("Disabling ADMA as it is marked broken\n");
-		host->flags &= ~SDHCI_USE_ADMA;
+		host->flags &= ~(SDHCI_USE_ADMA | SDHCI_USE_ADMA3);
 	}
 
 	if (sdhci_can_64bit_dma(host))
@@ -4184,7 +4192,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		if (ret) {
 			pr_warn("%s: No suitable DMA available - falling back to PIO\n",
 				mmc_hostname(mmc));
-			host->flags &= ~(SDHCI_USE_SDMA | SDHCI_USE_ADMA);
+			host->flags &= ~(SDHCI_USE_SDMA | SDHCI_USE_ADMA | SDHCI_USE_ADMA3);
 
 			ret = 0;
 		}
@@ -4206,31 +4214,68 @@ int sdhci_setup_host(struct sdhci_host *host)
 		host->desc_sz = host->alloc_desc_sz;
 		host->adma_table_sz = host->adma_table_cnt * host->desc_sz;
 
+		host->adma3_table_cnt = 1;
+
+		if (host->flags & SDHCI_USE_ADMA3) {
+			/* We can package maximum 16 requests once */
+			host->adma3_table_cnt = SDHCI_MAX_ADMA3_ENTRIES;
+
+			if (host->flags & SDHCI_USE_64_BIT_DMA)
+				host->integr_desc_sz = SDHCI_INTEGR_64_DESC_SZ;
+			else
+				host->integr_desc_sz = SDHCI_INTEGR_32_DESC_SZ;
+
+			host->cmd_desc_sz = SDHCI_ADMA3_CMD_DESC_SZ;
+			host->cmd_table_sz = host->adma3_table_cnt *
+				SDHCI_ADMA3_CMD_DESC_SZ * SDHCI_ADMA3_CMD_DESC_ENTRIES;
+
+			buf = dma_alloc_coherent(mmc_dev(mmc),
+						 host->adma3_table_cnt *
+						 host->integr_desc_sz,
+						 &dma, GFP_KERNEL);
+			if (!buf) {
+				pr_warn("%s: Unable to allocate ADMA3 integrated buffers - falling back to ADMA\n",
+					mmc_hostname(mmc));
+				host->flags &= ~SDHCI_USE_ADMA3;
+				host->adma3_table_cnt = 1;
+			} else {
+				host->integr_table = buf;
+				host->integr_addr = dma;
+			}
+		}
+
 		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
 		/*
 		 * Use zalloc to zero the reserved high 32-bits of 128-bit
 		 * descriptors so that they never need to be written.
 		 */
 		buf = dma_alloc_coherent(mmc_dev(mmc),
-					 host->align_buffer_sz + host->adma_table_sz,
+					 host->align_buffer_sz *
+					 host->adma3_table_cnt +
+					 host->cmd_table_sz +
+					 host->adma_table_sz *
+					 host->adma3_table_cnt,
 					 &dma, GFP_KERNEL);
 		if (!buf) {
 			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
 				mmc_hostname(mmc));
-			host->flags &= ~SDHCI_USE_ADMA;
-		} else if ((dma + host->align_buffer_sz) &
+			host->flags &= ~(SDHCI_USE_ADMA | SDHCI_USE_ADMA3);
+		} else if ((dma + host->align_buffer_sz * host->adma3_table_cnt) &
 			   (SDHCI_ADMA2_DESC_ALIGN - 1)) {
 			pr_warn("%s: unable to allocate aligned ADMA descriptor\n",
 				mmc_hostname(mmc));
-			host->flags &= ~SDHCI_USE_ADMA;
-			dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
-					  host->adma_table_sz, buf, dma);
+			host->flags &= ~(SDHCI_USE_ADMA | SDHCI_USE_ADMA3);
+			dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz *
+					  host->adma3_table_cnt +
+					  host->cmd_table_sz +
+					  host->adma_table_sz *
+					  host->adma3_table_cnt, buf, dma);
 		} else {
 			host->align_buffer = buf;
 			host->align_addr = dma;
 
-			host->adma_table = buf + host->align_buffer_sz;
-			host->adma_addr = dma + host->align_buffer_sz;
+			host->adma_table = buf + host->align_buffer_sz * host->adma3_table_cnt;
+			host->adma_addr = dma + host->align_buffer_sz * host->adma3_table_cnt;
 		}
 	}
 
@@ -4631,12 +4676,21 @@ int sdhci_setup_host(struct sdhci_host *host)
 		regulator_disable(mmc->supply.vqmmc);
 undma:
 	if (host->align_buffer)
-		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
-				  host->adma_table_sz, host->align_buffer,
+		dma_free_coherent(mmc_dev(mmc),
+				  host->align_buffer_sz * host->adma3_table_cnt +
+				  host->cmd_table_sz +
+				  host->adma_table_sz * host->adma3_table_cnt,
+				  host->align_buffer,
 				  host->align_addr);
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
 
+	if (host->integr_table)
+		dma_free_coherent(mmc_dev(mmc),
+				  host->adma3_table_cnt * host->integr_desc_sz,
+				  host->integr_table, host->integr_addr);
+	host->integr_table = NULL;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sdhci_setup_host);
@@ -4649,8 +4703,11 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
-		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
-				  host->adma_table_sz, host->align_buffer,
+		dma_free_coherent(mmc_dev(mmc),
+				  host->align_buffer_sz * host->adma3_table_cnt +
+				  host->cmd_table_sz +
+				  host->adma_table_sz * host->adma3_table_cnt,
+				  host->align_buffer,
 				  host->align_addr);
 
 	if (host->use_external_dma)
@@ -4658,6 +4715,12 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
+
+	if (host->integr_table)
+		dma_free_coherent(mmc_dev(mmc),
+				  host->adma3_table_cnt * host->integr_desc_sz,
+				  host->integr_table, host->integr_addr);
+	host->integr_table = NULL;
 }
 EXPORT_SYMBOL_GPL(sdhci_cleanup_host);
 
@@ -4786,8 +4849,11 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
-		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
-				  host->adma_table_sz, host->align_buffer,
+		dma_free_coherent(mmc_dev(mmc),
+				  host->align_buffer_sz * host->adma3_table_cnt +
+				  host->cmd_table_sz +
+				  host->adma_table_sz * host->adma3_table_cnt,
+				  host->align_buffer,
 				  host->align_addr);
 
 	if (host->use_external_dma)
@@ -4795,6 +4861,12 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
+
+	if (host->integr_table)
+		dma_free_coherent(mmc_dev(mmc),
+				  host->adma3_table_cnt * host->integr_desc_sz,
+				  host->integr_table, host->integr_addr);
+	host->integr_table = NULL;
 }
 
 EXPORT_SYMBOL_GPL(sdhci_remove_host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4bd70da7aa00..5cade9a7b53a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -272,6 +272,9 @@
 #define SDHCI_PRESET_CLKGEN_SEL		BIT(10)
 #define SDHCI_PRESET_SDCLK_FREQ_MASK	GENMASK(9, 0)
 
+#define SDHCI_ADMA3_ADDRESS	0x78
+#define SDHCI_ADMA3_ADDRESS_HI	0x7c
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
@@ -344,6 +347,41 @@ struct sdhci_adma2_64_desc {
 #define ADMA2_NOP_END_VALID	0x3
 #define ADMA2_END		0x2
 
+#define SDHCI_MAX_ADMA3_ENTRIES	16
+
+/* ADMA3 command descriptor */
+struct sdhci_adma3_cmd_desc {
+	__le32	cmd;
+	__le32	reg;
+}  __packed __aligned(4);
+
+#define ADMA3_TRAN_VALID	0x9
+#define ADMA3_TRAN_END		0xb
+
+/* ADMA3 command descriptor size */
+#define SDHCI_ADMA3_CMD_DESC_ENTRIES	4
+#define SDHCI_ADMA3_CMD_DESC_SZ		8
+
+/* ADMA3 integrated 32-bit descriptor */
+struct sdhci_integr_32_desc {
+	__le32	cmd;
+	__le32	addr;
+}  __packed __aligned(4);
+
+#define SDHCI_INTEGR_32_DESC_SZ		8
+
+/* ADMA3 integrated 64-bit descriptor. */
+struct sdhci_integr_64_desc {
+	__le32	cmd;
+	__le32	addr_lo;
+	__le32	addr_hi;
+}  __packed __aligned(4);
+
+#define SDHCI_INTEGR_64_DESC_SZ		16
+
+#define ADMA3_INTEGR_TRAN_VALID		0x39
+#define ADMA3_INTEGR_TRAN_END		0x3b
+
 /*
  * Maximum segments assuming a 512KiB maximum requisition size and a minimum
  * 4KiB page size.
@@ -482,6 +520,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* use ADMA3 for data read/write if hardware supports */
+#define SDHCI_QUIRK2_USE_ADMA3_SUPPORT			(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
@@ -518,6 +558,7 @@ struct sdhci_host {
 #define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */
 #define SDHCI_SIGNALING_180	(1<<15)	/* Host is capable of 1.8V signaling */
 #define SDHCI_SIGNALING_120	(1<<16)	/* Host is capable of 1.2V signaling */
+#define SDHCI_USE_ADMA3		(1<<17)	/* Host is ADMA3 capable */
 
 	unsigned int version;	/* SDHCI spec. version */
 
@@ -551,15 +592,20 @@ struct sdhci_host {
 
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
+	void *integr_table;	/* ADMA3 intergrate descriptor table */
 
 	size_t adma_table_sz;	/* ADMA descriptor table size */
 	size_t align_buffer_sz;	/* Bounce buffer size */
+	size_t cmd_table_sz;	/* ADMA3 command descriptor table size */
 
 	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
 	dma_addr_t align_addr;	/* Mapped bounce buffer */
+	dma_addr_t integr_addr;	/* Mapped ADMA3 intergrate descr. table */
 
 	unsigned int desc_sz;	/* ADMA current descriptor size */
 	unsigned int alloc_desc_sz;	/* ADMA descr. max size host supports */
+	unsigned int cmd_desc_sz;	/* ADMA3 command descriptor size */
+	unsigned int integr_desc_sz;	/* ADMA3 intergrate descriptor size */
 
 	struct workqueue_struct *complete_wq;	/* Request completion wq */
 	struct work_struct	complete_work;	/* Request completion work */
@@ -610,6 +656,8 @@ struct sdhci_host {
 
 	/* Host ADMA table count */
 	u32			adma_table_cnt;
+	/* Host ADMA3 table count */
+	u32			adma3_table_cnt;
 
 	u64			data_timeout;
 
-- 
2.17.1


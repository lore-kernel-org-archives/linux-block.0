Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BFDC76188
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88A421921
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsWBnyL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfGVNKT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:10:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41398 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfGVNKS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 09:10:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so17365529pff.8
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dG/LqrH9yTrCP4/AqHuYjFpolOWLOfEjROmiSDxrhyI=;
        b=xsWBnyL2HHwNYBdOs1xtJ+gKp5zK3I/iBKhtQ3IJVL4TbemyEJn2Yh/NU32uSQhfZP
         RSGQ6vDyOme1RaQM71oJz+BajQNDUa/7gE/rdJaU+FIx5YHW6NJUv3dN9bx9rK1yCL+C
         I1fn0TeveF3hrmoOeyEGCu5cxwxKVmuDAmTpyVmuwqL+6/f/mai82tDqlHgqkeEuTwf/
         VvqSE0sbF4xjlghheF1jOmiRzwD/LA+rv9GJzkloVtuvRzGbpm74wih39id0FS3cR6zW
         Tjiw0/NVn8nxCGmtvOS9KUGm0AxN+V84gOVqY//nRrDNCEQ8fYxy4/ndAOqKAIPE61w7
         pjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dG/LqrH9yTrCP4/AqHuYjFpolOWLOfEjROmiSDxrhyI=;
        b=N3dlyNPmeVy97wZQLOO0VBRaAf+wuh9xpbfeQxdd9+p6qrXj0tplaALZ4iGqXtgCjv
         S/4OOGJvScaeBDIL5FkFfrdqQB/CQC6ccIm7xQBwJ3v/+87LipBTc/EeUfPvj58IgUwz
         BvEe/6wQ42JDKS9jvXwPBBYRFK4F1XtJpZaNuXgy3Z3DbXoGOYOJaDHZSo0ucs2P9eko
         y7uuy6k3QAyL7czK73UUgERpev2q/L+txEwoK2Cw5RiAeZmdoZgdchKmAocUc4sCd5oh
         MQwCDsHpHAEuD5G0738E+3zOVgxhI9FQlOaBCf4+NAI/M6nC1TxL+TWMASZ15QKECv2v
         D1Kw==
X-Gm-Message-State: APjAAAVJkiyY73tsA4WYFDP+cuJhrsCapD0TR4KqRUMUPQSPgQYg6VSh
        gqDIkNcEl5+IZX22oj1MDB2pyg==
X-Google-Smtp-Source: APXvYqxuj3s+E6xDhpU4KpMJYWcyp0Tp3n/yS/80RLpMaY864CfQGAtHUZmOk2f+VYIwzQSZlROm1g==
X-Received: by 2002:a63:a35c:: with SMTP id v28mr28042212pgn.144.1563801017601;
        Mon, 22 Jul 2019 06:10:17 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm47013192pfn.99.2019.07.22.06.10.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:10:17 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 3/7] mmc: host: sdhci: Introduce ADMA3 transfer mode
Date:   Mon, 22 Jul 2019 21:09:38 +0800
Message-Id: <cea65bf03a9773156135986a5ebaa28940b63d0a.1563782844.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
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

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |  105 ++++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |   48 +++++++++++++++++++++
 2 files changed, 136 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e..e57a5b7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -240,7 +240,7 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 	host->ops->reset(host, mask);
 
 	if (mask & SDHCI_RESET_ALL) {
-		if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
+		if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA | SDHCI_USE_ADMA3)) {
 			if (host->ops->enable_dma)
 				host->ops->enable_dma(host);
 		}
@@ -3750,10 +3750,17 @@ int sdhci_setup_host(struct sdhci_host *host)
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
 
 	/*
@@ -3775,7 +3782,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		if (ret) {
 			pr_warn("%s: No suitable DMA available - falling back to PIO\n",
 				mmc_hostname(mmc));
-			host->flags &= ~(SDHCI_USE_SDMA | SDHCI_USE_ADMA);
+			host->flags &= ~(SDHCI_USE_SDMA | SDHCI_USE_ADMA | SDHCI_USE_ADMA3);
 
 			ret = 0;
 		}
@@ -3799,31 +3806,68 @@ int sdhci_setup_host(struct sdhci_host *host)
 			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
 		}
 
+		host->adma3_table_cnt = 1;
+
+		if (host->flags & SDHCI_USE_ADMA3) {
+			/* We can pack maximum 16 requests once */
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
 
@@ -4222,12 +4266,21 @@ int sdhci_setup_host(struct sdhci_host *host)
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
@@ -4240,11 +4293,20 @@ void sdhci_cleanup_host(struct sdhci_host *host)
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
 
@@ -4372,12 +4434,21 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
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
index 89fd965..010cc29 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -273,6 +273,9 @@
 #define SDHCI_PRESET_SDCLK_FREQ_MASK   0x3FF
 #define SDHCI_PRESET_SDCLK_FREQ_SHIFT	0
 
+#define SDHCI_ADMA3_ADDRESS	0x78
+#define SDHCI_ADMA3_ADDRESS_HI	0x7c
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
@@ -345,6 +348,41 @@ struct sdhci_adma2_64_desc {
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
@@ -481,6 +519,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* use ADMA3 for data read/write if hardware supports */
+#define SDHCI_QUIRK2_USE_ADMA3_SUPPORT			(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
@@ -517,6 +557,7 @@ struct sdhci_host {
 #define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */
 #define SDHCI_SIGNALING_180	(1<<15)	/* Host is capable of 1.8V signaling */
 #define SDHCI_SIGNALING_120	(1<<16)	/* Host is capable of 1.2V signaling */
+#define SDHCI_USE_ADMA3		(1<<17)	/* Host is ADMA3 capable */
 
 	unsigned int version;	/* SDHCI spec. version */
 
@@ -547,14 +588,19 @@ struct sdhci_host {
 
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
+	void *integr_table;	/* ADMA3 intergrate descriptor table */
 
 	size_t adma_table_sz;	/* ADMA descriptor table size */
 	size_t align_buffer_sz;	/* Bounce buffer size */
+	size_t cmd_table_sz;	/* ADMA3 command descriptor table size */
 
 	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
 	dma_addr_t align_addr;	/* Mapped bounce buffer */
+	dma_addr_t integr_addr;	/* Mapped ADMA3 intergrate descr. table */
 
 	unsigned int desc_sz;	/* ADMA descriptor size */
+	unsigned int cmd_desc_sz;	/* ADMA3 command descriptor size */
+	unsigned int integr_desc_sz;	/* ADMA3 intergrate descriptor size */
 
 	struct workqueue_struct *complete_wq;	/* Request completion wq */
 	struct work_struct	complete_work;	/* Request completion work */
@@ -600,6 +646,8 @@ struct sdhci_host {
 
 	/* Host ADMA table count */
 	u32			adma_table_cnt;
+	/* Host ADMA3 table count */
+	u32			adma3_table_cnt;
 
 	u64			data_timeout;
 
-- 
1.7.9.5


Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF86BC33CB6
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B6B20842
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIjbotbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgAQFZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:25:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39546 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgAQFZ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 00:25:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so11387770pfs.6;
        Thu, 16 Jan 2020 21:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dQSh2h3aMK8EaKhySKU03OMe1JMqWE38g+hICD3IyDA=;
        b=eIjbotbEzzZ0a+eChatjgrszxvO7wFMA9oHMeLsRr/VadGSqVE31aZWn6DkQJtAdI+
         diNw9J6Jk80HJCy7aWRlPIXrUaEsbKZhJUwlczXcM3GnbKPDTx1PMEb1FTblSVuQZxW+
         VI+WVlfxU3AdsEImzIXrrKRLf0jEvJVq7r4fjroxXiAqYrU9dKHM0Q2XFYo/vXVrGKSe
         8jrbxpmzzhiQ5aGt9ksP5icsqHjm/pwR8FJiN9pbUt8rCxrR7hBYvGNQlyag/qSpL1tu
         6pTUnCDrK7BC7r1bNKcdaHR1IIxEH/yJKdQvDrqWmcXLFa/ZTp0F8r3KLLAOToeevyCU
         9dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dQSh2h3aMK8EaKhySKU03OMe1JMqWE38g+hICD3IyDA=;
        b=LLhExOdOrQgUOw18Tq+sEB2NviWyzSlDQwDWKPjhl91AXwSfvhdq8kXndHsUgatR5k
         gKnfDAv+yIXzH3rFniIvetuDSwE64jaxTaba5GOj2kvKiyHvbYYdXTS5VB1miRvuRDnl
         xorjZAolPxlY6yfgPrrXFmmBpBDnHtV86+npf8wRMAm/Pna8y6PFM8btYr2EJVLQyH4Z
         aEIXLWPsn5mFBMC6JAkSqeZ3bOi3P2iqGN5sI5G2SeJfAu63GHQyThP55woKWl/U8f/b
         5g4Rklq7PQdV5LuHotHRu6zVN5CGOTmeWyqeI4W/5pkRHRSQ59XbrvaSI2KSYrjGj/rs
         uSsQ==
X-Gm-Message-State: APjAAAUxPDlMv72tpZCkMDRdjibEx7y7LJjDw7kMgZn78QhHZfb63uUB
        73bZ8yFt9RVdkZRNpCMUF3ICwUY0
X-Google-Smtp-Source: APXvYqxNmkZwyGMMMgEl1JnWlWxJjKAUPGVwASK+XxgtEYKgnKVZ7rZ4IOOsSU9SVrtyuLbq/jUojA==
X-Received: by 2002:a65:64c6:: with SMTP id t6mr42217562pgv.392.1579238727035;
        Thu, 16 Jan 2020 21:25:27 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c26sm28844756pfj.101.2020.01.16.21.25.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jan 2020 21:25:26 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [RFC PATCH 4/8] mmc: host: sdhci: Introduce ADMA3 transfer mode
Date:   Fri, 17 Jan 2020 13:24:23 +0800
Message-Id: <0ac890d2820f3b7bd8abc1030730f1ce7442499a.1579164456.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
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
 drivers/mmc/host/sdhci.c |  106 ++++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |   48 +++++++++++++++++++++
 2 files changed, 137 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 004f789..907a35e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -771,7 +771,8 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 		 * If this triggers then we have a calculation bug
 		 * somewhere. :/
 		 */
-		WARN_ON((desc - host->adma_table) >= host->adma_table_sz);
+		WARN_ON((desc - host->adma_table) >=
+			host->adma_table_sz * host->adma3_table_cnt);
 	}
 
 	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
@@ -3805,10 +3806,17 @@ int sdhci_setup_host(struct sdhci_host *host)
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
@@ -3826,7 +3834,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		if (ret) {
 			pr_warn("%s: No suitable DMA available - falling back to PIO\n",
 				mmc_hostname(mmc));
-			host->flags &= ~(SDHCI_USE_SDMA | SDHCI_USE_ADMA);
+			host->flags &= ~(SDHCI_USE_SDMA | SDHCI_USE_ADMA | SDHCI_USE_ADMA3);
 
 			ret = 0;
 		}
@@ -3850,31 +3858,68 @@ int sdhci_setup_host(struct sdhci_host *host)
 			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
 		}
 
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
 
@@ -4273,12 +4318,21 @@ int sdhci_setup_host(struct sdhci_host *host)
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
@@ -4291,11 +4345,20 @@ void sdhci_cleanup_host(struct sdhci_host *host)
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
 
@@ -4423,12 +4486,21 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
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
index cecc64b..a5df807 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -274,6 +274,9 @@
 #define SDHCI_PRESET_SDCLK_FREQ_MASK   0x3FF
 #define SDHCI_PRESET_SDCLK_FREQ_SHIFT	0
 
+#define SDHCI_ADMA3_ADDRESS	0x78
+#define SDHCI_ADMA3_ADDRESS_HI	0x7c
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
@@ -346,6 +349,41 @@ struct sdhci_adma2_64_desc {
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
@@ -517,6 +557,7 @@ struct sdhci_host {
 #define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */
 #define SDHCI_SIGNALING_180	(1<<15)	/* Host is capable of 1.8V signaling */
 #define SDHCI_SIGNALING_120	(1<<16)	/* Host is capable of 1.2V signaling */
+#define SDHCI_USE_ADMA3		(1<<17)	/* Host is ADMA3 capable */
 
 	unsigned int version;	/* SDHCI spec. version */
 
@@ -548,14 +589,19 @@ struct sdhci_host {
 
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
@@ -601,6 +647,8 @@ struct sdhci_host {
 
 	/* Host ADMA table count */
 	u32			adma_table_cnt;
+	/* Host ADMA3 table count */
+	u32			adma3_table_cnt;
 
 	u64			data_timeout;
 
-- 
1.7.9.5


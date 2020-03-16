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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C5C5ACBF
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D4B20754
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr5xEAiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgCPKB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:01:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38974 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbgCPKB4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 06:01:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id j20so7767548pll.6;
        Mon, 16 Mar 2020 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=o1DIsdYS7ff4jJb5jCTI/tsP5spVoqhTKmmU077/da4=;
        b=Jr5xEAiMjYgi7TOw021o1pEmQUbJ9AgMAYqAtB0HXbgBj/U4qKR5z3fnbBB4GLIWkb
         XFlvpQRpaitJ+hDHvUQZ9JER5Ew3AtF46351sY5KpcRbQ0c7ke5DKR6OJ7qGiLby6bFh
         ZHt2QbHsPCPDC4fjg15Md4YanbD7UvfXL2JmBwPRLmPKv1BpjqM2f4VGMvjrZVJMKfxz
         OD603oxOD8Vn8Tlzs4GSDcVg8RwrVcyEX+NZ2oFKvtjdFuGMicQdNh14EO+GsqUOXW4v
         kbbkDAe2oPydcRovbTYMmkfnSzegdSky90vp1gHDWldw2Zzpv4a88CwSX3wyqvLNr4Kn
         S6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=o1DIsdYS7ff4jJb5jCTI/tsP5spVoqhTKmmU077/da4=;
        b=S9CxhPDfJNNo4Gnx01mc4YG3jcvEfLb632kbT40UHWjNRIpZxgWK+MZn4YWvb4IKOa
         O7kmqyWRwxuPwRwZGdItHSjZCb/7kfZ9PtIKq1K/aZJnpn6C8Iq7tXowWBFuyH/pQRTK
         EC0IpYYFzUyzmgE6afBJUdqF5RKADr6G7yPXBuvQ9wCzs13KIbNtavIX5WLAHj2j1hAG
         fOAVotw9JXyol/m/l4t9vIzVeTVKg9LRDs9u/da8X9NxoG3EvBwS5W7RcBR6WeI/+E/w
         f7cBw+Ej8FnUmAB758DC6pLdCy8/QKbJfkwed/l3Ay9doWGxmYY8gDfEnAMao285/b74
         BAww==
X-Gm-Message-State: ANhLgQ3q8aI59D+4aNAOJ8X/CnOqz1cDHcpvTm/XESf8EWFM9rcvk4Fd
        ioAJKZHUaBAmCwuyJWbkuno=
X-Google-Smtp-Source: ADFU+vvAIAXggVnK9BXVLESVBN4pJu4tsfGabg1WukYRfyJanyZ6iLhHpKnnELZbDfK8Q4We8pMlig==
X-Received: by 2002:a17:90a:218e:: with SMTP id q14mr10943428pjc.37.1584352913547;
        Mon, 16 Mar 2020 03:01:53 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 136sm63970411pgh.26.2020.03.16.03.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 03:01:53 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     ming.lei@redhat.com, arnd@arndb.de, linus.walleij@linaro.org,
        baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH 4/8] mmc: host: sdhci: Introduce ADMA3 transfer mode
Date:   Mon, 16 Mar 2020 18:01:21 +0800
Message-Id: <a1dcb9128356adf623c057b3c658de6dc5422742.1584350380.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
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
 drivers/mmc/host/sdhci.c | 106 +++++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |  48 +++++++++++++++++++++
 2 files changed, 137 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4febbcb..6238b5c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -772,7 +772,8 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 		 * If this triggers then we have a calculation bug
 		 * somewhere. :/
 		 */
-		WARN_ON((desc - host->adma_table) >= host->adma_table_sz);
+		WARN_ON((desc - host->adma_table) >=
+			host->adma_table_sz * host->adma3_table_cnt);
 	}
 
 	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
@@ -4012,10 +4013,17 @@ int sdhci_setup_host(struct sdhci_host *host)
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
@@ -4048,7 +4056,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		if (ret) {
 			pr_warn("%s: No suitable DMA available - falling back to PIO\n",
 				mmc_hostname(mmc));
-			host->flags &= ~(SDHCI_USE_SDMA | SDHCI_USE_ADMA);
+			host->flags &= ~(SDHCI_USE_SDMA | SDHCI_USE_ADMA | SDHCI_USE_ADMA3);
 
 			ret = 0;
 		}
@@ -4070,31 +4078,68 @@ int sdhci_setup_host(struct sdhci_host *host)
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
 
@@ -4495,12 +4540,21 @@ int sdhci_setup_host(struct sdhci_host *host)
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
@@ -4513,8 +4567,11 @@ void sdhci_cleanup_host(struct sdhci_host *host)
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
@@ -4522,6 +4579,12 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 
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
 
@@ -4650,8 +4713,11 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
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
@@ -4659,6 +4725,12 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
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
index 5507a73..96aed99 100644
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
@@ -484,6 +522,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* use ADMA3 for data read/write if hardware supports */
+#define SDHCI_QUIRK2_USE_ADMA3_SUPPORT			(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
@@ -520,6 +560,7 @@ struct sdhci_host {
 #define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */
 #define SDHCI_SIGNALING_180	(1<<15)	/* Host is capable of 1.8V signaling */
 #define SDHCI_SIGNALING_120	(1<<16)	/* Host is capable of 1.2V signaling */
+#define SDHCI_USE_ADMA3		(1<<17)	/* Host is ADMA3 capable */
 
 	unsigned int version;	/* SDHCI spec. version */
 
@@ -552,15 +593,20 @@ struct sdhci_host {
 
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
@@ -611,6 +657,8 @@ struct sdhci_host {
 
 	/* Host ADMA table count */
 	u32			adma_table_cnt;
+	/* Host ADMA3 table count */
+	u32			adma3_table_cnt;
 
 	u64			data_timeout;
 
-- 
1.9.1


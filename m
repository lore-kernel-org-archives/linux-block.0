Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DD9C76190
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1FA21BE6
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eL4x2dfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfGVNKk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:10:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44165 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbfGVNKb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 09:10:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so19183542plr.11
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=56eFY5zrf98NeoxZQ8w/ietp7b8X8om0HlbnDu6jokY=;
        b=eL4x2dfZ8oxaRI+ojUn+fnWLzsD3ngHZDRX1LKvPqzXl8Qz2JfR/15j/c9DWiH9Xqe
         I4xe6snMT0TTYTNKzLo4jLcKQ3orAC6VBNj5K/ESRZ19TfBr3hW7dYUo8L6brIXxmS+Z
         VqZBCGJ9sg2E7K5cYTK6JyoLu1qWifNLd9fOLXs33XP+zpeFFZXZFl/OzRn27n6KyqBy
         Vbwf/pkkRNjbZbPPXMktMopR3uRKB+XIZFW3Mizu07036Xglvqia1RSdNtz+Q9feXXfv
         skmCOgm/8ejOOvhCFjkdmedZJyVt75kY06BKIp308t9EY54CZ2mqCHUFl9J7hkPtquUW
         TADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=56eFY5zrf98NeoxZQ8w/ietp7b8X8om0HlbnDu6jokY=;
        b=ZSjv2SXj0xJpuTpLASZ7/zvPPV/I0r5lV6aG9VTnKtCNaTia2wg5rFt6OWYX492hVU
         KnnhZeItHyMgJkqr+57uuV7LGlU9YntsYacWtcfS/c3CUZqcQGn8QlwHf48V0SSJIy6/
         eZty/QdkI6jq0A+R+++k3L1d3IDfx7b/uqZKTDfkM2Ldmuxy+8dMZm+Ho1Akn94ndHzG
         te4no/bCTCv8eEXO7ShgRLuU0UesS/iuicmrrbIUitKwlnRHKm0nOcYEZ8fKC6xgoR0G
         gZf5aosvDSViySUB71ZFTtlc98W7hcQc+//7eJJ/dqKG6Y+NmYGctADEyDVqghxtTuXv
         A7XQ==
X-Gm-Message-State: APjAAAW4gTj10aNlrcOba3LPDeP0m+RH246oZ9SuxLjNeB0s7BRCqvUD
        vNUCKzwVfiL9A/y0+BOJutuEDQ==
X-Google-Smtp-Source: APXvYqw4ac3I30qn8G3UPMT94xRNEWdM7z2XZIqlpKXYIuGaXrKV9l3/2+KQdHc9H4JX7fNO4SjmbA==
X-Received: by 2002:a17:902:7894:: with SMTP id q20mr72673888pll.339.1563801029653;
        Mon, 22 Jul 2019 06:10:29 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm47013192pfn.99.2019.07.22.06.10.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:10:29 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 6/7] mmc: host: sdhci: Add MMC packed request support
Date:   Mon, 22 Jul 2019 21:09:41 +0800
Message-Id: <82e3dbec69ad25250936cd4e3fed82013ed0115e.1563782844.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds MMC packed operations to support packed requests,
and enables ADMA3 transfer mode to support this feature.

Enable ADMA3 transfer mode only for read and write commands, and
we will disable command interrupt and data timeout interrupt,
instead we will use software data timeout for ADMA3 fransfer mode.
For other non-data commands, we still use the ADMA2 transfer, since
no bebefits using ADMA3 transfer.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |  329 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci.h |    9 ++
 2 files changed, 322 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9fec82f..3c4f701 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -109,6 +109,19 @@ void sdhci_dumpregs(struct sdhci_host *host)
 		}
 	}
 
+	if (host->adma3_enabled) {
+		if (host->flags & SDHCI_USE_64_BIT_DMA) {
+			SDHCI_DUMP("ADMA3 Err:  0x%08x | ADMA3 Ptr: 0x%08x%08x\n",
+				   sdhci_readl(host, SDHCI_ADMA_ERROR),
+				   sdhci_readl(host, SDHCI_ADMA3_ADDRESS_HI),
+				   sdhci_readl(host, SDHCI_ADMA3_ADDRESS));
+		} else {
+			SDHCI_DUMP("ADMA3 Err:  0x%08x | ADMA3 Ptr: 0x%08x\n",
+				   sdhci_readl(host, SDHCI_ADMA_ERROR),
+				   sdhci_readl(host, SDHCI_ADMA3_ADDRESS));
+		}
+	}
+
 	SDHCI_DUMP("============================================\n");
 }
 EXPORT_SYMBOL_GPL(sdhci_dumpregs);
@@ -286,7 +299,9 @@ static void sdhci_config_dma(struct sdhci_host *host)
 		goto out;
 
 	/* Note if DMA Select is zero then SDMA is selected */
-	if (host->flags & SDHCI_USE_ADMA)
+	if (host->adma3_enabled)
+		ctrl |= SDHCI_CTRL_ADMA3;
+	else if (host->flags & SDHCI_USE_ADMA)
 		ctrl |= SDHCI_CTRL_ADMA32;
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA) {
@@ -445,7 +460,7 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
 static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
 			    unsigned long timeout)
 {
-	if (sdhci_data_line_cmd(mrq->cmd))
+	if (host->prq || sdhci_data_line_cmd(mrq->cmd))
 		mod_timer(&host->data_timer, timeout);
 	else
 		mod_timer(&host->timer, timeout);
@@ -453,7 +468,7 @@ static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
 
 static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
 {
-	if (sdhci_data_line_cmd(mrq->cmd))
+	if (host->prq || sdhci_data_line_cmd(mrq->cmd))
 		del_timer(&host->data_timer);
 	else
 		del_timer(&host->timer);
@@ -710,10 +725,16 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	 * We currently guess that it is LE.
 	 */
 
-	desc = host->adma_table;
-	align = host->align_buffer;
-
-	align_addr = host->align_addr;
+	if (host->adma3_enabled) {
+		desc = host->adma3_pos;
+		align = host->adma3_align_pos;
+		align_addr = host->align_addr +
+			host->adma3_align_pos - host->align_buffer;
+	} else {
+		desc = host->adma_table;
+		align = host->align_buffer;
+		align_addr = host->align_addr;
+	}
 
 	for_each_sg(data->sg, sg, data->sg_count, i) {
 		addr = sg_dma_address(sg);
@@ -771,6 +792,11 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 		/* Add a terminating entry - nop, end, valid */
 		__sdhci_adma_write_desc(host, &desc, 0, 0, ADMA2_NOP_END_VALID);
 	}
+
+	if (host->adma3_enabled) {
+		host->adma3_pos = desc;
+		host->adma3_align_pos = align;
+	}
 }
 
 static void sdhci_adma_table_post(struct sdhci_host *host,
@@ -796,7 +822,10 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 			dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
 					    data->sg_len, DMA_FROM_DEVICE);
 
-			align = host->align_buffer;
+			if (host->adma3_enabled)
+				align = host->adma3_align_pos;
+			else
+				align = host->align_buffer;
 
 			for_each_sg(data->sg, sg, data->sg_count, i) {
 				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
@@ -810,6 +839,9 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 					align += SDHCI_ADMA2_ALIGN;
 				}
 			}
+
+			if (host->adma3_enabled)
+				host->adma3_align_pos = align;
 		}
 	}
 }
@@ -1014,13 +1046,13 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 
 	host->data_timeout = 0;
 
-	if (sdhci_data_line_cmd(cmd))
+	if (!host->prq && sdhci_data_line_cmd(cmd))
 		sdhci_set_timeout(host, cmd);
 
 	if (!data)
 		return;
 
-	WARN_ON(host->data);
+	WARN_ON(!host->prq && host->data);
 
 	/* Sanity checks */
 	BUG_ON(data->blksz * data->blocks > 524288);
@@ -1094,11 +1126,14 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		} else if (host->flags & SDHCI_USE_ADMA) {
 			sdhci_adma_table_pre(host, data);
 
-			sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
-			if (host->flags & SDHCI_USE_64_BIT_DMA)
-				sdhci_writel(host,
-					     (u64)host->adma_addr >> 32,
-					     SDHCI_ADMA_ADDRESS_HI);
+			if (!host->adma3_enabled) {
+				sdhci_writel(host, host->adma_addr,
+					     SDHCI_ADMA_ADDRESS);
+				if (host->flags & SDHCI_USE_64_BIT_DMA)
+					sdhci_writel(host,
+						     (u64)host->adma_addr >> 32,
+						     SDHCI_ADMA_ADDRESS_HI);
+			}
 		} else {
 			WARN_ON(sg_cnt != 1);
 			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
@@ -1121,6 +1156,9 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_irqs(host);
 
+	if (host->adma3_enabled)
+		return;
+
 	/* Set the DMA boundary value and block size */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
 		     SDHCI_BLOCK_SIZE);
@@ -1278,6 +1316,36 @@ static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 	queue_work(host->complete_wq, &host->complete_work);
 }
 
+static void sdhci_finish_packed_data(struct sdhci_host *host, int error)
+{
+	struct mmc_request *mrq;
+
+	host->data = NULL;
+	/*
+	 * Reset the align buffer pointer address for unaligned mappings after
+	 * finishing the transfer.
+	 */
+	host->adma3_align_pos = host->align_buffer;
+
+	if (error)
+		sdhci_do_reset(host, SDHCI_RESET_DATA);
+
+	list_for_each_entry(mrq, &host->prq->list, packed_list) {
+		struct mmc_data *data = mrq->data;
+
+		sdhci_adma_table_post(host, data);
+		data->error = error;
+
+		if (data->error)
+			data->bytes_xfered = 0;
+		else
+			data->bytes_xfered = data->blksz * data->blocks;
+	}
+
+	sdhci_del_timer(host, NULL);
+	sdhci_led_deactivate(host);
+}
+
 static void sdhci_finish_data(struct sdhci_host *host)
 {
 	struct mmc_command *data_cmd = host->data_cmd;
@@ -1786,6 +1854,209 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
  *                                                                           *
 \*****************************************************************************/
 
+static void sdhci_adma3_write_cmd_desc(struct sdhci_host *host,
+				       struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+	struct sdhci_adma3_cmd_desc *cmd_desc = host->adma3_pos;
+	int blksz, command;
+	u16 mode = 0;
+
+	/* Set block count */
+	cmd_desc->cmd = cpu_to_le32(ADMA3_TRAN_VALID);
+	cmd_desc->reg = cpu_to_le32(data->blocks);
+	cmd_desc++;
+
+	/* Set block size */
+	cmd_desc->cmd = cpu_to_le32(ADMA3_TRAN_VALID);
+	blksz = SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz);
+	cmd_desc->reg = cpu_to_le32(blksz);
+	cmd_desc++;
+
+	/* Set argument */
+	cmd_desc->cmd = cpu_to_le32(ADMA3_TRAN_VALID);
+	cmd_desc->reg = cpu_to_le32(cmd->arg);
+	cmd_desc++;
+
+	/* set command and transfer mode */
+	if (data->flags & MMC_DATA_READ)
+		mode |= SDHCI_TRNS_READ;
+
+	if (!(host->quirks2 & SDHCI_QUIRK2_SUPPORT_SINGLE))
+		mode |= SDHCI_TRNS_BLK_CNT_EN;
+
+	if (mmc_op_multi(cmd->opcode) || data->blocks > 1)
+		mode |= SDHCI_TRNS_MULTI;
+
+	sdhci_auto_cmd_select(host, cmd, &mode);
+	mode |= SDHCI_TRNS_DMA;
+
+	command = sdhci_get_command(host, cmd);
+	command = (command << 16) | mode;
+	cmd_desc->cmd = cpu_to_le32(ADMA3_TRAN_END);
+	cmd_desc->reg = cpu_to_le32(command);
+
+	host->adma3_pos +=
+		SDHCI_ADMA3_CMD_DESC_SZ * SDHCI_ADMA3_CMD_DESC_ENTRIES;
+}
+
+static void sdhci_adma3_write_integr_desc(struct sdhci_host *host,
+					  dma_addr_t addr)
+{
+	struct sdhci_integr_64_desc *integr_desc = host->integr_table;
+
+	integr_desc->cmd = cpu_to_le32(ADMA3_INTEGR_TRAN_END);
+	integr_desc->addr_lo = cpu_to_le32((u32)addr);
+
+	if (host->flags & SDHCI_USE_64_BIT_DMA)
+		integr_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
+}
+
+static void sdhci_set_adma3_addr(struct sdhci_host *host, dma_addr_t addr)
+{
+	sdhci_writel(host, addr, SDHCI_ADMA3_ADDRESS);
+	if (host->flags & SDHCI_USE_64_BIT_DMA)
+		sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA3_ADDRESS_HI);
+}
+
+int sdhci_prepare_packed(struct mmc_packed *packed)
+{
+	struct mmc_host *mmc = packed->host;
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long timeout, flags;
+	u32 mask;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (!(host->flags & SDHCI_USE_ADMA3) ||
+	    !(host->flags & (SDHCI_AUTO_CMD23 | SDHCI_AUTO_CMD12))) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		pr_err("%s: Unsupported packed request\n",
+		       mmc_hostname(host->mmc));
+		return -EOPNOTSUPP;
+	}
+
+	/* Wait max 10 ms */
+	timeout = 10;
+	mask = SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT;
+
+	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
+		if (timeout == 0) {
+			sdhci_dumpregs(host);
+			spin_unlock_irqrestore(&host->lock, flags);
+
+			pr_err("%s: Controller never released inhibit bit(s).\n",
+			       mmc_hostname(host->mmc));
+			return -EIO;
+		}
+
+		timeout--;
+		mdelay(1);
+	}
+
+	/* Disable command complete event for ADMA3 mode */
+	host->ier &= ~SDHCI_INT_RESPONSE;
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+
+	/*
+	 * Disable data timeout interrupt, and will use software timeout for
+	 * packed request.
+	 */
+	sdhci_set_data_timeout_irq(host, false);
+
+	/* Enable ADMA3 mode for packed request */
+	host->adma3_enabled = true;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+int sdhci_unprepare_packed(struct mmc_packed *packed)
+{
+	struct mmc_host *mmc = packed->host;
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	/* Disable ADMA3 mode after finishing packed request */
+	host->adma3_enabled = false;
+
+	/* Re-enable command complete event after ADMA3 mode */
+	host->ier |= SDHCI_INT_RESPONSE;
+
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+int sdhci_packed_request(struct mmc_packed *packed,
+			 struct mmc_packed_request *prq)
+{
+	struct mmc_host *mmc = packed->host;
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_request *mrq;
+	unsigned long timeout, flags;
+	u64 data_timeout = 0;
+	dma_addr_t integr_addr;
+	int present;
+
+	/* Firstly check card presence */
+	present = mmc->ops->get_cd(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	sdhci_led_activate(host);
+
+	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return -ENOMEDIUM;
+	}
+
+	host->prq = prq;
+	host->adma3_pos = host->adma_table;
+	host->adma3_align_pos = host->align_buffer;
+	integr_addr = host->adma_addr;
+
+	list_for_each_entry(mrq, &prq->list, packed_list) {
+		struct mmc_command *cmd = mrq->cmd;
+
+		/* Set command descriptor */
+		sdhci_adma3_write_cmd_desc(host, cmd);
+		/* Set ADMA2 descriptors */
+		sdhci_prepare_data(host, cmd);
+		/* Set integrated descriptor */
+		sdhci_adma3_write_integr_desc(host, integr_addr);
+
+		/* Update the integrated descriptor address */
+		integr_addr =
+			host->adma_addr + (host->adma3_pos - host->adma_table);
+
+		/* Calculate each command's data timeout */
+		sdhci_calc_sw_timeout(host, cmd);
+		data_timeout += host->data_timeout;
+	}
+
+	timeout = jiffies;
+	if (data_timeout)
+		timeout += nsecs_to_jiffies(data_timeout);
+	else
+		timeout += 10 * HZ * prq->nr_reqs;
+	sdhci_mod_timer(host, NULL, timeout);
+
+	/* Start ADMA3 transfer */
+	sdhci_set_adma3_addr(host, host->integr_addr);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdhci_packed_request);
+
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host;
@@ -2619,9 +2890,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
 {
 	unsigned long flags;
 	struct mmc_request *mrq;
+	struct mmc_packed_request *prq;
 	int i;
 
 	spin_lock_irqsave(&host->lock, flags);
+	prq = host->prq;
+
+	if (prq) {
+		host->prq = NULL;
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		mmc_packed_finalize_requests(host->mmc, prq);
+		return true;
+	}
 
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
 		mrq = host->mrqs_done[i];
@@ -2763,6 +3044,17 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
 	spin_lock_irqsave(&host->lock, flags);
 
+	if (host->prq) {
+		pr_err("%s: Packed requests timeout for hardware interrupt.\n",
+		       mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		sdhci_finish_packed_data(host, -ETIMEDOUT);
+		queue_work(host->complete_wq, &host->complete_work);
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		return;
+	}
+
 	if (host->data || host->data_cmd ||
 	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
 		pr_err("%s: Timeout waiting for hardware interrupt.\n",
@@ -2965,7 +3257,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			host->ops->adma_workaround(host, intmask);
 	}
 
-	if (host->data->error)
+	if (host->prq)
+		sdhci_finish_packed_data(host, host->data->error);
+	else if (host->data->error)
 		sdhci_finish_data(host);
 	else {
 		if (intmask & (SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL))
@@ -3137,6 +3431,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			host->mrqs_done[i] = NULL;
 		}
 	}
+
+	if (host->prq)
+		result = IRQ_WAKE_THREAD;
 out:
 	spin_unlock(&host->lock);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4548d9c..59cfa5d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -574,6 +574,7 @@ struct sdhci_host {
 	bool pending_reset;	/* Cmd/data reset is pending */
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
+	bool adma3_enabled;	/* ADMA3 mode enabled */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
@@ -581,12 +582,15 @@ struct sdhci_host {
 	struct mmc_data *data;	/* Current data request */
 	unsigned int data_early:1;	/* Data finished before cmd */
 
+	struct mmc_packed_request *prq;	/* Current packed request */
 	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
 	unsigned int blocks;	/* remaining PIO blocks */
 
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
 	void *integr_table;	/* ADMA3 intergrate descriptor table */
+	void *adma3_pos;	/* ADMA3 buffer position */
+	void *adma3_align_pos;	/* ADMA3 Bounce buffer position */
 
 	size_t adma_table_sz;	/* ADMA descriptor table size */
 	size_t align_buffer_sz;	/* Bounce buffer size */
@@ -843,4 +847,9 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
 
+int sdhci_prepare_packed(struct mmc_packed *packed);
+int sdhci_unprepare_packed(struct mmc_packed *packed);
+int sdhci_packed_request(struct mmc_packed *packed,
+			 struct mmc_packed_request *prq);
+
 #endif /* __SDHCI_HW_H */
-- 
1.7.9.5


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AADDC55191
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32012084D
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBWlSDbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDZJkB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDZJkA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 05:40:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C981DC061A0C;
        Sun, 26 Apr 2020 02:39:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id y6so6080762pjc.4;
        Sun, 26 Apr 2020 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pyveOO3QJUxSY6Rz4APEwXjsjy0dShb6TDPit1HSR0U=;
        b=fBWlSDbVvSRc37mDjOFXL6FWeDoB8SZ24Q62U+Ter37kuHdvV6nCjKpReqLxVFGpyi
         4+N04pf/JNGybKkWLWJsghkyyBpMmy/giYxWlKMRrZrqNy02pnfwAWFFYlqfEdJKW0xg
         d93LpNwR/yyW4hfFA7rrEnhFZVMvbW64HeYWpr57ofLHG0tfrSckzxp0naNvfZh/gSPb
         iX1UOSSZ8prN6fB+2IHDU0z/Q8taJX0dyo0nIoexbCUYx4kAHp2srOVRxObXNF0NVCnA
         h33pr1vu17YRBIXrh0dAwHj/TzNyy75oiUquZP7m+0XwN8kzUK+VjXjEdHe7kgSMsYjS
         /j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pyveOO3QJUxSY6Rz4APEwXjsjy0dShb6TDPit1HSR0U=;
        b=BelGcQVynr+v+cl4cfODHI30mCdjSvBZovSqA3/0MvJY32ILAEmpMWI8CqMX34iEJe
         ZcKeZ1CIROrLmZdsVUnJJ5MXxLRXnzqBjkm19GnlVID1XEJtbFy1a5xM2ArCgsvwjKfu
         6/qKah9zpIFncm8QgG6AiAeHAgzDCyxk/FNckQ4yRX5rtrZqV1mtBpwu4AlZKkKoRyN0
         eh+PMHN9rXxTGgwoLXHiwlRcbirvcE8/Xoo72xvDHICosE7O98SV80tmL7MRS7woeBs0
         KErTQWNDqdoxMPWbUkcquCEy/046u1JhSMlbFM/EfxYhoJF/4YuR/puir6xWFp0vcpsS
         sdug==
X-Gm-Message-State: AGi0PuZa/EgBzu3hJr+hw0I/V8Er9rBwXOkxrGUrp4ZvPqQJ/kun9HpX
        kQ2Xf5bGrqHCvOfJGAFmqjQ=
X-Google-Smtp-Source: APiQypLx9k4832NODXLCegKd+yXbbFF3gxMduZz80oR3gISPMoy5hJ28eGQ6WvjPXHugy6jEwYVmmw==
X-Received: by 2002:a17:90a:c481:: with SMTP id j1mr16931715pjt.5.1587893999308;
        Sun, 26 Apr 2020 02:39:59 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id m129sm1835245pga.47.2020.04.26.02.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 02:39:58 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, linus.walleij@linaro.org, paolo.valente@linaro.org,
        ming.lei@redhat.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 6/7] mmc: host: sdhci: Add MMC packed request support
Date:   Sun, 26 Apr 2020 17:38:59 +0800
Message-Id: <e669f582eacfe573be33f513c6fe01234ba15fbc.1587888520.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
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

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c | 317 +++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h |  11 ++
 2 files changed, 316 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ad7e2442f120..22935bbb0538 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -111,6 +111,19 @@ void sdhci_dumpregs(struct sdhci_host *host)
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
@@ -288,7 +301,9 @@ static void sdhci_config_dma(struct sdhci_host *host)
 		goto out;
 
 	/* Note if DMA Select is zero then SDMA is selected */
-	if (host->flags & SDHCI_USE_ADMA)
+	if (host->adma3_enabled)
+		ctrl |= SDHCI_CTRL_ADMA3;
+	else if (host->flags & SDHCI_USE_ADMA)
 		ctrl |= SDHCI_CTRL_ADMA32;
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA) {
@@ -458,7 +473,7 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
 static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
 			    unsigned long timeout)
 {
-	if (sdhci_data_line_cmd(mrq->cmd))
+	if (host->prq || sdhci_data_line_cmd(mrq->cmd))
 		mod_timer(&host->data_timer, timeout);
 	else
 		mod_timer(&host->timer, timeout);
@@ -466,7 +481,7 @@ static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
 
 static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
 {
-	if (sdhci_data_line_cmd(mrq->cmd))
+	if (host->prq || sdhci_data_line_cmd(mrq->cmd))
 		del_timer(&host->data_timer);
 	else
 		del_timer(&host->timer);
@@ -723,10 +738,16 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
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
@@ -785,6 +806,11 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
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
@@ -810,7 +836,10 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 			dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
 					    data->sg_len, DMA_FROM_DEVICE);
 
-			align = host->align_buffer;
+			if (host->adma3_enabled)
+				align = host->adma3_align_pos;
+			else
+				align = host->align_buffer;
 
 			for_each_sg(data->sg, sg, data->sg_count, i) {
 				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
@@ -824,6 +853,9 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 					align += SDHCI_ADMA2_ALIGN;
 				}
 			}
+
+			if (host->adma3_enabled)
+				host->adma3_align_pos = align;
 		}
 	}
 }
@@ -1032,7 +1064,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_initialize_data(struct sdhci_host *host,
 				  struct mmc_data *data)
 {
-	WARN_ON(host->data);
+	WARN_ON(!host->prq && host->data);
 
 	/* Sanity checks */
 	BUG_ON(data->blksz * data->blocks > 524288);
@@ -1133,7 +1165,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			host->flags &= ~SDHCI_REQ_USE_DMA;
 		} else if (host->flags & SDHCI_USE_ADMA) {
 			sdhci_adma_table_pre(host, data);
-			sdhci_set_adma_addr(host, host->adma_addr);
+			if (!host->adma3_enabled)
+				sdhci_set_adma_addr(host, host->adma_addr);
 		} else {
 			WARN_ON(sg_cnt != 1);
 			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
@@ -1156,6 +1189,9 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_irqs(host);
 
+	if (host->adma3_enabled)
+		return;
+
 	sdhci_set_block_info(host, data);
 }
 
@@ -1501,6 +1537,36 @@ static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
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
+		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
+	list_for_each_entry(mrq, &host->prq->list, list) {
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
 static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 {
 	struct mmc_command *data_cmd = host->data_cmd;
@@ -1642,7 +1708,7 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	host->cmd = cmd;
 	host->data_timeout = 0;
-	if (sdhci_data_line_cmd(cmd)) {
+	if (!host->prq && sdhci_data_line_cmd(cmd)) {
 		WARN_ON(host->data_cmd);
 		host->data_cmd = cmd;
 		sdhci_set_timeout(host, cmd);
@@ -2120,6 +2186,206 @@ EXPORT_SYMBOL_GPL(sdhci_set_power_and_bus_voltage);
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
+int sdhci_prepare_packed(struct mmc_host *mmc)
+{
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
+int sdhci_unprepare_packed(struct mmc_host *mmc)
+{
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
+int sdhci_packed_request(struct mmc_host *mmc,
+			 struct mmc_packed_request *prq)
+{
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
+	list_for_each_entry(mrq, &prq->list, list) {
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
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -2978,9 +3244,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
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
+		host->ops->packed_request_done(host, prq);
+		return true;
+	}
 
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
 		mrq = host->mrqs_done[i];
@@ -3136,6 +3412,17 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
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
@@ -3343,7 +3630,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			host->ops->adma_workaround(host, intmask);
 	}
 
-	if (host->data->error)
+	if (host->prq)
+		sdhci_finish_packed_data(host, host->data->error);
+	else if (host->data->error)
 		sdhci_finish_data(host);
 	else {
 		if (intmask & (SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL))
@@ -3515,6 +3804,10 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			host->mrqs_done[i] = NULL;
 		}
 	}
+
+	if (host->prq)
+		result = IRQ_WAKE_THREAD;
+
 out:
 	if (host->deferred_cmd)
 		result = IRQ_WAKE_THREAD;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 51207072d1ec..012958611790 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -577,6 +577,7 @@ struct sdhci_host {
 	bool v4_mode;		/* Host Version 4 Enable */
 	bool use_external_dma;	/* Host selects to use external DMA */
 	bool always_defer_done;	/* Always defer to complete requests */
+	bool adma3_enabled;	/* ADMA3 mode enabled */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
@@ -585,12 +586,15 @@ struct sdhci_host {
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
@@ -702,6 +706,8 @@ struct sdhci_ops {
 				   dma_addr_t addr, int len, unsigned int cmd);
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
+	void	(*packed_request_done)(struct sdhci_host *host,
+				       struct mmc_packed_request *prq);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -858,4 +864,9 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
+int sdhci_prepare_packed(struct mmc_host *mmc);
+int sdhci_unprepare_packed(struct mmc_host *mmc);
+int sdhci_packed_request(struct mmc_host *mmc,
+			 struct mmc_packed_request *prq);
+
 #endif /* __SDHCI_HW_H */
-- 
2.17.1


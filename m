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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCAEC0044D
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B8620724
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM5mP+2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgCPKCH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:02:07 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33020 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgCPKCG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 06:02:06 -0400
Received: by mail-pj1-f66.google.com with SMTP id dw20so3886814pjb.0;
        Mon, 16 Mar 2020 03:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=I0LdLqGPiKxYvJAfb6pGeFPkfbn8lz2wPqpXBWx4WLg=;
        b=YM5mP+2iOYAqt8ZEZk3H12rJW/c0KcYvGiTVH0TTxg+Rbpjxj574Jg+1MQ7agrLEjz
         UK057a9tm3iVLuht1612rjedx/Tzffic3OKgxPiN3Xo1fSKDzW5N5TEkBuX+0GIzdQvK
         8DWRKTnYtGz5oFrKIzeSUUB5lnO+Oq8Pe5BtLA2C/2fWWnuOIXIQvXRqokdph2CkeYPy
         jKeW0Zun9ldHTLJQLmzitB+9bHzPnKK/ipJDiZ70ciNWeCKCDF4qLH5nTbg8L97ib6Zk
         Z34g/AogK/6P/gjlGqwbMOAczpxLxCVdbUDEzHXG2nvDNu33tY2yyPFkprsTjOaEwztE
         Mdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=I0LdLqGPiKxYvJAfb6pGeFPkfbn8lz2wPqpXBWx4WLg=;
        b=GNc/vG7gI1KCublfjASjNLcCyVCdqd6jAs+jZ6ovPgYzUItM0aoJUqBytEZUA6trqb
         5knC3OOWlpfKAkMXkapjzfm7ZByW1GdqMI/jiMdm5gq/WeYbydScN//fPaPYr3s00s0g
         i6IFKKekDNQJG+GYLAwFX2wx8qE0XWOOukxXqy94iWNLLh805EqkLkQxMG+vtDvKsW16
         sc/9kdjxCM8zlwgfV2QFfXVSHSWlGecQg5s7o4KIyIy8ZGuAGeXTUfV3vCN91aGAYM2m
         z5Ivnlcqcfsfl9spqqTWHXZlr3az8whFWfGOChwM8uWg2qB6HMUy+XNs7b03vSOBRpT0
         QYaA==
X-Gm-Message-State: ANhLgQ3TxT5As8DPQYVRLhq2sVfCwDder4J7+rDkWXbdrX/kfR7QEcA7
        7nMofSH66OYP5/IlwElKJ2w=
X-Google-Smtp-Source: ADFU+vubWfRHng6wFVn6dni/xWntuWsR7ocB63fOrhS8OC/ZqkgkRxzUomeAmgKAxD1UdJpW0ObkdA==
X-Received: by 2002:a17:902:70c4:: with SMTP id l4mr25239336plt.136.1584352924995;
        Mon, 16 Mar 2020 03:02:04 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 136sm63970411pgh.26.2020.03.16.03.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 03:02:04 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     ming.lei@redhat.com, arnd@arndb.de, linus.walleij@linaro.org,
        baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH 7/8] mmc: host: sdhci: Add MMC packed request support
Date:   Mon, 16 Mar 2020 18:01:24 +0800
Message-Id: <8eec1acda41e51706baab3b3e470539517c1fa7c.1584350380.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
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
 drivers/mmc/host/sdhci.c | 316 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h |  11 ++
 2 files changed, 315 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6d6f450..5f1f157 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -110,6 +110,19 @@ void sdhci_dumpregs(struct sdhci_host *host)
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
@@ -287,7 +300,9 @@ static void sdhci_config_dma(struct sdhci_host *host)
 		goto out;
 
 	/* Note if DMA Select is zero then SDMA is selected */
-	if (host->flags & SDHCI_USE_ADMA)
+	if (host->adma3_enabled)
+		ctrl |= SDHCI_CTRL_ADMA3;
+	else if (host->flags & SDHCI_USE_ADMA)
 		ctrl |= SDHCI_CTRL_ADMA32;
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA) {
@@ -457,7 +472,7 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
 static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
 			    unsigned long timeout)
 {
-	if (sdhci_data_line_cmd(mrq->cmd))
+	if (host->prq || sdhci_data_line_cmd(mrq->cmd))
 		mod_timer(&host->data_timer, timeout);
 	else
 		mod_timer(&host->timer, timeout);
@@ -465,7 +480,7 @@ static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
 
 static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
 {
-	if (sdhci_data_line_cmd(mrq->cmd))
+	if (host->prq || sdhci_data_line_cmd(mrq->cmd))
 		del_timer(&host->data_timer);
 	else
 		del_timer(&host->timer);
@@ -722,10 +737,16 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
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
@@ -784,6 +805,11 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
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
@@ -809,7 +835,10 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 			dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
 					    data->sg_len, DMA_FROM_DEVICE);
 
-			align = host->align_buffer;
+			if (host->adma3_enabled)
+				align = host->adma3_align_pos;
+			else
+				align = host->align_buffer;
 
 			for_each_sg(data->sg, sg, data->sg_count, i) {
 				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
@@ -823,6 +852,9 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 					align += SDHCI_ADMA2_ALIGN;
 				}
 			}
+
+			if (host->adma3_enabled)
+				host->adma3_align_pos = align;
 		}
 	}
 }
@@ -1031,7 +1063,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_initialize_data(struct sdhci_host *host,
 				  struct mmc_data *data)
 {
-	WARN_ON(host->data);
+	WARN_ON(!host->prq && host->data);
 
 	/* Sanity checks */
 	BUG_ON(data->blksz * data->blocks > 524288);
@@ -1132,7 +1164,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			host->flags &= ~SDHCI_REQ_USE_DMA;
 		} else if (host->flags & SDHCI_USE_ADMA) {
 			sdhci_adma_table_pre(host, data);
-			sdhci_set_adma_addr(host, host->adma_addr);
+			if (!host->adma3_enabled)
+				sdhci_set_adma_addr(host, host->adma_addr);
 		} else {
 			WARN_ON(sg_cnt != 1);
 			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
@@ -1155,6 +1188,9 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_irqs(host);
 
+	if (host->adma3_enabled)
+		return;
+
 	sdhci_set_block_info(host, data);
 }
 
@@ -1485,6 +1521,36 @@ static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
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
 static void sdhci_finish_data(struct sdhci_host *host)
 {
 	struct mmc_command *data_cmd = host->data_cmd;
@@ -1620,7 +1686,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	host->cmd = cmd;
 	host->data_timeout = 0;
-	if (sdhci_data_line_cmd(cmd)) {
+	if (!host->prq && sdhci_data_line_cmd(cmd)) {
 		WARN_ON(host->data_cmd);
 		host->data_cmd = cmd;
 		sdhci_set_timeout(host, cmd);
@@ -2026,6 +2092,206 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
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
 static void sdhci_start_request(struct mmc_host *mmc, struct mmc_request *mrq,
 				int present)
 {
@@ -2854,9 +3120,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
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
@@ -3012,6 +3288,17 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
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
@@ -3219,7 +3506,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			host->ops->adma_workaround(host, intmask);
 	}
 
-	if (host->data->error)
+	if (host->prq)
+		sdhci_finish_packed_data(host, host->data->error);
+	else if (host->data->error)
 		sdhci_finish_data(host);
 	else {
 		if (intmask & (SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL))
@@ -3391,6 +3680,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			host->mrqs_done[i] = NULL;
 		}
 	}
+
+	if (host->prq)
+		result = IRQ_WAKE_THREAD;
 out:
 	spin_unlock(&host->lock);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f33830b..bbc937b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -579,6 +579,7 @@ struct sdhci_host {
 	bool v4_mode;		/* Host Version 4 Enable */
 	bool use_external_dma;	/* Host selects to use external DMA */
 	bool always_defer_done;	/* Always defer to complete requests */
+	bool adma3_enabled;	/* ADMA3 mode enabled */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
@@ -586,12 +587,15 @@ struct sdhci_host {
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
@@ -703,6 +707,8 @@ struct sdhci_ops {
 				   dma_addr_t addr, int len, unsigned int cmd);
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
+	void	(*packed_request_done)(struct sdhci_host *host,
+				       struct mmc_packed_request *prq);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -857,4 +863,9 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
+int sdhci_prepare_packed(struct mmc_host *mmc);
+int sdhci_unprepare_packed(struct mmc_host *mmc);
+int sdhci_packed_request(struct mmc_host *mmc,
+			 struct mmc_packed_request *prq);
+
 #endif /* __SDHCI_HW_H */
-- 
1.9.1


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAF6C33CB1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0AC2072E
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxUoxh1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgAQFZk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:25:40 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35340 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgAQFZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 00:25:39 -0500
Received: by mail-pj1-f68.google.com with SMTP id s7so2754943pjc.0;
        Thu, 16 Jan 2020 21:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PxBj08pdevWQPDD1zvOnmjYrwiUP7Ne0tEEKU5Du3iU=;
        b=SxUoxh1XZwEmC4VuivrEjXRhjdwvGrAKxJQmj/Bq0bkXOWIaUpH/r8aPL7uWQpwrPf
         RTcFJJZyXrx/nm4FDIwOv7ojDV5weBcYKYngxavDsyL1UB0GBZBf0M818adeqNeK+AMh
         jWi93QycaI44e+iuax3xC2SzxZOiV5xIXq3p035RCSxUN9g+C2Dns9QdYG21aXW2a0MD
         mOZYMd5oupCwDQUC1vhUDN622J5dHtWCSq+SEECm/8GN1SVJZH0shU07NV17gP8lpbtM
         IvxrvJxT2I4BuTjfhEGEnGCRj/gYti+4UDCGJvV+YZFMiTfRQhp385B8qWUfFxZqBVdM
         sTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PxBj08pdevWQPDD1zvOnmjYrwiUP7Ne0tEEKU5Du3iU=;
        b=Maie259TcScbpgoUzVimOVsnIXvQ8b899Qq28xhdjBzXdJMIDDEOx3WmQynFFz0HwK
         lmbPzSq5g2b4dO750tQib1FxdWirSubZEMM7HexyPA2FgHx23m/spEEKyLw8uBZyz/RV
         7se0QkUs4UItbPRW28KGGE+XEXT1LOkGbe4aqIdi2xluAc3Wbr8Q3ZiRibwZmyd3Cohh
         pV6UJhktyqU3VOVK87Za7YhaSNmCVkCitIH6zTPBKYjjokJv5rUQfKgL59kM+qdgoCQb
         +anLpzzQfRczdMM/0xFA+1DBgly1MqlBWEMgcVo2SuH/tpRPdJMF/gmPTl/iiGp6/kr8
         JwVw==
X-Gm-Message-State: APjAAAV9ofQoS6dhdJ8LxroVYjUC/uIKFTB1cEliw+32g9MLDvYKJBYl
        4hJLojlNGHRQ3ttDQVh8Af8oshDs
X-Google-Smtp-Source: APXvYqyDFEpUbu+buDxOYtCgfHLcOKXOUWHN6q9LfIX6Qcdcn56r3kwLCGSXqLon88FjMPQM4UH00Q==
X-Received: by 2002:a17:902:904c:: with SMTP id w12mr12261895plz.35.1579238738457;
        Thu, 16 Jan 2020 21:25:38 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c26sm28844756pfj.101.2020.01.16.21.25.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jan 2020 21:25:38 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [RFC PATCH 7/8] mmc: host: sdhci: Add MMC packed request support
Date:   Fri, 17 Jan 2020 13:24:26 +0800
Message-Id: <eec0cf143dcb036c5fb7e19b7829dc5c81cc3fcd.1579164456.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
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
 drivers/mmc/host/sdhci.c |  316 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h |   11 ++
 2 files changed, 315 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 645785d..56a3fb5 100644
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
@@ -456,7 +471,7 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
 static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
 			    unsigned long timeout)
 {
-	if (sdhci_data_line_cmd(mrq->cmd))
+	if (host->prq || sdhci_data_line_cmd(mrq->cmd))
 		mod_timer(&host->data_timer, timeout);
 	else
 		mod_timer(&host->timer, timeout);
@@ -464,7 +479,7 @@ static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
 
 static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
 {
-	if (sdhci_data_line_cmd(mrq->cmd))
+	if (host->prq || sdhci_data_line_cmd(mrq->cmd))
 		del_timer(&host->data_timer);
 	else
 		del_timer(&host->timer);
@@ -721,10 +736,16 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
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
@@ -783,6 +804,11 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
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
@@ -808,7 +834,10 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 			dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
 					    data->sg_len, DMA_FROM_DEVICE);
 
-			align = host->align_buffer;
+			if (host->adma3_enabled)
+				align = host->adma3_align_pos;
+			else
+				align = host->align_buffer;
 
 			for_each_sg(data->sg, sg, data->sg_count, i) {
 				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
@@ -822,6 +851,9 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 					align += SDHCI_ADMA2_ALIGN;
 				}
 			}
+
+			if (host->adma3_enabled)
+				host->adma3_align_pos = align;
 		}
 	}
 }
@@ -1030,13 +1062,13 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 
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
@@ -1109,7 +1141,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			host->flags &= ~SDHCI_REQ_USE_DMA;
 		} else if (host->flags & SDHCI_USE_ADMA) {
 			sdhci_adma_table_pre(host, data);
-			sdhci_set_adma_addr(host, host->adma_addr);
+			if (!host->adma3_enabled)
+				sdhci_set_adma_addr(host, host->adma_addr);
 		} else {
 			WARN_ON(sg_cnt != 1);
 			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
@@ -1132,6 +1165,9 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_irqs(host);
 
+	if (host->adma3_enabled)
+		return;
+
 	/* Set the DMA boundary value and block size */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
 		     SDHCI_BLOCK_SIZE);
@@ -1289,6 +1325,36 @@ static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
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
@@ -1820,6 +1886,206 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
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
@@ -2661,9 +2927,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
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
@@ -2808,6 +3084,17 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
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
@@ -3015,7 +3302,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			host->ops->adma_workaround(host, intmask);
 	}
 
-	if (host->data->error)
+	if (host->prq)
+		sdhci_finish_packed_data(host, host->data->error);
+	else if (host->data->error)
 		sdhci_finish_data(host);
 	else {
 		if (intmask & (SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL))
@@ -3187,6 +3476,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			host->mrqs_done[i] = NULL;
 		}
 	}
+
+	if (host->prq)
+		result = IRQ_WAKE_THREAD;
 out:
 	spin_unlock(&host->lock);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7bbdd8a..5b9b521 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -575,6 +575,7 @@ struct sdhci_host {
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
 	bool always_defer_done;	/* Always defer to complete requests */
+	bool adma3_enabled;	/* ADMA3 mode enabled */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
@@ -582,12 +583,15 @@ struct sdhci_host {
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
@@ -693,6 +697,8 @@ struct sdhci_ops {
 				   dma_addr_t addr, int len, unsigned int cmd);
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
+	void	(*packed_request_done)(struct sdhci_host *host,
+				       struct mmc_packed_request *prq);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -844,4 +850,9 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
 void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode);
 
+int sdhci_prepare_packed(struct mmc_host *mmc);
+int sdhci_unprepare_packed(struct mmc_host *mmc);
+int sdhci_packed_request(struct mmc_host *mmc,
+			 struct mmc_packed_request *prq);
+
 #endif /* __SDHCI_HW_H */
-- 
1.7.9.5


Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD33C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B7F2064C
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ipkmdSb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfANUXd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:23:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfANUXd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 15:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EHBpfQaB8b6F24S1Zp9Sgkzii+QiFUWl4029wnY7u3s=; b=ipkmdSb0zmbdI5WB0D04YCFN9
        JH3gPS6v7RZY1RMMCHxjceBw0GdsV28pvrE4uWTiNzdcscdeQAix2+M020nNhS9wBGIQTFaIzxnAX
        U/DxRKOAX/h8qhZFPs8EQOMPLbxeEDCXP3XqIpal/LdToLFDnb2zPl9+3ce5c3CL0IwbBTlOW/e7s
        l92OjQFzaOqBLz6d/jgD6mwDTxDQkf2qmdtkpr1sA9vAR/baSp/oAoU/PnCu7jDQvWl2qz+NJQ8fU
        Hdna/z8BDtBhidBk8+2St/Ri6h9B5LrVBBai2Fvdg6FoUoENfR1wpUh122rKwUOG/1ZzYtlej2TIp
        rShfdMsDQ==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj8lg-0004DU-6w; Mon, 14 Jan 2019 20:23:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?mtip32xx:=20=D1=95top=20abusing=20the=20managed?= =?UTF-8?q?=20resource=20APIs?=
Date:   Mon, 14 Jan 2019 21:23:30 +0100
Message-Id: <20190114202330.12597-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The mtip32xx driver uses managed resources for DMA coherent memory
and irqs, but then always pairs them with free calls anyway, making
the resource tracking rather pointless.  Given some DMA allocations
are transient anyway, the irq freeing seems to require ordering vs
other hardware access the best solution seems to be to stop using
the managed resurce API entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 37 +++++++++++++------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 88e8440e75c3..9a6f40cd8df6 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1415,7 +1415,7 @@ static blk_status_t mtip_send_trim(struct driver_data *dd, unsigned int lba,
 	WARN_ON(sizeof(struct mtip_trim) > ATA_SECT_SIZE);
 
 	/* Allocate a DMA buffer for the trim structure */
-	buf = dmam_alloc_coherent(&dd->pdev->dev, ATA_SECT_SIZE, &dma_addr,
+	buf = dma_alloc_coherent(&dd->pdev->dev, ATA_SECT_SIZE, &dma_addr,
 								GFP_KERNEL);
 	if (!buf)
 		return BLK_STS_RESOURCE;
@@ -1452,7 +1452,7 @@ static blk_status_t mtip_send_trim(struct driver_data *dd, unsigned int lba,
 					MTIP_TRIM_TIMEOUT_MS) < 0)
 		ret = BLK_STS_IOERR;
 
-	dmam_free_coherent(&dd->pdev->dev, ATA_SECT_SIZE, buf, dma_addr);
+	dma_free_coherent(&dd->pdev->dev, ATA_SECT_SIZE, buf, dma_addr);
 	return ret;
 }
 
@@ -1655,7 +1655,7 @@ static int exec_drive_command(struct mtip_port *port, u8 *command,
 		if (!user_buffer)
 			return -EFAULT;
 
-		buf = dmam_alloc_coherent(&port->dd->pdev->dev,
+		buf = dma_alloc_coherent(&port->dd->pdev->dev,
 				ATA_SECT_SIZE * xfer_sz,
 				&dma_addr,
 				GFP_KERNEL);
@@ -1733,7 +1733,7 @@ static int exec_drive_command(struct mtip_port *port, u8 *command,
 	}
 exit_drive_command:
 	if (buf)
-		dmam_free_coherent(&port->dd->pdev->dev,
+		dma_free_coherent(&port->dd->pdev->dev,
 				ATA_SECT_SIZE * xfer_sz, buf, dma_addr);
 	return rv;
 }
@@ -2837,11 +2837,11 @@ static void mtip_dma_free(struct driver_data *dd)
 	struct mtip_port *port = dd->port;
 
 	if (port->block1)
-		dmam_free_coherent(&dd->pdev->dev, BLOCK_DMA_ALLOC_SZ,
+		dma_free_coherent(&dd->pdev->dev, BLOCK_DMA_ALLOC_SZ,
 					port->block1, port->block1_dma);
 
 	if (port->command_list) {
-		dmam_free_coherent(&dd->pdev->dev, AHCI_CMD_TBL_SZ,
+		dma_free_coherent(&dd->pdev->dev, AHCI_CMD_TBL_SZ,
 				port->command_list, port->command_list_dma);
 	}
 }
@@ -2860,7 +2860,7 @@ static int mtip_dma_alloc(struct driver_data *dd)
 
 	/* Allocate dma memory for RX Fis, Identify, and Sector Bufffer */
 	port->block1 =
-		dmam_alloc_coherent(&dd->pdev->dev, BLOCK_DMA_ALLOC_SZ,
+		dma_alloc_coherent(&dd->pdev->dev, BLOCK_DMA_ALLOC_SZ,
 					&port->block1_dma, GFP_KERNEL);
 	if (!port->block1)
 		return -ENOMEM;
@@ -2868,10 +2868,10 @@ static int mtip_dma_alloc(struct driver_data *dd)
 
 	/* Allocate dma memory for command list */
 	port->command_list =
-		dmam_alloc_coherent(&dd->pdev->dev, AHCI_CMD_TBL_SZ,
+		dma_alloc_coherent(&dd->pdev->dev, AHCI_CMD_TBL_SZ,
 					&port->command_list_dma, GFP_KERNEL);
 	if (!port->command_list) {
-		dmam_free_coherent(&dd->pdev->dev, BLOCK_DMA_ALLOC_SZ,
+		dma_free_coherent(&dd->pdev->dev, BLOCK_DMA_ALLOC_SZ,
 					port->block1, port->block1_dma);
 		port->block1 = NULL;
 		port->block1_dma = 0;
@@ -3056,13 +3056,8 @@ static int mtip_hw_init(struct driver_data *dd)
 	mtip_start_port(dd->port);
 
 	/* Setup the ISR and enable interrupts. */
-	rv = devm_request_irq(&dd->pdev->dev,
-				dd->pdev->irq,
-				mtip_irq_handler,
-				IRQF_SHARED,
-				dev_driver_string(&dd->pdev->dev),
-				dd);
-
+	rv = request_irq(dd->pdev->irq, mtip_irq_handler, IRQF_SHARED,
+			 dev_driver_string(&dd->pdev->dev), dd);
 	if (rv) {
 		dev_err(&dd->pdev->dev,
 			"Unable to allocate IRQ %d\n", dd->pdev->irq);
@@ -3090,7 +3085,7 @@ static int mtip_hw_init(struct driver_data *dd)
 
 	/* Release the IRQ. */
 	irq_set_affinity_hint(dd->pdev->irq, NULL);
-	devm_free_irq(&dd->pdev->dev, dd->pdev->irq, dd);
+	free_irq(dd->pdev->irq, dd);
 
 out2:
 	mtip_deinit_port(dd->port);
@@ -3145,7 +3140,7 @@ static int mtip_hw_exit(struct driver_data *dd)
 
 	/* Release the IRQ. */
 	irq_set_affinity_hint(dd->pdev->irq, NULL);
-	devm_free_irq(&dd->pdev->dev, dd->pdev->irq, dd);
+	free_irq(dd->pdev->irq, dd);
 	msleep(1000);
 
 	/* Free dma regions */
@@ -3609,8 +3604,8 @@ static void mtip_free_cmd(struct blk_mq_tag_set *set, struct request *rq,
 	if (!cmd->command)
 		return;
 
-	dmam_free_coherent(&dd->pdev->dev, CMD_DMA_ALLOC_SZ,
-				cmd->command, cmd->command_dma);
+	dma_free_coherent(&dd->pdev->dev, CMD_DMA_ALLOC_SZ, cmd->command,
+			  cmd->command_dma);
 }
 
 static int mtip_init_cmd(struct blk_mq_tag_set *set, struct request *rq,
@@ -3619,7 +3614,7 @@ static int mtip_init_cmd(struct blk_mq_tag_set *set, struct request *rq,
 	struct driver_data *dd = set->driver_data;
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
 
-	cmd->command = dmam_alloc_coherent(&dd->pdev->dev, CMD_DMA_ALLOC_SZ,
+	cmd->command = dma_alloc_coherent(&dd->pdev->dev, CMD_DMA_ALLOC_SZ,
 			&cmd->command_dma, GFP_KERNEL);
 	if (!cmd->command)
 		return -ENOMEM;
-- 
2.20.1


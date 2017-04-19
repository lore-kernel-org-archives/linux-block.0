Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757660AbdDSAcY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2017 20:32:24 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] mtip32xx: use runtime tag to initialize command header
Date: Wed, 19 Apr 2017 08:31:42 +0800
Message-Id: <20170419003142.9581-4-ming.lei@redhat.com>
In-Reply-To: <20170419003142.9581-1-ming.lei@redhat.com>
References: <20170419003142.9581-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

mtip32xx supposes that 'request_idx' passed to .init_request()
is tag of the request, and use that as request's tag to initialize
command header.

After MQ IO scheduler is in, request tag assigned isn't same with
the request index anymore, so cause strange hardware failure on
mtip32xx, even whole system panic is triggered.

This patch fixes the issue by initializing command header via
request's real tag.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 8cfe5a6edb05..b122dc0368f4 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -169,6 +169,25 @@ static bool mtip_check_surprise_removal(struct pci_dev *pdev)
 	return false; /* device present */
 }
 
+/* we have to use runtime tag to setup command header */
+static void mtip_init_cmd_header(struct request *rq)
+{
+	struct driver_data *dd = rq->q->queuedata;
+	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
+
+	/* Point the command headers at the command tables. */
+	cmd->command_header = dd->port->command_list +
+				(sizeof(struct mtip_cmd_hdr) * rq->tag);
+	cmd->command_header_dma = dd->port->command_list_dma +
+				(sizeof(struct mtip_cmd_hdr) * rq->tag);
+
+	if (host_cap_64)
+		cmd->command_header->ctbau = __force_bit2int cpu_to_le32((cmd->command_dma >> 16) >> 16);
+
+	cmd->command_header->ctba = __force_bit2int cpu_to_le32(cmd->command_dma & 0xFFFFFFFF);
+}
+
 static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 {
 	struct request *rq;
@@ -182,6 +201,9 @@ static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 
 	WARN_ON(!blk_mq_get_driver_tag(rq, NULL, true));
 
+	/* Internal cmd isn't submitted via .queue_rq */
+	mtip_init_cmd_header(rq);
+
 	return blk_mq_rq_to_pdu(rq);
 }
 
@@ -3809,6 +3831,8 @@ static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	int ret;
 
+	mtip_init_cmd_header(rq);
+
 	if (unlikely(mtip_check_unal_depth(hctx, rq)))
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
@@ -3840,7 +3864,6 @@ static int mtip_init_cmd(void *data, struct request *rq, unsigned int hctx_idx,
 {
 	struct driver_data *dd = data;
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
-	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
 
 	/*
 	 * For flush requests, request_idx starts at the end of the
@@ -3857,17 +3880,6 @@ static int mtip_init_cmd(void *data, struct request *rq, unsigned int hctx_idx,
 
 	memset(cmd->command, 0, CMD_DMA_ALLOC_SZ);
 
-	/* Point the command headers at the command tables. */
-	cmd->command_header = dd->port->command_list +
-				(sizeof(struct mtip_cmd_hdr) * request_idx);
-	cmd->command_header_dma = dd->port->command_list_dma +
-				(sizeof(struct mtip_cmd_hdr) * request_idx);
-
-	if (host_cap_64)
-		cmd->command_header->ctbau = __force_bit2int cpu_to_le32((cmd->command_dma >> 16) >> 16);
-
-	cmd->command_header->ctba = __force_bit2int cpu_to_le32(cmd->command_dma & 0xFFFFFFFF);
-
 	sg_init_table(cmd->sg, MTIP_MAX_SG);
 	return 0;
 }
-- 
2.9.3

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbdGEEOl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jul 2017 00:14:41 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] mtip32xx: avoid to read HOST_CAP from HW in .queue_rq()
Date: Wed,  5 Jul 2017 12:14:27 +0800
Message-Id: <20170705041427.9887-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It is observed reading the register from HW takes a bit long,
for example in my box, the following difference of 'perf report
--no-children fio ...' can be seen when running I/O:

1) V4.12 without patch
+    9.28%       fio  [mtip32xx]           [k] mtip_irq_handler
+    8.48%       fio  [mtip32xx]           [k] mtip_init_cmd_header

2) V4.12 with the following patch
+    9.14%       fio  [mtip32xx]           [k] mtip_irq_handler
......
+    1.14%       fio  [mtip32xx]           [k] mtip_init_cmd_header

IOPS can be increased by ~5% with this patch too.

Fixes: a4e84aae8139(mtip32xx: use runtime tag to initialize command header)
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 4 ++--
 drivers/block/mtip32xx/mtip32xx.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index d8618a71da74..01e7fdfae0af 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -174,7 +174,6 @@ static void mtip_init_cmd_header(struct request *rq)
 {
 	struct driver_data *dd = rq->q->queuedata;
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
-	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
 
 	/* Point the command headers at the command tables. */
 	cmd->command_header = dd->port->command_list +
@@ -182,7 +181,7 @@ static void mtip_init_cmd_header(struct request *rq)
 	cmd->command_header_dma = dd->port->command_list_dma +
 				(sizeof(struct mtip_cmd_hdr) * rq->tag);
 
-	if (host_cap_64)
+	if (test_bit(MTIP_PF_HOST_CAP_64, &dd->port->flags))
 		cmd->command_header->ctbau = __force_bit2int cpu_to_le32((cmd->command_dma >> 16) >> 16);
 
 	cmd->command_header->ctba = __force_bit2int cpu_to_le32(cmd->command_dma & 0xFFFFFFFF);
@@ -386,6 +385,7 @@ static void mtip_init_port(struct mtip_port *port)
 			 port->mmio + PORT_LST_ADDR_HI);
 		writel((port->rxfis_dma >> 16) >> 16,
 			 port->mmio + PORT_FIS_ADDR_HI);
+		set_bit(MTIP_PF_HOST_CAP_64, &port->flags);
 	}
 
 	writel(port->command_list_dma & 0xFFFFFFFF,
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index e8286af50e16..e20e55dab443 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -140,6 +140,7 @@ enum {
 				(1 << MTIP_PF_SE_ACTIVE_BIT) |
 				(1 << MTIP_PF_DM_ACTIVE_BIT) |
 				(1 << MTIP_PF_TO_ACTIVE_BIT)),
+	MTIP_PF_HOST_CAP_64         = 10, /* cache HOST_CAP_64 */
 
 	MTIP_PF_SVC_THD_ACTIVE_BIT  = 4,
 	MTIP_PF_ISSUE_CMDS_BIT      = 5,
-- 
2.9.4

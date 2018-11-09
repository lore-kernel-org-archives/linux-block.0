Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 7/9] mtip32xx: remove mtip_get_int_command
Date: Fri,  9 Nov 2018 14:49:00 +0100
Message-Id: <20181109134902.32057-8-hch@lst.de>
In-Reply-To: <20181109134902.32057-1-hch@lst.de>
References: <20181109134902.32057-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Merging this function into the only callers makes the code flow easier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 6006f7baa1eb..5ae86224b2f5 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -168,20 +168,6 @@ static bool mtip_check_surprise_removal(struct pci_dev *pdev)
 	return false; /* device present */
 }
 
-static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
-{
-	struct request *rq;
-
-	if (mtip_check_surprise_removal(dd->pdev))
-		return NULL;
-
-	rq = blk_mq_alloc_request(dd->queue, REQ_OP_DRV_IN, BLK_MQ_REQ_RESERVED);
-	if (IS_ERR(rq))
-		return NULL;
-
-	return blk_mq_rq_to_pdu(rq);
-}
-
 static struct mtip_cmd *mtip_cmd_from_tag(struct driver_data *dd,
 					  unsigned int tag)
 {
@@ -1002,12 +988,15 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		return -EFAULT;
 	}
 
-	int_cmd = mtip_get_int_command(dd);
-	if (!int_cmd) {
+	if (mtip_check_surprise_removal(dd->pdev))
+		return -EFAULT;
+
+	rq = blk_mq_alloc_request(dd->queue, REQ_OP_DRV_IN, BLK_MQ_REQ_RESERVED);
+	if (IS_ERR(rq)) {
 		dbg_printk(MTIP_DRV_NAME "Unable to allocate tag for PIO cmd\n");
 		return -EFAULT;
 	}
-	rq = blk_mq_rq_from_pdu(int_cmd);
+
 	rq->special = &icmd;
 
 	set_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
@@ -1029,6 +1018,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 	}
 
 	/* Copy the command to the command table */
+	int_cmd = blk_mq_rq_to_pdu(rq);
 	memcpy(int_cmd->command, fis, fis_len*4);
 
 	rq->timeout = timeout;
-- 
2.19.1

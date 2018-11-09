Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 8/9] mtip32xx: don't use req->special
Date: Fri,  9 Nov 2018 14:49:01 +0100
Message-Id: <20181109134902.32057-9-hch@lst.de>
In-Reply-To: <20181109134902.32057-1-hch@lst.de>
References: <20181109134902.32057-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Instead create add to the icmd into struct mtip_cmd which can be unioned
with the scatterlist used for the normal I/O path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 5 ++---
 drivers/block/mtip32xx/mtip32xx.h | 7 ++++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 5ae86224b2f5..e99db2c9118f 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -997,8 +997,6 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		return -EFAULT;
 	}
 
-	rq->special = &icmd;
-
 	set_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
 
 	if (fis->command == ATA_CMD_SEC_ERASE_PREP)
@@ -1019,6 +1017,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 
 	/* Copy the command to the command table */
 	int_cmd = blk_mq_rq_to_pdu(rq);
+	int_cmd->icmd = &icmd;
 	memcpy(int_cmd->command, fis, fis_len*4);
 
 	rq->timeout = timeout;
@@ -3548,8 +3547,8 @@ static blk_status_t mtip_issue_reserved_cmd(struct blk_mq_hw_ctx *hctx,
 		struct request *rq)
 {
 	struct driver_data *dd = hctx->queue->queuedata;
-	struct mtip_int_cmd *icmd = rq->special;
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	struct mtip_int_cmd *icmd = cmd->icmd;
 	struct mtip_cmd_hdr *hdr =
 		dd->port->command_list + sizeof(struct mtip_cmd_hdr) * rq->tag;
 	struct mtip_cmd_sg *command_sg;
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index 63414928f07c..c33f8c3d9fb4 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -321,6 +321,8 @@ struct mtip_cmd_sg {
 };
 struct mtip_port;
 
+struct mtip_int_cmd;
+
 /* Structure used to describe a command. */
 struct mtip_cmd {
 	void *command; /* ptr to command table entry */
@@ -331,7 +333,10 @@ struct mtip_cmd {
 
 	int unaligned; /* command is unaligned on 4k boundary */
 
-	struct scatterlist sg[MTIP_MAX_SG]; /* Scatter list entries */
+	union {
+		struct scatterlist sg[MTIP_MAX_SG]; /* Scatter list entries */
+		struct mtip_int_cmd *icmd;
+	};
 
 	int retries; /* The number of retries left for this command. */
 
-- 
2.19.1

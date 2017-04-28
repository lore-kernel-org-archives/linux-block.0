Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41882 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965470AbdD1QzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 12:55:00 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/6] mtip32xx: convert internal command issue to block IO path
Date: Fri, 28 Apr 2017 10:54:31 -0600
Message-ID: <1493398473-29872-5-git-send-email-axboe@fb.com>
In-Reply-To: <1493398473-29872-1-git-send-email-axboe@fb.com>
References: <1493398473-29872-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The driver special cases certain things for command issue, depending
on whether it's an internal command or not. Make the internal commands
use the regular infrastructure for issuing IO.

Since this is an 8-group souped up AHCI variant, we have to deal
with NCQ vs non-queueable commands. Do this from the queue_rq
handler, by backing off unless the drive is idle.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 103 +++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 30 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index aee94f260725..9749b099a914 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -195,7 +195,7 @@ static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 	if (mtip_check_surprise_removal(dd->pdev))
 		return NULL;
 
-	rq = blk_mq_alloc_request(dd->queue, 0, BLK_MQ_REQ_RESERVED);
+	rq = blk_mq_alloc_request(dd->queue, REQ_OP_DRV_IN, BLK_MQ_REQ_RESERVED);
 	if (IS_ERR(rq))
 		return NULL;
 
@@ -1088,6 +1088,13 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
 	return -EFAULT;
 }
 
+struct mtip_int_cmd {
+	int fis_len;
+	dma_addr_t buffer;
+	int buf_len;
+	u32 opts;
+};
+
 /*
  * Execute an internal command and wait for the completion.
  *
@@ -1114,10 +1121,16 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 					u32 opts,
 					unsigned long timeout)
 {
-	struct mtip_cmd_sg *command_sg;
 	DECLARE_COMPLETION_ONSTACK(wait);
 	struct mtip_cmd *int_cmd;
 	struct driver_data *dd = port->dd;
+	struct request *rq;
+	struct mtip_int_cmd icmd = {
+		.fis_len = fis_len,
+		.buffer = buffer,
+		.buf_len = buf_len,
+		.opts = opts
+	};
 	int rv = 0;
 	unsigned long start;
 
@@ -1132,6 +1145,8 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		dbg_printk(MTIP_DRV_NAME "Unable to allocate tag for PIO cmd\n");
 		return -EFAULT;
 	}
+	rq = blk_mq_rq_from_pdu(int_cmd);
+	rq->end_io_data = &icmd;
 
 	set_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
 
@@ -1158,35 +1173,16 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 	/* Copy the command to the command table */
 	memcpy(int_cmd->command, fis, fis_len*4);
 
-	/* Populate the SG list */
-	int_cmd->command_header->opts =
-		 __force_bit2int cpu_to_le32(opts | fis_len);
-	if (buf_len) {
-		command_sg = int_cmd->command + AHCI_CMD_TBL_HDR_SZ;
-
-		command_sg->info =
-			__force_bit2int cpu_to_le32((buf_len-1) & 0x3FFFFF);
-		command_sg->dba	=
-			__force_bit2int cpu_to_le32(buffer & 0xFFFFFFFF);
-		command_sg->dba_upper =
-			__force_bit2int cpu_to_le32((buffer >> 16) >> 16);
-
-		int_cmd->command_header->opts |=
-			__force_bit2int cpu_to_le32((1 << 16));
-	}
-
-	/* Populate the command header */
-	int_cmd->command_header->byte_count = 0;
-
 	start = jiffies;
+	rq->timeout = timeout;
 
-	/* Issue the command to the hardware */
-	mtip_issue_non_ncq_command(port, MTIP_TAG_INTERNAL);
+	/* insert request and run queue */
+	blk_execute_rq_nowait(rq->q, NULL, rq, true, NULL);
+
+	wait_for_completion(&wait);
+	rv = int_cmd->status;
 
-	/* Wait for the command to complete or timeout. */
-	rv = wait_for_completion_interruptible_timeout(&wait,
-				msecs_to_jiffies(timeout));
-	if (rv <= 0) {
+	if (rv < 0) {
 		if (rv == -ERESTARTSYS) { /* interrupted */
 			dev_err(&dd->pdev->dev,
 				"Internal command [%02X] was interrupted after %u ms\n",
@@ -1217,7 +1213,6 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		goto exec_ic_exit;
 	}
 
-	rv = 0;
 	if (readl(port->cmd_issue[MTIP_TAG_INTERNAL])
 			& (1 << MTIP_TAG_INTERNAL)) {
 		rv = -ENXIO;
@@ -3762,6 +3757,44 @@ static bool mtip_check_unal_depth(struct blk_mq_hw_ctx *hctx,
 	return false;
 }
 
+static int mtip_issue_reserved_cmd(struct blk_mq_hw_ctx *hctx,
+				   struct request *rq)
+{
+	struct driver_data *dd = hctx->queue->queuedata;
+	struct mtip_int_cmd *icmd = rq->end_io_data;
+	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	struct mtip_cmd_sg *command_sg;
+
+	if (mtip_commands_active(dd->port))
+		return BLK_MQ_RQ_QUEUE_BUSY;
+
+	rq->end_io_data = NULL;
+
+	/* Populate the SG list */
+	cmd->command_header->opts =
+		 __force_bit2int cpu_to_le32(icmd->opts | icmd->fis_len);
+	if (icmd->buf_len) {
+		command_sg = cmd->command + AHCI_CMD_TBL_HDR_SZ;
+
+		command_sg->info =
+			__force_bit2int cpu_to_le32((icmd->buf_len-1) & 0x3FFFFF);
+		command_sg->dba	=
+			__force_bit2int cpu_to_le32(icmd->buffer & 0xFFFFFFFF);
+		command_sg->dba_upper =
+			__force_bit2int cpu_to_le32((icmd->buffer >> 16) >> 16);
+
+		cmd->command_header->opts |=
+			__force_bit2int cpu_to_le32((1 << 16));
+	}
+
+	/* Populate the command header */
+	cmd->command_header->byte_count = 0;
+
+	blk_mq_start_request(rq);
+	mtip_issue_non_ncq_command(dd->port, rq->tag);
+	return BLK_MQ_RQ_QUEUE_OK;
+}
+
 static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
@@ -3770,6 +3803,9 @@ static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	mtip_init_cmd_header(rq);
 
+	if (blk_rq_is_passthrough(rq))
+		return mtip_issue_reserved_cmd(hctx, rq);
+
 	if (unlikely(mtip_check_unal_depth(hctx, rq)))
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
@@ -3825,8 +3861,14 @@ static enum blk_eh_timer_return mtip_cmd_timeout(struct request *req,
 {
 	struct driver_data *dd = req->q->queuedata;
 
-	if (reserved)
+	if (reserved) {
+		struct mtip_cmd *cmd = blk_mq_rq_to_pdu(req);
+
+		cmd->status = -ETIME;
+		if (cmd->comp_func)
+			cmd->comp_func(dd->port, MTIP_TAG_INTERNAL, cmd, -ETIME);
 		goto exit_handler;
+	}
 
 	if (test_bit(req->tag, dd->port->cmds_to_issue))
 		goto exit_handler;
@@ -4063,6 +4105,7 @@ static void mtip_no_dev_cleanup(struct request *rq, void *data, bool reserv)
 	} else if (test_bit(MTIP_PF_IC_ACTIVE_BIT, &dd->port->flags)) {
 
 		cmd = mtip_cmd_from_tag(dd, MTIP_TAG_INTERNAL);
+		cmd->status = -ENODEV;
 		if (cmd->comp_func)
 			cmd->comp_func(dd->port, MTIP_TAG_INTERNAL,
 					cmd, -ENODEV);
-- 
2.7.4

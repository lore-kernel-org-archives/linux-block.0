Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57825 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750896AbdEBP7J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 11:59:09 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/2] mtip32xx: convert internal commands to regular block infrastructure
Date: Tue, 2 May 2017 09:59:01 -0600
Message-ID: <1493740741-4471-3-git-send-email-axboe@fb.com>
In-Reply-To: <1493740741-4471-1-git-send-email-axboe@fb.com>
References: <1493740741-4471-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Get rid of the private end_io handlers and data, and just use the
regular block IO path for these requests. This removes a lot of
redundant code.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 198 ++++++--------------------------------
 drivers/block/mtip32xx/mtip32xx.h |  10 --
 2 files changed, 30 insertions(+), 178 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 3204623f746a..3a779a4f5653 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -205,66 +205,12 @@ static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 	return blk_mq_rq_to_pdu(rq);
 }
 
-static void mtip_put_int_command(struct driver_data *dd, struct mtip_cmd *cmd)
-{
-	blk_put_request(blk_mq_rq_from_pdu(cmd));
-}
-
-/*
- * Once we add support for one hctx per mtip group, this will change a bit
- */
-static struct request *mtip_rq_from_tag(struct driver_data *dd,
-					unsigned int tag)
-{
-	struct blk_mq_hw_ctx *hctx = dd->queue->queue_hw_ctx[0];
-
-	return blk_mq_tag_to_rq(hctx->tags, tag);
-}
-
 static struct mtip_cmd *mtip_cmd_from_tag(struct driver_data *dd,
 					  unsigned int tag)
 {
-	struct request *rq = mtip_rq_from_tag(dd, tag);
-
-	return blk_mq_rq_to_pdu(rq);
-}
-
-/*
- * IO completion function.
- *
- * This completion function is called by the driver ISR when a
- * command that was issued by the kernel completes. It first calls the
- * asynchronous completion function which normally calls back into the block
- * layer passing the asynchronous callback data, then unmaps the
- * scatter list associated with the completed command, and finally
- * clears the allocated bit associated with the completed command.
- *
- * @port   Pointer to the port data structure.
- * @tag    Tag of the command.
- * @data   Pointer to driver_data.
- * @status Completion status.
- *
- * return value
- *	None
- */
-static void mtip_async_complete(struct mtip_port *port,
-				int tag, struct mtip_cmd *cmd, int status)
-{
-	struct driver_data *dd = port->dd;
-	struct request *rq;
-
-	if (unlikely(!dd) || unlikely(!port))
-		return;
-
-	if (unlikely(status == PORT_IRQ_TF_ERR)) {
-		dev_warn(&port->dd->pdev->dev,
-			"Command tag %d failed due to TFE\n", tag);
-	}
-
-	rq = mtip_rq_from_tag(dd, tag);
+	struct blk_mq_hw_ctx *hctx = dd->queue->queue_hw_ctx[0];
 
-	cmd->status = status;
-	blk_mq_complete_request(rq);
+	return blk_mq_rq_to_pdu(blk_mq_tag_to_rq(hctx->tags, tag));
 }
 
 /*
@@ -581,38 +527,19 @@ static void print_tags(struct driver_data *dd,
 			"%d command(s) %s: tagmap [%s]", cnt, msg, tagmap);
 }
 
-/*
- * Internal command completion callback function.
- *
- * This function is normally called by the driver ISR when an internal
- * command completed. This function signals the command completion by
- * calling complete().
- *
- * @port   Pointer to the port data structure.
- * @tag    Tag of the command that has completed.
- * @data   Pointer to a completion structure.
- * @status Completion status.
- *
- * return value
- *	None
- */
-static void mtip_completion(struct mtip_port *port,
-			    int tag, struct mtip_cmd *command, int status)
-{
-	struct completion *waiting = command->comp_data;
-	if (unlikely(status == PORT_IRQ_TF_ERR))
-		dev_warn(&port->dd->pdev->dev,
-			"Internal command %d completed with TFE\n", tag);
-
-	command->comp_func = NULL;
-	command->comp_data = NULL;
-	complete(waiting);
-}
-
 static int mtip_read_log_page(struct mtip_port *port, u8 page, u16 *buffer,
 				dma_addr_t buffer_dma, unsigned int sectors);
 static int mtip_get_smart_attr(struct mtip_port *port, unsigned int id,
 						struct smart_attr *attrib);
+
+static void mtip_complete_command(struct mtip_cmd *cmd, int status)
+{
+	struct request *req = blk_mq_rq_from_pdu(cmd);
+
+	cmd->status = status;
+	blk_mq_complete_request(req);
+}
+
 /*
  * Handle an error.
  *
@@ -641,11 +568,7 @@ static void mtip_handle_tfe(struct driver_data *dd)
 	if (test_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags)) {
 		cmd = mtip_cmd_from_tag(dd, MTIP_TAG_INTERNAL);
 		dbg_printk(MTIP_DRV_NAME " TFE for the internal command\n");
-
-		if (cmd->comp_data && cmd->comp_func) {
-			cmd->comp_func(port, MTIP_TAG_INTERNAL,
-					cmd, PORT_IRQ_TF_ERR);
-		}
+		mtip_complete_command(cmd, -EIO);
 		return;
 	}
 
@@ -672,19 +595,9 @@ static void mtip_handle_tfe(struct driver_data *dd)
 				continue;
 
 			cmd = mtip_cmd_from_tag(dd, tag);
-			if (likely(cmd->comp_func)) {
-				set_bit(tag, tagaccum);
-				cmd_cnt++;
-				cmd->comp_func(port, tag, cmd, 0);
-			} else {
-				dev_err(&port->dd->pdev->dev,
-					"Missing completion func for tag %d",
-					tag);
-				if (mtip_check_surprise_removal(dd->pdev)) {
-					/* don't proceed further */
-					return;
-				}
-			}
+			mtip_complete_command(cmd, 0);
+			set_bit(tag, tagaccum);
+			cmd_cnt++;
 		}
 	}
 
@@ -754,10 +667,7 @@ static void mtip_handle_tfe(struct driver_data *dd)
 					tag,
 					fail_reason != NULL ?
 						fail_reason : "unknown");
-					if (cmd->comp_func) {
-						cmd->comp_func(port, tag,
-							cmd, -ENODATA);
-					}
+					mtip_complete_command(cmd, -ENODATA);
 					continue;
 				}
 			}
@@ -780,12 +690,7 @@ static void mtip_handle_tfe(struct driver_data *dd)
 			dev_warn(&port->dd->pdev->dev,
 				"retiring tag %d\n", tag);
 
-			if (cmd->comp_func)
-				cmd->comp_func(port, tag, cmd, PORT_IRQ_TF_ERR);
-			else
-				dev_warn(&port->dd->pdev->dev,
-					"Bad completion for tag %d\n",
-					tag);
+			mtip_complete_command(cmd, -EIO);
 		}
 	}
 	print_tags(dd, "reissued (TFE)", tagaccum, cmd_cnt);
@@ -818,18 +723,7 @@ static inline void mtip_workq_sdbfx(struct mtip_port *port, int group,
 				continue;
 
 			command = mtip_cmd_from_tag(dd, tag);
-			if (likely(command->comp_func))
-				command->comp_func(port, tag, command, 0);
-			else {
-				dev_dbg(&dd->pdev->dev,
-					"Null completion for tag %d",
-					tag);
-
-				if (mtip_check_surprise_removal(
-					dd->pdev)) {
-					return;
-				}
-			}
+			mtip_complete_command(command, 0);
 		}
 		completed >>= 1;
 	}
@@ -851,10 +745,8 @@ static inline void mtip_process_legacy(struct driver_data *dd, u32 port_stat)
 		int group = MTIP_TAG_INDEX(MTIP_TAG_INTERNAL);
 		int status = readl(port->cmd_issue[group]);
 
-		if (!(status & (1 << MTIP_TAG_BIT(MTIP_TAG_INTERNAL)))) {
-			if (cmd->comp_func)
-				cmd->comp_func(port, MTIP_TAG_INTERNAL, cmd, 0);
-		}
+		if (!(status & (1 << MTIP_TAG_BIT(MTIP_TAG_INTERNAL))))
+			mtip_complete_command(cmd, 0);
 	}
 }
 
@@ -863,7 +755,6 @@ static inline void mtip_process_legacy(struct driver_data *dd, u32 port_stat)
  */
 static inline void mtip_process_errors(struct driver_data *dd, u32 port_stat)
 {
-
 	if (unlikely(port_stat & PORT_IRQ_CONNECT)) {
 		dev_warn(&dd->pdev->dev,
 			"Clearing PxSERR.DIAG.x\n");
@@ -990,8 +881,7 @@ static irqreturn_t mtip_irq_handler(int irq, void *instance)
 
 static void mtip_issue_non_ncq_command(struct mtip_port *port, int tag)
 {
-	writel(1 << MTIP_TAG_BIT(tag),
-		port->cmd_issue[MTIP_TAG_INDEX(tag)]);
+	writel(1 << MTIP_TAG_BIT(tag), port->cmd_issue[MTIP_TAG_INDEX(tag)]);
 }
 
 static bool mtip_pause_ncq(struct mtip_port *port,
@@ -1120,7 +1010,6 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 					u32 opts,
 					unsigned long timeout)
 {
-	DECLARE_COMPLETION_ONSTACK(wait);
 	struct mtip_cmd *int_cmd;
 	struct driver_data *dd = port->dd;
 	struct request *rq;
@@ -1145,7 +1034,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		return -EFAULT;
 	}
 	rq = blk_mq_rq_from_pdu(int_cmd);
-	rq->end_io_data = &icmd;
+	rq->special = &icmd;
 
 	set_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
 
@@ -1158,17 +1047,13 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		/* wait for io to complete if non atomic */
 		if (mtip_quiesce_io(port, MTIP_QUIESCE_IO_TIMEOUT_MS) < 0) {
 			dev_warn(&dd->pdev->dev, "Failed to quiesce IO\n");
-			mtip_put_int_command(dd, int_cmd);
+			blk_mq_free_request(rq);
 			clear_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
 			wake_up_interruptible(&port->svc_wait);
 			return -EBUSY;
 		}
 	}
 
-	/* Set the completion function and data for the command. */
-	int_cmd->comp_data = &wait;
-	int_cmd->comp_func = mtip_completion;
-
 	/* Copy the command to the command table */
 	memcpy(int_cmd->command, fis, fis_len*4);
 
@@ -1176,11 +1061,9 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 	rq->timeout = timeout;
 
 	/* insert request and run queue */
-	blk_execute_rq_nowait(rq->q, NULL, rq, true, NULL);
+	blk_execute_rq(rq->q, NULL, rq, true);
 
-	wait_for_completion(&wait);
 	rv = int_cmd->status;
-
 	if (rv < 0) {
 		if (rv == -ERESTARTSYS) { /* interrupted */
 			dev_err(&dd->pdev->dev,
@@ -1222,7 +1105,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 	}
 exec_ic_exit:
 	/* Clear the allocated and active bits for the internal command. */
-	mtip_put_int_command(dd, int_cmd);
+	blk_mq_free_request(rq);
 	clear_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
 	if (rv >= 0 && mtip_pause_ncq(port, fis)) {
 		/* NCQ paused */
@@ -2377,12 +2260,6 @@ static void mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
 				(nents << 16) | 5 | AHCI_CMD_PREFETCH);
 	command->command_header->byte_count = 0;
 
-	/*
-	 * Set the completion function and data for the command
-	 * within this layer.
-	 */
-	command->comp_data = dd;
-	command->comp_func = mtip_async_complete;
 	command->direction = dma_dir;
 
 	/*
@@ -3760,15 +3637,13 @@ static int mtip_issue_reserved_cmd(struct blk_mq_hw_ctx *hctx,
 				   struct request *rq)
 {
 	struct driver_data *dd = hctx->queue->queuedata;
-	struct mtip_int_cmd *icmd = rq->end_io_data;
+	struct mtip_int_cmd *icmd = rq->special;
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct mtip_cmd_sg *command_sg;
 
 	if (mtip_commands_active(dd->port))
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
-	rq->end_io_data = NULL;
-
 	/* Populate the SG list */
 	cmd->command_header->opts =
 		 __force_bit2int cpu_to_le32(icmd->opts | icmd->fis_len);
@@ -3856,9 +3731,7 @@ static enum blk_eh_timer_return mtip_cmd_timeout(struct request *req,
 		struct mtip_cmd *cmd = blk_mq_rq_to_pdu(req);
 
 		cmd->status = -ETIME;
-		if (cmd->comp_func)
-			cmd->comp_func(dd->port, MTIP_TAG_INTERNAL, cmd, -ETIME);
-		goto exit_handler;
+		return BLK_EH_HANDLED;
 	}
 
 	if (test_bit(req->tag, dd->port->cmds_to_issue))
@@ -4086,21 +3959,10 @@ static int mtip_block_initialize(struct driver_data *dd)
 
 static void mtip_no_dev_cleanup(struct request *rq, void *data, bool reserv)
 {
-	struct driver_data *dd = (struct driver_data *)data;
-	struct mtip_cmd *cmd;
-
-	if (likely(!reserv)) {
-		cmd = blk_mq_rq_to_pdu(rq);
-		cmd->status = -ENODEV;
-		blk_mq_complete_request(rq);
-	} else if (test_bit(MTIP_PF_IC_ACTIVE_BIT, &dd->port->flags)) {
+	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
 
-		cmd = mtip_cmd_from_tag(dd, MTIP_TAG_INTERNAL);
-		cmd->status = -ENODEV;
-		if (cmd->comp_func)
-			cmd->comp_func(dd->port, MTIP_TAG_INTERNAL,
-					cmd, -ENODEV);
-	}
+	cmd->status = -ENODEV;
+	blk_mq_complete_request(rq);
 }
 
 /*
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index 57b41528a824..37b8e3e0bb78 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -333,16 +333,6 @@ struct mtip_cmd {
 
 	dma_addr_t command_dma; /* corresponding physical address */
 
-	void *comp_data; /* data passed to completion function comp_func() */
-	/*
-	 * Completion function called by the ISR upon completion of
-	 * a command.
-	 */
-	void (*comp_func)(struct mtip_port *port,
-				int tag,
-				struct mtip_cmd *cmd,
-				int status);
-
 	int scatter_ents; /* Number of scatter list entries used */
 
 	int unaligned; /* command is unaligned on 4k boundary */
-- 
2.7.4

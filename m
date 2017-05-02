Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/6] mtip32xx: convert internal command issue to block IO
 path
To: Christoph Hellwig <hch@lst.de>
References: <1493398473-29872-1-git-send-email-axboe@fb.com>
 <1493398473-29872-5-git-send-email-axboe@fb.com>
 <20170502072810.GA11582@lst.de> <b5eae6e4-92f3-3266-5f8e-21c7ab6e69f6@fb.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a43cf987-6f97-a82d-38e7-f8880c4d63ae@kernel.dk>
Date: Tue, 2 May 2017 08:47:59 -0600
MIME-Version: 1.0
In-Reply-To: <b5eae6e4-92f3-3266-5f8e-21c7ab6e69f6@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/02/2017 07:53 AM, Jens Axboe wrote:
> On 05/02/2017 01:28 AM, Christoph Hellwig wrote:
>> Looks fine for now:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> But rather sooner than later we need to make this path at least go
>> through the normal end_request processing.  Without that we're just
>> bound to run into problems like we had with the tag changes again
>> when the driver is using the block layer APIs incompletely.
> 
> I completely agree, I'll see if I can find some time to do that
> soon.

Seems like a fine thing to do over morning coffee. How about something
like the below? It's on top of the previous series. Basically this kills
the private completion handler and data, which were basically redundant
as they did nothing but spew a warning in case of an error.

It'd be nice to unify the INTERNAL and regular commands, but we don't
have to do that to use the block layer APIs. If someone else wants to do
that, be my guest.

It compiles and loads fine on my setup, did some basic testing it that
went fine. Would be nice if someone else could look it over as well, to
verify that I didn't drop any of the 0-vs-error setting. I think it's
fine, we just need to ensure that cmd->status is always set to the
appropriate error, then we propagate that through the mtip32xx softirq
handler to the block layer.

 mtip32xx.c |  194 +++++++++----------------------------------------------------
 mtip32xx.h |   10 ---
 2 files changed, 29 insertions(+), 175 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 96fe6500e941..60b62a72bc22 100644
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
@@ -581,38 +527,18 @@ static void print_tags(struct driver_data *dd,
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
+static void mtip_complete_command(struct mtip_cmd *cmd)
+{
+	struct request *req = blk_mq_rq_from_pdu(cmd);
+
+	blk_mq_complete_request(req);
+}
+
 /*
  * Handle an error.
  *
@@ -641,11 +567,7 @@ static void mtip_handle_tfe(struct driver_data *dd)
 	if (test_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags)) {
 		cmd = mtip_cmd_from_tag(dd, MTIP_TAG_INTERNAL);
 		dbg_printk(MTIP_DRV_NAME " TFE for the internal command\n");
-
-		if (cmd->comp_data && cmd->comp_func) {
-			cmd->comp_func(port, MTIP_TAG_INTERNAL,
-					cmd, PORT_IRQ_TF_ERR);
-		}
+		mtip_complete_command(cmd);
 		return;
 	}
 
@@ -672,19 +594,9 @@ static void mtip_handle_tfe(struct driver_data *dd)
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
+			mtip_complete_command(cmd);
+			set_bit(tag, tagaccum);
+			cmd_cnt++;
 		}
 	}
 
@@ -754,10 +666,8 @@ static void mtip_handle_tfe(struct driver_data *dd)
 					tag,
 					fail_reason != NULL ?
 						fail_reason : "unknown");
-					if (cmd->comp_func) {
-						cmd->comp_func(port, tag,
-							cmd, -ENODATA);
-					}
+					cmd->status = -ENODATA;
+					mtip_complete_command(cmd);
 					continue;
 				}
 			}
@@ -780,12 +690,8 @@ static void mtip_handle_tfe(struct driver_data *dd)
 			dev_warn(&port->dd->pdev->dev,
 				"retiring tag %d\n", tag);
 
-			if (cmd->comp_func)
-				cmd->comp_func(port, tag, cmd, PORT_IRQ_TF_ERR);
-			else
-				dev_warn(&port->dd->pdev->dev,
-					"Bad completion for tag %d\n",
-					tag);
+			cmd->status = -EIO;
+			mtip_complete_command(cmd);
 		}
 	}
 	print_tags(dd, "reissued (TFE)", tagaccum, cmd_cnt);
@@ -818,18 +724,7 @@ static inline void mtip_workq_sdbfx(struct mtip_port *port, int group,
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
+			mtip_complete_command(command);
 		}
 		completed >>= 1;
 	}
@@ -850,10 +745,7 @@ static inline void mtip_process_legacy(struct driver_data *dd, u32 port_stat)
 	if (test_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags) &&
 	    (cmd != NULL) && !(readl(port->cmd_issue[MTIP_TAG_INTERNAL])
 		& (1 << MTIP_TAG_INTERNAL))) {
-		if (cmd->comp_func) {
-			cmd->comp_func(port, MTIP_TAG_INTERNAL, cmd, 0);
-			return;
-		}
+		mtip_complete_command(cmd);
 	}
 
 	return;
@@ -1121,7 +1013,6 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 					u32 opts,
 					unsigned long timeout)
 {
-	DECLARE_COMPLETION_ONSTACK(wait);
 	struct mtip_cmd *int_cmd;
 	struct driver_data *dd = port->dd;
 	struct request *rq;
@@ -1146,7 +1037,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		return -EFAULT;
 	}
 	rq = blk_mq_rq_from_pdu(int_cmd);
-	rq->end_io_data = &icmd;
+	rq->special = &icmd;
 
 	set_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
 
@@ -1159,17 +1050,13 @@ static int mtip_exec_internal_command(struct mtip_port *port,
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
 
@@ -1177,11 +1064,9 @@ static int mtip_exec_internal_command(struct mtip_port *port,
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
@@ -1223,7 +1108,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 	}
 exec_ic_exit:
 	/* Clear the allocated and active bits for the internal command. */
-	mtip_put_int_command(dd, int_cmd);
+	blk_mq_free_request(rq);
 	clear_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
 	if (rv >= 0 && mtip_pause_ncq(port, fis)) {
 		/* NCQ paused */
@@ -2378,12 +2263,6 @@ static void mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
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
@@ -3761,15 +3640,13 @@ static int mtip_issue_reserved_cmd(struct blk_mq_hw_ctx *hctx,
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
@@ -3857,9 +3734,7 @@ static enum blk_eh_timer_return mtip_cmd_timeout(struct request *req,
 		struct mtip_cmd *cmd = blk_mq_rq_to_pdu(req);
 
 		cmd->status = -ETIME;
-		if (cmd->comp_func)
-			cmd->comp_func(dd->port, MTIP_TAG_INTERNAL, cmd, -ETIME);
-		goto exit_handler;
+		return BLK_EH_HANDLED;
 	}
 
 	if (test_bit(req->tag, dd->port->cmds_to_issue))
@@ -4087,21 +3962,10 @@ static int mtip_block_initialize(struct driver_data *dd)
 
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
Jens Axboe

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
To: Christoph Hellwig <hch@infradead.org>
References: <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
 <20170420010346.GC16917@ming.t460p> <20170420045408.GB2235@infradead.org>
 <20170420083041.GA1637@ming.t460p> <20170426104842.GB28062@ming.t460p>
 <38bc590d-8ab4-5c88-d7e7-10cd2ec7d900@kernel.dk>
 <da795dd0-bba1-3a7a-5b24-696d51bcbc2e@kernel.dk>
 <20170427031445.GB4841@ming.t460p>
 <9990a1b5-6c4c-7308-8f38-22bb67c08ff1@kernel.dk>
 <20170427152050.GA733@infradead.org>
 <7ac2368a-f51b-d4de-6db8-2f20025411f0@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@fb.com>, Jozef Mikovic <jmikovic@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <82cd0b47-1bcb-69ea-3401-36f1f4c5687f@kernel.dk>
Date: Thu, 27 Apr 2017 15:40:36 -0600
MIME-Version: 1.0
In-Reply-To: <7ac2368a-f51b-d4de-6db8-2f20025411f0@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/27/2017 09:46 AM, Jens Axboe wrote:
> On 04/27/2017 09:20 AM, Christoph Hellwig wrote:
>> On Thu, Apr 27, 2017 at 06:49:43AM -0700, Jens Axboe wrote:
>>> Thanks Ming, I've added that patch and your patch to initialize the cmd
>>> at runtime.
>>
>> I really think this is the wrong fix, and doing these sort of band-aids
>> just will lead to further problems done the road.
> 
> Ming's patch is just fine, mine is a bit more of a hack. I'll throw some
> cycles at fixing up mtip32xx to not have a hard wired internal tag since
> it doesn't need to, and then we can drop my one-liner again.

Something like this, to keep it simple. This allows us to drop the
requirement that RESERVED requests bypass the normal insertion logic,
and converts mtip32xx to go through queue_rq for internal commands.
Quiesce of NCQ tags is done with busy backoff from queue_rq.

We don't really care about the value of the tag at this point, but
since we KNOW it's a reserved request, I did not rewrite the fact
that we hard code 0 as the internal tag. I think it's safer this
way.

Compiles...


diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 8b361e1..27c6746 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -82,11 +82,7 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 
-	/*
-	 * For a reserved tag, allocate a normal request since we might
-	 * have driver dependencies on the value of the internal tag.
-	 */
-	if (e && !(data->flags & BLK_MQ_REQ_RESERVED)) {
+	if (e) {
 		data->flags |= BLK_MQ_REQ_INTERNAL;
 
 		/*
@@ -104,6 +100,8 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 	}
 
 	if (rq) {
+		if (data->flags & BLK_MQ_REQ_RESERVED)
+			rq->rq_flags |= RQF_RESERVED;
 		if (!op_is_flush(op)) {
 			rq->elv.icq = NULL;
 			if (e && e->type->icq_cache)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b75ef23..0168b27 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -268,6 +268,9 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 			data->hctx->tags->rqs[rq->tag] = rq;
 		}
 
+		if (data->flags & BLK_MQ_REQ_RESERVED)
+			rq->rq_flags |= RQF_RESERVED;
+
 		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
 		return rq;
 	}
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 02804cc..ed287ed 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -195,13 +195,10 @@ static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 	if (mtip_check_surprise_removal(dd->pdev))
 		return NULL;
 
-	rq = blk_mq_alloc_request(dd->queue, 0, BLK_MQ_REQ_RESERVED);
+	rq = blk_mq_alloc_request(dd->queue, REQ_OP_DRV_IN, BLK_MQ_REQ_RESERVED);
 	if (IS_ERR(rq))
 		return NULL;
 
-	/* Internal cmd isn't submitted via .queue_rq */
-	mtip_init_cmd_header(rq);
-
 	return blk_mq_rq_to_pdu(rq);
 }
 
@@ -609,11 +606,6 @@ static void mtip_completion(struct mtip_port *port,
 	complete(waiting);
 }
 
-static void mtip_null_completion(struct mtip_port *port,
-			    int tag, struct mtip_cmd *command, int status)
-{
-}
-
 static int mtip_read_log_page(struct mtip_port *port, u8 page, u16 *buffer,
 				dma_addr_t buffer_dma, unsigned int sectors);
 static int mtip_get_smart_attr(struct mtip_port *port, unsigned int id,
@@ -1035,53 +1027,54 @@ static bool mtip_pause_ncq(struct mtip_port *port,
 	return false;
 }
 
+static bool mtip_commands_active(struct mtip_port *port)
+{
+	unsigned int n;
+	unsigned int active = 1;
+
+	/*
+	 * Ignore s_active bit 0 of array element 0.
+	 * This bit will always be set
+	 */
+	active = readl(port->s_active[0]) & 0xFFFFFFFE;
+	for (n = 1; n < port->dd->slot_groups; n++)
+		active |= readl(port->s_active[n]);
+
+	return active != 0;
+}
+
 /*
  * Wait for port to quiesce
  *
  * @port    Pointer to port data structure
  * @timeout Max duration to wait (ms)
- * @atomic  gfp_t flag to indicate blockable context or not
+ * @can_block flag to indicate blockable context or not
  *
  * return value
  *	0	Success
  *	-EBUSY  Commands still active
  */
-static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout,
-								gfp_t atomic)
+static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
 {
+	bool active = true;
 	unsigned long to;
-	unsigned int n;
-	unsigned int active = 1;
 
 	blk_mq_stop_hw_queues(port->dd->queue);
 
 	to = jiffies + msecs_to_jiffies(timeout);
 	do {
 		if (test_bit(MTIP_PF_SVC_THD_ACTIVE_BIT, &port->flags) &&
-			test_bit(MTIP_PF_ISSUE_CMDS_BIT, &port->flags) &&
-			atomic == GFP_KERNEL) {
+			test_bit(MTIP_PF_ISSUE_CMDS_BIT, &port->flags)) {
 			msleep(20);
 			continue; /* svc thd is actively issuing commands */
 		}
 
-		if (atomic == GFP_KERNEL)
-			msleep(100);
-		else {
-			cpu_relax();
-			udelay(100);
-		}
+		msleep(100);
 
 		if (mtip_check_surprise_removal(port->dd->pdev))
 			goto err_fault;
 
-		/*
-		 * Ignore s_active bit 0 of array element 0.
-		 * This bit will always be set
-		 */
-		active = readl(port->s_active[0]) & 0xFFFFFFFE;
-		for (n = 1; n < port->dd->slot_groups; n++)
-			active |= readl(port->s_active[n]);
-
+		active = mtip_commands_active(port);
 		if (!active)
 			break;
 	} while (time_before(jiffies, to));
@@ -1093,6 +1086,13 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout,
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
@@ -1117,13 +1117,18 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 					dma_addr_t buffer,
 					int buf_len,
 					u32 opts,
-					gfp_t atomic,
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
 
@@ -1138,6 +1143,8 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		dbg_printk(MTIP_DRV_NAME "Unable to allocate tag for PIO cmd\n");
 		return -EFAULT;
 	}
+	rq = blk_mq_rq_from_pdu(int_cmd);
+	rq->end_io_data = &icmd;
 
 	set_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
 
@@ -1146,133 +1153,53 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 
 	clear_bit(MTIP_PF_DM_ACTIVE_BIT, &port->flags);
 
-	if (atomic == GFP_KERNEL) {
-		if (fis->command != ATA_CMD_STANDBYNOW1) {
-			/* wait for io to complete if non atomic */
-			if (mtip_quiesce_io(port,
-				MTIP_QUIESCE_IO_TIMEOUT_MS, atomic) < 0) {
-				dev_warn(&dd->pdev->dev,
-					"Failed to quiesce IO\n");
-				mtip_put_int_command(dd, int_cmd);
-				clear_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
-				wake_up_interruptible(&port->svc_wait);
-				return -EBUSY;
-			}
-		}
-
-		/* Set the completion function and data for the command. */
-		int_cmd->comp_data = &wait;
-		int_cmd->comp_func = mtip_completion;
-
-	} else {
-		/* Clear completion - we're going to poll */
-		int_cmd->comp_data = NULL;
-		int_cmd->comp_func = mtip_null_completion;
-	}
+	/* Set the completion function and data for the command. */
+	int_cmd->comp_data = &wait;
+	int_cmd->comp_func = mtip_completion;
 
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
 
-	/* Issue the command to the hardware */
-	mtip_issue_non_ncq_command(port, MTIP_TAG_INTERNAL);
-
-	if (atomic == GFP_KERNEL) {
-		/* Wait for the command to complete or timeout. */
-		if ((rv = wait_for_completion_interruptible_timeout(
-				&wait,
-				msecs_to_jiffies(timeout))) <= 0) {
-
-			if (rv == -ERESTARTSYS) { /* interrupted */
-				dev_err(&dd->pdev->dev,
-					"Internal command [%02X] was interrupted after %u ms\n",
-					fis->command,
-					jiffies_to_msecs(jiffies - start));
-				rv = -EINTR;
-				goto exec_ic_exit;
-			} else if (rv == 0) /* timeout */
-				dev_err(&dd->pdev->dev,
-					"Internal command did not complete [%02X] within timeout of  %lu ms\n",
-					fis->command, timeout);
-			else
-				dev_err(&dd->pdev->dev,
-					"Internal command [%02X] wait returned code [%d] after %lu ms - unhandled\n",
-					fis->command, rv, timeout);
-
-			if (mtip_check_surprise_removal(dd->pdev) ||
-				test_bit(MTIP_DDF_REMOVE_PENDING_BIT,
-						&dd->dd_flag)) {
-				dev_err(&dd->pdev->dev,
-					"Internal command [%02X] wait returned due to SR\n",
-					fis->command);
-				rv = -ENXIO;
-				goto exec_ic_exit;
-			}
-			mtip_device_reset(dd); /* recover from timeout issue */
-			rv = -EAGAIN;
+	/* insert request and run queue */
+	blk_execute_rq_nowait(rq->q, NULL, rq, true, NULL);
+
+	/* Wait for the command to complete or timeout. */
+	rv = wait_for_completion_interruptible_timeout(&wait,
+						msecs_to_jiffies(timeout));
+	if (rv < 0) {
+		if (rv == -ERESTARTSYS) { /* interrupted */
+			dev_err(&dd->pdev->dev,
+				"Internal command [%02X] was interrupted after %u ms\n",
+				fis->command,
+				jiffies_to_msecs(jiffies - start));
+			rv = -EINTR;
 			goto exec_ic_exit;
-		}
-	} else {
-		u32 hba_stat, port_stat;
-
-		/* Spin for <timeout> checking if command still outstanding */
-		timeout = jiffies + msecs_to_jiffies(timeout);
-		while ((readl(port->cmd_issue[MTIP_TAG_INTERNAL])
-				& (1 << MTIP_TAG_INTERNAL))
-				&& time_before(jiffies, timeout)) {
-			if (mtip_check_surprise_removal(dd->pdev)) {
-				rv = -ENXIO;
-				goto exec_ic_exit;
-			}
-			if ((fis->command != ATA_CMD_STANDBYNOW1) &&
-				test_bit(MTIP_DDF_REMOVE_PENDING_BIT,
-						&dd->dd_flag)) {
-				rv = -ENXIO;
-				goto exec_ic_exit;
-			}
-			port_stat = readl(port->mmio + PORT_IRQ_STAT);
-			if (!port_stat)
-				continue;
+		} else if (rv == 0) /* timeout */
+			dev_err(&dd->pdev->dev,
+				"Internal command did not complete [%02X] within timeout of  %lu ms\n",
+				fis->command, timeout);
+		else
+			dev_err(&dd->pdev->dev,
+				"Internal command [%02X] wait returned code [%d] after %lu ms - unhandled\n",
+				fis->command, rv, timeout);
 
-			if (port_stat & PORT_IRQ_ERR) {
-				dev_err(&dd->pdev->dev,
-					"Internal command [%02X] failed\n",
-					fis->command);
-				mtip_device_reset(dd);
-				rv = -EIO;
-				goto exec_ic_exit;
-			} else {
-				writel(port_stat, port->mmio + PORT_IRQ_STAT);
-				hba_stat = readl(dd->mmio + HOST_IRQ_STAT);
-				if (hba_stat)
-					writel(hba_stat,
-						dd->mmio + HOST_IRQ_STAT);
-			}
-			break;
+		if (mtip_check_surprise_removal(dd->pdev) ||
+			test_bit(MTIP_DDF_REMOVE_PENDING_BIT,
+					&dd->dd_flag)) {
+			dev_err(&dd->pdev->dev,
+				"Internal command [%02X] wait returned due to SR\n",
+				fis->command);
+			rv = -ENXIO;
+			goto exec_ic_exit;
 		}
+		mtip_device_reset(dd); /* recover from timeout issue */
+		rv = -EAGAIN;
+		goto exec_ic_exit;
 	}
 
+	rv = 0;
 	if (readl(port->cmd_issue[MTIP_TAG_INTERNAL])
 			& (1 << MTIP_TAG_INTERNAL)) {
 		rv = -ENXIO;
@@ -1290,7 +1217,6 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 		return rv;
 	}
 	wake_up_interruptible(&port->svc_wait);
-
 	return rv;
 }
 
@@ -1391,7 +1317,6 @@ static int mtip_get_identify(struct mtip_port *port, void __user *user_buffer)
 				port->identify_dma,
 				sizeof(u16) * ATA_ID_WORDS,
 				0,
-				GFP_KERNEL,
 				MTIP_INT_CMD_TIMEOUT_MS)
 				< 0) {
 		rv = -1;
@@ -1477,7 +1402,6 @@ static int mtip_standby_immediate(struct mtip_port *port)
 					0,
 					0,
 					0,
-					GFP_ATOMIC,
 					timeout);
 	dbg_printk(MTIP_DRV_NAME "Time taken to complete standby cmd: %d ms\n",
 			jiffies_to_msecs(jiffies - start));
@@ -1523,7 +1447,6 @@ static int mtip_read_log_page(struct mtip_port *port, u8 page, u16 *buffer,
 					buffer_dma,
 					sectors * ATA_SECT_SIZE,
 					0,
-					GFP_ATOMIC,
 					MTIP_INT_CMD_TIMEOUT_MS);
 }
 
@@ -1558,7 +1481,6 @@ static int mtip_get_smart_data(struct mtip_port *port, u8 *buffer,
 					buffer_dma,
 					ATA_SECT_SIZE,
 					0,
-					GFP_ATOMIC,
 					15000);
 }
 
@@ -1686,7 +1608,6 @@ static int mtip_send_trim(struct driver_data *dd, unsigned int lba,
 					dma_addr,
 					ATA_SECT_SIZE,
 					0,
-					GFP_KERNEL,
 					MTIP_TRIM_TIMEOUT_MS) < 0)
 		rv = -EIO;
 
@@ -1850,7 +1771,6 @@ static int exec_drive_task(struct mtip_port *port, u8 *command)
 				 0,
 				 0,
 				 0,
-				 GFP_KERNEL,
 				 to) < 0) {
 		return -1;
 	}
@@ -1946,7 +1866,6 @@ static int exec_drive_command(struct mtip_port *port, u8 *command,
 				 (xfer_sz ? dma_addr : 0),
 				 (xfer_sz ? ATA_SECT_SIZE * xfer_sz : 0),
 				 0,
-				 GFP_KERNEL,
 				 to)
 				 < 0) {
 		rv = -EFAULT;
@@ -2189,7 +2108,6 @@ static int exec_drive_taskfile(struct driver_data *dd,
 				 dma_buffer,
 				 transfer_size,
 				 0,
-				 GFP_KERNEL,
 				 timeout) < 0) {
 		err = -EIO;
 		goto abort;
@@ -3825,6 +3743,44 @@ static bool mtip_check_unal_depth(struct blk_mq_hw_ctx *hctx,
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
@@ -3833,6 +3789,9 @@ static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	mtip_init_cmd_header(rq);
 
+	if (rq->rq_flags & RQF_RESERVED)
+		return mtip_issue_reserved_cmd(hctx, rq);
+
 	if (unlikely(mtip_check_unal_depth(hctx, rq)))
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
@@ -3982,7 +3941,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 	dd->tags.reserved_tags = 1;
 	dd->tags.cmd_size = sizeof(struct mtip_cmd);
 	dd->tags.numa_node = dd->numa_node;
-	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED;
+	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE;
 	dd->tags.driver_data = dd;
 	dd->tags.timeout = MTIP_NCQ_CMD_TIMEOUT_MS;
 
@@ -4168,11 +4127,9 @@ static int mtip_block_remove(struct driver_data *dd)
 		 * Explicitly wait here for IOs to quiesce,
 		 * as mtip_standby_drive usually won't wait for IOs.
 		 */
-		if (!mtip_quiesce_io(dd->port, MTIP_QUIESCE_IO_TIMEOUT_MS,
-								GFP_KERNEL))
+		if (!mtip_quiesce_io(dd->port, MTIP_QUIESCE_IO_TIMEOUT_MS))
 			mtip_standby_drive(dd);
-	}
-	else
+	} else
 		dev_info(&dd->pdev->dev, "device %s surprise removal\n",
 						dd->disk->disk_name);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ba3884f..c246de5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -120,6 +120,8 @@ typedef __u32 __bitwise req_flags_t;
 /* Look at ->special_vec for the actual data payload instead of the
    bio chain. */
 #define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
+/* Request came from the reserved tags/pool */
+#define RQF_RESERVED		((__force req_flags_t)(1 << 19))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \

-- 
Jens Axboe

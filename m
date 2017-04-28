Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45166 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S938102AbdD1Ozt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:55:49 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/7] mtip32xx: get rid of 'atomic' argument to mtip_exec_internal_command()
Date: Fri, 28 Apr 2017 08:55:34 -0600
Message-ID: <1493391340-24629-2-git-send-email-axboe@fb.com>
In-Reply-To: <1493391340-24629-1-git-send-email-axboe@fb.com>
References: <1493391340-24629-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

All callers can safely block. Kill the atomic/block argument, and
remove the argument from all callers.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@fb.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 148 +++++++++++---------------------------
 1 file changed, 43 insertions(+), 105 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 02804cc79d82..d81d797ee65d 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -609,11 +609,6 @@ static void mtip_completion(struct mtip_port *port,
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
@@ -1117,7 +1112,6 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 					dma_addr_t buffer,
 					int buf_len,
 					u32 opts,
-					gfp_t atomic,
 					unsigned long timeout)
 {
 	struct mtip_cmd_sg *command_sg;
@@ -1146,30 +1140,22 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 
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
+	if (fis->command != ATA_CMD_STANDBYNOW1) {
+		/* wait for io to complete if non atomic */
+		if (mtip_quiesce_io(port,
+			MTIP_QUIESCE_IO_TIMEOUT_MS, GFP_KERNEL) < 0) {
+			dev_warn(&dd->pdev->dev, "Failed to quiesce IO\n");
+			mtip_put_int_command(dd, int_cmd);
+			clear_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
+			wake_up_interruptible(&port->svc_wait);
+			return -EBUSY;
 		}
-
-		/* Set the completion function and data for the command. */
-		int_cmd->comp_data = &wait;
-		int_cmd->comp_func = mtip_completion;
-
-	} else {
-		/* Clear completion - we're going to poll */
-		int_cmd->comp_data = NULL;
-		int_cmd->comp_func = mtip_null_completion;
 	}
 
+	/* Set the completion function and data for the command. */
+	int_cmd->comp_data = &wait;
+	int_cmd->comp_func = mtip_completion;
+
 	/* Copy the command to the command table */
 	memcpy(int_cmd->command, fis, fis_len*4);
 
@@ -1198,81 +1184,41 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 	/* Issue the command to the hardware */
 	mtip_issue_non_ncq_command(port, MTIP_TAG_INTERNAL);
 
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
+	/* Wait for the command to complete or timeout. */
+	rv = wait_for_completion_interruptible_timeout(&wait,
+				msecs_to_jiffies(timeout));
+	if (rv <= 0) {
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
@@ -1391,7 +1337,6 @@ static int mtip_get_identify(struct mtip_port *port, void __user *user_buffer)
 				port->identify_dma,
 				sizeof(u16) * ATA_ID_WORDS,
 				0,
-				GFP_KERNEL,
 				MTIP_INT_CMD_TIMEOUT_MS)
 				< 0) {
 		rv = -1;
@@ -1477,7 +1422,6 @@ static int mtip_standby_immediate(struct mtip_port *port)
 					0,
 					0,
 					0,
-					GFP_ATOMIC,
 					timeout);
 	dbg_printk(MTIP_DRV_NAME "Time taken to complete standby cmd: %d ms\n",
 			jiffies_to_msecs(jiffies - start));
@@ -1523,7 +1467,6 @@ static int mtip_read_log_page(struct mtip_port *port, u8 page, u16 *buffer,
 					buffer_dma,
 					sectors * ATA_SECT_SIZE,
 					0,
-					GFP_ATOMIC,
 					MTIP_INT_CMD_TIMEOUT_MS);
 }
 
@@ -1558,7 +1501,6 @@ static int mtip_get_smart_data(struct mtip_port *port, u8 *buffer,
 					buffer_dma,
 					ATA_SECT_SIZE,
 					0,
-					GFP_ATOMIC,
 					15000);
 }
 
@@ -1686,7 +1628,6 @@ static int mtip_send_trim(struct driver_data *dd, unsigned int lba,
 					dma_addr,
 					ATA_SECT_SIZE,
 					0,
-					GFP_KERNEL,
 					MTIP_TRIM_TIMEOUT_MS) < 0)
 		rv = -EIO;
 
@@ -1850,7 +1791,6 @@ static int exec_drive_task(struct mtip_port *port, u8 *command)
 				 0,
 				 0,
 				 0,
-				 GFP_KERNEL,
 				 to) < 0) {
 		return -1;
 	}
@@ -1946,7 +1886,6 @@ static int exec_drive_command(struct mtip_port *port, u8 *command,
 				 (xfer_sz ? dma_addr : 0),
 				 (xfer_sz ? ATA_SECT_SIZE * xfer_sz : 0),
 				 0,
-				 GFP_KERNEL,
 				 to)
 				 < 0) {
 		rv = -EFAULT;
@@ -2189,7 +2128,6 @@ static int exec_drive_taskfile(struct driver_data *dd,
 				 dma_buffer,
 				 transfer_size,
 				 0,
-				 GFP_KERNEL,
 				 timeout) < 0) {
 		err = -EIO;
 		goto abort;
-- 
2.7.4

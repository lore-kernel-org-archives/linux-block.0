Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/17] gdrom: convert to blk-mq
Date: Thu, 11 Oct 2018 10:59:02 -0600
Message-Id: <20181011165909.32615-11-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Ditch the deffered list, lock, and workqueue handling. Just mark the
set as being blocking, so we are invoked from a workqueue already.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/cdrom/gdrom.c | 182 ++++++++++++++++++++----------------------
 1 file changed, 87 insertions(+), 95 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index ae3a7537cf0f..41b57d9c4424 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -31,12 +31,11 @@
 #include <linux/cdrom.h>
 #include <linux/genhd.h>
 #include <linux/bio.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/wait.h>
-#include <linux/workqueue.h>
 #include <linux/platform_device.h>
 #include <scsi/scsi.h>
 #include <asm/io.h>
@@ -102,11 +101,6 @@ static int gdrom_major;
 static DECLARE_WAIT_QUEUE_HEAD(command_queue);
 static DECLARE_WAIT_QUEUE_HEAD(request_queue);
 
-static DEFINE_SPINLOCK(gdrom_lock);
-static void gdrom_readdisk_dma(struct work_struct *work);
-static DECLARE_WORK(work, gdrom_readdisk_dma);
-static LIST_HEAD(gdrom_deferred);
-
 struct gdromtoc {
 	unsigned int entry[99];
 	unsigned int first, last;
@@ -122,6 +116,7 @@ static struct gdrom_unit {
 	char disk_type;
 	struct gdromtoc *toc;
 	struct request_queue *gdrom_rq;
+	struct blk_mq_tag_set tag_set;
 } gd;
 
 struct gdrom_id {
@@ -584,103 +579,83 @@ static int gdrom_set_interrupt_handlers(void)
  * 9 -> sectors >> 8
  * 10 -> sectors
  */
-static void gdrom_readdisk_dma(struct work_struct *work)
+static blk_status_t gdrom_readdisk_dma(struct request *req)
 {
 	int block, block_cnt;
 	blk_status_t err;
 	struct packet_command *read_command;
-	struct list_head *elem, *next;
-	struct request *req;
 	unsigned long timeout;
 
-	if (list_empty(&gdrom_deferred))
-		return;
 	read_command = kzalloc(sizeof(struct packet_command), GFP_KERNEL);
 	if (!read_command)
-		return; /* get more memory later? */
+		return BLK_STS_RESOURCE;
+
 	read_command->cmd[0] = 0x30;
 	read_command->cmd[1] = 0x20;
-	spin_lock(&gdrom_lock);
-	list_for_each_safe(elem, next, &gdrom_deferred) {
-		req = list_entry(elem, struct request, queuelist);
-		spin_unlock(&gdrom_lock);
-		block = blk_rq_pos(req)/GD_TO_BLK + GD_SESSION_OFFSET;
-		block_cnt = blk_rq_sectors(req)/GD_TO_BLK;
-		__raw_writel(virt_to_phys(bio_data(req->bio)), GDROM_DMA_STARTADDR_REG);
-		__raw_writel(block_cnt * GDROM_HARD_SECTOR, GDROM_DMA_LENGTH_REG);
-		__raw_writel(1, GDROM_DMA_DIRECTION_REG);
-		__raw_writel(1, GDROM_DMA_ENABLE_REG);
-		read_command->cmd[2] = (block >> 16) & 0xFF;
-		read_command->cmd[3] = (block >> 8) & 0xFF;
-		read_command->cmd[4] = block & 0xFF;
-		read_command->cmd[8] = (block_cnt >> 16) & 0xFF;
-		read_command->cmd[9] = (block_cnt >> 8) & 0xFF;
-		read_command->cmd[10] = block_cnt & 0xFF;
-		/* set for DMA */
-		__raw_writeb(1, GDROM_ERROR_REG);
-		/* other registers */
-		__raw_writeb(0, GDROM_SECNUM_REG);
-		__raw_writeb(0, GDROM_BCL_REG);
-		__raw_writeb(0, GDROM_BCH_REG);
-		__raw_writeb(0, GDROM_DSEL_REG);
-		__raw_writeb(0, GDROM_INTSEC_REG);
-		/* Wait for registers to reset after any previous activity */
-		timeout = jiffies + HZ / 2;
-		while (gdrom_is_busy() && time_before(jiffies, timeout))
-			cpu_relax();
-		__raw_writeb(GDROM_COM_PACKET, GDROM_STATUSCOMMAND_REG);
-		timeout = jiffies + HZ / 2;
-		/* Wait for packet command to finish */
-		while (gdrom_is_busy() && time_before(jiffies, timeout))
-			cpu_relax();
-		gd.pending = 1;
-		gd.transfer = 1;
-		outsw(GDROM_DATA_REG, &read_command->cmd, 6);
-		timeout = jiffies + HZ / 2;
-		/* Wait for any pending DMA to finish */
-		while (__raw_readb(GDROM_DMA_STATUS_REG) &&
-			time_before(jiffies, timeout))
-			cpu_relax();
-		/* start transfer */
-		__raw_writeb(1, GDROM_DMA_STATUS_REG);
-		wait_event_interruptible_timeout(request_queue,
-			gd.transfer == 0, GDROM_DEFAULT_TIMEOUT);
-		err = gd.transfer ? BLK_STS_IOERR : BLK_STS_OK;
-		gd.transfer = 0;
-		gd.pending = 0;
-		/* now seek to take the request spinlock
-		* before handling ending the request */
-		spin_lock(&gdrom_lock);
-		list_del_init(&req->queuelist);
-		__blk_end_request_all(req, err);
-	}
-	spin_unlock(&gdrom_lock);
+	block = blk_rq_pos(req)/GD_TO_BLK + GD_SESSION_OFFSET;
+	block_cnt = blk_rq_sectors(req)/GD_TO_BLK;
+	__raw_writel(virt_to_phys(bio_data(req->bio)), GDROM_DMA_STARTADDR_REG);
+	__raw_writel(block_cnt * GDROM_HARD_SECTOR, GDROM_DMA_LENGTH_REG);
+	__raw_writel(1, GDROM_DMA_DIRECTION_REG);
+	__raw_writel(1, GDROM_DMA_ENABLE_REG);
+	read_command->cmd[2] = (block >> 16) & 0xFF;
+	read_command->cmd[3] = (block >> 8) & 0xFF;
+	read_command->cmd[4] = block & 0xFF;
+	read_command->cmd[8] = (block_cnt >> 16) & 0xFF;
+	read_command->cmd[9] = (block_cnt >> 8) & 0xFF;
+	read_command->cmd[10] = block_cnt & 0xFF;
+	/* set for DMA */
+	__raw_writeb(1, GDROM_ERROR_REG);
+	/* other registers */
+	__raw_writeb(0, GDROM_SECNUM_REG);
+	__raw_writeb(0, GDROM_BCL_REG);
+	__raw_writeb(0, GDROM_BCH_REG);
+	__raw_writeb(0, GDROM_DSEL_REG);
+	__raw_writeb(0, GDROM_INTSEC_REG);
+	/* Wait for registers to reset after any previous activity */
+	timeout = jiffies + HZ / 2;
+	while (gdrom_is_busy() && time_before(jiffies, timeout))
+		cpu_relax();
+	__raw_writeb(GDROM_COM_PACKET, GDROM_STATUSCOMMAND_REG);
+	timeout = jiffies + HZ / 2;
+	/* Wait for packet command to finish */
+	while (gdrom_is_busy() && time_before(jiffies, timeout))
+		cpu_relax();
+	gd.pending = 1;
+	gd.transfer = 1;
+	outsw(GDROM_DATA_REG, &read_command->cmd, 6);
+	timeout = jiffies + HZ / 2;
+	/* Wait for any pending DMA to finish */
+	while (__raw_readb(GDROM_DMA_STATUS_REG) &&
+		time_before(jiffies, timeout))
+		cpu_relax();
+	/* start transfer */
+	__raw_writeb(1, GDROM_DMA_STATUS_REG);
+	wait_event_interruptible_timeout(request_queue,
+		gd.transfer == 0, GDROM_DEFAULT_TIMEOUT);
+	err = gd.transfer ? BLK_STS_IOERR : BLK_STS_OK;
+	gd.transfer = 0;
+	gd.pending = 0;
+
+	blk_mq_end_request(req, err);
 	kfree(read_command);
+	return BLK_STS_OK;
 }
 
-static void gdrom_request(struct request_queue *rq)
-{
-	struct request *req;
-
-	while ((req = blk_fetch_request(rq)) != NULL) {
-		switch (req_op(req)) {
-		case REQ_OP_READ:
-			/*
-			 * Add to list of deferred work and then schedule
-			 * workqueue.
-			 */
-			list_add_tail(&req->queuelist, &gdrom_deferred);
-			schedule_work(&work);
-			break;
-		case REQ_OP_WRITE:
-			pr_notice("Read only device - write request ignored\n");
-			__blk_end_request_all(req, BLK_STS_IOERR);
-			break;
-		default:
-			printk(KERN_DEBUG "gdrom: Non-fs request ignored\n");
-			__blk_end_request_all(req, BLK_STS_IOERR);
-			break;
-		}
+static blk_status_t gdrom_queue_rq(struct blk_mq_hw_ctx *hctx,
+				   const struct blk_mq_queue_data *bd)
+{
+	blk_mq_start_request(bd->rq);
+
+	switch (req_op(bd->rq)) {
+	case REQ_OP_READ:
+		return gdrom_readdisk_dma(bd->rq);
+	case REQ_OP_WRITE:
+		pr_notice("Read only device - write request ignored\n");
+		return BLK_STS_IOERR;
+	default:
+		printk(KERN_DEBUG "gdrom: Non-fs request ignored\n");
+		return BLK_STS_IOERR;
 	}
 }
 
@@ -768,6 +743,10 @@ static int probe_gdrom_setupqueue(void)
 	return gdrom_init_dma_mode();
 }
 
+static const struct blk_mq_ops gdrom_mq_ops = {
+	.queue_rq	= gdrom_queue_rq,
+};
+
 /*
  * register this as a block device and as compliant with the
  * universal CD Rom driver interface
@@ -811,11 +790,23 @@ static int probe_gdrom(struct platform_device *devptr)
 	err = gdrom_set_interrupt_handlers();
 	if (err)
 		goto probe_fail_cmdirq_register;
-	gd.gdrom_rq = blk_init_queue(gdrom_request, &gdrom_lock);
-	if (!gd.gdrom_rq) {
-		err = -ENOMEM;
+
+	gd.tag_set.ops = &gdrom_mq_ops;
+	gd.tag_set.nr_hw_queues = 1;
+	gd.tag_set.queue_depth = 1;
+	gd.tag_set.numa_node = NUMA_NO_NODE;
+	gd.tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	err = blk_mq_alloc_tag_set(&td.tag_set);
+	if (err)
+		goto probe_fail_requestq;
+
+	gd.gdrom_rq = blk_mq_init_queue(set);
+	if (IS_ERR(gd.gdrom_rq)) {
+		rc = PTR_ERR(gd.gdrom_rq);
+		gd.gdrom_rq = NULL;
 		goto probe_fail_requestq;
 	}
+
 	blk_queue_bounce_limit(gd.gdrom_rq, BLK_BOUNCE_HIGH);
 
 	err = probe_gdrom_setupqueue();
@@ -831,6 +822,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	return 0;
 
 probe_fail_toc:
+	blk_mq_free_tag_set(&gd.tag_set);
 	blk_cleanup_queue(gd.gdrom_rq);
 probe_fail_requestq:
 	free_irq(HW_EVENT_GDROM_DMA, &gd);
@@ -849,7 +841,7 @@ static int probe_gdrom(struct platform_device *devptr)
 
 static int remove_gdrom(struct platform_device *devptr)
 {
-	flush_work(&work);
+	blk_mq_free_tag_set(&gd.tag_set);
 	blk_cleanup_queue(gd.gdrom_rq);
 	free_irq(HW_EVENT_GDROM_CMD, &gd);
 	free_irq(HW_EVENT_GDROM_DMA, &gd);
-- 
2.17.1

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88406CCA47A
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 06:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiFSGGD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiFSGGC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 02:06:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1D7EE2D
        for <linux-block@vger.kernel.org>; Sat, 18 Jun 2022 23:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IOTgejJB+pFXR2rrFeUd94/lhUioCsMPlk9A1DT7C4k=; b=zfda7540Iw3pnHg4dln5NT9Cxt
        rkmD9ACeKCVgjUn1CUSIlvsLwYlEl0LWP+nk0SfgOhL4/LLn0qxxD/3JiGzlsYg17T/VKjAxx0K2H
        kEMZZ97Xm/Uus/QyGDDHaaSG7XEn/VZ2HLZJwqjDwOuCQyLXCGVUTJyUGDjHpzl4UpK5EzXdeImyb
        0jkmdhuPwvkKqobSOgMINpFzT8R+3GN75oG+6Fdsv6D7RYO+R/8WBOgyiUlb7pKhqRtojMJjLSQom
        l25gKDNlqRQUcxKLyN9Cuww1h/4HYQHc7313rwNIg+toGros6/bBnWwTkrtk86EmMcaauM2gTONZz
        9Ka72a0w==;
Received: from [2001:4bb8:189:7251:513c:d533:c6f1:1e56] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2o4O-00DJmW-DY; Sun, 19 Jun 2022 06:06:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 2/6] mtip32xx: fix device removal
Date:   Sun, 19 Jun 2022 08:05:48 +0200
Message-Id: <20220619060552.1850436-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220619060552.1850436-1-hch@lst.de>
References: <20220619060552.1850436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the proper helper to mark a surpise removal, remove the gendisk as
soon as possible when removing the device and implement the ->free_disk
callback to ensure the private data is alive as long as the gendisk has
references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 157 +++++++++---------------------
 drivers/block/mtip32xx/mtip32xx.h |   1 -
 2 files changed, 44 insertions(+), 114 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 4151c80f5bfcc..e7604b3bf8a75 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -141,11 +141,8 @@ static bool mtip_check_surprise_removal(struct driver_data *dd)
 	pci_read_config_word(dd->pdev, 0x00, &vendor_id);
 	if (vendor_id == 0xFFFF) {
 		dd->sr = true;
-		if (dd->queue)
-			blk_queue_flag_set(QUEUE_FLAG_DEAD, dd->queue);
-		else
-			dev_warn(&dd->pdev->dev,
-				"%s: dd->queue is NULL\n", __func__);
+		if (dd->disk)
+			blk_mark_disk_dead(dd->disk);
 		return true; /* device removed */
 	}
 
@@ -3185,26 +3182,12 @@ static int mtip_block_getgeo(struct block_device *dev,
 	return 0;
 }
 
-static int mtip_block_open(struct block_device *dev, fmode_t mode)
+static void mtip_block_free_disk(struct gendisk *disk)
 {
-	struct driver_data *dd;
-
-	if (dev && dev->bd_disk) {
-		dd = (struct driver_data *) dev->bd_disk->private_data;
-
-		if (dd) {
-			if (test_bit(MTIP_DDF_REMOVAL_BIT,
-							&dd->dd_flag)) {
-				return -ENODEV;
-			}
-			return 0;
-		}
-	}
-	return -ENODEV;
-}
+	struct driver_data *dd = disk->private_data;
 
-static void mtip_block_release(struct gendisk *disk, fmode_t mode)
-{
+	ida_free(&rssd_index_ida, dd->index);
+	kfree(dd);
 }
 
 /*
@@ -3214,13 +3197,12 @@ static void mtip_block_release(struct gendisk *disk, fmode_t mode)
  * layer.
  */
 static const struct block_device_operations mtip_block_ops = {
-	.open		= mtip_block_open,
-	.release	= mtip_block_release,
 	.ioctl		= mtip_block_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= mtip_block_compat_ioctl,
 #endif
 	.getgeo		= mtip_block_getgeo,
+	.free_disk	= mtip_block_free_disk,
 	.owner		= THIS_MODULE
 };
 
@@ -3561,72 +3543,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 	return rv;
 }
 
-static bool mtip_no_dev_cleanup(struct request *rq, void *data, bool reserv)
-{
-	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
-
-	cmd->status = BLK_STS_IOERR;
-	blk_mq_complete_request(rq);
-	return true;
-}
-
-/*
- * Block layer deinitialization function.
- *
- * Called by the PCI layer as each P320 device is removed.
- *
- * @dd Pointer to the driver data structure.
- *
- * return value
- *	0
- */
-static int mtip_block_remove(struct driver_data *dd)
-{
-	mtip_hw_debugfs_exit(dd);
-
-	if (dd->mtip_svc_handler) {
-		set_bit(MTIP_PF_SVC_THD_STOP_BIT, &dd->port->flags);
-		wake_up_interruptible(&dd->port->svc_wait);
-		kthread_stop(dd->mtip_svc_handler);
-	}
-
-	if (!dd->sr) {
-		/*
-		 * Explicitly wait here for IOs to quiesce,
-		 * as mtip_standby_drive usually won't wait for IOs.
-		 */
-		if (!mtip_quiesce_io(dd->port, MTIP_QUIESCE_IO_TIMEOUT_MS))
-			mtip_standby_drive(dd);
-	}
-	else
-		dev_info(&dd->pdev->dev, "device %s surprise removal\n",
-						dd->disk->disk_name);
-
-	blk_freeze_queue_start(dd->queue);
-	blk_mq_quiesce_queue(dd->queue);
-	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
-	blk_mq_unquiesce_queue(dd->queue);
-
-	if (dd->disk) {
-		if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
-			del_gendisk(dd->disk);
-		if (dd->disk->queue) {
-			blk_cleanup_queue(dd->queue);
-			blk_mq_free_tag_set(&dd->tags);
-			dd->queue = NULL;
-		}
-		put_disk(dd->disk);
-	}
-	dd->disk  = NULL;
-
-	ida_free(&rssd_index_ida, dd->index);
-
-	/* De-initialize the protocol layer. */
-	mtip_hw_exit(dd);
-
-	return 0;
-}
-
 /*
  * Function called by the PCI layer when just before the
  * machine shuts down.
@@ -3643,23 +3559,15 @@ static int mtip_block_shutdown(struct driver_data *dd)
 {
 	mtip_hw_shutdown(dd);
 
-	/* Delete our gendisk structure, and cleanup the blk queue. */
-	if (dd->disk) {
-		dev_info(&dd->pdev->dev,
-			"Shutting down %s ...\n", dd->disk->disk_name);
+	dev_info(&dd->pdev->dev,
+		"Shutting down %s ...\n", dd->disk->disk_name);
 
-		if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
-			del_gendisk(dd->disk);
-		if (dd->disk->queue) {
-			blk_cleanup_queue(dd->queue);
-			blk_mq_free_tag_set(&dd->tags);
-		}
-		put_disk(dd->disk);
-		dd->disk  = NULL;
-		dd->queue = NULL;
-	}
+	if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
+		del_gendisk(dd->disk);
 
-	ida_free(&rssd_index_ida, dd->index);
+	blk_cleanup_queue(dd->queue);
+	blk_mq_free_tag_set(&dd->tags);
+	put_disk(dd->disk);
 	return 0;
 }
 
@@ -3966,8 +3874,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 	struct driver_data *dd = pci_get_drvdata(pdev);
 	unsigned long to;
 
-	set_bit(MTIP_DDF_REMOVAL_BIT, &dd->dd_flag);
-
 	mtip_check_surprise_removal(dd);
 	synchronize_irq(dd->pdev->irq);
 
@@ -3983,11 +3889,36 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 			"Completion workers still active!\n");
 	}
 
-	blk_mark_disk_dead(dd->disk);
 	set_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag);
 
-	/* Clean up the block layer. */
-	mtip_block_remove(dd);
+	if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
+		del_gendisk(dd->disk);
+
+	mtip_hw_debugfs_exit(dd);
+
+	if (dd->mtip_svc_handler) {
+		set_bit(MTIP_PF_SVC_THD_STOP_BIT, &dd->port->flags);
+		wake_up_interruptible(&dd->port->svc_wait);
+		kthread_stop(dd->mtip_svc_handler);
+	}
+
+	if (!dd->sr) {
+		/*
+		 * Explicitly wait here for IOs to quiesce,
+		 * as mtip_standby_drive usually won't wait for IOs.
+		 */
+		if (!mtip_quiesce_io(dd->port, MTIP_QUIESCE_IO_TIMEOUT_MS))
+			mtip_standby_drive(dd);
+	}
+	else
+		dev_info(&dd->pdev->dev, "device %s surprise removal\n",
+						dd->disk->disk_name);
+
+	blk_cleanup_queue(dd->queue);
+	blk_mq_free_tag_set(&dd->tags);
+
+	/* De-initialize the protocol layer. */
+	mtip_hw_exit(dd);
 
 	if (dd->isr_workq) {
 		destroy_workqueue(dd->isr_workq);
@@ -3998,10 +3929,10 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	kfree(dd);
-
 	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 	pci_set_drvdata(pdev, NULL);
+
+	put_disk(dd->disk);
 }
 
 /*
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index a80419c57bbe4..f7328f19ac5c2 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -149,7 +149,6 @@ enum {
 	MTIP_DDF_RESUME_BIT         = 6,
 	MTIP_DDF_INIT_DONE_BIT      = 7,
 	MTIP_DDF_REBUILD_FAILED_BIT = 8,
-	MTIP_DDF_REMOVAL_BIT	    = 9,
 
 	MTIP_DDF_STOP_IO      = ((1 << MTIP_DDF_REMOVE_PENDING_BIT) |
 				(1 << MTIP_DDF_SEC_LOCK_BIT) |
-- 
2.30.2


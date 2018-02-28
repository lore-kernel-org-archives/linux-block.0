Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:65085 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933430AbeB1T20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Feb 2018 14:28:26 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 05/11] mtip32xx: Use the blk_queue_flag_*() functions
Date: Wed, 28 Feb 2018 11:28:17 -0800
Message-Id: <20180228192823.5191-6-bart.vanassche@wdc.com>
In-Reply-To: <20180228192823.5191-1-bart.vanassche@wdc.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use the blk_queue_flag_*() functions instead of open-coding these.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index b8af7352a18f..769c551e3d71 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -159,7 +159,7 @@ static bool mtip_check_surprise_removal(struct pci_dev *pdev)
 	if (vendor_id == 0xFFFF) {
 		dd->sr = true;
 		if (dd->queue)
-			set_bit(QUEUE_FLAG_DEAD, &dd->queue->queue_flags);
+			blk_queue_flag_set(QUEUE_FLAG_DEAD, dd->queue);
 		else
 			dev_warn(&dd->pdev->dev,
 				"%s: dd->queue is NULL\n", __func__);
@@ -3855,8 +3855,8 @@ static int mtip_block_initialize(struct driver_data *dd)
 		goto start_service_thread;
 
 	/* Set device limits. */
-	set_bit(QUEUE_FLAG_NONROT, &dd->queue->queue_flags);
-	clear_bit(QUEUE_FLAG_ADD_RANDOM, &dd->queue->queue_flags);
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, dd->queue);
+	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, dd->queue);
 	blk_queue_max_segments(dd->queue, MTIP_MAX_SG);
 	blk_queue_physical_block_size(dd->queue, 4096);
 	blk_queue_max_hw_sectors(dd->queue, 0xffff);
@@ -3866,7 +3866,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 
 	/* Signal trim support */
 	if (dd->trim_supp == true) {
-		set_bit(QUEUE_FLAG_DISCARD, &dd->queue->queue_flags);
+		blk_queue_flag_set(QUEUE_FLAG_DISCARD, dd->queue);
 		dd->queue->limits.discard_granularity = 4096;
 		blk_queue_max_discard_sectors(dd->queue,
 			MTIP_MAX_TRIM_ENTRY_LEN * MTIP_MAX_TRIM_ENTRIES);
-- 
2.16.2

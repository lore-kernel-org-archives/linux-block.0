Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 6/8] mtip32xx: quiesce request queues to make sure no submissions are inflight
Date: Tue,  4 Jul 2017 10:55:10 +0300
Message-Id: <1499154912-10420-7-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Unlike blk_mq_stop_hw_queues, blk_mq_quiesce_queue respects the
submission path rcu grace. quiesce the queue before iterating
on live tags, or performing device io quiescing.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/block/mtip32xx/mtip32xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 61b046f256ca..69a62aeace2a 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -950,7 +950,7 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
 	unsigned long to;
 	bool active = true;
 
-	blk_mq_stop_hw_queues(port->dd->queue);
+	blk_mq_quiesce_queue(port->dd->queue);
 
 	to = jiffies + msecs_to_jiffies(timeout);
 	do {
@@ -970,10 +970,10 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
 			break;
 	} while (time_before(jiffies, to));
 
-	blk_mq_start_stopped_hw_queues(port->dd->queue, true);
+	blk_mq_unquiesce_queue(port->dd->queue);
 	return active ? -EBUSY : 0;
 err_fault:
-	blk_mq_start_stopped_hw_queues(port->dd->queue, true);
+	blk_mq_unquiesce_queue(port->dd->queue);
 	return -EFAULT;
 }
 
@@ -3995,7 +3995,7 @@ static int mtip_block_remove(struct driver_data *dd)
 						dd->disk->disk_name);
 
 	blk_freeze_queue_start(dd->queue);
-	blk_mq_stop_hw_queues(dd->queue);
+	blk_mq_quiesce_queue(dd->queue);
 	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
 
 	/*
-- 
2.7.4

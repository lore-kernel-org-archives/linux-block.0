Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	James Smart <james.smart@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 7/8] mtip32xx: quiesce request queues to make sure no submissions are inflight
Date: Wed,  5 Jul 2017 20:00:36 +0300
Message-Id: <1499274037-17438-8-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Unlike blk_mq_stop_hw_queues, blk_mq_quiesce_queue respects the
submission path rcu grace. quiesce the queue before iterating
on live tags, or performing device io quiescing.

While were at it, verify that the request started in mtip_abort_cmd
amd mtip_queue_cmd tag iteration calls.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/block/mtip32xx/mtip32xx.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 61b046f256ca..87717a1a5c89 100644
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
 
@@ -2737,6 +2737,9 @@ static void mtip_abort_cmd(struct request *req, void *data,
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct driver_data *dd = data;
 
+	if (!blk_mq_request_started(req))
+		return;
+
 	dbg_printk(MTIP_DRV_NAME " Aborting request, tag = %d\n", req->tag);
 
 	clear_bit(req->tag, dd->port->cmds_to_issue);
@@ -2749,6 +2752,9 @@ static void mtip_queue_cmd(struct request *req, void *data,
 {
 	struct driver_data *dd = data;
 
+	if (!blk_mq_request_started(req))
+		return;
+
 	set_bit(req->tag, dd->port->cmds_to_issue);
 	blk_abort_request(req);
 }
@@ -2814,6 +2820,8 @@ static int mtip_service_thread(void *data)
 				dev_warn(&dd->pdev->dev,
 					"Completion workers still active!");
 
+			blk_mq_quiesce_queue(dd->queue);
+
 			spin_lock(dd->queue->queue_lock);
 			blk_mq_tagset_busy_iter(&dd->tags,
 							mtip_queue_cmd, dd);
@@ -2826,6 +2834,8 @@ static int mtip_service_thread(void *data)
 							mtip_abort_cmd, dd);
 
 			clear_bit(MTIP_PF_TO_ACTIVE_BIT, &dd->port->flags);
+
+			blk_mq_unquiesce_queue(dd->queue);
 		}
 
 		if (test_bit(MTIP_PF_ISSUE_CMDS_BIT, &port->flags)) {
@@ -3995,8 +4005,9 @@ static int mtip_block_remove(struct driver_data *dd)
 						dd->disk->disk_name);
 
 	blk_freeze_queue_start(dd->queue);
-	blk_mq_stop_hw_queues(dd->queue);
+	blk_mq_quiesce_queue(dd->queue);
 	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
+	blk_mq_unquiesce_queue(dd->queue);
 
 	/*
 	 * Delete our gendisk structure. This also removes the device
-- 
2.7.4

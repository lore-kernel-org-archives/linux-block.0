Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52102 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdFRPWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:20 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 07/30] nvme-rdma: make stop/free queue receive a ctrl and qid struct
Date: Sun, 18 Jun 2017 18:21:41 +0300
Message-Id: <1497799324-19598-8-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make it symmetrical to alloc/start queue.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c8016150dc21..86998de90f52 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -563,16 +563,20 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	return ret;
 }
 
-static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
+static void nvme_rdma_stop_queue(struct nvme_rdma_ctrl *ctrl, int qid)
 {
+	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
+
 	if (test_bit(NVME_RDMA_Q_DELETING, &queue->flags))
 		return;
 	rdma_disconnect(queue->cm_id);
 	ib_drain_qp(queue->qp);
 }
 
-static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
+static void nvme_rdma_free_queue(struct nvme_rdma_ctrl *ctrl, int qid)
 {
+	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
+
 	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
 		return;
 	nvme_rdma_destroy_queue_ib(queue);
@@ -584,7 +588,7 @@ static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_rdma_free_queue(&ctrl->queues[i]);
+		nvme_rdma_free_queue(ctrl, i);
 }
 
 static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
@@ -592,7 +596,7 @@ static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_rdma_stop_queue(&ctrl->queues[i]);
+		nvme_rdma_stop_queue(ctrl, i);
 }
 
 static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl, bool remove)
@@ -637,7 +641,7 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 out_stop_queues:
 	for (i--; i >= 1; i--)
-		nvme_rdma_stop_queue(&ctrl->queues[i]);
+		nvme_rdma_stop_queue(ctrl, i);
 	return ret;
 }
 
@@ -680,7 +684,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 out_free_queues:
 	for (i--; i >= 1; i--)
-		nvme_rdma_free_queue(&ctrl->queues[i]);
+		nvme_rdma_free_queue(ctrl, i);
 
 	return ret;
 }
@@ -752,7 +756,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl, bool remove)
 {
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(ctrl, 0);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
@@ -762,7 +766,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl, bool remo
 
 	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
-	nvme_rdma_free_queue(&ctrl->queues[0]);
+	nvme_rdma_free_queue(ctrl, 0);
 }
 
 static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new)
@@ -864,14 +868,14 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 out_free_tagset:
 	if (new) {
 		/* disconnect and drain the queue before freeing the tagset */
-		nvme_rdma_stop_queue(&ctrl->queues[0]);
+		nvme_rdma_stop_queue(ctrl, 0);
 		blk_mq_free_tag_set(&ctrl->admin_tag_set);
 	}
 out_put_dev:
 	if (new)
 		nvme_rdma_dev_put(ctrl->device);
 out_free_queue:
-	nvme_rdma_free_queue(&ctrl->queues[0]);
+	nvme_rdma_free_queue(ctrl, 0);
 	return error;
 }
 
-- 
2.7.4

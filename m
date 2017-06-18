Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52182 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:34 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 17/30] nvme-rdma: move admin specific resources to alloc_queue
Date: Sun, 18 Jun 2017 18:21:51 +0300
Message-Id: <1497799324-19598-18-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We're trying to make admin queue configuration generic, so
move the rdma specifics to the queue allocation (based on
the queue index passed).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c1ffdb823cbb..7f4b66cf67cc 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -618,6 +618,23 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 		goto out_destroy_cm_id;
 	}
 
+	if (!idx) {
+		ctrl->device = ctrl->queues[0].device;
+		ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
+			ctrl->device->dev->attrs.max_fast_reg_page_list_len);
+		ctrl->ctrl.max_hw_sectors =
+			(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
+
+		ret = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
+			&ctrl->async_event_sqe, sizeof(struct nvme_command),
+			DMA_TO_DEVICE);
+		if (ret) {
+			nvme_rdma_destroy_queue_ib(&ctrl->queues[0]);
+			goto out_destroy_cm_id;
+		}
+
+	}
+
 	clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);
 
 	return 0;
@@ -643,6 +660,11 @@ static void nvme_rdma_free_queue(struct nvme_rdma_ctrl *ctrl, int qid)
 
 	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
 		return;
+
+	if (!qid)
+		nvme_rdma_free_qe(ctrl->queues[0].device->dev,
+			&ctrl->async_event_sqe, sizeof(struct nvme_command),
+			DMA_TO_DEVICE);
 	nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
 }
@@ -801,9 +823,6 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl, bool remo
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
 		nvme_rdma_free_tagset(&ctrl->ctrl, true);
 	}
-
-	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
-			sizeof(struct nvme_command), DMA_TO_DEVICE);
 	nvme_rdma_free_queue(ctrl, 0);
 }
 
@@ -815,10 +834,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 	if (error)
 		return error;
 
-	ctrl->device = ctrl->queues[0].device;
-	ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
-		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
-
 	if (new) {
 		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
 		if (IS_ERR(ctrl->ctrl.admin_tagset)) {
@@ -861,19 +876,10 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 	if (error)
 		goto out_cleanup_connect_queue;
 
-	ctrl->ctrl.max_hw_sectors =
-		(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
-
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
 		goto out_cleanup_connect_queue;
 
-	error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
-			&ctrl->async_event_sqe, sizeof(struct nvme_command),
-			DMA_TO_DEVICE);
-	if (error)
-		goto out_cleanup_connect_queue;
-
 	nvme_start_keep_alive(&ctrl->ctrl);
 
 	return 0;
-- 
2.7.4

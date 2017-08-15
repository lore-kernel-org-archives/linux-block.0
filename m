Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbdHOJwf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:35 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 02/12] nvme-rdma: move admin specific resources to alloc_queue
Date: Tue, 15 Aug 2017 12:52:15 +0300
Message-Id: <1502790745-12569-3-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We're trying to make admin queue configuration generic, so
move the rdma specifics to the queue allocation (based on
the queue index passed).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 10e54f81e3d9..d94b4df364a5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -544,6 +544,23 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
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
@@ -567,6 +584,10 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
 		return;
 
+	if (!nvme_rdma_queue_idx(queue))
+		nvme_rdma_free_qe(queue->device->dev,
+			&queue->ctrl->async_event_sqe,
+			sizeof(struct nvme_command), DMA_TO_DEVICE);
 	nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
 }
@@ -735,8 +756,6 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
-			sizeof(struct nvme_command), DMA_TO_DEVICE);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
@@ -754,11 +773,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		return error;
 
-	ctrl->device = ctrl->queues[0].device;
-
-	ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
-		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
-
 	if (new) {
 		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
 		if (IS_ERR(ctrl->ctrl.admin_tagset))
@@ -794,19 +808,10 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		goto out_cleanup_queue;
 
-	ctrl->ctrl.max_hw_sectors =
-		(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
-
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
 		goto out_cleanup_queue;
 
-	error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
-			&ctrl->async_event_sqe, sizeof(struct nvme_command),
-			DMA_TO_DEVICE);
-	if (error)
-		goto out_cleanup_queue;
-
 	return 0;
 
 out_cleanup_queue:
-- 
2.7.4

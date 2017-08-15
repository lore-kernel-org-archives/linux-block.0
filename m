Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44863 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbdHOJwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:41 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 05/12] nvme-rdma: introduce nvme_rdma_alloc/stop/free_admin_queue
Date: Tue, 15 Aug 2017 12:52:18 +0300
Message-Id: <1502790745-12569-6-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The core will eventually call this type of callouts
to allocate/stop/free the HW admin queue.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 81 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dc903625a759..8a8163c82733 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -544,23 +544,6 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 		goto out_destroy_cm_id;
 	}
 
-	if (!idx) {
-		ctrl->device = ctrl->queues[0].device;
-		ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
-			ctrl->device->dev->attrs.max_fast_reg_page_list_len);
-		ctrl->ctrl.max_hw_sectors =
-			(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
-
-		ret = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
-			&ctrl->async_event_sqe, sizeof(struct nvme_command),
-			DMA_TO_DEVICE);
-		if (ret) {
-			nvme_rdma_destroy_queue_ib(&ctrl->queues[0]);
-			goto out_destroy_cm_id;
-		}
-
-	}
-
 	clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);
 
 	return 0;
@@ -579,19 +562,32 @@ static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 	ib_drain_qp(queue->qp);
 }
 
+static void nvme_rdma_stop_admin_queue(struct nvme_ctrl *ctrl)
+{
+	nvme_rdma_stop_queue(&to_rdma_ctrl(ctrl)->queues[0]);
+}
+
 static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 {
 	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
 		return;
 
-	if (!nvme_rdma_queue_idx(queue))
-		nvme_rdma_free_qe(queue->device->dev,
-			&queue->ctrl->async_event_sqe,
-			sizeof(struct nvme_command), DMA_TO_DEVICE);
 	nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
 }
 
+static void nvme_rdma_free_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[0];
+
+	nvme_rdma_free_qe(queue->device->dev,
+		&queue->ctrl->async_event_sqe,
+		sizeof(struct nvme_command), DMA_TO_DEVICE);
+
+	nvme_rdma_free_queue(queue);
+}
+
 static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	int i;
@@ -625,6 +621,11 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	return ret;
 }
 
+static int nvme_rdma_start_admin_queue(struct nvme_ctrl *ctrl)
+{
+	return nvme_rdma_start_queue(to_rdma_ctrl(ctrl), 0);
+}
+
 static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	int i, ret = 0;
@@ -751,12 +752,40 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_admin_queue(&ctrl->ctrl);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
 		nvme_rdma_free_tagset(&ctrl->ctrl, true);
 	}
+	nvme_rdma_free_admin_queue(&ctrl->ctrl);
+}
+
+static int nvme_rdma_alloc_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	int ret;
+
+	ret = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	if (ret)
+		return ret;
+
+	ctrl->device = ctrl->queues[0].device;
+	ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
+		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
+	ctrl->ctrl.max_hw_sectors =
+		(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
+
+	ret = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
+		&ctrl->async_event_sqe, sizeof(struct nvme_command),
+		DMA_TO_DEVICE);
+	if (ret)
+		goto out_free_queue;
+
+	return 0;
+
+out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
+	return ret;
 }
 
 static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
@@ -764,7 +793,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	int error;
 
-	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	error = nvme_rdma_alloc_admin_queue(&ctrl->ctrl);
 	if (error)
 		return error;
 
@@ -784,7 +813,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 			goto out_free_queue;
 	}
 
-	error = nvme_rdma_start_queue(ctrl, 0);
+	error = nvme_rdma_start_admin_queue(&ctrl->ctrl);
 	if (error)
 		goto out_cleanup_queue;
 
@@ -816,7 +845,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (new)
 		nvme_rdma_free_tagset(&ctrl->ctrl, true);
 out_free_queue:
-	nvme_rdma_free_queue(&ctrl->queues[0]);
+	nvme_rdma_free_admin_queue(&ctrl->ctrl);
 	return error;
 }
 
@@ -976,7 +1005,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 		nvme_rdma_stop_io_queues(ctrl);
 	}
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_admin_queue(&ctrl->ctrl);
 
 	/* We must take care of fastfail/requeue all our inflight requests */
 	if (ctrl->ctrl.queue_count > 1)
-- 
2.7.4

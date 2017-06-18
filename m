Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52070 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdFRPWP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:15 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 02/30] nvme-rdma: Don't alloc/free the tagset on reset
Date: Sun, 18 Jun 2017 18:21:36 +0300
Message-Id: <1497799324-19598-3-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Also the admin and admin_connect request queues. This
is not something we should do on controller resets.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 118 ++++++++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 53 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cb7f81d9098f..3e4c6aa119ee 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -656,15 +656,19 @@ static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl, bool remove)
 {
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	if (remove) {
+		blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
+		blk_cleanup_queue(ctrl->ctrl.admin_q);
+		blk_mq_free_tag_set(&ctrl->admin_tag_set);
+		nvme_rdma_dev_put(ctrl->device);
+	}
+
 	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
-	nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
-	blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
-	nvme_rdma_dev_put(ctrl->device);
+	nvme_rdma_free_queue(&ctrl->queues[0]);
 }
 
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
@@ -1542,7 +1546,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int error;
 
@@ -1551,43 +1555,44 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 		return error;
 
 	ctrl->device = ctrl->queues[0].device;
-
-	/*
-	 * We need a reference on the device as long as the tag_set is alive,
-	 * as the MRs in the request structures need a valid ib_device.
-	 */
-	error = -EINVAL;
-	if (!nvme_rdma_dev_get(ctrl->device))
-		goto out_free_queue;
-
 	ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
 		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
 
-	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
-	ctrl->admin_tag_set.ops = &nvme_rdma_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
-	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
-	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
-		SG_CHUNK_SIZE * sizeof(struct scatterlist);
-	ctrl->admin_tag_set.driver_data = ctrl;
-	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
-
-	error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
-	if (error)
-		goto out_put_dev;
-
-	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-	if (IS_ERR(ctrl->ctrl.admin_q)) {
-		error = PTR_ERR(ctrl->ctrl.admin_q);
-		goto out_free_tagset;
-	}
+	if (new) {
+		/*
+		 * We need a reference on the device as long as the tag_set is alive,
+		 * as the MRs in the request structures need a valid ib_device.
+		 */
+		error = -EINVAL;
+		if (!nvme_rdma_dev_get(ctrl->device))
+			goto out_free_queue;
+
+		memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
+		ctrl->admin_tag_set.ops = &nvme_rdma_admin_mq_ops;
+		ctrl->admin_tag_set.queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
+		ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
+		ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
+		ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
+			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		ctrl->admin_tag_set.driver_data = ctrl;
+		ctrl->admin_tag_set.nr_hw_queues = 1;
+		ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
+
+		error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
+		if (error)
+			goto out_put_dev;
+
+		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+		if (IS_ERR(ctrl->ctrl.admin_q)) {
+			error = PTR_ERR(ctrl->ctrl.admin_q);
+			goto out_free_tagset;
+		}
 
-	ctrl->ctrl.admin_connect_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-	if (IS_ERR(ctrl->ctrl.admin_connect_q)) {
-		error = PTR_ERR(ctrl->ctrl.admin_connect_q);
-		goto out_cleanup_queue;
+		ctrl->ctrl.admin_connect_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+		if (IS_ERR(ctrl->ctrl.admin_connect_q)) {
+			error = PTR_ERR(ctrl->ctrl.admin_connect_q);
+			goto out_cleanup_queue;
+		}
 	}
 
 	error = nvmf_connect_admin_queue(&ctrl->ctrl);
@@ -1596,6 +1601,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 
 	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
 
+	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
+
 	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->cap);
 	if (error) {
 		dev_err(ctrl->ctrl.device,
@@ -1628,21 +1635,26 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	return 0;
 
 out_cleanup_connect_queue:
-	blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
+	if (new)
+		blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
 out_cleanup_queue:
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
+	if (new)
+		blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_tagset:
-	/* disconnect and drain the queue before freeing the tagset */
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
+	if (new) {
+		/* disconnect and drain the queue before freeing the tagset */
+		nvme_rdma_stop_queue(&ctrl->queues[0]);
+		blk_mq_free_tag_set(&ctrl->admin_tag_set);
+	}
 out_put_dev:
-	nvme_rdma_dev_put(ctrl->device);
+	if (new)
+		nvme_rdma_dev_put(ctrl->device);
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
 }
 
-static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	cancel_work_sync(&ctrl->err_work);
@@ -1661,14 +1673,14 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl);
+	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
 }
 
 static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	if (shutdown)
-		nvme_rdma_shutdown_ctrl(ctrl);
+		nvme_rdma_shutdown_ctrl(ctrl, shutdown);
 
 	if (ctrl->ctrl.tagset) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
@@ -1731,9 +1743,9 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	int ret;
 	bool changed;
 
-	nvme_rdma_shutdown_ctrl(ctrl);
+	nvme_rdma_shutdown_ctrl(ctrl, false);
 
-	ret = nvme_rdma_configure_admin_queue(ctrl);
+	ret = nvme_rdma_configure_admin_queue(ctrl, false);
 	if (ret) {
 		/* ctrl is already shutdown, just remove the ctrl */
 		INIT_WORK(&ctrl->delete_work, nvme_rdma_remove_ctrl_work);
@@ -1898,7 +1910,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_uninit_ctrl;
 
-	ret = nvme_rdma_configure_admin_queue(ctrl);
+	ret = nvme_rdma_configure_admin_queue(ctrl, true);
 	if (ret)
 		goto out_kfree_queues;
 
@@ -1959,7 +1971,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 
 out_remove_admin_queue:
 	nvme_stop_keep_alive(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl);
+	nvme_rdma_destroy_admin_queue(ctrl, true);
 out_kfree_queues:
 	kfree(ctrl->queues);
 out_uninit_ctrl:
-- 
2.7.4

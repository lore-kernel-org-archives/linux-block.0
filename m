Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753113AbdFRPWP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:15 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 03/30] nvme-rdma: reuse configure/destroy admin queue
Date: Sun, 18 Jun 2017 18:21:37 +0300
Message-Id: <1497799324-19598-4-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We have all we need in these functions now that these
are aware if we are doing a full instantiation/removal.

For that we move nvme_rdma_configure_admin_queue to avoid
a forward declaration, and we add blk_mq_ops forward declaration.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 253 ++++++++++++++++++++++-------------------------
 1 file changed, 119 insertions(+), 134 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e4c6aa119ee..5fef5545e365 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -140,6 +140,9 @@ static DEFINE_MUTEX(device_list_mutex);
 static LIST_HEAD(nvme_rdma_ctrl_list);
 static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
 
+static const struct blk_mq_ops nvme_rdma_mq_ops;
+static const struct blk_mq_ops nvme_rdma_admin_mq_ops;
+
 /*
  * Disabling this option makes small I/O goes faster, but is fundamentally
  * unsafe.  With it turned off we will have to register a global rkey that
@@ -562,20 +565,22 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 
 static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 {
+	if (test_bit(NVME_RDMA_Q_DELETING, &queue->flags))
+		return;
 	rdma_disconnect(queue->cm_id);
 	ib_drain_qp(queue->qp);
 }
 
 static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 {
+	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
+		return;
 	nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
 }
 
 static void nvme_rdma_stop_and_free_queue(struct nvme_rdma_queue *queue)
 {
-	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
-		return;
 	nvme_rdma_stop_queue(queue);
 	nvme_rdma_free_queue(queue);
 }
@@ -671,6 +676,116 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl, bool remo
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 }
 
+static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new)
+{
+	int error;
+
+	error = nvme_rdma_init_queue(ctrl, 0, NVME_AQ_DEPTH);
+	if (error)
+		return error;
+
+	ctrl->device = ctrl->queues[0].device;
+	ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
+		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
+
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
+
+		ctrl->ctrl.admin_connect_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+		if (IS_ERR(ctrl->ctrl.admin_connect_q)) {
+			error = PTR_ERR(ctrl->ctrl.admin_connect_q);
+			goto out_cleanup_queue;
+		}
+	} else {
+		error = blk_mq_reinit_tagset(&ctrl->admin_tag_set);
+		if (error)
+			goto out_free_queue;
+	}
+
+	error = nvmf_connect_admin_queue(&ctrl->ctrl);
+	if (error)
+		goto out_cleanup_connect_queue;
+
+	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
+
+	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->cap);
+	if (error) {
+		dev_err(ctrl->ctrl.device,
+			"prop_get NVME_REG_CAP failed\n");
+		goto out_cleanup_connect_queue;
+	}
+
+	ctrl->ctrl.sqsize =
+		min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->ctrl.sqsize);
+
+	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
+	if (error)
+		goto out_cleanup_connect_queue;
+
+	ctrl->ctrl.max_hw_sectors =
+		(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
+
+	error = nvme_init_identify(&ctrl->ctrl);
+	if (error)
+		goto out_cleanup_connect_queue;
+
+	error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
+			&ctrl->async_event_sqe, sizeof(struct nvme_command),
+			DMA_TO_DEVICE);
+	if (error)
+		goto out_cleanup_connect_queue;
+
+	nvme_start_keep_alive(&ctrl->ctrl);
+
+	return 0;
+
+out_cleanup_connect_queue:
+	if (new)
+		blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
+out_cleanup_queue:
+	if (new)
+		blk_cleanup_queue(ctrl->ctrl.admin_q);
+out_free_tagset:
+	if (new) {
+		/* disconnect and drain the queue before freeing the tagset */
+		nvme_rdma_stop_queue(&ctrl->queues[0]);
+		blk_mq_free_tag_set(&ctrl->admin_tag_set);
+	}
+out_put_dev:
+	if (new)
+		nvme_rdma_dev_put(ctrl->device);
+out_free_queue:
+	nvme_rdma_free_queue(&ctrl->queues[0]);
+	return error;
+}
+
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -725,28 +840,12 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 			goto requeue;
 	}
 
-	nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
+	nvme_rdma_destroy_admin_queue(ctrl, false);
 
-	ret = blk_mq_reinit_tagset(&ctrl->admin_tag_set);
-	if (ret)
-		goto requeue;
-
-	ret = nvme_rdma_init_queue(ctrl, 0, NVME_AQ_DEPTH);
-	if (ret)
-		goto requeue;
-
-	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
-	if (ret)
-		goto requeue;
-
-	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
-
-	ret = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
+	ret = nvme_rdma_configure_admin_queue(ctrl, false);
 	if (ret)
 		goto requeue;
 
-	nvme_start_keep_alive(&ctrl->ctrl);
-
 	if (ctrl->queue_count > 1) {
 		ret = nvme_rdma_init_io_queues(ctrl);
 		if (ret)
@@ -760,12 +859,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 	ctrl->ctrl.nr_reconnects = 0;
-
-	if (ctrl->queue_count > 1) {
-		nvme_queue_scan(&ctrl->ctrl);
-		nvme_queue_async_events(&ctrl->ctrl);
-	}
-
 	dev_info(ctrl->ctrl.device, "Successfully reconnected\n");
 
 	return;
@@ -1546,114 +1639,6 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new)
-{
-	int error;
-
-	error = nvme_rdma_init_queue(ctrl, 0, NVME_AQ_DEPTH);
-	if (error)
-		return error;
-
-	ctrl->device = ctrl->queues[0].device;
-	ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
-		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
-
-	if (new) {
-		/*
-		 * We need a reference on the device as long as the tag_set is alive,
-		 * as the MRs in the request structures need a valid ib_device.
-		 */
-		error = -EINVAL;
-		if (!nvme_rdma_dev_get(ctrl->device))
-			goto out_free_queue;
-
-		memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
-		ctrl->admin_tag_set.ops = &nvme_rdma_admin_mq_ops;
-		ctrl->admin_tag_set.queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
-		ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
-		ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
-		ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
-			SG_CHUNK_SIZE * sizeof(struct scatterlist);
-		ctrl->admin_tag_set.driver_data = ctrl;
-		ctrl->admin_tag_set.nr_hw_queues = 1;
-		ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
-
-		error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
-		if (error)
-			goto out_put_dev;
-
-		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-		if (IS_ERR(ctrl->ctrl.admin_q)) {
-			error = PTR_ERR(ctrl->ctrl.admin_q);
-			goto out_free_tagset;
-		}
-
-		ctrl->ctrl.admin_connect_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-		if (IS_ERR(ctrl->ctrl.admin_connect_q)) {
-			error = PTR_ERR(ctrl->ctrl.admin_connect_q);
-			goto out_cleanup_queue;
-		}
-	}
-
-	error = nvmf_connect_admin_queue(&ctrl->ctrl);
-	if (error)
-		goto out_cleanup_connect_queue;
-
-	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
-
-	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
-
-	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->cap);
-	if (error) {
-		dev_err(ctrl->ctrl.device,
-			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_connect_queue;
-	}
-
-	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->ctrl.sqsize);
-
-	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
-	if (error)
-		goto out_cleanup_connect_queue;
-
-	ctrl->ctrl.max_hw_sectors =
-		(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
-
-	error = nvme_init_identify(&ctrl->ctrl);
-	if (error)
-		goto out_cleanup_connect_queue;
-
-	error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
-			&ctrl->async_event_sqe, sizeof(struct nvme_command),
-			DMA_TO_DEVICE);
-	if (error)
-		goto out_cleanup_connect_queue;
-
-	nvme_start_keep_alive(&ctrl->ctrl);
-
-	return 0;
-
-out_cleanup_connect_queue:
-	if (new)
-		blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
-out_cleanup_queue:
-	if (new)
-		blk_cleanup_queue(ctrl->ctrl.admin_q);
-out_free_tagset:
-	if (new) {
-		/* disconnect and drain the queue before freeing the tagset */
-		nvme_rdma_stop_queue(&ctrl->queues[0]);
-		blk_mq_free_tag_set(&ctrl->admin_tag_set);
-	}
-out_put_dev:
-	if (new)
-		nvme_rdma_dev_put(ctrl->device);
-out_free_queue:
-	nvme_rdma_free_queue(&ctrl->queues[0]);
-	return error;
-}
-
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	nvme_stop_keep_alive(&ctrl->ctrl);
-- 
2.7.4

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52078 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbdFRPWQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:16 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 04/30] nvme-rdma: introduce configure/destroy io queues
Date: Sun, 18 Jun 2017 18:21:38 +0300
Message-Id: <1497799324-19598-5-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

simlar to how we handle the admin queue.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 193 +++++++++++++++++++++++------------------------
 1 file changed, 96 insertions(+), 97 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5fef5545e365..bbe39dd378b5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -579,18 +579,31 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 	rdma_destroy_id(queue->cm_id);
 }
 
-static void nvme_rdma_stop_and_free_queue(struct nvme_rdma_queue *queue)
+static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
-	nvme_rdma_stop_queue(queue);
-	nvme_rdma_free_queue(queue);
+	int i;
+
+	for (i = 1; i < ctrl->queue_count; i++)
+		nvme_rdma_free_queue(&ctrl->queues[i]);
 }
 
-static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_rdma_stop_and_free_queue(&ctrl->queues[i]);
+		nvme_rdma_stop_queue(&ctrl->queues[i]);
+}
+
+static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl, bool remove)
+{
+	nvme_rdma_stop_io_queues(ctrl);
+	if (remove) {
+		blk_cleanup_queue(ctrl->ctrl.connect_q);
+		blk_mq_free_tag_set(&ctrl->tag_set);
+		nvme_rdma_dev_put(ctrl->device);
+	}
+	nvme_rdma_free_io_queues(ctrl);
 }
 
 static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
@@ -602,15 +615,15 @@ static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
 		if (ret) {
 			dev_info(ctrl->ctrl.device,
 				"failed to connect i/o queue: %d\n", ret);
-			goto out_free_queues;
+			goto out_stop_queues;
 		}
 		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
 	return 0;
 
-out_free_queues:
-	nvme_rdma_free_io_queues(ctrl);
+out_stop_queues:
+	nvme_rdma_stop_io_queues(ctrl);
 	return ret;
 }
 
@@ -656,8 +669,73 @@ static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 out_free_queues:
 	for (i--; i >= 1; i--)
-		nvme_rdma_stop_and_free_queue(&ctrl->queues[i]);
+		nvme_rdma_free_queue(&ctrl->queues[i]);
+
+	return ret;
+}
+
+static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
+{
+	int ret;
 
+	ret = nvme_rdma_init_io_queues(ctrl);
+	if (ret)
+		return ret;
+
+	if (new) {
+		/*
+		 * We need a reference on the device as long as the tag_set is alive,
+		 * as the MRs in the request structures need a valid ib_device.
+		 */
+		ret = -EINVAL;
+		if (!nvme_rdma_dev_get(ctrl->device))
+			goto out_free_io_queues;
+
+		memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
+		ctrl->tag_set.ops = &nvme_rdma_mq_ops;
+		ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
+		ctrl->tag_set.reserved_tags = 1; /* fabric connect */
+		ctrl->tag_set.numa_node = NUMA_NO_NODE;
+		ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+		ctrl->tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
+			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		ctrl->tag_set.driver_data = ctrl;
+		ctrl->tag_set.nr_hw_queues = ctrl->queue_count - 1;
+		ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
+
+		ret = blk_mq_alloc_tag_set(&ctrl->tag_set);
+		if (ret)
+			goto out_put_dev;
+		ctrl->ctrl.tagset = &ctrl->tag_set;
+
+		ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
+		if (IS_ERR(ctrl->ctrl.connect_q)) {
+			ret = PTR_ERR(ctrl->ctrl.connect_q);
+			goto out_free_tag_set;
+		}
+	} else {
+		ret = blk_mq_reinit_tagset(&ctrl->tag_set);
+		if (ret)
+			goto out_free_io_queues;
+	}
+
+	ret = nvme_rdma_connect_io_queues(ctrl);
+	if (ret)
+		goto out_cleanup_connect_q;
+
+	return 0;
+
+out_cleanup_connect_q:
+	if (new)
+		blk_cleanup_queue(ctrl->ctrl.connect_q);
+out_free_tag_set:
+	if (new)
+		blk_mq_free_tag_set(&ctrl->tag_set);
+out_put_dev:
+	if (new)
+		nvme_rdma_dev_put(ctrl->device);
+out_free_io_queues:
+	nvme_rdma_free_io_queues(ctrl);
 	return ret;
 }
 
@@ -832,13 +910,8 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 
 	++ctrl->ctrl.nr_reconnects;
 
-	if (ctrl->queue_count > 1) {
-		nvme_rdma_free_io_queues(ctrl);
-
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set);
-		if (ret)
-			goto requeue;
-	}
+	if (ctrl->ctrl.opts->nr_io_queues)
+		nvme_rdma_destroy_io_queues(ctrl, false);
 
 	nvme_rdma_destroy_admin_queue(ctrl, false);
 
@@ -846,12 +919,8 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto requeue;
 
-	if (ctrl->queue_count > 1) {
-		ret = nvme_rdma_init_io_queues(ctrl);
-		if (ret)
-			goto requeue;
-
-		ret = nvme_rdma_connect_io_queues(ctrl);
+	if (ctrl->ctrl.opts->nr_io_queues) {
+		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
 			goto requeue;
 	}
@@ -1645,11 +1714,11 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 
-	if (ctrl->queue_count > 1) {
+	if (ctrl->ctrl.opts->nr_io_queues) {
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
-		nvme_rdma_free_io_queues(ctrl);
+		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
 
 	if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags))
@@ -1667,12 +1736,6 @@ static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	if (shutdown)
 		nvme_rdma_shutdown_ctrl(ctrl, shutdown);
 
-	if (ctrl->ctrl.tagset) {
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
-		blk_mq_free_tag_set(&ctrl->tag_set);
-		nvme_rdma_dev_put(ctrl->device);
-	}
-
 	nvme_put_ctrl(&ctrl->ctrl);
 }
 
@@ -1737,16 +1800,8 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		goto del_dead_ctrl;
 	}
 
-	if (ctrl->queue_count > 1) {
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set);
-		if (ret)
-			goto del_dead_ctrl;
-
-		ret = nvme_rdma_init_io_queues(ctrl);
-		if (ret)
-			goto del_dead_ctrl;
-
-		ret = nvme_rdma_connect_io_queues(ctrl);
+	if (ctrl->ctrl.opts->nr_io_queues) {
+		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
 			goto del_dead_ctrl;
 	}
@@ -1782,62 +1837,6 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address		= nvmf_get_address,
 };
 
-static int nvme_rdma_create_io_queues(struct nvme_rdma_ctrl *ctrl)
-{
-	int ret;
-
-	ret = nvme_rdma_init_io_queues(ctrl);
-	if (ret)
-		return ret;
-
-	/*
-	 * We need a reference on the device as long as the tag_set is alive,
-	 * as the MRs in the request structures need a valid ib_device.
-	 */
-	ret = -EINVAL;
-	if (!nvme_rdma_dev_get(ctrl->device))
-		goto out_free_io_queues;
-
-	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
-	ctrl->tag_set.ops = &nvme_rdma_mq_ops;
-	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
-	ctrl->tag_set.numa_node = NUMA_NO_NODE;
-	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	ctrl->tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
-		SG_CHUNK_SIZE * sizeof(struct scatterlist);
-	ctrl->tag_set.driver_data = ctrl;
-	ctrl->tag_set.nr_hw_queues = ctrl->queue_count - 1;
-	ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
-
-	ret = blk_mq_alloc_tag_set(&ctrl->tag_set);
-	if (ret)
-		goto out_put_dev;
-	ctrl->ctrl.tagset = &ctrl->tag_set;
-
-	ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-	if (IS_ERR(ctrl->ctrl.connect_q)) {
-		ret = PTR_ERR(ctrl->ctrl.connect_q);
-		goto out_free_tag_set;
-	}
-
-	ret = nvme_rdma_connect_io_queues(ctrl);
-	if (ret)
-		goto out_cleanup_connect_q;
-
-	return 0;
-
-out_cleanup_connect_q:
-	blk_cleanup_queue(ctrl->ctrl.connect_q);
-out_free_tag_set:
-	blk_mq_free_tag_set(&ctrl->tag_set);
-out_put_dev:
-	nvme_rdma_dev_put(ctrl->device);
-out_free_io_queues:
-	nvme_rdma_free_io_queues(ctrl);
-	return ret;
-}
-
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -1930,7 +1929,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	}
 
 	if (opts->nr_io_queues) {
-		ret = nvme_rdma_create_io_queues(ctrl);
+		ret = nvme_rdma_configure_io_queues(ctrl, true);
 		if (ret)
 			goto out_remove_admin_queue;
 	}
-- 
2.7.4

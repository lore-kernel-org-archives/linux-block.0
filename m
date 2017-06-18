Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52174 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:32 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 16/30] nvme-rdma: move tagset allocation to a dedicated routine
Date: Sun, 18 Jun 2017 18:21:50 +0300
Message-Id: <1497799324-19598-17-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 148 ++++++++++++++++++++++++++---------------------
 1 file changed, 83 insertions(+), 65 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 700aef42c4f2..c1ffdb823cbb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -506,6 +506,72 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
+static void nvme_rdma_free_tagset(struct nvme_ctrl *nctrl, bool admin)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct blk_mq_tag_set *set = admin ?
+			&ctrl->admin_tag_set : &ctrl->tag_set;
+
+	nvme_rdma_dev_put(ctrl->device);
+	blk_mq_free_tag_set(set);
+}
+
+static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
+		bool admin)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct blk_mq_tag_set *set;
+	int ret;
+
+	if (admin) {
+		set = &ctrl->admin_tag_set;
+		memset(set, 0, sizeof(*set));
+		set->ops = &nvme_rdma_admin_mq_ops;
+		set->queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
+		set->reserved_tags = 2; /* connect + keep-alive */
+		set->numa_node = NUMA_NO_NODE;
+		set->cmd_size = sizeof(struct nvme_rdma_request) +
+			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		set->driver_data = ctrl;
+		set->nr_hw_queues = 1;
+		set->timeout = ADMIN_TIMEOUT;
+	} else {
+		set = &ctrl->tag_set;
+		memset(set, 0, sizeof(*set));
+		set->ops = &nvme_rdma_mq_ops;
+		set->queue_depth = nctrl->opts->queue_size;
+		set->reserved_tags = 1; /* fabric connect */
+		set->numa_node = NUMA_NO_NODE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		set->cmd_size = sizeof(struct nvme_rdma_request) +
+			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		set->driver_data = ctrl;
+		set->nr_hw_queues = nctrl->queue_count - 1;
+		set->timeout = NVME_IO_TIMEOUT;
+	}
+
+	ret = blk_mq_alloc_tag_set(set);
+	if (ret)
+		goto out;
+
+	/*
+	 * We need a reference on the device as long as the tag_set is alive,
+	 * as the MRs in the request structures need a valid ib_device.
+	 */
+	ret = nvme_rdma_dev_get(ctrl->device);
+	if (!ret) {
+		ret = -EINVAL;
+		goto out_free_tagset;
+	}
+
+	return set;
+
+out_free_tagset:
+	blk_mq_free_tag_set(set);
+out:
+	return ERR_PTR(ret);
+}
+
 static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 		int idx, size_t queue_size)
 {
@@ -602,8 +668,7 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl, bool remove
 	nvme_rdma_stop_io_queues(ctrl);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
-		blk_mq_free_tag_set(&ctrl->tag_set);
-		nvme_rdma_dev_put(ctrl->device);
+		nvme_rdma_free_tagset(&ctrl->ctrl, false);
 	}
 	nvme_rdma_free_io_queues(ctrl);
 }
@@ -694,38 +759,19 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		return ret;
 
 	if (new) {
-		/*
-		 * We need a reference on the device as long as the tag_set is alive,
-		 * as the MRs in the request structures need a valid ib_device.
-		 */
-		ret = -EINVAL;
-		if (!nvme_rdma_dev_get(ctrl->device))
+		ctrl->ctrl.tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, false);
+		if (IS_ERR(ctrl->ctrl.tagset)) {
+			ret = PTR_ERR(ctrl->ctrl.tagset);
 			goto out_free_io_queues;
+		}
 
-		memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
-		ctrl->tag_set.ops = &nvme_rdma_mq_ops;
-		ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-		ctrl->tag_set.reserved_tags = 1; /* fabric connect */
-		ctrl->tag_set.numa_node = NUMA_NO_NODE;
-		ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-		ctrl->tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
-			SG_CHUNK_SIZE * sizeof(struct scatterlist);
-		ctrl->tag_set.driver_data = ctrl;
-		ctrl->tag_set.nr_hw_queues = ctrl->ctrl.max_queues - 1;
-		ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
-
-		ret = blk_mq_alloc_tag_set(&ctrl->tag_set);
-		if (ret)
-			goto out_put_dev;
-		ctrl->ctrl.tagset = &ctrl->tag_set;
-
-		ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
+		ctrl->ctrl.connect_q = blk_mq_init_queue(ctrl->ctrl.tagset);
 		if (IS_ERR(ctrl->ctrl.connect_q)) {
 			ret = PTR_ERR(ctrl->ctrl.connect_q);
 			goto out_free_tag_set;
 		}
 	} else {
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set);
+		ret = blk_mq_reinit_tagset(ctrl->ctrl.tagset);
 		if (ret)
 			goto out_free_io_queues;
 	}
@@ -741,10 +787,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
 	if (new)
-		blk_mq_free_tag_set(&ctrl->tag_set);
-out_put_dev:
-	if (new)
-		nvme_rdma_dev_put(ctrl->device);
+		nvme_rdma_free_tagset(&ctrl->ctrl, false);
 out_free_io_queues:
 	nvme_rdma_free_io_queues(ctrl);
 	return ret;
@@ -756,8 +799,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl, bool remo
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
-		blk_mq_free_tag_set(&ctrl->admin_tag_set);
-		nvme_rdma_dev_put(ctrl->device);
+		nvme_rdma_free_tagset(&ctrl->ctrl, true);
 	}
 
 	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
@@ -778,43 +820,25 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
 
 	if (new) {
-		/*
-		 * We need a reference on the device as long as the tag_set is alive,
-		 * as the MRs in the request structures need a valid ib_device.
-		 */
-		error = -EINVAL;
-		if (!nvme_rdma_dev_get(ctrl->device))
+		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
+		if (IS_ERR(ctrl->ctrl.admin_tagset)) {
+			error = PTR_ERR(ctrl->ctrl.admin_tagset);
 			goto out_free_queue;
+		}
 
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
-		ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
-
-		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+		ctrl->ctrl.admin_q = blk_mq_init_queue(ctrl->ctrl.admin_tagset);
 		if (IS_ERR(ctrl->ctrl.admin_q)) {
 			error = PTR_ERR(ctrl->ctrl.admin_q);
 			goto out_free_tagset;
 		}
 
-		ctrl->ctrl.admin_connect_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+		ctrl->ctrl.admin_connect_q = blk_mq_init_queue(ctrl->ctrl.admin_tagset);
 		if (IS_ERR(ctrl->ctrl.admin_connect_q)) {
 			error = PTR_ERR(ctrl->ctrl.admin_connect_q);
 			goto out_cleanup_queue;
 		}
 	} else {
-		error = blk_mq_reinit_tagset(&ctrl->admin_tag_set);
+		error = blk_mq_reinit_tagset(ctrl->ctrl.admin_tagset);
 		if (error)
 			goto out_free_queue;
 	}
@@ -861,14 +885,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_tagset:
-	if (new) {
-		/* disconnect and drain the queue before freeing the tagset */
-		nvme_rdma_stop_queue(ctrl, 0);
-		blk_mq_free_tag_set(&ctrl->admin_tag_set);
-	}
-out_put_dev:
 	if (new)
-		nvme_rdma_dev_put(ctrl->device);
+		nvme_rdma_free_tagset(&ctrl->ctrl, true);
 out_free_queue:
 	nvme_rdma_free_queue(ctrl, 0);
 	return error;
-- 
2.7.4

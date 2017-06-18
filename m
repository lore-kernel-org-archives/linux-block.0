Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52232 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:41 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 23/30] nvme: add low level queue and tagset controller ops
Date: Sun, 18 Jun 2017 18:21:57 +0300
Message-Id: <1497799324-19598-24-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a preparation for moving a lot of the shared control
plane logic to the nvme core.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/nvme.h | 10 ++++++++++
 drivers/nvme/host/rdma.c | 46 +++++++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c604d471aa3d..18aac677a96c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -233,6 +233,16 @@ struct nvme_ctrl_ops {
 	int (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	const char *(*get_subsysnqn)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+
+	int (*alloc_hw_queue)(struct nvme_ctrl *ctrl, int idx,
+		size_t queue_size);
+	void (*free_hw_queue)(struct nvme_ctrl *ctrl, int idx);
+	int (*start_hw_queue)(struct nvme_ctrl *ctrl, int idx);
+	void (*stop_hw_queue)(struct nvme_ctrl *ctrl, int idx);
+	struct blk_mq_tag_set *(*alloc_tagset)(struct nvme_ctrl *ctrl,
+		bool admin);
+	void (*free_tagset)(struct nvme_ctrl *ctrl, bool admin);
+	int (*verify_ctrl)(struct nvme_ctrl *ctrl);
 };
 
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0036ddcbc138..a32c8a710ad4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -679,7 +679,7 @@ static void nvme_rdma_free_io_queues(struct nvme_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_rdma_free_queue(ctrl, i);
+		ctrl->ops->free_hw_queue(ctrl, i);
 }
 
 static void nvme_rdma_stop_io_queues(struct nvme_ctrl *ctrl)
@@ -687,7 +687,7 @@ static void nvme_rdma_stop_io_queues(struct nvme_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_rdma_stop_queue(ctrl, i);
+		ctrl->ops->stop_hw_queue(ctrl, i);
 }
 
 static void nvme_rdma_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
@@ -695,7 +695,7 @@ static void nvme_rdma_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
 	nvme_rdma_stop_io_queues(ctrl);
 	if (remove) {
 		blk_cleanup_queue(ctrl->connect_q);
-		nvme_rdma_free_tagset(ctrl, false);
+		ctrl->ops->free_tagset(ctrl, false);
 	}
 	nvme_rdma_free_io_queues(ctrl);
 }
@@ -723,7 +723,7 @@ static int nvme_rdma_start_io_queues(struct nvme_ctrl *ctrl)
 	int i, ret = 0;
 
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_rdma_start_queue(ctrl, i);
+		ret = ctrl->ops->start_hw_queue(ctrl, i);
 		if (ret)
 			goto out_stop_queues;
 	}
@@ -732,7 +732,7 @@ static int nvme_rdma_start_io_queues(struct nvme_ctrl *ctrl)
 
 out_stop_queues:
 	for (i--; i >= 1; i--)
-		nvme_rdma_stop_queue(ctrl, i);
+		ctrl->ops->stop_hw_queue(ctrl, i);
 	return ret;
 }
 
@@ -754,7 +754,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_ctrl *ctrl)
 		"creating %d I/O queues.\n", nr_io_queues);
 
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_rdma_alloc_queue(ctrl, i,
+		ret = ctrl->ops->alloc_hw_queue(ctrl, i,
 				ctrl->sqsize + 1);
 		if (ret)
 			goto out_free_queues;
@@ -764,7 +764,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_ctrl *ctrl)
 
 out_free_queues:
 	for (i--; i >= 1; i--)
-		nvme_rdma_free_queue(ctrl, i);
+		ctrl->ops->free_hw_queue(ctrl, i);
 
 	return ret;
 }
@@ -778,7 +778,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		return ret;
 
 	if (new) {
-		ctrl->tagset = nvme_rdma_alloc_tagset(ctrl, false);
+		ctrl->tagset = ctrl->ops->alloc_tagset(ctrl, false);
 		if (IS_ERR(ctrl->tagset)) {
 			ret = PTR_ERR(ctrl->tagset);
 			goto out_free_io_queues;
@@ -806,7 +806,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		blk_cleanup_queue(ctrl->connect_q);
 out_free_tag_set:
 	if (new)
-		nvme_rdma_free_tagset(ctrl, false);
+		ctrl->ops->free_tagset(ctrl, false);
 out_free_io_queues:
 	nvme_rdma_free_io_queues(ctrl);
 	return ret;
@@ -814,25 +814,25 @@ static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 static void nvme_rdma_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
-	nvme_rdma_stop_queue(ctrl, 0);
+	ctrl->ops->stop_hw_queue(ctrl, 0);
 	if (remove) {
 		blk_cleanup_queue(ctrl->admin_connect_q);
 		blk_cleanup_queue(ctrl->admin_q);
-		nvme_rdma_free_tagset(ctrl, true);
+		ctrl->ops->free_tagset(ctrl, true);
 	}
-	nvme_rdma_free_queue(ctrl, 0);
+	ctrl->ops->free_hw_queue(ctrl, 0);
 }
 
 static int nvme_rdma_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 {
 	int error;
 
-	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	error = ctrl->ops->alloc_hw_queue(ctrl, 0, NVME_AQ_DEPTH);
 	if (error)
 		return error;
 
 	if (new) {
-		ctrl->admin_tagset = nvme_rdma_alloc_tagset(ctrl, true);
+		ctrl->admin_tagset = ctrl->ops->alloc_tagset(ctrl, true);
 		if (IS_ERR(ctrl->admin_tagset)) {
 			error = PTR_ERR(ctrl->admin_tagset);
 			goto out_free_queue;
@@ -855,7 +855,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 			goto out_free_queue;
 	}
 
-	error = nvme_rdma_start_queue(ctrl, 0);
+	error = ctrl->ops->start_hw_queue(ctrl, 0);
 	if (error)
 		goto out_cleanup_connect_queue;
 
@@ -889,9 +889,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 		blk_cleanup_queue(ctrl->admin_q);
 out_free_tagset:
 	if (new)
-		nvme_rdma_free_tagset(ctrl, true);
+		ctrl->ops->free_tagset(ctrl, true);
 out_free_queue:
-	nvme_rdma_free_queue(ctrl, 0);
+	ctrl->ops->free_hw_queue(ctrl, 0);
 	return error;
 }
 
@@ -981,7 +981,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 		nvme_rdma_stop_io_queues(ctrl);
 	}
 	blk_mq_stop_hw_queues(ctrl->admin_q);
-	nvme_rdma_stop_queue(ctrl, 0);
+	ctrl->ops->stop_hw_queue(ctrl, 0);
 
 	/* We must take care of fastfail/requeue all our inflight requests */
 	if (ctrl->queue_count > 1)
@@ -1886,6 +1886,14 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.delete_ctrl		= nvme_rdma_del_ctrl,
 	.get_subsysnqn		= nvmf_get_subsysnqn,
 	.get_address		= nvmf_get_address,
+
+	.alloc_hw_queue		= nvme_rdma_alloc_queue,
+	.free_hw_queue		= nvme_rdma_free_queue,
+	.start_hw_queue		= nvme_rdma_start_queue,
+	.stop_hw_queue		= nvme_rdma_stop_queue,
+	.alloc_tagset		= nvme_rdma_alloc_tagset,
+	.free_tagset		= nvme_rdma_free_tagset,
+	.verify_ctrl		= nvme_rdma_verify_ctrl,
 };
 
 static int nvme_rdma_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
@@ -1910,7 +1918,7 @@ static int nvme_rdma_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_uninit_ctrl;
 
-	ret = nvme_rdma_verify_ctrl(ctrl);
+	ret = ctrl->ops->verify_ctrl(ctrl);
 	if (ret)
 		goto out_remove_admin_queue;
 
-- 
2.7.4

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:43628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753473AbdHOJwr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:47 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 08/12] nvme: add some ctrl ops for centralizing control plane logic.
Date: Tue, 15 Aug 2017 12:52:21 +0300
Message-Id: <1502790745-12569-9-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The goal is to move a larger portion of the logic to nvme
core, thus add admin/io queue and tagset callouts.

1. for queues we start with admin/io queues:
->alloc
->free
->start
->stop

we separate admin and IO mostly to allow pci driver
to free the queue in batches rather than one by one (to
speed up the process).

2. for tagset we have:
->alloc_tagset
->free_tagset

which accepts admin boolean.

3. we also has some misc ops:
->post_configure
->nr_hw_queues

And I think we'll have more as we go.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/nvme.h | 13 +++++++++
 drivers/nvme/host/rdma.c | 76 ++++++++++++++++++++++++++++--------------------
 2 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c52ba1405788..7b8e57b3e634 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -235,6 +235,19 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl, int aer_idx);
 	int (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	int (*alloc_admin_queue)(struct nvme_ctrl *ctrl);
+	void (*free_admin_queue)(struct nvme_ctrl *ctrl);
+	int (*start_admin_queue)(struct nvme_ctrl *ctrl);
+	void (*stop_admin_queue)(struct nvme_ctrl *ctrl);
+	int (*alloc_io_queues)(struct nvme_ctrl *ctrl);
+	void (*free_io_queues)(struct nvme_ctrl *ctrl);
+	int (*start_io_queues)(struct nvme_ctrl *ctrl);
+	void (*stop_io_queues)(struct nvme_ctrl *ctrl);
+	struct blk_mq_tag_set *(*alloc_tagset)(struct nvme_ctrl *ctrl,
+		bool admin);
+	void (*free_tagset)(struct nvme_ctrl *ctrl, bool admin);
+	int (*post_configure)(struct nvme_ctrl *ctrl);
+	unsigned int (*nr_hw_queues)(struct nvme_ctrl *ctrl);
 };
 
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b03c4a2a1172..cf4e4371c2db 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -757,12 +757,12 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 static void nvme_rdma_destroy_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	nvme_rdma_stop_admin_queue(ctrl);
+	ctrl->ops->stop_admin_queue(ctrl);
 	if (remove) {
 		blk_cleanup_queue(ctrl->admin_q);
-		nvme_rdma_free_tagset(ctrl, true);
+		ctrl->ops->free_tagset(ctrl, true);
 	}
-	nvme_rdma_free_admin_queue(ctrl);
+	ctrl->ops->free_admin_queue(ctrl);
 }
 
 static int nvme_rdma_alloc_admin_queue(struct nvme_ctrl *nctrl)
@@ -798,12 +798,12 @@ static int nvme_rdma_configure_admin_queue(struct nvme_ctrl *ctrl,
 {
 	int error;
 
-	error = nvme_rdma_alloc_admin_queue(ctrl);
+	error = ctrl->ops->alloc_admin_queue(ctrl);
 	if (error)
 		return error;
 
 	if (new) {
-		ctrl->admin_tagset = nvme_rdma_alloc_tagset(ctrl, true);
+		ctrl->admin_tagset = ctrl->ops->alloc_tagset(ctrl, true);
 		if (IS_ERR(ctrl->admin_tagset))
 			goto out_free_queue;
 
@@ -818,7 +818,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_ctrl *ctrl,
 			goto out_free_queue;
 	}
 
-	error = nvme_rdma_start_admin_queue(ctrl);
+	error = ctrl->ops->start_admin_queue(ctrl);
 	if (error)
 		goto out_cleanup_queue;
 
@@ -846,21 +846,21 @@ static int nvme_rdma_configure_admin_queue(struct nvme_ctrl *ctrl,
 		blk_cleanup_queue(ctrl->admin_q);
 out_free_tagset:
 	if (new)
-		nvme_rdma_free_tagset(ctrl, true);
+		ctrl->ops->free_tagset(ctrl, true);
 out_free_queue:
-	nvme_rdma_free_admin_queue(ctrl);
+	ctrl->ops->free_admin_queue(ctrl);
 	return error;
 }
 
 static void nvme_rdma_destroy_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	nvme_rdma_stop_io_queues(ctrl);
+	ctrl->ops->stop_io_queues(ctrl);
 	if (remove) {
 		blk_cleanup_queue(ctrl->connect_q);
-		nvme_rdma_free_tagset(ctrl, false);
+		ctrl->ops->free_tagset(ctrl, false);
 	}
-	nvme_rdma_free_io_queues(ctrl);
+	ctrl->ops->free_io_queues(ctrl);
 }
 
 static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
@@ -868,7 +868,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	unsigned int nr_io_queues;
 	int ret;
 
-	nr_io_queues = nvme_rdma_nr_io_queues(ctrl);
+	nr_io_queues = ctrl->ops->nr_hw_queues(ctrl);
 	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
@@ -880,12 +880,12 @@ static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	dev_info(ctrl->device,
 		"creating %d I/O queues.\n", nr_io_queues);
 
-	ret = nvme_rdma_alloc_io_queues(ctrl);
+	ret = ctrl->ops->alloc_io_queues(ctrl);
 	if (ret)
 		return ret;
 
 	if (new) {
-		ctrl->tagset = nvme_rdma_alloc_tagset(ctrl, false);
+		ctrl->tagset = ctrl->ops->alloc_tagset(ctrl, false);
 		if (IS_ERR(ctrl->tagset))
 			goto out_free_io_queues;
 
@@ -914,9 +914,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		blk_cleanup_queue(ctrl->connect_q);
 out_free_tag_set:
 	if (new)
-		nvme_rdma_free_tagset(ctrl, false);
+		ctrl->ops->free_tagset(ctrl, false);
 out_free_io_queues:
-	nvme_rdma_free_io_queues(ctrl);
+	ctrl->ops->free_io_queues(ctrl);
 	return ret;
 }
 
@@ -1005,10 +1005,10 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	if (ctrl->queue_count > 1) {
 		nvme_stop_queues(ctrl);
-		nvme_rdma_stop_io_queues(ctrl);
+		ctrl->ops->stop_io_queues(ctrl);
 	}
 	blk_mq_quiesce_queue(ctrl->admin_q);
-	nvme_rdma_stop_admin_queue(ctrl);
+	ctrl->ops->stop_admin_queue(ctrl);
 
 	/* We must take care of fastfail/requeue all our inflight requests */
 	if (ctrl->queue_count > 1)
@@ -1862,19 +1862,6 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_rdma_remove_ctrl(ctrl);
 }
 
-static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
-	.name			= "rdma",
-	.module			= THIS_MODULE,
-	.flags			= NVME_F_FABRICS,
-	.reg_read32		= nvmf_reg_read32,
-	.reg_read64		= nvmf_reg_read64,
-	.reg_write32		= nvmf_reg_write32,
-	.free_ctrl		= nvme_rdma_free_ctrl,
-	.submit_async_event	= nvme_rdma_submit_async_event,
-	.delete_ctrl		= nvme_rdma_del_ctrl,
-	.get_address		= nvmf_get_address,
-};
-
 static int nvme_rdma_post_configure(struct nvme_ctrl *ctrl)
 {
 	/* sanity check icdoff */
@@ -1908,6 +1895,31 @@ static int nvme_rdma_post_configure(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
+static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
+	.name			= "rdma",
+	.module			= THIS_MODULE,
+	.flags			= NVME_F_FABRICS,
+	.reg_read32		= nvmf_reg_read32,
+	.reg_read64		= nvmf_reg_read64,
+	.reg_write32		= nvmf_reg_write32,
+	.free_ctrl		= nvme_rdma_free_ctrl,
+	.submit_async_event	= nvme_rdma_submit_async_event,
+	.delete_ctrl		= nvme_rdma_del_ctrl,
+	.get_address		= nvmf_get_address,
+	.alloc_admin_queue	= nvme_rdma_alloc_admin_queue,
+	.free_admin_queue	= nvme_rdma_free_admin_queue,
+	.start_admin_queue	= nvme_rdma_start_admin_queue,
+	.stop_admin_queue	= nvme_rdma_stop_admin_queue,
+	.alloc_io_queues	= nvme_rdma_alloc_io_queues,
+	.free_io_queues		= nvme_rdma_free_io_queues,
+	.start_io_queues	= nvme_rdma_start_io_queues,
+	.stop_io_queues		= nvme_rdma_stop_io_queues,
+	.alloc_tagset		= nvme_rdma_alloc_tagset,
+	.free_tagset		= nvme_rdma_free_tagset,
+	.post_configure		= nvme_rdma_post_configure,
+	.nr_hw_queues		= nvme_rdma_nr_io_queues,
+};
+
 static int nvme_rdma_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks)
 {
@@ -1925,7 +1937,7 @@ static int nvme_rdma_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_uninit_ctrl;
 
-	ret = nvme_rdma_post_configure(ctrl);
+	ret = ctrl->ops->post_configure(ctrl);
 	if (ret)
 		goto out_remove_admin_queue;
 
-- 
2.7.4

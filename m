Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:36507 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753473AbdHOJws (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:48 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 09/12] nvme: move control plane handling to nvme core
Date: Tue, 15 Aug 2017 12:52:22 +0300
Message-Id: <1502790745-12569-10-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

handle controller setup (probe), reset and delete in nvme-core and
rip it our from nvme-rdma.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 296 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  11 ++
 drivers/nvme/host/rdma.c | 290 ++--------------------------------------------
 3 files changed, 314 insertions(+), 283 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bbaf5b98f2fe..4344adff7134 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2913,6 +2913,302 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+static int nvme_alloc_io_queues(struct nvme_ctrl *ctrl)
+{
+	unsigned int nr_io_queues;
+	int ret;
+
+	nr_io_queues = ctrl->ops->nr_hw_queues(ctrl);
+	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
+	if (ret)
+		return ret;
+
+	ctrl->queue_count = nr_io_queues + 1;
+	if (ctrl->queue_count < 2)
+		return 0;
+
+	dev_info(ctrl->device,
+		"creating %d I/O queues.\n", nr_io_queues);
+
+	return ctrl->ops->alloc_io_queues(ctrl);
+}
+
+void nvme_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
+{
+	ctrl->ops->stop_io_queues(ctrl);
+	if (remove) {
+		if (ctrl->ops->flags & NVME_F_FABRICS)
+			blk_cleanup_queue(ctrl->connect_q);
+		ctrl->ops->free_tagset(ctrl, false);
+	}
+	ctrl->ops->free_io_queues(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_destroy_io_queues);
+
+int nvme_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
+{
+	int ret;
+
+	ret = nvme_alloc_io_queues(ctrl);
+	if (ret)
+		return ret;
+
+	if (new) {
+		ctrl->tagset = ctrl->ops->alloc_tagset(ctrl, false);
+		if (IS_ERR(ctrl->tagset)) {
+			ret = PTR_ERR(ctrl->tagset);
+			goto out_free_io_queues;
+		}
+
+		if (ctrl->ops->flags & NVME_F_FABRICS) {
+			ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
+			if (IS_ERR(ctrl->connect_q)) {
+				ret = PTR_ERR(ctrl->connect_q);
+				goto out_free_tag_set;
+			}
+		}
+       } else {
+		ret = blk_mq_reinit_tagset(ctrl->tagset);
+		if (ret)
+			goto out_free_io_queues;
+
+		blk_mq_update_nr_hw_queues(ctrl->tagset,
+			ctrl->queue_count - 1);
+       }
+
+	ret = ctrl->ops->start_io_queues(ctrl);
+	if (ret)
+		goto out_cleanup_connect_q;
+
+	return 0;
+
+out_cleanup_connect_q:
+	if (new && (ctrl->ops->flags & NVME_F_FABRICS))
+		blk_cleanup_queue(ctrl->connect_q);
+out_free_tag_set:
+       if (new)
+		ctrl->ops->free_tagset(ctrl, false);
+out_free_io_queues:
+	ctrl->ops->free_io_queues(ctrl);
+       return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_configure_io_queues);
+
+void nvme_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
+{
+	ctrl->ops->stop_admin_queue(ctrl);
+	if (remove) {
+		blk_cleanup_queue(ctrl->admin_q);
+		ctrl->ops->free_tagset(ctrl, true);
+	}
+	ctrl->ops->free_admin_queue(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_destroy_admin_queue);
+
+int nvme_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
+{
+	int error;
+
+	error = ctrl->ops->alloc_admin_queue(ctrl);
+	if (error)
+		return error;
+
+	if (new) {
+		ctrl->admin_tagset = ctrl->ops->alloc_tagset(ctrl, true);
+		if (IS_ERR(ctrl->admin_tagset)) {
+			error = PTR_ERR(ctrl->admin_tagset);
+			goto out_free_queue;
+		}
+
+		ctrl->admin_q = blk_mq_init_queue(ctrl->admin_tagset);
+		if (IS_ERR(ctrl->admin_q)) {
+			error = PTR_ERR(ctrl->admin_q);
+			goto out_free_tagset;
+		}
+	} else {
+		error = blk_mq_reinit_tagset(ctrl->admin_tagset);
+		if (error)
+			goto out_free_queue;
+	}
+
+	error = ctrl->ops->start_admin_queue(ctrl);
+	if (error)
+		goto out_cleanup_queue;
+
+	error = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	if (error) {
+		dev_err(ctrl->device,
+			"prop_get NVME_REG_CAP failed\n");
+		goto out_cleanup_queue;
+	}
+
+	ctrl->sqsize = min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
+
+	error = nvme_enable_ctrl(ctrl, ctrl->cap);
+	if (error)
+		goto out_cleanup_queue;
+
+	error = nvme_init_identify(ctrl);
+	if (error)
+		goto out_cleanup_queue;
+
+	return 0;
+
+out_cleanup_queue:
+	if (new)
+		blk_cleanup_queue(ctrl->admin_q);
+out_free_tagset:
+	if (new)
+		ctrl->ops->free_tagset(ctrl, true);
+out_free_queue:
+	ctrl->ops->free_admin_queue(ctrl);
+	return error;
+}
+EXPORT_SYMBOL_GPL(nvme_configure_admin_queue);
+
+static void nvme_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+{
+	if (ctrl->queue_count > 1) {
+		nvme_stop_queues(ctrl);
+		blk_mq_tagset_busy_iter(ctrl->tagset,
+					nvme_cancel_request, ctrl);
+		nvme_destroy_io_queues(ctrl, shutdown);
+	}
+
+	if (shutdown)
+		nvme_shutdown_ctrl(ctrl);
+	else
+		nvme_disable_ctrl(ctrl, ctrl->cap);
+
+	blk_mq_quiesce_queue(ctrl->admin_q);
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+				nvme_cancel_request, ctrl);
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+	nvme_destroy_admin_queue(ctrl, shutdown);
+}
+
+static void nvme_remove_ctrl(struct nvme_ctrl *ctrl)
+{
+	nvme_remove_namespaces(ctrl);
+	nvme_teardown_ctrl(ctrl, true);
+	nvme_uninit_ctrl(ctrl);
+	nvme_put_ctrl(ctrl);
+}
+
+static void nvme_del_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work,
+			struct nvme_ctrl, delete_work);
+
+	nvme_stop_ctrl(ctrl);
+	nvme_remove_ctrl(ctrl);
+}
+
+int __nvme_del_ctrl(struct nvme_ctrl *ctrl)
+{
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
+		return -EBUSY;
+
+	if (!queue_work(nvme_wq, &ctrl->delete_work))
+		return -EBUSY;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__nvme_del_ctrl);
+
+int nvme_del_ctrl(struct nvme_ctrl *ctrl)
+{
+	int ret = 0;
+
+	/*
+	 * Keep a reference until all work is flushed since
+	 * __nvme_del_ctrl can free the ctrl mem
+	 */
+	if (!kref_get_unless_zero(&ctrl->kref))
+		return -EBUSY;
+
+	ret = __nvme_del_ctrl(ctrl);
+	if (!ret)
+		flush_work(&ctrl->delete_work);
+
+	nvme_put_ctrl(ctrl);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_del_ctrl);
+
+static void nvme_reset_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, reset_work);
+	int ret;
+	bool changed;
+
+	nvme_stop_ctrl(ctrl);
+	nvme_teardown_ctrl(ctrl, false);
+
+	ret = nvme_configure_admin_queue(ctrl, false);
+	if (ret)
+		goto out_fail;
+
+	if (ctrl->queue_count > 1) {
+		ret = nvme_configure_io_queues(ctrl, false);
+		if (ret)
+			goto out_fail;
+	}
+
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+	WARN_ON_ONCE(!changed);
+
+	nvme_start_ctrl(ctrl);
+
+	return;
+
+out_fail:
+	dev_warn(ctrl->device, "Removing after reset failure\n");
+	nvme_remove_ctrl(ctrl);
+}
+
+int nvme_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
+		const struct nvme_ctrl_ops *ops, unsigned long quirks)
+{
+	bool changed;
+	int ret;
+
+	ret = nvme_init_ctrl(ctrl, dev, ops, quirks);
+	if (ret)
+		return ret;
+
+	INIT_WORK(&ctrl->delete_work, nvme_del_ctrl_work);
+	INIT_WORK(&ctrl->reset_work, nvme_reset_ctrl_work);
+
+	ret = nvme_configure_admin_queue(ctrl, true);
+	if (ret)
+		goto out_uninit_ctrl;
+
+	ret = ctrl->ops->post_configure(ctrl);
+	if (ret)
+		goto out_remove_admin_queue;
+
+	if (ctrl->queue_count > 1) {
+		ret = nvme_configure_io_queues(ctrl, true);
+		if (ret)
+			goto out_remove_admin_queue;
+	}
+
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+	WARN_ON_ONCE(!changed);
+
+	nvme_start_ctrl(ctrl);
+
+	return 0;
+out_remove_admin_queue:
+	nvme_destroy_admin_queue(ctrl, true);
+out_uninit_ctrl:
+	nvme_uninit_ctrl(ctrl);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_probe_ctrl);
+
 int __init nvme_core_init(void)
 {
 	int result;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7b8e57b3e634..b5cefa28d3d6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -381,6 +381,17 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 	return dev_to_disk(dev)->private_data;
 }
 
+void nvme_stop_io_queues(struct nvme_ctrl *ctrl);
+void nvme_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove);
+int nvme_configure_io_queues(struct nvme_ctrl *ctrl, bool new);
+void nvme_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove);
+int nvme_configure_admin_queue(struct nvme_ctrl *ctrl, bool new);
+int __nvme_del_ctrl(struct nvme_ctrl *ctrl);
+int nvme_del_ctrl(struct nvme_ctrl *ctrl);
+int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
+int nvme_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
+		const struct nvme_ctrl_ops *ops, unsigned long quirks);
+
 int __init nvme_core_init(void);
 void nvme_core_exit(void);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cf4e4371c2db..35459f2eea74 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -754,17 +754,6 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 	return ERR_PTR(ret);
 }
 
-static void nvme_rdma_destroy_admin_queue(struct nvme_ctrl *ctrl,
-		bool remove)
-{
-	ctrl->ops->stop_admin_queue(ctrl);
-	if (remove) {
-		blk_cleanup_queue(ctrl->admin_q);
-		ctrl->ops->free_tagset(ctrl, true);
-	}
-	ctrl->ops->free_admin_queue(ctrl);
-}
-
 static int nvme_rdma_alloc_admin_queue(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -793,133 +782,6 @@ static int nvme_rdma_alloc_admin_queue(struct nvme_ctrl *nctrl)
 	return ret;
 }
 
-static int nvme_rdma_configure_admin_queue(struct nvme_ctrl *ctrl,
-		bool new)
-{
-	int error;
-
-	error = ctrl->ops->alloc_admin_queue(ctrl);
-	if (error)
-		return error;
-
-	if (new) {
-		ctrl->admin_tagset = ctrl->ops->alloc_tagset(ctrl, true);
-		if (IS_ERR(ctrl->admin_tagset))
-			goto out_free_queue;
-
-		ctrl->admin_q = blk_mq_init_queue(ctrl->admin_tagset);
-		if (IS_ERR(ctrl->admin_q)) {
-			error = PTR_ERR(ctrl->admin_q);
-			goto out_free_tagset;
-		}
-	} else {
-		error = blk_mq_reinit_tagset(ctrl->admin_tagset);
-		if (error)
-			goto out_free_queue;
-	}
-
-	error = ctrl->ops->start_admin_queue(ctrl);
-	if (error)
-		goto out_cleanup_queue;
-
-	error = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP,
-			&ctrl->cap);
-	if (error) {
-		dev_err(ctrl->device, "prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_queue;
-	}
-
-	ctrl->sqsize = min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
-
-	error = nvme_enable_ctrl(ctrl, ctrl->cap);
-	if (error)
-		goto out_cleanup_queue;
-
-	error = nvme_init_identify(ctrl);
-	if (error)
-		goto out_cleanup_queue;
-
-	return 0;
-
-out_cleanup_queue:
-	if (new)
-		blk_cleanup_queue(ctrl->admin_q);
-out_free_tagset:
-	if (new)
-		ctrl->ops->free_tagset(ctrl, true);
-out_free_queue:
-	ctrl->ops->free_admin_queue(ctrl);
-	return error;
-}
-
-static void nvme_rdma_destroy_io_queues(struct nvme_ctrl *ctrl,
-		bool remove)
-{
-	ctrl->ops->stop_io_queues(ctrl);
-	if (remove) {
-		blk_cleanup_queue(ctrl->connect_q);
-		ctrl->ops->free_tagset(ctrl, false);
-	}
-	ctrl->ops->free_io_queues(ctrl);
-}
-
-static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
-{
-	unsigned int nr_io_queues;
-	int ret;
-
-	nr_io_queues = ctrl->ops->nr_hw_queues(ctrl);
-	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
-	if (ret)
-		return ret;
-
-	ctrl->queue_count = nr_io_queues + 1;
-	if (ctrl->queue_count < 2)
-		return 0;
-
-	dev_info(ctrl->device,
-		"creating %d I/O queues.\n", nr_io_queues);
-
-	ret = ctrl->ops->alloc_io_queues(ctrl);
-	if (ret)
-		return ret;
-
-	if (new) {
-		ctrl->tagset = ctrl->ops->alloc_tagset(ctrl, false);
-		if (IS_ERR(ctrl->tagset))
-			goto out_free_io_queues;
-
-		ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
-		if (IS_ERR(ctrl->connect_q)) {
-			ret = PTR_ERR(ctrl->connect_q);
-			goto out_free_tag_set;
-		}
-	} else {
-		ret = blk_mq_reinit_tagset(ctrl->tagset);
-		if (ret)
-			goto out_free_io_queues;
-
-		blk_mq_update_nr_hw_queues(ctrl->tagset,
-			ctrl->queue_count - 1);
-	}
-
-	ret = nvme_rdma_start_io_queues(ctrl);
-	if (ret)
-		goto out_cleanup_connect_q;
-
-	return 0;
-
-out_cleanup_connect_q:
-	if (new)
-		blk_cleanup_queue(ctrl->connect_q);
-out_free_tag_set:
-	if (new)
-		ctrl->ops->free_tagset(ctrl, false);
-out_free_io_queues:
-	ctrl->ops->free_io_queues(ctrl);
-	return ret;
-}
-
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -967,15 +829,15 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	++ctrl->nr_reconnects;
 
 	if (ctrl->queue_count > 1)
-		nvme_rdma_destroy_io_queues(ctrl, false);
+		nvme_destroy_io_queues(ctrl, false);
 
-	nvme_rdma_destroy_admin_queue(ctrl, false);
-	ret = nvme_rdma_configure_admin_queue(ctrl, false);
+	nvme_destroy_admin_queue(ctrl, false);
+	ret = nvme_configure_admin_queue(ctrl, false);
 	if (ret)
 		goto requeue;
 
 	if (ctrl->queue_count > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, false);
+		ret = nvme_configure_io_queues(ctrl, false);
 		if (ret)
 			goto requeue;
 	}
@@ -1764,104 +1626,6 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static void nvme_rdma_shutdown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
-{
-	if (ctrl->queue_count > 1) {
-		nvme_stop_queues(ctrl);
-		blk_mq_tagset_busy_iter(ctrl->tagset,
-					nvme_cancel_request, ctrl);
-		nvme_rdma_destroy_io_queues(ctrl, shutdown);
-	}
-
-	if (shutdown)
-		nvme_shutdown_ctrl(ctrl);
-	else
-		nvme_disable_ctrl(ctrl, ctrl->cap);
-
-	blk_mq_quiesce_queue(ctrl->admin_q);
-	blk_mq_tagset_busy_iter(ctrl->admin_tagset,
-				nvme_cancel_request, ctrl);
-	blk_mq_unquiesce_queue(ctrl->admin_q);
-	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
-}
-
-static void nvme_rdma_remove_ctrl(struct nvme_ctrl *ctrl)
-{
-	nvme_remove_namespaces(ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl, true);
-	nvme_uninit_ctrl(ctrl);
-	nvme_put_ctrl(ctrl);
-}
-
-static void nvme_rdma_del_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl = container_of(work,
-			struct nvme_ctrl, delete_work);
-
-	nvme_stop_ctrl(ctrl);
-	nvme_rdma_remove_ctrl(ctrl);
-}
-
-static int __nvme_rdma_del_ctrl(struct nvme_ctrl *ctrl)
-{
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
-		return -EBUSY;
-
-	if (!queue_work(nvme_wq, &ctrl->delete_work))
-		return -EBUSY;
-
-	return 0;
-}
-
-static int nvme_rdma_del_ctrl(struct nvme_ctrl *ctrl)
-{
-	int ret = 0;
-
-	/*
-	 * Keep a reference until all work is flushed since
-	 * __nvme_rdma_del_ctrl can free the ctrl mem
-	 */
-	if (!kref_get_unless_zero(&ctrl->kref))
-		return -EBUSY;
-	ret = __nvme_rdma_del_ctrl(ctrl);
-	if (!ret)
-		flush_work(&ctrl->delete_work);
-	nvme_put_ctrl(ctrl);
-	return ret;
-}
-
-static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl =
-		container_of(work, struct nvme_ctrl, reset_work);
-	int ret;
-	bool changed;
-
-	nvme_stop_ctrl(ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl, false);
-
-	ret = nvme_rdma_configure_admin_queue(ctrl, false);
-	if (ret)
-		goto out_fail;
-
-	if (ctrl->queue_count > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, false);
-		if (ret)
-			goto out_fail;
-	}
-
-	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
-
-	nvme_start_ctrl(ctrl);
-
-	return;
-
-out_fail:
-	dev_warn(ctrl->device, "Removing after reset failure\n");
-	nvme_rdma_remove_ctrl(ctrl);
-}
-
 static int nvme_rdma_post_configure(struct nvme_ctrl *ctrl)
 {
 	/* sanity check icdoff */
@@ -1904,7 +1668,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.reg_write32		= nvmf_reg_write32,
 	.free_ctrl		= nvme_rdma_free_ctrl,
 	.submit_async_event	= nvme_rdma_submit_async_event,
-	.delete_ctrl		= nvme_rdma_del_ctrl,
+	.delete_ctrl		= nvme_del_ctrl,
 	.get_address		= nvmf_get_address,
 	.alloc_admin_queue	= nvme_rdma_alloc_admin_queue,
 	.free_admin_queue	= nvme_rdma_free_admin_queue,
@@ -1920,46 +1684,6 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.nr_hw_queues		= nvme_rdma_nr_io_queues,
 };
 
-static int nvme_rdma_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
-		const struct nvme_ctrl_ops *ops, unsigned long quirks)
-{
-	bool changed;
-	int ret;
-
-	ret = nvme_init_ctrl(ctrl, dev, ops, quirks);
-	if (ret)
-		return ret;
-
-	INIT_WORK(&ctrl->delete_work, nvme_rdma_del_ctrl_work);
-	INIT_WORK(&ctrl->reset_work, nvme_rdma_reset_ctrl_work);
-
-	ret = nvme_rdma_configure_admin_queue(ctrl, true);
-	if (ret)
-		goto out_uninit_ctrl;
-
-	ret = ctrl->ops->post_configure(ctrl);
-	if (ret)
-		goto out_remove_admin_queue;
-
-	if (ctrl->queue_count > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, true);
-		if (ret)
-			goto out_remove_admin_queue;
-	}
-
-	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
-
-	nvme_start_ctrl(ctrl);
-
-	return 0;
-out_remove_admin_queue:
-	nvme_rdma_destroy_admin_queue(ctrl, true);
-out_uninit_ctrl:
-	nvme_uninit_ctrl(ctrl);
-	return ret;
-}
-
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2010,7 +1734,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
 
-	ret = nvme_rdma_probe_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops, 0);
+	ret = nvme_probe_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops, 0);
 	if (!ctrl->queues)
 		goto out_kfree_queues;
 
@@ -2059,7 +1783,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 		dev_info(ctrl->ctrl.device,
 			"Removing ctrl: NQN \"%s\", addr %pISp\n",
 			ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
-		__nvme_rdma_del_ctrl(&ctrl->ctrl);
+		__nvme_del_ctrl(&ctrl->ctrl);
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-- 
2.7.4

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbdFRPWn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:43 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 25/30] nvme: move control plane handling to nvme core
Date: Sun, 18 Jun 2017 18:21:59 +0300
Message-Id: <1497799324-19598-26-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

handle controller setup, reset and delete

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 373 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  12 ++
 drivers/nvme/host/rdma.c | 372 +---------------------------------------------
 3 files changed, 393 insertions(+), 364 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 17a10549d688..6937ba26ff2c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2670,6 +2670,379 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+static void nvme_free_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 1; i < ctrl->queue_count; i++)
+		ctrl->ops->free_hw_queue(ctrl, i);
+}
+
+void nvme_stop_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 1; i < ctrl->queue_count; i++)
+		ctrl->ops->stop_hw_queue(ctrl, i);
+}
+EXPORT_SYMBOL_GPL(nvme_stop_io_queues);
+
+static int nvme_start_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i, ret = 0;
+
+	for (i = 1; i < ctrl->queue_count; i++) {
+		ret = ctrl->ops->start_hw_queue(ctrl, i);
+		if (ret)
+			goto out_stop_queues;
+	}
+
+	return 0;
+
+out_stop_queues:
+	for (i--; i >= 1; i--)
+		ctrl->ops->stop_hw_queue(ctrl, i);
+	return ret;
+}
+
+static int nvme_alloc_io_queues(struct nvme_ctrl *ctrl)
+{
+	unsigned int nr_io_queues = ctrl->max_queues - 1;
+	int i, ret;
+
+	nr_io_queues = min(nr_io_queues, num_online_cpus());
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
+	for (i = 1; i < ctrl->queue_count; i++) {
+		ret = ctrl->ops->alloc_hw_queue(ctrl, i,
+				ctrl->sqsize + 1);
+		if (ret)
+			goto out_free_queues;
+	}
+
+	return 0;
+
+out_free_queues:
+	for (i--; i >= 1; i--)
+		ctrl->ops->free_hw_queue(ctrl, i);
+
+	return ret;
+}
+
+void nvme_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
+{
+	nvme_stop_io_queues(ctrl);
+	if (remove) {
+		if (ctrl->ops->flags & NVME_F_FABRICS)
+			blk_cleanup_queue(ctrl->connect_q);
+		ctrl->ops->free_tagset(ctrl, false);
+	}
+	nvme_free_io_queues(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_destroy_io_queues);
+
+int nvme_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
+{
+	int ret;
+
+	ret = nvme_alloc_io_queues(ctrl);
+	if (ret)
+	return ret;
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
+       }
+
+	ret = nvme_start_io_queues(ctrl);
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
+       nvme_free_io_queues(ctrl);
+       return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_configure_io_queues);
+
+void nvme_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
+{
+	ctrl->ops->stop_hw_queue(ctrl, 0);
+	if (remove) {
+		if (ctrl->ops->flags & NVME_F_FABRICS)
+			blk_cleanup_queue(ctrl->admin_connect_q);
+		blk_cleanup_queue(ctrl->admin_q);
+		ctrl->ops->free_tagset(ctrl, true);
+	}
+	ctrl->ops->free_hw_queue(ctrl, 0);
+}
+EXPORT_SYMBOL_GPL(nvme_destroy_admin_queue);
+
+int nvme_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
+{
+	int error;
+
+	error = ctrl->ops->alloc_hw_queue(ctrl, 0, NVME_AQ_DEPTH);
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
+
+		if (ctrl->ops->flags & NVME_F_FABRICS) {
+			ctrl->admin_connect_q =
+				blk_mq_init_queue(ctrl->admin_tagset);
+			if (IS_ERR(ctrl->admin_connect_q)) {
+				error = PTR_ERR(ctrl->admin_connect_q);
+				goto out_cleanup_queue;
+			}
+		}
+	} else {
+		error = blk_mq_reinit_tagset(ctrl->admin_tagset);
+		if (error)
+			goto out_free_queue;
+	}
+
+	error = ctrl->ops->start_hw_queue(ctrl, 0);
+	if (error)
+		goto out_cleanup_connect_queue;
+
+	error = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	if (error) {
+		dev_err(ctrl->device,
+			"prop_get NVME_REG_CAP failed\n");
+		goto out_cleanup_connect_queue;
+	}
+
+	ctrl->sqsize = min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
+
+	error = nvme_enable_ctrl(ctrl, ctrl->cap);
+	if (error)
+		goto out_cleanup_connect_queue;
+
+	error = nvme_init_identify(ctrl);
+	if (error)
+		goto out_cleanup_connect_queue;
+
+	nvme_start_keep_alive(ctrl);
+
+	return 0;
+
+out_cleanup_connect_queue:
+	if (new && (ctrl->ops->flags & NVME_F_FABRICS))
+		blk_cleanup_queue(ctrl->admin_connect_q);
+out_cleanup_queue:
+	if (new)
+		blk_cleanup_queue(ctrl->admin_q);
+out_free_tagset:
+	if (new)
+		ctrl->ops->free_tagset(ctrl, true);
+out_free_queue:
+	ctrl->ops->free_hw_queue(ctrl, 0);
+	return error;
+}
+EXPORT_SYMBOL_GPL(nvme_configure_admin_queue);
+
+static void nvme_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+{
+	nvme_stop_keep_alive(ctrl);
+	cancel_work_sync(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->reconnect_work);
+
+	if (ctrl->max_queues > 1) {
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
+	blk_mq_stop_hw_queues(ctrl->admin_q);
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+				nvme_cancel_request, ctrl);
+	nvme_destroy_admin_queue(ctrl, shutdown);
+}
+
+static void nvme_del_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work,
+			struct nvme_ctrl, delete_work);
+
+	nvme_uninit_ctrl(ctrl);
+	nvme_teardown_ctrl(ctrl, true);
+	nvme_put_ctrl(ctrl);
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
+	struct nvme_ctrl *ctrl = container_of(work,
+			struct nvme_ctrl, reset_work);
+	int ret;
+	bool changed;
+
+	nvme_teardown_ctrl(ctrl, false);
+
+	blk_mq_start_stopped_hw_queues(ctrl->admin_q, true);
+
+	ret = nvme_configure_admin_queue(ctrl, false);
+	if (ret)
+		goto out_destroy_admin;
+
+	if (ctrl->max_queues > 1) {
+		ret = nvme_configure_io_queues(ctrl, false);
+		if (ret)
+			goto out_destroy_io;
+	}
+
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+	WARN_ON_ONCE(!changed);
+
+	if (ctrl->queue_count > 1) {
+		nvme_start_queues(ctrl);
+		nvme_queue_scan(ctrl);
+		nvme_queue_async_events(ctrl);
+	}
+
+	return;
+
+out_destroy_io:
+	nvme_destroy_io_queues(ctrl, true);
+out_destroy_admin:
+	nvme_destroy_admin_queue(ctrl, true);
+	dev_warn(ctrl->device, "Removing after reset failure\n");
+	nvme_uninit_ctrl(ctrl);
+	nvme_put_ctrl(ctrl);
+}
+
+int nvme_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
+		const struct nvme_ctrl_ops *ops, unsigned long quirks,
+		unsigned int nr_io_queues, size_t queue_size, int kato)
+{
+	bool changed;
+	int ret;
+
+	INIT_WORK(&ctrl->delete_work, nvme_del_ctrl_work);
+	INIT_WORK(&ctrl->reset_work, nvme_reset_ctrl_work);
+
+	ctrl->max_queues = nr_io_queues + 1; /* +1 for admin queue */
+	ctrl->sqsize = queue_size - 1; /* 0's based */
+	ctrl->kato = kato;
+
+	ret = nvme_init_ctrl(ctrl, dev, ops, quirks);
+	if (ret)
+		return ret;
+
+	ret = nvme_configure_admin_queue(ctrl, true);
+	if (ret)
+		goto out_uninit_ctrl;
+
+	ret = ctrl->ops->verify_ctrl(ctrl);
+	if (ret)
+		goto out_remove_admin_queue;
+
+	if (ctrl->max_queues > 1) {
+		ret = nvme_configure_io_queues(ctrl, true);
+		if (ret)
+			goto out_remove_admin_queue;
+	}
+
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+	WARN_ON_ONCE(!changed);
+
+	kref_get(&ctrl->kref);
+
+	if (ctrl->queue_count > 1) {
+		nvme_queue_scan(ctrl);
+		nvme_queue_async_events(ctrl);
+	}
+
+	return 0;
+
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
index 18aac677a96c..c231caf0e486 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -388,6 +388,18 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
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
+		const struct nvme_ctrl_ops *ops, unsigned long quirks,
+		unsigned int nr_io_queues, size_t queue_size, int kato);
+
 int __init nvme_core_init(void);
 void nvme_core_exit(void);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a32c8a710ad4..9b8c819f2bd7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -674,32 +674,6 @@ static void nvme_rdma_free_queue(struct nvme_ctrl *nctrl, int qid)
 	rdma_destroy_id(queue->cm_id);
 }
 
-static void nvme_rdma_free_io_queues(struct nvme_ctrl *ctrl)
-{
-	int i;
-
-	for (i = 1; i < ctrl->queue_count; i++)
-		ctrl->ops->free_hw_queue(ctrl, i);
-}
-
-static void nvme_rdma_stop_io_queues(struct nvme_ctrl *ctrl)
-{
-	int i;
-
-	for (i = 1; i < ctrl->queue_count; i++)
-		ctrl->ops->stop_hw_queue(ctrl, i);
-}
-
-static void nvme_rdma_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_rdma_stop_io_queues(ctrl);
-	if (remove) {
-		blk_cleanup_queue(ctrl->connect_q);
-		ctrl->ops->free_tagset(ctrl, false);
-	}
-	nvme_rdma_free_io_queues(ctrl);
-}
-
 static int nvme_rdma_start_queue(struct nvme_ctrl *nctrl, int idx)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -718,183 +692,6 @@ static int nvme_rdma_start_queue(struct nvme_ctrl *nctrl, int idx)
 	return ret;
 }
 
-static int nvme_rdma_start_io_queues(struct nvme_ctrl *ctrl)
-{
-	int i, ret = 0;
-
-	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = ctrl->ops->start_hw_queue(ctrl, i);
-		if (ret)
-			goto out_stop_queues;
-	}
-
-	return 0;
-
-out_stop_queues:
-	for (i--; i >= 1; i--)
-		ctrl->ops->stop_hw_queue(ctrl, i);
-	return ret;
-}
-
-static int nvme_rdma_alloc_io_queues(struct nvme_ctrl *ctrl)
-{
-	unsigned int nr_io_queues = ctrl->max_queues - 1;
-	int i, ret;
-
-	nr_io_queues = min(nr_io_queues, num_online_cpus());
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
-	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = ctrl->ops->alloc_hw_queue(ctrl, i,
-				ctrl->sqsize + 1);
-		if (ret)
-			goto out_free_queues;
-	}
-
-	return 0;
-
-out_free_queues:
-	for (i--; i >= 1; i--)
-		ctrl->ops->free_hw_queue(ctrl, i);
-
-	return ret;
-}
-
-static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
-{
-	int ret;
-
-	ret = nvme_rdma_alloc_io_queues(ctrl);
-	if (ret)
-		return ret;
-
-	if (new) {
-		ctrl->tagset = ctrl->ops->alloc_tagset(ctrl, false);
-		if (IS_ERR(ctrl->tagset)) {
-			ret = PTR_ERR(ctrl->tagset);
-			goto out_free_io_queues;
-		}
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
-	nvme_rdma_free_io_queues(ctrl);
-	return ret;
-}
-
-static void nvme_rdma_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
-{
-	ctrl->ops->stop_hw_queue(ctrl, 0);
-	if (remove) {
-		blk_cleanup_queue(ctrl->admin_connect_q);
-		blk_cleanup_queue(ctrl->admin_q);
-		ctrl->ops->free_tagset(ctrl, true);
-	}
-	ctrl->ops->free_hw_queue(ctrl, 0);
-}
-
-static int nvme_rdma_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
-{
-	int error;
-
-	error = ctrl->ops->alloc_hw_queue(ctrl, 0, NVME_AQ_DEPTH);
-	if (error)
-		return error;
-
-	if (new) {
-		ctrl->admin_tagset = ctrl->ops->alloc_tagset(ctrl, true);
-		if (IS_ERR(ctrl->admin_tagset)) {
-			error = PTR_ERR(ctrl->admin_tagset);
-			goto out_free_queue;
-		}
-
-		ctrl->admin_q = blk_mq_init_queue(ctrl->admin_tagset);
-		if (IS_ERR(ctrl->admin_q)) {
-			error = PTR_ERR(ctrl->admin_q);
-			goto out_free_tagset;
-		}
-
-		ctrl->admin_connect_q = blk_mq_init_queue(ctrl->admin_tagset);
-		if (IS_ERR(ctrl->admin_connect_q)) {
-			error = PTR_ERR(ctrl->admin_connect_q);
-			goto out_cleanup_queue;
-		}
-	} else {
-		error = blk_mq_reinit_tagset(ctrl->admin_tagset);
-		if (error)
-			goto out_free_queue;
-	}
-
-	error = ctrl->ops->start_hw_queue(ctrl, 0);
-	if (error)
-		goto out_cleanup_connect_queue;
-
-	error = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
-	if (error) {
-		dev_err(ctrl->device,
-			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_connect_queue;
-	}
-
-	ctrl->sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
-
-	error = nvme_enable_ctrl(ctrl, ctrl->cap);
-	if (error)
-		goto out_cleanup_connect_queue;
-
-	error = nvme_init_identify(ctrl);
-	if (error)
-		goto out_cleanup_connect_queue;
-
-	nvme_start_keep_alive(ctrl);
-
-	return 0;
-
-out_cleanup_connect_queue:
-	if (new)
-		blk_cleanup_queue(ctrl->admin_connect_q);
-out_cleanup_queue:
-	if (new)
-		blk_cleanup_queue(ctrl->admin_q);
-out_free_tagset:
-	if (new)
-		ctrl->ops->free_tagset(ctrl, true);
-out_free_queue:
-	ctrl->ops->free_hw_queue(ctrl, 0);
-	return error;
-}
-
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -942,16 +739,16 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	++ctrl->nr_reconnects;
 
 	if (ctrl->max_queues > 1)
-		nvme_rdma_destroy_io_queues(ctrl, false);
+		nvme_destroy_io_queues(ctrl, false);
 
-	nvme_rdma_destroy_admin_queue(ctrl, false);
+	nvme_destroy_admin_queue(ctrl, false);
 
-	ret = nvme_rdma_configure_admin_queue(ctrl, false);
+	ret = nvme_configure_admin_queue(ctrl, false);
 	if (ret)
 		goto requeue;
 
 	if (ctrl->max_queues > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, false);
+		ret = nvme_configure_io_queues(ctrl, false);
 		if (ret)
 			goto requeue;
 	}
@@ -978,7 +775,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	if (ctrl->queue_count > 1) {
 		nvme_stop_queues(ctrl);
-		nvme_rdma_stop_io_queues(ctrl);
+		nvme_stop_io_queues(ctrl);
 	}
 	blk_mq_stop_hw_queues(ctrl->admin_q);
 	ctrl->ops->stop_hw_queue(ctrl, 0);
@@ -1738,107 +1535,6 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static void nvme_rdma_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
-{
-	nvme_stop_keep_alive(ctrl);
-	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
-
-	if (ctrl->max_queues > 1) {
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
-	blk_mq_stop_hw_queues(ctrl->admin_q);
-	blk_mq_tagset_busy_iter(ctrl->admin_tagset,
-				nvme_cancel_request, ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
-}
-
-static void nvme_rdma_del_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl = container_of(work,
-			struct nvme_ctrl, delete_work);
-
-	nvme_uninit_ctrl(ctrl);
-	nvme_rdma_teardown_ctrl(ctrl, true);
-	nvme_put_ctrl(ctrl);
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
-	struct nvme_ctrl *ctrl = container_of(work,
-			struct nvme_ctrl, reset_work);
-	int ret;
-	bool changed;
-
-	nvme_rdma_teardown_ctrl(ctrl, false);
-
-	ret = nvme_rdma_configure_admin_queue(ctrl, false);
-	if (ret)
-		goto out_destroy_admin;
-
-	if (ctrl->max_queues > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, false);
-		if (ret)
-			goto out_destroy_io;
-	}
-
-	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
-
-	if (ctrl->queue_count > 1) {
-		nvme_start_queues(ctrl);
-		nvme_queue_scan(ctrl);
-		nvme_queue_async_events(ctrl);
-	}
-
-	return;
-
-out_destroy_io:
-	nvme_rdma_destroy_io_queues(ctrl, true);
-out_destroy_admin:
-	nvme_rdma_destroy_admin_queue(ctrl, true);
-	dev_warn(ctrl->device, "Removing after reset failure\n");
-	nvme_uninit_ctrl(ctrl);
-	nvme_put_ctrl(ctrl);
-}
-
 static int nvme_rdma_verify_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->opts;
@@ -1883,7 +1579,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.reg_write32		= nvmf_reg_write32,
 	.free_ctrl		= nvme_rdma_free_ctrl,
 	.submit_async_event	= nvme_rdma_submit_async_event,
-	.delete_ctrl		= nvme_rdma_del_ctrl,
+	.delete_ctrl		= nvme_del_ctrl,
 	.get_subsysnqn		= nvmf_get_subsysnqn,
 	.get_address		= nvmf_get_address,
 
@@ -1896,57 +1592,6 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.verify_ctrl		= nvme_rdma_verify_ctrl,
 };
 
-static int nvme_rdma_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
-		const struct nvme_ctrl_ops *ops, unsigned long quirks,
-		unsigned int nr_io_queues, size_t queue_size, int kato)
-{
-	bool changed;
-	int ret;
-
-	INIT_WORK(&ctrl->delete_work, nvme_rdma_del_ctrl_work);
-	INIT_WORK(&ctrl->reset_work, nvme_rdma_reset_ctrl_work);
-
-	ctrl->max_queues = nr_io_queues + 1; /* +1 for admin queue */
-	ctrl->sqsize = queue_size - 1; /* 0's based */
-	ctrl->kato = kato;
-
-	ret = nvme_init_ctrl(ctrl, dev, ops, quirks);
-	if (ret)
-		return ret;
-
-	ret = nvme_rdma_configure_admin_queue(ctrl, true);
-	if (ret)
-		goto out_uninit_ctrl;
-
-	ret = ctrl->ops->verify_ctrl(ctrl);
-	if (ret)
-		goto out_remove_admin_queue;
-
-	if (ctrl->max_queues > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, true);
-		if (ret)
-			goto out_remove_admin_queue;
-	}
-
-	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
-
-	kref_get(&ctrl->kref);
-
-	if (ctrl->queue_count > 1) {
-		nvme_queue_scan(ctrl);
-		nvme_queue_async_events(ctrl);
-	}
-
-	return 0;
-
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
@@ -1986,7 +1631,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->ctrl.reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
-	INIT_WORK(&ctrl->ctrl.delete_work, nvme_rdma_del_ctrl_work);
 
 	ret = -ENOMEM;
 	ctrl->queues = kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
@@ -1994,7 +1638,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_free_ctrl;
 
-	ret = nvme_rdma_probe_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
+	ret = nvme_probe_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 			0, opts->nr_io_queues, opts->queue_size, opts->kato);
 	if (ret)
 		goto out_kfree_queues;
@@ -2039,7 +1683,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 		dev_info(ctrl->ctrl.device,
 			"Removing ctrl: NQN \"%s\", addr %pISp\n",
 			ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
-		__nvme_rdma_del_ctrl(&ctrl->ctrl);
+		__nvme_del_ctrl(&ctrl->ctrl);
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-- 
2.7.4

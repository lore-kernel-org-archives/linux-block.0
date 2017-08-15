Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47533 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbdHOJwx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:53 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 12/12] nvme-loop: convert to nvme-core control plane management
Date: Tue, 15 Aug 2017 12:52:25 +0300
Message-Id: <1502790745-12569-13-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

rip out all the controller and queues control plane code,
only maintain queue alloc/free/start/stop and tagset alloc/free.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
This patch failed to generate a nice diff :(

 drivers/nvme/target/loop.c | 443 ++++++++++++++++-----------------------------
 1 file changed, 160 insertions(+), 283 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 92628c432926..feba730dd9f1 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -273,260 +273,191 @@ static const struct blk_mq_ops nvme_loop_admin_mq_ops = {
 	.timeout	= nvme_loop_timeout,
 };
 
-static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
+static unsigned int nvme_loop_nr_io_queues(struct nvme_ctrl *ctrl)
 {
-	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
+	return num_online_cpus();
 }
 
-static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
+static int nvme_loop_post_configure(struct nvme_ctrl *ctrl)
 {
-	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
-
-	if (list_empty(&ctrl->list))
-		goto free_ctrl;
+	struct nvmf_ctrl_options *opts = ctrl->opts;
 
-	mutex_lock(&nvme_loop_ctrl_mutex);
-	list_del(&ctrl->list);
-	mutex_unlock(&nvme_loop_ctrl_mutex);
-
-	if (nctrl->tagset) {
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
-		blk_mq_free_tag_set(&ctrl->tag_set);
+	if (opts->queue_size > ctrl->maxcmd) {
+		/* warn if maxcmd is lower than queue_size */
+		dev_warn(ctrl->device,
+			"queue_size %zu > ctrl maxcmd %u, clamping down\n",
+			opts->queue_size, ctrl->maxcmd);
+		opts->queue_size = ctrl->maxcmd;
 	}
-	kfree(ctrl->queues);
-	nvmf_free_options(nctrl->opts);
-free_ctrl:
-	kfree(ctrl);
+
+	return 0;
 }
 
-static void nvme_loop_destroy_io_queues(struct nvme_loop_ctrl *ctrl)
+static void nvme_loop_free_tagset(struct nvme_ctrl *nctrl, bool admin)
 {
-	int i;
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
+	struct blk_mq_tag_set *set = admin ?
+			&ctrl->admin_tag_set : &ctrl->tag_set;
 
-	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvmet_sq_destroy(&ctrl->queues[i].nvme_sq);
+	blk_mq_free_tag_set(set);
 }
 
-static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
+static struct blk_mq_tag_set *nvme_loop_alloc_tagset(struct nvme_ctrl *nctrl,
+		bool admin)
 {
-	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
-	unsigned int nr_io_queues;
-	int ret, i;
-
-	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
-	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
-	if (ret || !nr_io_queues)
-		return ret;
-
-	dev_info(ctrl->ctrl.device, "creating %d I/O queues.\n", nr_io_queues);
-
-	for (i = 1; i <= nr_io_queues; i++) {
-		ctrl->queues[i].ctrl = ctrl;
-		ret = nvmet_sq_init(&ctrl->queues[i].nvme_sq);
-		if (ret)
-			goto out_destroy_queues;
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
+	struct blk_mq_tag_set *set;
+	int ret;
 
-		ctrl->ctrl.queue_count++;
+	if (admin) {
+		set = &ctrl->admin_tag_set;
+		memset(set, 0, sizeof(*set));
+		set->ops = &nvme_loop_admin_mq_ops;
+		set->queue_depth = NVME_LOOP_AQ_BLKMQ_DEPTH;
+		set->reserved_tags = 2; /* connect + keep-alive */
+		set->numa_node = NUMA_NO_NODE;
+		set->cmd_size = sizeof(struct nvme_loop_iod) +
+			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		set->driver_data = ctrl;
+		set->nr_hw_queues = 1;
+		set->timeout = ADMIN_TIMEOUT;
+	} else {
+		set = &ctrl->tag_set;
+		memset(set, 0, sizeof(*set));
+		set->ops = &nvme_loop_mq_ops;
+		set->queue_depth = nctrl->opts->queue_size;
+		set->reserved_tags = 1; /* fabric connect */
+		set->numa_node = NUMA_NO_NODE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		set->cmd_size = sizeof(struct nvme_loop_iod) +
+			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		set->driver_data = ctrl;
+		set->nr_hw_queues = nctrl->queue_count - 1;
+		set->timeout = NVME_IO_TIMEOUT;
 	}
 
-	return 0;
+	ret = blk_mq_alloc_tag_set(set);
+	if (ret)
+		return ERR_PTR(ret);
 
-out_destroy_queues:
-	nvme_loop_destroy_io_queues(ctrl);
-	return ret;
+	return set;
 }
 
-static int nvme_loop_connect_io_queues(struct nvme_loop_ctrl *ctrl)
+static void nvme_loop_free_admin_queue(struct nvme_ctrl *ctrl)
 {
-	int i, ret;
-
-	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
 }
 
-static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
-{
-	int error;
-
-	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
-	ctrl->admin_tag_set.ops = &nvme_loop_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_LOOP_AQ_BLKMQ_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
-	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
-	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
-		SG_CHUNK_SIZE * sizeof(struct scatterlist);
-	ctrl->admin_tag_set.driver_data = ctrl;
-	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
-
-	ctrl->queues[0].ctrl = ctrl;
-	error = nvmet_sq_init(&ctrl->queues[0].nvme_sq);
-	if (error)
-		return error;
-	ctrl->ctrl.queue_count = 1;
-
-	error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
-	if (error)
-		goto out_free_sq;
-	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
-
-	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-	if (IS_ERR(ctrl->ctrl.admin_q)) {
-		error = PTR_ERR(ctrl->ctrl.admin_q);
-		goto out_free_tagset;
-	}
-
-	error = nvmf_connect_admin_queue(&ctrl->ctrl);
-	if (error)
-		goto out_cleanup_queue;
-
-	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->ctrl.cap);
-	if (error) {
-		dev_err(ctrl->ctrl.device,
-			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_queue;
-	}
-
-	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->ctrl.cap), ctrl->ctrl.sqsize);
-
-	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
-	if (error)
-		goto out_cleanup_queue;
+static void nvme_loop_free_io_queues(struct nvme_ctrl *ctrl)
+{
+}
 
-	ctrl->ctrl.max_hw_sectors =
-		(NVME_LOOP_MAX_SEGMENTS - 1) << (PAGE_SHIFT - 9);
+static void nvme_loop_stop_queue(struct nvme_loop_ctrl *ctrl, int qid)
+{
+	nvmet_sq_destroy(&ctrl->queues[qid].nvme_sq);
+}
 
-	error = nvme_init_identify(&ctrl->ctrl);
-	if (error)
-		goto out_cleanup_queue;
+static void nvme_loop_stop_admin_queue(struct nvme_ctrl *ctrl)
+{
+	nvme_loop_stop_queue(to_loop_ctrl(ctrl), 0);
+}
 
-	return 0;
+static void nvme_loop_stop_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i;
 
-out_cleanup_queue:
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
-out_free_tagset:
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
-out_free_sq:
-	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
-	return error;
+	for (i = 1; i < ctrl->queue_count; i++)
+		nvme_loop_stop_queue(to_loop_ctrl(ctrl), i);
 }
 
-static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
+static int nvme_loop_start_queue(struct nvme_ctrl *ctrl, int qid)
 {
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
-		nvme_loop_destroy_io_queues(ctrl);
-	}
+	int ret;
 
-	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
-		nvme_shutdown_ctrl(&ctrl->ctrl);
+	if (qid)
+		ret = nvmf_connect_io_queue(ctrl, qid);
+	else
+		ret = nvmf_connect_admin_queue(ctrl);
 
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
-	nvme_loop_destroy_admin_queue(ctrl);
+	if (ret)
+		dev_info(ctrl->device,
+			"failed to connect queue: %d ret=%d\n", qid, ret);
+	return ret;
 }
 
-static void nvme_loop_del_ctrl_work(struct work_struct *work)
+static int nvme_loop_start_admin_queue(struct nvme_ctrl *ctrl)
 {
-	struct nvme_loop_ctrl *ctrl = container_of(work,
-				struct nvme_loop_ctrl, delete_work);
-
-	nvme_stop_ctrl(&ctrl->ctrl);
-	nvme_remove_namespaces(&ctrl->ctrl);
-	nvme_loop_shutdown_ctrl(ctrl);
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
+	return nvme_loop_start_queue(ctrl, 0);
 }
 
-static int __nvme_loop_del_ctrl(struct nvme_loop_ctrl *ctrl)
+static int nvme_loop_start_io_queues(struct nvme_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
-		return -EBUSY;
+	int i, ret = 0;
 
-	if (!queue_work(nvme_wq, &ctrl->delete_work))
-		return -EBUSY;
+	for (i = 1; i < ctrl->queue_count; i++) {
+		ret = nvme_loop_start_queue(ctrl, i);
+		if (ret)
+			goto out_stop_queues;
+	}
 
 	return 0;
+
+out_stop_queues:
+	for (i--; i >= 1; i--)
+		nvme_loop_stop_queue(to_loop_ctrl(ctrl), i);
+	return ret;
 }
 
-static int nvme_loop_del_ctrl(struct nvme_ctrl *nctrl)
+static int nvme_loop_alloc_queue(struct nvme_loop_ctrl *ctrl,
+		int qid, size_t queue_size)
 {
-	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
 	int ret;
 
-	ret = __nvme_loop_del_ctrl(ctrl);
+	ctrl->queues[qid].ctrl = ctrl;
+	ret = nvmet_sq_init(&ctrl->queues[qid].nvme_sq);
 	if (ret)
 		return ret;
 
-	flush_work(&ctrl->delete_work);
-
 	return 0;
 }
 
-static void nvme_loop_delete_ctrl(struct nvmet_ctrl *nctrl)
+static int nvme_loop_alloc_admin_queue(struct nvme_ctrl *nctrl)
 {
-	struct nvme_loop_ctrl *ctrl;
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
 
-	mutex_lock(&nvme_loop_ctrl_mutex);
-	list_for_each_entry(ctrl, &nvme_loop_ctrl_list, list) {
-		if (ctrl->ctrl.cntlid == nctrl->cntlid)
-			__nvme_loop_del_ctrl(ctrl);
-	}
-	mutex_unlock(&nvme_loop_ctrl_mutex);
+	nvme_loop_init_iod(ctrl, &ctrl->async_event_iod, 0);
+
+	return nvme_loop_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
 }
 
-static void nvme_loop_reset_ctrl_work(struct work_struct *work)
+static int nvme_loop_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_loop_ctrl *ctrl =
-		container_of(work, struct nvme_loop_ctrl, ctrl.reset_work);
-	bool changed;
-	int ret;
-
-	nvme_stop_ctrl(&ctrl->ctrl);
-	nvme_loop_shutdown_ctrl(ctrl);
-
-	ret = nvme_loop_configure_admin_queue(ctrl);
-	if (ret)
-		goto out_disable;
-
-	ret = nvme_loop_init_io_queues(ctrl);
-	if (ret)
-		goto out_destroy_admin;
+	int i, ret;
 
-	ret = nvme_loop_connect_io_queues(ctrl);
-	if (ret)
-		goto out_destroy_io;
+	for (i = 1; i < ctrl->queue_count; i++) {
+		ret = nvme_loop_alloc_queue(to_loop_ctrl(ctrl),
+				i, ctrl->sqsize + 1);
+		if (ret)
+			return ret;
+	}
 
-	blk_mq_update_nr_hw_queues(&ctrl->tag_set,
-			ctrl->ctrl.queue_count - 1);
+	return 0;
+}
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
+static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
+{
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
 
-	nvme_start_ctrl(&ctrl->ctrl);
+	if (list_empty(&ctrl->list))
+		goto free_ctrl;
 
-	return;
+	mutex_lock(&nvme_loop_ctrl_mutex);
+	list_del(&ctrl->list);
+	mutex_unlock(&nvme_loop_ctrl_mutex);
 
-out_destroy_io:
-	nvme_loop_destroy_io_queues(ctrl);
-out_destroy_admin:
-	nvme_loop_destroy_admin_queue(ctrl);
-out_disable:
-	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
+	kfree(ctrl->queues);
+	nvmf_free_options(nctrl->opts);
+free_ctrl:
+	kfree(ctrl);
 }
 
 static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
@@ -538,135 +469,81 @@ static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
 	.reg_write32		= nvmf_reg_write32,
 	.free_ctrl		= nvme_loop_free_ctrl,
 	.submit_async_event	= nvme_loop_submit_async_event,
-	.delete_ctrl		= nvme_loop_del_ctrl,
+	.delete_ctrl		= nvme_del_ctrl,
+	.alloc_admin_queue	= nvme_loop_alloc_admin_queue,
+	.free_admin_queue	= nvme_loop_free_admin_queue,
+	.start_admin_queue	= nvme_loop_start_admin_queue,
+	.stop_admin_queue	= nvme_loop_stop_admin_queue,
+	.alloc_io_queues	= nvme_loop_alloc_io_queues,
+	.free_io_queues		= nvme_loop_free_io_queues,
+	.start_io_queues	= nvme_loop_start_io_queues,
+	.stop_io_queues		= nvme_loop_stop_io_queues,
+	.alloc_tagset		= nvme_loop_alloc_tagset,
+	.free_tagset		= nvme_loop_free_tagset,
+	.post_configure		= nvme_loop_post_configure,
+	.nr_hw_queues		= nvme_loop_nr_io_queues,
 };
 
-static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
-{
-	int ret;
-
-	ret = nvme_loop_init_io_queues(ctrl);
-	if (ret)
-		return ret;
-
-	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
-	ctrl->tag_set.ops = &nvme_loop_mq_ops;
-	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
-	ctrl->tag_set.numa_node = NUMA_NO_NODE;
-	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
-		SG_CHUNK_SIZE * sizeof(struct scatterlist);
-	ctrl->tag_set.driver_data = ctrl;
-	ctrl->tag_set.nr_hw_queues = ctrl->ctrl.queue_count - 1;
-	ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
-	ctrl->ctrl.tagset = &ctrl->tag_set;
-
-	ret = blk_mq_alloc_tag_set(&ctrl->tag_set);
-	if (ret)
-		goto out_destroy_queues;
-
-	ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-	if (IS_ERR(ctrl->ctrl.connect_q)) {
-		ret = PTR_ERR(ctrl->ctrl.connect_q);
-		goto out_free_tagset;
-	}
-
-	ret = nvme_loop_connect_io_queues(ctrl);
-	if (ret)
-		goto out_cleanup_connect_q;
-
-	return 0;
-
-out_cleanup_connect_q:
-	blk_cleanup_queue(ctrl->ctrl.connect_q);
-out_free_tagset:
-	blk_mq_free_tag_set(&ctrl->tag_set);
-out_destroy_queues:
-	nvme_loop_destroy_io_queues(ctrl);
-	return ret;
-}
-
 static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_loop_ctrl *ctrl;
-	bool changed;
 	int ret;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
-	ctrl->ctrl.opts = opts;
-	INIT_LIST_HEAD(&ctrl->list);
-
-	INIT_WORK(&ctrl->delete_work, nvme_loop_del_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.reset_work, nvme_loop_reset_ctrl_work);
-
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
-				0 /* no quirks, we're perfect! */);
-	if (ret)
-		goto out_put_ctrl;
-
-	ret = -ENOMEM;
 
+	ctrl->ctrl.opts = opts;
+	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
+	INIT_LIST_HEAD(&ctrl->list);
 
 	ctrl->queues = kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
 			GFP_KERNEL);
-	if (!ctrl->queues)
-		goto out_uninit_ctrl;
+	if (!ctrl->queues) {
+		ret = -ENOMEM;
+		goto out_free_ctrl;
+	}
 
-	ret = nvme_loop_configure_admin_queue(ctrl);
+	ret = nvme_probe_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops, 0);
 	if (ret)
 		goto out_free_queues;
 
-	if (opts->queue_size > ctrl->ctrl.maxcmd) {
-		/* warn if maxcmd is lower than queue_size */
-		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl maxcmd %u, clamping down\n",
-			opts->queue_size, ctrl->ctrl.maxcmd);
-		opts->queue_size = ctrl->ctrl.maxcmd;
-	}
-
-	if (opts->nr_io_queues) {
-		ret = nvme_loop_create_io_queues(ctrl);
-		if (ret)
-			goto out_remove_admin_queue;
-	}
-
-	nvme_loop_init_iod(ctrl, &ctrl->async_event_iod, 0);
-
 	dev_info(ctrl->ctrl.device,
 		 "new ctrl: \"%s\"\n", ctrl->ctrl.opts->subsysnqn);
 
-	kref_get(&ctrl->ctrl.kref);
-
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
-
 	mutex_lock(&nvme_loop_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_loop_ctrl_list);
 	mutex_unlock(&nvme_loop_ctrl_mutex);
 
-	nvme_start_ctrl(&ctrl->ctrl);
+	kref_get(&ctrl->ctrl.kref);
 
 	return &ctrl->ctrl;
 
-out_remove_admin_queue:
-	nvme_loop_destroy_admin_queue(ctrl);
 out_free_queues:
 	kfree(ctrl->queues);
-out_uninit_ctrl:
-	nvme_uninit_ctrl(&ctrl->ctrl);
-out_put_ctrl:
+out_free_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret = -EIO;
+	kfree(ctrl);
 	return ERR_PTR(ret);
 }
 
+static void nvme_loop_delete_ctrl(struct nvmet_ctrl *nctrl)
+{
+	struct nvme_loop_ctrl *ctrl;
+
+	mutex_lock(&nvme_loop_ctrl_mutex);
+	list_for_each_entry(ctrl, &nvme_loop_ctrl_list, list) {
+		if (ctrl->ctrl.cntlid == nctrl->cntlid)
+			__nvme_del_ctrl(&ctrl->ctrl);
+	}
+	mutex_unlock(&nvme_loop_ctrl_mutex);
+}
+
 static int nvme_loop_add_port(struct nvmet_port *port)
 {
 	/*
@@ -730,7 +607,7 @@ static void __exit nvme_loop_cleanup_module(void)
 
 	mutex_lock(&nvme_loop_ctrl_mutex);
 	list_for_each_entry_safe(ctrl, next, &nvme_loop_ctrl_list, list)
-		__nvme_loop_del_ctrl(ctrl);
+		__nvme_del_ctrl(&ctrl->ctrl);
 	mutex_unlock(&nvme_loop_ctrl_mutex);
 
 	flush_workqueue(nvme_wq);
-- 
2.7.4

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52260 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbdFRPWq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:46 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 27/30] nvme-loop: convert to nvme-core control plane management
Date: Sun, 18 Jun 2017 18:22:01 +0300
Message-Id: <1497799324-19598-28-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

rip out all the controller and queues control plane code,
only maintain queue alloc/free/start/stop and tagset alloc/free.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/loop.c | 424 ++++++++++++---------------------------------
 1 file changed, 110 insertions(+), 314 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index edd9ee04de02..f176b473a2dd 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -241,7 +241,7 @@ static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	struct nvme_loop_ctrl *ctrl = data;
 	struct nvme_loop_queue *queue = &ctrl->queues[hctx_idx + 1];
 
-	BUG_ON(hctx_idx >= ctrl->queue_count);
+	BUG_ON(hctx_idx >= ctrl->ctrl.max_queues);
 
 	hctx->driver_data = queue;
 	return 0;
@@ -275,268 +275,137 @@ static const struct blk_mq_ops nvme_loop_admin_mq_ops = {
 	.timeout	= nvme_loop_timeout,
 };
 
-static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
+static int nvme_loop_verify_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
-	blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
-}
-
-static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
-{
-	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
 
-	if (list_empty(&ctrl->list))
-		goto free_ctrl;
-
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
-}
 
-static void nvme_loop_destroy_io_queues(struct nvme_loop_ctrl *ctrl)
-{
-	int i;
-
-	for (i = 1; i < ctrl->queue_count; i++)
-		nvmet_sq_destroy(&ctrl->queues[i].nvme_sq);
-}
-
-static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
-{
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
-
-		ctrl->queue_count++;
+	if (opts->queue_size > ctrl->sqsize + 1) {
+		/* warn if sqsize is lower than queue_size */
+		dev_warn(ctrl->device,
+			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			opts->queue_size, ctrl->sqsize + 1);
+		opts->queue_size = ctrl->sqsize + 1;
 	}
 
 	return 0;
-
-out_destroy_queues:
-	nvme_loop_destroy_io_queues(ctrl);
-	return ret;
 }
 
-static int nvme_loop_connect_io_queues(struct nvme_loop_ctrl *ctrl)
+static void nvme_loop_free_tagset(struct nvme_ctrl *nctrl, bool admin)
 {
-	int i, ret;
-
-	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
-		if (ret)
-			return ret;
-	}
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
+	struct blk_mq_tag_set *set = admin ?
+			&ctrl->admin_tag_set : &ctrl->tag_set;
 
-	return 0;
+	blk_mq_free_tag_set(set);
 }
 
-static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
+static struct blk_mq_tag_set *nvme_loop_alloc_tagset(struct nvme_ctrl *nctrl,
+		bool admin)
 {
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
-	ctrl->queue_count = 1;
-
-	error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
-	if (error)
-		goto out_free_sq;
-
-	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-	if (IS_ERR(ctrl->ctrl.admin_q)) {
-		error = PTR_ERR(ctrl->ctrl.admin_q);
-		goto out_free_tagset;
-	}
-
-	ctrl->ctrl.admin_connect_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-	if (IS_ERR(ctrl->ctrl.admin_connect_q)) {
-		error = PTR_ERR(ctrl->ctrl.admin_connect_q);
-		goto out_cleanup_queue;
-	}
-
-	error = nvmf_connect_admin_queue(&ctrl->ctrl);
-	if (error)
-		goto out_cleanup_connect_queue;
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
+	struct blk_mq_tag_set *set;
+	int ret;
 
-	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->cap);
-	if (error) {
-		dev_err(ctrl->ctrl.device,
-			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_connect_queue;
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
 
-	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->ctrl.sqsize);
-
-	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
-	if (error)
-		goto out_cleanup_connect_queue;
-
-	ctrl->ctrl.max_hw_sectors =
-		(NVME_LOOP_MAX_SEGMENTS - 1) << (PAGE_SHIFT - 9);
-
-	error = nvme_init_identify(&ctrl->ctrl);
-	if (error)
-		goto out_cleanup_connect_queue;
-
-	nvme_start_keep_alive(&ctrl->ctrl);
-
-	return 0;
+	ret = blk_mq_alloc_tag_set(set);
+	if (ret)
+		return ERR_PTR(ret);
 
-out_cleanup_connect_queue:
-	blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
-out_cleanup_queue:
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
-out_free_tagset:
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
-out_free_sq:
-	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
-	return error;
+	return set;
 }
 
-static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
+static void nvme_loop_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	nvme_stop_keep_alive(&ctrl->ctrl);
-
-	if (ctrl->queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
-		nvme_loop_destroy_io_queues(ctrl);
-	}
-
-	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
-		nvme_shutdown_ctrl(&ctrl->ctrl);
-
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
-	nvme_loop_destroy_admin_queue(ctrl);
 }
 
-static void nvme_loop_del_ctrl_work(struct work_struct *work)
+static void nvme_loop_stop_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	struct nvme_loop_ctrl *ctrl = container_of(work,
-				struct nvme_loop_ctrl, delete_work);
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
 
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_loop_shutdown_ctrl(ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
+	nvmet_sq_destroy(&ctrl->queues[qid].nvme_sq);
 }
 
-static int __nvme_loop_del_ctrl(struct nvme_loop_ctrl *ctrl)
+static int nvme_loop_start_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
-		return -EBUSY;
+	int ret;
 
-	if (!queue_work(nvme_wq, &ctrl->delete_work))
-		return -EBUSY;
+	if (qid)
+		ret = nvmf_connect_io_queue(nctrl, qid);
+	else
+		ret = nvmf_connect_admin_queue(nctrl);
 
-	return 0;
+	if (ret)
+		dev_info(nctrl->device,
+			"failed to connect queue: %d ret=%d\n", qid, ret);
+	return ret;
 }
 
-static int nvme_loop_del_ctrl(struct nvme_ctrl *nctrl)
+static int nvme_loop_alloc_queue(struct nvme_ctrl *nctrl,
+		int qid, size_t queue_size)
 {
 	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
 	int ret;
 
-	ret = __nvme_loop_del_ctrl(ctrl);
+	ctrl->queues[qid].ctrl = ctrl;
+	ret = nvmet_sq_init(&ctrl->queues[qid].nvme_sq);
 	if (ret)
 		return ret;
 
-	flush_work(&ctrl->delete_work);
+	if (!qid)
+		nvme_loop_init_iod(ctrl, &ctrl->async_event_iod, 0);
 
 	return 0;
 }
 
-static void nvme_loop_delete_ctrl(struct nvmet_ctrl *nctrl)
+static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
 {
-	struct nvme_loop_ctrl *ctrl;
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
+
+	if (list_empty(&ctrl->list))
+		goto free_ctrl;
 
 	mutex_lock(&nvme_loop_ctrl_mutex);
-	list_for_each_entry(ctrl, &nvme_loop_ctrl_list, list) {
-		if (ctrl->ctrl.cntlid == nctrl->cntlid)
-			__nvme_loop_del_ctrl(ctrl);
-	}
+	list_del(&ctrl->list);
 	mutex_unlock(&nvme_loop_ctrl_mutex);
-}
-
-static void nvme_loop_reset_ctrl_work(struct work_struct *work)
-{
-	struct nvme_loop_ctrl *ctrl =
-		container_of(work, struct nvme_loop_ctrl, ctrl.reset_work);
-	bool changed;
-	int ret;
-
-	nvme_loop_shutdown_ctrl(ctrl);
-
-	ret = nvme_loop_configure_admin_queue(ctrl);
-	if (ret)
-		goto out_disable;
-
-	ret = nvme_loop_init_io_queues(ctrl);
-	if (ret)
-		goto out_destroy_admin;
-
-	ret = nvme_loop_connect_io_queues(ctrl);
-	if (ret)
-		goto out_destroy_io;
-
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
-
-	nvme_queue_scan(&ctrl->ctrl);
-	nvme_queue_async_events(&ctrl->ctrl);
-
-	nvme_start_queues(&ctrl->ctrl);
-
-	return;
 
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
@@ -548,139 +417,66 @@ static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
 	.reg_write32		= nvmf_reg_write32,
 	.free_ctrl		= nvme_loop_free_ctrl,
 	.submit_async_event	= nvme_loop_submit_async_event,
-	.delete_ctrl		= nvme_loop_del_ctrl,
+	.delete_ctrl		= nvme_del_ctrl,
 	.get_subsysnqn		= nvmf_get_subsysnqn,
+	.alloc_hw_queue		= nvme_loop_alloc_queue,
+	.free_hw_queue		= nvme_loop_free_queue,
+	.start_hw_queue		= nvme_loop_start_queue,
+	.stop_hw_queue		= nvme_loop_stop_queue,
+	.alloc_tagset		= nvme_loop_alloc_tagset,
+	.free_tagset		= nvme_loop_free_tagset,
+	.verify_ctrl		= nvme_loop_verify_ctrl,
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
-	ctrl->tag_set.nr_hw_queues = ctrl->queue_count - 1;
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
 
 	ret = -ENOMEM;
-
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
-	ctrl->ctrl.kato = opts->kato;
-
 	ctrl->queues = kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
 			GFP_KERNEL);
 	if (!ctrl->queues)
-		goto out_uninit_ctrl;
+		goto out_free_ctrl;
 
-	ret = nvme_loop_configure_admin_queue(ctrl);
+	ret = nvme_probe_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
+			0, opts->nr_io_queues, opts->queue_size, opts->kato);
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
 
-	if (opts->nr_io_queues) {
-		nvme_queue_scan(&ctrl->ctrl);
-		nvme_queue_async_events(&ctrl->ctrl);
-	}
-
 	return &ctrl->ctrl;
 
-out_remove_admin_queue:
-	nvme_loop_destroy_admin_queue(ctrl);
 out_free_queues:
 	kfree(ctrl->queues);
-out_uninit_ctrl:
-	nvme_uninit_ctrl(&ctrl->ctrl);
-out_put_ctrl:
-	nvme_put_ctrl(&ctrl->ctrl);
-	if (ret > 0)
-		ret = -EIO;
+out_free_ctrl:
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
@@ -744,7 +540,7 @@ static void __exit nvme_loop_cleanup_module(void)
 
 	mutex_lock(&nvme_loop_ctrl_mutex);
 	list_for_each_entry_safe(ctrl, next, &nvme_loop_ctrl_list, list)
-		__nvme_loop_del_ctrl(ctrl);
+		__nvme_del_ctrl(&ctrl->ctrl);
 	mutex_unlock(&nvme_loop_ctrl_mutex);
 
 	flush_workqueue(nvme_wq);
-- 
2.7.4

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52216 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:39 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 21/30] nvme-rdma: plumb nvme_ctrl down the calls tack
Date: Sun, 18 Jun 2017 18:21:55 +0300
Message-Id: <1497799324-19598-22-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We are trying to make these routines generic, so pass
around nvme_ctrl down the call stack and only access
the rdma ctrl in the bottom of the stack, where we
will callout the transports.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 251 +++++++++++++++++++++++------------------------
 1 file changed, 125 insertions(+), 126 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6ce5054d4470..e656b9b17d67 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -568,14 +568,14 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 	return ERR_PTR(ret);
 }
 
-static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
+static int nvme_rdma_alloc_queue(struct nvme_ctrl *nctrl,
 		int idx, size_t queue_size)
 {
-	struct nvme_rdma_queue *queue;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
 	struct sockaddr *src_addr = NULL;
 	int ret;
 
-	queue = &ctrl->queues[idx];
 	queue->ctrl = ctrl;
 	init_completion(&queue->cm_done);
 
@@ -647,8 +647,9 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	return ret;
 }
 
-static void nvme_rdma_stop_queue(struct nvme_rdma_ctrl *ctrl, int qid)
+static void nvme_rdma_stop_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
 
 	if (!test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
@@ -657,8 +658,9 @@ static void nvme_rdma_stop_queue(struct nvme_rdma_ctrl *ctrl, int qid)
 	ib_drain_qp(queue->qp);
 }
 
-static void nvme_rdma_free_queue(struct nvme_rdma_ctrl *ctrl, int qid)
+static void nvme_rdma_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
 
 	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
@@ -672,54 +674,55 @@ static void nvme_rdma_free_queue(struct nvme_rdma_ctrl *ctrl, int qid)
 	rdma_destroy_id(queue->cm_id);
 }
 
-static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_free_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i;
 
-	for (i = 1; i < ctrl->ctrl.queue_count; i++)
+	for (i = 1; i < ctrl->queue_count; i++)
 		nvme_rdma_free_queue(ctrl, i);
 }
 
-static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_stop_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i;
 
-	for (i = 1; i < ctrl->ctrl.queue_count; i++)
+	for (i = 1; i < ctrl->queue_count; i++)
 		nvme_rdma_stop_queue(ctrl, i);
 }
 
-static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl, bool remove)
+static void nvme_rdma_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
 {
 	nvme_rdma_stop_io_queues(ctrl);
 	if (remove) {
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
-		nvme_rdma_free_tagset(&ctrl->ctrl, false);
+		blk_cleanup_queue(ctrl->connect_q);
+		nvme_rdma_free_tagset(ctrl, false);
 	}
 	nvme_rdma_free_io_queues(ctrl);
 }
 
-static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
+static int nvme_rdma_start_queue(struct nvme_ctrl *nctrl, int idx)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx);
+		ret = nvmf_connect_io_queue(nctrl, idx);
 	else
-		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
+		ret = nvmf_connect_admin_queue(nctrl);
 
 	if (!ret)
 		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[idx].flags);
 	else
-		dev_info(ctrl->ctrl.device,
+		dev_info(nctrl->device,
 			"failed to connect queue: %d ret=%d\n", idx, ret);
 	return ret;
 }
 
-static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_start_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret = 0;
 
-	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
+	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_rdma_start_queue(ctrl, i);
 		if (ret)
 			goto out_stop_queues;
@@ -733,26 +736,26 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
-	unsigned int nr_io_queues = ctrl->ctrl.max_queues - 1;
+	unsigned int nr_io_queues = ctrl->max_queues - 1;
 	int i, ret;
 
 	nr_io_queues = min(nr_io_queues, num_online_cpus());
-	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
+	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
 
-	ctrl->ctrl.queue_count = nr_io_queues + 1;
-	if (ctrl->ctrl.queue_count < 2)
+	ctrl->queue_count = nr_io_queues + 1;
+	if (ctrl->queue_count < 2)
 		return 0;
 
-	dev_info(ctrl->ctrl.device,
+	dev_info(ctrl->device,
 		"creating %d I/O queues.\n", nr_io_queues);
 
-	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
+	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_rdma_alloc_queue(ctrl, i,
-				ctrl->ctrl.sqsize + 1);
+				ctrl->sqsize + 1);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -766,7 +769,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
+static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret;
 
@@ -775,19 +778,19 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		return ret;
 
 	if (new) {
-		ctrl->ctrl.tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, false);
-		if (IS_ERR(ctrl->ctrl.tagset)) {
-			ret = PTR_ERR(ctrl->ctrl.tagset);
+		ctrl->tagset = nvme_rdma_alloc_tagset(ctrl, false);
+		if (IS_ERR(ctrl->tagset)) {
+			ret = PTR_ERR(ctrl->tagset);
 			goto out_free_io_queues;
 		}
 
-		ctrl->ctrl.connect_q = blk_mq_init_queue(ctrl->ctrl.tagset);
-		if (IS_ERR(ctrl->ctrl.connect_q)) {
-			ret = PTR_ERR(ctrl->ctrl.connect_q);
+		ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
+		if (IS_ERR(ctrl->connect_q)) {
+			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
 	} else {
-		ret = blk_mq_reinit_tagset(ctrl->ctrl.tagset);
+		ret = blk_mq_reinit_tagset(ctrl->tagset);
 		if (ret)
 			goto out_free_io_queues;
 	}
@@ -800,27 +803,27 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 out_cleanup_connect_q:
 	if (new)
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
+		blk_cleanup_queue(ctrl->connect_q);
 out_free_tag_set:
 	if (new)
-		nvme_rdma_free_tagset(&ctrl->ctrl, false);
+		nvme_rdma_free_tagset(ctrl, false);
 out_free_io_queues:
 	nvme_rdma_free_io_queues(ctrl);
 	return ret;
 }
 
-static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl, bool remove)
+static void nvme_rdma_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
 	nvme_rdma_stop_queue(ctrl, 0);
 	if (remove) {
-		blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
-		blk_cleanup_queue(ctrl->ctrl.admin_q);
-		nvme_rdma_free_tagset(&ctrl->ctrl, true);
+		blk_cleanup_queue(ctrl->admin_connect_q);
+		blk_cleanup_queue(ctrl->admin_q);
+		nvme_rdma_free_tagset(ctrl, true);
 	}
 	nvme_rdma_free_queue(ctrl, 0);
 }
 
-static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new)
+static int nvme_rdma_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 {
 	int error;
 
@@ -829,25 +832,25 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 		return error;
 
 	if (new) {
-		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
-		if (IS_ERR(ctrl->ctrl.admin_tagset)) {
-			error = PTR_ERR(ctrl->ctrl.admin_tagset);
+		ctrl->admin_tagset = nvme_rdma_alloc_tagset(ctrl, true);
+		if (IS_ERR(ctrl->admin_tagset)) {
+			error = PTR_ERR(ctrl->admin_tagset);
 			goto out_free_queue;
 		}
 
-		ctrl->ctrl.admin_q = blk_mq_init_queue(ctrl->ctrl.admin_tagset);
-		if (IS_ERR(ctrl->ctrl.admin_q)) {
-			error = PTR_ERR(ctrl->ctrl.admin_q);
+		ctrl->admin_q = blk_mq_init_queue(ctrl->admin_tagset);
+		if (IS_ERR(ctrl->admin_q)) {
+			error = PTR_ERR(ctrl->admin_q);
 			goto out_free_tagset;
 		}
 
-		ctrl->ctrl.admin_connect_q = blk_mq_init_queue(ctrl->ctrl.admin_tagset);
-		if (IS_ERR(ctrl->ctrl.admin_connect_q)) {
-			error = PTR_ERR(ctrl->ctrl.admin_connect_q);
+		ctrl->admin_connect_q = blk_mq_init_queue(ctrl->admin_tagset);
+		if (IS_ERR(ctrl->admin_connect_q)) {
+			error = PTR_ERR(ctrl->admin_connect_q);
 			goto out_cleanup_queue;
 		}
 	} else {
-		error = blk_mq_reinit_tagset(ctrl->ctrl.admin_tagset);
+		error = blk_mq_reinit_tagset(ctrl->admin_tagset);
 		if (error)
 			goto out_free_queue;
 	}
@@ -856,37 +859,37 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 	if (error)
 		goto out_cleanup_connect_queue;
 
-	error = ctrl->ctrl.ops->reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->ctrl.cap);
+	error = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
 	if (error) {
-		dev_err(ctrl->ctrl.device,
+		dev_err(ctrl->device,
 			"prop_get NVME_REG_CAP failed\n");
 		goto out_cleanup_connect_queue;
 	}
 
-	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->ctrl.cap), ctrl->ctrl.sqsize);
+	ctrl->sqsize =
+		min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
 
-	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
+	error = nvme_enable_ctrl(ctrl, ctrl->cap);
 	if (error)
 		goto out_cleanup_connect_queue;
 
-	error = nvme_init_identify(&ctrl->ctrl);
+	error = nvme_init_identify(ctrl);
 	if (error)
 		goto out_cleanup_connect_queue;
 
-	nvme_start_keep_alive(&ctrl->ctrl);
+	nvme_start_keep_alive(ctrl);
 
 	return 0;
 
 out_cleanup_connect_queue:
 	if (new)
-		blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
+		blk_cleanup_queue(ctrl->admin_connect_q);
 out_cleanup_queue:
 	if (new)
-		blk_cleanup_queue(ctrl->ctrl.admin_q);
+		blk_cleanup_queue(ctrl->admin_q);
 out_free_tagset:
 	if (new)
-		nvme_rdma_free_tagset(&ctrl->ctrl, true);
+		nvme_rdma_free_tagset(ctrl, true);
 out_free_queue:
 	nvme_rdma_free_queue(ctrl, 0);
 	return error;
@@ -909,37 +912,36 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
-static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_reconnect_or_remove(struct nvme_ctrl *ctrl)
 {
 	/* If we are resetting/deleting then do nothing */
-	if (ctrl->ctrl.state != NVME_CTRL_RECONNECTING) {
-		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
-			ctrl->ctrl.state == NVME_CTRL_LIVE);
+	if (ctrl->state != NVME_CTRL_RECONNECTING) {
+		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
+			ctrl->state == NVME_CTRL_LIVE);
 		return;
 	}
 
-	if (nvmf_should_reconnect(&ctrl->ctrl)) {
-		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
-			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->ctrl.reconnect_work,
-				ctrl->ctrl.opts->reconnect_delay * HZ);
+	if (nvmf_should_reconnect(ctrl)) {
+		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
+			ctrl->opts->reconnect_delay);
+		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
+				ctrl->opts->reconnect_delay * HZ);
 	} else {
-		dev_info(ctrl->ctrl.device, "Removing controller...\n");
-		queue_work(nvme_wq, &ctrl->ctrl.delete_work);
+		dev_info(ctrl->device, "Removing controller...\n");
+		queue_work(nvme_wq, &ctrl->delete_work);
 	}
 }
 
 static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
-	struct nvme_ctrl *nctrl = container_of(to_delayed_work(work),
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_ctrl, reconnect_work);
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	bool changed;
 	int ret;
 
-	++ctrl->ctrl.nr_reconnects;
+	++ctrl->nr_reconnects;
 
-	if (ctrl->ctrl.max_queues > 1)
+	if (ctrl->max_queues > 1)
 		nvme_rdma_destroy_io_queues(ctrl, false);
 
 	nvme_rdma_destroy_admin_queue(ctrl, false);
@@ -948,53 +950,52 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto requeue;
 
-	if (ctrl->ctrl.max_queues > 1) {
+	if (ctrl->max_queues > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
 			goto requeue;
 	}
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
-	ctrl->ctrl.nr_reconnects = 0;
-	dev_info(ctrl->ctrl.device, "Successfully reconnected\n");
+	ctrl->nr_reconnects = 0;
+	dev_info(ctrl->device, "Successfully reconnected\n");
 
 	return;
 
 requeue:
-	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
-			ctrl->ctrl.nr_reconnects);
+	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
+			ctrl->nr_reconnects);
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
-	struct nvme_ctrl *nctrl = container_of(work,
+	struct nvme_ctrl *ctrl = container_of(work,
 			struct nvme_ctrl, err_work);
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	nvme_stop_keep_alive(&ctrl->ctrl);
+	nvme_stop_keep_alive(ctrl);
 
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
+	if (ctrl->queue_count > 1) {
+		nvme_stop_queues(ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 	}
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_stop_hw_queues(ctrl->admin_q);
 	nvme_rdma_stop_queue(ctrl, 0);
 
 	/* We must take care of fastfail/requeue all our inflight requests */
-	if (ctrl->ctrl.queue_count > 1)
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
+	if (ctrl->queue_count > 1)
+		blk_mq_tagset_busy_iter(ctrl->tagset,
+					nvme_cancel_request, ctrl);
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+				nvme_cancel_request, ctrl);
 
 	/*
 	 * queues are not a live anymore, so restart the queues to fail fast
 	 * new IO
 	 */
-	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
-	nvme_start_queues(&ctrl->ctrl);
+	blk_mq_start_stopped_hw_queues(ctrl->admin_q, true);
+	nvme_start_queues(ctrl);
 
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
@@ -1737,39 +1738,38 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static void nvme_rdma_teardown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
+static void nvme_rdma_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	nvme_stop_keep_alive(&ctrl->ctrl);
-	cancel_work_sync(&ctrl->ctrl.err_work);
-	cancel_delayed_work_sync(&ctrl->ctrl.reconnect_work);
+	nvme_stop_keep_alive(ctrl);
+	cancel_work_sync(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->reconnect_work);
 
-	if (ctrl->ctrl.max_queues > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
+	if (ctrl->max_queues > 1) {
+		nvme_stop_queues(ctrl);
+		blk_mq_tagset_busy_iter(ctrl->tagset,
+					nvme_cancel_request, ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
 
 	if (shutdown)
-		nvme_shutdown_ctrl(&ctrl->ctrl);
+		nvme_shutdown_ctrl(ctrl);
 	else
-		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
+		nvme_disable_ctrl(ctrl, ctrl->cap);
 
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
+	blk_mq_stop_hw_queues(ctrl->admin_q);
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+				nvme_cancel_request, ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
 }
 
 static void nvme_rdma_del_ctrl_work(struct work_struct *work)
 {
-	struct nvme_ctrl *nctrl = container_of(work,
+	struct nvme_ctrl *ctrl = container_of(work,
 			struct nvme_ctrl, delete_work);
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_uninit_ctrl(ctrl);
 	nvme_rdma_teardown_ctrl(ctrl, true);
-	nvme_put_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(ctrl);
 }
 
 static int __nvme_rdma_del_ctrl(struct nvme_ctrl *ctrl)
@@ -1802,9 +1802,8 @@ static int nvme_rdma_del_ctrl(struct nvme_ctrl *ctrl)
 
 static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
-	struct nvme_ctrl *nctrl = container_of(work,
+	struct nvme_ctrl *ctrl = container_of(work,
 			struct nvme_ctrl, reset_work);
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	int ret;
 	bool changed;
 
@@ -1814,19 +1813,19 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto out_destroy_admin;
 
-	if (ctrl->ctrl.max_queues > 1) {
+	if (ctrl->max_queues > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
 			goto out_destroy_io;
 	}
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_queues(&ctrl->ctrl);
-		nvme_queue_scan(&ctrl->ctrl);
-		nvme_queue_async_events(&ctrl->ctrl);
+	if (ctrl->queue_count > 1) {
+		nvme_start_queues(ctrl);
+		nvme_queue_scan(ctrl);
+		nvme_queue_async_events(ctrl);
 	}
 
 	return;
@@ -1835,9 +1834,9 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_rdma_destroy_io_queues(ctrl, true);
 out_destroy_admin:
 	nvme_rdma_destroy_admin_queue(ctrl, true);
-	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
+	dev_warn(ctrl->device, "Removing after reset failure\n");
+	nvme_uninit_ctrl(ctrl);
+	nvme_put_ctrl(ctrl);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
@@ -1911,7 +1910,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_uninit_ctrl;
 
-	ret = nvme_rdma_configure_admin_queue(ctrl, true);
+	ret = nvme_rdma_configure_admin_queue(&ctrl->ctrl, true);
 	if (ret)
 		goto out_kfree_queues;
 
@@ -1946,7 +1945,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	}
 
 	if (ctrl->ctrl.max_queues > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, true);
+		ret = nvme_rdma_configure_io_queues(&ctrl->ctrl, true);
 		if (ret)
 			goto out_remove_admin_queue;
 	}
@@ -1972,7 +1971,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 
 out_remove_admin_queue:
 	nvme_stop_keep_alive(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl, true);
+	nvme_rdma_destroy_admin_queue(&ctrl->ctrl, true);
 out_kfree_queues:
 	kfree(ctrl->queues);
 out_uninit_ctrl:
-- 
2.7.4

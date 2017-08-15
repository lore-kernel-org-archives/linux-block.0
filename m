Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbdHOJwp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:45 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 06/12] nvme-rdma: plumb nvme ctrl to various routines
Date: Tue, 15 Aug 2017 12:52:19 +0300
Message-Id: <1502790745-12569-7-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

These routines will move to the nvme core, so make
sure they are passed with a core nvme controller struct.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 264 ++++++++++++++++++++++++-----------------------
 1 file changed, 133 insertions(+), 131 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8a8163c82733..2591b0ce155e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -588,16 +588,18 @@ static void nvme_rdma_free_admin_queue(struct nvme_ctrl *nctrl)
 	nvme_rdma_free_queue(queue);
 }
 
-static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_free_io_queues(struct nvme_ctrl *nctrl)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	int i;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++)
 		nvme_rdma_free_queue(&ctrl->queues[i]);
 }
 
-static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_stop_io_queues(struct nvme_ctrl *nctrl)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	int i;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++)
@@ -626,8 +628,9 @@ static int nvme_rdma_start_admin_queue(struct nvme_ctrl *ctrl)
 	return nvme_rdma_start_queue(to_rdma_ctrl(ctrl), 0);
 }
 
-static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_start_io_queues(struct nvme_ctrl *nctrl)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	int i, ret = 0;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
@@ -644,9 +647,10 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static unsigned int nvme_rdma_nr_io_queues(struct nvme_rdma_ctrl *ctrl)
+static unsigned int nvme_rdma_nr_io_queues(struct nvme_ctrl *nctrl)
 {
-	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvmf_ctrl_options *opts = nctrl->opts;
 	struct ib_device *ibdev = ctrl->device->dev;
 	unsigned int nr_io_queues;
 
@@ -663,8 +667,9 @@ static unsigned int nvme_rdma_nr_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return nr_io_queues;
 }
 
-static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_alloc_io_queues(struct nvme_ctrl *nctrl)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	int i, ret;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
@@ -749,15 +754,15 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 	return ERR_PTR(ret);
 }
 
-static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
+static void nvme_rdma_destroy_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	nvme_rdma_stop_admin_queue(&ctrl->ctrl);
+	nvme_rdma_stop_admin_queue(ctrl);
 	if (remove) {
-		blk_cleanup_queue(ctrl->ctrl.admin_q);
-		nvme_rdma_free_tagset(&ctrl->ctrl, true);
+		blk_cleanup_queue(ctrl->admin_q);
+		nvme_rdma_free_tagset(ctrl, true);
 	}
-	nvme_rdma_free_admin_queue(&ctrl->ctrl);
+	nvme_rdma_free_admin_queue(ctrl);
 }
 
 static int nvme_rdma_alloc_admin_queue(struct nvme_ctrl *nctrl)
@@ -788,51 +793,49 @@ static int nvme_rdma_alloc_admin_queue(struct nvme_ctrl *nctrl)
 	return ret;
 }
 
-static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
+static int nvme_rdma_configure_admin_queue(struct nvme_ctrl *ctrl,
 		bool new)
 {
 	int error;
 
-	error = nvme_rdma_alloc_admin_queue(&ctrl->ctrl);
+	error = nvme_rdma_alloc_admin_queue(ctrl);
 	if (error)
 		return error;
 
 	if (new) {
-		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
-		if (IS_ERR(ctrl->ctrl.admin_tagset))
+		ctrl->admin_tagset = nvme_rdma_alloc_tagset(ctrl, true);
+		if (IS_ERR(ctrl->admin_tagset))
 			goto out_free_queue;
 
-		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-		if (IS_ERR(ctrl->ctrl.admin_q)) {
-			error = PTR_ERR(ctrl->ctrl.admin_q);
+		ctrl->admin_q = blk_mq_init_queue(ctrl->admin_tagset);
+		if (IS_ERR(ctrl->admin_q)) {
+			error = PTR_ERR(ctrl->admin_q);
 			goto out_free_tagset;
 		}
 	} else {
-		error = blk_mq_reinit_tagset(&ctrl->admin_tag_set);
+		error = blk_mq_reinit_tagset(ctrl->admin_tagset);
 		if (error)
 			goto out_free_queue;
 	}
 
-	error = nvme_rdma_start_admin_queue(&ctrl->ctrl);
+	error = nvme_rdma_start_admin_queue(ctrl);
 	if (error)
 		goto out_cleanup_queue;
 
-	error = ctrl->ctrl.ops->reg_read64(&ctrl->ctrl, NVME_REG_CAP,
-			&ctrl->ctrl.cap);
+	error = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP,
+			&ctrl->cap);
 	if (error) {
-		dev_err(ctrl->ctrl.device,
-			"prop_get NVME_REG_CAP failed\n");
+		dev_err(ctrl->device, "prop_get NVME_REG_CAP failed\n");
 		goto out_cleanup_queue;
 	}
 
-	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->ctrl.cap), ctrl->ctrl.sqsize);
+	ctrl->sqsize = min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
 
-	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
+	error = nvme_enable_ctrl(ctrl, ctrl->cap);
 	if (error)
 		goto out_cleanup_queue;
 
-	error = nvme_init_identify(&ctrl->ctrl);
+	error = nvme_init_identify(ctrl);
 	if (error)
 		goto out_cleanup_queue;
 
@@ -840,41 +843,41 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 out_cleanup_queue:
 	if (new)
-		blk_cleanup_queue(ctrl->ctrl.admin_q);
+		blk_cleanup_queue(ctrl->admin_q);
 out_free_tagset:
 	if (new)
-		nvme_rdma_free_tagset(&ctrl->ctrl, true);
+		nvme_rdma_free_tagset(ctrl, true);
 out_free_queue:
-	nvme_rdma_free_admin_queue(&ctrl->ctrl);
+	nvme_rdma_free_admin_queue(ctrl);
 	return error;
 }
 
-static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
+static void nvme_rdma_destroy_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
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
 
-static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
+static int nvme_rdma_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	unsigned int nr_io_queues;
 	int ret;
 
 	nr_io_queues = nvme_rdma_nr_io_queues(ctrl);
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
 
 	ret = nvme_rdma_alloc_io_queues(ctrl);
@@ -882,22 +885,22 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		return ret;
 
 	if (new) {
-		ctrl->ctrl.tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, false);
-		if (IS_ERR(ctrl->ctrl.tagset))
+		ctrl->tagset = nvme_rdma_alloc_tagset(ctrl, false);
+		if (IS_ERR(ctrl->tagset))
 			goto out_free_io_queues;
 
-		ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-		if (IS_ERR(ctrl->ctrl.connect_q)) {
-			ret = PTR_ERR(ctrl->ctrl.connect_q);
+		ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
+		if (IS_ERR(ctrl->connect_q)) {
+			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
 	} else {
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set);
+		ret = blk_mq_reinit_tagset(ctrl->tagset);
 		if (ret)
 			goto out_free_io_queues;
 
-		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
-			ctrl->ctrl.queue_count - 1);
+		blk_mq_update_nr_hw_queues(ctrl->tagset,
+			ctrl->queue_count - 1);
 	}
 
 	ret = nvme_rdma_start_io_queues(ctrl);
@@ -908,10 +911,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
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
@@ -934,36 +937,36 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
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
-	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_rdma_ctrl, ctrl.reconnect_work);
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, reconnect_work);
 	bool changed;
 	int ret;
 
-	++ctrl->ctrl.nr_reconnects;
+	++ctrl->nr_reconnects;
 
-	if (ctrl->ctrl.queue_count > 1)
+	if (ctrl->queue_count > 1)
 		nvme_rdma_destroy_io_queues(ctrl, false);
 
 	nvme_rdma_destroy_admin_queue(ctrl, false);
@@ -971,65 +974,65 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto requeue;
 
-	if (ctrl->ctrl.queue_count > 1) {
+	if (ctrl->queue_count > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
 			goto requeue;
 	}
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
-	ctrl->ctrl.nr_reconnects = 0;
+	ctrl->nr_reconnects = 0;
 
-	nvme_start_ctrl(&ctrl->ctrl);
+	nvme_start_ctrl(ctrl);
 
-	dev_info(ctrl->ctrl.device, "Successfully reconnected\n");
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
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-			struct nvme_rdma_ctrl, ctrl.err_work);
+	struct nvme_ctrl *ctrl = container_of(work,
+			struct nvme_ctrl, err_work);
 
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_ctrl(ctrl);
 
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
+	if (ctrl->queue_count > 1) {
+		nvme_stop_queues(ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 	}
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_admin_queue(&ctrl->ctrl);
+	blk_mq_quiesce_queue(ctrl->admin_q);
+	nvme_rdma_stop_admin_queue(ctrl);
 
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
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
-	nvme_start_queues(&ctrl->ctrl);
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+	nvme_start_queues(ctrl);
 
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
-static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_error_recovery(struct nvme_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RECONNECTING))
 		return;
 
-	queue_work(nvme_wq, &ctrl->ctrl.err_work);
+	queue_work(nvme_wq, &ctrl->err_work);
 }
 
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
@@ -1043,7 +1046,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
 			     ib_wc_status_msg(wc->status), wc->status);
-	nvme_rdma_error_recovery(ctrl);
+	nvme_rdma_error_recovery(&ctrl->ctrl);
 }
 
 static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -1094,7 +1097,7 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 			dev_err(ctrl->ctrl.device,
 				"Queueing INV WR for rkey %#x failed (%d)\n",
 				req->mr->rkey, res);
-			nvme_rdma_error_recovery(queue->ctrl);
+			nvme_rdma_error_recovery(&queue->ctrl->ctrl);
 		}
 	}
 
@@ -1373,7 +1376,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"tag 0x%x on QP %#x not found\n",
 			cqe->command_id, queue->qp->qp_num);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvme_rdma_error_recovery(&queue->ctrl->ctrl);
 		return ret;
 	}
 	req = blk_mq_rq_to_pdu(rq);
@@ -1584,7 +1587,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
 		dev_dbg(queue->ctrl->ctrl.device,
 			"disconnect received - connection closed\n");
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvme_rdma_error_recovery(&queue->ctrl->ctrl);
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/* device removal is handled via the ib_client API */
@@ -1592,7 +1595,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	default:
 		dev_err(queue->ctrl->ctrl.device,
 			"Unexpected RDMA CM event (%d)\n", ev->event);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvme_rdma_error_recovery(&queue->ctrl->ctrl);
 		break;
 	}
 
@@ -1610,7 +1613,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 
 	/* queue error recovery */
-	nvme_rdma_error_recovery(req->queue->ctrl);
+	nvme_rdma_error_recovery(&req->queue->ctrl->ctrl);
 
 	/* fail with DNR on cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
@@ -1761,102 +1764,101 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
+static void nvme_rdma_shutdown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
+	if (ctrl->queue_count > 1) {
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
 
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(ctrl->admin_q);
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+				nvme_cancel_request, ctrl);
+	blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
 }
 
-static void nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_remove_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_remove_namespaces(&ctrl->ctrl);
+	nvme_remove_namespaces(ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, true);
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
+	nvme_uninit_ctrl(ctrl);
+	nvme_put_ctrl(ctrl);
 }
 
 static void nvme_rdma_del_ctrl_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-				struct nvme_rdma_ctrl, ctrl.delete_work);
+	struct nvme_ctrl *ctrl = container_of(work,
+			struct nvme_ctrl, delete_work);
 
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_ctrl(ctrl);
 	nvme_rdma_remove_ctrl(ctrl);
 }
 
-static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
+static int __nvme_rdma_del_ctrl(struct nvme_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
 		return -EBUSY;
 
-	if (!queue_work(nvme_wq, &ctrl->ctrl.delete_work))
+	if (!queue_work(nvme_wq, &ctrl->delete_work))
 		return -EBUSY;
 
 	return 0;
 }
 
-static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
+static int nvme_rdma_del_ctrl(struct nvme_ctrl *ctrl)
 {
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	int ret = 0;
 
 	/*
 	 * Keep a reference until all work is flushed since
 	 * __nvme_rdma_del_ctrl can free the ctrl mem
 	 */
-	if (!kref_get_unless_zero(&ctrl->ctrl.kref))
+	if (!kref_get_unless_zero(&ctrl->kref))
 		return -EBUSY;
 	ret = __nvme_rdma_del_ctrl(ctrl);
 	if (!ret)
-		flush_work(&ctrl->ctrl.delete_work);
-	nvme_put_ctrl(&ctrl->ctrl);
+		flush_work(&ctrl->delete_work);
+	nvme_put_ctrl(ctrl);
 	return ret;
 }
 
 static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl =
-		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
 	bool changed;
 
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_ctrl(ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
 	ret = nvme_rdma_configure_admin_queue(ctrl, false);
 	if (ret)
 		goto out_fail;
 
-	if (ctrl->ctrl.queue_count > 1) {
+	if (ctrl->queue_count > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
 			goto out_fail;
 	}
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
-	nvme_start_ctrl(&ctrl->ctrl);
+	nvme_start_ctrl(ctrl);
 
 	return;
 
 out_fail:
-	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
+	dev_warn(ctrl->device, "Removing after reset failure\n");
 	nvme_rdma_remove_ctrl(ctrl);
 }
 
@@ -1963,7 +1965,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->ctrl.delete_work, nvme_rdma_del_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ret = nvme_rdma_configure_admin_queue(ctrl, true);
+	ret = nvme_rdma_configure_admin_queue(&ctrl->ctrl, true);
 	if (ret)
 		goto out_uninit_ctrl;
 
@@ -1972,7 +1974,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_uninit_ctrl;
 
 	if (opts->nr_io_queues) {
-		ret = nvme_rdma_configure_io_queues(ctrl, true);
+		ret = nvme_rdma_configure_io_queues(&ctrl->ctrl, true);
 		if (ret)
 			goto out_remove_admin_queue;
 	}
@@ -1994,7 +1996,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	return &ctrl->ctrl;
 
 out_remove_admin_queue:
-	nvme_rdma_destroy_admin_queue(ctrl, true);
+	nvme_rdma_destroy_admin_queue(&ctrl->ctrl, true);
 out_kfree_queues:
 	kfree(ctrl->queues);
 out_uninit_ctrl:
@@ -2032,7 +2034,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 		dev_info(ctrl->ctrl.device,
 			"Removing ctrl: NQN \"%s\", addr %pISp\n",
 			ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
-		__nvme_rdma_del_ctrl(ctrl);
+		__nvme_rdma_del_ctrl(&ctrl->ctrl);
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-- 
2.7.4

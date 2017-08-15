Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753473AbdHOJwu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:50 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 10/12] nvme-fabrics: handle reconnects in fabrics library
Date: Tue, 15 Aug 2017 12:52:23 +0300
Message-Id: <1502790745-12569-11-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Rip the nvme-rdma equivalent.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 103 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |   1 +
 drivers/nvme/host/rdma.c    | 114 +++-----------------------------------------
 3 files changed, 110 insertions(+), 108 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index cf8c6163db9e..8e03360f45b3 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -819,6 +819,105 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
 
+static void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
+{
+	/* If we are resetting/deleting then do nothing */
+	if (ctrl->state != NVME_CTRL_RECONNECTING) {
+		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
+			ctrl->state == NVME_CTRL_LIVE);
+		return;
+	}
+
+	if (nvmf_should_reconnect(ctrl)) {
+		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
+			ctrl->opts->reconnect_delay);
+		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
+				ctrl->opts->reconnect_delay * HZ);
+	} else {
+		dev_info(ctrl->device, "Removing controller...\n");
+		__nvme_del_ctrl(ctrl);
+	}
+}
+
+static void nvmf_reconnect_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, reconnect_work);
+	bool changed;
+	int ret;
+
+	++ctrl->nr_reconnects;
+
+	if (ctrl->queue_count > 1)
+		nvme_destroy_io_queues(ctrl, false);
+
+	nvme_destroy_admin_queue(ctrl, false);
+	ret = nvme_configure_admin_queue(ctrl, false);
+	if (ret)
+		goto requeue;
+
+	if (ctrl->queue_count > 1) {
+		ret = nvme_configure_io_queues(ctrl, false);
+		if (ret)
+			goto requeue;
+	}
+
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+	WARN_ON_ONCE(!changed);
+	ctrl->nr_reconnects = 0;
+
+	nvme_start_ctrl(ctrl);
+
+	dev_info(ctrl->device, "Successfully reconnected\n");
+
+	return;
+
+requeue:
+	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
+			ctrl->nr_reconnects);
+	nvmf_reconnect_or_remove(ctrl);
+}
+
+static void nvmf_error_recovery_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work,
+			struct nvme_ctrl, err_work);
+
+	nvme_stop_keep_alive(ctrl);
+
+	if (ctrl->queue_count > 1) {
+		nvme_stop_queues(ctrl);
+		ctrl->ops->stop_io_queues(ctrl);
+	}
+	blk_mq_quiesce_queue(ctrl->admin_q);
+	ctrl->ops->stop_admin_queue(ctrl);
+
+	/* We must take care of fastfail/requeue all our inflight requests */
+	if (ctrl->queue_count > 1)
+		blk_mq_tagset_busy_iter(ctrl->tagset,
+					nvme_cancel_request, ctrl);
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+				nvme_cancel_request, ctrl);
+
+	/*
+	 * queues are not a live anymore, so restart the queues to fail fast
+	 * new IO
+	 */
+	nvme_start_queues(ctrl);
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+
+	nvmf_reconnect_or_remove(ctrl);
+}
+
+void nvmf_error_recovery(struct nvme_ctrl *ctrl)
+{
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RECONNECTING))
+		return;
+
+	queue_work(nvme_wq, &ctrl->err_work);
+}
+EXPORT_SYMBOL_GPL(nvmf_error_recovery);
+
 #define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
@@ -882,6 +981,10 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 		return ERR_PTR(-EINVAL);
 	}
 
+	INIT_DELAYED_WORK(&ctrl->reconnect_work,
+			nvmf_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->err_work, nvmf_error_recovery_work);
+
 	mutex_unlock(&nvmf_transports_mutex);
 	return ctrl;
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index bf33663218cd..20e9f45b8658 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -140,6 +140,7 @@ int nvmf_register_transport(struct nvmf_transport_ops *ops);
 void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
+void nvmf_error_recovery(struct nvme_ctrl *ctrl);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 
 #endif /* _NVME_FABRICS_H */
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 35459f2eea74..3bdf1ab7c2f3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -799,104 +799,6 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
-static void nvme_rdma_reconnect_or_remove(struct nvme_ctrl *ctrl)
-{
-	/* If we are resetting/deleting then do nothing */
-	if (ctrl->state != NVME_CTRL_RECONNECTING) {
-		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
-			ctrl->state == NVME_CTRL_LIVE);
-		return;
-	}
-
-	if (nvmf_should_reconnect(ctrl)) {
-		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
-			ctrl->opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
-				ctrl->opts->reconnect_delay * HZ);
-	} else {
-		dev_info(ctrl->device, "Removing controller...\n");
-		queue_work(nvme_wq, &ctrl->delete_work);
-	}
-}
-
-static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_ctrl, reconnect_work);
-	bool changed;
-	int ret;
-
-	++ctrl->nr_reconnects;
-
-	if (ctrl->queue_count > 1)
-		nvme_destroy_io_queues(ctrl, false);
-
-	nvme_destroy_admin_queue(ctrl, false);
-	ret = nvme_configure_admin_queue(ctrl, false);
-	if (ret)
-		goto requeue;
-
-	if (ctrl->queue_count > 1) {
-		ret = nvme_configure_io_queues(ctrl, false);
-		if (ret)
-			goto requeue;
-	}
-
-	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
-	ctrl->nr_reconnects = 0;
-
-	nvme_start_ctrl(ctrl);
-
-	dev_info(ctrl->device, "Successfully reconnected\n");
-
-	return;
-
-requeue:
-	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
-			ctrl->nr_reconnects);
-	nvme_rdma_reconnect_or_remove(ctrl);
-}
-
-static void nvme_rdma_error_recovery_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl = container_of(work,
-			struct nvme_ctrl, err_work);
-
-	nvme_stop_ctrl(ctrl);
-
-	if (ctrl->queue_count > 1) {
-		nvme_stop_queues(ctrl);
-		ctrl->ops->stop_io_queues(ctrl);
-	}
-	blk_mq_quiesce_queue(ctrl->admin_q);
-	ctrl->ops->stop_admin_queue(ctrl);
-
-	/* We must take care of fastfail/requeue all our inflight requests */
-	if (ctrl->queue_count > 1)
-		blk_mq_tagset_busy_iter(ctrl->tagset,
-					nvme_cancel_request, ctrl);
-	blk_mq_tagset_busy_iter(ctrl->admin_tagset,
-				nvme_cancel_request, ctrl);
-
-	/*
-	 * queues are not a live anymore, so restart the queues to fail fast
-	 * new IO
-	 */
-	blk_mq_unquiesce_queue(ctrl->admin_q);
-	nvme_start_queues(ctrl);
-
-	nvme_rdma_reconnect_or_remove(ctrl);
-}
-
-static void nvme_rdma_error_recovery(struct nvme_ctrl *ctrl)
-{
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RECONNECTING))
-		return;
-
-	queue_work(nvme_wq, &ctrl->err_work);
-}
-
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 		const char *op)
 {
@@ -908,7 +810,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
 			     ib_wc_status_msg(wc->status), wc->status);
-	nvme_rdma_error_recovery(&ctrl->ctrl);
+	nvmf_error_recovery(&ctrl->ctrl);
 }
 
 static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -959,7 +861,7 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 			dev_err(ctrl->ctrl.device,
 				"Queueing INV WR for rkey %#x failed (%d)\n",
 				req->mr->rkey, res);
-			nvme_rdma_error_recovery(&queue->ctrl->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 		}
 	}
 
@@ -1238,7 +1140,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"tag 0x%x on QP %#x not found\n",
 			cqe->command_id, queue->qp->qp_num);
-		nvme_rdma_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return ret;
 	}
 	req = blk_mq_rq_to_pdu(rq);
@@ -1449,7 +1351,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
 		dev_dbg(queue->ctrl->ctrl.device,
 			"disconnect received - connection closed\n");
-		nvme_rdma_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/* device removal is handled via the ib_client API */
@@ -1457,7 +1359,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	default:
 		dev_err(queue->ctrl->ctrl.device,
 			"Unexpected RDMA CM event (%d)\n", ev->event);
-		nvme_rdma_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	}
 
@@ -1475,7 +1377,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 
 	/* queue error recovery */
-	nvme_rdma_error_recovery(&req->queue->ctrl->ctrl);
+	nvmf_error_recovery(&req->queue->ctrl->ctrl);
 
 	/* fail with DNR on cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
@@ -1730,10 +1632,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	INIT_DELAYED_WORK(&ctrl->ctrl.reconnect_work,
-			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
-
 	ret = nvme_probe_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops, 0);
 	if (!ctrl->queues)
 		goto out_kfree_queues;
-- 
2.7.4

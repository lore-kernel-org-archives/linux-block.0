Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52252 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbdFRPWo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:44 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 26/30] nvme-fabrics: handle reconnects in fabrics library
Date: Sun, 18 Jun 2017 18:22:00 +0300
Message-Id: <1497799324-19598-27-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c | 102 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |   1 +
 drivers/nvme/host/rdma.c    | 112 +++-----------------------------------------
 3 files changed, 109 insertions(+), 106 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bd99bbb1faa3..b543d52f00d0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -813,6 +813,104 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
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
+		queue_work(nvme_wq, &ctrl->delete_work);
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
+	if (ctrl->max_queues > 1)
+		nvme_destroy_io_queues(ctrl, false);
+
+	nvme_destroy_admin_queue(ctrl, false);
+
+	ret = nvme_configure_admin_queue(ctrl, false);
+	if (ret)
+		goto requeue;
+
+	if (ctrl->max_queues > 1) {
+		ret = nvme_configure_io_queues(ctrl, false);
+		if (ret)
+			goto requeue;
+	}
+
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+	WARN_ON_ONCE(!changed);
+	ctrl->nr_reconnects = 0;
+
+	if (ctrl->queue_count > 1) {
+		nvme_queue_scan(ctrl);
+		nvme_queue_async_events(ctrl);
+	}
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
+		nvme_stop_io_queues(ctrl);
+	}
+	blk_mq_stop_hw_queues(ctrl->admin_q);
+	ctrl->ops->stop_hw_queue(ctrl, 0);
+
+	/* We must take care of fastfail/requeue all our inflight requests */
+	if (ctrl->queue_count > 1)
+		blk_mq_tagset_busy_iter(ctrl->tagset,
+					nvme_cancel_request, ctrl);
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+				nvme_cancel_request, ctrl);
+	nvme_start_queues(ctrl);
+	blk_mq_start_stopped_hw_queues(ctrl->admin_q, true);
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
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN)
@@ -866,6 +964,10 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 		goto out_unlock;
 	}
 
+	INIT_DELAYED_WORK(&ctrl->reconnect_work,
+			nvmf_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->err_work, nvmf_error_recovery_work);
+
 	mutex_unlock(&nvmf_transports_mutex);
 	return ctrl;
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index f1c9bd7ae7ff..c8f6ea03e288 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -140,6 +140,7 @@ void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
 const char *nvmf_get_subsysnqn(struct nvme_ctrl *ctrl);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
+void nvmf_error_recovery(struct nvme_ctrl *ctrl);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 
 #endif /* _NVME_FABRICS_H */
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9b8c819f2bd7..4f20ade3f752 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -709,102 +709,6 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
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
-	if (ctrl->max_queues > 1)
-		nvme_destroy_io_queues(ctrl, false);
-
-	nvme_destroy_admin_queue(ctrl, false);
-
-	ret = nvme_configure_admin_queue(ctrl, false);
-	if (ret)
-		goto requeue;
-
-	if (ctrl->max_queues > 1) {
-		ret = nvme_configure_io_queues(ctrl, false);
-		if (ret)
-			goto requeue;
-	}
-
-	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
-	ctrl->nr_reconnects = 0;
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
-	nvme_stop_keep_alive(ctrl);
-
-	if (ctrl->queue_count > 1) {
-		nvme_stop_queues(ctrl);
-		nvme_stop_io_queues(ctrl);
-	}
-	blk_mq_stop_hw_queues(ctrl->admin_q);
-	ctrl->ops->stop_hw_queue(ctrl, 0);
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
-	blk_mq_start_stopped_hw_queues(ctrl->admin_q, true);
-	nvme_start_queues(ctrl);
-
-	nvme_rdma_reconnect_or_remove(ctrl);
-}
-
-static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
-{
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING))
-		return;
-
-	queue_work(nvme_wq, &ctrl->ctrl.err_work);
-}
-
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 		const char *op)
 {
@@ -816,7 +720,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
 			     ib_wc_status_msg(wc->status), wc->status);
-	nvme_rdma_error_recovery(ctrl);
+	nvmf_error_recovery(&ctrl->ctrl);
 }
 
 static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -867,7 +771,7 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 			dev_err(ctrl->ctrl.device,
 				"Queueing INV WR for rkey %#x failed (%d)\n",
 				req->mr->rkey, res);
-			nvme_rdma_error_recovery(queue->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 		}
 	}
 
@@ -1147,7 +1051,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"tag 0x%x on QP %#x not found\n",
 			cqe->command_id, queue->qp->qp_num);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return ret;
 	}
 	req = blk_mq_rq_to_pdu(rq);
@@ -1358,7 +1262,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
 		dev_dbg(queue->ctrl->ctrl.device,
 			"disconnect received - connection closed\n");
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/* device removal is handled via the ib_client API */
@@ -1366,7 +1270,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	default:
 		dev_err(queue->ctrl->ctrl.device,
 			"Unexpected RDMA CM event (%d)\n", ev->event);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	}
 
@@ -1384,7 +1288,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 
 	/* queue error recovery */
-	nvme_rdma_error_recovery(req->queue->ctrl);
+	nvmf_error_recovery(&req->queue->ctrl->ctrl);
 
 	/* fail with DNR on cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
@@ -1628,10 +1532,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		}
 	}
 
-	INIT_DELAYED_WORK(&ctrl->ctrl.reconnect_work,
-			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
-
 	ret = -ENOMEM;
 	ctrl->queues = kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
 				GFP_KERNEL);
-- 
2.7.4

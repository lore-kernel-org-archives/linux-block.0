Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:50535 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdHOJwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:33 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 01/12] nvme: move err and reconnect work to nvme ctrl
Date: Tue, 15 Aug 2017 12:52:14 +0300
Message-Id: <1502790745-12569-2-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In theory, all fabric transports can/should use these.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c |  4 ++++
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/rdma.c | 29 +++++++++++------------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a2ac892f470e..bbaf5b98f2fe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2703,6 +2703,10 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
+		cancel_work_sync(&ctrl->err_work);
+		cancel_delayed_work_sync(&ctrl->reconnect_work);
+	}
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
 	cancel_work_sync(&ctrl->fw_act_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2c8a02be46fd..c52ba1405788 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -186,6 +186,9 @@ struct nvme_ctrl {
 	u16 maxcmd;
 	int nr_reconnects;
 	struct nvmf_ctrl_options *opts;
+	struct delayed_work reconnect_work;
+	struct work_struct delete_work;
+	struct work_struct err_work;
 };
 
 struct nvme_ns {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 74fd62062377..10e54f81e3d9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -105,13 +105,9 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
-	struct work_struct	delete_work;
-	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
 
-	struct delayed_work	reconnect_work;
-
 	struct list_head	list;
 
 	struct blk_mq_tag_set	admin_tag_set;
@@ -908,18 +904,18 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
 			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.reconnect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->ctrl.device, "Removing controller...\n");
-		queue_work(nvme_wq, &ctrl->delete_work);
+		queue_work(nvme_wq, &ctrl->ctrl.delete_work);
 	}
 }
 
 static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_rdma_ctrl, reconnect_work);
+			struct nvme_rdma_ctrl, ctrl.reconnect_work);
 	bool changed;
 	int ret;
 
@@ -958,7 +954,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
-			struct nvme_rdma_ctrl, err_work);
+			struct nvme_rdma_ctrl, ctrl.err_work);
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 
@@ -991,7 +987,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING))
 		return;
 
-	queue_work(nvme_wq, &ctrl->err_work);
+	queue_work(nvme_wq, &ctrl->ctrl.err_work);
 }
 
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
@@ -1725,9 +1721,6 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
-
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
@@ -1758,7 +1751,7 @@ static void nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl)
 static void nvme_rdma_del_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
-				struct nvme_rdma_ctrl, delete_work);
+				struct nvme_rdma_ctrl, ctrl.delete_work);
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_remove_ctrl(ctrl);
@@ -1769,7 +1762,7 @@ static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
 		return -EBUSY;
 
-	if (!queue_work(nvme_wq, &ctrl->delete_work))
+	if (!queue_work(nvme_wq, &ctrl->ctrl.delete_work))
 		return -EBUSY;
 
 	return 0;
@@ -1788,7 +1781,7 @@ static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
 		return -EBUSY;
 	ret = __nvme_rdma_del_ctrl(ctrl);
 	if (!ret)
-		flush_work(&ctrl->delete_work);
+		flush_work(&ctrl->ctrl.delete_work);
 	nvme_put_ctrl(&ctrl->ctrl);
 	return ret;
 }
@@ -1879,10 +1872,10 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_free_ctrl;
 
-	INIT_DELAYED_WORK(&ctrl->reconnect_work,
+	INIT_DELAYED_WORK(&ctrl->ctrl.reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
-	INIT_WORK(&ctrl->delete_work, nvme_rdma_del_ctrl_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.delete_work, nvme_rdma_del_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
-- 
2.7.4

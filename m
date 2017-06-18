Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52208 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:37 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 20/30] nvme: add err, reconnect and delete work items to nvme core
Date: Sun, 18 Jun 2017 18:21:54 +0300
Message-Id: <1497799324-19598-21-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We intent for these handlers to become generic, thus, add them to
the nvme core controller struct.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/nvme.h |  4 +++
 drivers/nvme/host/rdma.c | 69 ++++++++++++++++++++++++------------------------
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5b75f6a81764..c604d471aa3d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -164,6 +164,7 @@ struct nvme_ctrl {
 	bool subsystem;
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
+
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
@@ -181,6 +182,9 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	int nr_reconnects;
+	struct work_struct delete_work;
+	struct work_struct err_work;
+	struct delayed_work reconnect_work;
 	struct nvmf_ctrl_options *opts;
 };
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 753e66c1d77d..6ce5054d4470 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -107,13 +107,9 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
-	struct work_struct	delete_work;
-	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
 
-	struct delayed_work	reconnect_work;
-
 	struct list_head	list;
 
 	struct blk_mq_tag_set	admin_tag_set;
@@ -925,18 +921,19 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
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
-	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_rdma_ctrl, reconnect_work);
+	struct nvme_ctrl *nctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, reconnect_work);
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	bool changed;
 	int ret;
 
@@ -972,8 +969,9 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-			struct nvme_rdma_ctrl, err_work);
+	struct nvme_ctrl *nctrl = container_of(work,
+			struct nvme_ctrl, err_work);
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 
@@ -1006,7 +1004,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING))
 		return;
 
-	queue_work(nvme_wq, &ctrl->err_work);
+	queue_work(nvme_wq, &ctrl->ctrl.err_work);
 }
 
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
@@ -1742,8 +1740,8 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 static void nvme_rdma_teardown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	nvme_stop_keep_alive(&ctrl->ctrl);
-	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
+	cancel_work_sync(&ctrl->ctrl.err_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.reconnect_work);
 
 	if (ctrl->ctrl.max_queues > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
@@ -1765,17 +1763,18 @@ static void nvme_rdma_teardown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 
 static void nvme_rdma_del_ctrl_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-				struct nvme_rdma_ctrl, delete_work);
+	struct nvme_ctrl *nctrl = container_of(work,
+			struct nvme_ctrl, delete_work);
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_rdma_teardown_ctrl(ctrl, true);
 	nvme_put_ctrl(&ctrl->ctrl);
 }
 
-static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
+static int __nvme_rdma_del_ctrl(struct nvme_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
 		return -EBUSY;
 
 	if (!queue_work(nvme_wq, &ctrl->delete_work))
@@ -1784,28 +1783,28 @@ static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
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
 		flush_work(&ctrl->delete_work);
-	nvme_put_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(ctrl);
 	return ret;
 }
 
 static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl =
-		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
+	struct nvme_ctrl *nctrl = container_of(work,
+			struct nvme_ctrl, reset_work);
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	int ret;
 	bool changed;
 
@@ -1866,7 +1865,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
-	ctrl->ctrl.opts = opts;
+
 	INIT_LIST_HEAD(&ctrl->list);
 
 	if (opts->mask & NVMF_OPT_TRSVCID)
@@ -1891,21 +1890,21 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		}
 	}
 
+	ctrl->ctrl.opts = opts;
+	ctrl->ctrl.max_queues = opts->nr_io_queues + 1;
+	ctrl->ctrl.sqsize = opts->queue_size - 1;
+	ctrl->ctrl.kato = opts->kato;
+	INIT_DELAYED_WORK(&ctrl->ctrl.reconnect_work,
+			nvme_rdma_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.delete_work, nvme_rdma_del_ctrl_work);
+	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
+
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
 	if (ret)
 		goto out_free_ctrl;
 
-	INIT_DELAYED_WORK(&ctrl->reconnect_work,
-			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
-	INIT_WORK(&ctrl->delete_work, nvme_rdma_del_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
-
-	ctrl->ctrl.max_queues = opts->nr_io_queues + 1;
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
-	ctrl->ctrl.kato = opts->kato;
-
 	ret = -ENOMEM;
 	ctrl->queues = kcalloc(ctrl->ctrl.max_queues, sizeof(*ctrl->queues),
 				GFP_KERNEL);
@@ -2011,7 +2010,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 		dev_info(ctrl->ctrl.device,
 			"Removing ctrl: NQN \"%s\", addr %pISp\n",
 			ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
-		__nvme_rdma_del_ctrl(ctrl);
+		__nvme_rdma_del_ctrl(&ctrl->ctrl);
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-- 
2.7.4

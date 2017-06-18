Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52226 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:40 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 22/30] nvme-rdma: Split create_ctrl to transport specific and generic parts
Date: Sun, 18 Jun 2017 18:21:56 +0300
Message-Id: <1497799324-19598-23-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Most of create controller are simply setup admin queue and tags, submit a set
of admin commands, allocate io tags, and io queues.

We can make that generic, next we will move stuff into the core.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 160 +++++++++++++++++++++++++++--------------------
 1 file changed, 91 insertions(+), 69 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e656b9b17d67..0036ddcbc138 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1839,6 +1839,41 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_put_ctrl(ctrl);
 }
 
+static int nvme_rdma_verify_ctrl(struct nvme_ctrl *ctrl)
+{
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+
+	/* sanity check icdoff */
+	if (ctrl->icdoff) {
+		dev_err(ctrl->device, "icdoff is not supported!\n");
+		return -EINVAL;
+	}
+
+	/* sanity check keyed sgls */
+	if (!(ctrl->sgls & (1 << 20))) {
+		dev_err(ctrl->device, "Mandatory keyed sgls are not support\n");
+		return -EINVAL;
+	}
+
+	if (opts->queue_size > ctrl->maxcmd) {
+		/* warn if maxcmd is lower than queue_size */
+		dev_warn(ctrl->device,
+			"queue_size %zu > ctrl maxcmd %u, clamping down\n",
+			opts->queue_size, ctrl->maxcmd);
+		opts->queue_size = ctrl->maxcmd;
+	}
+
+	if (opts->queue_size > ctrl->sqsize + 1) {
+		/* warn if sqsize is lower than queue_size */
+		dev_warn(ctrl->device,
+			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			opts->queue_size, ctrl->sqsize + 1);
+		opts->queue_size = ctrl->sqsize + 1;
+	}
+
+	return 0;
+}
+
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
@@ -1853,12 +1888,62 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address		= nvmf_get_address,
 };
 
+static int nvme_rdma_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
+		const struct nvme_ctrl_ops *ops, unsigned long quirks,
+		unsigned int nr_io_queues, size_t queue_size, int kato)
+{
+	bool changed;
+	int ret;
+
+	INIT_WORK(&ctrl->delete_work, nvme_rdma_del_ctrl_work);
+	INIT_WORK(&ctrl->reset_work, nvme_rdma_reset_ctrl_work);
+
+	ctrl->max_queues = nr_io_queues + 1; /* +1 for admin queue */
+	ctrl->sqsize = queue_size - 1; /* 0's based */
+	ctrl->kato = kato;
+
+	ret = nvme_init_ctrl(ctrl, dev, ops, quirks);
+	if (ret)
+		return ret;
+
+	ret = nvme_rdma_configure_admin_queue(ctrl, true);
+	if (ret)
+		goto out_uninit_ctrl;
+
+	ret = nvme_rdma_verify_ctrl(ctrl);
+	if (ret)
+		goto out_remove_admin_queue;
+
+	if (ctrl->max_queues > 1) {
+		ret = nvme_rdma_configure_io_queues(ctrl, true);
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
+	nvme_rdma_destroy_admin_queue(ctrl, true);
+out_uninit_ctrl:
+	nvme_uninit_ctrl(ctrl);
+	return ret;
+}
+
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_rdma_ctrl *ctrl;
 	int ret;
-	bool changed;
 	char *port;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
@@ -1866,6 +1951,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&ctrl->list);
+	ctrl->ctrl.opts = opts;
 
 	if (opts->mask & NVMF_OPT_TRSVCID)
 		port = opts->trsvcid;
@@ -1889,97 +1975,33 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		}
 	}
 
-	ctrl->ctrl.opts = opts;
-	ctrl->ctrl.max_queues = opts->nr_io_queues + 1;
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
-	ctrl->ctrl.kato = opts->kato;
 	INIT_DELAYED_WORK(&ctrl->ctrl.reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.delete_work, nvme_rdma_del_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
-
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
-				0 /* no quirks, we're perfect! */);
-	if (ret)
-		goto out_free_ctrl;
 
 	ret = -ENOMEM;
-	ctrl->queues = kcalloc(ctrl->ctrl.max_queues, sizeof(*ctrl->queues),
+	ctrl->queues = kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues)
-		goto out_uninit_ctrl;
+		goto out_free_ctrl;
 
-	ret = nvme_rdma_configure_admin_queue(&ctrl->ctrl, true);
+	ret = nvme_rdma_probe_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
+			0, opts->nr_io_queues, opts->queue_size, opts->kato);
 	if (ret)
 		goto out_kfree_queues;
 
-	/* sanity check icdoff */
-	if (ctrl->ctrl.icdoff) {
-		dev_err(ctrl->ctrl.device, "icdoff is not supported!\n");
-		ret = -EINVAL;
-		goto out_remove_admin_queue;
-	}
-
-	/* sanity check keyed sgls */
-	if (!(ctrl->ctrl.sgls & (1 << 20))) {
-		dev_err(ctrl->ctrl.device, "Mandatory keyed sgls are not support\n");
-		ret = -EINVAL;
-		goto out_remove_admin_queue;
-	}
-
-	if (opts->queue_size > ctrl->ctrl.maxcmd) {
-		/* warn if maxcmd is lower than queue_size */
-		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl maxcmd %u, clamping down\n",
-			opts->queue_size, ctrl->ctrl.maxcmd);
-		opts->queue_size = ctrl->ctrl.maxcmd;
-	}
-
-	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
-		/* warn if sqsize is lower than queue_size */
-		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			opts->queue_size, ctrl->ctrl.sqsize + 1);
-		opts->queue_size = ctrl->ctrl.sqsize + 1;
-	}
-
-	if (ctrl->ctrl.max_queues > 1) {
-		ret = nvme_rdma_configure_io_queues(&ctrl->ctrl, true);
-		if (ret)
-			goto out_remove_admin_queue;
-	}
-
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
-
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
 		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
 
-	kref_get(&ctrl->ctrl.kref);
-
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	if (ctrl->ctrl.max_queues > 1) {
-		nvme_queue_scan(&ctrl->ctrl);
-		nvme_queue_async_events(&ctrl->ctrl);
-	}
-
 	return &ctrl->ctrl;
 
-out_remove_admin_queue:
-	nvme_stop_keep_alive(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(&ctrl->ctrl, true);
 out_kfree_queues:
 	kfree(ctrl->queues);
-out_uninit_ctrl:
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
-	if (ret > 0)
-		ret = -EIO;
-	return ERR_PTR(ret);
 out_free_ctrl:
 	kfree(ctrl);
 	return ERR_PTR(ret);
-- 
2.7.4

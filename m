Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44559 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbdHOJwp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:45 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 07/12] nvme-rdma: split generic probe out of create_ctrl
Date: Tue, 15 Aug 2017 12:52:20 +0300
Message-Id: <1502790745-12569-8-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This code is replicated for several transports, prepare
to move it to the core.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 81 ++++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2591b0ce155e..b03c4a2a1172 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1908,12 +1908,51 @@ static int nvme_rdma_post_configure(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
+static int nvme_rdma_probe_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
+		const struct nvme_ctrl_ops *ops, unsigned long quirks)
+{
+	bool changed;
+	int ret;
+
+	ret = nvme_init_ctrl(ctrl, dev, ops, quirks);
+	if (ret)
+		return ret;
+
+	INIT_WORK(&ctrl->delete_work, nvme_rdma_del_ctrl_work);
+	INIT_WORK(&ctrl->reset_work, nvme_rdma_reset_ctrl_work);
+
+	ret = nvme_rdma_configure_admin_queue(ctrl, true);
+	if (ret)
+		goto out_uninit_ctrl;
+
+	ret = nvme_rdma_post_configure(ctrl);
+	if (ret)
+		goto out_remove_admin_queue;
+
+	if (ctrl->queue_count > 1) {
+		ret = nvme_rdma_configure_io_queues(ctrl, true);
+		if (ret)
+			goto out_remove_admin_queue;
+	}
+
+	changed = nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+	WARN_ON_ONCE(!changed);
+
+	nvme_start_ctrl(ctrl);
+
+	return 0;
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
@@ -1948,39 +1987,20 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		}
 	}
 
-	ret = -ENOMEM;
 	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
-	if (!ctrl->queues)
+	if (!ctrl->queues) {
+		ret = -ENOMEM;
 		goto out_free_ctrl;
-
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
-				0 /* no quirks, we're perfect! */);
-	if (ret)
-		goto out_kfree_queues;
+	}
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
-	INIT_WORK(&ctrl->ctrl.delete_work, nvme_rdma_del_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
-
-	ret = nvme_rdma_configure_admin_queue(&ctrl->ctrl, true);
-	if (ret)
-		goto out_uninit_ctrl;
-
-	ret = nvme_rdma_post_configure(&ctrl->ctrl);
-	if (ret)
-		goto out_uninit_ctrl;
 
-	if (opts->nr_io_queues) {
-		ret = nvme_rdma_configure_io_queues(&ctrl->ctrl, true);
-		if (ret)
-			goto out_remove_admin_queue;
-	}
-
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
+	ret = nvme_rdma_probe_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops, 0);
+	if (!ctrl->queues)
+		goto out_kfree_queues;
 
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
 		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
@@ -1991,21 +2011,14 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	nvme_start_ctrl(&ctrl->ctrl);
-
 	return &ctrl->ctrl;
 
-out_remove_admin_queue:
-	nvme_rdma_destroy_admin_queue(&ctrl->ctrl, true);
 out_kfree_queues:
 	kfree(ctrl->queues);
-out_uninit_ctrl:
-	nvme_uninit_ctrl(&ctrl->ctrl);
+out_free_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret = -EIO;
-	return ERR_PTR(ret);
-out_free_ctrl:
 	kfree(ctrl);
 	return ERR_PTR(ret);
 }
-- 
2.7.4

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:40857 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbdHOJwj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:39 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 04/12] nvme-rdma: restructure create_ctrl a bit
Date: Tue, 15 Aug 2017 12:52:17 +0300
Message-Id: <1502790745-12569-5-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We'd like to split the generic part out, so rearrange
to ease the split. post_configure will be called after the
controller basic configuration occured and identification.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 89 ++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a0981fd5291c..dc903625a759 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1844,6 +1844,39 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address		= nvmf_get_address,
 };
 
+static int nvme_rdma_post_configure(struct nvme_ctrl *ctrl)
+{
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
+	if (ctrl->opts->queue_size > ctrl->maxcmd) {
+		/* warn if maxcmd is lower than queue_size */
+		dev_warn(ctrl->device,
+			"queue_size %zu > ctrl maxcmd %u, clamping down\n",
+			ctrl->opts->queue_size, ctrl->maxcmd);
+		ctrl->opts->queue_size = ctrl->maxcmd;
+	}
+
+	if (ctrl->opts->queue_size > ctrl->sqsize + 1) {
+		/* warn if sqsize is lower than queue_size */
+		dev_warn(ctrl->device,
+			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			ctrl->opts->queue_size, ctrl->sqsize + 1);
+		ctrl->opts->queue_size = ctrl->sqsize + 1;
+	}
+
+	return 0;
+}
+
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -1855,7 +1888,11 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
+
 	ctrl->ctrl.opts = opts;
+	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
+	ctrl->ctrl.sqsize = opts->queue_size - 1;
+	ctrl->ctrl.kato = opts->kato;
 	INIT_LIST_HEAD(&ctrl->list);
 
 	if (opts->mask & NVMF_OPT_TRSVCID)
@@ -1880,10 +1917,16 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		}
 	}
 
+	ret = -ENOMEM;
+	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
+				GFP_KERNEL);
+	if (!ctrl->queues)
+		goto out_free_ctrl;
+
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
 	if (ret)
-		goto out_free_ctrl;
+		goto out_kfree_queues;
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
@@ -1891,49 +1934,13 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->ctrl.delete_work, nvme_rdma_del_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
-	ctrl->ctrl.kato = opts->kato;
-
-	ret = -ENOMEM;
-	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
-				GFP_KERNEL);
-	if (!ctrl->queues)
-		goto out_uninit_ctrl;
-
 	ret = nvme_rdma_configure_admin_queue(ctrl, true);
 	if (ret)
-		goto out_kfree_queues;
-
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
+		goto out_uninit_ctrl;
 
-	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
-		/* warn if sqsize is lower than queue_size */
-		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			opts->queue_size, ctrl->ctrl.sqsize + 1);
-		opts->queue_size = ctrl->ctrl.sqsize + 1;
-	}
+	ret = nvme_rdma_post_configure(&ctrl->ctrl);
+	if (ret)
+		goto out_uninit_ctrl;
 
 	if (opts->nr_io_queues) {
 		ret = nvme_rdma_configure_io_queues(ctrl, true);
-- 
2.7.4

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52064 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752992AbdFRPWP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:15 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 01/30] nvme: Add admin connect request queue
Date: Sun, 18 Jun 2017 18:21:35 +0300
Message-Id: <1497799324-19598-2-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In case we reconnect with inflight admin IO we
need to make sure that the connect comes before
the admin command. This can be only achieved by
using a seperate request queue for admin connects.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/fc.c      | 11 ++++++++++-
 drivers/nvme/host/nvme.h    |  1 +
 drivers/nvme/host/rdma.c    | 19 ++++++++++++++-----
 drivers/nvme/target/loop.c  | 17 +++++++++++++----
 5 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 64db2c46c5ea..bd99bbb1faa3 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -412,7 +412,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res,
+	ret = __nvme_submit_sync_cmd(ctrl->admin_connect_q, &cmd, &res,
 			data, sizeof(*data), 0, NVME_QID_ANY, 1,
 			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5d5ecefd8dbe..25ee49037edb 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1703,6 +1703,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	list_del(&ctrl->ctrl_list);
 	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
+	blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
 
@@ -2745,6 +2746,12 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto out_free_admin_tag_set;
 	}
 
+	ctrl->ctrl.admin_connect_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+	if (IS_ERR(ctrl->ctrl.admin_connect_q)) {
+		ret = PTR_ERR(ctrl->ctrl.admin_connect_q);
+		goto out_cleanup_admin_q;
+	}
+
 	/*
 	 * Would have been nice to init io queues tag set as well.
 	 * However, we require interaction from the controller
@@ -2754,7 +2761,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops, 0);
 	if (ret)
-		goto out_cleanup_admin_q;
+		goto out_cleanup_admin_connect_q;
 
 	/* at this point, teardown path changes to ref counting on nvme ctrl */
 
@@ -2791,6 +2798,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	return &ctrl->ctrl;
 
+out_cleanup_admin_connect_q:
+	blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
 out_cleanup_admin_q:
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_admin_tag_set:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f27c58b860f4..67147b49d992 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -121,6 +121,7 @@ struct nvme_ctrl {
 	const struct nvme_ctrl_ops *ops;
 	struct request_queue *admin_q;
 	struct request_queue *connect_q;
+	struct request_queue *admin_connect_q;
 	struct device *dev;
 	struct kref kref;
 	int instance;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7533138d2244..cb7f81d9098f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -661,6 +661,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 	nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
+	blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
 	nvme_rdma_dev_put(ctrl->device);
@@ -1583,9 +1584,15 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 		goto out_free_tagset;
 	}
 
+	ctrl->ctrl.admin_connect_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+	if (IS_ERR(ctrl->ctrl.admin_connect_q)) {
+		error = PTR_ERR(ctrl->ctrl.admin_connect_q);
+		goto out_cleanup_queue;
+	}
+
 	error = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_connect_queue;
 
 	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
 
@@ -1593,7 +1600,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	if (error) {
 		dev_err(ctrl->ctrl.device,
 			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_queue;
+		goto out_cleanup_connect_queue;
 	}
 
 	ctrl->ctrl.sqsize =
@@ -1601,25 +1608,27 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 
 	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_connect_queue;
 
 	ctrl->ctrl.max_hw_sectors =
 		(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_connect_queue;
 
 	error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
 			&ctrl->async_event_sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_connect_queue;
 
 	nvme_start_keep_alive(&ctrl->ctrl);
 
 	return 0;
 
+out_cleanup_connect_queue:
+	blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
 out_cleanup_queue:
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_tagset:
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 86c09e2a1490..edd9ee04de02 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -278,6 +278,7 @@ static const struct blk_mq_ops nvme_loop_admin_mq_ops = {
 static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
+	blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
 }
@@ -384,15 +385,21 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 		goto out_free_tagset;
 	}
 
+	ctrl->ctrl.admin_connect_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+	if (IS_ERR(ctrl->ctrl.admin_connect_q)) {
+		error = PTR_ERR(ctrl->ctrl.admin_connect_q);
+		goto out_cleanup_queue;
+	}
+
 	error = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_connect_queue;
 
 	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->cap);
 	if (error) {
 		dev_err(ctrl->ctrl.device,
 			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_queue;
+		goto out_cleanup_connect_queue;
 	}
 
 	ctrl->ctrl.sqsize =
@@ -400,19 +407,21 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_connect_queue;
 
 	ctrl->ctrl.max_hw_sectors =
 		(NVME_LOOP_MAX_SEGMENTS - 1) << (PAGE_SHIFT - 9);
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_connect_queue;
 
 	nvme_start_keep_alive(&ctrl->ctrl);
 
 	return 0;
 
+out_cleanup_connect_queue:
+	blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
 out_cleanup_queue:
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_tagset:
-- 
2.7.4

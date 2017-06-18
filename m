Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52142 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:27 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 12/30] nvme-rdma: disable controller in reset instead of shutdown
Date: Sun, 18 Jun 2017 18:21:46 +0300
Message-Id: <1497799324-19598-13-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For controller resets we can avoid a full controller shutdown.
This makes rdma similar to pci.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cd637e28647b..34518c90609a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1720,7 +1720,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
+static void nvme_rdma_teardown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	cancel_work_sync(&ctrl->err_work);
@@ -1733,8 +1733,12 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
 
-	if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags))
-		nvme_shutdown_ctrl(&ctrl->ctrl);
+	if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags)) {
+		if (shutdown)
+			nvme_shutdown_ctrl(&ctrl->ctrl);
+		else
+			nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
+	}
 
 	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
@@ -1748,7 +1752,7 @@ static void nvme_rdma_del_ctrl_work(struct work_struct *work)
 				struct nvme_rdma_ctrl, delete_work);
 
 	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl, true);
+	nvme_rdma_teardown_ctrl(ctrl, true);
 	nvme_put_ctrl(&ctrl->ctrl);
 }
 
@@ -1788,7 +1792,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	int ret;
 	bool changed;
 
-	nvme_rdma_shutdown_ctrl(ctrl, false);
+	nvme_rdma_teardown_ctrl(ctrl, false);
 
 	ret = nvme_rdma_configure_admin_queue(ctrl, false);
 	if (ret)
-- 
2.7.4

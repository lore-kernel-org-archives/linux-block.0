Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52166 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:30 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 15/30] nvme-rdma: don't check queue state for shutdown/disable
Date: Sun, 18 Jun 2017 18:21:49 +0300
Message-Id: <1497799324-19598-16-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If the queue is not ready, it will be rejected in queue_rq

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index fbe2ca4f4ba3..700aef42c4f2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1730,12 +1730,10 @@ static void nvme_rdma_teardown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
 
-	if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags)) {
-		if (shutdown)
-			nvme_shutdown_ctrl(&ctrl->ctrl);
-		else
-			nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
-	}
+	if (shutdown)
+		nvme_shutdown_ctrl(&ctrl->ctrl);
+	else
+		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 
 	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-- 
2.7.4

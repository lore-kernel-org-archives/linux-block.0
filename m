Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52086 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdFRPWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:17 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 05/30] nvme-rdma: introduce nvme_rdma_start_queue
Date: Sun, 18 Jun 2017 18:21:39 +0300
Message-Id: <1497799324-19598-6-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This should pair with nvme_rdma_stop_queue. While this
is not a complete 1x1 reverse, it still pairs up pretty
well because in fabrics we don't have a disconnect capsule
but we simply teardown the transport association.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bbe39dd378b5..69ebfb61d599 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -606,24 +606,38 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl, bool remove
 	nvme_rdma_free_io_queues(ctrl);
 }
 
-static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
+{
+	int ret;
+
+	if (idx)
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx);
+	else
+		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
+
+	if (ret)
+		dev_info(ctrl->ctrl.device,
+			"failed to connect queue: %d ret=%d\n", idx, ret);
+	return ret;
+}
+
+static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	int i, ret = 0;
 
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
-		if (ret) {
-			dev_info(ctrl->ctrl.device,
-				"failed to connect i/o queue: %d\n", ret);
+		ret = nvme_rdma_start_queue(ctrl, i);
+		if (ret)
 			goto out_stop_queues;
-		}
+
 		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
 	return 0;
 
 out_stop_queues:
-	nvme_rdma_stop_io_queues(ctrl);
+	for (i--; i >= 1; i--)
+		nvme_rdma_stop_queue(&ctrl->queues[i]);
 	return ret;
 }
 
@@ -719,7 +733,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			goto out_free_io_queues;
 	}
 
-	ret = nvme_rdma_connect_io_queues(ctrl);
+	ret = nvme_rdma_start_io_queues(ctrl);
 	if (ret)
 		goto out_cleanup_connect_q;
 
@@ -807,7 +821,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 			goto out_free_queue;
 	}
 
-	error = nvmf_connect_admin_queue(&ctrl->ctrl);
+	error = nvme_rdma_start_queue(ctrl, 0);
 	if (error)
 		goto out_cleanup_connect_queue;
 
-- 
2.7.4

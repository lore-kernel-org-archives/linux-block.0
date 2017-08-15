Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbdHOJwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:37 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 03/12] nvme-rdma: split nvme_rdma_alloc_io_queues
Date: Tue, 15 Aug 2017 12:52:16 +0300
Message-Id: <1502790745-12569-4-git-send-email-sagi@grimberg.me>
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We're going to call it from the core, so split
nr_io_queues setting to the call-sites.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d94b4df364a5..a0981fd5291c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -643,12 +643,11 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
+static unsigned int nvme_rdma_nr_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 	struct ib_device *ibdev = ctrl->device->dev;
 	unsigned int nr_io_queues;
-	int i, ret;
 
 	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
 
@@ -660,16 +659,12 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	nr_io_queues = min_t(unsigned int, nr_io_queues,
 				ibdev->num_comp_vectors);
 
-	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
-	if (ret)
-		return ret;
-
-	ctrl->ctrl.queue_count = nr_io_queues + 1;
-	if (ctrl->ctrl.queue_count < 2)
-		return 0;
+	return nr_io_queues;
+}
 
-	dev_info(ctrl->ctrl.device,
-		"creating %d I/O queues.\n", nr_io_queues);
+static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
+{
+	int i, ret;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
 		ret = nvme_rdma_alloc_queue(ctrl, i,
@@ -838,8 +833,21 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 
 static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
+	unsigned int nr_io_queues;
 	int ret;
 
+	nr_io_queues = nvme_rdma_nr_io_queues(ctrl);
+	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
+	if (ret)
+		return ret;
+
+	ctrl->ctrl.queue_count = nr_io_queues + 1;
+	if (ctrl->ctrl.queue_count < 2)
+		return 0;
+
+	dev_info(ctrl->ctrl.device,
+		"creating %d I/O queues.\n", nr_io_queues);
+
 	ret = nvme_rdma_alloc_io_queues(ctrl);
 	if (ret)
 		return ret;
-- 
2.7.4

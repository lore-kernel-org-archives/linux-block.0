Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] nvme: move the workaround for I/O queue-less controllers from PCIe to core
Date: Mon,  6 Jun 2016 23:20:50 +0200
Message-Id: <1465248052-17811-9-git-send-email-hch@lst.de>
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

We want to apply this to Fabrics drivers as well, so move it to common
code.

Reviewed-by: Jay Freyensee <james.p.freyensee@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Ming Lin <ming.l@ssi.samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 17 ++++++++++++++---
 drivers/nvme/host/pci.c  | 10 +---------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ffd9910..972029a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -557,11 +557,22 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 
 	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, 0,
 			&result);
-	if (status)
+	if (status < 0)
 		return status;
 
-	nr_io_queues = min(result & 0xffff, result >> 16) + 1;
-	*count = min(*count, nr_io_queues);
+	/*
+	 * Degraded controllers might return an error when setting the queue
+	 * count.  We still want to be able to bring them online and offer
+	 * access to the admin queue, as that might be only way to fix them up.
+	 */
+	if (status > 0) {
+		dev_err(ctrl->dev, "Could not set queue count (%d)\n", status);
+		*count = 0;
+	} else {
+		nr_io_queues = min(result & 0xffff, result >> 16) + 1;
+		*count = min(*count, nr_io_queues);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 78dca31..cf7ea73 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1399,16 +1399,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (result < 0)
 		return result;
 
-	/*
-	 * Degraded controllers might return an error when setting the queue
-	 * count.  We still want to be able to bring them online and offer
-	 * access to the admin queue, as that might be only way to fix them up.
-	 */
-	if (result > 0) {
-		dev_err(dev->ctrl.device,
-			"Could not set queue count (%d)\n", result);
+	if (nr_io_queues == 0)
 		return 0;
-	}
 
 	if (dev->cmb && NVME_CMB_SQS(dev->cmbsz)) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
-- 
2.1.4

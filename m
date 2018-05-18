Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/6] nvme-pci: Fix queue freeze criteria on reset
Date: Fri, 18 May 2018 10:38:19 -0600
Message-Id: <20180518163823.27820-2-keith.busch@intel.com>
In-Reply-To: <20180518163823.27820-1-keith.busch@intel.com>
References: <20180518163823.27820-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The driver had been relying on the pci_dev to maintain the state of
the pci device to know when starting a freeze would be appropriate. The
blktests block/011 however shows us that users may alter the state of
pci_dev out from under drivers and break the criteria we had been using.

This patch uses the private nvme controller struct to track the
enabling/disabling state. Since we're relying on that now, the reset will
unconditionally disable the device on reset. This is necessary anyway
on a controller failure reset, and was already being done in the reset
during admin bring up, and is not harmful to do a second time.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/pci.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8da63402d474..2bd9d84f58d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2196,24 +2196,22 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (pci_is_enabled(pdev)) {
+	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE &&
+	    (dev->ctrl.state == NVME_CTRL_LIVE ||
+	     dev->ctrl.state == NVME_CTRL_RESETTING)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING)
-			nvme_start_freeze(&dev->ctrl);
+		nvme_start_freeze(&dev->ctrl);
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
-			pdev->error_state  != pci_channel_io_normal);
+			pci_channel_offline(pdev) || !pci_is_enabled(pdev));
 	}
 
 	/*
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead) {
-		if (shutdown)
-			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
-	}
+	if (!dead && shutdown)
+		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
 	nvme_stop_queues(&dev->ctrl);
 
@@ -2227,8 +2225,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		if (dev->host_mem_descs)
 			nvme_set_host_mem(dev, 0);
 		nvme_disable_io_queues(dev);
-		nvme_disable_admin_queue(dev, shutdown);
 	}
+	nvme_disable_admin_queue(dev, shutdown);
 	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
 		nvme_suspend_queue(&dev->queues[i]);
 
-- 
2.14.3

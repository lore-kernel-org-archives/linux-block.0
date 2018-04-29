Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 3/5] nvme: pci: only wait freezing if queue is frozen
Date: Sun, 29 Apr 2018 23:41:50 +0800
Message-Id: <20180429154152.16656-4-ming.lei@redhat.com>
In-Reply-To: <20180429154152.16656-1-ming.lei@redhat.com>
References: <20180429154152.16656-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

In nvme_dev_disable() called during shutting down controler,
nvme_wait_freeze_timeout() may be done on the controller not
frozen yet, so add the check for avoiding the case.

Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0e6cd605164a..8172ee584130 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2240,14 +2240,17 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	int i;
 	bool dead = true;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	bool frozen = false;
 
 	mutex_lock(&dev->shutdown_lock);
 	if (pci_is_enabled(pdev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING)
+		    dev->ctrl.state == NVME_CTRL_RESETTING) {
 			nvme_start_freeze(&dev->ctrl);
+			frozen = true;
+		}
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
 			pdev->error_state  != pci_channel_io_normal);
 	}
@@ -2257,7 +2260,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * doing a safe shutdown.
 	 */
 	if (!dead) {
-		if (shutdown)
+		if (shutdown && frozen)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
 
-- 
2.9.5

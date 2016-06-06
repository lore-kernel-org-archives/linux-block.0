Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lin <ming.l@samsung.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 09/10] nvme: update nvme_cancel_io() a bit
Date: Mon,  6 Jun 2016 23:20:51 +0200
Message-Id: <1465248052-17811-10-git-send-email-hch@lst.de>
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Ming Lin <ming.l@samsung.com>

Pass in nvme_ctrl, so it can be used by the fabrics drivers also.
Also update to upstream version and rename it to nvme_cancel_request.

Signed-off-by: Ming Lin <ming.l@samsung.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cf7ea73..5ae5804 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -919,14 +919,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	return BLK_EH_RESET_TIMER;
 }
 
-static void nvme_cancel_io(struct request *req, void *data, bool reserved)
+static void nvme_cancel_request(struct request *req, void *data, bool reserved)
 {
 	int status;
 
 	if (!blk_mq_request_started(req))
 		return;
 
-	dev_dbg_ratelimited(((struct nvme_dev *) data)->ctrl.device,
+	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
 
 	status = NVME_SC_ABORT_REQ;
@@ -1714,8 +1714,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	}
 	nvme_pci_disable(dev);
 
-	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_io, dev);
-	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_io, dev);
+	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
+	blk_mq_tagset_busy_iter(&dev->admin_tagset,
+				nvme_cancel_request, &dev->ctrl);
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-- 
2.1.4

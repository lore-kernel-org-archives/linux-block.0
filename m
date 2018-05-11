Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>
Subject: [PATCH V5 6/9] nvme: pci: move error handling out of nvme_reset_dev()
Date: Fri, 11 May 2018 20:29:30 +0800
Message-Id: <20180511122933.27155-7-ming.lei@redhat.com>
In-Reply-To: <20180511122933.27155-1-ming.lei@redhat.com>
References: <20180511122933.27155-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Once nested EH is introduced, we may not need to handle error
in the inner EH, so move error handling out of nvme_reset_dev().

Meantime return the reset result to caller.

Cc: James Smart <james.smart@broadcom.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a924246ffdb6..d880356feee2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2365,7 +2365,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 		nvme_put_ctrl(&dev->ctrl);
 }
 
-static void nvme_reset_dev(struct nvme_dev *dev)
+static int nvme_reset_dev(struct nvme_dev *dev)
 {
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
@@ -2459,6 +2459,7 @@ static void nvme_reset_dev(struct nvme_dev *dev)
 		nvme_unfreeze(&dev->ctrl);
 	}
 
+	result = -ENODEV;
 	/*
 	 * If only admin queue live, keep it to do further investigation or
 	 * recovery.
@@ -2470,19 +2471,22 @@ static void nvme_reset_dev(struct nvme_dev *dev)
 	}
 
 	nvme_start_ctrl(&dev->ctrl);
-	return;
+	return 0;
 
  out:
-	nvme_remove_dead_ctrl(dev, result);
+	return result;
 }
 
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev =
 		container_of(work, struct nvme_dev, ctrl.reset_work);
+	int result;
 
 	mutex_lock(&dev->ctrl.reset_lock);
-	nvme_reset_dev(dev);
+	result = nvme_reset_dev(dev);
+	if (result)
+		nvme_remove_dead_ctrl(dev, result);
 	mutex_unlock(&dev->ctrl.reset_lock);
 }
 
-- 
2.9.5

Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>
Subject: [PATCH V4 6/7] nvme: pci: prepare for supporting error recovery from resetting context
Date: Sat,  5 May 2018 21:59:04 +0800
Message-Id: <20180505135905.18815-7-ming.lei@redhat.com>
In-Reply-To: <20180505135905.18815-1-ming.lei@redhat.com>
References: <20180505135905.18815-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Either the admin or normal IO in reset context may be timed out because
controller error happens. When this timeout happens, we may have to
start controller recovery again.

This patch holds the introduced reset lock when running reset, so that
we may support nested reset in the following patches.

Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1fafe5d01355..2fbe24274ad0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2365,14 +2365,14 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 		nvme_put_ctrl(&dev->ctrl);
 }
 
-static void nvme_reset_work(struct work_struct *work)
+static void nvme_reset_dev(struct nvme_dev *dev)
 {
-	struct nvme_dev *dev =
-		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
 	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
 
+	mutex_lock(&dev->ctrl.reset_lock);
+
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
 		goto out;
 
@@ -2448,7 +2448,11 @@ static void nvme_reset_work(struct work_struct *work)
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
 		nvme_start_queues(&dev->ctrl);
+		mutex_unlock(&dev->ctrl.reset_lock);
+
 		nvme_wait_freeze(&dev->ctrl);
+
+		mutex_lock(&dev->ctrl.reset_lock);
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
@@ -2466,10 +2470,20 @@ static void nvme_reset_work(struct work_struct *work)
 	}
 
 	nvme_start_ctrl(&dev->ctrl);
+	mutex_unlock(&dev->ctrl.reset_lock);
 	return;
 
  out:
 	nvme_remove_dead_ctrl(dev, result);
+	mutex_unlock(&dev->ctrl.reset_lock);
+}
+
+static void nvme_reset_work(struct work_struct *work)
+{
+	struct nvme_dev *dev =
+		container_of(work, struct nvme_dev, ctrl.reset_work);
+
+	nvme_reset_dev(dev);
 }
 
 static void nvme_remove_dead_ctrl_work(struct work_struct *work)
-- 
2.9.5

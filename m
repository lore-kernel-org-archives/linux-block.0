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
Subject: [PATCH V3 6/8] nvme: pci: split controller resetting into two parts
Date: Thu,  3 May 2018 11:17:14 +0800
Message-Id: <20180503031716.31446-7-ming.lei@redhat.com>
In-Reply-To: <20180503031716.31446-1-ming.lei@redhat.com>
References: <20180503031716.31446-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This patch splits controller resetting into the following two parts:

1) the real resetting part

2) the 2nd part for draining IO and updating controller state

The patch prepares for supporting reliable controller recovery, for
example, IO timeout still may be triggered when running the above part 2,
so we still have to recover hardware under this situation.

No functional change.

Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ef80e064a62c..16d7507bfd79 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2361,16 +2361,10 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 		nvme_put_ctrl(&dev->ctrl);
 }
 
-static void nvme_reset_work(struct work_struct *work)
+static int nvme_pre_reset_dev(struct nvme_dev *dev)
 {
-	struct nvme_dev *dev =
-		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
-	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
-
-	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
-		goto out;
 
 	/*
 	 * If we're called to reset a live controller first shut it down before
@@ -2430,8 +2424,13 @@ static void nvme_reset_work(struct work_struct *work)
 	}
 
 	result = nvme_setup_io_queues(dev);
-	if (result)
-		goto out;
+ out:
+	return result;
+}
+
+static void nvme_post_reset_dev(struct nvme_dev *dev)
+{
+	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
 
 	/*
 	 * Keep the controller around but remove all namespaces if we don't have
@@ -2465,7 +2464,25 @@ static void nvme_reset_work(struct work_struct *work)
 	return;
 
  out:
-	nvme_remove_dead_ctrl(dev, result);
+	nvme_remove_dead_ctrl(dev, 0);
+}
+
+static void nvme_reset_work(struct work_struct *work)
+{
+	struct nvme_dev *dev =
+		container_of(work, struct nvme_dev, ctrl.reset_work);
+	int ret;
+
+	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
+		return;
+
+	ret = nvme_pre_reset_dev(dev);
+	if (ret) {
+		nvme_remove_dead_ctrl(dev, ret);
+		return;
+	}
+
+	nvme_post_reset_dev(dev);
 }
 
 static void nvme_remove_dead_ctrl_work(struct work_struct *work)
-- 
2.9.5

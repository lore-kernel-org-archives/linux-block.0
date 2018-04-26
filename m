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
Subject: [PATCH 2/2] nvme: pci: guarantee EH can make progress
Date: Thu, 26 Apr 2018 20:39:56 +0800
Message-Id: <20180426123956.26039-3-ming.lei@redhat.com>
In-Reply-To: <20180426123956.26039-1-ming.lei@redhat.com>
References: <20180426123956.26039-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

When handling error/timeout, it still needs to send commands to admin
queue, and these commands can be timed out too, then EH handler may
never move on for dealing with this situation.

Actually it doesn't need to handle these admin commands after controller
is recovered because all these requests are marked as FAIL_FAST_DRIVER.

So this patch returns BLK_EH_HANDLED for these requests in
nvme_timeout().

Meantime log this failure when it happens.

Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5d05a04f8e72..1e058deb4718 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1265,6 +1265,20 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_command cmd;
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
+	/*
+	 * If error recovery is in-progress and this request needn't to
+	 * be retried, return BLK_EH_HANDLED immediately, so that error
+	 * handler kthread can always make progress since we still need
+	 * to send FAILFAST request to admin queue for handling error.
+	 */
+	spin_lock(&dev->eh_lock);
+	if (dev->eh_in_recovery && blk_noretry_request(req)) {
+		spin_unlock(&dev->eh_lock);
+		nvme_req(req)->status |= NVME_SC_DNR;
+		return BLK_EH_HANDLED;
+	}
+	spin_unlock(&dev->eh_lock);
+
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
 	 */
@@ -2106,7 +2120,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	return 0;
 }
 
-static void nvme_disable_io_queues(struct nvme_dev *dev)
+static int nvme_disable_io_queues(struct nvme_dev *dev)
 {
 	int pass, queues = dev->online_queues - 1;
 	unsigned long timeout;
@@ -2125,12 +2139,14 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 		while (sent--) {
 			timeout = wait_for_completion_io_timeout(&dev->ioq_wait, timeout);
 			if (timeout == 0)
-				return;
+				return -EIO;
 			if (i)
 				goto retry;
 		}
 		opcode = nvme_admin_delete_cq;
 	}
+
+	return 0;
 }
 
 /*
@@ -2302,6 +2318,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
+		int ret = 0;
 		/*
 		 * If the controller is still alive tell it to stop using the
 		 * host memory buffer.  In theory the shutdown / reset should
@@ -2309,8 +2326,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		 * but I'd rather be safe than sorry..
 		 */
 		if (dev->host_mem_descs)
-			nvme_set_host_mem(dev, 0);
-		nvme_disable_io_queues(dev);
+			ret = nvme_set_host_mem(dev, 0);
+		ret |= nvme_disable_io_queues(dev);
+		if (ret)
+			dev_warn(dev->ctrl.device, "fail to configure dev\n");
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
-- 
2.9.5

Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Linux NVMe <linux-nvme@lists.infradead.org>,
	Linux Block <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/3] nvme-pci: Remove unused queue parameter
Date: Tue, 27 Mar 2018 09:39:07 -0600
Message-Id: <20180327153908.3732-2-keith.busch@intel.com>
In-Reply-To: <20180327153908.3732-1-keith.busch@intel.com>
References: <20180327153908.3732-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

All the queue memory is allocated up front. We don't take the node
into consideration when creating queues anymore, so removing the unused
parameter.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v1 -> v2:

   Added review.

 drivers/nvme/host/pci.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e3b9efca0571..cc47fbe32ea5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1379,8 +1379,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 	return 0;
 }
 
-static int nvme_alloc_queue(struct nvme_dev *dev, int qid,
-		int depth, int node)
+static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 {
 	struct nvme_queue *nvmeq = &dev->queues[qid];
 
@@ -1595,8 +1594,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	if (result < 0)
 		return result;
 
-	result = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH,
-			dev_to_node(dev->dev));
+	result = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH);
 	if (result)
 		return result;
 
@@ -1629,9 +1627,7 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	int ret = 0;
 
 	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
-		/* vector == qid - 1, match nvme_create_queue */
-		if (nvme_alloc_queue(dev, i, dev->q_depth,
-		     pci_irq_get_node(to_pci_dev(dev->dev), i - 1))) {
+		if (nvme_alloc_queue(dev, i, dev->q_depth)) {
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.14.3

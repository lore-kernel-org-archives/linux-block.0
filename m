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
Subject: [PATCH 3/3] nvme-pci: Separate IO and admin queue IRQ vectors
Date: Fri, 23 Mar 2018 16:19:23 -0600
Message-Id: <20180323221923.24545-3-keith.busch@intel.com>
In-Reply-To: <20180323221923.24545-1-keith.busch@intel.com>
References: <20180323221923.24545-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

From: Jianchao Wang <jianchao.w.wang@oracle.com>

The admin and first IO queues shared the first irq vector, which has an
affinity mask including cpu0. If a system allows cpu0 to be offlined,
the admin queue may not be usable if no other CPUs in the affinity mask
are online. This is a problem since unlike IO queues, there is only
one admin queue that always needs to be usable.

To fix, this patch allocates one pre_vector for the admin queue that
is assigned all CPUs, so will always be accessible. The IO queues are
assigned the remaining managed vectors.

In case a controller has only one interrupt vector available, the admin
and IO queues will share the pre_vector with all CPUs assigned.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
[changelog, code comments, merge, and blk-mq pci vector offset]
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/pci.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 632166f7d8f2..7b31bc01df6c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -84,6 +84,7 @@ struct nvme_dev {
 	struct dma_pool *prp_small_pool;
 	unsigned online_queues;
 	unsigned max_qid;
+	unsigned int num_vecs;
 	int q_depth;
 	u32 db_stride;
 	void __iomem *bar;
@@ -139,6 +140,16 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_dev, ctrl);
 }
 
+static inline unsigned int nvme_ioq_vector(struct nvme_dev *dev,
+		unsigned int qid)
+{
+	/*
+	 * A queue's vector matches the queue identifier unless the controller
+	 * has only one vector available.
+	 */
+	return (dev->num_vecs == 1) ? 0 : qid;
+}
+
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
  * commands and one for I/O commands).
@@ -414,7 +425,8 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_dev *dev = set->driver_data;
 
-	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev));
+	return __blk_mq_pci_map_queues(set, to_pci_dev(dev->dev),
+				       dev->num_vecs > 1);
 }
 
 /**
@@ -1455,7 +1467,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 		nvmeq->sq_cmds_io = dev->cmb + offset;
 	}
 
-	nvmeq->cq_vector = qid - 1;
+	nvmeq->cq_vector = nvme_ioq_vector(dev, qid);
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
 		goto release_vector;
@@ -1908,6 +1920,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues;
 	unsigned long size;
+	struct irq_affinity affd = {.pre_vectors = 1};
+	int ret;
 
 	nr_io_queues = num_present_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
@@ -1944,11 +1958,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * setting up the full range we need.
 	 */
 	pci_free_irq_vectors(pdev);
-	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
-			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
-	if (nr_io_queues <= 0)
+	ret = pci_alloc_irq_vectors_affinity(pdev, 1, (nr_io_queues + 1),
+			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+	if (ret <= 0)
 		return -EIO;
-	dev->max_qid = nr_io_queues;
+	dev->num_vecs = ret;
+	dev->max_qid = max(ret - 1, 1);
 
 	/*
 	 * Should investigate if there's a performance win from allocating
-- 
2.14.3

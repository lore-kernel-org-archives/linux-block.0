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
Date: Tue, 27 Mar 2018 09:39:08 -0600
Message-Id: <20180327153908.3732-3-keith.busch@intel.com>
In-Reply-To: <20180327153908.3732-1-keith.busch@intel.com>
References: <20180327153908.3732-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

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

Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v1 -> v2:

  Update to use new blk-mq API.

  Removed unnecessary braces, inline functions, and temp variables.

  Amended author (this has evolved significantly from the original).

 drivers/nvme/host/pci.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cc47fbe32ea5..50c8eaf51d92 100644
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
@@ -414,7 +415,8 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_dev *dev = set->driver_data;
 
-	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
+	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev),
+				     dev->num_vecs > 1);
 }
 
 /**
@@ -1455,7 +1457,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 		nvmeq->sq_cmds_io = dev->cmb + offset;
 	}
 
-	nvmeq->cq_vector = qid - 1;
+	/*
+	 * A queue's vector matches the queue identifier unless the controller
+	 * has only one vector available.
+	 */
+	nvmeq->cq_vector = dev->num_vecs == 1 ? 0 : qid;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
 		goto release_vector;
@@ -1909,6 +1915,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	int result, nr_io_queues;
 	unsigned long size;
 
+	struct irq_affinity affd = {
+		.pre_vectors = 1
+	};
+
 	nr_io_queues = num_present_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
@@ -1944,11 +1954,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * setting up the full range we need.
 	 */
 	pci_free_irq_vectors(pdev);
-	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
-			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
-	if (nr_io_queues <= 0)
+	result = pci_alloc_irq_vectors_affinity(pdev, 1, nr_io_queues + 1,
+			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+	if (result <= 0)
 		return -EIO;
-	dev->max_qid = nr_io_queues;
+	dev->num_vecs = result;
+	dev->max_qid = max(result - 1, 1);
 
 	/*
 	 * Should investigate if there's a performance win from allocating
-- 
2.14.3

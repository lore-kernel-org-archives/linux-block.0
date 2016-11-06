Return-Path: <BATV+fbdc7abeb5f03b4a914d+4823+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: add a first_vec argument to blk_mq_pci_map_queues
Date: Sun,  6 Nov 2016 15:07:26 -0800
Message-Id: <1478473646-12524-3-git-send-email-hch@lst.de>
In-Reply-To: <1478473646-12524-1-git-send-email-hch@lst.de>
References: <1478473646-12524-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This allows skipping the first N IRQ vectors in case they are used for
control or admin interrupts.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-pci.c         | 6 ++++--
 drivers/nvme/host/pci.c    | 2 +-
 include/linux/blk-mq-pci.h | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index 966c216..03ff7c4 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -21,6 +21,7 @@
  * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
  * @set:	tagset to provide the mapping for
  * @pdev:	PCI device associated with @set.
+ * @first_vec:	first interrupt vectors to use for queues (usually 0)
  *
  * This function assumes the PCI device @pdev has at least as many available
  * interrupt vetors as @set has queues.  It will then queuery the vector
@@ -28,12 +29,13 @@
  * that maps a queue to the CPUs that have irq affinity for the corresponding
  * vector.
  */
-int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
+int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
+		int first_vec)
 {
 	const struct cpumask *mask;
 	unsigned int queue, cpu;
 
-	for (queue = 0; queue < set->nr_hw_queues; queue++) {
+	for (queue = first_vec; queue < set->nr_hw_queues; queue++) {
 		mask = pci_irq_get_affinity(pdev, queue);
 		if (!mask)
 			return -EINVAL;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0fc99f0..a05fbaf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -272,7 +272,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_dev *dev = set->driver_data;
 
-	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev));
+	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
 }
 
 /**
diff --git a/include/linux/blk-mq-pci.h b/include/linux/blk-mq-pci.h
index 6ab5952..fde26d2 100644
--- a/include/linux/blk-mq-pci.h
+++ b/include/linux/blk-mq-pci.h
@@ -4,6 +4,7 @@
 struct blk_mq_tag_set;
 struct pci_dev;
 
-int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev);
+int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
+		int first_vec);
 
 #endif /* _LINUX_BLK_MQ_PCI_H */
-- 
2.1.4

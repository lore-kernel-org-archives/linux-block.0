Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbcH2Kxy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2016 06:53:54 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 5/7] nvme: switch to use pci_alloc_irq_vectors
Date: Mon, 29 Aug 2016 12:53:31 +0200
Message-Id: <1472468013-29936-6-git-send-email-hch@lst.de>
In-Reply-To: <1472468013-29936-1-git-send-email-hch@lst.de>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use the new helper to automatically select the right interrupt type, as
well as to use the automatic interupt affinity assignment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 99 ++++++++++++++-----------------------------------
 1 file changed, 28 insertions(+), 71 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 086fd7e..50e9038 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -88,7 +88,6 @@ struct nvme_dev {
 	unsigned max_qid;
 	int q_depth;
 	u32 db_stride;
-	struct msix_entry *entry;
 	void __iomem *bar;
 	struct work_struct reset_work;
 	struct work_struct remove_work;
@@ -201,6 +200,11 @@ static unsigned int nvme_cmd_size(struct nvme_dev *dev)
 		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES);
 }
 
+static int nvmeq_irq(struct nvme_queue *nvmeq)
+{
+	return pci_irq_vector(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector);
+}
+
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -960,7 +964,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 		spin_unlock_irq(&nvmeq->q_lock);
 		return 1;
 	}
-	vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
+	vector = nvmeq_irq(nvmeq);
 	nvmeq->dev->online_queues--;
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -968,7 +972,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_stop_hw_queues(nvmeq->dev->ctrl.admin_q);
 
-	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
 
 	return 0;
@@ -1075,15 +1078,14 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	return NULL;
 }
 
-static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
-							const char *name)
+static int queue_request_irq(struct nvme_queue *nvmeq)
 {
 	if (use_threaded_interrupts)
-		return request_threaded_irq(dev->entry[nvmeq->cq_vector].vector,
-					nvme_irq_check, nvme_irq, IRQF_SHARED,
-					name, nvmeq);
-	return request_irq(dev->entry[nvmeq->cq_vector].vector, nvme_irq,
-				IRQF_SHARED, name, nvmeq);
+		return request_threaded_irq(nvmeq_irq(nvmeq), nvme_irq_check,
+				nvme_irq, IRQF_SHARED, nvmeq->irqname, nvmeq);
+	else
+		return request_irq(nvmeq_irq(nvmeq), nvme_irq, IRQF_SHARED,
+				nvmeq->irqname, nvmeq);
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -1114,7 +1116,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	if (result < 0)
 		goto release_cq;
 
-	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
+	result = queue_request_irq(nvmeq);
 	if (result < 0)
 		goto release_sq;
 
@@ -1232,7 +1234,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 		goto free_nvmeq;
 
 	nvmeq->cq_vector = 0;
-	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
+	result = queue_request_irq(nvmeq);
 	if (result) {
 		nvmeq->cq_vector = -1;
 		goto free_nvmeq;
@@ -1380,7 +1382,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = dev->queues[0];
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int result, i, vecs, nr_io_queues, size;
+	int result, nr_io_queues, size;
 
 	nr_io_queues = num_online_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
@@ -1415,29 +1417,18 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	}
 
 	/* Deregister the admin queue's interrupt */
-	free_irq(dev->entry[0].vector, adminq);
+	free_irq(pci_irq_vector(pdev, 0), adminq);
 
 	/*
 	 * If we enable msix early due to not intx, disable it again before
 	 * setting up the full range we need.
 	 */
-	if (pdev->msi_enabled)
-		pci_disable_msi(pdev);
-	else if (pdev->msix_enabled)
-		pci_disable_msix(pdev);
-
-	for (i = 0; i < nr_io_queues; i++)
-		dev->entry[i].entry = i;
-	vecs = pci_enable_msix_range(pdev, dev->entry, 1, nr_io_queues);
-	if (vecs < 0) {
-		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues, 32));
-		if (vecs < 0) {
-			vecs = 1;
-		} else {
-			for (i = 0; i < vecs; i++)
-				dev->entry[i].vector = i + pdev->irq;
-		}
-	}
+	pci_free_irq_vectors(pdev);
+	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
+			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
+	if (nr_io_queues <= 0)
+		return -EIO;
+	dev->max_qid = nr_io_queues;
 
 	/*
 	 * Should investigate if there's a performance win from allocating
@@ -1445,10 +1436,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * path to scale better, even if the receive path is limited by the
 	 * number of interrupts.
 	 */
-	nr_io_queues = vecs;
-	dev->max_qid = nr_io_queues;
 
-	result = queue_request_irq(dev, adminq, adminq->irqname);
+	result = queue_request_irq(adminq);
 	if (result) {
 		adminq->cq_vector = -1;
 		goto free_queues;
@@ -1460,23 +1449,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return result;
 }
 
-static void nvme_pci_post_scan(struct nvme_ctrl *ctrl)
-{
-	struct nvme_dev *dev = to_nvme_dev(ctrl);
-	struct nvme_queue *nvmeq;
-	int i;
-
-	for (i = 0; i < dev->online_queues; i++) {
-		nvmeq = dev->queues[i];
-
-		if (!nvmeq->tags || !(*nvmeq->tags))
-			continue;
-
-		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
-					blk_mq_tags_cpumask(*nvmeq->tags));
-	}
-}
-
 static void nvme_del_queue_end(struct request *req, int error)
 {
 	struct nvme_queue *nvmeq = req->end_io_data;
@@ -1574,6 +1546,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.cmd_size = nvme_cmd_size(dev);
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
+		dev->tagset.affinity_mask = to_pci_dev(dev->dev)->irq_affinity;
 
 		if (blk_mq_alloc_tag_set(&dev->tagset))
 			return 0;
@@ -1613,15 +1586,9 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	 * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
 	 * adjust this later.
 	 */
-	if (pci_enable_msix(pdev, dev->entry, 1)) {
-		pci_enable_msi(pdev);
-		dev->entry[0].vector = pdev->irq;
-	}
-
-	if (!dev->entry[0].vector) {
-		result = -ENODEV;
-		goto disable;
-	}
+	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (result < 0)
+		return result;
 
 	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
@@ -1663,10 +1630,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	if (pdev->msi_enabled)
-		pci_disable_msi(pdev);
-	else if (pdev->msix_enabled)
-		pci_disable_msix(pdev);
+	pci_free_irq_vectors(pdev);
 
 	if (pci_is_enabled(pdev)) {
 		pci_disable_pcie_error_reporting(pdev);
@@ -1736,7 +1700,6 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
-	kfree(dev->entry);
 	kfree(dev);
 }
 
@@ -1880,7 +1843,6 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read64		= nvme_pci_reg_read64,
 	.reset_ctrl		= nvme_pci_reset_ctrl,
 	.free_ctrl		= nvme_pci_free_ctrl,
-	.post_scan		= nvme_pci_post_scan,
 	.submit_async_event	= nvme_pci_submit_async_event,
 };
 
@@ -1913,10 +1875,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
 		return -ENOMEM;
-	dev->entry = kzalloc_node(num_possible_cpus() * sizeof(*dev->entry),
-							GFP_KERNEL, node);
-	if (!dev->entry)
-		goto free;
 	dev->queues = kzalloc_node((num_possible_cpus() + 1) * sizeof(void *),
 							GFP_KERNEL, node);
 	if (!dev->queues)
@@ -1957,7 +1915,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dev_unmap(dev);
  free:
 	kfree(dev->queues);
-	kfree(dev->entry);
 	kfree(dev);
 	return result;
 }
-- 
2.1.4


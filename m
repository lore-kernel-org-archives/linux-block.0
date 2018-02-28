Return-Path: <gunthorp@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 28 Feb 2018 16:40:04 -0700
Message-Id: <20180228234006.21093-9-logang@deltatee.com>
In-Reply-To: <20180228234006.21093-1-logang@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com>
Subject: [PATCH v2 08/10] nvme-pci: Add support for P2P memory in requests
List-ID: <linux-block@vger.kernel.org>

For P2P requests we must use the pci_p2pmem_[un]map_sg() functions
instead of the dma_map_sg functions.

With that, we can then indicate PCI_P2P support in the request queue.
For this, we create an NVME_F_PCI_P2P flag which tells the core to
set QUEUE_FLAG_PCI_P2P in the request queue.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c |  4 ++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 19 +++++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0fe7ea35c221..4dd564f175fa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2954,7 +2954,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns->queue = blk_mq_init_queue(ctrl->tagset);
 	if (IS_ERR(ns->queue))
 		goto out_free_ns;
+
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
+	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
+		queue_flag_set_unlocked(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
+
 	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0521e4707d1c..e38beb1917e2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -290,6 +290,7 @@ struct nvme_ctrl_ops {
 	unsigned int flags;
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
+#define NVME_F_PCI_P2PDMA		(1 << 2)
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 56ca79be8476..b896a78225cb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -796,8 +796,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_STS_RESOURCE;
-	nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
-			DMA_ATTR_NO_WARN);
+
+	if (REQ_IS_PCI_P2PDMA(req))
+		nr_mapped = pci_p2pdma_map_sg(dev->dev, iod->sg, iod->nents,
+					  dma_dir);
+	else
+		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
+					     dma_dir,  DMA_ATTR_NO_WARN);
 	if (!nr_mapped)
 		goto out;
 
@@ -842,7 +847,12 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 
 	if (iod->nents) {
-		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
+		if (REQ_IS_PCI_P2PDMA(req))
+			pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
+					    dma_dir);
+		else
+			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
+
 		if (blk_integrity_rq(req)) {
 			if (req_op(req) == REQ_OP_READ)
 				nvme_dif_remap(req, nvme_dif_complete);
@@ -2422,7 +2432,8 @@ static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
-	.flags			= NVME_F_METADATA_SUPPORTED,
+	.flags			= NVME_F_METADATA_SUPPORTED |
+				  NVME_F_PCI_P2PDMA,
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
 	.reg_read64		= nvme_pci_reg_read64,
-- 
2.11.0

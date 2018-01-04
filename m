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
	Logan Gunthorpe <logang@deltatee.com>
Date: Thu,  4 Jan 2018 12:01:35 -0700
Message-Id: <20180104190137.7654-11-logang@deltatee.com>
In-Reply-To: <20180104190137.7654-1-logang@deltatee.com>
References: <20180104190137.7654-1-logang@deltatee.com>
Subject: [PATCH 10/12] nvme-pci: Add support for P2P memory in requests
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
 drivers/nvme/host/pci.c  | 18 ++++++++++++++----
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e46e60b8f10..8a7caaa5ee49 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2861,7 +2861,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns->queue = blk_mq_init_queue(ctrl->tagset);
 	if (IS_ERR(ns->queue))
 		goto out_free_ns;
+
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
+	if (ctrl->ops->flags & NVME_F_PCI_P2P)
+		queue_flag_set_unlocked(QUEUE_FLAG_PCI_P2P, ns->queue);
+
 	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ea1aa5283e8e..ae1453238250 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -286,6 +286,7 @@ struct nvme_ctrl_ops {
 	unsigned int flags;
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
+#define NVME_F_PCI_P2P			(1 << 2)
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 71893babb982..29ef3fd24938 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -792,6 +792,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	enum dma_data_direction dma_dir = rq_data_dir(req) ?
 			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 	blk_status_t ret = BLK_STS_IOERR;
+	int nents;
 
 	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
 	iod->nents = blk_rq_map_sg(q, req, iod->sg);
@@ -799,8 +800,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_STS_RESOURCE;
-	if (!dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
-				DMA_ATTR_NO_WARN))
+
+	if (REQ_IS_PCI_P2P(req))
+		nents = pci_p2pmem_map_sg(iod->sg, iod->nents);
+	else
+		nents = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
+					 dma_dir, DMA_ATTR_NO_WARN);
+	if (!nents)
 		goto out;
 
 	if (nvme_pci_use_sgls(dev, req))
@@ -844,7 +850,11 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 
 	if (iod->nents) {
-		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
+		if (REQ_IS_PCI_P2P(req))
+			pci_p2pmem_unmap_sg(iod->sg, iod->nents);
+		else
+			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
+
 		if (blk_integrity_rq(req)) {
 			if (req_op(req) == REQ_OP_READ)
 				nvme_dif_remap(req, nvme_dif_complete);
@@ -2417,7 +2427,7 @@ static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
-	.flags			= NVME_F_METADATA_SUPPORTED,
+	.flags			= NVME_F_METADATA_SUPPORTED | NVME_F_PCI_P2P,
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
 	.reg_read64		= nvme_pci_reg_read64,
-- 
2.11.0

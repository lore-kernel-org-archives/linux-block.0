Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Date: Thu, 30 Aug 2018 12:53:49 -0600
Message-Id: <20180830185352.3369-11-logang@deltatee.com>
In-Reply-To: <20180830185352.3369-1-logang@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
Subject: [PATCH v5 10/13] nvme-pci: Add support for P2P memory in requests
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stephen Bates <sbates@raithlin.com>, Keith Busch <keith.busch@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

For P2P requests, we must use the pci_p2pmem_map_sg() function
instead of the dma_map_sg functions.

With that, we can then indicate PCI_P2P support in the request queue.
For this, we create an NVME_F_PCI_P2P flag which tells the core to
set QUEUE_FLAG_PCI_P2P in the request queue.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c |  4 ++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 17 +++++++++++++----
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd8ec1dd9219..6033ce2fd3e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3051,7 +3051,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns->queue = blk_mq_init_queue(ctrl->tagset);
 	if (IS_ERR(ns->queue))
 		goto out_free_ns;
+
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
+	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
+		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
+
 	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a2003c097..4030743c90aa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -343,6 +343,7 @@ struct nvme_ctrl_ops {
 	unsigned int flags;
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
+#define NVME_F_PCI_P2PDMA		(1 << 2)
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2902585c6ddf..bb2120d30e39 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -737,8 +737,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_STS_RESOURCE;
-	nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
-			DMA_ATTR_NO_WARN);
+
+	if (is_pci_p2pdma_page(sg_page(iod->sg)))
+		nr_mapped = pci_p2pdma_map_sg(dev->dev, iod->sg, iod->nents,
+					  dma_dir);
+	else
+		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
+					     dma_dir,  DMA_ATTR_NO_WARN);
 	if (!nr_mapped)
 		goto out;
 
@@ -780,7 +785,10 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 
 	if (iod->nents) {
-		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
+		/* P2PDMA requests do not need to be unmapped */
+		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
+			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
+
 		if (blk_integrity_rq(req))
 			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
 	}
@@ -2392,7 +2400,8 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

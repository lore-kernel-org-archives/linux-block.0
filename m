Return-Path: <BATV+b05e9fb8710da454cfb6+5260+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: keith.busch@intel.com,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-pci: take sglist coalescing in dma_map_sg into account
Date: Wed, 17 Jan 2018 22:04:38 +0100
Message-Id: <20180117210438.3778-3-hch@lst.de>
In-Reply-To: <20180117210438.3778-1-hch@lst.de>
References: <20180117210438.3778-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Some iommu implementations can merge physically and/or virtually
contiguous segments inside sg_map_dma.  The NVMe SGL support does not take
this into account and will warn because of falling off a loop.  Pass the
number of mapped segments to nvme_pci_setup_sgls so that the SGL setup
can take the number of mapped segments into account.

Reported-by: Fangjian (Turing) <f.fangjian@huawei.com>
Fixes: a7a7cbe3 ("nvme-pci: add SGL support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@rimberg.me>
---
 drivers/nvme/host/pci.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a7e94cc3c70e..4276ebfff22b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -725,20 +725,19 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 }
 
 static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmd)
+		struct request *req, struct nvme_rw_command *cmd, int entries)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	int length = blk_rq_payload_bytes(req);
 	struct dma_pool *pool;
 	struct nvme_sgl_desc *sg_list;
 	struct scatterlist *sg = iod->sg;
-	int entries = iod->nents, i = 0;
 	dma_addr_t sgl_dma;
+	int i = 0;
 
 	/* setting the transfer type as SGL */
 	cmd->flags = NVME_CMD_SGL_METABUF;
 
-	if (length == sg_dma_len(sg)) {
+	if (entries == 1) {
 		nvme_pci_sgl_set_data(&cmd->dptr.sgl, sg);
 		return BLK_STS_OK;
 	}
@@ -778,13 +777,9 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 		}
 
 		nvme_pci_sgl_set_data(&sg_list[i++], sg);
-
-		length -= sg_dma_len(sg);
 		sg = sg_next(sg);
-		entries--;
-	} while (length > 0);
+	} while (--entries > 0);
 
-	WARN_ON(entries > 0);
 	return BLK_STS_OK;
 }
 
@@ -796,6 +791,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	enum dma_data_direction dma_dir = rq_data_dir(req) ?
 			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 	blk_status_t ret = BLK_STS_IOERR;
+	int nr_mapped;
 
 	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
 	iod->nents = blk_rq_map_sg(q, req, iod->sg);
@@ -803,12 +799,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_STS_RESOURCE;
-	if (!dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
-				DMA_ATTR_NO_WARN))
+	nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
+			DMA_ATTR_NO_WARN);
+	if (!nr_mapped)
 		goto out;
 
 	if (iod->use_sgl)
-		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
+		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
 
-- 
2.14.2

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
Date: Wed, 28 Feb 2018 16:39:59 -0700
Message-Id: <20180228234006.21093-4-logang@deltatee.com>
In-Reply-To: <20180228234006.21093-1-logang@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com>
Subject: [PATCH v2 03/10] PCI/P2PDMA: Add PCI p2pmem dma mappings to adjust the bus offset
List-ID: <linux-block@vger.kernel.org>

The DMA address used when mapping PCI P2P memory must be the PCI bus
address. Thus, introduce pci_p2pmem_[un]map_sg() to map the correct
addresses when using P2P memory.

For this, we assume that an SGL passed to these functions contain all
p2p memory or no p2p memory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c       | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/memremap.h   |  1 +
 include/linux/pci-p2pdma.h | 13 ++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index a57df78f6a32..4e1c81f64b29 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -188,6 +188,8 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->res.flags = pci_resource_flags(pdev, bar);
 	pgmap->ref = &pdev->p2pdma->devmap_ref;
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
+	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
+		pci_resource_start(pdev, bar);
 
 	addr = devm_memremap_pages(&pdev->dev, pgmap);
 	if (IS_ERR(addr))
@@ -616,3 +618,52 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 	pdev->p2pdma->published = publish;
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
+
+/*
+ * pci_p2pdma_map_sg - map a PCI peer-to-peer sg for DMA
+ * @dev:        device doing the DMA request
+ * @sg:		scatter list to map
+ * @nents:	elements in the scatterlist
+ * @dir:        DMA direction
+ *
+ * Returns the number of SG entries mapped
+ */
+int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		      enum dma_data_direction dir)
+{
+	struct dev_pagemap *pgmap;
+	struct scatterlist *s;
+	phys_addr_t paddr;
+	int i;
+
+	/*
+	 * p2pdma mappings are not compatible with devices that use
+	 * dma_virt_ops.
+	 */
+	if (IS_ENABLED(CONFIG_DMA_VIRT_OPS) && dev->dma_ops == &dma_virt_ops)
+		return 0;
+
+	for_each_sg(sg, s, nents, i) {
+		pgmap = sg_page(s)->pgmap;
+		paddr = sg_phys(s);
+
+		s->dma_address = paddr - pgmap->pci_p2pdma_bus_offset;
+		sg_dma_len(s) = s->length;
+	}
+
+	return nents;
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg);
+
+/**
+ * pci_p2pdma_unmap_sg - unmap a PCI peer-to-peer sg for DMA
+ * @dev:        device doing the DMA request
+ * @sg:		scatter list to map
+ * @nents:	elements in the scatterlist
+ * @dir:        DMA direction
+ */
+void pci_p2pdma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+			 enum dma_data_direction dir)
+{
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 9e907c338a44..1660f64ce96f 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -125,6 +125,7 @@ struct dev_pagemap {
 	struct device *dev;
 	void *data;
 	enum memory_type type;
+	u64 pci_p2pdma_bus_offset;
 };
 
 #ifdef CONFIG_ZONE_DEVICE
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index c0dde3d3aac4..126eca697ab3 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -36,6 +36,10 @@ int pci_p2pmem_alloc_sgl(struct pci_dev *pdev, struct scatterlist **sgl,
 void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl,
 		unsigned int nents);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
+int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		      enum dma_data_direction dir);
+void pci_p2pdma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+			 enum dma_data_direction dir);
 #else /* CONFIG_PCI_P2PDMA */
 static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
 		size_t size, u64 offset)
@@ -83,5 +87,14 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
 static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
 }
+static inline int pci_p2pdma_map_sg(struct device *dev,
+	struct scatterlist *sg, int nents, enum dma_data_direction dir)
+{
+	return 0;
+}
+static inline void pci_p2pdma_unmap_sg(struct device *dev,
+	struct scatterlist *sg, int nents, enum dma_data_direction dir)
+{
+}
 #endif /* CONFIG_PCI_P2PDMA */
 #endif /* _LINUX_PCI_P2P_H */
-- 
2.11.0

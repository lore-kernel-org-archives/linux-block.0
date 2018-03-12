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
Date: Mon, 12 Mar 2018 13:35:21 -0600
Message-Id: <20180312193525.2855-8-logang@deltatee.com>
In-Reply-To: <20180312193525.2855-1-logang@deltatee.com>
References: <20180312193525.2855-1-logang@deltatee.com>
Subject: [PATCH v3 07/11] IB/core: Ensure we map P2P memory correctly in  rdma_rw_ctx_[init|destroy]()
List-ID: <linux-block@vger.kernel.org>

In order to use PCI P2P memory pci_p2pmem_[un]map_sg() functions must be
called to map the correct PCI bus address.

To do this, check the first page in the scatter list to see if it is P2P
memory or not. At the moment, scatter lists that contain P2P memory must
be homogeneous so if the first page is P2P the entire SGL should be P2P.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/infiniband/core/rw.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index c8963e91f92a..f495e8a7f8ac 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -12,6 +12,7 @@
  */
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
+#include <linux/pci-p2pdma.h>
 #include <rdma/mr_pool.h>
 #include <rdma/rw.h>
 
@@ -280,7 +281,11 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 	struct ib_device *dev = qp->pd->device;
 	int ret;
 
-	ret = ib_dma_map_sg(dev, sg, sg_cnt, dir);
+	if (is_pci_p2pdma_page(sg_page(sg)))
+		ret = pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
+	else
+		ret = ib_dma_map_sg(dev, sg, sg_cnt, dir);
+
 	if (!ret)
 		return -ENOMEM;
 	sg_cnt = ret;
@@ -602,7 +607,11 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 		break;
 	}
 
-	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	if (is_pci_p2pdma_page(sg_page(sg)))
+		pci_p2pdma_unmap_sg(qp->pd->device->dma_device, sg,
+				    sg_cnt, dir);
+	else
+		ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
-- 
2.11.0

Return-Path: <gunthorp@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jens Axboe <axboe@kernel.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lei <ming.lei@canonical.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Stephen Bates <sbates@raithlin.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jerome Glisse <jglisse@redhat.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 24 May 2017 15:42:12 -0600
Message-Id: <1495662147-18277-2-git-send-email-logang@deltatee.com>
In-Reply-To: <1495662147-18277-1-git-send-email-logang@deltatee.com>
References: <1495662147-18277-1-git-send-email-logang@deltatee.com>
Subject: [RFC PATCH 01/16] dmaengine: ste_dma40, imx-dma: Cleanup scatterlist layering violations
List-ID: <linux-block@vger.kernel.org>

Two dma engine drivers directly accesses page_link assuming knowledge
that should be contained only in scatterlist.h.

We replace these with calls to sg_chain and sg_assign_page.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 drivers/dma/imx-dma.c   | 7 ++-----
 drivers/dma/ste_dma40.c | 5 +----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index ab0fb80..f681df8 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -888,7 +888,7 @@ static struct dma_async_tx_descriptor *imxdma_prep_dma_cyclic(
 	sg_init_table(imxdmac->sg_list, periods);
 
 	for (i = 0; i < periods; i++) {
-		imxdmac->sg_list[i].page_link = 0;
+		sg_assign_page(&imxdmac->sg_list[i], NULL);
 		imxdmac->sg_list[i].offset = 0;
 		imxdmac->sg_list[i].dma_address = dma_addr;
 		sg_dma_len(&imxdmac->sg_list[i]) = period_len;
@@ -896,10 +896,7 @@ static struct dma_async_tx_descriptor *imxdma_prep_dma_cyclic(
 	}
 
 	/* close the loop */
-	imxdmac->sg_list[periods].offset = 0;
-	sg_dma_len(&imxdmac->sg_list[periods]) = 0;
-	imxdmac->sg_list[periods].page_link =
-		((unsigned long)imxdmac->sg_list | 0x01) & ~0x02;
+	sg_chain(imxdmac->sg_list, periods + 1, imxdmac->sg_list);
 
 	desc->type = IMXDMA_DESC_CYCLIC;
 	desc->sg = imxdmac->sg_list;
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index a6620b6..c3052fb 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2528,10 +2528,7 @@ dma40_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
 		dma_addr += period_len;
 	}
 
-	sg[periods].offset = 0;
-	sg_dma_len(&sg[periods]) = 0;
-	sg[periods].page_link =
-		((unsigned long)sg | 0x01) & ~0x02;
+	sg_chain(sg, periods + 1, sg);
 
 	txd = d40_prep_sg(chan, sg, sg, periods, direction,
 			  DMA_PREP_INTERRUPT);
-- 
2.1.4

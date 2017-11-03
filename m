Return-Path: <prvs=473169c3e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Ard
 Biesheuvel" <ard.biesheuvel@linaro.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3 3/8] nvmet/fc: Use sgl_alloc() and sgl_free()
Date: Fri, 3 Nov 2017 15:23:34 -0700
Message-ID: <20171103222339.26540-4-bart.vanassche@wdc.com>
In-Reply-To: <20171103222339.26540-1-bart.vanassche@wdc.com>
References: <20171103222339.26540-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Use the sgl_alloc() and sgl_free() functions instead of open coding
these functions.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/Kconfig |  1 +
 drivers/nvme/target/fc.c    | 36 ++----------------------------------
 2 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 03e4ab65fe77..4d9715630e21 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -39,6 +39,7 @@ config NVME_TARGET_FC
 	tristate "NVMe over Fabrics FC target driver"
 	depends on NVME_TARGET
 	depends on HAS_DMA
+	select SGL_ALLOC
 	help
 	  This enables the NVMe FC target support, which allows exporting NVMe
 	  devices over FC.
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 5f2570f5dfa9..1b4030d74ceb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1695,31 +1695,12 @@ static int
 nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 {
 	struct scatterlist *sg;
-	struct page *page;
 	unsigned int nent;
-	u32 page_len, length;
-	int i = 0;
 
-	length = fod->total_length;
-	nent = DIV_ROUND_UP(length, PAGE_SIZE);
-	sg = kmalloc_array(nent, sizeof(struct scatterlist), GFP_KERNEL);
+	sg = sgl_alloc(fod->total_length, GFP_KERNEL, &nent);
 	if (!sg)
 		goto out;
 
-	sg_init_table(sg, nent);
-
-	while (length) {
-		page_len = min_t(u32, length, PAGE_SIZE);
-
-		page = alloc_page(GFP_KERNEL);
-		if (!page)
-			goto out_free_pages;
-
-		sg_set_page(&sg[i], page, page_len, 0);
-		length -= page_len;
-		i++;
-	}
-
 	fod->data_sg = sg;
 	fod->data_sg_cnt = nent;
 	fod->data_sg_cnt = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
@@ -1729,14 +1710,6 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 
 	return 0;
 
-out_free_pages:
-	while (i > 0) {
-		i--;
-		__free_page(sg_page(&sg[i]));
-	}
-	kfree(sg);
-	fod->data_sg = NULL;
-	fod->data_sg_cnt = 0;
 out:
 	return NVME_SC_INTERNAL;
 }
@@ -1744,18 +1717,13 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 static void
 nvmet_fc_free_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 {
-	struct scatterlist *sg;
-	int count;
-
 	if (!fod->data_sg || !fod->data_sg_cnt)
 		return;
 
 	fc_dma_unmap_sg(fod->tgtport->dev, fod->data_sg, fod->data_sg_cnt,
 				((fod->io_dir == NVMET_FCP_WRITE) ?
 					DMA_FROM_DEVICE : DMA_TO_DEVICE));
-	for_each_sg(fod->data_sg, sg, fod->data_sg_cnt, count)
-		__free_page(sg_page(sg));
-	kfree(fod->data_sg);
+	sgl_free(fod->data_sg);
 	fod->data_sg = NULL;
 	fod->data_sg_cnt = 0;
 }
-- 
2.14.3

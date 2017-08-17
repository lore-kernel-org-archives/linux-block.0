Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 32/55] skd: Use for_each_sg()
Date: Thu, 17 Aug 2017 13:13:15 -0700
Message-Id: <20170817201338.16537-33-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This change makes skd_preop_sg_list() support chained sg-lists.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a363d5f6bcb5..62e06e35ddf5 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -740,7 +740,7 @@ static bool skd_preop_sg_list(struct skd_device *skdev,
 			     struct skd_request_context *skreq)
 {
 	struct request *req = skreq->req;
-	struct scatterlist *sg = &skreq->sg[0];
+	struct scatterlist *sgl = &skreq->sg[0], *sg;
 	int n_sg;
 	int i;
 
@@ -749,7 +749,7 @@ static bool skd_preop_sg_list(struct skd_device *skdev,
 	WARN_ON_ONCE(skreq->data_dir != DMA_TO_DEVICE &&
 		     skreq->data_dir != DMA_FROM_DEVICE);
 
-	n_sg = blk_rq_map_sg(skdev->queue, req, sg);
+	n_sg = blk_rq_map_sg(skdev->queue, req, sgl);
 	if (n_sg <= 0)
 		return false;
 
@@ -757,7 +757,7 @@ static bool skd_preop_sg_list(struct skd_device *skdev,
 	 * Map scatterlist to PCI bus addresses.
 	 * Note PCI might change the number of entries.
 	 */
-	n_sg = pci_map_sg(skdev->pdev, sg, n_sg, skreq->data_dir);
+	n_sg = pci_map_sg(skdev->pdev, sgl, n_sg, skreq->data_dir);
 	if (n_sg <= 0)
 		return false;
 
@@ -765,10 +765,10 @@ static bool skd_preop_sg_list(struct skd_device *skdev,
 
 	skreq->n_sg = n_sg;
 
-	for (i = 0; i < n_sg; i++) {
+	for_each_sg(sgl, sg, n_sg, i) {
 		struct fit_sg_descriptor *sgd = &skreq->sksg_list[i];
-		u32 cnt = sg_dma_len(&sg[i]);
-		uint64_t dma_addr = sg_dma_address(&sg[i]);
+		u32 cnt = sg_dma_len(sg);
+		uint64_t dma_addr = sg_dma_address(sg);
 
 		sgd->control = FIT_SGD_CONTROL_NOT_LAST;
 		sgd->byte_count = cnt;
-- 
2.14.0

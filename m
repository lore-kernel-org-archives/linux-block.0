Return-Path: <maxg@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
To: keith.busch@intel.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc: vladimirk@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 3/3] nvme: use blk API to remap ref tags for IOs with metadata
Date: Tue, 24 Jul 2018 16:33:42 +0300
Message-Id: <1532439222-5668-3-git-send-email-maxg@mellanox.com>
In-Reply-To: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
References: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

Also moved the logic of the remapping to the nvme core driver instead
of implementing it in the nvme pci driver. This way all the other nvme
transport drivers will benefit from it (in case they'll implement metadata
support).

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from v1:
 - check status of nvme_req instead of converting to BLK_STS

---
 drivers/nvme/host/core.c | 18 ++++++++++++
 drivers/nvme/host/nvme.h |  9 +-----
 drivers/nvme/host/pci.c  | 75 +-----------------------------------------------
 3 files changed, 20 insertions(+), 82 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 191177b..b57abe5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -617,6 +617,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
+		} else if (req_op(req) == REQ_OP_WRITE) {
+			t10_pi_prepare(req, ns->pi_type);
 		}
 
 		switch (ns->pi_type) {
@@ -637,6 +639,22 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	return 0;
 }
 
+void nvme_cleanup_cmd(struct request *req)
+{
+	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
+	    nvme_req(req)->status == 0) {
+		struct nvme_ns *ns = req->rq_disk->private_data;
+
+		t10_pi_complete(req, ns->pi_type,
+				blk_rq_bytes(req) >> ns->lba_shift);
+	}
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		kfree(page_address(req->special_vec.bv_page) +
+		      req->special_vec.bv_offset);
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
+
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0c4a33d..dfc01ff 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -356,14 +356,6 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 	return (sector >> (ns->lba_shift - 9));
 }
 
-static inline void nvme_cleanup_cmd(struct request *req)
-{
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		kfree(page_address(req->special_vec.bv_page) +
-		      req->special_vec.bv_offset);
-	}
-}
-
 static inline void nvme_end_request(struct request *req, __le16 status,
 		union nvme_result result)
 {
@@ -420,6 +412,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
+void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ddd441b..03beac5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -535,73 +535,6 @@ static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 		mempool_free(iod->sg, dev->iod_mempool);
 }
 
-#ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_dif_prep(u32 p, u32 v, struct t10_pi_tuple *pi)
-{
-	if (be32_to_cpu(pi->ref_tag) == v)
-		pi->ref_tag = cpu_to_be32(p);
-}
-
-static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
-{
-	if (be32_to_cpu(pi->ref_tag) == p)
-		pi->ref_tag = cpu_to_be32(v);
-}
-
-/**
- * nvme_dif_remap - remaps ref tags to bip seed and physical lba
- *
- * The virtual start sector is the one that was originally submitted by the
- * block layer.	Due to partitioning, MD/DM cloning, etc. the actual physical
- * start sector may be different. Remap protection information to match the
- * physical LBA on writes, and back to the original seed on reads.
- *
- * Type 0 and 3 do not have a ref tag, so no remapping required.
- */
-static void nvme_dif_remap(struct request *req,
-			void (*dif_swap)(u32 p, u32 v, struct t10_pi_tuple *pi))
-{
-	struct nvme_ns *ns = req->rq_disk->private_data;
-	struct bio_integrity_payload *bip;
-	struct t10_pi_tuple *pi;
-	void *p, *pmap;
-	u32 i, nlb, ts, phys, virt;
-
-	if (!ns->pi_type || ns->pi_type == NVME_NS_DPS_PI_TYPE3)
-		return;
-
-	bip = bio_integrity(req->bio);
-	if (!bip)
-		return;
-
-	pmap = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;
-
-	p = pmap;
-	virt = bip_get_seed(bip);
-	phys = nvme_block_nr(ns, blk_rq_pos(req));
-	nlb = (blk_rq_bytes(req) >> ns->lba_shift);
-	ts = ns->disk->queue->integrity.tuple_size;
-
-	for (i = 0; i < nlb; i++, virt++, phys++) {
-		pi = (struct t10_pi_tuple *)p;
-		dif_swap(phys, virt, pi);
-		p += ts;
-	}
-	kunmap_atomic(pmap);
-}
-#else /* CONFIG_BLK_DEV_INTEGRITY */
-static void nvme_dif_remap(struct request *req,
-			void (*dif_swap)(u32 p, u32 v, struct t10_pi_tuple *pi))
-{
-}
-static void nvme_dif_prep(u32 p, u32 v, struct t10_pi_tuple *pi)
-{
-}
-static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
-{
-}
-#endif
-
 static void nvme_print_sgl(struct scatterlist *sgl, int nents)
 {
 	int i;
@@ -827,9 +760,6 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		if (blk_rq_map_integrity_sg(q, req->bio, &iod->meta_sg) != 1)
 			goto out_unmap;
 
-		if (req_op(req) == REQ_OP_WRITE)
-			nvme_dif_remap(req, nvme_dif_prep);
-
 		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
 			goto out_unmap;
 	}
@@ -852,11 +782,8 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 
 	if (iod->nents) {
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
-		if (blk_integrity_rq(req)) {
-			if (req_op(req) == REQ_OP_READ)
-				nvme_dif_remap(req, nvme_dif_complete);
+		if (blk_integrity_rq(req))
 			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
-		}
 	}
 
 	nvme_cleanup_cmd(req);
-- 
1.8.3.1

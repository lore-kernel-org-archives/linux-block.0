Return-Path: <maxg@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
To: martin.petersen@oracle.com, linux-block@vger.kernel.org, axboe@kernel.dk,
        keith.busch@intel.com, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de
Cc: Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/2] block: move dif_prepare/dif_complete functions to block layer
Date: Sun, 22 Jul 2018 12:49:57 +0300
Message-Id: <1532252998-2375-1-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

Currently these functions are implemented in the scsi layer, but their
actual place should be the block layer since T10-PI is a general data
integrity feature that is used in the nvme protocol as well.

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 block/blk-integrity.c  | 111 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sd.c      |  12 ++++--
 drivers/scsi/sd.h      |   9 ----
 drivers/scsi/sd_dif.c  | 113 -------------------------------------------------
 include/linux/blkdev.h |  14 ++++++
 5 files changed, 134 insertions(+), 125 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 6121611e1316..66b095a866d3 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/t10-pi.h>
 #include <linux/backing-dev.h>
 #include <linux/mempool.h>
 #include <linux/bio.h>
@@ -451,3 +452,113 @@ void blk_integrity_del(struct gendisk *disk)
 	kobject_del(&disk->integrity_kobj);
 	kobject_put(&disk->integrity_kobj);
 }
+
+/*
+ * The virtual start sector is the one that was originally submitted
+ * by the block layer.	Due to partitioning, MD/DM cloning, etc. the
+ * actual physical start sector is likely to be different.  Remap
+ * protection information to match the physical LBA.
+ *
+ * From a protocol perspective there's a slight difference between
+ * Type 1 and 2.  The latter uses command's 32-byte exclusively, and the
+ * reference tag is seeded in the command.  This gives us the potential to
+ * avoid virt->phys remapping during write.  However, at read time we
+ * don't know whether the virt sector is the same as when we wrote it
+ * (we could be reading from real disk as opposed to MD/DM device.  So
+ * we always remap Type 2 making it identical to Type 1.
+ *
+ * Type 3 does not have a reference tag so no remapping is required.
+ */
+void blk_integrity_dif_prepare(struct request *rq, u8 protection_type,
+			       u32 ref_tag)
+{
+	const int tuple_sz = sizeof(struct t10_pi_tuple);
+	struct bio *bio;
+	struct t10_pi_tuple *pi;
+	u32 phys, virt;
+
+	if (protection_type == T10_PI_TYPE3_PROTECTION)
+		return;
+
+	phys = ref_tag;
+
+	__rq_for_each_bio(bio, rq) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+		struct bio_vec iv;
+		struct bvec_iter iter;
+		unsigned int j;
+
+		/* Already remapped? */
+		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
+			break;
+
+		virt = bip_get_seed(bip) & 0xffffffff;
+
+		bip_for_each_vec(iv, bip, iter) {
+			pi = kmap_atomic(iv.bv_page) + iv.bv_offset;
+
+			for (j = 0; j < iv.bv_len; j += tuple_sz, pi++) {
+
+				if (be32_to_cpu(pi->ref_tag) == virt)
+					pi->ref_tag = cpu_to_be32(phys);
+
+				virt++;
+				phys++;
+			}
+
+			kunmap_atomic(pi);
+		}
+
+		bip->bip_flags |= BIP_MAPPED_INTEGRITY;
+	}
+}
+EXPORT_SYMBOL(blk_integrity_dif_prepare);
+
+/*
+ * Remap physical sector values in the reference tag to the virtual
+ * values expected by the block layer.
+ */
+void blk_integrity_dif_complete(struct request *rq, u8 protection_type,
+				u32 ref_tag, unsigned int intervals)
+{
+	const int tuple_sz = sizeof(struct t10_pi_tuple);
+	struct bio *bio;
+	struct t10_pi_tuple *pi;
+	unsigned int j;
+	u32 phys, virt;
+
+	if (protection_type == T10_PI_TYPE3_PROTECTION)
+		return;
+
+	phys = ref_tag;
+
+	__rq_for_each_bio(bio, rq) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+		struct bio_vec iv;
+		struct bvec_iter iter;
+
+		virt = bip_get_seed(bip) & 0xffffffff;
+
+		bip_for_each_vec(iv, bip, iter) {
+			pi = kmap_atomic(iv.bv_page) + iv.bv_offset;
+
+			for (j = 0; j < iv.bv_len; j += tuple_sz, pi++) {
+
+				if (intervals == 0) {
+					kunmap_atomic(pi);
+					return;
+				}
+
+				if (be32_to_cpu(pi->ref_tag) == phys)
+					pi->ref_tag = cpu_to_be32(virt);
+
+				virt++;
+				phys++;
+				intervals--;
+			}
+
+			kunmap_atomic(pi);
+		}
+	}
+}
+EXPORT_SYMBOL(blk_integrity_dif_complete);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 9421d9877730..4186bf027c59 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1119,7 +1119,9 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 		SCpnt->cmnd[0] = WRITE_6;
 
 		if (blk_integrity_rq(rq))
-			sd_dif_prepare(SCpnt);
+			blk_integrity_dif_prepare(SCpnt->request,
+						  sdkp->protection_type,
+						  scsi_prot_ref_tag(SCpnt));
 
 	} else if (rq_data_dir(rq) == READ) {
 		SCpnt->cmnd[0] = READ_6;
@@ -2047,8 +2049,12 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 					   "sd_done: completed %d of %d bytes\n",
 					   good_bytes, scsi_bufflen(SCpnt)));
 
-	if (rq_data_dir(SCpnt->request) == READ && scsi_prot_sg_count(SCpnt))
-		sd_dif_complete(SCpnt, good_bytes);
+	if (rq_data_dir(SCpnt->request) == READ && scsi_prot_sg_count(SCpnt) &&
+	    good_bytes)
+		blk_integrity_dif_complete(SCpnt->request,
+				sdkp->protection_type,
+				scsi_prot_ref_tag(SCpnt),
+				good_bytes / scsi_prot_interval(SCpnt));
 
 	return good_bytes;
 }
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 392c7d078ae3..a7d4f50b67d4 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -254,21 +254,12 @@ static inline unsigned int sd_prot_flag_mask(unsigned int prot_op)
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 
 extern void sd_dif_config_host(struct scsi_disk *);
-extern void sd_dif_prepare(struct scsi_cmnd *scmd);
-extern void sd_dif_complete(struct scsi_cmnd *, unsigned int);
 
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 
 static inline void sd_dif_config_host(struct scsi_disk *disk)
 {
 }
-static inline int sd_dif_prepare(struct scsi_cmnd *scmd)
-{
-	return 0;
-}
-static inline void sd_dif_complete(struct scsi_cmnd *cmd, unsigned int a)
-{
-}
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index 9035380c0dda..db72c82486e3 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -95,116 +95,3 @@ void sd_dif_config_host(struct scsi_disk *sdkp)
 	blk_integrity_register(disk, &bi);
 }
 
-/*
- * The virtual start sector is the one that was originally submitted
- * by the block layer.	Due to partitioning, MD/DM cloning, etc. the
- * actual physical start sector is likely to be different.  Remap
- * protection information to match the physical LBA.
- *
- * From a protocol perspective there's a slight difference between
- * Type 1 and 2.  The latter uses 32-byte CDBs exclusively, and the
- * reference tag is seeded in the CDB.  This gives us the potential to
- * avoid virt->phys remapping during write.  However, at read time we
- * don't know whether the virt sector is the same as when we wrote it
- * (we could be reading from real disk as opposed to MD/DM device.  So
- * we always remap Type 2 making it identical to Type 1.
- *
- * Type 3 does not have a reference tag so no remapping is required.
- */
-void sd_dif_prepare(struct scsi_cmnd *scmd)
-{
-	const int tuple_sz = sizeof(struct t10_pi_tuple);
-	struct bio *bio;
-	struct scsi_disk *sdkp;
-	struct t10_pi_tuple *pi;
-	u32 phys, virt;
-
-	sdkp = scsi_disk(scmd->request->rq_disk);
-
-	if (sdkp->protection_type == T10_PI_TYPE3_PROTECTION)
-		return;
-
-	phys = scsi_prot_ref_tag(scmd);
-
-	__rq_for_each_bio(bio, scmd->request) {
-		struct bio_integrity_payload *bip = bio_integrity(bio);
-		struct bio_vec iv;
-		struct bvec_iter iter;
-		unsigned int j;
-
-		/* Already remapped? */
-		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
-			break;
-
-		virt = bip_get_seed(bip) & 0xffffffff;
-
-		bip_for_each_vec(iv, bip, iter) {
-			pi = kmap_atomic(iv.bv_page) + iv.bv_offset;
-
-			for (j = 0; j < iv.bv_len; j += tuple_sz, pi++) {
-
-				if (be32_to_cpu(pi->ref_tag) == virt)
-					pi->ref_tag = cpu_to_be32(phys);
-
-				virt++;
-				phys++;
-			}
-
-			kunmap_atomic(pi);
-		}
-
-		bip->bip_flags |= BIP_MAPPED_INTEGRITY;
-	}
-}
-
-/*
- * Remap physical sector values in the reference tag to the virtual
- * values expected by the block layer.
- */
-void sd_dif_complete(struct scsi_cmnd *scmd, unsigned int good_bytes)
-{
-	const int tuple_sz = sizeof(struct t10_pi_tuple);
-	struct scsi_disk *sdkp;
-	struct bio *bio;
-	struct t10_pi_tuple *pi;
-	unsigned int j, intervals;
-	u32 phys, virt;
-
-	sdkp = scsi_disk(scmd->request->rq_disk);
-
-	if (sdkp->protection_type == T10_PI_TYPE3_PROTECTION || good_bytes == 0)
-		return;
-
-	intervals = good_bytes / scsi_prot_interval(scmd);
-	phys = scsi_prot_ref_tag(scmd);
-
-	__rq_for_each_bio(bio, scmd->request) {
-		struct bio_integrity_payload *bip = bio_integrity(bio);
-		struct bio_vec iv;
-		struct bvec_iter iter;
-
-		virt = bip_get_seed(bip) & 0xffffffff;
-
-		bip_for_each_vec(iv, bip, iter) {
-			pi = kmap_atomic(iv.bv_page) + iv.bv_offset;
-
-			for (j = 0; j < iv.bv_len; j += tuple_sz, pi++) {
-
-				if (intervals == 0) {
-					kunmap_atomic(pi);
-					return;
-				}
-
-				if (be32_to_cpu(pi->ref_tag) == phys)
-					pi->ref_tag = cpu_to_be32(virt);
-
-				virt++;
-				phys++;
-				intervals--;
-			}
-
-			kunmap_atomic(pi);
-		}
-	}
-}
-
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 79226ca8f80f..18f3ca17d4f4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1823,6 +1823,10 @@ extern bool blk_integrity_merge_rq(struct request_queue *, struct request *,
 				   struct request *);
 extern bool blk_integrity_merge_bio(struct request_queue *, struct request *,
 				    struct bio *);
+extern void blk_integrity_dif_prepare(struct request *rq, u8 protection_type,
+			       u32 ref_tag);
+extern void blk_integrity_dif_complete(struct request *rq, u8 protection_type,
+				u32 ref_tag, unsigned int intervals);
 
 static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
 {
@@ -1950,6 +1954,16 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 	return false;
 }
 
+void blk_integrity_dif_prepare(struct request *rq, u8 protection_type,
+			       u32 ref_tag)
+{
+}
+
+void blk_integrity_dif_complete(struct request *rq, u8 protection_type,
+				u32 ref_tag, unsigned int intervals)
+{
+}
+
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 struct block_device_operations {
-- 
2.16.3

Return-Path: <maxg@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
To: keith.busch@intel.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc: vladimirk@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v4 2/3] block: move dif_prepare/dif_complete functions to block layer
Date: Wed, 25 Jul 2018 18:46:16 +0300
Message-Id: <1532533577-1600-2-git-send-email-maxg@mellanox.com>
In-Reply-To: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
References: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

Currently these functions are implemented in the scsi layer, but their
actual place should be the block layer since T10-PI is a general data
integrity feature that is used in the nvme protocol as well. Also, use
the tuple size from the integrity profile since it may vary between
integrity types.

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from v3:
 - kmap_atomic/kunmap_atomic the same address
 - declare pi struct inside the inner for loop
 - check "intervals" inside the for loop condition

changes from v2:
 - convert comments to kerneldoc format
 - removed SCSI specific comment
 - fix kmap_atomic/kunmap_atomic addresses
 - fix iteration over t10_pi_tuple's

changes from v1 (Christoph, Martin and Keith comments):
 - moved the functions to t10-pi.c
 - updated tuple size
 - changed local variables scope
 - remove/add new lines

---
 block/t10-pi.c         | 110 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sd.c      |   8 ++--
 drivers/scsi/sd.h      |   9 ----
 drivers/scsi/sd_dif.c  | 113 -------------------------------------------------
 include/linux/t10-pi.h |   3 ++
 5 files changed, 118 insertions(+), 125 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index a98db38..62aed77 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -184,3 +184,113 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
 	.verify_fn		= t10_pi_type3_verify_ip,
 };
 EXPORT_SYMBOL(t10_pi_type3_ip);
+
+/**
+ * t10_pi_prepare - prepare PI prior submitting request to device
+ * @rq:              request with PI that should be prepared
+ * @protection_type: PI type (Type 1/Type 2/Type 3)
+ *
+ * For Type 1/Type 2, the virtual start sector is the one that was
+ * originally submitted by the block layer for the ref_tag usage. Due to
+ * partitioning, MD/DM cloning, etc. the actual physical start sector is
+ * likely to be different. Remap protection information to match the
+ * physical LBA.
+ *
+ * Type 3 does not have a reference tag so no remapping is required.
+ */
+void t10_pi_prepare(struct request *rq, u8 protection_type)
+{
+	const int tuple_sz = rq->q->integrity.tuple_size;
+	u32 ref_tag = t10_pi_ref_tag(rq);
+	struct bio *bio;
+
+	if (protection_type == T10_PI_TYPE3_PROTECTION)
+		return;
+
+	__rq_for_each_bio(bio, rq) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+		u32 virt = bip_get_seed(bip) & 0xffffffff;
+		struct bio_vec iv;
+		struct bvec_iter iter;
+
+		/* Already remapped? */
+		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
+			break;
+
+		bip_for_each_vec(iv, bip, iter) {
+			void *p, *pmap;
+			unsigned int j;
+
+			pmap = kmap_atomic(iv.bv_page);
+			p = pmap + iv.bv_offset;
+			for (j = 0; j < iv.bv_len; j += tuple_sz) {
+				struct t10_pi_tuple *pi = p;
+
+				if (be32_to_cpu(pi->ref_tag) == virt)
+					pi->ref_tag = cpu_to_be32(ref_tag);
+				virt++;
+				ref_tag++;
+				p += tuple_sz;
+			}
+
+			kunmap_atomic(pmap);
+		}
+
+		bip->bip_flags |= BIP_MAPPED_INTEGRITY;
+	}
+}
+EXPORT_SYMBOL(t10_pi_prepare);
+
+/**
+ * t10_pi_complete - prepare PI prior returning request to the block layer
+ * @rq:              request with PI that should be prepared
+ * @protection_type: PI type (Type 1/Type 2/Type 3)
+ * @intervals:       total elements to prepare
+ *
+ * For Type 1/Type 2, the virtual start sector is the one that was
+ * originally submitted by the block layer for the ref_tag usage. Due to
+ * partitioning, MD/DM cloning, etc. the actual physical start sector is
+ * likely to be different. Since the physical start sector was submitted
+ * to the device, we should remap it back to virtual values expected by the
+ * block layer.
+ *
+ * Type 3 does not have a reference tag so no remapping is required.
+ */
+void t10_pi_complete(struct request *rq, u8 protection_type,
+		     unsigned int intervals)
+{
+	const int tuple_sz = rq->q->integrity.tuple_size;
+	u32 ref_tag = t10_pi_ref_tag(rq);
+	struct bio *bio;
+
+	if (protection_type == T10_PI_TYPE3_PROTECTION)
+		return;
+
+	__rq_for_each_bio(bio, rq) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
+		u32 virt = bip_get_seed(bip) & 0xffffffff;
+		struct bio_vec iv;
+		struct bvec_iter iter;
+
+		bip_for_each_vec(iv, bip, iter) {
+			void *p, *pmap;
+			unsigned int j;
+
+			pmap = kmap_atomic(iv.bv_page);
+			p = pmap + iv.bv_offset;
+			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
+				struct t10_pi_tuple *pi = p;
+
+				if (be32_to_cpu(pi->ref_tag) == ref_tag)
+					pi->ref_tag = cpu_to_be32(virt);
+				virt++;
+				ref_tag++;
+				intervals--;
+				p += tuple_sz;
+			}
+
+			kunmap_atomic(pmap);
+		}
+	}
+}
+EXPORT_SYMBOL(t10_pi_complete);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 9421d98..bbebdc3 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1119,7 +1119,7 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 		SCpnt->cmnd[0] = WRITE_6;
 
 		if (blk_integrity_rq(rq))
-			sd_dif_prepare(SCpnt);
+			t10_pi_prepare(SCpnt->request, sdkp->protection_type);
 
 	} else if (rq_data_dir(rq) == READ) {
 		SCpnt->cmnd[0] = READ_6;
@@ -2047,8 +2047,10 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 					   "sd_done: completed %d of %d bytes\n",
 					   good_bytes, scsi_bufflen(SCpnt)));
 
-	if (rq_data_dir(SCpnt->request) == READ && scsi_prot_sg_count(SCpnt))
-		sd_dif_complete(SCpnt, good_bytes);
+	if (rq_data_dir(SCpnt->request) == READ && scsi_prot_sg_count(SCpnt) &&
+	    good_bytes)
+		t10_pi_complete(SCpnt->request, sdkp->protection_type,
+				good_bytes / scsi_prot_interval(SCpnt));
 
 	return good_bytes;
 }
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 392c7d0..a7d4f50 100644
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
index d8de43d..db72c82 100644
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
-	phys = t10_pi_ref_tag(scmd->request);
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
-	phys = t10_pi_ref_tag(scmd->request);
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
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index 635855e..81ae4c4 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -47,5 +47,8 @@ static inline u32 t10_pi_ref_tag(struct request *rq)
 extern const struct blk_integrity_profile t10_pi_type1_ip;
 extern const struct blk_integrity_profile t10_pi_type3_crc;
 extern const struct blk_integrity_profile t10_pi_type3_ip;
+extern void t10_pi_prepare(struct request *rq, u8 protection_type);
+extern void t10_pi_complete(struct request *rq, u8 protection_type,
+			    unsigned int intervals);
 
 #endif
-- 
1.8.3.1

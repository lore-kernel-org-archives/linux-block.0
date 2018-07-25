Return-Path: <gedwards@ddn.com>
From: Greg Edwards <gedwards@ddn.com>
To: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Greg Edwards <gedwards@ddn.com>
Subject: [PATCH 1/2] block: move bio_integrity_{intervals,bytes} into blkdev.h
Date: Wed, 25 Jul 2018 10:22:58 -0400
Message-ID: <20180725142259.20562-2-gedwards@ddn.com>
In-Reply-To: <20180725142259.20562-1-gedwards@ddn.com>
References: <20180725142259.20562-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: gedwards@ddn.com
List-ID: <linux-block@vger.kernel.org>

This allows bio_integrity_bytes() to be called from drivers instead of
open coding it.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 block/bio-integrity.c  | 22 ----------------------
 include/linux/blkdev.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index add7c7c85335..67b5fb861a51 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -159,28 +159,6 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_integrity_add_page);
 
-/**
- * bio_integrity_intervals - Return number of integrity intervals for a bio
- * @bi:		blk_integrity profile for device
- * @sectors:	Size of the bio in 512-byte sectors
- *
- * Description: The block layer calculates everything in 512 byte
- * sectors but integrity metadata is done in terms of the data integrity
- * interval size of the storage device.  Convert the block layer sectors
- * to the appropriate number of integrity intervals.
- */
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
-{
-	return sectors >> (bi->interval_exp - 9);
-}
-
-static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-					       unsigned int sectors)
-{
-	return bio_integrity_intervals(bi, sectors) * bi->tuple_size;
-}
-
 /**
  * bio_integrity_process - Process integrity metadata for a bio
  * @bio:	bio to generate/verify integrity metadata for
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 79226ca8f80f..553cc97900f6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1877,6 +1877,28 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 				bip_next->bip_vec[0].bv_offset);
 }
 
+/**
+ * bio_integrity_intervals - Return number of integrity intervals for a bio
+ * @bi:		blk_integrity profile for device
+ * @sectors:	Size of the bio in 512-byte sectors
+ *
+ * Description: The block layer calculates everything in 512 byte
+ * sectors but integrity metadata is done in terms of the data integrity
+ * interval size of the storage device.  Convert the block layer sectors
+ * to the appropriate number of integrity intervals.
+ */
+static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
+						   unsigned int sectors)
+{
+	return sectors >> (bi->interval_exp - 9);
+}
+
+static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
+					       unsigned int sectors)
+{
+	return bio_integrity_intervals(bi, sectors) * bi->tuple_size;
+}
+
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 
 struct bio;
@@ -1950,6 +1972,18 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 	return false;
 }
 
+static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
+						   unsigned int sectors)
+{
+	return 0;
+}
+
+static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
+					       unsigned int sectors)
+{
+	return 0;
+}
+
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 struct block_device_operations {
-- 
2.17.1

Return-Path: <BATV+a3f5f3e6054314e6ea5e+5058+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shaohua Li <shli@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/9] bio-integrity: fix interface for bio_integrity_trim
Date: Thu, 29 Jun 2017 11:31:10 -0700
Message-Id: <20170629183116.28685-4-hch@lst.de>
In-Reply-To: <20170629183116.28685-1-hch@lst.de>
References: <20170629183116.28685-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Dmitry Monakhov <dmonakhov@openvz.org>

bio_integrity_trim inherent it's interface from bio_trim and accept
offset and size, but this API is error prone because data offset
must always be insync with bio's data offset. That is why we have
integrity update hook in bio_advance()

So only meaningful values are: offset == 0, sectors == bio_sectors(bio)
Let's just remove them completely.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 11 ++---------
 block/bio.c           |  4 ++--
 drivers/md/dm.c       |  2 +-
 include/linux/bio.h   |  5 ++---
 4 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 8c2253c59edb..3a0d71199fb0 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -433,22 +433,15 @@ EXPORT_SYMBOL(bio_integrity_advance);
 /**
  * bio_integrity_trim - Trim integrity vector
  * @bio:	bio whose integrity vector to update
- * @offset:	offset to first data sector
- * @sectors:	number of data sectors
  *
  * Description: Used to trim the integrity vector in a cloned bio.
- * The ivec will be advanced corresponding to 'offset' data sectors
- * and the length will be truncated corresponding to 'len' data
- * sectors.
  */
-void bio_integrity_trim(struct bio *bio, unsigned int offset,
-			unsigned int sectors)
+void bio_integrity_trim(struct bio *bio)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 
-	bio_integrity_advance(bio, offset << 9);
-	bip->bip_iter.bi_size = bio_integrity_bytes(bi, sectors);
+	bip->bip_iter.bi_size = bio_integrity_bytes(bi, bio_sectors(bio));
 }
 EXPORT_SYMBOL(bio_integrity_trim);
 
diff --git a/block/bio.c b/block/bio.c
index 8cd995f7d3c0..7a288d344638 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1862,7 +1862,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	split->bi_iter.bi_size = sectors << 9;
 
 	if (bio_integrity(split))
-		bio_integrity_trim(split, 0, sectors);
+		bio_integrity_trim(split);
 
 	bio_advance(bio, split->bi_iter.bi_size);
 
@@ -1896,7 +1896,7 @@ void bio_trim(struct bio *bio, int offset, int size)
 	bio->bi_iter.bi_size = size;
 
 	if (bio_integrity(bio))
-		bio_integrity_trim(bio, 0, size);
+		bio_integrity_trim(bio);
 
 }
 EXPORT_SYMBOL_GPL(bio_trim);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 402946035308..13e714ea7a42 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1153,7 +1153,7 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 	clone->bi_iter.bi_size = to_bytes(len);
 
 	if (unlikely(bio_integrity(bio) != NULL))
-		bio_integrity_trim(clone, 0, len);
+		bio_integrity_trim(clone);
 
 	return 0;
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4907bea03908..8f11b659a992 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -727,7 +727,7 @@ extern bool bio_integrity_enabled(struct bio *bio);
 extern int bio_integrity_prep(struct bio *);
 extern void bio_integrity_endio(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
-extern void bio_integrity_trim(struct bio *, unsigned int, unsigned int);
+extern void bio_integrity_trim(struct bio *);
 extern int bio_integrity_clone(struct bio *, struct bio *, gfp_t);
 extern int bioset_integrity_create(struct bio_set *, int);
 extern void bioset_integrity_free(struct bio_set *);
@@ -777,8 +777,7 @@ static inline void bio_integrity_advance(struct bio *bio,
 	return;
 }
 
-static inline void bio_integrity_trim(struct bio *bio, unsigned int offset,
-				      unsigned int sectors)
+static inline void bio_integrity_trim(struct bio *bio)
 {
 	return;
 }
-- 
2.11.0

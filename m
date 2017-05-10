Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 4/9] bio-integrity: fix interface for bio_integrity_trim
Date: Wed, 10 May 2017 19:20:47 +0400
Message-Id: <1494429652-9488-5-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

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
---
 block/bio-integrity.c | 11 ++---------
 block/bio.c           |  4 ++--
 drivers/md/dm.c       |  2 +-
 include/linux/bio.h   |  5 ++---
 4 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 82a6ffb..6170dad 100644
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
index 2f01f1b..d42e602 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1857,7 +1857,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	split->bi_iter.bi_size = sectors << 9;
 
 	if (bio_integrity(split))
-		bio_integrity_trim(split, 0, sectors);
+		bio_integrity_trim(split);
 
 	bio_advance(bio, split->bi_iter.bi_size);
 
@@ -1891,7 +1891,7 @@ void bio_trim(struct bio *bio, int offset, int size)
 	bio->bi_iter.bi_size = size;
 
 	if (bio_integrity(bio))
-		bio_integrity_trim(bio, 0, size);
+		bio_integrity_trim(bio);
 
 }
 EXPORT_SYMBOL_GPL(bio_trim);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 6ef9500..35e5f57 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1146,7 +1146,7 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 	clone->bi_iter.bi_size = to_bytes(len);
 
 	if (unlikely(bio_integrity(bio) != NULL))
-		bio_integrity_trim(clone, 0, len);
+		bio_integrity_trim(clone);
 
 	return 0;
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d1b04b0..5834186 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -724,7 +724,7 @@ extern bool bio_integrity_enabled(struct bio *bio);
 extern int bio_integrity_prep(struct bio *);
 extern void bio_integrity_endio(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
-extern void bio_integrity_trim(struct bio *, unsigned int, unsigned int);
+extern void bio_integrity_trim(struct bio *);
 extern int bio_integrity_clone(struct bio *, struct bio *, gfp_t);
 extern int bioset_integrity_create(struct bio_set *, int);
 extern void bioset_integrity_free(struct bio_set *);
@@ -774,8 +774,7 @@ static inline void bio_integrity_advance(struct bio *bio,
 	return;
 }
 
-static inline void bio_integrity_trim(struct bio *bio, unsigned int offset,
-				      unsigned int sectors)
+static inline void bio_integrity_trim(struct bio *bio)
 {
 	return;
 }
-- 
2.9.3

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33164 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934026AbdC3Nt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 09:49:56 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 5/8] bio-integrity: fix interface for bio_integrity_trim
Date: Thu, 30 Mar 2017 17:49:33 +0400
Message-Id: <1490881776-28735-6-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1490881776-28735-1-git-send-email-dmonakhov@openvz.org>
References: <1490881776-28735-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bio_integrity_trim inherent it's interface from bio_trim and accept
offset and size, but this API is error prone because data offset
must always be in sync with bio's data offset. That is why we have
integrity update hook in bio_advance()

So the only meaningful offset is 0. Let's just remove it completely.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 block/bio-integrity.c | 8 +-------
 block/bio.c           | 4 ++--
 drivers/md/dm.c       | 2 +-
 include/linux/bio.h   | 5 ++---
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 43a4476..43895a0 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -433,21 +433,15 @@ EXPORT_SYMBOL(bio_integrity_advance);
 /**
  * bio_integrity_trim - Trim integrity vector
  * @bio:	bio whose integrity vector to update
- * @offset:	offset to first data sector
  * @sectors:	number of data sectors
  *
  * Description: Used to trim the integrity vector in a cloned bio.
- * The ivec will be advanced corresponding to 'offset' data sectors
- * and the length will be truncated corresponding to 'len' data
- * sectors.
  */
-void bio_integrity_trim(struct bio *bio, unsigned int offset,
-			unsigned int sectors)
+void bio_integrity_trim(struct bio *bio, unsigned int sectors)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 
-	bio_integrity_advance(bio, offset << 9);
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, sectors);
 }
 EXPORT_SYMBOL(bio_integrity_trim);
diff --git a/block/bio.c b/block/bio.c
index fa84323..6895986 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1878,7 +1878,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	split->bi_iter.bi_size = sectors << 9;
 
 	if (bio_integrity(split))
-		bio_integrity_trim(split, 0, sectors);
+		bio_integrity_trim(split, sectors);
 
 	bio_advance(bio, split->bi_iter.bi_size);
 
@@ -1909,7 +1909,7 @@ void bio_trim(struct bio *bio, int offset, int size)
 	bio->bi_iter.bi_size = size;
 
 	if (bio_integrity(bio))
-		bio_integrity_trim(bio, 0, size);
+		bio_integrity_trim(bio, size);
 
 }
 EXPORT_SYMBOL_GPL(bio_trim);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dfb7597..e54ecdd 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1102,7 +1102,7 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 	clone->bi_iter.bi_size = to_bytes(len);
 
 	if (bio_integrity(bio))
-		bio_integrity_trim(clone, 0, len);
+		bio_integrity_trim(clone, len);
 
 	return 0;
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 00b086a..350f71d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -732,7 +732,7 @@ extern bool bio_integrity_enabled(struct bio *bio);
 extern int bio_integrity_prep(struct bio *);
 extern void bio_integrity_endio(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
-extern void bio_integrity_trim(struct bio *, unsigned int, unsigned int);
+extern void bio_integrity_trim(struct bio *, unsigned int);
 extern int bio_integrity_clone(struct bio *, struct bio *, gfp_t);
 extern int bioset_integrity_create(struct bio_set *, int);
 extern void bioset_integrity_free(struct bio_set *);
@@ -782,8 +782,7 @@ static inline void bio_integrity_advance(struct bio *bio,
 	return;
 }
 
-static inline void bio_integrity_trim(struct bio *bio, unsigned int offset,
-				      unsigned int sectors)
+static inline void bio_integrity_trim(struct bio *bio, unsigned int sectors)
 {
 	return;
 }
-- 
2.9.3

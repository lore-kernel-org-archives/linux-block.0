Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1D226D14
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329028; cv=none; b=qWk61h3KcB8oSiaq4fYismxWKCcvs8L9xNBlayv0Ttgk6/RlDfbwFI0uzua2Vmz7mvQS0VcVuyh8ymQFIy8zWMHcIq5fPjVcDwtn8XcsDBR11q5bMp3h/5zP7AUvElqhV1OVMVYFuFppqYGeLOp1FXrbJ1NAx7EGc549mUCCjwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329028; c=relaxed/simple;
	bh=jQUlL5i+6y7Oeu8lE3T3Ll8MCUN1CnDWl5xP68gZtkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmHWXiI+v2WCiA9GLRn7SxjqdernqVyy65Op09HiG7yxne9dfTYse94Ela4oQgXiUCsVRTvtOO/N2/wSaIAhLpzzNvAkb7aFVbHzduKkS8jw630JMYvAGAYVu9YOz77A4KaHYnSPHRe4xFCo0ha1w+9lSMm6DHThmoh9IGJTSl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zJDUFTHL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zJDUFTHL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5E+AHoDM9odRpLAHbKE3WTIkZq2vNit7bUxk7S6fYT8=; b=zJDUFTHLZhxhhstycTJco4sTws
	nqPZZIxICl8X3trl3FyQGm8bTE5EBi52PtA0y7Q+Jv0c0obMA0ws+vDJyW1G1lDyVEoNgb8piZEld
	+ASoU37fs1XdaJ7jamWIaD7Hq9wyIuFhOy0gLpCKq2ZjBW42Qyfssj+JbGO0s5pVuOdWSQGAwK0B0
	uYPvoILdbvD72cg9cLRh+KqLwq/4ClpVDLNcvlJr4XHpZaXR0ZAdCeBfoY0KkcApUoBB0MiIuiMoJ
	m/Sw9Woky12LkDtbY8NsGrCuTz2j+eAijdJDEICcAwk/umd4a+jU1UTVoywlXSuKktlQi9jnABZgL
	F6RnSAMw==;
Received: from 85-127-105-228.dsl.dynamic.surfer.at ([85.127.105.228] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvZYX-0000000GVH2-0wtd;
	Mon, 08 Sep 2025 10:57:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: remove the bi_inline_vecs variable sized array from struct bio
Date: Mon,  8 Sep 2025 12:56:39 +0200
Message-ID: <20250908105653.4079264-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250908105653.4079264-1-hch@lst.de>
References: <20250908105653.4079264-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Bios are embedded into other structures, and at least spare is unhappy
about embedding structures with variable sized arrays.  There's no
real need to the array anyway, we can replace it with a helper pointing
to the memory just behind the bio, and with the previous cleanups there
is very few site doing anything special with it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                   |  3 ++-
 drivers/md/bcache/movinggc.c  |  6 +++---
 drivers/md/bcache/writeback.c |  6 +++---
 drivers/md/dm-vdo/vio.c       |  2 +-
 fs/bcachefs/data_update.h     |  1 -
 fs/bcachefs/journal.c         |  4 ++--
 include/linux/bio.h           |  2 +-
 include/linux/blk_types.h     | 12 +++++-------
 8 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index bd8bf179981a..971d96afaf8d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -617,7 +617,8 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
 
 	if (nr_vecs > BIO_MAX_INLINE_VECS)
 		return NULL;
-	return kmalloc(struct_size(bio, bi_inline_vecs, nr_vecs), gfp_mask);
+	return kmalloc(sizeof(*bio) + nr_vecs * sizeof(struct bio_vec),
+			gfp_mask);
 }
 EXPORT_SYMBOL(bio_kmalloc);
 
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index 4fc80c6d5b31..73918e55bf04 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -145,9 +145,9 @@ static void read_moving(struct cache_set *c)
 			continue;
 		}
 
-		io = kzalloc(struct_size(io, bio.bio.bi_inline_vecs,
-					 DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS)),
-			     GFP_KERNEL);
+		io = kzalloc(sizeof(*io) + sizeof(struct bio_vec) *
+				DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS),
+				GFP_KERNEL);
 		if (!io)
 			goto err;
 
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 36dd8f14a6df..6ba73dc1a3df 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -536,9 +536,9 @@ static void read_dirty(struct cached_dev *dc)
 		for (i = 0; i < nk; i++) {
 			w = keys[i];
 
-			io = kzalloc(struct_size(io, bio.bi_inline_vecs,
-						DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS)),
-				     GFP_KERNEL);
+			io = kzalloc(sizeof(*io) + sizeof(struct bio_vec) *
+				DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS),
+				GFP_KERNEL);
 			if (!io)
 				goto err;
 
diff --git a/drivers/md/dm-vdo/vio.c b/drivers/md/dm-vdo/vio.c
index e7f4153e55e3..8fc22fb14196 100644
--- a/drivers/md/dm-vdo/vio.c
+++ b/drivers/md/dm-vdo/vio.c
@@ -212,7 +212,7 @@ int vio_reset_bio_with_size(struct vio *vio, char *data, int size, bio_end_io_t
 		return VDO_SUCCESS;
 
 	bio->bi_ioprio = 0;
-	bio->bi_io_vec = bio->bi_inline_vecs;
+	bio->bi_io_vec = bio_inline_vecs(bio);
 	bio->bi_max_vecs = vio->block_count + 1;
 	if (VDO_ASSERT(size <= vio_size, "specified size %d is not greater than allocated %d",
 		       size, vio_size) != VDO_SUCCESS)
diff --git a/fs/bcachefs/data_update.h b/fs/bcachefs/data_update.h
index 5e14d13568de..1b37780abfda 100644
--- a/fs/bcachefs/data_update.h
+++ b/fs/bcachefs/data_update.h
@@ -62,7 +62,6 @@ struct promote_op {
 
 	struct work_struct	work;
 	struct data_update	write;
-	struct bio_vec		bi_inline_vecs[]; /* must be last */
 };
 
 void bch2_data_update_to_text(struct printbuf *, struct data_update *);
diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
index 3dbf9faaaa4c..474e0e867b68 100644
--- a/fs/bcachefs/journal.c
+++ b/fs/bcachefs/journal.c
@@ -1627,8 +1627,8 @@ int bch2_dev_journal_init(struct bch_dev *ca, struct bch_sb *sb)
 	unsigned nr_bvecs = DIV_ROUND_UP(JOURNAL_ENTRY_SIZE_MAX, PAGE_SIZE);
 
 	for (unsigned i = 0; i < ARRAY_SIZE(ja->bio); i++) {
-		ja->bio[i] = kzalloc(struct_size(ja->bio[i], bio.bi_inline_vecs,
-				     nr_bvecs), GFP_KERNEL);
+		ja->bio[i] = kzalloc(sizeof(*ja->bio[i]) +
+				sizeof(struct bio_vec) * nr_bvecs, GFP_KERNEL);
 		if (!ja->bio[i])
 			return bch_err_throw(c, ENOMEM_dev_journal_init);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index eb7f4fbd8aa9..27cbff5b0356 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -408,7 +408,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 static inline void bio_init_inline(struct bio *bio, struct block_device *bdev,
 	      unsigned short max_vecs, blk_opf_t opf)
 {
-	bio_init(bio, bdev, bio->bi_inline_vecs, max_vecs, opf);
+	bio_init(bio, bdev, bio_inline_vecs(bio), max_vecs, opf);
 }
 extern void bio_uninit(struct bio *);
 void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 930daff207df..bbb7893e0542 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -269,18 +269,16 @@ struct bio {
 	struct bio_vec		*bi_io_vec;	/* the actual vec list */
 
 	struct bio_set		*bi_pool;
-
-	/*
-	 * We can inline a number of vecs at the end of the bio, to avoid
-	 * double allocations for a small number of bio_vecs. This member
-	 * MUST obviously be kept at the very end of the bio.
-	 */
-	struct bio_vec		bi_inline_vecs[];
 };
 
 #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
 #define BIO_MAX_SECTORS		(UINT_MAX >> SECTOR_SHIFT)
 
+static inline struct bio_vec *bio_inline_vecs(struct bio *bio)
+{
+	return (struct bio_vec *)(bio + 1);
+}
+
 /*
  * bio flags
  */
-- 
2.47.2


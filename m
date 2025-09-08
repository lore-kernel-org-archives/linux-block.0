Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6722256F
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329024; cv=none; b=aCUNbjFsDuAXe8jS2nNbk7Z+wLeww3jrEumWKI4ZOmzkUqsZb5KvntJKtxIOhsGbPSc64zzagIuHlAcR7O/HFdYUWmhUeiVJvIemQ4ftvpkAKN6UkONmHrjiV22vFktlf2dLAWwO6uvRe3bVkAmq2tXV5D5x0NogpS3U1/XwF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329024; c=relaxed/simple;
	bh=3K9W05DqKj2XJxmOBEkNrIuzwrmTuP/WnsgNK6kzrjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcU/e+0mOdejrrolycsh2Sfw0tTZ0YaeCrCsI0ds48djx2sRGGNeoqEsZjT2e+Md0csOfBzgr5BKD/z/ZDMQopDmPBCIoUiNmxULJAGhNy/afxS8ExCN9q1OnkKRujqygUNPU7vriOCHWIFaJ9KIKqDNYtZoxLjHv3O5s/zharc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=13PfBAaP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="13PfBAaP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WU56IKIYAay7e4AERlL3TA01A7A4q8HdLXAq2WkrGfY=; b=13PfBAaP+MUdw73cGZN/FmBVaj
	SdMITO61DFZpV6cjxSS2NQIth0G+5c5CrG2KyUbeiIBdDfqNofJ5AQbR5iFb79Umr0kcrwRt7WluL
	caNhYnHRvdfEc2IeRt/5cLRNkpQ9CCQw5ECz76rb0fdJZySuZyD+nGif8nZDBGDkZtbqfF/QWYi1x
	/kVmCa/G5HURRnM4IxYB2Is2uw1BCwlcEIUKdRFbdqBMHDGyBqBLhME9X0DxTrO0ao+UHgEO9rKrj
	c4JMdvW/WgglHw3nxY9/l4hmOuT8azYPxb+kUKmAfU8MnF6qs69U4KIPMJ1KBjNNlTCBo78sjglqH
	765LnTZg==;
Received: from 85-127-105-228.dsl.dynamic.surfer.at ([85.127.105.228] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvZYT-0000000GVFf-0Xtu;
	Mon, 08 Sep 2025 10:57:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: add a bio_init_inline helper
Date: Mon,  8 Sep 2025 12:56:38 +0200
Message-ID: <20250908105653.4079264-2-hch@lst.de>
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

Just a simpler wrapper around bio_init for callers that want to
initialize a bio with inline bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                        | 7 +++++--
 block/blk-crypto-fallback.c        | 3 +--
 block/blk-map.c                    | 8 ++++----
 drivers/md/bcache/debug.c          | 3 +--
 drivers/md/bcache/io.c             | 3 +--
 drivers/md/bcache/journal.c        | 2 +-
 drivers/md/bcache/movinggc.c       | 2 +-
 drivers/md/bcache/super.c          | 2 +-
 drivers/md/bcache/writeback.c      | 2 +-
 drivers/md/dm-bufio.c              | 2 +-
 drivers/md/dm-flakey.c             | 2 +-
 drivers/md/raid1.c                 | 2 +-
 drivers/md/raid10.c                | 4 ++--
 drivers/target/target_core_pscsi.c | 2 +-
 fs/bcachefs/btree_io.c             | 2 +-
 fs/bcachefs/journal.c              | 2 +-
 fs/bcachefs/journal_io.c           | 2 +-
 fs/bcachefs/super-io.c             | 2 +-
 fs/squashfs/block.c                | 2 +-
 include/linux/bio.h                | 5 +++++
 20 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44c43b970387..bd8bf179981a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -462,7 +462,10 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
 	cache->nr--;
 	put_cpu();
 
-	bio_init(bio, bdev, nr_vecs ? bio->bi_inline_vecs : NULL, nr_vecs, opf);
+	if (nr_vecs)
+		bio_init_inline(bio, bdev, nr_vecs, opf);
+	else
+		bio_init(bio, bdev, NULL, nr_vecs, opf);
 	bio->bi_pool = bs;
 	return bio;
 }
@@ -578,7 +581,7 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 
 		bio_init(bio, bdev, bvl, nr_vecs, opf);
 	} else if (nr_vecs) {
-		bio_init(bio, bdev, bio->bi_inline_vecs, BIO_INLINE_VECS, opf);
+		bio_init_inline(bio, bdev, BIO_INLINE_VECS, opf);
 	} else {
 		bio_init(bio, bdev, NULL, 0, opf);
 	}
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 005c9157ffb3..dbc2d8784dab 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -167,8 +167,7 @@ static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
 	bio = bio_kmalloc(nr_segs, GFP_NOIO);
 	if (!bio)
 		return NULL;
-	bio_init(bio, bio_src->bi_bdev, bio->bi_inline_vecs, nr_segs,
-		 bio_src->bi_opf);
+	bio_init_inline(bio, bio_src->bi_bdev, nr_segs, bio_src->bi_opf);
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
diff --git a/block/blk-map.c b/block/blk-map.c
index 23e5d5ebe59e..92b7e19b1a1f 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -157,7 +157,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	bio = bio_kmalloc(nr_pages, gfp_mask);
 	if (!bio)
 		goto out_bmd;
-	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, req_op(rq));
+	bio_init_inline(bio, NULL, nr_pages, req_op(rq));
 
 	if (map_data) {
 		nr_pages = 1U << map_data->page_order;
@@ -264,7 +264,7 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 		bio = bio_kmalloc(nr_vecs, gfp_mask);
 		if (!bio)
 			return NULL;
-		bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
+		bio_init_inline(bio, NULL, nr_vecs, req_op(rq));
 	}
 	return bio;
 }
@@ -326,7 +326,7 @@ static struct bio *bio_map_kern(void *data, unsigned int len, enum req_op op,
 	bio = bio_kmalloc(nr_vecs, gfp_mask);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-	bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, op);
+	bio_init_inline(bio, NULL, nr_vecs, op);
 	if (is_vmalloc_addr(data)) {
 		bio->bi_private = data;
 		if (!bio_add_vmalloc(bio, data, len)) {
@@ -392,7 +392,7 @@ static struct bio *bio_copy_kern(void *data, unsigned int len, enum req_op op,
 	bio = bio_kmalloc(nr_pages, gfp_mask);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, op);
+	bio_init_inline(bio, NULL, nr_pages, op);
 
 	while (len) {
 		struct page *page;
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 7510d1c983a5..f327456fc4e0 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -115,8 +115,7 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
 	check = bio_kmalloc(nr_segs, GFP_NOIO);
 	if (!check)
 		return;
-	bio_init(check, bio->bi_bdev, check->bi_inline_vecs, nr_segs,
-		 REQ_OP_READ);
+	bio_init_inline(check, bio->bi_bdev, nr_segs, REQ_OP_READ);
 	check->bi_iter.bi_sector = bio->bi_iter.bi_sector;
 	check->bi_iter.bi_size = bio->bi_iter.bi_size;
 
diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index 020712c5203f..2386d08bf4e4 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -26,8 +26,7 @@ struct bio *bch_bbio_alloc(struct cache_set *c)
 	struct bbio *b = mempool_alloc(&c->bio_meta, GFP_NOIO);
 	struct bio *bio = &b->bio;
 
-	bio_init(bio, NULL, bio->bi_inline_vecs,
-		 meta_bucket_pages(&c->cache->sb), 0);
+	bio_init_inline(bio, NULL, meta_bucket_pages(&c->cache->sb), 0);
 
 	return bio;
 }
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 7ff14bd2feb8..d50eb82ccb4f 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -615,7 +615,7 @@ static void do_journal_discard(struct cache *ca)
 
 		atomic_set(&ja->discard_in_flight, DISCARD_IN_FLIGHT);
 
-		bio_init(bio, ca->bdev, bio->bi_inline_vecs, 1, REQ_OP_DISCARD);
+		bio_init_inline(bio, ca->bdev, 1, REQ_OP_DISCARD);
 		bio->bi_iter.bi_sector	= bucket_to_sector(ca->set,
 						ca->sb.d[ja->discard_idx]);
 		bio->bi_iter.bi_size	= bucket_bytes(ca);
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index 26a6a535ec32..4fc80c6d5b31 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -79,7 +79,7 @@ static void moving_init(struct moving_io *io)
 {
 	struct bio *bio = &io->bio.bio;
 
-	bio_init(bio, NULL, bio->bi_inline_vecs,
+	bio_init_inline(bio, NULL,
 		 DIV_ROUND_UP(KEY_SIZE(&io->w->key), PAGE_SECTORS), 0);
 	bio_get(bio);
 	bio->bi_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 1492c8552255..6d250e366412 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2236,7 +2236,7 @@ static int cache_alloc(struct cache *ca)
 	__module_get(THIS_MODULE);
 	kobject_init(&ca->kobj, &bch_cache_ktype);
 
-	bio_init(&ca->journal.bio, NULL, ca->journal.bio.bi_inline_vecs, 8, 0);
+	bio_init_inline(&ca->journal.bio, NULL, 8, 0);
 
 	/*
 	 * When the cache disk is first registered, ca->sb.njournal_buckets
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 302e75f1fc4b..36dd8f14a6df 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -331,7 +331,7 @@ static void dirty_init(struct keybuf_key *w)
 	struct dirty_io *io = w->private;
 	struct bio *bio = &io->bio;
 
-	bio_init(bio, NULL, bio->bi_inline_vecs,
+	bio_init_inline(bio, NULL,
 		 DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS), 0);
 	if (!io->dc->writeback_percent)
 		bio->bi_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0);
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index ff7595caf440..8f3a23f4b168 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1342,7 +1342,7 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 		use_dmio(b, op, sector, n_sectors, offset, ioprio);
 		return;
 	}
-	bio_init(bio, b->c->bdev, bio->bi_inline_vecs, 1, op);
+	bio_init_inline(bio, b->c->bdev, 1, op);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = bio_complete;
 	bio->bi_private = b;
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index cf17fd46e255..08925aca838c 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -441,7 +441,7 @@ static struct bio *clone_bio(struct dm_target *ti, struct flakey_c *fc, struct b
 	if (!clone)
 		return NULL;
 
-	bio_init(clone, fc->dev->bdev, clone->bi_inline_vecs, nr_iovecs, bio->bi_opf);
+	bio_init_inline(clone, fc->dev->bdev, nr_iovecs, bio->bi_opf);
 
 	clone->bi_iter.bi_sector = flakey_map_sector(ti, bio->bi_iter.bi_sector);
 	clone->bi_private = bio;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 408c26398321..bc11aaa38615 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -167,7 +167,7 @@ static void * r1buf_pool_alloc(gfp_t gfp_flags, void *data)
 		bio = bio_kmalloc(RESYNC_PAGES, gfp_flags);
 		if (!bio)
 			goto out_free_bio;
-		bio_init(bio, NULL, bio->bi_inline_vecs, RESYNC_PAGES, 0);
+		bio_init_inline(bio, NULL, RESYNC_PAGES, 0);
 		r1_bio->bios[j] = bio;
 	}
 	/*
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b60c30bfb6c7..c52ccd12d86b 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -163,14 +163,14 @@ static void * r10buf_pool_alloc(gfp_t gfp_flags, void *data)
 		bio = bio_kmalloc(RESYNC_PAGES, gfp_flags);
 		if (!bio)
 			goto out_free_bio;
-		bio_init(bio, NULL, bio->bi_inline_vecs, RESYNC_PAGES, 0);
+		bio_init_inline(bio, NULL, RESYNC_PAGES, 0);
 		r10_bio->devs[j].bio = bio;
 		if (!conf->have_replacement)
 			continue;
 		bio = bio_kmalloc(RESYNC_PAGES, gfp_flags);
 		if (!bio)
 			goto out_free_bio;
-		bio_init(bio, NULL, bio->bi_inline_vecs, RESYNC_PAGES, 0);
+		bio_init_inline(bio, NULL, RESYNC_PAGES, 0);
 		r10_bio->devs[j].repl_bio = bio;
 	}
 	/*
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index f991cf759836..db4e09042469 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -861,7 +861,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 				bio = bio_kmalloc(nr_vecs, GFP_KERNEL);
 				if (!bio)
 					goto fail;
-				bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs,
+				bio_init_inline(bio, NULL, nr_vecs,
 					 rw ? REQ_OP_WRITE : REQ_OP_READ);
 				bio->bi_end_io = pscsi_bi_endio;
 
diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index 590cd29f3e86..e701e6d6e321 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -2084,7 +2084,7 @@ int bch2_btree_node_scrub(struct btree_trans *trans,
 
 	INIT_WORK(&scrub->work, btree_node_scrub_work);
 
-	bio_init(&scrub->bio, ca->disk_sb.bdev, scrub->bio.bi_inline_vecs, vecs, REQ_OP_READ);
+	bio_init_inline(&scrub->bio, ca->disk_sb.bdev, vecs, REQ_OP_READ);
 	bch2_bio_map(&scrub->bio, scrub->buf, c->opts.btree_node_size);
 	scrub->bio.bi_iter.bi_sector	= pick.ptr.offset;
 	scrub->bio.bi_end_io		= btree_node_scrub_endio;
diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
index ddfeb0dafc9d..3dbf9faaaa4c 100644
--- a/fs/bcachefs/journal.c
+++ b/fs/bcachefs/journal.c
@@ -1634,7 +1634,7 @@ int bch2_dev_journal_init(struct bch_dev *ca, struct bch_sb *sb)
 
 		ja->bio[i]->ca = ca;
 		ja->bio[i]->buf_idx = i;
-		bio_init(&ja->bio[i]->bio, NULL, ja->bio[i]->bio.bi_inline_vecs, nr_bvecs, 0);
+		bio_init_inline(&ja->bio[i]->bio, NULL, nr_bvecs, 0);
 	}
 
 	ja->buckets = kcalloc(ja->nr, sizeof(u64), GFP_KERNEL);
diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index 9e028dbcc3d0..ce8888d518c3 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -1071,7 +1071,7 @@ static int journal_read_bucket(struct bch_dev *ca,
 			bio = bio_kmalloc(nr_bvecs, GFP_KERNEL);
 			if (!bio)
 				return bch_err_throw(c, ENOMEM_journal_read_bucket);
-			bio_init(bio, ca->disk_sb.bdev, bio->bi_inline_vecs, nr_bvecs, REQ_OP_READ);
+			bio_init_inline(bio, ca->disk_sb.bdev, nr_bvecs, REQ_OP_READ);
 
 			bio->bi_iter.bi_sector = offset;
 			bch2_bio_map(bio, buf->data, sectors_read << 9);
diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index 6c2e1d647403..e3fcffb93d2b 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -232,7 +232,7 @@ int bch2_sb_realloc(struct bch_sb_handle *sb, unsigned u64s)
 		if (!bio)
 			return -BCH_ERR_ENOMEM_sb_bio_realloc;
 
-		bio_init(bio, NULL, bio->bi_inline_vecs, nr_bvecs, 0);
+		bio_init_inline(bio, NULL, nr_bvecs, 0);
 
 		kfree(sb->bio);
 		sb->bio = bio;
diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index b69c294e3ef0..a05e3793f93a 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -231,7 +231,7 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 	bio = bio_kmalloc(page_count, GFP_NOIO);
 	if (!bio)
 		return -ENOMEM;
-	bio_init(bio, sb->s_bdev, bio->bi_inline_vecs, page_count, REQ_OP_READ);
+	bio_init_inline(bio, sb->s_bdev, page_count, REQ_OP_READ);
 	bio->bi_iter.bi_sector = block * (msblk->devblksize >> SECTOR_SHIFT);
 
 	for (i = 0; i < page_count; ++i) {
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 46ffac5caab7..eb7f4fbd8aa9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -405,6 +405,11 @@ struct request_queue;
 
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	      unsigned short max_vecs, blk_opf_t opf);
+static inline void bio_init_inline(struct bio *bio, struct block_device *bdev,
+	      unsigned short max_vecs, blk_opf_t opf)
+{
+	bio_init(bio, bdev, bio->bi_inline_vecs, max_vecs, opf);
+}
 extern void bio_uninit(struct bio *);
 void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
 void bio_chain(struct bio *, struct bio *);
-- 
2.47.2


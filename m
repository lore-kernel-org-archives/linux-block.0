Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 20/33] md/dm/bcache: conver to bio_for_each_page_all2 and bio_for_each_segment
Date: Thu, 24 May 2018 17:01:25 +0800
Message-Id: <20180524090139.2150-21-ming.lei@redhat.com>
In-Reply-To: <20180524090139.2150-1-ming.lei@redhat.com>
References: <20180524090139.2150-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

In bch_bio_alloc_pages(), bio_for_each_segment() is fine because this
helper can only be used on a freshly new bio.

For other cases, we conver to bio_for_each_page_all2() since they needn't
to update bvec table.

bio_for_each_page_all() can't be used any more after multipage bvec is
enabled, so we have to convert to bio_for_each_page_all2().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/bcache/btree.c | 3 ++-
 drivers/md/bcache/util.c  | 2 +-
 drivers/md/dm-crypt.c     | 3 ++-
 drivers/md/raid1.c        | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index a9d82911c3d2..498f6b032b4c 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -423,8 +423,9 @@ static void do_btree_node_write(struct btree *b)
 		int j;
 		struct bio_vec *bv;
 		void *base = (void *) ((unsigned long) i & ~(PAGE_SIZE - 1));
+		struct bvec_iter_all bia;
 
-		bio_for_each_page_all(bv, b->bio, j)
+		bio_for_each_page_all2(bv, b->bio, j, bia)
 			memcpy(page_address(bv->bv_page),
 			       base + j * PAGE_SIZE, PAGE_SIZE);
 
diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index 77230973a110..74febd5230df 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -303,7 +303,7 @@ int bch_bio_alloc_pages(struct bio *bio, gfp_t gfp_mask)
 	int i;
 	struct bio_vec *bv;
 
-	bio_for_each_page_all(bv, bio, i) {
+	bio_for_each_segment_all(bv, bio, i) {
 		bv->bv_page = alloc_page(gfp_mask);
 		if (!bv->bv_page) {
 			while (--bv >= bio->bi_io_vec)
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 74737ae0ef11..8fdc8349fd72 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1450,8 +1450,9 @@ static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
 {
 	unsigned int i;
 	struct bio_vec *bv;
+	struct bvec_iter_all bia;
 
-	bio_for_each_page_all(bv, clone, i) {
+	bio_for_each_page_all2(bv, clone, i, bia) {
 		BUG_ON(!bv->bv_page);
 		mempool_free(bv->bv_page, cc->page_pool);
 	}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index e318a0c19eb0..8b2b071619a2 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2117,13 +2117,14 @@ static void process_checks(struct r1bio *r1_bio)
 		struct page **spages = get_resync_pages(sbio)->pages;
 		struct bio_vec *bi;
 		int page_len[RESYNC_PAGES] = { 0 };
+		struct bvec_iter_all bia;
 
 		if (sbio->bi_end_io != end_sync_read)
 			continue;
 		/* Now we can 'fixup' the error value */
 		sbio->bi_status = 0;
 
-		bio_for_each_page_all(bi, sbio, j)
+		bio_for_each_page_all2(bi, sbio, j, bia)
 			page_len[j] = bi->bv_len;
 
 		if (!status) {
-- 
2.9.5

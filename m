Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 47/60] block: convert to bio_for_each_segment_all_rd()
Date: Sat, 29 Oct 2016 16:08:46 +0800
Message-Id: <1477728600-12938-48-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/bio.c    | 17 +++++++++++------
 block/bounce.c |  6 ++++--
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8e5af6e8bba3..c9cf0a81cca3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -934,7 +934,7 @@ int bio_alloc_pages(struct bio *bio, gfp_t gfp_mask)
 	int i;
 	struct bio_vec *bv;
 
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_segment_all_wt(bv, bio, i) {
 		bv->bv_page = alloc_page(gfp_mask);
 		if (!bv->bv_page) {
 			while (--bv >= bio->bi_io_vec)
@@ -1035,8 +1035,9 @@ static int bio_copy_from_iter(struct bio *bio, struct iov_iter iter)
 {
 	int i;
 	struct bio_vec *bvec;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_rd(bvec, bio, i, bia) {
 		ssize_t ret;
 
 		ret = copy_page_from_iter(bvec->bv_page,
@@ -1066,8 +1067,9 @@ static int bio_copy_to_iter(struct bio *bio, struct iov_iter iter)
 {
 	int i;
 	struct bio_vec *bvec;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_rd(bvec, bio, i, bia) {
 		ssize_t ret;
 
 		ret = copy_page_to_iter(bvec->bv_page,
@@ -1089,8 +1091,9 @@ void bio_free_pages(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i)
+	bio_for_each_segment_all_rd(bvec, bio, i, bia)
 		__free_page(bvec->bv_page);
 }
 EXPORT_SYMBOL(bio_free_pages);
@@ -1390,11 +1393,12 @@ static void __bio_unmap_user(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
 	/*
 	 * make sure we dirty pages we wrote to
 	 */
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_rd(bvec, bio, i, bia) {
 		if (bio_data_dir(bio) == READ)
 			set_page_dirty_lock(bvec->bv_page);
 
@@ -1486,8 +1490,9 @@ static void bio_copy_kern_endio_read(struct bio *bio)
 	char *p = bio->bi_private;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_rd(bvec, bio, i, bia) {
 		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
 		p += bvec->bv_len;
 	}
diff --git a/block/bounce.c b/block/bounce.c
index da240d1de809..5459127188c1 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -135,11 +135,12 @@ static void bounce_end_io(struct bio *bio, mempool_t *pool)
 	struct bio_vec *bvec, orig_vec;
 	int i;
 	struct bvec_iter orig_iter = bio_orig->bi_iter;
+	struct bvec_iter_all bia;
 
 	/*
 	 * free up bounce indirect pages used
 	 */
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_rd(bvec, bio, i, bia) {
 
 		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
 		if (bvec->bv_page == orig_vec.bv_page)
@@ -214,13 +215,14 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	int rw = bio_data_dir(*bio_orig);
 	struct bio_vec *to;
 	unsigned i;
+	struct bvec_iter_all bia;
 
 	if (!need_bounce(q, *bio_orig))
 		return;
 
 	bio = bio_clone_bioset_sp(*bio_orig, GFP_NOIO, fs_bio_set);
 
-	bio_for_each_segment_all(to, bio, i) {
+	bio_for_each_segment_all_rd(to, bio, i, bia) {
 		struct page *page = to->bv_page;
 
 		if (page_to_pfn(page) <= queue_bounce_pfn(q))
-- 
2.7.4

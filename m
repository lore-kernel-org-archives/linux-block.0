Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752572AbdFZMSv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:18:51 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 34/51] block: convert to singe/multi page version of bio_for_each_segment_all()
Date: Mon, 26 Jun 2017 20:10:17 +0800
Message-Id: <20170626121034.3051-35-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c       | 17 +++++++++++------
 block/blk-zoned.c |  5 +++--
 block/bounce.c    |  6 ++++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 22e5deec7ec7..c460888f14b5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -988,7 +988,7 @@ int bio_alloc_pages(struct bio *bio, gfp_t gfp_mask)
 	int i;
 	struct bio_vec *bv;
 
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_segment_all_mp(bv, bio, i) {
 		bv->bv_page = alloc_page(gfp_mask);
 		if (!bv->bv_page) {
 			while (--bv >= bio->bi_io_vec)
@@ -1089,8 +1089,9 @@ static int bio_copy_from_iter(struct bio *bio, struct iov_iter iter)
 {
 	int i;
 	struct bio_vec *bvec;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		ssize_t ret;
 
 		ret = copy_page_from_iter(bvec->bv_page,
@@ -1120,8 +1121,9 @@ static int bio_copy_to_iter(struct bio *bio, struct iov_iter iter)
 {
 	int i;
 	struct bio_vec *bvec;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		ssize_t ret;
 
 		ret = copy_page_to_iter(bvec->bv_page,
@@ -1143,8 +1145,9 @@ void bio_free_pages(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i)
+	bio_for_each_segment_all_sp(bvec, bio, i, bia)
 		__free_page(bvec->bv_page);
 }
 EXPORT_SYMBOL(bio_free_pages);
@@ -1435,11 +1438,12 @@ static void __bio_unmap_user(struct bio *bio)
 {
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
 	/*
 	 * make sure we dirty pages we wrote to
 	 */
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		if (bio_data_dir(bio) == READ)
 			set_page_dirty_lock(bvec->bv_page);
 
@@ -1531,8 +1535,9 @@ static void bio_copy_kern_endio_read(struct bio *bio)
 	char *p = bio->bi_private;
 	struct bio_vec *bvec;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
 		p += bvec->bv_len;
 	}
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3bd15d8095b1..558b84ae2d86 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -81,6 +81,7 @@ int blkdev_report_zones(struct block_device *bdev,
 	unsigned int ofst;
 	void *addr;
 	int ret;
+	struct bvec_iter_all bia;
 
 	if (!q)
 		return -ENXIO;
@@ -148,7 +149,7 @@ int blkdev_report_zones(struct block_device *bdev,
 	n = 0;
 	nz = 0;
 	nr_rep = 0;
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_segment_all_sp(bv, bio, i, bia) {
 
 		if (!bv->bv_page)
 			break;
@@ -181,7 +182,7 @@ int blkdev_report_zones(struct block_device *bdev,
 
 	*nr_zones = nz;
 out:
-	bio_for_each_segment_all(bv, bio, i)
+	bio_for_each_segment_all_sp(bv, bio, i, bia)
 		__free_page(bv->bv_page);
 	bio_put(bio);
 
diff --git a/block/bounce.c b/block/bounce.c
index 590dcdb1de76..1f46ba9535c1 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -144,11 +144,12 @@ static void bounce_end_io(struct bio *bio, mempool_t *pool)
 	struct bio_vec *bvec, orig_vec;
 	int i;
 	struct bvec_iter orig_iter = bio_orig->bi_iter;
+	struct bvec_iter_all bia;
 
 	/*
 	 * free up bounce indirect pages used
 	 */
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
 		if (bvec->bv_page == orig_vec.bv_page)
 			goto next;
@@ -205,6 +206,7 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	unsigned i = 0;
 	bool bounce = false;
 	int sectors = 0;
+	struct bvec_iter_all bia;
 
 	bio_for_each_segment(from, *bio_orig, iter) {
 		if (i++ < BIO_MAX_PAGES)
@@ -223,7 +225,7 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	}
 	bio = bio_clone_bioset(*bio_orig, GFP_NOIO, bounce_bio_set);
 
-	bio_for_each_segment_all(to, bio, i) {
+	bio_for_each_segment_all_sp(to, bio, i, bia) {
 		struct page *page = to->bv_page;
 
 		if (page_to_pfn(page) <= queue_bounce_pfn(q))
-- 
2.9.4

Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 21/33] fs: conver to bio_for_each_page_all2
Date: Thu, 24 May 2018 17:01:26 +0800
Message-Id: <20180524090139.2150-22-ming.lei@redhat.com>
In-Reply-To: <20180524090139.2150-1-ming.lei@redhat.com>
References: <20180524090139.2150-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

bio_for_each_page_all() can't be used any more after multipage bvec is
enabled, so we have to convert to bio_for_each_page_all2().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c  | 6 ++++--
 fs/crypto/bio.c | 3 ++-
 fs/direct-io.c  | 4 +++-
 fs/iomap.c      | 3 ++-
 fs/mpage.c      | 3 ++-
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 65498a34efa9..f581fc0a6142 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -197,6 +197,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	ssize_t ret;
 	blk_qc_t qc;
 	int i;
+	struct bvec_iter_all bia;
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
@@ -242,7 +243,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	}
 	__set_current_state(TASK_RUNNING);
 
-	bio_for_each_page_all(bvec, &bio, i) {
+	bio_for_each_page_all2(bvec, &bio, i, bia) {
 		if (should_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
 		put_page(bvec->bv_page);
@@ -309,8 +310,9 @@ static void blkdev_bio_end_io(struct bio *bio)
 	} else {
 		struct bio_vec *bvec;
 		int i;
+		struct bvec_iter_all bia;
 
-		bio_for_each_page_all(bvec, bio, i)
+		bio_for_each_page_all2(bvec, bio, i, bia)
 			put_page(bvec->bv_page);
 		bio_put(bio);
 	}
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 2dda77c3a89a..743c3ecb7f97 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -37,8 +37,9 @@ static void completion_pages(struct work_struct *work)
 	struct bio *bio = ctx->r.bio;
 	struct bio_vec *bv;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_page_all(bv, bio, i) {
+	bio_for_each_page_all2(bv, bio, i, bia) {
 		struct page *page = bv->bv_page;
 		int ret = fscrypt_decrypt_page(page->mapping->host, page,
 				PAGE_SIZE, 0, page->index);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index bbf25b0de9f8..e6a6dd560da2 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -551,7 +551,9 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {
 		bio_check_pages_dirty(bio);	/* transfers ownership */
 	} else {
-		bio_for_each_page_all(bvec, bio, i) {
+		struct bvec_iter_all bia;
+
+		bio_for_each_page_all2(bvec, bio, i, bia) {
 			struct page *page = bvec->bv_page;
 
 			if (dio->op == REQ_OP_READ && !PageCompound(page) &&
diff --git a/fs/iomap.c b/fs/iomap.c
index 42b0b1697b3d..31d19f8f0aac 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -817,8 +817,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	} else {
 		struct bio_vec *bvec;
 		int i;
+		struct bvec_iter_all bia;
 
-		bio_for_each_page_all(bvec, bio, i)
+		bio_for_each_page_all2(bvec, bio, i, bia)
 			put_page(bvec->bv_page);
 		bio_put(bio);
 	}
diff --git a/fs/mpage.c b/fs/mpage.c
index 1cf322c4d6f8..f2da0f9ec0f2 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -48,8 +48,9 @@ static void mpage_end_io(struct bio *bio)
 {
 	struct bio_vec *bv;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_page_all(bv, bio, i) {
+	bio_for_each_page_all2(bv, bio, i, bia) {
 		struct page *page = bv->bv_page;
 		page_endio(page, op_is_write(bio_op(bio)),
 				blk_status_to_errno(bio->bi_status));
-- 
2.9.5

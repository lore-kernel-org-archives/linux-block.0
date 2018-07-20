Return-Path: <mwilck@suse.com>
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v4 3/4] block: add bio_iov_iter_get_all_pages() helper
Date: Fri, 20 Jul 2018 15:05:51 +0200
Message-Id: <20180720130552.21432-4-mwilck@suse.com>
In-Reply-To: <20180720130552.21432-1-mwilck@suse.com>
References: <20180720130552.21432-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

bio_iov_iter_get_pages() only adds pages for the next non-zero
segment from the iov_iter to the bio. Some callers prefer to
obtain as many pages as would fit into the bio, with proper
rollback in case of failure. Add bio_iov_iter_get_all_pages()
for this purpose.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 block/bio.c         | 43 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/bio.h |  1 +
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 489a430..693eb3b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -907,8 +907,10 @@ EXPORT_SYMBOL(bio_add_page);
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be mapped
  *
- * Pins as many pages from *iter and appends them to @bio's bvec array. The
+ * Pins pages from *iter and appends them to @bio's bvec array. The
  * pages will have to be released using put_page() when done.
+ * For multi-segment *iter, this function only adds pages from the
+ * the next non-empty segment of the iov iterator.
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -949,6 +951,45 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
+/**
+ * bio_iov_iter_get_all_pages - pin user or kernel pages and add them to a bio
+ * @bio: bio to add pages to
+ * @iter: iov iterator describing the region to be mapped
+ *
+ * Pins pages from *iter and appends them to @bio's bvec array. The
+ * pages will have to be released using put_page() when done.
+ * This function adds as many pages as possible to a bio.
+ * If this function encounters an error, it unpins the pages it has
+ * pinned before, leaving previously pinned pages untouched.
+ */
+int bio_iov_iter_get_all_pages(struct bio *bio, struct iov_iter *iter)
+{
+	unsigned short orig_vcnt = bio->bi_vcnt;
+
+	do {
+		int ret = bio_iov_iter_get_pages(bio, iter);
+
+		if (unlikely(ret)) {
+			struct bio_vec *bvec;
+			unsigned short i;
+
+			bio_for_each_segment_all(bvec, bio, i) {
+				if (i >= orig_vcnt) {
+					put_page(bvec->bv_page);
+					bvec->bv_page = NULL;
+					bvec->bv_len = 0;
+					bvec->bv_offset = 0;
+				}
+			}
+			bio->bi_vcnt = orig_vcnt;
+			return ret;
+		}
+	} while (iov_iter_count(iter) && !bio_full(bio));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_all_pages);
+
 static void submit_bio_wait_endio(struct bio *bio)
 {
 	complete(bio->bi_private);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f08f5fe..824cb74 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -485,6 +485,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+int bio_iov_iter_get_all_pages(struct bio *bio, struct iov_iter *iter);
 struct rq_map_data;
 extern struct bio *bio_map_user_iov(struct request_queue *,
 				    struct iov_iter *, gfp_t);
-- 
2.17.1

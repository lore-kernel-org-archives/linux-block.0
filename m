Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752196AbdHHIuP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Aug 2017 04:50:15 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 20/49] block: introduce bio_for_each_segment_mp()
Date: Tue,  8 Aug 2017 16:45:19 +0800
Message-Id: <20170808084548.18963-21-ming.lei@redhat.com>
In-Reply-To: <20170808084548.18963-1-ming.lei@redhat.com>
References: <20170808084548.18963-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This helper is used to iterate multipage bvec and it is
required in bio_clone().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h  | 34 +++++++++++++++++++++++++++++++---
 include/linux/bvec.h | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 80defb3cfca4..ac8248558ab4 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -68,6 +68,9 @@
 #define bio_data_dir(bio) \
 	(op_is_write(bio_op(bio)) ? WRITE : READ)
 
+#define bio_iter_iovec_mp(bio, iter)				\
+	bvec_iter_bvec_mp((bio)->bi_io_vec, (iter))
+
 /*
  * Check whether this bio carries any data or not. A NULL bio is allowed.
  */
@@ -163,8 +166,8 @@ static inline void *bio_data(struct bio *bio)
 #define bio_for_each_segment_all(bvl, bio, i)				\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
 
-static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
-				    unsigned bytes)
+static inline void __bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
+				      unsigned bytes, bool mp)
 {
 	iter->bi_sector += bytes >> 9;
 
@@ -172,11 +175,26 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 		iter->bi_size -= bytes;
 		iter->bi_done += bytes;
 	} else {
-		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
+		if (!mp)
+			bvec_iter_advance(bio->bi_io_vec, iter, bytes);
+		else
+			bvec_iter_advance_mp(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
 	}
 }
 
+static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
+				    unsigned bytes)
+{
+	__bio_advance_iter(bio, iter, bytes, false);
+}
+
+static inline void bio_advance_iter_mp(struct bio *bio, struct bvec_iter *iter,
+				       unsigned bytes)
+{
+	__bio_advance_iter(bio, iter, bytes, true);
+}
+
 static inline bool bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
 		unsigned int bytes)
 {
@@ -204,6 +222,16 @@ static inline bool bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
+#define __bio_for_each_segment_mp(bvl, bio, iter, start)		\
+	for (iter = (start);						\
+	     (iter).bi_size &&						\
+		((bvl = bio_iter_iovec_mp((bio), (iter))), 1);		\
+	     bio_advance_iter_mp((bio), &(iter), (bvl).bv_len))
+
+/* returns one real segment(multipage bvec) each time */
+#define bio_for_each_segment_mp(bvl, bio, iter)				\
+	__bio_for_each_segment_mp(bvl, bio, iter, (bio)->bi_iter)
+
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
 static inline unsigned bio_segments(struct bio *bio)
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index d5f999a493de..c1ec0945451a 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -131,8 +131,16 @@ struct bvec_iter {
 	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
 })
 
-static inline bool bvec_iter_advance(const struct bio_vec *bv,
-		struct bvec_iter *iter, unsigned bytes)
+#define bvec_iter_bvec_mp(bvec, iter)				\
+((struct bio_vec) {						\
+	.bv_page	= bvec_iter_page_mp((bvec), (iter)),	\
+	.bv_len		= bvec_iter_len_mp((bvec), (iter)),	\
+	.bv_offset	= bvec_iter_offset_mp((bvec), (iter)),	\
+})
+
+static inline bool __bvec_iter_advance(const struct bio_vec *bv,
+				       struct bvec_iter *iter,
+				       unsigned bytes, bool mp)
 {
 	if (WARN_ONCE(bytes > iter->bi_size,
 		     "Attempted to advance past end of bvec iter\n")) {
@@ -141,8 +149,14 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	}
 
 	while (bytes) {
-		unsigned iter_len = bvec_iter_len(bv, *iter);
-		unsigned len = min(bytes, iter_len);
+		unsigned len;
+
+		if (mp)
+			len = bvec_iter_len_mp(bv, *iter);
+		else
+			len = bvec_iter_len_sp(bv, *iter);
+
+		len = min(bytes, len);
 
 		bytes -= len;
 		iter->bi_size -= len;
@@ -181,6 +195,20 @@ static inline bool bvec_iter_rewind(const struct bio_vec *bv,
 	return true;
 }
 
+static inline bool bvec_iter_advance(const struct bio_vec *bv,
+				     struct bvec_iter *iter,
+				     unsigned bytes)
+{
+	return __bvec_iter_advance(bv, iter, bytes, false);
+}
+
+static inline bool bvec_iter_advance_mp(const struct bio_vec *bv,
+					struct bvec_iter *iter,
+					unsigned bytes)
+{
+	return __bvec_iter_advance(bv, iter, bytes, true);
+}
+
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
-- 
2.9.4

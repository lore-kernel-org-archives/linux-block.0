Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36356 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933133AbcL0QHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:07:46 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v1 16/54] block: introduce bio_for_each_segment_mp()
Date: Tue, 27 Dec 2016 23:56:05 +0800
Message-Id: <1482854250-13481-17-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This helper is used to iterate multipage bvec and it is
required in bio_clone().

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bio.h  | 39 ++++++++++++++++++++++++++++++++++-----
 include/linux/bvec.h | 37 ++++++++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 714fbf495af7..2bd4e6f2087a 100644
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
@@ -164,15 +167,31 @@ static inline void *bio_data(struct bio *bio)
 #define bio_for_each_segment_all(bvl, bio, i)				\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
 
-static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
-				    unsigned bytes)
+static inline void __bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
+				      unsigned bytes, bool mp)
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
-		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
+	} else {
+		if (!mp)
+			bvec_iter_advance(bio->bi_io_vec, iter, bytes);
+		else
+			bvec_iter_advance_mp(bio->bi_io_vec, iter, bytes);
+	}
+}
+
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
 }
 
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
@@ -188,6 +207,16 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
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
index d77c3cabce8c..f8a8b293cd32 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -128,16 +128,29 @@ struct bvec_iter {
 	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
 })
 
-static inline void bvec_iter_advance(const struct bio_vec *bv,
-				     struct bvec_iter *iter,
-				     unsigned bytes)
+#define bvec_iter_bvec_mp(bvec, iter)				\
+((struct bio_vec) {						\
+	.bv_page	= bvec_iter_page_mp((bvec), (iter)),	\
+	.bv_len		= bvec_iter_len_mp((bvec), (iter)),	\
+	.bv_offset	= bvec_iter_offset_mp((bvec), (iter)),	\
+})
+
+static inline void __bvec_iter_advance(const struct bio_vec *bv,
+				       struct bvec_iter *iter,
+				       unsigned bytes, bool mp)
 {
 	WARN_ONCE(bytes > iter->bi_size,
 		  "Attempted to advance past end of bvec iter\n");
 
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
@@ -150,6 +163,20 @@ static inline void bvec_iter_advance(const struct bio_vec *bv,
 	}
 }
 
+static inline void bvec_iter_advance(const struct bio_vec *bv,
+				     struct bvec_iter *iter,
+				     unsigned bytes)
+{
+	__bvec_iter_advance(bv, iter, bytes, false);
+}
+
+static inline void bvec_iter_advance_mp(const struct bio_vec *bv,
+					struct bvec_iter *iter,
+					unsigned bytes)
+{
+	__bvec_iter_advance(bv, iter, bytes, true);
+}
+
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
-- 
2.7.4


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 8/9] bio: add bvec_iter rewind API
Date: Wed, 10 May 2017 19:20:51 +0400
Message-Id: <1494429652-9488-9-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Some ->bi_end_io handlers (for example: pi_verify or decrypt handlers)
need to know original data vector, but after bio traverse io-stack it may
be advanced, splited and relocated many times so it is hard to guess
original iterator. Let's add 'bi_done' conter which accounts number
of bytes iterator was advanced during it's evolution. Later end_io handler
may easily restore original iterator by rewinding iterator to
iter->bi_done.

Note: this change makes sizeof (struct bvec_iter) multiple to 8

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 include/linux/bio.h  | 21 +++++++++++++++++++--
 include/linux/bvec.h | 27 +++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 643ecba..ab812a0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -166,9 +166,10 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else {
+		iter->bi_done += bytes;
+	} else {
 		int err;
 
 		err = bvec_iter_advance(bio->bi_io_vec, iter, bytes);
@@ -176,6 +177,22 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 	}
 }
 
+static inline int bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
+				    unsigned int bytes)
+{
+	int err = 0;
+
+	iter->bi_sector -= bytes >> 9;
+
+	if (bio_no_advance_iter(bio)) {
+		iter->bi_size += bytes;
+		iter->bi_done -= bytes;
+	} else {
+		err = bvec_iter_rewind(bio->bi_io_vec, iter, bytes);
+	}
+	return err;
+}
+
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 984a7a8..8cfe4d6 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -40,6 +40,8 @@ struct bvec_iter {
 
 	unsigned int		bi_idx;		/* current index into bvl_vec */
 
+	unsigned int            bi_done;	/* number of bytes completed */
+
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
 };
@@ -84,6 +86,7 @@ static inline int bvec_iter_advance(const struct bio_vec *bv,
 		bytes -= len;
 		iter->bi_size -= len;
 		iter->bi_bvec_done += len;
+		iter->bi_done += len;
 
 		if (iter->bi_bvec_done == __bvec_iter_bvec(bv, *iter)->bv_len) {
 			iter->bi_bvec_done = 0;
@@ -93,6 +96,30 @@ static inline int bvec_iter_advance(const struct bio_vec *bv,
 	return 0;
 }
 
+static inline int bvec_iter_rewind(const struct bio_vec *bv,
+				     struct bvec_iter *iter,
+				     unsigned int bytes)
+{
+	while (bytes) {
+		unsigned len = min(bytes, iter->bi_bvec_done);
+
+		if (iter->bi_bvec_done == 0) {
+			if (WARN_ONCE(iter->bi_idx == 0,
+				      "Attempted to rewind iter beyond "
+				      "bvec's boundaries\n")) {
+				return -EINVAL;
+			}
+			iter->bi_idx--;
+			iter->bi_bvec_done = __bvec_iter_bvec(bv, *iter)->bv_len;
+			continue;
+		}
+		bytes -= len;
+		iter->bi_size += len;
+		iter->bi_bvec_done -= len;
+	}
+	return 0;
+}
+
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
-- 
2.9.3

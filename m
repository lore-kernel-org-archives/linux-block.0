Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35077 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755440AbdDDS46 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 14:56:58 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 8/9] bio: add bvec_iter rewind API
Date: Tue,  4 Apr 2017 22:56:40 +0400
Message-Id: <1491332201-26926-9-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Some ->bi_end_io handlers (for example: pi_verify or decrypt handlers)
need to know original data vector, but after bio traverse io-stack it may
be advanced, splited and relocated many times so it is hard to guess
original iterator. Let's add 'bi_done' conter which accounts number
of bytes iterator was advanced during it's evolution. Later end_io handler
may easily restore original iterator by rewinding iterator to
iter->bi_done.

Note: this change makes sizeof (struct bvec_iter) multiple to 8
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 include/linux/bio.h  | 21 +++++++++++++++++++--
 include/linux/bvec.h | 26 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 12b7fcd..491fb0c 100644
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
 		if (unlikely(err))
@@ -176,6 +177,22 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 	}
 }
 
+static inline void bio_rewind_iter(struct bio *bio, struct bvec_iter *iter,
+				    unsigned bytes)
+{
+	iter->bi_sector -= bytes >> 9;
+
+	if (bio_no_advance_iter(bio)) {
+		iter->bi_size += bytes;
+		iter->bi_done -= bytes;
+	} else {
+		int err;
+		err = bvec_iter_rewind(bio->bi_io_vec, iter, bytes);
+		if (unlikely(err))
+			bio->bi_error = err;
+	}
+}
+
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 984a7a8..35cb97b 100644
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
@@ -93,6 +96,29 @@ static inline int bvec_iter_advance(const struct bio_vec *bv,
 	return 0;
 }
 
+static inline int bvec_iter_rewind(const struct bio_vec *bv,
+				     struct bvec_iter *iter,
+				     unsigned bytes)
+{
+	while (bytes) {
+		unsigned len = min(bytes, iter->bi_bvec_done);
+		if (iter->bi_bvec_done == 0 ) {
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

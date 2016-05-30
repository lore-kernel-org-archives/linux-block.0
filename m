Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33576 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161328AbcE3NgJ (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 30 May 2016 09:36:09 -0400
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@canonical.com>,
	Keith Busch <keith.busch@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Ming Lin <ming.l@ssi.samsung.com>,
	Mike Snitzer <snitzer@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v6 1/8] block: move bvec iterator into include/linux/bvec.h
Date: Mon, 30 May 2016 21:34:29 +0800
Message-Id: <1464615294-9946-2-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bvec iterator helpers should be used to implement by
iterate_bvec():lib/iov_iter.c too, and move them into
one header, so that we can keep bvec iterator header
out of CONFIG_BLOCK. Then we can remove the reinventing
of wheel in iterate_bvec().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 include/linux/bio.h  | 51 +-----------------------------------
 include/linux/bvec.h | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 50 deletions(-)
 create mode 100644 include/linux/bvec.h

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9faebf7..ed4bfb9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -31,6 +31,7 @@
 
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
+#include <linux/bvec.h>
 
 #define BIO_DEBUG
 
@@ -57,29 +58,6 @@
 	(bio)->bi_rw |= ((unsigned long) (prio) << BIO_PRIO_SHIFT);	\
 } while (0)
 
-/*
- * various member access, note that bio_data should of course not be used
- * on highmem page vectors
- */
-#define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
-
-#define bvec_iter_page(bvec, iter)				\
-	(__bvec_iter_bvec((bvec), (iter))->bv_page)
-
-#define bvec_iter_len(bvec, iter)				\
-	min((iter).bi_size,					\
-	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
-
-#define bvec_iter_offset(bvec, iter)				\
-	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
-
-#define bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
-})
-
 #define bio_iter_iovec(bio, iter)				\
 	bvec_iter_bvec((bio)->bi_io_vec, (iter))
 
@@ -193,33 +171,6 @@ static inline void *bio_data(struct bio *bio)
 #define bio_for_each_segment_all(bvl, bio, i)				\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
 
-static inline void bvec_iter_advance(struct bio_vec *bv, struct bvec_iter *iter,
-				     unsigned bytes)
-{
-	WARN_ONCE(bytes > iter->bi_size,
-		  "Attempted to advance past end of bvec iter\n");
-
-	while (bytes) {
-		unsigned len = min(bytes, bvec_iter_len(bv, *iter));
-
-		bytes -= len;
-		iter->bi_size -= len;
-		iter->bi_bvec_done += len;
-
-		if (iter->bi_bvec_done == __bvec_iter_bvec(bv, *iter)->bv_len) {
-			iter->bi_bvec_done = 0;
-			iter->bi_idx++;
-		}
-	}
-}
-
-#define for_each_bvec(bvl, bio_vec, iter, start)			\
-	for (iter = (start);						\
-	     (iter).bi_size &&						\
-		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
-	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
-
-
 static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 				    unsigned bytes)
 {
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
new file mode 100644
index 0000000..29c459d
--- /dev/null
+++ b/include/linux/bvec.h
@@ -0,0 +1,74 @@
+/*
+ * bvec iterator
+ *
+ * Copyright (C) 2001 Ming Lei <ming.lei@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public Licens
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
+ */
+#ifndef __LINUX_BVEC_ITER_H
+#define __LINUX_BVEC_ITER_H
+
+#include <linux/blk_types.h>
+
+/*
+ * various member access, note that bio_data should of course not be used
+ * on highmem page vectors
+ */
+#define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
+
+#define bvec_iter_page(bvec, iter)				\
+	(__bvec_iter_bvec((bvec), (iter))->bv_page)
+
+#define bvec_iter_len(bvec, iter)				\
+	min((iter).bi_size,					\
+	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
+
+#define bvec_iter_offset(bvec, iter)				\
+	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
+
+#define bvec_iter_bvec(bvec, iter)				\
+((struct bio_vec) {						\
+	.bv_page	= bvec_iter_page((bvec), (iter)),	\
+	.bv_len		= bvec_iter_len((bvec), (iter)),	\
+	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
+})
+
+static inline void bvec_iter_advance(struct bio_vec *bv, struct bvec_iter *iter,
+				     unsigned bytes)
+{
+	WARN_ONCE(bytes > iter->bi_size,
+		  "Attempted to advance past end of bvec iter\n");
+
+	while (bytes) {
+		unsigned len = min(bytes, bvec_iter_len(bv, *iter));
+
+		bytes -= len;
+		iter->bi_size -= len;
+		iter->bi_bvec_done += len;
+
+		if (iter->bi_bvec_done == __bvec_iter_bvec(bv, *iter)->bv_len) {
+			iter->bi_bvec_done = 0;
+			iter->bi_idx++;
+		}
+	}
+}
+
+#define for_each_bvec(bvl, bio_vec, iter, start)			\
+	for (iter = (start);						\
+	     (iter).bi_size &&						\
+		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
+	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
+
+#endif /* __LINUX_BVEC_ITER_H */
-- 
1.9.1


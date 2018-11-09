Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V8 01/18] block: introduce multi-page page bvec helpers
Date: Sat, 10 Nov 2018 00:25:53 +0800
Message-Id: <20181109162610.18981-2-ming.lei@redhat.com>
In-Reply-To: <20181109162610.18981-1-ming.lei@redhat.com>
References: <20181109162610.18981-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This patch introduces helpers of 'mp_bvec_iter_*' for multipage
bvec support.

The introduced helpers treate one bvec as real multi-page segment,
which may include more than one pages.

The existed helpers of bvec_iter_* are interfaces for supporting current
bvec iterator which is thought as single-page by drivers, fs, dm and
etc. These introduced helpers will build single-page bvec in flight, so
this way won't break current bio/bvec users, which needn't any change.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 63 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 02c73c6aa805..8ef904a50577 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -23,6 +23,44 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
+#include <linux/mm.h>
+
+/*
+ * What is multi-page bvecs?
+ *
+ * - bvecs stored in bio->bi_io_vec is always multi-page(mp) style
+ *
+ * - bvec(struct bio_vec) represents one physically contiguous I/O
+ *   buffer, now the buffer may include more than one pages after
+ *   multi-page(mp) bvec is supported, and all these pages represented
+ *   by one bvec is physically contiguous. Before mp support, at most
+ *   one page is included in one bvec, we call it single-page(sp)
+ *   bvec.
+ *
+ * - .bv_page of the bvec represents the 1st page in the mp bvec
+ *
+ * - .bv_offset of the bvec represents offset of the buffer in the bvec
+ *
+ * The effect on the current drivers/filesystem/dm/bcache/...:
+ *
+ * - almost everyone supposes that one bvec only includes one single
+ *   page, so we keep the sp interface not changed, for example,
+ *   bio_for_each_segment() still returns bvec with single page
+ *
+ * - bio_for_each_segment*() will be changed to return single-page
+ *   bvec too
+ *
+ * - during iterating, iterator variable(struct bvec_iter) is always
+ *   updated in multipage bvec style and that means bvec_iter_advance()
+ *   is kept not changed
+ *
+ * - returned(copied) single-page bvec is built in flight by bvec
+ *   helpers from the stored multipage bvec
+ *
+ * - In case that some components(such as iov_iter) need to support
+ *   multi-page bvec, we introduce new helpers(mp_bvec_iter_*) for
+ *   them.
+ */
 
 /*
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
@@ -50,16 +88,35 @@ struct bvec_iter {
  */
 #define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
 
-#define bvec_iter_page(bvec, iter)				\
+#define mp_bvec_iter_page(bvec, iter)				\
 	(__bvec_iter_bvec((bvec), (iter))->bv_page)
 
-#define bvec_iter_len(bvec, iter)				\
+#define mp_bvec_iter_len(bvec, iter)				\
 	min((iter).bi_size,					\
 	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
 
-#define bvec_iter_offset(bvec, iter)				\
+#define mp_bvec_iter_offset(bvec, iter)				\
 	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
 
+#define mp_bvec_iter_page_idx(bvec, iter)			\
+	(mp_bvec_iter_offset((bvec), (iter)) / PAGE_SIZE)
+
+/*
+ * <page, offset,length> of single-page(sp) segment.
+ *
+ * This helpers are for building sp bvec in flight.
+ */
+#define bvec_iter_offset(bvec, iter)					\
+	(mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
+
+#define bvec_iter_len(bvec, iter)					\
+	min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),		\
+	    (PAGE_SIZE - (bvec_iter_offset((bvec), (iter)))))
+
+#define bvec_iter_page(bvec, iter)					\
+	nth_page(mp_bvec_iter_page((bvec), (iter)),		\
+		 mp_bvec_iter_page_idx((bvec), (iter)))
+
 #define bvec_iter_bvec(bvec, iter)				\
 ((struct bio_vec) {						\
 	.bv_page	= bvec_iter_page((bvec), (iter)),	\
-- 
2.9.5

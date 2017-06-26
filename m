Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752651AbdFZMQK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:16:10 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 20/51] block: introduce multipage/single page bvec helpers
Date: Mon, 26 Jun 2017 20:10:03 +0800
Message-Id: <20170626121034.3051-21-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch introduces helpers which are suffixed with _mp
and _sp for the multipage bvec/segment support.

The helpers with _mp suffix are the interfaces for treating
one bvec/segment as real multipage one, for example, .bv_len
is the total length of the multipage segment.

The helpers with _sp suffix are interfaces for supporting
current bvec iterator which is thought as singlepage only
by drivers, fs, dm and etc. These _sp helpers are introduced
to build singlepage bvec in flight, so users of bio/bvec
iterator still can work well and needn't change even though
we store multipage into bvec.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 162ca7caf510..f52587e283d4 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -24,6 +24,42 @@
 #include <linux/bug.h>
 
 /*
+ * What is multipage bvecs(segment)?
+ *
+ * - bvec stored in bio->bi_io_vec is always multipage style vector
+ *
+ * - bvec(struct bio_vec) represents one physically contiguous I/O
+ *   buffer, now the buffer may include more than one pages since
+ *   multipage(mp) bvec is supported, and all these pages represented
+ *   by one bvec is physically contiguous. Before mp support, at most
+ *   one page can be included in one bvec, we call it singlepage(sp)
+ *   bvec.
+ *
+ * - .bv_page of th bvec represents the 1st page in the mp segment
+ *
+ * - .bv_offset of the bvec represents offset of the buffer in the bvec
+ *
+ * The effect on the current drivers/filesystem/dm/bcache/...:
+ *
+ * - almost everyone supposes that one bvec only includes one single
+ *   page, so we keep the sp interface not changed, for example,
+ *   bio_for_each_segment() still returns bvec with single page
+ *
+ * - bio_for_each_segment_all() will be changed to return singlepage
+ *   bvec too
+ *
+ * - during iterating, iterator variable(struct bvec_iter) is always
+ *   updated in multipage bvec style and that means bvec_iter_advance()
+ *   is kept not changed
+ *
+ * - returned(copied) singlepage bvec is generated in flight by bvec
+ *   helpers from the stored mp bvec
+ *
+ * - In case that some components(such as iov_iter) need to support mp
+ *   segment, we introduce new helpers(suffixed with _mp) for them.
+ */
+
+/*
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
  */
 struct bio_vec {
@@ -49,16 +85,30 @@ struct bvec_iter {
  */
 #define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
 
-#define bvec_iter_page(bvec, iter)				\
+#define bvec_iter_page_mp(bvec, iter)				\
 	(__bvec_iter_bvec((bvec), (iter))->bv_page)
 
-#define bvec_iter_len(bvec, iter)				\
+#define bvec_iter_len_mp(bvec, iter)				\
 	min((iter).bi_size,					\
 	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
 
-#define bvec_iter_offset(bvec, iter)				\
+#define bvec_iter_offset_mp(bvec, iter)				\
 	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
 
+/*
+ * <page, offset,length> of singlepage(sp) segment.
+ *
+ * This helpers will be implemented for building sp bvec in flight.
+ */
+#define bvec_iter_offset_sp(bvec, iter)	bvec_iter_offset_mp((bvec), (iter))
+#define bvec_iter_len_sp(bvec, iter)	bvec_iter_len_mp((bvec), (iter))
+#define bvec_iter_page_sp(bvec, iter)	bvec_iter_page_mp((bvec), (iter))
+
+/* current interfaces support sp style at default */
+#define bvec_iter_page(bvec, iter)	bvec_iter_page_sp((bvec), (iter))
+#define bvec_iter_len(bvec, iter)	bvec_iter_len_sp((bvec), (iter))
+#define bvec_iter_offset(bvec, iter)	bvec_iter_offset_sp((bvec), (iter))
+
 #define bvec_iter_bvec(bvec, iter)				\
 ((struct bio_vec) {						\
 	.bv_page	= bvec_iter_page((bvec), (iter)),	\
-- 
2.9.4

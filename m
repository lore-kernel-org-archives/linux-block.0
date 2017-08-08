Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 19/49] block: implement sp version of bvec iterator helpers
Date: Tue,  8 Aug 2017 16:45:18 +0800
Message-Id: <20170808084548.18963-20-ming.lei@redhat.com>
In-Reply-To: <20170808084548.18963-1-ming.lei@redhat.com>
References: <20170808084548.18963-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

This patch implements singlepage version of the following
3 helpers:
	- bvec_iter_offset_sp()
	- bvec_iter_len_sp()
	- bvec_iter_page_sp()

So that one multipage bvec can be splited to singlepage
bvec, and make users of current bvec iterator happy.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 1eaf7ca5cab3..d5f999a493de 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
+#include <linux/mm.h>
 
 /*
  * What is multipage bvecs(segment)?
@@ -98,14 +99,25 @@ struct bvec_iter {
 #define bvec_iter_offset_mp(bvec, iter)				\
 	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
 
+#define bvec_iter_page_idx_mp(bvec, iter)			\
+	(bvec_iter_offset_mp((bvec), (iter)) / PAGE_SIZE)
+
+
 /*
  * <page, offset,length> of singlepage(sp) segment.
  *
  * This helpers will be implemented for building sp bvec in flight.
  */
-#define bvec_iter_offset_sp(bvec, iter)	bvec_iter_offset_mp((bvec), (iter))
-#define bvec_iter_len_sp(bvec, iter)	bvec_iter_len_mp((bvec), (iter))
-#define bvec_iter_page_sp(bvec, iter)	bvec_iter_page_mp((bvec), (iter))
+#define bvec_iter_offset_sp(bvec, iter)					\
+	(bvec_iter_offset_mp((bvec), (iter)) % PAGE_SIZE)
+
+#define bvec_iter_len_sp(bvec, iter)					\
+	min_t(unsigned, bvec_iter_len_mp((bvec), (iter)),		\
+	    (PAGE_SIZE - (bvec_iter_offset_sp((bvec), (iter)))))
+
+#define bvec_iter_page_sp(bvec, iter)					\
+	nth_page(bvec_iter_page_mp((bvec), (iter)),			\
+		 bvec_iter_page_idx_mp((bvec), (iter)))
 
 /* current interfaces support sp style at default */
 #define bvec_iter_page(bvec, iter)	bvec_iter_page_sp((bvec), (iter))
-- 
2.9.4

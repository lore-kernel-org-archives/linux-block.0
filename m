Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35399 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933171AbcL0QIP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:08:15 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v1 15/54] block: implement sp version of bvec iterator helpers
Date: Tue, 27 Dec 2016 23:56:04 +0800
Message-Id: <1482854250-13481-16-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch implements singlepage version of the following
3 helpers:
	- bvec_iter_offset_sp()
	- bvec_iter_len_sp()
	- bvec_iter_page_sp()

So that one multipage bvec can be splited to singlepage
bvec, and make users of current bvec iterator happy.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bvec.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 307a387eb29c..d77c3cabce8c 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -22,6 +22,7 @@
 
 #include <linux/kernel.h>
 #include <linux/bug.h>
+#include <linux/mm.h>
 
 /*
  * What is multipage bvecs(segment)?
@@ -95,14 +96,25 @@ struct bvec_iter {
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
2.7.4


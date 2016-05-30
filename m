Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33098 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161219AbcE3Ngf (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 30 May 2016 09:36:35 -0400
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@canonical.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v6 4/8] iov_iter: use bvec iterator to implement iterate_bvec()
Date: Mon, 30 May 2016 21:34:32 +0800
Message-Id: <1464615294-9946-5-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bvec has one native/mature iterator for long time, so not
necessary to use the reinvented wheel for iterating bvecs
in lib/iov_iter.c.

Two ITER_BVEC test cases are run:
	- xfstest(-g auto) on loop dio/aio, no regression found
	- swap file works well under extreme stress(stress-ng --all 64 -t
	  800 -v), and lots of OOMs are triggerd, and the whole
	system still survives

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 lib/iov_iter.c | 45 +++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0cd5227..d67c828 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -56,37 +56,24 @@
 	n = wanted;					\
 }
 
-#define iterate_bvec(i, n, __v, __p, skip, STEP) {	\
-	size_t wanted = n;				\
-	__p = i->bvec;					\
-	__v.bv_len = min_t(size_t, n, __p->bv_len - skip);	\
-	if (likely(__v.bv_len)) {			\
-		__v.bv_page = __p->bv_page;		\
-		__v.bv_offset = __p->bv_offset + skip; 	\
-		(void)(STEP);				\
-		skip += __v.bv_len;			\
-		n -= __v.bv_len;			\
-	}						\
-	while (unlikely(n)) {				\
-		__p++;					\
-		__v.bv_len = min_t(size_t, n, __p->bv_len);	\
-		if (unlikely(!__v.bv_len))		\
+#define iterate_bvec(i, n, __v, __bi, skip, STEP) {	\
+	struct bvec_iter __start;			\
+	__start.bi_size = n;				\
+	__start.bi_bvec_done = skip;			\
+	__start.bi_idx = 0;				\
+	for_each_bvec(__v, i->bvec, __bi, __start) {	\
+		if (!__v.bv_len)			\
 			continue;			\
-		__v.bv_page = __p->bv_page;		\
-		__v.bv_offset = __p->bv_offset;		\
 		(void)(STEP);				\
-		skip = __v.bv_len;			\
-		n -= __v.bv_len;			\
 	}						\
-	n = wanted;					\
 }
 
 #define iterate_all_kinds(i, n, v, I, B, K) {			\
 	size_t skip = i->iov_offset;				\
 	if (unlikely(i->type & ITER_BVEC)) {			\
-		const struct bio_vec *bvec;			\
 		struct bio_vec v;				\
-		iterate_bvec(i, n, v, bvec, skip, (B))		\
+		struct bvec_iter __bi;				\
+		iterate_bvec(i, n, v, __bi, skip, (B))		\
 	} else if (unlikely(i->type & ITER_KVEC)) {		\
 		const struct kvec *kvec;			\
 		struct kvec v;					\
@@ -104,15 +91,13 @@
 	if (i->count) {						\
 		size_t skip = i->iov_offset;			\
 		if (unlikely(i->type & ITER_BVEC)) {		\
-			const struct bio_vec *bvec;		\
+			const struct bio_vec *bvec = i->bvec;	\
 			struct bio_vec v;			\
-			iterate_bvec(i, n, v, bvec, skip, (B))	\
-			if (skip == bvec->bv_len) {		\
-				bvec++;				\
-				skip = 0;			\
-			}					\
-			i->nr_segs -= bvec - i->bvec;		\
-			i->bvec = bvec;				\
+			struct bvec_iter __bi;			\
+			iterate_bvec(i, n, v, __bi, skip, (B))	\
+			i->bvec = __bvec_iter_bvec(i->bvec, __bi);	\
+			i->nr_segs -= i->bvec - bvec;		\
+			skip = __bi.bi_bvec_done;		\
 		} else if (unlikely(i->type & ITER_KVEC)) {	\
 			const struct kvec *kvec;		\
 			struct kvec v;				\
-- 
1.9.1


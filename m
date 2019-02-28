Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE96C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 03:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C532183F
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 03:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfB1DYd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 22:24:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbfB1DYd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 22:24:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5037B30027BB;
        Thu, 28 Feb 2019 03:24:33 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FE0460C80;
        Thu, 28 Feb 2019 03:24:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: advance by bvec's length for bio_for_each_bvec
Date:   Thu, 28 Feb 2019 11:24:21 +0800
Message-Id: <20190228032421.23161-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 28 Feb 2019 03:24:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_for_each_bvec is used in fast path of bio splitting and sg mapping,
and what we want to do is to iterate over multi-page bvecs, instead of pages.
However, bvec_iter_advance() is invisble for this requirement, and
always advance by page size.

This way isn't efficient for multipage bvec iterator, also bvec_iter_len()
isn't as fast as mp_bvec_iter_len().

So advance by multi-page bvec's length instead of page size for bio_for_each_bvec().

More than 1% IOPS improvement can be observed in io_uring test on null_blk.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h  | 13 +++++++++----
 include/linux/bvec.h | 13 ++++++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index bb6090aa165d..29c7dd348dc2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -134,17 +134,22 @@ static inline bool bio_full(struct bio *bio)
 	for (i = 0, iter_all.idx = 0; iter_all.idx < (bio)->bi_vcnt; iter_all.idx++)	\
 		mp_bvec_for_each_segment(bvl, &((bio)->bi_io_vec[iter_all.idx]), i, iter_all)
 
-static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
-				    unsigned bytes)
+static inline void __bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
+				      unsigned bytes, bool bvec)
 {
 	iter->bi_sector += bytes >> 9;
 
 	if (bio_no_advance_iter(bio))
 		iter->bi_size -= bytes;
 	else
-		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
+		__bvec_iter_advance(bio->bi_io_vec, iter, bytes, bvec);
 		/* TODO: It is reasonable to complete bio with error here. */
 }
+static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
+				    unsigned bytes)
+{
+	return __bio_advance_iter(bio, iter, bytes, false);
+}
 
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
 	for (iter = (start);						\
@@ -159,7 +164,7 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
 		((bvl = mp_bvec_iter_bvec((bio)->bi_io_vec, (iter))), 1); \
-	     bio_advance_iter((bio), &(iter), (bvl).bv_len))
+	     __bio_advance_iter((bio), &(iter), (bvl).bv_len, true))
 
 /* iterate over multi-page bvec */
 #define bio_for_each_bvec(bvl, bio, iter)			\
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 2c32e3e151a0..98a140fa4dac 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -102,8 +102,8 @@ static inline struct page *bvec_nth_page(struct page *page, int idx)
 	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
 })
 
-static inline bool bvec_iter_advance(const struct bio_vec *bv,
-		struct bvec_iter *iter, unsigned bytes)
+static inline bool __bvec_iter_advance(const struct bio_vec *bv,
+		struct bvec_iter *iter, unsigned bytes, bool bvec)
 {
 	if (WARN_ONCE(bytes > iter->bi_size,
 		     "Attempted to advance past end of bvec iter\n")) {
@@ -112,7 +112,8 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	}
 
 	while (bytes) {
-		unsigned iter_len = bvec_iter_len(bv, *iter);
+		unsigned iter_len = bvec ? mp_bvec_iter_len(bv, *iter) :
+			bvec_iter_len(bv, *iter);
 		unsigned len = min(bytes, iter_len);
 
 		bytes -= len;
@@ -127,6 +128,12 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	return true;
 }
 
+static inline bool bvec_iter_advance(const struct bio_vec *bv,
+		struct bvec_iter *iter, unsigned bytes)
+{
+	return __bvec_iter_advance(bv, iter, bytes, false);
+}
+
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
-- 
2.9.5


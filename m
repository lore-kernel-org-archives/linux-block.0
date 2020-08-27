Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEABCC433E1
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 15:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D97F22B40
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 15:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sRE3h/ZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgH0Phz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0Phz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 11:37:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076BFC061264
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2020 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kUX7COLuyupJMmRBkcHZr/++k6y26DL5WnQBM9DrPwM=; b=sRE3h/ZQT6UfchCi5zFAhwNj0z
        GxLGG7Up39KTlvcypz5ZhT2izD1n+vxwcwRYT1ajofxXss/f/JeInyA1x2sW2oVDihwNiIEcqiKca
        IDshGLeLqLplNvLKjCTxdS78Q/zEJZ8f2Ti43nh779k+ief6XE5we6FymLeu9mx6vGgguJ9GT4Mkg
        cq3g9/dSJeGYULV0Cm90H4kXhxA/61S6XRB4iDOluEE6fY7kMUlWVKnCdvCGyAz9zUZnRhGJcXEmF
        4Ax1D/ORDGSjx7z+ucUJ/sm6xvRaKvxcCSrt1GzB4O2C/R8gtGKIBczjFg+6HNlOIOkngydjb/m1c
        q3PjE90A==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJyL-0006xk-6i; Thu, 27 Aug 2020 15:37:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: remove __blk_rq_map_user_iov
Date:   Thu, 27 Aug 2020 17:37:47 +0200
Message-Id: <20200827153748.378424-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827153748.378424-1-hch@lst.de>
References: <20200827153748.378424-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just duplicate a small amount of code in the low-level map into the bio
and copy to the bio routines, leading to much easier to follow and
maintain code, and better shared error handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c | 144 ++++++++++++++++++------------------------------
 1 file changed, 54 insertions(+), 90 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 10de4809edf9a7..427962ac2f675f 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -127,24 +127,12 @@ static int bio_uncopy_user(struct bio *bio)
 	return ret;
 }
 
-/**
- *	bio_copy_user_iov	-	copy user data to bio
- *	@q:		destination block queue
- *	@map_data:	pointer to the rq_map_data holding pages (if necessary)
- *	@iter:		iovec iterator
- *	@gfp_mask:	memory allocation flags
- *
- *	Prepares and returns a bio for indirect user io, bouncing data
- *	to/from kernel pages as necessary. Must be paired with
- *	call bio_uncopy_user() on io completion.
- */
-static struct bio *bio_copy_user_iov(struct request_queue *q,
-		struct rq_map_data *map_data, struct iov_iter *iter,
-		gfp_t gfp_mask)
+static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
+		struct iov_iter *iter, gfp_t gfp_mask)
 {
 	struct bio_map_data *bmd;
 	struct page *page;
-	struct bio *bio;
+	struct bio *bio, *bounce_bio;
 	int i = 0, ret;
 	int nr_pages;
 	unsigned int len = iter->count;
@@ -152,7 +140,7 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 
 	bmd = bio_alloc_map_data(iter, gfp_mask);
 	if (!bmd)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	/*
 	 * We need to do a deep copy of the iov_iter including the iovecs.
@@ -169,8 +157,7 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 	bio = bio_kmalloc(gfp_mask, nr_pages);
 	if (!bio)
 		goto out_bmd;
-
-	ret = 0;
+	bio->bi_opf |= req_op(rq);
 
 	if (map_data) {
 		nr_pages = 1 << map_data->page_order;
@@ -187,7 +174,7 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 		if (map_data) {
 			if (i == map_data->nr_entries * nr_pages) {
 				ret = -ENOMEM;
-				break;
+				goto cleanup;
 			}
 
 			page = map_data->pages[i / nr_pages];
@@ -195,14 +182,14 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 
 			i++;
 		} else {
-			page = alloc_page(q->bounce_gfp | gfp_mask);
+			page = alloc_page(rq->q->bounce_gfp | gfp_mask);
 			if (!page) {
 				ret = -ENOMEM;
-				break;
+				goto cleanup;
 			}
 		}
 
-		if (bio_add_pc_page(q, bio, page, bytes, offset) < bytes) {
+		if (bio_add_pc_page(rq->q, bio, page, bytes, offset) < bytes) {
 			if (!map_data)
 				__free_page(page);
 			break;
@@ -212,9 +199,6 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 		offset = 0;
 	}
 
-	if (ret)
-		goto cleanup;
-
 	if (map_data)
 		map_data->offset += bio->bi_iter.bi_size;
 
@@ -236,39 +220,42 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 	bio->bi_private = bmd;
 	if (map_data && map_data->null_mapped)
 		bmd->is_null_mapped = true;
-	return bio;
+
+	bounce_bio = bio;
+	ret = blk_rq_append_bio(rq, &bounce_bio);
+	if (ret)
+		goto cleanup;
+
+	/*
+	 * We link the bounce buffer in and could have to traverse it later, so
+	 * we have to get a ref to prevent it from being freed
+	 */
+	bio_get(bounce_bio);
+	return 0;
 cleanup:
 	if (!map_data)
 		bio_free_pages(bio);
 	bio_put(bio);
 out_bmd:
 	kfree(bmd);
-	return ERR_PTR(ret);
+	return ret;
 }
 
-/**
- *	bio_map_user_iov - map user iovec into bio
- *	@q:		the struct request_queue for the bio
- *	@iter:		iovec iterator
- *	@gfp_mask:	memory allocation flags
- *
- *	Map the user space address into a bio suitable for io to a block
- *	device. Returns an error pointer in case of error.
- */
-static struct bio *bio_map_user_iov(struct request_queue *q,
-		struct iov_iter *iter, gfp_t gfp_mask)
+static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
+		gfp_t gfp_mask)
 {
-	unsigned int max_sectors = queue_max_hw_sectors(q);
-	int j;
-	struct bio *bio;
+	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
+	struct bio *bio, *bounce_bio;
 	int ret;
+	int j;
 
 	if (!iov_iter_count(iter))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	bio = bio_kmalloc(gfp_mask, iov_iter_npages(iter, BIO_MAX_PAGES));
 	if (!bio)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
+	bio->bi_opf |= req_op(rq);
 
 	while (iov_iter_count(iter)) {
 		struct page **pages;
@@ -284,7 +271,7 @@ static struct bio *bio_map_user_iov(struct request_queue *q,
 
 		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
 
-		if (unlikely(offs & queue_dma_alignment(q))) {
+		if (unlikely(offs & queue_dma_alignment(rq->q))) {
 			ret = -EINVAL;
 			j = 0;
 		} else {
@@ -296,7 +283,7 @@ static struct bio *bio_map_user_iov(struct request_queue *q,
 				if (n > bytes)
 					n = bytes;
 
-				if (!bio_add_hw_page(q, bio, page, n, offs,
+				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
 						     max_sectors, &same_page)) {
 					if (same_page)
 						put_page(page);
@@ -323,18 +310,30 @@ static struct bio *bio_map_user_iov(struct request_queue *q,
 	bio_set_flag(bio, BIO_USER_MAPPED);
 
 	/*
-	 * subtle -- if bio_map_user_iov() ended up bouncing a bio,
-	 * it would normally disappear when its bi_end_io is run.
-	 * however, we need it for the unmap, so grab an extra
-	 * reference to it
+	 * Subtle: if we end up needing to bounce a bio, it would normally
+	 * disappear when its bi_end_io is run.  However, we need the original
+	 * bio for the unmap, so grab an extra reference to it
 	 */
 	bio_get(bio);
-	return bio;
 
+	bounce_bio = bio;
+	ret = blk_rq_append_bio(rq, &bounce_bio);
+	if (ret)
+		goto out_put_orig;
+
+	/*
+	 * We link the bounce buffer in and could have to traverse it
+	 * later, so we have to get a ref to prevent it from being freed
+	 */
+	bio_get(bounce_bio);
+	return 0;
+
+ out_put_orig:
+	bio_put(bio);
  out_unmap:
 	bio_release_pages(bio, false);
 	bio_put(bio);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 /**
@@ -558,44 +557,6 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
 }
 EXPORT_SYMBOL(blk_rq_append_bio);
 
-static int __blk_rq_map_user_iov(struct request *rq,
-		struct rq_map_data *map_data, struct iov_iter *iter,
-		gfp_t gfp_mask, bool copy)
-{
-	struct request_queue *q = rq->q;
-	struct bio *bio, *orig_bio;
-	int ret;
-
-	if (copy)
-		bio = bio_copy_user_iov(q, map_data, iter, gfp_mask);
-	else
-		bio = bio_map_user_iov(q, iter, gfp_mask);
-
-	if (IS_ERR(bio))
-		return PTR_ERR(bio);
-
-	bio->bi_opf &= ~REQ_OP_MASK;
-	bio->bi_opf |= req_op(rq);
-
-	orig_bio = bio;
-
-	/*
-	 * We link the bounce buffer in and could have to traverse it
-	 * later so we have to get a ref to prevent it from being freed
-	 */
-	ret = blk_rq_append_bio(rq, &bio);
-	if (ret) {
-		if (copy)
-			bio_uncopy_user(orig_bio);
-		else
-			bio_unmap_user(orig_bio);
-		return ret;
-	}
-	bio_get(bio);
-
-	return 0;
-}
-
 /**
  * blk_rq_map_user_iov - map user data to a request, for passthrough requests
  * @q:		request queue where request should be inserted
@@ -639,7 +600,10 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 
 	i = *iter;
 	do {
-		ret =__blk_rq_map_user_iov(rq, map_data, &i, gfp_mask, copy);
+		if (copy)
+			ret = bio_copy_user_iov(rq, map_data, &i, gfp_mask);
+		else
+			ret = bio_map_user_iov(rq, &i, gfp_mask);
 		if (ret)
 			goto unmap_rq;
 		if (!bio)
-- 
2.28.0


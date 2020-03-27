Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7093C2D0E5
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 17:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846212071B
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 17:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hz8eb2Op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0Ruv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:50:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Ruu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 13:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=clL5bEPAe20DRzk5iVaZirPWccejmdVCVII/0ewkv9c=; b=hz8eb2OpdmlBPFQAVAYZPHW/68
        B3WkP7+z/010Zam3yBl1qb74oSih5/HgocCNZW+2EKS55IxzJSDXZbRw9y+9y4kL+k40rMZN11mpN
        EgaqpzVcZOgOC1BdeGns0D+nhzEXsGf0cAnBufJg7OcOLwcgR53xfk346ERs6tUYqubzkT7C37msS
        3Q54P94RYxr71pqelSs7kjVl3sSqI4F188+6xLaAQz0Wwncm41gwveDu2zHUYT6G0Tqb0lk6DDyZf
        g8NeH6TzQlUGe3BXHzBwSduvrazB0xxWvWydFe1M3XUCLvwqObDtMfuv/TDtKqEeFxUMdZvbwbRj/
        HMC96dWQ==;
Received: from 213-225-10-87.nat.highway.a1.net ([213.225.10.87] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHt85-0001yQ-Hh; Fri, 27 Mar 2020 17:50:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: move bio_map_* to blk-map.c
Date:   Fri, 27 Mar 2020 18:48:37 +0100
Message-Id: <20200327174837.1648620-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bio_map_* helpers are just the low-level helpers for the
blk_rq_map_* APIs.  Move them together for better logical grouping,
as no there isn't much overlap with other code in bio.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 510 +-------------------------------------------
 block/blk-map.c     | 508 +++++++++++++++++++++++++++++++++++++++++++
 block/blk.h         |   4 +
 include/linux/bio.h |  14 --
 4 files changed, 513 insertions(+), 523 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 11e6aac35092..21cbaa6a1c20 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -780,7 +780,7 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
  *
  *	This should only be used by passthrough bios.
  */
-static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		bool *same_page)
 {
@@ -1194,90 +1194,6 @@ void bio_list_copy_data(struct bio *dst, struct bio *src)
 }
 EXPORT_SYMBOL(bio_list_copy_data);
 
-struct bio_map_data {
-	int is_our_pages;
-	struct iov_iter iter;
-	struct iovec iov[];
-};
-
-static struct bio_map_data *bio_alloc_map_data(struct iov_iter *data,
-					       gfp_t gfp_mask)
-{
-	struct bio_map_data *bmd;
-	if (data->nr_segs > UIO_MAXIOV)
-		return NULL;
-
-	bmd = kmalloc(struct_size(bmd, iov, data->nr_segs), gfp_mask);
-	if (!bmd)
-		return NULL;
-	memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);
-	bmd->iter = *data;
-	bmd->iter.iov = bmd->iov;
-	return bmd;
-}
-
-/**
- * bio_copy_from_iter - copy all pages from iov_iter to bio
- * @bio: The &struct bio which describes the I/O as destination
- * @iter: iov_iter as source
- *
- * Copy all pages from iov_iter to bio.
- * Returns 0 on success, or error on failure.
- */
-static int bio_copy_from_iter(struct bio *bio, struct iov_iter *iter)
-{
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		ssize_t ret;
-
-		ret = copy_page_from_iter(bvec->bv_page,
-					  bvec->bv_offset,
-					  bvec->bv_len,
-					  iter);
-
-		if (!iov_iter_count(iter))
-			break;
-
-		if (ret < bvec->bv_len)
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-/**
- * bio_copy_to_iter - copy all pages from bio to iov_iter
- * @bio: The &struct bio which describes the I/O as source
- * @iter: iov_iter as destination
- *
- * Copy all pages from bio to iov_iter.
- * Returns 0 on success, or error on failure.
- */
-static int bio_copy_to_iter(struct bio *bio, struct iov_iter iter)
-{
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		ssize_t ret;
-
-		ret = copy_page_to_iter(bvec->bv_page,
-					bvec->bv_offset,
-					bvec->bv_len,
-					&iter);
-
-		if (!iov_iter_count(&iter))
-			break;
-
-		if (ret < bvec->bv_len)
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
 void bio_free_pages(struct bio *bio)
 {
 	struct bio_vec *bvec;
@@ -1288,430 +1204,6 @@ void bio_free_pages(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_free_pages);
 
-/**
- *	bio_uncopy_user	-	finish previously mapped bio
- *	@bio: bio being terminated
- *
- *	Free pages allocated from bio_copy_user_iov() and write back data
- *	to user space in case of a read.
- */
-int bio_uncopy_user(struct bio *bio)
-{
-	struct bio_map_data *bmd = bio->bi_private;
-	int ret = 0;
-
-	if (!bio_flagged(bio, BIO_NULL_MAPPED)) {
-		/*
-		 * if we're in a workqueue, the request is orphaned, so
-		 * don't copy into a random user address space, just free
-		 * and return -EINTR so user space doesn't expect any data.
-		 */
-		if (!current->mm)
-			ret = -EINTR;
-		else if (bio_data_dir(bio) == READ)
-			ret = bio_copy_to_iter(bio, bmd->iter);
-		if (bmd->is_our_pages)
-			bio_free_pages(bio);
-	}
-	kfree(bmd);
-	bio_put(bio);
-	return ret;
-}
-
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
-struct bio *bio_copy_user_iov(struct request_queue *q,
-			      struct rq_map_data *map_data,
-			      struct iov_iter *iter,
-			      gfp_t gfp_mask)
-{
-	struct bio_map_data *bmd;
-	struct page *page;
-	struct bio *bio;
-	int i = 0, ret;
-	int nr_pages;
-	unsigned int len = iter->count;
-	unsigned int offset = map_data ? offset_in_page(map_data->offset) : 0;
-
-	bmd = bio_alloc_map_data(iter, gfp_mask);
-	if (!bmd)
-		return ERR_PTR(-ENOMEM);
-
-	/*
-	 * We need to do a deep copy of the iov_iter including the iovecs.
-	 * The caller provided iov might point to an on-stack or otherwise
-	 * shortlived one.
-	 */
-	bmd->is_our_pages = map_data ? 0 : 1;
-
-	nr_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
-	if (nr_pages > BIO_MAX_PAGES)
-		nr_pages = BIO_MAX_PAGES;
-
-	ret = -ENOMEM;
-	bio = bio_kmalloc(gfp_mask, nr_pages);
-	if (!bio)
-		goto out_bmd;
-
-	ret = 0;
-
-	if (map_data) {
-		nr_pages = 1 << map_data->page_order;
-		i = map_data->offset / PAGE_SIZE;
-	}
-	while (len) {
-		unsigned int bytes = PAGE_SIZE;
-
-		bytes -= offset;
-
-		if (bytes > len)
-			bytes = len;
-
-		if (map_data) {
-			if (i == map_data->nr_entries * nr_pages) {
-				ret = -ENOMEM;
-				break;
-			}
-
-			page = map_data->pages[i / nr_pages];
-			page += (i % nr_pages);
-
-			i++;
-		} else {
-			page = alloc_page(q->bounce_gfp | gfp_mask);
-			if (!page) {
-				ret = -ENOMEM;
-				break;
-			}
-		}
-
-		if (bio_add_pc_page(q, bio, page, bytes, offset) < bytes) {
-			if (!map_data)
-				__free_page(page);
-			break;
-		}
-
-		len -= bytes;
-		offset = 0;
-	}
-
-	if (ret)
-		goto cleanup;
-
-	if (map_data)
-		map_data->offset += bio->bi_iter.bi_size;
-
-	/*
-	 * success
-	 */
-	if ((iov_iter_rw(iter) == WRITE && (!map_data || !map_data->null_mapped)) ||
-	    (map_data && map_data->from_user)) {
-		ret = bio_copy_from_iter(bio, iter);
-		if (ret)
-			goto cleanup;
-	} else {
-		if (bmd->is_our_pages)
-			zero_fill_bio(bio);
-		iov_iter_advance(iter, bio->bi_iter.bi_size);
-	}
-
-	bio->bi_private = bmd;
-	if (map_data && map_data->null_mapped)
-		bio_set_flag(bio, BIO_NULL_MAPPED);
-	return bio;
-cleanup:
-	if (!map_data)
-		bio_free_pages(bio);
-	bio_put(bio);
-out_bmd:
-	kfree(bmd);
-	return ERR_PTR(ret);
-}
-
-/**
- *	bio_map_user_iov - map user iovec into bio
- *	@q:		the struct request_queue for the bio
- *	@iter:		iovec iterator
- *	@gfp_mask:	memory allocation flags
- *
- *	Map the user space address into a bio suitable for io to a block
- *	device. Returns an error pointer in case of error.
- */
-struct bio *bio_map_user_iov(struct request_queue *q,
-			     struct iov_iter *iter,
-			     gfp_t gfp_mask)
-{
-	int j;
-	struct bio *bio;
-	int ret;
-
-	if (!iov_iter_count(iter))
-		return ERR_PTR(-EINVAL);
-
-	bio = bio_kmalloc(gfp_mask, iov_iter_npages(iter, BIO_MAX_PAGES));
-	if (!bio)
-		return ERR_PTR(-ENOMEM);
-
-	while (iov_iter_count(iter)) {
-		struct page **pages;
-		ssize_t bytes;
-		size_t offs, added = 0;
-		int npages;
-
-		bytes = iov_iter_get_pages_alloc(iter, &pages, LONG_MAX, &offs);
-		if (unlikely(bytes <= 0)) {
-			ret = bytes ? bytes : -EFAULT;
-			goto out_unmap;
-		}
-
-		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
-
-		if (unlikely(offs & queue_dma_alignment(q))) {
-			ret = -EINVAL;
-			j = 0;
-		} else {
-			for (j = 0; j < npages; j++) {
-				struct page *page = pages[j];
-				unsigned int n = PAGE_SIZE - offs;
-				bool same_page = false;
-
-				if (n > bytes)
-					n = bytes;
-
-				if (!__bio_add_pc_page(q, bio, page, n, offs,
-						&same_page)) {
-					if (same_page)
-						put_page(page);
-					break;
-				}
-
-				added += n;
-				bytes -= n;
-				offs = 0;
-			}
-			iov_iter_advance(iter, added);
-		}
-		/*
-		 * release the pages we didn't map into the bio, if any
-		 */
-		while (j < npages)
-			put_page(pages[j++]);
-		kvfree(pages);
-		/* couldn't stuff something into bio? */
-		if (bytes)
-			break;
-	}
-
-	bio_set_flag(bio, BIO_USER_MAPPED);
-
-	/*
-	 * subtle -- if bio_map_user_iov() ended up bouncing a bio,
-	 * it would normally disappear when its bi_end_io is run.
-	 * however, we need it for the unmap, so grab an extra
-	 * reference to it
-	 */
-	bio_get(bio);
-	return bio;
-
- out_unmap:
-	bio_release_pages(bio, false);
-	bio_put(bio);
-	return ERR_PTR(ret);
-}
-
-/**
- *	bio_unmap_user	-	unmap a bio
- *	@bio:		the bio being unmapped
- *
- *	Unmap a bio previously mapped by bio_map_user_iov(). Must be called from
- *	process context.
- *
- *	bio_unmap_user() may sleep.
- */
-void bio_unmap_user(struct bio *bio)
-{
-	bio_release_pages(bio, bio_data_dir(bio) == READ);
-	bio_put(bio);
-	bio_put(bio);
-}
-
-static void bio_invalidate_vmalloc_pages(struct bio *bio)
-{
-#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
-	if (bio->bi_private && !op_is_write(bio_op(bio))) {
-		unsigned long i, len = 0;
-
-		for (i = 0; i < bio->bi_vcnt; i++)
-			len += bio->bi_io_vec[i].bv_len;
-		invalidate_kernel_vmap_range(bio->bi_private, len);
-	}
-#endif
-}
-
-static void bio_map_kern_endio(struct bio *bio)
-{
-	bio_invalidate_vmalloc_pages(bio);
-	bio_put(bio);
-}
-
-/**
- *	bio_map_kern	-	map kernel address into bio
- *	@q: the struct request_queue for the bio
- *	@data: pointer to buffer to map
- *	@len: length in bytes
- *	@gfp_mask: allocation flags for bio allocation
- *
- *	Map the kernel address into a bio suitable for io to a block
- *	device. Returns an error pointer in case of error.
- */
-struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
-			 gfp_t gfp_mask)
-{
-	unsigned long kaddr = (unsigned long)data;
-	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	unsigned long start = kaddr >> PAGE_SHIFT;
-	const int nr_pages = end - start;
-	bool is_vmalloc = is_vmalloc_addr(data);
-	struct page *page;
-	int offset, i;
-	struct bio *bio;
-
-	bio = bio_kmalloc(gfp_mask, nr_pages);
-	if (!bio)
-		return ERR_PTR(-ENOMEM);
-
-	if (is_vmalloc) {
-		flush_kernel_vmap_range(data, len);
-		bio->bi_private = data;
-	}
-
-	offset = offset_in_page(kaddr);
-	for (i = 0; i < nr_pages; i++) {
-		unsigned int bytes = PAGE_SIZE - offset;
-
-		if (len <= 0)
-			break;
-
-		if (bytes > len)
-			bytes = len;
-
-		if (!is_vmalloc)
-			page = virt_to_page(data);
-		else
-			page = vmalloc_to_page(data);
-		if (bio_add_pc_page(q, bio, page, bytes,
-				    offset) < bytes) {
-			/* we don't support partial mappings */
-			bio_put(bio);
-			return ERR_PTR(-EINVAL);
-		}
-
-		data += bytes;
-		len -= bytes;
-		offset = 0;
-	}
-
-	bio->bi_end_io = bio_map_kern_endio;
-	return bio;
-}
-
-static void bio_copy_kern_endio(struct bio *bio)
-{
-	bio_free_pages(bio);
-	bio_put(bio);
-}
-
-static void bio_copy_kern_endio_read(struct bio *bio)
-{
-	char *p = bio->bi_private;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
-		p += bvec->bv_len;
-	}
-
-	bio_copy_kern_endio(bio);
-}
-
-/**
- *	bio_copy_kern	-	copy kernel address into bio
- *	@q: the struct request_queue for the bio
- *	@data: pointer to buffer to copy
- *	@len: length in bytes
- *	@gfp_mask: allocation flags for bio and page allocation
- *	@reading: data direction is READ
- *
- *	copy the kernel address into a bio suitable for io to a block
- *	device. Returns an error pointer in case of error.
- */
-struct bio *bio_copy_kern(struct request_queue *q, void *data, unsigned int len,
-			  gfp_t gfp_mask, int reading)
-{
-	unsigned long kaddr = (unsigned long)data;
-	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	unsigned long start = kaddr >> PAGE_SHIFT;
-	struct bio *bio;
-	void *p = data;
-	int nr_pages = 0;
-
-	/*
-	 * Overflow, abort
-	 */
-	if (end < start)
-		return ERR_PTR(-EINVAL);
-
-	nr_pages = end - start;
-	bio = bio_kmalloc(gfp_mask, nr_pages);
-	if (!bio)
-		return ERR_PTR(-ENOMEM);
-
-	while (len) {
-		struct page *page;
-		unsigned int bytes = PAGE_SIZE;
-
-		if (bytes > len)
-			bytes = len;
-
-		page = alloc_page(q->bounce_gfp | gfp_mask);
-		if (!page)
-			goto cleanup;
-
-		if (!reading)
-			memcpy(page_address(page), p, bytes);
-
-		if (bio_add_pc_page(q, bio, page, bytes, 0) < bytes)
-			break;
-
-		len -= bytes;
-		p += bytes;
-	}
-
-	if (reading) {
-		bio->bi_end_io = bio_copy_kern_endio_read;
-		bio->bi_private = data;
-	} else {
-		bio->bi_end_io = bio_copy_kern_endio;
-	}
-
-	return bio;
-
-cleanup:
-	bio_free_pages(bio);
-	bio_put(bio);
-	return ERR_PTR(-ENOMEM);
-}
-
 /*
  * bio_set_pages_dirty() and bio_check_pages_dirty() are support functions
  * for performing direct-IO in BIOs.
diff --git a/block/blk-map.c b/block/blk-map.c
index b0790268ed9d..b72c361911a4 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -11,6 +11,514 @@
 
 #include "blk.h"
 
+struct bio_map_data {
+	int is_our_pages;
+	struct iov_iter iter;
+	struct iovec iov[];
+};
+
+static struct bio_map_data *bio_alloc_map_data(struct iov_iter *data,
+					       gfp_t gfp_mask)
+{
+	struct bio_map_data *bmd;
+
+	if (data->nr_segs > UIO_MAXIOV)
+		return NULL;
+
+	bmd = kmalloc(struct_size(bmd, iov, data->nr_segs), gfp_mask);
+	if (!bmd)
+		return NULL;
+	memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);
+	bmd->iter = *data;
+	bmd->iter.iov = bmd->iov;
+	return bmd;
+}
+
+/**
+ * bio_copy_from_iter - copy all pages from iov_iter to bio
+ * @bio: The &struct bio which describes the I/O as destination
+ * @iter: iov_iter as source
+ *
+ * Copy all pages from iov_iter to bio.
+ * Returns 0 on success, or error on failure.
+ */
+static int bio_copy_from_iter(struct bio *bio, struct iov_iter *iter)
+{
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		ssize_t ret;
+
+		ret = copy_page_from_iter(bvec->bv_page,
+					  bvec->bv_offset,
+					  bvec->bv_len,
+					  iter);
+
+		if (!iov_iter_count(iter))
+			break;
+
+		if (ret < bvec->bv_len)
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+/**
+ * bio_copy_to_iter - copy all pages from bio to iov_iter
+ * @bio: The &struct bio which describes the I/O as source
+ * @iter: iov_iter as destination
+ *
+ * Copy all pages from bio to iov_iter.
+ * Returns 0 on success, or error on failure.
+ */
+static int bio_copy_to_iter(struct bio *bio, struct iov_iter iter)
+{
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		ssize_t ret;
+
+		ret = copy_page_to_iter(bvec->bv_page,
+					bvec->bv_offset,
+					bvec->bv_len,
+					&iter);
+
+		if (!iov_iter_count(&iter))
+			break;
+
+		if (ret < bvec->bv_len)
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+/**
+ *	bio_uncopy_user	-	finish previously mapped bio
+ *	@bio: bio being terminated
+ *
+ *	Free pages allocated from bio_copy_user_iov() and write back data
+ *	to user space in case of a read.
+ */
+static int bio_uncopy_user(struct bio *bio)
+{
+	struct bio_map_data *bmd = bio->bi_private;
+	int ret = 0;
+
+	if (!bio_flagged(bio, BIO_NULL_MAPPED)) {
+		/*
+		 * if we're in a workqueue, the request is orphaned, so
+		 * don't copy into a random user address space, just free
+		 * and return -EINTR so user space doesn't expect any data.
+		 */
+		if (!current->mm)
+			ret = -EINTR;
+		else if (bio_data_dir(bio) == READ)
+			ret = bio_copy_to_iter(bio, bmd->iter);
+		if (bmd->is_our_pages)
+			bio_free_pages(bio);
+	}
+	kfree(bmd);
+	bio_put(bio);
+	return ret;
+}
+
+/**
+ *	bio_copy_user_iov	-	copy user data to bio
+ *	@q:		destination block queue
+ *	@map_data:	pointer to the rq_map_data holding pages (if necessary)
+ *	@iter:		iovec iterator
+ *	@gfp_mask:	memory allocation flags
+ *
+ *	Prepares and returns a bio for indirect user io, bouncing data
+ *	to/from kernel pages as necessary. Must be paired with
+ *	call bio_uncopy_user() on io completion.
+ */
+static struct bio *bio_copy_user_iov(struct request_queue *q,
+		struct rq_map_data *map_data, struct iov_iter *iter,
+		gfp_t gfp_mask)
+{
+	struct bio_map_data *bmd;
+	struct page *page;
+	struct bio *bio;
+	int i = 0, ret;
+	int nr_pages;
+	unsigned int len = iter->count;
+	unsigned int offset = map_data ? offset_in_page(map_data->offset) : 0;
+
+	bmd = bio_alloc_map_data(iter, gfp_mask);
+	if (!bmd)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * We need to do a deep copy of the iov_iter including the iovecs.
+	 * The caller provided iov might point to an on-stack or otherwise
+	 * shortlived one.
+	 */
+	bmd->is_our_pages = map_data ? 0 : 1;
+
+	nr_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
+	if (nr_pages > BIO_MAX_PAGES)
+		nr_pages = BIO_MAX_PAGES;
+
+	ret = -ENOMEM;
+	bio = bio_kmalloc(gfp_mask, nr_pages);
+	if (!bio)
+		goto out_bmd;
+
+	ret = 0;
+
+	if (map_data) {
+		nr_pages = 1 << map_data->page_order;
+		i = map_data->offset / PAGE_SIZE;
+	}
+	while (len) {
+		unsigned int bytes = PAGE_SIZE;
+
+		bytes -= offset;
+
+		if (bytes > len)
+			bytes = len;
+
+		if (map_data) {
+			if (i == map_data->nr_entries * nr_pages) {
+				ret = -ENOMEM;
+				break;
+			}
+
+			page = map_data->pages[i / nr_pages];
+			page += (i % nr_pages);
+
+			i++;
+		} else {
+			page = alloc_page(q->bounce_gfp | gfp_mask);
+			if (!page) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
+
+		if (bio_add_pc_page(q, bio, page, bytes, offset) < bytes) {
+			if (!map_data)
+				__free_page(page);
+			break;
+		}
+
+		len -= bytes;
+		offset = 0;
+	}
+
+	if (ret)
+		goto cleanup;
+
+	if (map_data)
+		map_data->offset += bio->bi_iter.bi_size;
+
+	/*
+	 * success
+	 */
+	if ((iov_iter_rw(iter) == WRITE &&
+	     (!map_data || !map_data->null_mapped)) ||
+	    (map_data && map_data->from_user)) {
+		ret = bio_copy_from_iter(bio, iter);
+		if (ret)
+			goto cleanup;
+	} else {
+		if (bmd->is_our_pages)
+			zero_fill_bio(bio);
+		iov_iter_advance(iter, bio->bi_iter.bi_size);
+	}
+
+	bio->bi_private = bmd;
+	if (map_data && map_data->null_mapped)
+		bio_set_flag(bio, BIO_NULL_MAPPED);
+	return bio;
+cleanup:
+	if (!map_data)
+		bio_free_pages(bio);
+	bio_put(bio);
+out_bmd:
+	kfree(bmd);
+	return ERR_PTR(ret);
+}
+
+/**
+ *	bio_map_user_iov - map user iovec into bio
+ *	@q:		the struct request_queue for the bio
+ *	@iter:		iovec iterator
+ *	@gfp_mask:	memory allocation flags
+ *
+ *	Map the user space address into a bio suitable for io to a block
+ *	device. Returns an error pointer in case of error.
+ */
+static struct bio *bio_map_user_iov(struct request_queue *q,
+		struct iov_iter *iter, gfp_t gfp_mask)
+{
+	int j;
+	struct bio *bio;
+	int ret;
+
+	if (!iov_iter_count(iter))
+		return ERR_PTR(-EINVAL);
+
+	bio = bio_kmalloc(gfp_mask, iov_iter_npages(iter, BIO_MAX_PAGES));
+	if (!bio)
+		return ERR_PTR(-ENOMEM);
+
+	while (iov_iter_count(iter)) {
+		struct page **pages;
+		ssize_t bytes;
+		size_t offs, added = 0;
+		int npages;
+
+		bytes = iov_iter_get_pages_alloc(iter, &pages, LONG_MAX, &offs);
+		if (unlikely(bytes <= 0)) {
+			ret = bytes ? bytes : -EFAULT;
+			goto out_unmap;
+		}
+
+		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
+
+		if (unlikely(offs & queue_dma_alignment(q))) {
+			ret = -EINVAL;
+			j = 0;
+		} else {
+			for (j = 0; j < npages; j++) {
+				struct page *page = pages[j];
+				unsigned int n = PAGE_SIZE - offs;
+				bool same_page = false;
+
+				if (n > bytes)
+					n = bytes;
+
+				if (!__bio_add_pc_page(q, bio, page, n, offs,
+						&same_page)) {
+					if (same_page)
+						put_page(page);
+					break;
+				}
+
+				added += n;
+				bytes -= n;
+				offs = 0;
+			}
+			iov_iter_advance(iter, added);
+		}
+		/*
+		 * release the pages we didn't map into the bio, if any
+		 */
+		while (j < npages)
+			put_page(pages[j++]);
+		kvfree(pages);
+		/* couldn't stuff something into bio? */
+		if (bytes)
+			break;
+	}
+
+	bio_set_flag(bio, BIO_USER_MAPPED);
+
+	/*
+	 * subtle -- if bio_map_user_iov() ended up bouncing a bio,
+	 * it would normally disappear when its bi_end_io is run.
+	 * however, we need it for the unmap, so grab an extra
+	 * reference to it
+	 */
+	bio_get(bio);
+	return bio;
+
+ out_unmap:
+	bio_release_pages(bio, false);
+	bio_put(bio);
+	return ERR_PTR(ret);
+}
+
+/**
+ *	bio_unmap_user	-	unmap a bio
+ *	@bio:		the bio being unmapped
+ *
+ *	Unmap a bio previously mapped by bio_map_user_iov(). Must be called from
+ *	process context.
+ *
+ *	bio_unmap_user() may sleep.
+ */
+static void bio_unmap_user(struct bio *bio)
+{
+	bio_release_pages(bio, bio_data_dir(bio) == READ);
+	bio_put(bio);
+	bio_put(bio);
+}
+
+static void bio_invalidate_vmalloc_pages(struct bio *bio)
+{
+#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+	if (bio->bi_private && !op_is_write(bio_op(bio))) {
+		unsigned long i, len = 0;
+
+		for (i = 0; i < bio->bi_vcnt; i++)
+			len += bio->bi_io_vec[i].bv_len;
+		invalidate_kernel_vmap_range(bio->bi_private, len);
+	}
+#endif
+}
+
+static void bio_map_kern_endio(struct bio *bio)
+{
+	bio_invalidate_vmalloc_pages(bio);
+	bio_put(bio);
+}
+
+/**
+ *	bio_map_kern	-	map kernel address into bio
+ *	@q: the struct request_queue for the bio
+ *	@data: pointer to buffer to map
+ *	@len: length in bytes
+ *	@gfp_mask: allocation flags for bio allocation
+ *
+ *	Map the kernel address into a bio suitable for io to a block
+ *	device. Returns an error pointer in case of error.
+ */
+static struct bio *bio_map_kern(struct request_queue *q, void *data,
+		unsigned int len, gfp_t gfp_mask)
+{
+	unsigned long kaddr = (unsigned long)data;
+	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long start = kaddr >> PAGE_SHIFT;
+	const int nr_pages = end - start;
+	bool is_vmalloc = is_vmalloc_addr(data);
+	struct page *page;
+	int offset, i;
+	struct bio *bio;
+
+	bio = bio_kmalloc(gfp_mask, nr_pages);
+	if (!bio)
+		return ERR_PTR(-ENOMEM);
+
+	if (is_vmalloc) {
+		flush_kernel_vmap_range(data, len);
+		bio->bi_private = data;
+	}
+
+	offset = offset_in_page(kaddr);
+	for (i = 0; i < nr_pages; i++) {
+		unsigned int bytes = PAGE_SIZE - offset;
+
+		if (len <= 0)
+			break;
+
+		if (bytes > len)
+			bytes = len;
+
+		if (!is_vmalloc)
+			page = virt_to_page(data);
+		else
+			page = vmalloc_to_page(data);
+		if (bio_add_pc_page(q, bio, page, bytes,
+				    offset) < bytes) {
+			/* we don't support partial mappings */
+			bio_put(bio);
+			return ERR_PTR(-EINVAL);
+		}
+
+		data += bytes;
+		len -= bytes;
+		offset = 0;
+	}
+
+	bio->bi_end_io = bio_map_kern_endio;
+	return bio;
+}
+
+static void bio_copy_kern_endio(struct bio *bio)
+{
+	bio_free_pages(bio);
+	bio_put(bio);
+}
+
+static void bio_copy_kern_endio_read(struct bio *bio)
+{
+	char *p = bio->bi_private;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
+		p += bvec->bv_len;
+	}
+
+	bio_copy_kern_endio(bio);
+}
+
+/**
+ *	bio_copy_kern	-	copy kernel address into bio
+ *	@q: the struct request_queue for the bio
+ *	@data: pointer to buffer to copy
+ *	@len: length in bytes
+ *	@gfp_mask: allocation flags for bio and page allocation
+ *	@reading: data direction is READ
+ *
+ *	copy the kernel address into a bio suitable for io to a block
+ *	device. Returns an error pointer in case of error.
+ */
+static struct bio *bio_copy_kern(struct request_queue *q, void *data,
+		unsigned int len, gfp_t gfp_mask, int reading)
+{
+	unsigned long kaddr = (unsigned long)data;
+	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long start = kaddr >> PAGE_SHIFT;
+	struct bio *bio;
+	void *p = data;
+	int nr_pages = 0;
+
+	/*
+	 * Overflow, abort
+	 */
+	if (end < start)
+		return ERR_PTR(-EINVAL);
+
+	nr_pages = end - start;
+	bio = bio_kmalloc(gfp_mask, nr_pages);
+	if (!bio)
+		return ERR_PTR(-ENOMEM);
+
+	while (len) {
+		struct page *page;
+		unsigned int bytes = PAGE_SIZE;
+
+		if (bytes > len)
+			bytes = len;
+
+		page = alloc_page(q->bounce_gfp | gfp_mask);
+		if (!page)
+			goto cleanup;
+
+		if (!reading)
+			memcpy(page_address(page), p, bytes);
+
+		if (bio_add_pc_page(q, bio, page, bytes, 0) < bytes)
+			break;
+
+		len -= bytes;
+		p += bytes;
+	}
+
+	if (reading) {
+		bio->bi_end_io = bio_copy_kern_endio_read;
+		bio->bi_private = data;
+	} else {
+		bio->bi_end_io = bio_copy_kern_endio;
+	}
+
+	return bio;
+
+cleanup:
+	bio_free_pages(bio);
+	bio_put(bio);
+	return ERR_PTR(-ENOMEM);
+}
+
 /*
  * Append a bio to a passthrough request.  Only works if the bio can be merged
  * into the request based on the driver constraints.
diff --git a/block/blk.h b/block/blk.h
index 491e52fc0aa6..0a94ec68af32 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -484,4 +484,8 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 
 struct request_queue *__blk_alloc_queue(int node_id);
 
+int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		bool *same_page);
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a430e9c1c2d2..c1c0f9ea4e63 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -441,14 +441,6 @@ void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_release_pages(struct bio *bio, bool mark_dirty);
-struct rq_map_data;
-extern struct bio *bio_map_user_iov(struct request_queue *,
-				    struct iov_iter *, gfp_t);
-extern void bio_unmap_user(struct bio *);
-extern struct bio *bio_map_kern(struct request_queue *, void *, unsigned int,
-				gfp_t);
-extern struct bio *bio_copy_kern(struct request_queue *, void *, unsigned int,
-				 gfp_t, int);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
 
@@ -463,12 +455,6 @@ extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 extern void bio_copy_data(struct bio *dst, struct bio *src);
 extern void bio_list_copy_data(struct bio *dst, struct bio *src);
 extern void bio_free_pages(struct bio *bio);
-
-extern struct bio *bio_copy_user_iov(struct request_queue *,
-				     struct rq_map_data *,
-				     struct iov_iter *,
-				     gfp_t);
-extern int bio_uncopy_user(struct bio *);
 void zero_fill_bio_iter(struct bio *bio, struct bvec_iter iter);
 void bio_truncate(struct bio *bio, unsigned new_size);
 void guard_bio_eod(struct bio *bio);
-- 
2.25.1


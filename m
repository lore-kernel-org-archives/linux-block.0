Return-Path: <viro@ftp.linux.org.uk>
Date: Sat, 23 Sep 2017 18:19:26 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fix unbalanced page refcounting in bio_map_user_iov
Message-ID: <20170923171925.GQ32076@ZenIV.linux.org.uk>
References: <87bmm3xqds.wl-v.mayatskih@gmail.com>
 <20170923163928.GO32076@ZenIV.linux.org.uk>
 <20170923165537.GP32076@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170923165537.GP32076@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 23, 2017 at 05:55:37PM +0100, Al Viro wrote:

> IOW, the loop on failure exit should go through the bio, like __bio_unmap_user()
> does.  We *also* need to put everything left unused in pages[], but only from the
> last iteration through iov_for_each().
> 
> Frankly, I would prefer to reuse the pages[], rather than append to it on each
> iteration.  Used iov_iter_get_pages_alloc(), actually.

Something like completely untested diff below, perhaps...

diff --git a/block/bio.c b/block/bio.c
index b38e962fa83e..b5fe23597b41 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1323,94 +1323,60 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 			     const struct iov_iter *iter,
 			     gfp_t gfp_mask)
 {
-	int j;
-	int nr_pages = 0;
-	struct page **pages;
 	struct bio *bio;
-	int cur_page = 0;
-	int ret, offset;
+	struct bio_vec *bvec;
 	struct iov_iter i;
-	struct iovec iov;
-
-	iov_for_each(iov, i, *iter) {
-		unsigned long uaddr = (unsigned long) iov.iov_base;
-		unsigned long len = iov.iov_len;
-		unsigned long end = (uaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-		unsigned long start = uaddr >> PAGE_SHIFT;
-
-		/*
-		 * Overflow, abort
-		 */
-		if (end < start)
-			return ERR_PTR(-EINVAL);
-
-		nr_pages += end - start;
-		/*
-		 * buffer must be aligned to at least logical block size for now
-		 */
-		if (uaddr & queue_dma_alignment(q))
-			return ERR_PTR(-EINVAL);
-	}
+	int ret, j;
 
-	if (!nr_pages)
+	if (!iov_iter_count(iter))
 		return ERR_PTR(-EINVAL);
 
-	bio = bio_kmalloc(gfp_mask, nr_pages);
+	bio = bio_kmalloc(gfp_mask, iov_iter_npages(iter, BIO_MAX_PAGES));
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 
-	ret = -ENOMEM;
-	pages = kcalloc(nr_pages, sizeof(struct page *), gfp_mask);
-	if (!pages)
-		goto out;
+	i = *iter;
+	while (iov_iter_count(&i)) {
+		struct page **pages;
+		size_t offs;
+		ssize_t bytes;
+		int npages, j;
 
-	iov_for_each(iov, i, *iter) {
-		unsigned long uaddr = (unsigned long) iov.iov_base;
-		unsigned long len = iov.iov_len;
-		unsigned long end = (uaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-		unsigned long start = uaddr >> PAGE_SHIFT;
-		const int local_nr_pages = end - start;
-		const int page_limit = cur_page + local_nr_pages;
-
-		ret = get_user_pages_fast(uaddr, local_nr_pages,
-				(iter->type & WRITE) != WRITE,
-				&pages[cur_page]);
-		if (ret < local_nr_pages) {
-			ret = -EFAULT;
+		bytes = iov_iter_get_pages_alloc(&i, &pages, LONG_MAX, &offs);
+		if (bytes <= 0) {
+			ret = bytes ? bytes : -EFAULT;
 			goto out_unmap;
 		}
 
-		offset = offset_in_page(uaddr);
-		for (j = cur_page; j < page_limit; j++) {
-			unsigned int bytes = PAGE_SIZE - offset;
+		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
 
-			if (len <= 0)
-				break;
+		if (unlikely(offs & queue_dma_alignment(q))) {
+			ret = -EINVAL;
+			j = 0;
+		} else {
+			for (j = 0; j < npages; j++) {
+				struct page *page = pages[j];
+				unsigned n = PAGE_SIZE - offs;
+				unsigned prev_bi_vcnt = bio->bi_vcnt;
+
+				if (!bio_add_pc_page(q, bio, page, n, offs)) {
+					iov_iter_truncate(&i, 0);
+					break;
+				}
+
+				if (bio->bi_vcnt == prev_bi_vcnt)
+					put_page(page);
 			
-			if (bytes > len)
-				bytes = len;
-
-			/*
-			 * sorry...
-			 */
-			if (bio_add_pc_page(q, bio, pages[j], bytes, offset) <
-					    bytes)
-				break;
-
-			len -= bytes;
-			offset = 0;
+				iov_iter_advance(&i, n);
+				bytes -= n;
+				offs = 0;
+			}
 		}
-
-		cur_page = j;
-		/*
-		 * release the pages we didn't map into the bio, if any
-		 */
-		while (j < page_limit)
+		while (j < npages)
 			put_page(pages[j++]);
+		kvfree(pages);
 	}
 
-	kfree(pages);
-
 	bio_set_flag(bio, BIO_USER_MAPPED);
 
 	/*
@@ -1423,13 +1389,9 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	return bio;
 
  out_unmap:
-	for (j = 0; j < nr_pages; j++) {
-		if (!pages[j])
-			break;
-		put_page(pages[j]);
+	bio_for_each_segment_all(bvec, bio, j) {
+		put_page(bvec->bv_page);
 	}
- out:
-	kfree(pages);
 	bio_put(bio);
 	return ERR_PTR(ret);
 }

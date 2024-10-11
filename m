Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18E20ADE7;
	Fri, 11 Oct 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636257; cv=none; b=feQzTqUAGNiOrbI3G0YprQybRp7n8jjBw/I2QsLTMqFTItyhfvfXgcqClD0v9QGga7LolzX5oQIQOiagNI0qc9IYn1PBWzFuF7IuGvf4gmOmUzvLtqstIsBfb08Sxdqkzlig7ykH+P87SHF7NZ3u8WSpKKZgaQT0x09Q5VyZ6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636257; c=relaxed/simple;
	bh=ZI9clCjJjhVmMmhpzQMGAsPFn6KxMsb2kzwjyz1MSKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lqnl6kH0IbldnL1RxNX4yQsClnOY0ZKFagjd/p2K0ym3iDFyKxpGPX6wQ/BoNXSb1xl6SxdoBGWo/bZsAMRdwQEtA+i188TKn1m9PgBGJKPY78Vp5VHU5DnlY10k6vN6sJv49bniFRTPpf8pJToHNGEwGftY8PP7pvRoqQlj7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sD8kqpP4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sD8kqpP4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ufjU2q/C1FQdH4rkSPCHarm6ljmOSPBULCiUiT9EckE=; b=sD8kqpP4VzsRLqmeP0OxD40fLl
	wrMM1jlHeRCdLcJsflW1Fjw66CYruIUBInI6EV+umzMLGnYqdIfoEd6GnzssQW5DCycAMt+hkymiz
	0+t49eOlXG30bGb4CiYdQGF7jd+uMCbKx+8gjoXRwMgDyOpONA3iFrfazepyTmCy8/eU3LWbci+nt
	4j02X12XIS8r2vTp+y+msbsUlx5iUOjxxvxZk4UCmuG4HRPHd8/HxnhtZpawhHJCCloUgh568GobO
	5EIb6hXYPcw0RJla6huBxzgVN5gpDHtubsvyX7U1/MPR/2kKmNrsxBXKys+Vhin1h+9mFPektmGso
	20TrEpqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szBFu-0000000FiVI-1u6R;
	Fri, 11 Oct 2024 08:44:14 +0000
Date: Fri, 11 Oct 2024 01:44:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V2] lib/iov_iter.c: extract virt-contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <ZwjlXoSu6zA5Xcy7@infradead.org>
References: <20241011035247.2444033-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011035247.2444033-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 11, 2024 at 11:52:47AM +0800, Ming Lei wrote:
> Actually iov_iter_extract_pages() requires that there isn't gap in the
> extracted pages, so 'offset' only exists in the 1st page, then these
> pages can be mapped to one virtual(contiguous) address.
> 
> All iov_iter_bvec() users only want to extract virt-contiguous pages from
> iov_iter_extract_pages() instead physical-contiguous pages.
> 
> Change iov_iter_extract_bvec_pages() to extract virt-contiguous pages via
> bvec helper.
> 
> This way can fill much more pages one time, instead of (often)one page from
> iov_iter_extract_pages() each time.
> 
> The change is reasonable & safe since oher kind of iterators(UBUF, KVEC, ...)
> do return non physically-contiguous pages.

I had to read through the code to understand what this means.  Here is
what I have written based on my understanding:

The iov_iter_extract_pages interface allows to return physically
discontiguous pages, as long as all but the first and last page
in the array are page aligned and page size.  Rewrite
iov_iter_extract_bvec_pages to take advantage of that instead of only
returning ranges of physically contiguous pages.

> Fixes: a7e689dd1c06 ("block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages")

As far as I can tell the current behavior is highly suboptimal, but not
actually buggy, does this really warrant a fixes tag?

> +#define for_each_bvec_max(bvl, bio_vec, iter, start, nr_bvecs)		\
> +	for (iter = (start);						\
> +	     (iter).bi_size && iter.bi_idx < nr_bvecs &&		\
> +		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
> +	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
> +

And this helper just makes the code harder to read, and makes people
wonder what this undocumented _max interface does.  What about the
below variant of your patch that open codes it, and throws in a few
comments to explain the logic?

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1abb32c0da50bc..7768f1b2006d81 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1677,8 +1677,8 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
 }
 
 /*
- * Extract a list of contiguous pages from an ITER_BVEC iterator.  This does
- * not get references on the pages, nor does it get a pin on them.
+ * Extract a list of virtually contiguous pages from an ITER_BVEC iterator.
+ * This does not get references on the pages, nor does it get a pin on them.
  */
 static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 					   struct page ***pages, size_t maxsize,
@@ -1686,35 +1686,57 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 					   iov_iter_extraction_t extraction_flags,
 					   size_t *offset0)
 {
-	struct page **p, *page;
-	size_t skip = i->iov_offset, offset, size;
-	int k;
+	size_t skip = i->iov_offset, size = 0;
+	struct bvec_iter bi;
+	int k = 0;
 
-	for (;;) {
-		if (i->nr_segs == 0)
-			return 0;
-		size = min(maxsize, i->bvec->bv_len - skip);
-		if (size)
-			break;
+	if (i->nr_segs == 0)
+		return 0;
+
+	if (i->iov_offset == i->bvec->bv_len) {
 		i->iov_offset = 0;
 		i->nr_segs--;
 		i->bvec++;
 		skip = 0;
 	}
+	bi.bi_size = maxsize + skip;
+	bi.bi_bvec_done = skip;
+
+	maxpages = want_pages_array(pages, maxsize, skip, maxpages);
+
+	while (bi.bi_size && bi.bi_idx < i->nr_segs) {
+		struct bio_vec bv = bvec_iter_bvec(i->bvec, bi);
+
+		/*
+		 * The iov_iter_extract_pages interface only allows an offset
+		 * into the first page.  Break out of the loop if we see an
+		 * offset into subsequent pages, the caller will have to call
+		 * iov_iter_extract_pages again for the reminder.
+		 */
+		if (k) {
+			if (bv.bv_offset)
+				break;
+		} else {
+			*offset0 = bv.bv_offset;
+		}
 
-	skip += i->bvec->bv_offset;
-	page = i->bvec->bv_page + skip / PAGE_SIZE;
-	offset = skip % PAGE_SIZE;
-	*offset0 = offset;
+		(*pages)[k++] = bv.bv_page;
+		size += bv.bv_len;
 
-	maxpages = want_pages_array(pages, size, offset, maxpages);
-	if (!maxpages)
-		return -ENOMEM;
-	p = *pages;
-	for (k = 0; k < maxpages; k++)
-		p[k] = page + k;
+		if (k >= maxpages)
+			break;
+
+		/*
+		 * Similarly, we are done when the end of the bvec doesn't align
+		 * to a page boundary as that would create a hole in the
+		 * returned space.  The caller will handle this with another call
+		 * to iov_iter_extract_pages.
+		 */
+		if (bv.bv_offset + bv.bv_len != PAGE_SIZE)
+			break;
+	     	bvec_iter_advance_single(i->bvec, &bi, bv.bv_len);
+	}
 
-	size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
 	iov_iter_advance(i, size);
 	return size;
 }

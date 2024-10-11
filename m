Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743EA21A70C;
	Fri, 11 Oct 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655873; cv=none; b=K2KOAHujEqNndmEBmZPzJM5SQc5FHOtie7pomqRPDzbrfbuqm3znjHLHkJyMC/WKCSvK/yB8wa3zJZUwqcvus68Fl61/M8BtjyFiAt9QNl785QzQ2xaazFFnKeLSyoH+Y+cLd2SlG48U6aluR7CAD/FbpKGPae8ofbapBNMcRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655873; c=relaxed/simple;
	bh=FqMPAU4HPBdlhTcXShKd1l0QI0kRx19jxv+S9orB7yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPMlEU/CbCzmgv81BdNkkp03sKnAimVJhOCUV+D7Y3dr9CbBJI9QttfJbB+xm8FbLbiq+CXTblrJJuq61oXAm7sTV4YKsnsEM0x+9xjJqPX8NII4cPj6MuNOGg1hy91DduBcd/GryQXpOSK0jdsT4+PC+RYrAVRCaaOoIoEyZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HZvYMVbB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HZvYMVbB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B4Ha4yE9lVIj1UEDH8gkFD4pDPWuVhXKTqcgGB3822Q=; b=HZvYMVbBc1H/VM2KxpTBfk/mDw
	3hP6N4VN+hBsPTK7pfuSzBDjSkwz4ELlojbM34nEZU+TgBy2JyzZYahghsgT4XRf/hOf9cpUu8hy2
	xmK1gmWuDOrs4qZeQIHLuYHoxIx0THnRlt+/vD1pVu70TAgeBZTA5oho251O7lCkb8VgbHoLmDlww
	hKu61JlFarVKosdiC4eMztNueN2vcQkqtS2elmjknsCeVF8YVBuahlgV4rwMM1pfoVl2ACdFFSFtb
	biBeknGoGo7CW+bXZkStRKF9OLTDo1SKXJ8ujNi2PK2vUdBkPdzYqLOQCz2sZhJN8KQSkuBOtmXe2
	LWufhW3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szGMF-0000000GYJd-0xTe;
	Fri, 11 Oct 2024 14:11:07 +0000
Date: Fri, 11 Oct 2024 07:11:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
	dhowells@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <Zwkx-8M3oRD6Q2cQ@infradead.org>
References: <20241011132047.1153249-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011132047.1153249-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Btw, this is a missing a:

From: Ming Lei <ming.lei@redhat.com>

at the top of the mail as it should be credited to Ming of course.

On Fri, Oct 11, 2024 at 03:20:22PM +0200, Christoph Hellwig wrote:
> The iov_iter_extract_pages interface allows to return physically
> discontiguous pages, as long as all but the first and last page
> in the array are page aligned and page size.  Rewrite
> iov_iter_extract_bvec_pages to take advantage of that instead of only
> returning ranges of physically contiguous pages.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [hch: minor cleanups, new commit log]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> v3:
>  - open code the iterator
>  - improve commit log and comments
> 
>  lib/iov_iter.c | 67 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1abb32c0da50bc..9fc06f5fb7489f 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1677,8 +1677,8 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
>  }
>  
>  /*
> - * Extract a list of contiguous pages from an ITER_BVEC iterator.  This does
> - * not get references on the pages, nor does it get a pin on them.
> + * Extract a list of virtually contiguous pages from an ITER_BVEC iterator.
> + * This does not get references on the pages, nor does it get a pin on them.
>   */
>  static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>  					   struct page ***pages, size_t maxsize,
> @@ -1686,35 +1686,58 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>  					   iov_iter_extraction_t extraction_flags,
>  					   size_t *offset0)
>  {
> -	struct page **p, *page;
> -	size_t skip = i->iov_offset, offset, size;
> -	int k;
> +	size_t skip = i->iov_offset, size = 0;
> +	struct bvec_iter bi;
> +	int k = 0;
>  
> -	for (;;) {
> -		if (i->nr_segs == 0)
> -			return 0;
> -		size = min(maxsize, i->bvec->bv_len - skip);
> -		if (size)
> -			break;
> +	if (i->nr_segs == 0)
> +		return 0;
> +
> +	if (i->iov_offset == i->bvec->bv_len) {
>  		i->iov_offset = 0;
>  		i->nr_segs--;
>  		i->bvec++;
>  		skip = 0;
>  	}
> +	bi.bi_size = maxsize + skip;
> +	bi.bi_bvec_done = skip;
> +
> +	maxpages = want_pages_array(pages, maxsize, skip, maxpages);
> +
> +	while (bi.bi_size && bi.bi_idx < i->nr_segs) {
> +		struct bio_vec bv = bvec_iter_bvec(i->bvec, bi);
> +
> +		/*
> +		 * The iov_iter_extract_pages interface only allows an offset
> +		 * into the first page.  Break out of the loop if we see an
> +		 * offset into subsequent pages, the caller will have to call
> +		 * iov_iter_extract_pages again for the reminder.
> +		 */
> +		if (k) {
> +			if (bv.bv_offset)
> +				break;
> +		} else {
> +			*offset0 = bv.bv_offset;
> +		}
>  
> -	skip += i->bvec->bv_offset;
> -	page = i->bvec->bv_page + skip / PAGE_SIZE;
> -	offset = skip % PAGE_SIZE;
> -	*offset0 = offset;
> +		(*pages)[k++] = bv.bv_page;
> +		size += bv.bv_len;
>  
> -	maxpages = want_pages_array(pages, size, offset, maxpages);
> -	if (!maxpages)
> -		return -ENOMEM;
> -	p = *pages;
> -	for (k = 0; k < maxpages; k++)
> -		p[k] = page + k;
> +		if (k >= maxpages)
> +			break;
> +
> +		/*
> +		 * We are done when the end of the bvec doesn't align to a page
> +		 * boundary as that would create a hole in the returned space.
> +		 * The caller will handle this with another call to
> +		 * iov_iter_extract_pages.
> +		 */
> +		if (bv.bv_offset + bv.bv_len != PAGE_SIZE)
> +			break;
> +
> +		bvec_iter_advance_single(i->bvec, &bi, bv.bv_len);
> +	}
>  
> -	size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
>  	iov_iter_advance(i, size);
>  	return size;
>  }
> -- 
> 2.45.2
> 
> 
---end quoted text---

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC219923C
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648245; cv=none; b=qheW2aVG8VXy8AecJc+VDOaeZrar9GdOhSYhT0upJ0gK8q/0XCtxkv9YY2I5W/x/Y2xIfWupU6crFw8Yn82bzO+KjlweD+RBpfVsQXcLByehEtq2WIUVt6WwyhxhhBFUubyA+wbwc8q5QAPiO8nM7lPKrXaho1rgBHHAvKJATws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648245; c=relaxed/simple;
	bh=jhijvkU9Y6TjMmi9MNqLpvpd+sy1nIS4UC1DfnFir9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAHHJ761/8XxAgwwg9jsOo16oGyzxu5EgRHI2aFDtHEDSSmd5KlQA5oh2DspTO1rpv4cDm9Y42UoKQaNbFKTePsrlhaRSOmwuP5l0YRmnKM1o9QrPXI6PRR0JLs4ui8K0ObwoYvMwW7ZkKlPdmUACmlHcx7FOB0gFN5optMRy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/pO51Af; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/pO51Af"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728648242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DtLEQwSBZFuMXa3pniRMEEJP5d/rPm1ZUIoNXNCfYo=;
	b=O/pO51AfqtaW4zf70qJrD+st2skOK7CdfqGGNFhy7nzVJ5Ad/CPq15rLVrrtxT3z3Z9pF0
	6PZ+RMU6+BWPT3NnHXXkvNRqtb/fI3PDaQxGFT4DF+bxoYRzjM6M7kDPBMHZZf9qShvKqA
	ldWhqRJ7jinMr7KT6vBN/DFhb3e+yvI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-ia3dAel8PMGE-waguDnhUA-1; Fri,
 11 Oct 2024 08:04:01 -0400
X-MC-Unique: ia3dAel8PMGE-waguDnhUA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE3221955EA9;
	Fri, 11 Oct 2024 12:03:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CCE719560A2;
	Fri, 11 Oct 2024 12:03:54 +0000 (UTC)
Date: Fri, 11 Oct 2024 20:03:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V2] lib/iov_iter.c: extract virt-contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <ZwkUJaXM8XLgl8in@fedora>
References: <20241011035247.2444033-1-ming.lei@redhat.com>
 <ZwjlXoSu6zA5Xcy7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwjlXoSu6zA5Xcy7@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Oct 11, 2024 at 01:44:14AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2024 at 11:52:47AM +0800, Ming Lei wrote:
> > Actually iov_iter_extract_pages() requires that there isn't gap in the
> > extracted pages, so 'offset' only exists in the 1st page, then these
> > pages can be mapped to one virtual(contiguous) address.
> > 
> > All iov_iter_bvec() users only want to extract virt-contiguous pages from
> > iov_iter_extract_pages() instead physical-contiguous pages.
> > 
> > Change iov_iter_extract_bvec_pages() to extract virt-contiguous pages via
> > bvec helper.
> > 
> > This way can fill much more pages one time, instead of (often)one page from
> > iov_iter_extract_pages() each time.
> > 
> > The change is reasonable & safe since oher kind of iterators(UBUF, KVEC, ...)
> > do return non physically-contiguous pages.
> 
> I had to read through the code to understand what this means.  Here is
> what I have written based on my understanding:
> 
> The iov_iter_extract_pages interface allows to return physically
> discontiguous pages, as long as all but the first and last page
> in the array are page aligned and page size.  Rewrite
> iov_iter_extract_bvec_pages to take advantage of that instead of only
> returning ranges of physically contiguous pages.
> 
> > Fixes: a7e689dd1c06 ("block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages")
> 
> As far as I can tell the current behavior is highly suboptimal, but not
> actually buggy, does this really warrant a fixes tag?

This bad behavior is really introduced from this commit, I'd suggest to
add 'Fixes:'

> 
> > +#define for_each_bvec_max(bvl, bio_vec, iter, start, nr_bvecs)		\
> > +	for (iter = (start);						\
> > +	     (iter).bi_size && iter.bi_idx < nr_bvecs &&		\
> > +		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
> > +	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
> > +
> 
> And this helper just makes the code harder to read, and makes people
> wonder what this undocumented _max interface does.  What about the
> below variant of your patch that open codes it, and throws in a few
> comments to explain the logic?

Looks open-code iterator is more readable, the patch looks fine, and
I have verified it works as expected.

> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1abb32c0da50bc..7768f1b2006d81 100644
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
> @@ -1686,35 +1686,57 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
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
> +		 * Similarly, we are done when the end of the bvec doesn't align
> +		 * to a page boundary as that would create a hole in the
> +		 * returned space.  The caller will handle this with another call
> +		 * to iov_iter_extract_pages.
> +		 */
> +		if (bv.bv_offset + bv.bv_len != PAGE_SIZE)
> +			break;
> +	     	bvec_iter_advance_single(i->bvec, &bi, bv.bv_len);

Indent.


Thanks,
Ming


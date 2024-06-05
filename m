Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDCD512
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613131; cv=none; b=r6ZiD+zdfZgaAgyXbLpM8YSYZdEueUSdpf86f5lw2+On+QmITTYOUwOjytzXl8kuwdx8XfmkX0L60RQOt3zHe1fuOAYdrJvTQH7Q4Om9ZSb36ycGSaAWhdYJBBKqOwQWzPDXTB5eBCpeQnw6TMVUwlKH7rO82AEdzU7M1NsALuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613131; c=relaxed/simple;
	bh=cus2VFbZG7x6eFAjBCG1jeTVhQSrpotP6HuLxNnNIEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/o39Z1IviA347c0DwERAg8k+cN7flP1A6cFYzIVyvJ42gcRt3zLOG7QRZwNqAThD1lRgLZrjmgy0cgDUxfOPHb80HVrvcrEo+jXt8zoKHUc/b29Xxj651IVzlx5ZBongP61ShG6pjmPFTU9MEaVIBGwxGV2LZpTzmpQpuIj2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a8kN2etG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a8kN2etG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yXd0bZV0thh34kd/8d6NWKxaK14web1hFtAq+NZviEA=; b=a8kN2etGG1D0uWD5CxQSAmkfCj
	A7MoF9K16T8LUYeo9wUbiFK3ACBAsL6DqB3ZGzx51TAx7c0A1V3yD/akDa4ZlNqe+O4/hIZ4cVoJR
	U3s8uFr5j+zZ5M85QSFcLB8SkiZ1HFnjGd+g90Gp5Yx9yp1/ttDS3JfW5000RiDwkf/aUXxOrxbZ8
	lH1ktw9OJXPKDfz1xLRXXAwZ4/mlGAuKkuCKHM9+gnjErNKfK83mSL7A9tB9+pnYxk8ue+Hhoaltz
	uqsK7bRwYHUL7DJi9Y0FqXroU04LG04xSJdV1/FViOWsjNN6nkxp+y5lZItIjz/PPkCvCEEArCD3/
	11WMEEVA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEvdU-0000000GSke-04kL;
	Wed, 05 Jun 2024 18:45:24 +0000
Date: Wed, 5 Jun 2024 19:45:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] block: add folio awareness instead of looping
 through pages
Message-ID: <ZmCyQwCtvgolgkcz@casper.infradead.org>
References: <20240605092455.20435-1-kundan.kumar@samsung.com>
 <CGME20240605093225epcas5p335664b9185c99a8fe1d661227d3f4f1a@epcas5p3.samsung.com>
 <20240605092455.20435-2-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605092455.20435-2-kundan.kumar@samsung.com>

On Wed, Jun 05, 2024 at 02:54:54PM +0530, Kundan Kumar wrote:
> @@ -1214,27 +1214,27 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
>  
>  	if (bio->bi_vcnt > 0 &&
>  	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
> -				page, len, offset, &same_page)) {
> +				&folio->page, len, offset, &same_page)) {

Let's make that folio_page(folio, 0)

> +static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
>  		unsigned int len, unsigned int offset)
>  {
>  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>  	bool same_page = false;
>  
> -	if (bio_add_hw_page(q, bio, page, len, offset,
> +	if (bio_add_hw_page(q, bio, &folio->page, len, offset,

Likewise.

> @@ -1301,15 +1301,49 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  
>  	for (left = size, i = 0; left > 0; left -= len, i++) {
>  		struct page *page = pages[i];
> +		struct folio *folio = page_folio(page);
> +
> +		/* Calculate the offset of page in folio */
> +		folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
> +				offset;

No it doesn't.  I'd drop the comment entirely, but if you must have a
comment, it turns the page offset into a folio offset.

> +		len = min_t(size_t, (folio_size(folio) - folio_offset), left);
> +
> +		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> +
> +		if (num_pages > 1) {
> +			ssize_t bytes = left;
> +			size_t contig_sz = min_t(size_t,  PAGE_SIZE - offset,
> +						 bytes);
> +
> +			/*
> +			 * Check if pages are contiguous and belong to the
> +			 * same folio.
> +			 */

You do like writing obvious comments, don't you?

> +			for (j = i + 1; j < i + num_pages; j++) {
> +				size_t next = min_t(size_t, PAGE_SIZE, bytes);
> +
> +				if (page_folio(pages[j]) != folio ||
> +				    pages[j] != pages[j - 1] + 1) {
> +					break;
> +				}
> +				contig_sz += next;
> +				bytes -= next;
> +			}
> +			num_pages = j - i;
> +			len = contig_sz;
> +		}


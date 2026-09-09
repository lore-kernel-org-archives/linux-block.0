Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A0357D08;
	Wed,  9 Sep 2026 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935320; cv=none; b=oDpnAkm1dXhFTXgHUAh8CmAqRzZmPZCYrjnHo+uhmc7zOR+x/p0oYXarapthk9qYhLzfVMjG/iaMfB7czkAYYXqktfl+jYgY4spvU2uC4Y8XiB7vsqdqE16U1rkAyzl108ZMdqDr2Ul2Zp5aBKA73JxKmokjpwAlSTt5aWw+2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935320; c=relaxed/simple;
	bh=BrlJQRGpv8LjaBg42W5SV69VB13V8HOV4jBK9bSeMB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSiWMvd7tDAUehYatw3rF0pD5IX/oOJLyuEYDftvrE9kCdRW+q+UXlTV3cFvbsRxZ30Xa9/+hACdZvd10K2wA3fT29EmhHjl0zcEeS0ak7JHY33tOFzkFmfFpivm2G5r//CdY2B1p2M0Azs4P6ELyDdbk4CFHn4bHpUcT1+C+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 74A7B68BFE; Wed,  9 Sep 2026 08:28:27 +0200 (CEST)
Date: Wed, 9 Sep 2026 08:28:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-ID: <20260909062827.GA29874@lst.de>
References: <1456602.1788783694@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456602.1788783694@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 07, 2026 at 01:21:34PM +0100, David Howells wrote:
> index 6665372ecf71..5e9f9e2c30b1 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1921,15 +1921,29 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
>  		unsigned short max_vecs, unsigned mem_align_mask,
>  		iov_iter_extraction_t extraction_flags)
>  {
> -	unsigned long start = (unsigned long)iter_iov_addr(iter);
>  	unsigned short entries_left = max_vecs - *nr_vecs;
>  	unsigned short nr_pages, i = 0;
>  	size_t left, offset, len;
>  	struct page **pages;
>  	ssize_t size;
>  
> -	if ((start | iter_iov_len(iter)) & mem_align_mask)
> +	/*
> +	 * DMA engines typically have both memory address and length alignment
> +	 * requirements, so check these against the alignment mask.  For UBUF,
> +	 * IOVEC and KVEC, only the current segment will be drawn from; for
> +	 * everything else we might draw from multiple segments, so we need to
> +	 * check those too.

I have a bit of a hard time understanding what "draw from" means here?
I guess you mean that iov_iter_extract_pages only operates on a single
iov/kvec/bvec but could touch multiple segments for the others?
Maybe try to explain that without introducing new terminology?


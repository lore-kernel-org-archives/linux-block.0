Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC52C11FA;
	Wed, 26 Aug 2026 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777541; cv=none; b=r9YJMBlkNYynL7sYOtArlgaUUwa6WpAWYY7gsBIObcftIojJsCzBZfzf2hr0OQwAO8BmXpi87Cx1e4L3mexrPX3io511Eosmnaa1Iz3vryETJTDqE0Nelnh2116tYoc1VHEaSfRfa5UZhMt75ZA7eBnnq51KZ4dgiEQfh3SA9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777541; c=relaxed/simple;
	bh=HFEwYkuDOYK/e11oo7Mrl+3xi0EteH/qvK3YEb8wkEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZYJFq/VUsGmGvq/YImWilQ+gFZTvGJsBWT9LBiTYCicu/0YkWBRLzZreaKnaUrXOmf1YlNTgl1y+OSNAtJNEOC4AbSCCUG0BtXwQ5IyIKWmoSL6eofJW2qG/4DRTXesWtQ4hOOgDO2CwJ3infCt/+h/jHKQ1LGd4C8d5bPeZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw9gjVSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw9gjVSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC01D1F000E9;
	Wed, 26 Aug 2026 20:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787777540;
	bh=5b+l3k9DBgHTG3PkSnIyD0rgFhg9jWbUNMUfpYEV3g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bw9gjVSj0FpfwiNB7URk+9Rpr3BM64aWo8M8O6VXawNiNvdF4OrLBz67NsMGlLk6/
	 hMFolT4S6vCWnhtAtY0Z5pM5YBEtO8egcTinOIxZ4Gr9wzQWqpHve62F4kjdZe4m7p
	 xHhovMFUoJdoLW4qlImo2Apb7j+jPFlpgD8Li8zuh6P0CsBHOtNzWHXUcb5J4UVwlg
	 L9mZcVSMn0xF96rdO05oHA8vUGi/WHuLBQgHCgHBac/r2SJMiHeRD57hp9xd42ZorS
	 XgcG2GYjzTZ6T3pkpGRFY6bgKRmbcmVes5ZXO7pIYw7tARBz/BLMiDeHZO3csOsNVv
	 FdDx8RGWl7rlg==
Date: Wed, 26 Aug 2026 14:52:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-ID: <ao9SAh9E1F-6oXaM@kbusch-mbp>
References: <1819786.1787768317@warthog.procyon.org.uk>
 <1895550.1787777192@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1895550.1787777192@warthog.procyon.org.uk>

On Wed, Aug 26, 2026 at 09:46:32PM +0100, David Howells wrote:
> Fixes: 14b007e17881 ("block: validate user space vectors during extraction")
> Suggested-by: Keith Busch <kbusch@kernel.org>

Thanks, looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

Missing your Signed-off-by?
 
> cc: Keith Busch <kbusch@kernel.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Hannes Reinecke <hare@kernel.org>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: netfs@lists.linux.dev
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  lib/iov_iter.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 6665372ecf71..c489569a5815 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1921,15 +1921,22 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
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
> +	if (likely(iter_is_ubuf(iter) ||
> +		   iter_is_iovec(iter) ||
> +		   iov_iter_is_kvec(iter))) {
> +		unsigned long start = (unsigned long)iter_iov_addr(iter);
> +
> +		if ((start | iter_iov_len(iter)) & mem_align_mask)
> +			return -EINVAL;
> +	} else if (iov_iter_alignment(iter) & mem_align_mask) {
>  		return -EINVAL;
> +	}
>  
>  	/*
>  	 * Move page array up in the allocated memory for the bio vecs as far as
> 

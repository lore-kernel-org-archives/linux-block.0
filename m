Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19193B19CF;
	Wed, 26 Aug 2026 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769274; cv=none; b=HjncrzSwAACXqnfJWuoLHqvLj89g0O+TIQwCEAEtV8YkAufoqFEVIXtUUzKhWOp3OH4+eZQZWhmoznYubJNNPVr4DOSCZZfHqU94EdGeqZuiD2WSL+eDFLlWkem23WGY1VLZXqgl3Qe29xNwoB0y/SlZEVMh8GSAVhdY3RFjb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769274; c=relaxed/simple;
	bh=WoKEstAxHN2E8coeOmacYjFPwFjlhZ4GC5UqV0xV+ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adXW2CZGU/d5Fr+VOlP+WmHtgKhx/32jDwlmMzTH0PJBu4aWkTc0FnorAYbvrqMcijPQmarddG/sSK9wCBUWM/snMtMmzBvuBlIRnlp16DaPrr1YUXqs5D7JXsHxMPZeJO+WIF0m/buGQScsnaI7d0T9uEPVVQzzbD92Kht9MZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkUTzNSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkUTzNSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F381F00A3D;
	Wed, 26 Aug 2026 18:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769258;
	bh=hMvR2B7tAETH9ilflu7XXJD3qyRuNdLa73zRpfKhV1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KkUTzNSFhAoWXKwQXA6M4TTtSaBpxTjpepIYzOXcRqCXxrjBXhmQ3VlBTQR1NYZur
	 pLHslNH6g/a3iZ6Qi4YmBJgi50O55x+Eah1L6a9Mx/0vV942vnx4X9td8LglXlxlLt
	 uAxJQ6hX1M+OUhcgfBEiHj2GIHaz2Tp5+9pJU8YWvO1MbcM79oOeK3BNRV96fQueCU
	 puU17gPiypEbLjmBn57hUwJjE4JAyOSF8gCvEi5JwT9BmgCts/LC1X1MHL06+k2v1v
	 HOzqBNYJkBDtQd6msCNejJK5gfZdp6A5RU5R2ExhYRe5/LE5HgxheX/U0lJMJNr79i
	 HcajBbbvtKWqQ==
Date: Wed, 26 Aug 2026 12:34:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-ID: <ao8xqMXoCfj4AWUw@kbusch-mbp>
References: <1819786.1787768317@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1819786.1787768317@warthog.procyon.org.uk>

On Wed, Aug 26, 2026 at 07:18:37PM +0100, David Howells wrote:
> @@ -1921,15 +1921,19 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
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
> +	if (iov_iter_alignment(iter) & mem_align_mask) {
> +		pr_warn("%u %zx %x\n",
> +			iter->iter_type,
> +			iov_iter_alignment(iter),
> +			mem_align_mask);
>  		return -EINVAL;
> +	}

iov_iter_alignment loops over all the vectors when we only need to
examine the current one here.

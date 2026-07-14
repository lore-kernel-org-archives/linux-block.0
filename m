Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DB46AF27;
	Tue, 14 Jul 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039194; cv=none; b=pa2GL5IgrZWCMKrQbHz04pDE6A9JM76VkcmgB96BtohkS9t9kAJeell9EPz0uOVEsKogqeObiRUoG/EMvkjwJqA4tXWk9LW9JIT93b0xRzCn0j319eYIaDYjn3G3PguKuMXGPX27VgQb/szMiOLwfv7Bwh36sYRusQuVGxXQZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039194; c=relaxed/simple;
	bh=BpzYzNIG3aCTKwWPtVJy2QqyqKVWWR2E0o1ytMbIg5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA0BIdUgsxHLR7G8lH2y+nhXOydAjRjOBGW9KIxVy4qjm6lEHNhTJmmdBLJjglqV9pl7QOyOiByXTxR6e2I6vZWZmhqF/0bTwlGH4ytI9Tt8I5WYSk81m5c6L40dANVKDDAgxW0tk6FESwBVePap9SmRisFjp5vCWg1tvgzUU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPaRsztg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPaRsztg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1C61F000E9;
	Tue, 14 Jul 2026 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039193;
	bh=Du/Qx6OfsLSa/qdn0n3JG6VcWY9DO0fr0k2WbNZUHg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UPaRsztgoLG0bk2DgSoYyOwymANMXb+XiGlt/Rjmi4C2MkkdaNIugB68fCDIpF1Nw
	 lK6EdLX7aCEk7jC0WfTx7OxB0VlEdsT/3j1SZQO7+NGsJnAOhNvZpuzdJBqFooIgyZ
	 7rQ+S3VNzAql5lhd5qvZdMOhenctRySIevjk/06RNjfAFCNP3XomppjTVF5kzoBec9
	 enb39TSD8voUiZrhYO58pGwdLNuiKk/3W8zuXEOEpfO9UwNn4cFtUP4OF1n50K96wb
	 tPvpHrm9i4ZxWxl8Mf2GA9Bqphb7tbjttQffveqMtVIluB0r8KD0wy1j42iM4twrDl
	 6YkgxsiOCz6RA==
Date: Tue, 14 Jul 2026 08:26:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, Qu Wenruo <wqu@suse.com>,
	Neptune <z1281552865@gmail.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] block,iov_iter: move bio_iov_iter_align_down into
 iov_iter_extract_bvecs
Message-ID: <alZHF1wZY58JSU7N@kbusch-mbp>
References: <20260714131318.2670042-1-hch@lst.de>
 <20260714131318.2670042-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714131318.2670042-4-hch@lst.de>

On Tue, Jul 14, 2026 at 03:12:00PM +0200, Christoph Hellwig wrote:
>  ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
>  		size_t max_size, unsigned short *nr_vecs,
>  		unsigned short max_vecs, unsigned mem_align_mask,
> -		iov_iter_extraction_t extraction_flags)
> +		unsigned len_align_mask, iov_iter_extraction_t extraction_flags)
>  {
>  	unsigned long start = (unsigned long)iter_iov_addr(iter);
>  	unsigned short entries_left = max_vecs - *nr_vecs;
> @@ -1960,11 +1991,13 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
>  		offset = 0;
>  	}
>  
> +	size -= left;
>  	iov_iter_revert(iter, left);
>  	if (iov_iter_extract_will_pin(iter)) {
>  		while (i < nr_pages)
>  			unpin_user_page(pages[i++]);
>  	}
> -	return size - left;
> +
> +	return bvec_iter_align_down(iter, bv, size, nr_vecs, len_align_mask);

I don't think we can do this alignment inline with building the bio_vec.
The len_align_mask is usually the logical block size. We can submit
sub-sector sized vectors so aligning down after extracting such a vector
will result in a zero size for that iteration.

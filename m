Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508B2E62DA
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255509; cv=none; b=bgDEEmjhMZB7ueevd+Rc6Cfgfm1LHSfea63jesATk0McLE80KJUfAQUtAU8CL0rAyb9xtuN5baJi7kUoDcWOXqxZYnqw/1hCoXOZIpumnhhLOBXJ60LrrxgVPRDHT6nhXwFV4aXTQIcu21j+2CJGeT/FCz/3tbwvOUonMDRLgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255509; c=relaxed/simple;
	bh=pkjLyqvrhft8OY+ogz9/TwHjJKfTXvrmnKlu+L1bbnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhlNcwsgF5YGdxELVtDgVQRpjBaDTAhlUoBwUyWPqnxo65f3EK8y9w58DdHZPlE/c7yfCoBwJsegyTynPQzPj6YpPDfaYEUbNekDklYaPlFGC/+2nzUOCGZb5ExCefQL3EWGmOJahIHnoLyJ7Z6RND3JVxk9rsyT4wuJIKVhKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F210227AAA; Tue,  4 Nov 2025 12:24:55 +0100 (CET)
Date: Tue, 4 Nov 2025 12:24:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	dlemoal@kernel.org, hans.holmberg@wdc.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] null_blk: allow byte aligned memory offsets
Message-ID: <20251104112454.GA13441@lst.de>
References: <20251103172854.746263-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103172854.746263-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +		offset = pos & (PAGE_SIZE - 1);

This is an open coded offset_in_page()

> +		offset = pos & (PAGE_SIZE - 1);

Same.

> +static int null_transfer(struct nullb *nullb, void *p,
> +	unsigned int len, bool is_write, loff_t pos,
>  	bool is_fua)

Maybe fix the non-standard indentation here if you touch it anyway?

> +			memset(p, 0xff, len);
> +		flush_dcache_page(virt_to_page(p));
>  	} else {
> -		flush_dcache_page(page);
> -		err = copy_to_nullb(nullb, page, off, sector, len, is_fua);
> +		flush_dcache_page(virt_to_page(p));
> +		err = copy_to_nullb(nullb, p, pos, len, is_fua);

virt_to_page does not work when kmap actually had to map, i.e. for
highmem.


>  	spin_lock_irq(&nullb->lock);
>  	rq_for_each_segment(bvec, rq, iter) {
> +		void *p = bvec_kmap_local(&bvec);;
> +
>  		len = bvec.bv_len;
> +		if (len > nr_bytes)
> +			len = nr_bytes;
> +		err = null_transfer(nullb, p, nr_bytes, op_is_write(req_op(rq)),
> +				    pos, rq->cmd_flags & REQ_FUA);
> +		kunmap_local(p);

Any reason to not keep the kmap local to null_transfer (or even the low-level
operation below it) and pass the bvec to it?


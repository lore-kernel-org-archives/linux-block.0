Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617828315A
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546130; cv=none; b=lGjhMB+kXrWGiEfL0E3DghwGoAFu3pgJmk+RlIQNHmQmx1DD2qAtGstaTkE8nYRx0wm+7dzcTqNFbiPeybVLxBHSDKi0gs8rTNnjufwi1wAOo1+X/w3CKTXPc6V4fS30pqBpSAVQHSQz3kiA63QFvtQEBOl5rwKNXZ6/CMP7zQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546130; c=relaxed/simple;
	bh=Nydkr/o9PVsftISBXyT7ViVrHNGbQyGpFGETSyWfy2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B380h1OuR/ZnoxoM72N+jOVhrWsofcwKo5fjRWmgLPlsKddlEEKgUljuzJqkzThxf1uJ2bSU7mNHbxwGLgDOMqK1qJkkSFGorcJWC0X/tlFUsyERM528LzfNBpmZyIAbc/hWiTpWoQxfeTzfsqli6rNFMTPE/kwRxLtsxpjazaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS5YL7MI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS5YL7MI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582E0C4CEEB;
	Tue,  6 May 2025 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746546129;
	bh=Nydkr/o9PVsftISBXyT7ViVrHNGbQyGpFGETSyWfy2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WS5YL7MIJmAP7NwcuT/ag3VBzsO014a0xzDA+Mcgxzl206At5lGJTKy6ke+5w3R+d
	 9cVygyFKNuEcaTpYLHn3wROEdYIiFKG7BC++kLNbTKM4XTXj9GwUXMRoA8CiSsnQcr
	 y8lR5FfNtq7O1Dk38KzdtTDAy045b4aPwf7yGftoWzMJCxBUiA9gzUzhVoYOQowzbM
	 OBajaVqL9AvAe6mfuXNnTjtEk3FG+maYgsT/QS5SbsDvQMa8lywox/WjvwPbzRzm6t
	 6r9HgpjWGaRIIbYilLk6fLm4HA03+uJyiVnMBtbuFg5i5o6sdhEdsfkbtbQWCTMypK
	 M1QZIU1OTIeRA==
Date: Tue, 6 May 2025 09:42:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, yukuai1@huaweicloud.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] brd: avoid extra xarray lookups on first write
Message-ID: <aBotzukGcxHQ0LIX@kbusch-mbp.dhcp.thefacebook.com>
References: <20250506143836.3793765-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506143836.3793765-1-hch@lst.de>

On Tue, May 06, 2025 at 04:38:36PM +0200, Christoph Hellwig wrote:
> +	rcu_read_lock();
> +	page = brd_lookup_page(brd, sector);
> +	if (!page && op_is_write(opf)) {
>  		/*
>  		 * Must use NOIO because we don't want to recurse back into the
>  		 * block or filesystem layers from page reclaim.
>  		 */
> -		err = brd_insert_page(brd, sector,
> -				(opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO);
> -		if (err) {
> -			if (err == -ENOMEM && (opf & REQ_NOWAIT))
> -				bio_wouldblock_error(bio);
> -			else
> -				bio_io_error(bio);
> -			return false;
> +		gfp_t gfp = (opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO;
> +
> +		rcu_read_unlock();
> +		page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
> +		if (!page) {
> +			err = -ENOMEM;
> +			goto out_error;
> +		}
> +		rcu_read_lock();
> +
> +		xa_lock(&brd->brd_pages);
> +		ret = __xa_store(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT,
> +				page, gfp);

On success, __xa_store() says it replaces the old entry ("ret"), with
your new entry ("page"). I think you want to store the new entry only if
there is no old entry, so shouldn't this instead be:

		ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT,
				   NULL, page, gfp);

?

> +		if (!ret)
> +			brd->brd_nr_pages++;
> +		xa_unlock(&brd->brd_pages);
> +
> +		if (ret) {
> +			__free_page(page);
> +			err = xa_err(ret);
> +			if (err < 0)
> +				goto out_error;
> +			page = ret;
>  		}

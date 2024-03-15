Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F434487AE
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527007; cv=none; b=r951yEUS5VTyasuP9QhzyddmKGje70+cfR9NCDKmBQQuWsja6c7tuvEOgVuWjR5iP5N8lqfC8K2P2pEwg53YqOEs5hKNxa5R+k1PchG3s1yv2HJQZPRtRwvk5016PRr/och3LrksyQJkA/LGoQjpE3pE0Rl665Lva8kMEvL8oB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527007; c=relaxed/simple;
	bh=lub1QRO2Lskgp8R2IQAkrUw5puAP1pp27pLk2YXuaQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbwWWpSOsm7jt6VKx+WuxhWjf38voDSNf/AKtqcBpeXbOzH5OU/B3EIEXG/ZdeJ7NJM3+PiO0O84OzIjAuMMeqkGTGZ6Jat+PHqmZnqClmbUqR2NrHXCbKfo4L3Dno2nKm2+prPWYgmc+GW/q5P7OHYowj00D7NWXIWR4Ohaed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMWNtBwH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMWNtBwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933DCC433F1;
	Fri, 15 Mar 2024 18:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710527007;
	bh=lub1QRO2Lskgp8R2IQAkrUw5puAP1pp27pLk2YXuaQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMWNtBwHk1gSxEjRF/dTgFBQDdEu+qVBSL/H52oG901jWq/DzDpmVLkYLESKaeDXd
	 Gz6erIQJaKZIW7mI7Oo8AT/CvV6VyKx+pn8L6v9yadIU87BgTsP5GhR08f+wg7jitm
	 +i1iqYvQRBWx11DNLJWPfss2hQZ/PC/BbXKwVgXj84swvHBdtxDBWg1RkFN5WAmJjK
	 SBCsmF5ywINK7j3kVbtamieGw2DzOKuL0g1ks92PdOx79A+RcPAbKBaCkeftqdyJqH
	 dvjViKROn5jcq5e+DOQuBijGNXtJqUPXnL44tlpfo7PeN3KbkDnKm/54QcMxUt4oow
	 VPeD0sn8irpuA==
Date: Fri, 15 Mar 2024 12:23:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] brd: Remove use of page->index
Message-ID: <ZfSSG3z0rQffkwGy@kbusch-mbp>
References: <20240315181212.2573753-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315181212.2573753-1-willy@infradead.org>

On Fri, Mar 15, 2024 at 06:12:09PM +0000, Matthew Wilcox (Oracle) wrote:
>  static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>  {
> -	pgoff_t idx;
> -	struct page *page;
> -
> -	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
> -	page = xa_load(&brd->brd_pages, idx);
> -
> -	BUG_ON(page && page->index != idx);
> -
> -	return page;
> +	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
>  }
>  
>  /*
> @@ -67,8 +56,8 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>   */
>  static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
>  {
> -	pgoff_t idx;
> -	struct page *page, *cur;
> +	pgoff_t idx = sector >> PAGE_SECTORS_SHIFT;
> +	struct page *page;
>  	int ret = 0;
>  
>  	page = brd_lookup_page(brd, sector);

This looks good. Unnecessary suggestion, but since you're already
changing these, might as well replace "sector" with "idx" here and skip
the duplicated shift in brd_lookup_page().

Reviewed-by: Keith Busch <kbusch@kernel.org>

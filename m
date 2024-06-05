Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2D15F321
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622537; cv=none; b=OSeBah0j/TNLsZWczKDpH+vlgrg9Sx0bbNKu5qdxNOw+vRCZy75wEJRzhVVQP2Ny9+lZoVmiOW4EjEPn9RQbxWfbuebN8AV3ZjmMXwk7aXEzwrs8JzcZn5dtdJo1dJNuARvnt9ihUEEaYZpdlSh+GSlELBkNOpcUOKq38aEFjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622537; c=relaxed/simple;
	bh=YFOqINnmT4zQEz1jA/7iIWsu3E0GtXhMYFevqvQmcIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N42ghc4LQgQGxM5uIpDVXW2bHyboR7FnkVOUn9PVOgKcIALy5Zwp1ug6H+tO69bvXqtg0gPI9IW+Aju7KTy9/PjCXEDpGOM/RBzfxH2zu87djO0aceKviBob2bl8DE2y/WMFW3St6kTmJfRxt85zDXE8RxsqguETwhsPb5Smi9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UqkkVLXN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UqkkVLXN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RBqjyCaN+PjUE3YnZPBzV7SnCg45JpFlSWlY1/nUM74=; b=UqkkVLXNYQXmJoanYgwqzSTVV0
	L+1gaACKBW77rpPooVFvDpW0y16R0SunhoDricJJHjU6g+QK4fFmytBxA80PrEjFmGDc2UOZ6Rq0y
	uWH+iZdfA6LY0bOgHR74FekxUTtWnBVfQhmsN+kzLJUSxQMaJI2Zr9NvDOKdp9rUpghE1EhtDG6eW
	DKNJEgh6Ku+FnuMqiS37kJLMcKFZdJGEdSLBmNcBg9ArAfUdqmtmFP1uiudUPZMMSVsmSamwKsPMr
	1pjUW9VrC5I2BY6qYLATzzrmrcx0/HdM/hFSN+vRB+pAcZ69HTUmGqft1Mn3L9AATtScYs1zYThxt
	a7B0uiJA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEy5D-00000004SrP-3Iua;
	Wed, 05 Jun 2024 21:22:11 +0000
Date: Wed, 5 Jun 2024 22:22:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 2/2] block: unpin user pages belonging to a folio
Message-ID: <ZmDXAxGm01XayBSn@casper.infradead.org>
References: <20240605092455.20435-1-kundan.kumar@samsung.com>
 <CGME20240605093234epcas5p151b3b39b2f2e1567c6e4ceae6130c6b9@epcas5p1.samsung.com>
 <20240605092455.20435-3-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605092455.20435-3-kundan.kumar@samsung.com>

On Wed, Jun 05, 2024 at 02:54:55PM +0530, Kundan Kumar wrote:
> -		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> -		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
> -			   fi.offset / PAGE_SIZE + 1;
> -		do {
> -			bio_release_page(bio, page++);
> -		} while (--nr_pages != 0);
> +		bio_release_page(bio, &fi.folio->page);
>  	}

Why can't we have ...

		bio_release_folio(bio, fi.folio, nr_pages);

which is implemented as:

static inline void bio_release_page(struct bio *bio, struct folio *folio, unsigned long nr_pages)
{
	if (bio_flagged(bio, BIO_PAGE_PINNED))
		gup_put_folio(folio, nr_pages, FOLL_PIN);
}

Sure, we'd need to make gup_put_folio() unstatic, but this seems far
more sensible.


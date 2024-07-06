Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224966AC0
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253428; cv=none; b=QPYz59F94KnjgD4iaVh0HQ6uBntW3AlNUcKJwjBkCBIqNtmVmlB62dR5+s1tk4rHUXC6LQEazE2PFg8znPpbCrYs94XarAPuNuV18+ebGy/GU8KEfmYuH4BzrUsICIg2p92VkXL0wXwePEBknFMcY25D+9LoI7kF7k7keaDiC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253428; c=relaxed/simple;
	bh=SLXkkAtJDUW/Q6frpXYrBjUO2i+qNxudz2Tg+4UJdTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVZJmmc9igsYk/7UsoFtBB/RwE5AY2PTdgvOToowaFMOVIXSvKlrhIvDRlu5fT2N9FLfx4ArTLabjuinJOKm3fAS/Ap72jKb/FrYf5FdPMvn0yH+3+ufhIkQaGuHbgm1eKusFpLv2XEueYh/u/ao+S+e5GcS4lttYwIHfsmfhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 180C668AA6; Sat,  6 Jul 2024 10:10:21 +0200 (CEST)
Date: Sat, 6 Jul 2024 10:10:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v7 4/4] block: unpin user pages belonging to a folio at
 once
Message-ID: <20240706081021.GB15556@lst.de>
References: <20240704070357.1993-1-kundan.kumar@samsung.com> <CGME20240704071134epcas5p2ec6160369e9092de98a051e05750bd4f@epcas5p2.samsung.com> <20240704070357.1993-5-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704070357.1993-5-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
>  			   fi.offset / PAGE_SIZE + 1;
> +		bio_release_folio(bio, fi.folio, nr_pages);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(__bio_release_pages);
> diff --git a/block/blk.h b/block/blk.h
> index 0c8857fe4079..18520b05c6ce 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -548,6 +548,13 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
>  		unpin_user_page(page);
>  }
>  
> +static inline void bio_release_folio(struct bio *bio, struct folio *folio,
> +				     unsigned long npages)
> +{
> +	if (bio_flagged(bio, BIO_PAGE_PINNED))
> +		unpin_user_folio(folio, npages);
> +}

This is only used in __bio_release_pages, and given that
__bio_release_pages is only called when BIO_PAGE_PINNED is set there
is no need to check it inside the loop again.

Also this means we know the loop doesn't do anything if mark_dirty is
false, which is another trivial check that can move into
bio_release_pages.  As this optimization already applies as-is I'll
send a prep patch for it.

so that we can avoid the npages calculation for the !BIO_PAGE_PINNED
case.  Morover having the BIO_PAGE_PINNED knowledge there means we
can skip the entire loop for !BIO_PAGE_PINNED && 

> +/**
> + * unpin_user_folio() - release pages of a folio
> + * @folio:  pointer to folio to be released
> + * @npages: number of pages of same folio
> + *
> + * Release npages of the folio
> + */
> +void unpin_user_folio(struct folio *folio, unsigned long npages)
> +{
> +	gup_put_folio(folio, npages, FOLL_PIN);
> +}
> +EXPORT_SYMBOL(unpin_user_folio);

Please don't hide a new MM API inside a block patch, but split it out
with a mm prefix.


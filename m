Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4927462
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754836281; cv=none; b=biza5q0gOYPWBsI2v8LflDPN9Gg14MdREJUqoBu0txQ65QgezkZ5H8C1eerpuY8OlvfxlOxtpd9orQvEASJZaGakX5hlKWnVXnQsV4BDZ1C9ajzBGSawb7FLFE0LP5T+z3vGek2Y1A4Q1OX2SNrL31OIwn0QWhHs0lK7OhdOUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754836281; c=relaxed/simple;
	bh=YpQP11Aat9V89c4cN9GxPMRquH21hnVnI1YUk1SVhp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1AjEb6yGWHXYTytlXO0s0Y8TdlLDnfijm2K3vU8zIg009p8WN0lCdPgan8EHAxSca61zeoTnsxpj8ARFOR7Wh2hrzEAhWIFIEnn5PoR2I0Zxt09FIbiyQjpG1D/YOydSX21+PM7njZfIt79qy5QytZLNmZ9LIPKaoXyHwKy2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F0A0968BEB; Sun, 10 Aug 2025 16:31:12 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:31:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250810143112.GA4860@lst.de>
References: <20250805195608.2379107-1-kbusch@meta.com> <20250806145621.GC20102@lst.de> <aJN4b6GS30eJdQLd@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJN4b6GS30eJdQLd@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 06, 2025 at 09:44:47AM -0600, Keith Busch wrote:
> On Wed, Aug 06, 2025 at 04:56:21PM +0200, Christoph Hellwig wrote:
> > > index 0a29b20939d17..d0ed28d40fe02 100644
> > > --- a/include/linux/blk_types.h
> > > +++ b/include/linux/blk_types.h
> > > @@ -264,6 +264,8 @@ struct bio {
> > >  
> > >  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
> > >  
> > > +	unsigned int		page_gaps;	/* a mask of all the vector gaps */
> > 
> > Bloating the bio for the gaps, especially as the bio is otherwise not
> > built to hardware limits at all seems like an odd tradeoff.
> 
> Maybe, but I don't have anywhere else to put this. We split the bio to
> its hardware limits at some point, which is where this field gets
> initially set.

What we do for nr_segs is to just do it on stack while splitting,
and then only record it in the request.  I think you could do the same
here, i.e. replace the nr_segs output parameter to __bio_split_to_limits
and it's helpers with a new struct bio_split_info that in the first
version just contains nr_segs, but can be extended to other easily
derived information like the page gaps.


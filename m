Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DC21B19D
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795558; cv=none; b=qEI+YGtA2P3f7lffbWdMjbM8CVay7OA+1amf4Bd5h/Z2mRU04usFCXIfy5SmOYfj9doRuMmmYgFxyKD912Fynrb5xCIXqxSGTpqdS16qTCH9JCuIZQT0fg2LxoEDD1nCKR0rBr5Zy1h0I5Qv7xa4F6VxZ05vo+DUIXLMc6X0Lco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795558; c=relaxed/simple;
	bh=MxwJ4bP2WzkpvhDCjuM6IeAF8Dfkuer80o5JpD0QNfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5WCCgARGYfjJIKcNZDX8r34gNdrPxvRozuQOHenxINwaBfwKK2JZGzrIcSb5DoIBIOUhaS07r0l0xdQTu7GaR66u/WtPaxACOtogwUbzZTLhZdLHMnvJKZ9GsGszXYM7Os+Kl+/2Q7NaqzMR7pHUX41Ta0BiYehNXGgeICal8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4D7C68CFE; Fri, 13 Jun 2025 08:19:12 +0200 (CEST)
Date: Fri, 13 Jun 2025 08:19:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20250613061912.GA9517@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <CGME20250610050728epcas5p343c293cd81ffb03b6f12dabfcf2fd8d4@epcas5p3.samsung.com> <20250610050713.2046316-2-hch@lst.de> <c75ac878-376e-497b-b4fe-ddd54733c090@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75ac878-376e-497b-b4fe-ddd54733c090@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 12, 2025 at 11:54:21AM +0530, Kanchan Joshi wrote:
> On 6/10/2025 10:36 AM, Christoph Hellwig wrote:
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -930,8 +930,6 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
> >   		return false;
> >   	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
> >   		return false;
> > -	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
> > -		return false;
> 
> I did not understand the value of moving this out to its two callers 
> (bio_add_page and bio_integrity_add_page).
> 
> Since this check existed, I am a bit confused. The thing that patch 
> title says - is not a new addition and used to happen earlier too?
> Or is this about setting REQ_NOMERGE in bio?

It is about not merging mismatch pgmaps into a bio, for which it needs
to be in the caller.  The current code only prevents merges into the
same bio_vec.

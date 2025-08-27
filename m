Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41994278771
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280237; cv=none; b=hJiNcliznH7T58gvRxMUZaNbhMw6BLLaUPk1z7HUHMBp4y/opqkpHxD6gBvcbiW22B/TxrVAO0BxD0uXdKeNdTo6QZCQYXCq1UQtlXCqU0r5cqvgxBDQ81fCL5Sek4Dc08mAS9HOG63G51YfhiKgRh1htMahYRc/7L/eTp7QBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280237; c=relaxed/simple;
	bh=GW4ytYy9cRjvbMsUTK4HxjuMCsvKeixLpvhkwZ26nyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dxi0+AH71H0a6YFTWjJxJlgJ8o7l9G+sO3Jhkj6VtCaxOWkY0WfuFH2K2tNZ4S/qU/avXqYOO0ckkTnAEHSWy+6YyvJcT0erSMPGCBKUis/b6Yq/AA63pG/y735yfaaGUwIRayrzO8a3BFn9n440CADAgaPWbIYA3arowLBqEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DEE268AA6; Wed, 27 Aug 2025 09:37:10 +0200 (CEST)
Date: Wed, 27 Aug 2025 09:37:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250827073709.GA25032@lst.de>
References: <20250821204420.2267923-1-kbusch@meta.com> <20250821204420.2267923-2-kbusch@meta.com> <aKxpSorluMXgOFEI@infradead.org> <aKxu83upEBhf5gT7@kbusch-mbp> <20250826130344.GA32739@lst.de> <aK27AhpcQOWADLO8@kbusch-mbp> <20250826135734.GA4532@lst.de> <aK42K_-gHrOQsNyv@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK42K_-gHrOQsNyv@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 26, 2025 at 04:33:15PM -0600, Keith Busch wrote:
> On Tue, Aug 26, 2025 at 03:57:34PM +0200, Christoph Hellwig wrote:
> > On Tue, Aug 26, 2025 at 07:47:46AM -0600, Keith Busch wrote:
> > > Currently, the virtual boundary is always compared to bv_offset, which
> > > is a page offset. If the virtual boundary is larger than a page, then we
> > > need something like "page_to_phys(bv.bv_page) + bv.bv_offset" every
> > > place we need to check against the virt boundary.
> > 
> > bv_offset is only guaranteed to be a page offset if your use
> > bio_for_each_segment(_all) or the low-level helpers implementing
> > it and not bio_for_each_bvec(_all) where it can be much larger
> > than PAGE_SIZE.
> 
> Yes, good point. So we'd have a folio offset when it's not a single
> page, but I don't think we want to special case large folios for every
> virt boundary check. It's looking like replace bvec's "page + offset"
> with phys addrs, yeah?!

Basically everything should be using physical address.  The page + offset
is just a weird and inefficient way to represent that and we really
need to get rid of it.

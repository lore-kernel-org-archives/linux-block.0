Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FDC20013A
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355120; cv=none; b=Vg/8wPoKHm2+/owu3uJVSrVcFnAeGeX7yBNgDzozn95v6y4JSMBywOrzKrocrn4b3VC1KSE9PIfNmrn9SIt1WLelskz+k/tHuEvg3Q6fItofYE163/Vnts6rs1u7ela2Ff08vKQgMbIRC4x2OqzxCpGf8vniQ0cZAdAImj8e5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355120; c=relaxed/simple;
	bh=5CXXQpkSVME5iBtO85wZ47sPUfr33FCoTLbhKV/yW6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSfYGvsxcevTxq6MK8YlxHF8wpsJJlRNG9bNLw89M94BY7BNt5GlboKT6ef7UY9Mj3EQ56a/rx88JaAE1frwnskSumoONmc0VAxya5AKxMIzO7xCemED1/SIgo5pR9aUR0lQI6yzOV/iAPwEdKPxD5vImVNuF8suqeed5fija6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1350967373; Wed, 10 Dec 2025 09:25:09 +0100 (CET)
Date: Wed, 10 Dec 2025 09:25:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, axboe@kernel.dk,
	Sebastian Ott <sebott@redhat.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] blk-mq-dma: always initialize dma state
Message-ID: <20251210082508.GA2638@lst.de>
References: <20251210064915.3196916-1-kbusch@meta.com> <20251210065407.GA650@lst.de> <aTkcEeRFPHuN8d9f@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTkcEeRFPHuN8d9f@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 10, 2025 at 04:06:57PM +0900, Keith Busch wrote:
> On Wed, Dec 10, 2025 at 07:54:07AM +0100, Christoph Hellwig wrote:
> > On Tue, Dec 09, 2025 at 10:49:15PM -0800, Keith Busch wrote:
> > > -	if (blk_can_dma_map_iova(req, dma_dev) &&
> > > -	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
> > > +	if (!blk_can_dma_map_iova(req, dma_dev))
> > > +		memset(state, 0, sizeof(*state));
> > > +	else if (dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
> > >  		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
> > 
> > What about just doing the memset unconditionally?  It's just two
> > 64-bit fields so no real overhead, and it gives us a clean slate that
> > avoid introducing other bugs later on.
> 
> I didn't do that is because dma_iova_try_alloc() also does that, so it'd
> be two repeated and unnecessary memset's on the same address. That feels
> undesirable no matter how small the struct is. I could remove the memset
> in dma_iova_try_alloc instead and make the caller initialize it. There
> are only two existing users of the API, so not a big deal to change it.

If we move it out we'll need a separate dma_iova_init helper or similar
(which I think Leon had in earlier version before I optimized it away).
Personally I'd prefer to just zero twice, as it's really cheap.

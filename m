Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D982DF144;
	Wed, 15 Oct 2025 04:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501932; cv=none; b=sd3MBoJuZLyV5K2Kfzei7TmlmVm68IzQVqKSTOCH7yHP5NStAUc2XGeeD0qT3Lc4iqA4HOsbVd9r2d8oRcs39C1Hehsz80ze65tdH1vkFOG1jgV8Jcz+CqCGq6/EuUeiF0ahLNT4v1JkwH/MMRLtP6b2IB3KD72vBZ4rKMC4lYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501932; c=relaxed/simple;
	bh=tiHIFeXoZvycKmukPNFj8nn2Ei164RZZGxk+2t2YVWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgo18pqJ41T5PkCorEgHWKHP3oWMpBQYDcQ49dOkou6DjOA9rvvtnYBz5/6LLZLtXmF7ZMqlg4AbFSLmEzMpcFMZ0d459v97whkAMBuyZIalfUSLAO7mXiF1/XXMaMYjfdr3kgNoOPSyLln05svNqRjqab95ZXGVdQYJ+UmZ8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F114227A87; Wed, 15 Oct 2025 06:18:46 +0200 (CEST)
Date: Wed, 15 Oct 2025 06:18:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] block-dma: properly take MMIO path
Message-ID: <20251015041846.GB7073@lst.de>
References: <cover.1760369219.git.leon@kernel.org> <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org> <aO1MfsuWeteOsBve@kbusch-mbp> <20251013192940.GC14552@unreal> <aO1URj3B3IUHX4Ge@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO1URj3B3IUHX4Ge@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 13, 2025 at 01:34:30PM -0600, Keith Busch wrote:
> On Mon, Oct 13, 2025 at 10:29:40PM +0300, Leon Romanovsky wrote:
> > On Mon, Oct 13, 2025 at 01:01:18PM -0600, Keith Busch wrote:
> > > On Mon, Oct 13, 2025 at 06:34:11PM +0300, Leon Romanovsky wrote:
> > > >  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> > > >  		struct blk_dma_iter *iter, struct phys_vec *vec)
> > > >  {
> > > > +	unsigned int attrs = 0;
> > > > +
> > > > +	if (req->cmd_flags & REQ_MMIO)
> > > > +		attrs |= DMA_ATTR_MMIO;
> > > 
> > > Since data and integrity paylods use these same functions and may point
> > > to different kinds of memory, I think you'd have to pass the 'attrs'
> > > from the caller since it knows which flags to check for MMIO dma.
> > 
> > I think that hunk will fix it.
> > 
> > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > index 38f5c34ca223..8af88ba97c7a 100644
> > --- a/block/blk-mq-dma.c
> > +++ b/block/blk-mq-dma.c
> > @@ -88,9 +88,11 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
> >  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> >                 struct blk_dma_iter *iter, struct phys_vec *vec)
> >  {
> > +       struct bio_integrity_payload *bip = bio_integrity(req->bio);
> >         unsigned int attrs = 0;
> > 
> > -       if (req->cmd_flags & REQ_MMIO)
> > +       if ((!bip && req->cmd_flags & REQ_MMIO) ||
> > +           bio_integrity_flagged(req->bio, BIP_MMIO))
> >                 attrs |= DMA_ATTR_MMIO;
> 
> If cmd_flags has REQ_MMIO set, but the integrity flag doesn't have
> BIP_MMIO set, you will skip setting DMA_ATTR_MMIO, but I think we need
> that set when this is called for the data payload.

Yes, we just need to check the relevant flag in the caller
and pass it in.  Or maybe just stash it in  struct blk_dma_iter.

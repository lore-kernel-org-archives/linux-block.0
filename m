Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CF2DF710;
	Mon, 27 Oct 2025 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551863; cv=none; b=XAqMyNusMG7H+vMCNnZvaz0GpkbLR2PYv0fm7K8452jzlRJA4dUtsqBml+eHcgnADfSF04Gj5cS3R1PzzKcVb2MT/HzN7K2gFvwnCmg+FEX24329P5NNjs+43VntbZaywub3Aj2HbZNI40fvbEVRmGSN1z1zEO7JekQOdfSzSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551863; c=relaxed/simple;
	bh=8Pzj6eA9ly1d9tF2fE60ZmbtYhCY2uo2nMNhehrxgU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4mx48TrppvAovWCZl77jmKIfQM8JSqjJkJYWeGLedpAy/9RNgJYUv94cJk6s1crB4bwz6HLhTQzIC/MDjraKd8OVj+IC17pqKG9KCa17ujFFBX42NaxhxVcy3ZrNT9Ppq4is6TOOsxg2aQvzud50dYKU9XsCSbjOuAjvPjybUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L45dkNDw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L45dkNDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241B2C4CEF1;
	Mon, 27 Oct 2025 07:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761551862;
	bh=8Pzj6eA9ly1d9tF2fE60ZmbtYhCY2uo2nMNhehrxgU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L45dkNDwCYLNVZuROPPeyuyrbaHkF+rrcv+Ur7i9rMIcU1hAfa2zdIct0wI3pBqMl
	 puWpEVZlrrS4mR8znz14FAVUm48cnR6V1G8G01dkVbNuUOoKYgNawswkU5pYBVXqJn
	 wpKBQWEdypZif8+OpOZtVEY/NO818uQ7+lZk+HLx/Q6CGGSsZaDCGav9v7gGrpXMsi
	 VZcRA7Z7+26gENuPg6m4sDky34TTmT9Cu/l9YWHKwlUMHetim/xs6VLjQNXVo9YxzS
	 +n7zIP2i/OKTftSNi03L0u9zkMoomzJAE8LZdskrUOW7RVJERP6tzsZoRc7rr2HONV
	 xdeGHnv3taAog==
Date: Mon, 27 Oct 2025 09:57:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251027075738.GF12554@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <20251027074922.GA14543@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027074922.GA14543@lst.de>

On Mon, Oct 27, 2025 at 08:49:22AM +0100, Christoph Hellwig wrote:
> > +	switch (iter.p2pdma.map) {
> > +	case PCI_P2PDMA_MAP_BUS_ADDR:
> > +		iod->flags |= IOD_DATA_P2P;
> > +		break;
> > +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> > +		iod->flags |= IOD_DATA_MMIO;
> > +		break;
> > +	default:
> > +		return BLK_STS_RESOURCE;
> 
> I almost wonder if we should just the pci_p2pdma_map_type values into
> place.  But that's a future cleanup, I'd rather get this going now.

I thought about it, but decided to use flags as more space efficient.
PCI_P2PDMA_MAP_BUS_ADDR == 3 and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE == 4.
It means that will need to occupy 6 bits (extra u8 IOD field), while
this flags encoding takes only 4 bits (without extra IOD field).

> 
> > +static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
> > +		struct dma_iova_state *state, size_t mapped_len,
> > +		enum pci_p2pdma_map_type map)
> >  {
> > -	if (is_p2p)
> > +	if (map == PCI_P2PDMA_MAP_BUS_ADDR)
> >  		return true;
> >  
> >  	if (dma_use_iova(state)) {
> > +		unsigned int attrs = 0;
> > +
> > +		if (map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
> > +			attrs |= DMA_ATTR_MMIO;
> > +
> >  		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
> > -				 0);
> > +				 attrs);
> 
> The only thing in req that is used now is the data directrion.  I'd be
> almost tempted to just pass that and lift this to dma-mapping.h.
> 
> But I guess we could just do that in a follow on to not drag in
> another subsystem.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks

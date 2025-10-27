Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC622A4D5;
	Mon, 27 Oct 2025 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551370; cv=none; b=KpT8AiGs7EsooYk4qMcKVZ/ECPsLA+vlYfvVUj5cazYKfSmnrs7y3D30HvHUi2fQQQKX6U8f377dFLhht/TIwvrvzoYKhhqM9C38Y9OEExQdP7R27WnCi0LK/l32tckLNhCdsQFTG15hXY339JF0Z5KdNdvG1//q5XEiq36INXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551370; c=relaxed/simple;
	bh=IUDHLFdSW98VMmhJnfTZEpaoUm58u9sqZ9xYIWyIEWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfH5BPDHwgSFMuaS2+XdAmn/f2Sdr45KbLu7/8JAZVa6bCZxbrjdnj0ZqnbhenQqunCaKCDnf/9GmFMe+aoQkPE2Td3STGCay3RZGQwb05fCid6gp3pJE0y18nmWzITYOnomZqqwhAp08qHoWGfLSKlEddcwZGD2PjpmrqCvBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 62E1D227A87; Mon, 27 Oct 2025 08:49:23 +0100 (CET)
Date: Mon, 27 Oct 2025 08:49:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251027074922.GA14543@lst.de>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com> <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	switch (iter.p2pdma.map) {
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		iod->flags |= IOD_DATA_P2P;
> +		break;
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		iod->flags |= IOD_DATA_MMIO;
> +		break;
> +	default:
> +		return BLK_STS_RESOURCE;

I almost wonder if we should just the pci_p2pdma_map_type values into
place.  But that's a future cleanup, I'd rather get this going now.

> +static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
> +		struct dma_iova_state *state, size_t mapped_len,
> +		enum pci_p2pdma_map_type map)
>  {
> -	if (is_p2p)
> +	if (map == PCI_P2PDMA_MAP_BUS_ADDR)
>  		return true;
>  
>  	if (dma_use_iova(state)) {
> +		unsigned int attrs = 0;
> +
> +		if (map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
> +			attrs |= DMA_ATTR_MMIO;
> +
>  		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
> -				 0);
> +				 attrs);

The only thing in req that is used now is the data directrion.  I'd be
almost tempted to just pass that and lift this to dma-mapping.h.

But I guess we could just do that in a follow on to not drag in
another subsystem.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

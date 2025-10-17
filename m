Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F31630F556;
	Fri, 17 Oct 2025 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682325; cv=none; b=unTjg7TcoFcis/aAvYLrOXs1qNC4vZNpDSUeLgL629zckLA2dDYW5nUJIPTAOszQYD4hvMM+kCX++e4N4hoTtwt3fQsGQguiyhNY0t4xL8NOv1+Hdbdg195fiQxqmZ57ULGUern5GF0VItYVMrdiwfJz0tAWz37l3dXUi7Vp6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682325; c=relaxed/simple;
	bh=DjQDkCQhEluD8+ST9M+C04vAN/OQrSdiaH+oajzRRXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3nV7f+qCwq5BOgkRC3Q2aR0J6RmcuccnBFoXch0jXXMsRVt1LDj8xSIN5DFdbx5VGzkXcdaH79GSbx9OFWj5O6W/bEWyuvng/SUo+qSlzB4y6Evb5LXd6OGse6QjK4Of9KzbN8D01tulK/uZ5MAsUxxN2xO92PbE3tM/BQx5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96FB4227A87; Fri, 17 Oct 2025 08:25:19 +0200 (CEST)
Date: Fri, 17 Oct 2025 08:25:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] block-dma: properly take MMIO path
Message-ID: <20251017062519.GC402@lst.de>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com> <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 17, 2025 at 08:32:00AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Make sure that CPU is not synced and IOMMU is configured to take
> MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.

Please write a commit log that explains this.  Where was DMA_ATTR_MMIO
recently introduced?  Why?  What does this actually fix or improve?

> @@ -184,6 +184,12 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
>  		 * P2P transfers through the host bridge are treated the
>  		 * same as non-P2P transfers below and during unmap.
>  		 */
> +		if (iter->iter.is_integrity)
> +			bio_integrity(req->bio)->bip_flags |= BIP_MMIO;
> +		else
> +			req->cmd_flags |= REQ_MMIO;
> +		iter->iter.attrs |= DMA_ATTR_MMIO;

REQ_MMIO / BIP_MMIO is not block layer state, but driver state resulting
from the dma mapping.  Reflecting it in block layer data structures
is not a good idea.  This is really something that just needs to be
communicated outward and recorded in the driver.  For nvme I suspect
two new flags in nvme_iod_flags would be the right place, assuming
we actually need it.  But do we need it?  If REQ_/BIP_P2PDMA is set,
these are always true.


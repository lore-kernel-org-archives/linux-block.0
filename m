Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35102EA17D;
	Wed, 22 Oct 2025 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114102; cv=none; b=Ha9RnnEeY1hq1z+F8cY/+xeFl2FGkD5yi5ToiwoqyYOiH7BTTZjtsbXgM5AP/SjgeyBzx2ngQ4HxuGQ/A/Ph/ekoTKOpbY7HT72XWZYjCTDBGEKXMYEzNqwmQUJ0mLGfyNo0r2kboVO2XNYihltSsJ/W2tX67cFcRknvOAn4yt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114102; c=relaxed/simple;
	bh=/rbjkxMQ8pz0+YOUj+1n2Nn/55zboinmjczNiZTonmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGs2LwJcHhLOtxl1OJCYJd1J8fB+1C+M0WCUZrLuoGSod8a4I6UGWyzUK8Olxje5Z+6V5MVJOUCJsoueQdO5wzKFTtTn3257dT0PQyWObypHZ6KOfgK7KxCePTX0uc3FtN0wXmMLiMGHmXDee/DtHx1Wu02vtIxK5s2wjiapxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E62DB227A88; Wed, 22 Oct 2025 08:21:35 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:21:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/2] block-dma: properly take MMIO path
Message-ID: <20251022062135.GD4317@lst.de>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com> <20251020-block-with-mmio-v2-2-147e9f93d8d4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-block-with-mmio-v2-2-147e9f93d8d4@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 20, 2025 at 08:00:21PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In commit eadaa8b255f3 ("dma-mapping: introduce new DMA attribute to
> indicate MMIO memory"), DMA_ATTR_MMIO attribute was added to describe
> MMIO addresses, which require to avoid any memory cache flushing, as
> an outcome of the discussion pointed in Link tag below.
> 
> In case of PCI_P2PDMA_MAP_THRU_HOST_BRIDGE transfer, blk-mq-dm logic
> treated this as regular page and relied on "struct page" DMA flow.
> That flow performs CPU cache flushing, which shouldn't be done here,
> and doesn't set IOMMU_MMIO flag in DMA-IOMMU case.
> 
> Link: https://lore.kernel.org/all/f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  block/blk-mq-dma.c            |  6 ++++--
>  drivers/nvme/host/pci.c       | 23 +++++++++++++++++++++--
>  include/linux/blk-integrity.h |  7 ++++---
>  include/linux/blk-mq-dma.h    | 11 +++++++----
>  4 files changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 4ba7b0323da4..3ede8022b41c 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -94,7 +94,7 @@ static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>  		struct blk_dma_iter *iter, struct phys_vec *vec)
>  {
>  	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
> -			rq_dma_dir(req), 0);
> +			rq_dma_dir(req), iter->attrs);
>  	if (dma_mapping_error(dma_dev, iter->addr)) {
>  		iter->status = BLK_STS_RESOURCE;
>  		return false;
> @@ -116,7 +116,7 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
>  
>  	do {
>  		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
> -				vec->len, dir, 0);
> +				vec->len, dir, iter->attrs);
>  		if (error)
>  			break;
>  		mapped += vec->len;
> @@ -184,6 +184,8 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
>  		 * P2P transfers through the host bridge are treated the
>  		 * same as non-P2P transfers below and during unmap.
>  		 */
> +		iter->attrs |= DMA_ATTR_MMIO;

DMA_ATTR_MMIO is the only flags in iter->attrs, and I can't see any other
DMA mapping flag that would fit here.  So I'd rather store the
enum pci_p2pdma_map_type here, which also removes the need for REQ_P2PDMA 
and BIP_P2P_DMA when propagating that to nvme.


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874F22DF9A
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651206; cv=none; b=MJu63rIoCp+/Jvz9YWW+XoQY/qsdg8nYTvR/n3p2+P+ExPTK/oGU39HivSOa9GnP4Z2KJ9vik1aihssOI4LTrjMzOyC1195Zjj1B2IQJsHrYYMjfTxCm7FTrrr0gsYwVBZTXbgo8BtqDCy7Nyubb0cjP6NcUPSQVIS5nPQYHNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651206; c=relaxed/simple;
	bh=g9ZqoAzVAgYCqLKjo26Nv7HuA3LavIx+D1Zfdwx4AmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSCBRHS4huRacX5KlscbM9V9RtJIYOXDZ26by8htltK40lRRsxcDcTLNNisyzy4+P1b4L7xLE1hf2Fap29Bbe/2Y4K9uOcr2nh2BjsyLAjk3sYWrX3RMv9rgOBUa+0OH/gl4WhJ7Urt4MPlDnoJoUHe+o9rxUDMN2cOHXOVNE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh4PB6DN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh4PB6DN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECDFC4CEE3;
	Wed, 11 Jun 2025 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749651205;
	bh=g9ZqoAzVAgYCqLKjo26Nv7HuA3LavIx+D1Zfdwx4AmQ=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fh4PB6DN00JmQKz/lac6hrUrtZvhOUXWR0/9zvjFFBk5Vay8mUnwEKugj2zz5MPUz
	 0j/TfGkirXtWz3g0N+uzhYETUi4rws5JtQGh8qcpfQ6r/3sxabxi7PMQIzIS9ONH7L
	 HoXdnW/5+6G68HsWb1DDx1Yyihyhm8cc2pUjqfdNuDSqkCKwawVkqSH2hSS+6FohjJ
	 jeiIRLxt+M4Yl3eIdj4boSsdOW6eJeYqelMVsv4IHkuQm7ZUBFooqf5gdbyTJD9RXY
	 QlR0Wn1ymn3XzOuWNefG9a9yBBLQ8miEQKN74OpNc2TKmbh5gGXgIRAAbrwTaAdz+B
	 8hASRyk58J6hQ==
Message-ID: <4bdeb522-42d4-460c-8812-7e0d8602cf8f@kernel.org>
Date: Wed, 11 Jun 2025 16:13:22 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2025 07.06, Christoph Hellwig wrote:
> Use the blk_rq_dma_map API to DMA map requests instead of scatterlists.
> This removes the need to allocate a scatterlist covering every segment,
> and thus the overall transfer length limit based on the scatterlist
> allocation.
> 
> Instead the DMA mapping is done by iterating the bio_vec chain in the
> request directly.  The unmap is handled differently depending on how
> we mapped:
> 
>  - when using an IOMMU only a single IOVA is used, and it is stored in
>    iova_state
>  - for direct mappings that don't use swiotlb and are cache coherent no
>    unmap is needed at all
>  - for direct mappings that are not cache coherent or use swiotlb, the
>    physical addresses are rebuild from the PRPs or SGL segments
> 
> The latter unfortunately adds a fair amount of code to the driver, but
> it is code not used in the fast path.
> 
> The conversion only covers the data mapping path, and still uses a
> scatterlist for the multi-segment metadata case.  I plan to convert that
> as soon as we have good test coverage for the multi-segment metadata
> path.
> 
> Thanks to Chaitanya Kulkarni for an initial attempt at a new DMA API
> conversion for nvme-pci, Kanchan Joshi for bringing back the single
> segment optimization, Leon Romanovsky for shepherding this through a
> gazillion rebases and Nitesh Shetty for various improvements.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 388 +++++++++++++++++++++++++---------------
>  1 file changed, 242 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 04461efb6d27..2d3573293d0c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
...
> @@ -2908,26 +3018,14 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
>  static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)

Since this pool is now used exclusively for metadata, it makes sense to update
the function name accordingly:

static int nvme_pci_alloc_iod_meta_mempool(struct nvme_dev *dev)

>  {
>  	size_t meta_size = sizeof(struct scatterlist) * (NVME_MAX_META_SEGS + 1);
> -	size_t alloc_size = sizeof(struct scatterlist) * NVME_MAX_SEGS;
> -
> -	dev->iod_mempool = mempool_create_node(1,
> -			mempool_kmalloc, mempool_kfree,
> -			(void *)alloc_size, GFP_KERNEL,
> -			dev_to_node(dev->dev));
> -	if (!dev->iod_mempool)
> -		return -ENOMEM;
>  
>  	dev->iod_meta_mempool = mempool_create_node(1,
>  			mempool_kmalloc, mempool_kfree,
>  			(void *)meta_size, GFP_KERNEL,
>  			dev_to_node(dev->dev));
>  	if (!dev->iod_meta_mempool)
> -		goto free;
> -
> +		return -ENOMEM;
>  	return 0;
> -free:
> -	mempool_destroy(dev->iod_mempool);
> -	return -ENOMEM;
>  }
>  
>  static void nvme_free_tagset(struct nvme_dev *dev)

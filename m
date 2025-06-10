Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5D18D643
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561578; cv=none; b=fZhN+kC4HaszaNbunN2085FMBthIu4wmzQ/Ch56ooAi/OtwjTpDFRJw/FaCrpOHWq/Wll1NqlAnZbJhWoMjHFxjSjog+0pwbV5/AVDKHaWijpoWr2qM7UaJ1Mc/O2F0Fsf0uNCqjXdh58bMuprGA0+salEZVHBiKsEwyM3GlEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561578; c=relaxed/simple;
	bh=ExmpJqdt8Nx9vpB3PyBR9XWBoIYWiy6bz8HbtpMRh+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXaaFJDxXMpc2LZ0QesAqia+67FakG9JlX8Nem+eDcglGSG2ggvaR+aBM/naWWaIB6Y8OzIxmgmtv8WoB6sUNhq45dlmujIJ3b8+R69l/FSY05gALMZT0rfqw0GL16gC/YKld2gl/+OHVnKODxLuJ89FvpBSX+wSUOkV8g1/Y74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqOfg63H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqOfg63H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A14CC4CEEF;
	Tue, 10 Jun 2025 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561575;
	bh=ExmpJqdt8Nx9vpB3PyBR9XWBoIYWiy6bz8HbtpMRh+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqOfg63HR/s/tuogH6KHzMOtRRVp4rQn2r2Wuur5YJc/Y7FVtOt6zn4qq6Aal05g0
	 ofBAkt/N0MUH7B7mfRr0XY1NiJ7fPi2ywLGNfMWmc6QuasNis1KlbDVpk52asx0wws
	 7UMRYLIFrxW7EgnWPem7OOvyF0PBdXl8v6hRLzn3cR/ZLwIzEU3qt6a3WLUcOgPLM+
	 XoOr1xwrCx2cTJMZZ7oXEIDULH+Pl1QAsQkOyfel0mLUbAgrYxlSbUuoux9GcBRhAb
	 sT/UK4oeTPVy2dxIS9e5aU8ROYgn/4krBdD8ejnNn7EGOMsEeFFU8IzNVivBPYrPV8
	 EHSf6t63o22xg==
Date: Tue, 10 Jun 2025 16:19:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <20250610131929.GI10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-8-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:45AM +0200, Christoph Hellwig wrote:
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
>    unmap is needed at al

s/unmap is needed/unmap is not needed

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

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

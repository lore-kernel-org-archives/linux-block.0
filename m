Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0A1397;
	Wed, 12 Nov 2025 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977615; cv=none; b=XeWOUAzXhzdbYyH5jsblHAYRYMJa1MY5Ww/aHssCm1WZl7wECtQ+VHZfvvjFTTSJteOK8/2xr2RmOG8NVBFL70rQzQK0swX2Ch3lQ7eeePHNnzsBQQ1tOtl7ftwfC21KARsgvRUZWIrB0HLRdg4HpILmFNX47MWC2JV+iiNdkjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977615; c=relaxed/simple;
	bh=4fG9Ur91w+X52ehK5y6ywRwOWBbDk4C2OU5cqPLS6qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pyvbu2UMCnmtrzZxPUQVhEWDhKDqoSkAtPRUlRh7snPIGK3KdLTK5M82uwFiALk54Q265qsriJElNgkedRMu+a/yCXO/vonE5Scszy2UHQRcAYlR9u9Yv7aVDDKtTkXxmMdlXOWQrbhOVh0c98EeRSJuSntDoW7tcER7hWXUM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz3RlSFM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz3RlSFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE71C4CEF1;
	Wed, 12 Nov 2025 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762977614;
	bh=4fG9Ur91w+X52ehK5y6ywRwOWBbDk4C2OU5cqPLS6qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cz3RlSFMzfhxAjnIGbWv6+VutJ1mc8y0R0OXJZ+AiCE5iK8k648cSq58T9fF/+xAr
	 cp41t0ixxleQGV6wz07fHZUH5XthX8cT5FIreElVIvx3fXFes6rGuvyiohaGxrkixC
	 CZpcKIO23sCzbzsLgnNitJwl2qRuu0pBgr1zoMuIhIGDduYNqhbpT6rfePMRw1OTMa
	 1WMFH2O8yXnR5peGoB7NXQEMJsmLJrSrvk5wKgahhab3dq7UenZNpQGjDSCYcEhsMH
	 ElaHtdQxArigqBrZPUDIoXMnFbapGFJLHYnVOCZWDNgfnpR+GOhyuDB3cO+mdkpehD
	 dDbaybw44Mcmw==
Date: Wed, 12 Nov 2025 15:00:11 -0500
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 2/2] block-dma: properly take MMIO path
Message-ID: <aRTnS1NZ0yEL0pJl@kbusch-mbp>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <20251112-block-with-mmio-v4-2-54aeb609d28d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-block-with-mmio-v4-2-54aeb609d28d@nvidia.com>

On Wed, Nov 12, 2025 at 09:48:05PM +0200, Leon Romanovsky wrote:
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
> As a solution, let's encode peer-to-peer transaction type in NVMe IOD
> flags variable and provide it to blk-mq-dma API.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449621A447;
	Wed, 15 Oct 2025 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510656; cv=none; b=PAWpH3cOZZVRJn4qz21QnKMZne1a1twDPy5K5+K2UC4yeG+kjF70YWYBisAM7AJdEvL+auSthnwZt5zBATm2p74gJ9WJ7I9w3QDjBIgIBfVDfNywYWriRIgyURdp0jQi0R2eGBO9pSYeJFyVvBNct9k+J7vlC3BL+4YARsfxhPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510656; c=relaxed/simple;
	bh=Ng/TpONxqJIcYfHCXWiNhUnJ8g9KU2/KbXEEA1wmwyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnkTRj0ufxxT511rvoefE21b9wUmpXPdn+TzJNSKZUgZ4XOFt5Cv5w6ghVodn1f9yZ2XdjrFwqmAAZIAjGogpbGmYnK5ZC5xjei5Z8JKhUmOehzLtP+SSx55sOtsMjdFQ9rtzQTows4gIICiIFg38KDTJv615iaJQyDRKlL2Q84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0xFHOo/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0xFHOo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A47FC4CEF8;
	Wed, 15 Oct 2025 06:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760510655;
	bh=Ng/TpONxqJIcYfHCXWiNhUnJ8g9KU2/KbXEEA1wmwyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0xFHOo/AodCLJYuRhRDGNzyP0paUpB7BlbhboayGDkqaPpBf2LUvibc9K3xiWAsg
	 nZU8URiUNXMeQpHnVJ+BIygtX0nOCdJcZHhOSYHXr1vrLYkvM+/ZAF9qVHpsK/Ty7+
	 cV331e+Xpi92a4efrSS3XoxTq5XD8shJWnm1cQRl/hyUIgQCfV4QDsZKVB36cO60U4
	 r1GZFJjGj2E90EF36n3p+J2zO+oATDtSXGIeLCyc8Tl846NMAawQ0j1WHBzQeOoQM6
	 zAS8LLHydG0A2Xp0dqQA9TlmBmd/ZNoj3o994bLTsx8M0Y5tNneBcJmpSgnPKMjieE
	 OOl6e2KdPSqKg==
Date: Wed, 15 Oct 2025 09:44:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/4] nvme-pci: unmap MMIO pages with appropriate interface
Message-ID: <20251015064411.GA6393@unreal>
References: <cover.1760369219.git.leon@kernel.org>
 <6522567376d50f71425ccc4950552fca48e4f57f.1760369219.git.leon@kernel.org>
 <20251015042053.GC7073@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015042053.GC7073@lst.de>

On Wed, Oct 15, 2025 at 06:20:53AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 13, 2025 at 06:34:12PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Block layer maps MMIO memory through dma_map_phys() interface
> > with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> > that memory with the appropriate unmap function, something which
> > wasn't possible before adding new REQ attribute to block layer in
> > previous patch.
> 
> This should go into the same patch that switches to dma_map_phys.

I don't think so, dma_map_phys() patch [1] doesn't change any behavior
and dma_map_page() is equal to dma_map_phys(... , attr = 0),

> Unless I'm missing something it also misses passing the flag for
> the metadata mapping.

Yes, I didn't realize that same request can have both metadata and data
payloads.

> 
> Btw, where is all this going?  Are you trying to remove the auto
> detection of P2P in the low-level dma mapping routines?  If so that
> should probably go into at very least the cover lttter, but probably also
> the commit logs.

It is an outcome of multiple things:
1. We missed setting of IOMMU_MMIO flag in dma-iommu.c flow for p2p pages
and for that we need some external indication as memory type is already
known to the callers.
2. Robin expressed concerns about overloading DMA_ATTR_SKIP_CPU_SYNC.

[1] https://lore.kernel.org/all/a40705f38a9f3c757f30228b9b848ce0a87cbcdd.1760369219.git.leon@kernel.org/
[2] https://lore.kernel.org/all/751e7ece-8640-4653-b308-96da6731b8e7@arm.com/

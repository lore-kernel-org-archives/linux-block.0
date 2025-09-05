Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC90306B3D;
	Fri,  5 Sep 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091058; cv=none; b=in2Jjf5hDGgJ5BtBNl2mgSh3gmXfY3BlT8huNcPsfroXpNesqCYSULXqBPUfLr4M6t/UnTUsYhpYTgrJHBFRA9dtXRtOp/tqsNp2mtAlK6hOwVxTxdoGCJls62/X8eUxze5FGsPObOJHzI3p/ioNLB11q7dt5Gy5KNwAqqhZpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091058; c=relaxed/simple;
	bh=ed7tjh37WUsiWKbFsXU4Fz4LWP9OYuSxI0T6PtehL5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF0IRiuy/yeYx6gLhj0ZJLHuFQusxejUghJ3ONvhsEGAJeUz0ZlwsWzGUkQ1b8hzrERb654vfk+fwH4oSxy7tgslFMiGX0hXnumqRuUqN3/Qqx3JCcBj+gQGG2V9Lg6RaK2QBBSYrdqWGdMTc9aISJHXl+zHlQ1TFczWt+RLdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hkj6jwvL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hkj6jwvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291F0C4CEF1;
	Fri,  5 Sep 2025 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757091058;
	bh=ed7tjh37WUsiWKbFsXU4Fz4LWP9OYuSxI0T6PtehL5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hkj6jwvLxKggBm5BaYRmXNHFJSTzS4j//v2v297B9zbvAb6zaXk3ye+d7kJpzYt+i
	 pVjGPf+glYmCMY8ZXxKqFzfErZn5vYpuxstgE5z7K6bWjnB52Zu2pWhWX8YpcE0TZ3
	 wqpQ/atJ+vA0oyDRUVNRdo8I0NXlm4wfllQDaEaUhi9U9aEo4xqnHh2mcEuBjTyxog
	 A1t4vtOjJmcxMXWsrEs0iDeQq9drkmd4Whjs7cSHTOvVKn09EIzsL7m+VCMmXlxsZx
	 LFVA53bS5HpTQKBuuE67ybcB5j6vm/3A//si20RgKUC4Z6Fe/u+7Z/FKOCjsOXLxSF
	 Mdr++eBA7BRQw==
Date: Fri, 5 Sep 2025 19:50:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	David Hildenbrand <david@redhat.com>, iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>, kasan-dev@googlegroups.com,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v5 07/16] dma-mapping: convert dma_direct_*map_page to be
 phys_addr_t based
Message-ID: <20250905165051.GA25881@unreal>
References: <cover.1756822782.git.leon@kernel.org>
 <CGME20250902144935eucas1p253de9e94315de54325cc61dea9c76490@eucas1p2.samsung.com>
 <6b2f4cb436c98d6342db69e965a5621707b9711f.1756822782.git.leon@kernel.org>
 <087e7f3d-1e0d-4efe-822f-72d16d161a60@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087e7f3d-1e0d-4efe-822f-72d16d161a60@samsung.com>

On Fri, Sep 05, 2025 at 06:21:44PM +0200, Marek Szyprowski wrote:
> On 02.09.2025 16:48, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Convert the DMA direct mapping functions to accept physical addresses
> > directly instead of page+offset parameters. The functions were already
> > operating on physical addresses internally, so this change eliminates
> > the redundant page-to-physical conversion at the API boundary.
> >
> > The functions dma_direct_map_page() and dma_direct_unmap_page() are
> > renamed to dma_direct_map_phys() and dma_direct_unmap_phys() respectively,
> > with their calling convention changed from (struct page *page,
> > unsigned long offset) to (phys_addr_t phys).
> >
> > Architecture-specific functions arch_dma_map_page_direct() and
> > arch_dma_unmap_page_direct() are similarly renamed to
> > arch_dma_map_phys_direct() and arch_dma_unmap_phys_direct().
> >
> > The is_pci_p2pdma_page() checks are replaced with DMA_ATTR_MMIO checks
> > to allow integration with dma_direct_map_resource and dma_direct_map_phys()
> > is extended to support MMIO path either.
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   arch/powerpc/kernel/dma-iommu.c |  4 +--
> >   include/linux/dma-map-ops.h     |  8 ++---
> >   kernel/dma/direct.c             |  6 ++--
> >   kernel/dma/direct.h             | 57 +++++++++++++++++++++------------
> >   kernel/dma/mapping.c            |  8 ++---
> >   5 files changed, 49 insertions(+), 34 deletions(-)

<...>

> > -	if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
> > -	    dma_kmalloc_needs_bounce(dev, size, dir)) {
> > -		if (is_pci_p2pdma_page(page))
> > -			return DMA_MAPPING_ERROR;
> > -		if (is_swiotlb_active(dev))
> > -			return swiotlb_map(dev, phys, size, dir, attrs);
> > -
> > -		dev_WARN_ONCE(dev, 1,
> > -			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
> > -			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
> > -		return DMA_MAPPING_ERROR;
> > +	if (attrs & DMA_ATTR_MMIO) {
> > +		dma_addr = phys;
> > +		if (unlikely(dma_capable(dev, dma_addr, size, false)))
> 
> "!dma_capable(dev, dma_addr, size, false)" in the above line.
> 
> It took me a while to find this after noticing that this patchset breaks booting some of me test systems.

Ohh, sorry, I overlooked it. Do you expect from me v6?

Thanks

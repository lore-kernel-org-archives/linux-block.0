Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6593257845;
	Sun, 31 Aug 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756645976; cv=none; b=QRzp0i+kcNgZ47JcW5NjL9aqSe1PfLlkTHRNPEhV53fkaq1SRcpYAEtp8UTIIk2WHx6UoO1/lEznvNd/Q9MkOSl5Syt2Z59a4bIBJzJamDiIRi0dvxOsKNZ5DSGtjxFbL0PmKu6RgQUiOMISVwYu4X42tFm9mpAgVHj8haIplWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756645976; c=relaxed/simple;
	bh=SVfffytdJ7l+FJFH+NQ2fAYz/jln+XvhXnCAv4vVciA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgVzYVgVV0a50cguRnBjMpk0rWqmBnYI9ly+aegefDLM5gbBix+8QByEcn7D+tvkT8kWgd8McPFGvYvbdFmEungfSVsQgOVwMU74/cw5B1Op5bNPF2D6Gcqept5LmyxHZFTIOLh6JBebz8ST2271kH5qupwLWBnI9OftPmnOC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMN3gtSJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMN3gtSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2B1C4CEED;
	Sun, 31 Aug 2025 13:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756645976;
	bh=SVfffytdJ7l+FJFH+NQ2fAYz/jln+XvhXnCAv4vVciA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMN3gtSJVf7yZJvH25PHoup176xzR4iH45PFd5WTaZl3P3yIlcpIRkfu5U3ulpn36
	 IKubxjRKitiVH7tEFGk0EvSWGehRo+3Ze6ErmIyU4uPo4HQlYX4MxtypCD8fFWeHBM
	 x5lx5bK4qJ+D+MLZSAMBnr8/dS6PtN2tAd1/pTiMLV/guQAHue805z1yqYSMaGWuq1
	 Airln6Bzle28Ohk7U9LgDEafLkaTwO2O0iuzeLmhUWu5F6SgZbC5gh8KCCHy3wqp2C
	 Hcv7g6EwqE5WnoDtEeiWuc9ndJyrHz9MWyHpBWe4DPcTvzNQTROEZWINBtgECoxCxA
	 rqMaDKHjRKGlQ==
Date: Sun, 31 Aug 2025 16:12:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v4 09/16] dma-mapping: handle MMIO flow in
 dma_map|unmap_page
Message-ID: <20250831131250.GC10073@unreal>
References: <cover.1755624249.git.leon@kernel.org>
 <ba5b6525bb8d49ca356a299aa63b0a495d3c74ca.1755624249.git.leon@kernel.org>
 <20250828151730.GH9469@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828151730.GH9469@nvidia.com>

On Thu, Aug 28, 2025 at 12:17:30PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 19, 2025 at 08:36:53PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Extend base DMA page API to handle MMIO flow and follow
> > existing dma_map_resource() implementation to rely on dma_map_direct()
> > only to take DMA direct path.
> 
> I would reword this a little bit too
> 
> dma-mapping: implement DMA_ATTR_MMIO for dma_(un)map_page_attrs()
> 
> Make dma_map_page_attrs() and dma_map_page_attrs() respect
> DMA_ATTR_MMIO.
> 
> DMA_ATR_MMIO makes the functions behave the same as dma_(un)map_resource():
>  - No swiotlb is possible
>  - Legacy dma_ops arches use ops->map_resource()
>  - No kmsan
>  - No arch_dma_map_phys_direct()
> 
> The prior patches have made the internl funtions called here support
> DMA_ATTR_MMIO.
> 
> This is also preparation for turning dma_map_resource() into an inline
> calling dma_map_phys(DMA_ATTR_MMIO) to consolidate the flows.
> 
> > @@ -166,14 +167,25 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
> >  		return DMA_MAPPING_ERROR;
> >  
> >  	if (dma_map_direct(dev, ops) ||
> > -	    arch_dma_map_phys_direct(dev, phys + size))
> > +	    (!is_mmio && arch_dma_map_phys_direct(dev, phys + size)))
> >  		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
> 
> PPC is the only user of arch_dma_map_phys_direct() and it looks like
> it should be called on MMIO memory. Seems like another inconsistency
> with map_resource. I'd leave it like the above though for this series.
> 
> >  	else if (use_dma_iommu(dev))
> >  		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
> > -	else
> > +	else if (is_mmio) {
> > +		if (!ops->map_resource)
> > +			return DMA_MAPPING_ERROR;
> 
> Probably written like:
> 
> 		if (ops->map_resource)
> 			addr = ops->map_resource(dev, phys, size, dir, attrs);
> 		else
> 			addr = DMA_MAPPING_ERROR;

I'm big fan of "if (!ops->map_resource)" coding style and prefer to keep it.

> 
> As I think some of the design here is to run the trace even on the
> failure path?

Yes, this is how it worked before.

> 
> Otherwise looks OK
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ACF2EA752;
	Tue,  2 Sep 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805368; cv=none; b=Q6WMOEeD6y+arGDVORm7WMLYL4ENPKCgrYPOzabU+hWv+b9NCHGJYKCJw3QOFYdW1oQg18GWKQ3dkPLUzOiInyuCQGKaRqK/yK99ksG4FJc6COd7tNCMl2DJt2iWd8mB4fvVXp5u4wdUxYDFwdg7bMdnAAXnwTZYmGfgfzlcQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805368; c=relaxed/simple;
	bh=DnDVES5Jg8WrIGoMPMfvxV9Wox20mcRcpnotwmcTmTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl/RiZ9ijahTcajwKGCIZfExpXV6TvnYLlwdzy4BJpce8I/yT5OxmTF3NeOPt06VK0lZO6PuJtKnMPKHPiYlWvgD5sAXfQjmPFApplRXhssy5UVP6mmdlSGzltoP8qN8crLO00QrukyGw9gbcXLX5Z12qVJWk9fwb+Ll9Ffurnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+YP0LKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+YP0LKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793FEC4CEED;
	Tue,  2 Sep 2025 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756805367;
	bh=DnDVES5Jg8WrIGoMPMfvxV9Wox20mcRcpnotwmcTmTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+YP0LKc7Ca9KSEGyhHI9LWKXOpYxDkmlx+xi/d94i28PXwnbkADYdG/kMj0eiK5B
	 zd/GooYAccyXKqdo2LtN0swNMmhiizGQIgjHrkSZ2IAXK/1jBPSRk3StbcZycbdrVP
	 g5quZtmGQMVEWVOV9clnOLPmMIcFNqak1dVeFhnzWaY1VIAyIlM9TCnw1bUSOb10fT
	 eYPBFQEGyOkOZzS7K5YPtS3dmkawe2LLvJU33SWPAwVjDdMQDDLsS8LD6Qfe4rZdHI
	 wki/IP/V+av0oWZTHcazqMPHDSPlXAIhw9qhWxKa10uhggFEbKZZEF+GYaHO+zcGYb
	 634HFrNZvr1dg==
Date: Tue, 2 Sep 2025 12:29:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
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
Subject: Re: [PATCH v4 00/16] dma-mapping: migrate to physical address-based
 API
Message-ID: <20250902092920.GE10073@unreal>
References: <cover.1755624249.git.leon@kernel.org>
 <CGME20250828115738eucas1p24f3c17326b318c95a5569a2c9651ff92@eucas1p2.samsung.com>
 <20250828115729.GA10073@unreal>
 <26bd901a-0812-492d-9736-4a7bb2e6d6b4@samsung.com>
 <20250901222302.GA186519@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901222302.GA186519@nvidia.com>

On Mon, Sep 01, 2025 at 07:23:02PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 01, 2025 at 11:47:59PM +0200, Marek Szyprowski wrote:
> > I would like to give those patches a try in linux-next, but in meantime 
> > I tested it on my test farm and found a regression in dma_map_resource() 
> > handling. Namely the dma_map_resource() is no longer possible with size 
> > not aligned to kmalloc()'ed buffer, as dma_direct_map_phys() calls 
> > dma_kmalloc_needs_bounce(),
> 
> Hmm, it's this bit:
> 
> 	capable = dma_capable(dev, dma_addr, size, !(attrs & DMA_ATTR_MMIO));
> 	if (unlikely(!capable) || dma_kmalloc_needs_bounce(dev, size, dir)) {
> 		if (is_swiotlb_active(dev) && !(attrs & DMA_ATTR_MMIO))
> 			return swiotlb_map(dev, phys, size, dir, attrs);
> 
> 		goto err_overflow;
> 	}
> 
> We shouldn't be checking dma_kmalloc_needs_bounce() on mmio as there
> is no cache flushing so the "dma safe alignment" for non-coherent DMA
> does not apply.
> 
> Like you say looks good to me, and more of the surrouding code can be
> pulled in too, no sense in repeating the boolean logic:
> 
> 	if (attrs & DMA_ATTR_MMIO) {
> 		dma_addr = phys;
> 		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
> 			goto err_overflow;
> 	} else {
> 		dma_addr = phys_to_dma(dev, phys);
> 		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||

I tried to reuse same code as much as possible :(

> 		    dma_kmalloc_needs_bounce(dev, size, dir)) {
> 			if (is_swiotlb_active(dev))
> 				return swiotlb_map(dev, phys, size, dir, attrs);
> 
> 			goto err_overflow;
> 		}
> 		if (!dev_is_dma_coherent(dev) &&
> 		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> 			arch_sync_dma_for_device(phys, size, dir);
> 	}

Like Jason wrote, but in diff format:

diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 92dbadcd3b2f..3f4792910604 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -85,7 +85,6 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
                unsigned long attrs)
 {
        dma_addr_t dma_addr;
-       bool capable;

        if (is_swiotlb_force_bounce(dev)) {
                if (attrs & DMA_ATTR_MMIO)
@@ -94,17 +93,19 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
                return swiotlb_map(dev, phys, size, dir, attrs);
        }

-       if (attrs & DMA_ATTR_MMIO)
+       if (attrs & DMA_ATTR_MMIO) {
                dma_addr = phys;
-       else
+               if (unlikely(dma_capable(dev, dma_addr, size, false)))
+                       goto err_overflow;
+       } else {
                dma_addr = phys_to_dma(dev, phys);
+               if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
+                   dma_kmalloc_needs_bounce(dev, size, dir)) {
+                       if (is_swiotlb_active(dev))
+                               return swiotlb_map(dev, phys, size, dir, attrs);

-       capable = dma_capable(dev, dma_addr, size, !(attrs & DMA_ATTR_MMIO));
-       if (unlikely(!capable) || dma_kmalloc_needs_bounce(dev, size, dir)) {
-               if (is_swiotlb_active(dev) && !(attrs & DMA_ATTR_MMIO))
-                       return swiotlb_map(dev, phys, size, dir, attrs);
-
-               goto err_overflow;
+                       goto err_overflow;
+               }
        }

        if (!dev_is_dma_coherent(dev) &&


I created new tag with fixed code.
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/tag/?h=dma-phys-Sep-2

Thanks

> 
> Jason

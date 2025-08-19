Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDD255F5E;
	Tue, 19 Aug 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627754; cv=none; b=mKEb10QoJgKDwo9OFOO6NxQRkr4SkeSg/CRF0D0WLLOuiBPCPhrzTBWTKiBs1dW6YH72RTb6CNwkZjGlCYUp7XABSrYpDpnuSavTOPgimEhDjRvxNVD04ko0bgyiwsWPZ2I2+dX/70wVxJD2zr7Pz31s1BRDasE4ly2ZX3b1tkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627754; c=relaxed/simple;
	bh=VSqn6WSqLVd/XpfzgudXSJRo0uPOQ5wyv2bWmCBBnJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brClJXw8q8QjdkdLUKH8H4UL3KgzpQnkw460zPL5CUbUoAYViG0BvizVlms6EdhXWKShQju/oLOPPhihMkzhQCMFtS+jGVfi17MXyZEb55jDhLiWnjEMUjamSqYORypxRVoV3evglw6woX+jm39Pwzq8ULfObO5GuiT8JVqut4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alN6/hwH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alN6/hwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8557CC4CEF1;
	Tue, 19 Aug 2025 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755627754;
	bh=VSqn6WSqLVd/XpfzgudXSJRo0uPOQ5wyv2bWmCBBnJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alN6/hwHpvzthoP/KrllDuyPfF9f8yAYQER8+ba4p7ZAaMRpwoXt8rvK6QE3L0ekl
	 bNm+CTndacGb+nR2BKXPNUnvE9okK+nJN6vWKLBypTEbMKpjdWZnobeyYbTdlJBwG3
	 eQhAlRfAJUiGmqIDHRjbObolLDa17Te4yFQpGASd/eKfIFxPevya5z3Kg7b9O2j2pW
	 xGJZckYIQxAQDMxUtnVFWJEEUia3gPTM6PRono+D9/zC602CQuuuu0N45uS/29jmmO
	 kxle5BpRno+jkLFSoQGxLhrpEA9gCkuIidPS0ZJ3bdNRJ1LR7RUOVZQkLijjuMZ2fZ
	 kFmTbvgXjx5hQ==
Date: Tue, 19 Aug 2025 12:22:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, linux-block@vger.kernel.org,
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
Subject: Re: [PATCH v4 11/16] dma-mapping: export new dma_*map_phys()
 interface
Message-ID: <aKTA5i1IZquRBolf@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <bb979e4620b3bdf2878e29b998d982185beefee0.1755624249.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb979e4620b3bdf2878e29b998d982185beefee0.1755624249.git.leon@kernel.org>

On Tue, Aug 19, 2025 at 08:36:55PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Introduce new DMA mapping functions dma_map_phys() and dma_unmap_phys()
> that operate directly on physical addresses instead of page+offset
> parameters. This provides a more efficient interface for drivers that
> already have physical addresses available.
> 
> The new functions are implemented as the primary mapping layer, with
> the existing dma_map_page_attrs()/dma_map_resource() and
> dma_unmap_page_attrs()/dma_unmap_resource() functions converted to simple
> wrappers around the phys-based implementations.
> 
> In case dma_map_page_attrs(), the struct page is converted to physical
> address with help of page_to_phys() function and dma_map_resource()
> provides physical address as is together with addition of DMA_ATTR_MMIO
> attribute.
> 
> The old page-based API is preserved in mapping.c to ensure that existing
> code won't be affected by changing EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
> variant for dma_*map_phys().

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

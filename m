Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A42F83CE;
	Wed, 13 Aug 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097643; cv=none; b=Qvg8Cqxo5WLA2wRy7JEgnG9rKc2IP+qoj3CF5ZmSlJFGHMCFFpoAJASGk6fDWBunY6ZJrz4IehTAAFfBhIn5DOSh40MPq2M5KRN/U/Nuu1KxYfNKsWdqRyj6ahKHSTrqz0XVodJqP58UyLyWZ3F7Z0jnleczWizuFwSz525CZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097643; c=relaxed/simple;
	bh=AgCFVr8B6NzxkSuzvPEJMB9AhjM0iYqJptnGya/8rdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7m1svZiFDaZ0nHci6ZaIBKn9a+n+G40+lKu17ez50jptc+4LcdkE9drO3UZ/8nUpRwspBbABorq8IPDeSVYD9q+1WEj1+gq3H6fyE0S0N13lswcJh8AhUNmosGVapOsqANzgQ6YCTISJy1CvqV63nURmwKWhnEa7Cpa60Z8p4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YENt6LTm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YENt6LTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B711C4CEF1;
	Wed, 13 Aug 2025 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755097642;
	bh=AgCFVr8B6NzxkSuzvPEJMB9AhjM0iYqJptnGya/8rdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YENt6LTmzTF5MtD2CCE/V13VNj4PuphZirCcbsVboFbdWpo5pbDoM+O1RwGND9hHA
	 WetmjCRKzL7pVzJCuB6ANhgpmI5NnCbOUKiA98JWJtIXOH8N50EVLmuQyuay6zm6ky
	 Onvhe46hQosw9HCamdkdEFdjBFc8sAKkHOvcvhEwHpJ12ST8cc+74GQ77yCDPQN8yP
	 6Wv7nBFsNIocmJw6FI3A2Sw+oIhMT6YNdwdLIq5MhleD6VLBx07CKPNCPkvEmssek+
	 ZjeG2ZowZ0nIKyT2jMky93WoiZsWFLORbU579a0ityJsLq0oaeKqLOOi+Bq4oEc02a
	 vNc66YhlSs8qQ==
Date: Wed, 13 Aug 2025 18:07:18 +0300
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
Subject: Re: [PATCH v1 08/16] kmsan: convert kmsan_handle_dma to use physical
 addresses
Message-ID: <20250813150718.GB310013@unreal>
References: <cover.1754292567.git.leon@kernel.org>
 <5b40377b621e49ff4107fa10646c828ccc94e53e.1754292567.git.leon@kernel.org>
 <20250807122115.GH184255@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807122115.GH184255@nvidia.com>

On Thu, Aug 07, 2025 at 09:21:15AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 04, 2025 at 03:42:42PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Convert the KMSAN DMA handling function from page-based to physical
> > address-based interface.
> > 
> > The refactoring renames kmsan_handle_dma() parameters from accepting
> > (struct page *page, size_t offset, size_t size) to (phys_addr_t phys,
> > size_t size). A PFN_VALID check is added to prevent KMSAN operations
> > on non-page memory, preventing from non struct page backed address,
> > 
> > As part of this change, support for highmem addresses is implemented
> > using kmap_local_page() to handle both lowmem and highmem regions
> > properly. All callers throughout the codebase are updated to use the
> > new phys_addr_t based interface.
> 
> Use the function Matthew pointed at kmap_local_pfn()
> 
> Maybe introduce the kmap_local_phys() he suggested too.

At this point it gives nothing.

> 
> >  /* Helper function to handle DMA data transfers. */
> > -void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
> > +void kmsan_handle_dma(phys_addr_t phys, size_t size,
> >  		      enum dma_data_direction dir)
> >  {
> >  	u64 page_offset, to_go, addr;
> > +	struct page *page;
> > +	void *kaddr;
> >  
> > -	if (PageHighMem(page))
> > +	if (!pfn_valid(PHYS_PFN(phys)))
> >  		return;
> 
> Not needed, the caller must pass in a phys that is kmap
> compatible. Maybe just leave a comment. FWIW today this is also not
> checking for P2P or DEVICE non-kmap struct pages either, so it should
> be fine without checks.

It is not true as we will call to kmsan_handle_dma() unconditionally in
dma_map_phys(). The reason to it is that kmsan_handle_dma() is guarded
with debug kconfig options and cost of pfn_valid() can be accommodated
in that case. It gives more clean DMA code.

   155 dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
   156                 enum dma_data_direction dir, unsigned long attrs)
   157 {
   <...>
   187
   188         kmsan_handle_dma(phys, size, dir);
   189         trace_dma_map_phys(dev, phys, addr, size, dir, attrs);
   190         debug_dma_map_phys(dev, phys, size, dir, addr, attrs);
   191
   192         return addr;
   193 }
   194 EXPORT_SYMBOL_GPL(dma_map_phys);

So let's keep this patch as is.

Thanks

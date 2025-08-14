Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF221DE2A5;
	Thu, 14 Aug 2025 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174912; cv=none; b=bIT5Zc/kQ3NYWol5bPy/zl2FbXAOafSCrPtHbEQLl0V2U2ISBlP2gSjockzA5ZOXujj6/UuvkZbWNnGJtLLXrB2xi+WVnQ/zh69p/qiVS2lV0OasO0h6Z2JSmxgH+Zb8wepjuvM7I/1DFnc4GeQH7NBMcWPRKAYmS8ratnmf3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174912; c=relaxed/simple;
	bh=5hXrpmcmtYiZJx4oU8qkI207P6Gx3hYundw5EKylrIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPdc7sHAGVD4TrJ2AMAQs8w+ZVFfeKiMAkPt0F0Q2+g+oLCATQPpfpK2j8cMiVkL7teBmg85fMm+qg1W/t1R0sb/Nzak8LER2tySdRJa7/fpPzMPOU7OMXgGSmwtr6rlnjXJDOyM+sgI6nzsP7XBJpawpIs6pbDFMAg53BnPVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2g2BIJ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2g2BIJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3623FC4CEED;
	Thu, 14 Aug 2025 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755174912;
	bh=5hXrpmcmtYiZJx4oU8qkI207P6Gx3hYundw5EKylrIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2g2BIJ8YPB3KdUqlIQ+3sf88XYTAU5YzXsxCIMkq+b9inEW2vgp9A4ivccGvjwfF
	 AV/wNRHN7Rl4BZfB83b4YqKem1VH+FiuolX5SiQ0hmKku6kJ9fzYlnSHRYR/hZfo4A
	 t7RgKyvSz54/20bp9OQxBJ3FdHTZ28zI3/O5nihwLrWH4XxMFsh7ImLJrid7kdNvXc
	 dxHzSoTZ0eAkBFydpLdrAEROqaFVHC+xn4DDTCz/hN4fLyFBvzVlWYglA0CvtcModo
	 8sk1zeTQvWBfTVENe6sc6PZjsbCDpigaPftEIsijKrs4a0DqSYC9HgT0MWUqY4ie5R
	 dAHYa4zIponFg==
Date: Thu, 14 Aug 2025 15:35:06 +0300
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
Message-ID: <20250814123506.GD310013@unreal>
References: <cover.1754292567.git.leon@kernel.org>
 <5b40377b621e49ff4107fa10646c828ccc94e53e.1754292567.git.leon@kernel.org>
 <20250807122115.GH184255@nvidia.com>
 <20250813150718.GB310013@unreal>
 <20250814121316.GC699432@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814121316.GC699432@nvidia.com>

On Thu, Aug 14, 2025 at 09:13:16AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 13, 2025 at 06:07:18PM +0300, Leon Romanovsky wrote:
> > > >  /* Helper function to handle DMA data transfers. */
> > > > -void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
> > > > +void kmsan_handle_dma(phys_addr_t phys, size_t size,
> > > >  		      enum dma_data_direction dir)
> > > >  {
> > > >  	u64 page_offset, to_go, addr;
> > > > +	struct page *page;
> > > > +	void *kaddr;
> > > >  
> > > > -	if (PageHighMem(page))
> > > > +	if (!pfn_valid(PHYS_PFN(phys)))
> > > >  		return;
> > > 
> > > Not needed, the caller must pass in a phys that is kmap
> > > compatible. Maybe just leave a comment. FWIW today this is also not
> > > checking for P2P or DEVICE non-kmap struct pages either, so it should
> > > be fine without checks.
> > 
> > It is not true as we will call to kmsan_handle_dma() unconditionally in
> > dma_map_phys(). The reason to it is that kmsan_handle_dma() is guarded
> > with debug kconfig options and cost of pfn_valid() can be accommodated
> > in that case. It gives more clean DMA code.
> 
> Then check attrs here, not pfn_valid.

attrs are not available in kmsan_handle_dma(). I can add it if you prefer.

> 
> > So let's keep this patch as is.
> 
> Still need to fix the remarks you clipped, do not check PageHighMem
> just call kmap_local_pfn(). All thie PageHighMem stuff is new to this
> patch and should not be here, it is the wrong way to use highmem.

Sure, thanks

> 
> Jason
> 

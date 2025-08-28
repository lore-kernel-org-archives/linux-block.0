Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE01239591;
	Thu, 28 Aug 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400074; cv=none; b=OKy3t5IInbTn4MzacZ50x4alKaB9QW3aidx2/kM8lGpm6YqCkSeW6ON0tzYdgb6TnhXNgdNBoxbfZslP4YZZzOOgBJT5kPHUPXuGft/Xb+fffDyuh2EaSWnYGPLyxiy8DrOMAWX/iAUdEghJhEgjSVt1BRExO2gzr/Bunkg1cvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400074; c=relaxed/simple;
	bh=3QSqWFwhLXFpgIQB1AhDzeFYEFSsyOykW/t8YMcdvDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtLva3nkQcBVWZrKbjaVkcaNP2AXxkRrdw24eElLjoB8BLpR/OhRAd5RUIz3utUW+Gtl1XsgcygMs64/IlEBHSIOomAMF0/0IAVL0Qc6+MX+yrFdc04F01pNrBZrmiXSMd6o5kOIzprIOkiYCYWfxRPpyOFWskguSH6lzLMEm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utug3C4q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utug3C4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C34C4CEED;
	Thu, 28 Aug 2025 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756400072;
	bh=3QSqWFwhLXFpgIQB1AhDzeFYEFSsyOykW/t8YMcdvDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Utug3C4qHAngGkUPRUqPcVpMv2skHSOiyTR1dzioCxiyV/N0D3D3xwLMN4kKVhjRg
	 R1e3GaQ66/QDlvAbclIdn1b0xrBO+DODu7rLesJ54dZQOJ+qr4UwXmhZorK6X6L1pe
	 /mKnN3THYo/PX+SSQI5FBBXcz4a8pvxXQG8iBycA9jlkdj9zJMMNMWOCxqVVHcRMG0
	 jrJGkyKqRduB/ujzl45UowCIqtVEnLBTqm/vLH4mWU4+vwRxIYccg9OHedq9aiILZs
	 hmuixBFk7xqznER0ERf4UjMVjXknV66U4Y9wYKKHbgLQRBDuheIDJSUa9AzDEN/7Pr
	 p4K8MwEWQi7/w==
Date: Thu, 28 Aug 2025 19:54:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
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
Subject: Re: [PATCH v4 15/16] block-dma: properly take MMIO path
Message-ID: <20250828165427.GB10073@unreal>
References: <cover.1755624249.git.leon@kernel.org>
 <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
 <aLBzeMNT3WOrjprC@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLBzeMNT3WOrjprC@kbusch-mbp>

On Thu, Aug 28, 2025 at 09:19:20AM -0600, Keith Busch wrote:
> On Tue, Aug 19, 2025 at 08:36:59PM +0300, Leon Romanovsky wrote:
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 09b99d52fd36..283058bcb5b1 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -387,6 +387,7 @@ enum req_flag_bits {
> >  	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
> >  	__REQ_ATOMIC,		/* for atomic write operations */
> >  	__REQ_P2PDMA,		/* contains P2P DMA pages */
> > +	__REQ_MMIO,		/* contains MMIO memory */
> >  	/*
> >  	 * Command specific flags, keep last:
> >  	 */
> > @@ -420,6 +421,7 @@ enum req_flag_bits {
> >  #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
> >  #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
> >  #define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
> > +#define REQ_MMIO	(__force blk_opf_t)(1ULL << __REQ_MMIO)
> 
> Now that my integrity metadata DMA series is staged, I don't think we
> can use REQ flags like this because data and metadata may have different
> mapping types. I think we should add a flags field to the dma_iova_state
> instead.

Before integrity metadata code was merged, the assumption was that request is
only one type or p2p or host. Is it still holding now?

And we can't store in dma_iova_state() as HMM/RDMA code works in page-based
granularity and one dma_iova_state() can mix different types.

Thanks

> 

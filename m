Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56272340D90;
	Thu, 28 Aug 2025 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401325; cv=none; b=HjTueI1GQffMoqMsbKBaacZXY+wB6ruHntr5Jy31qu1wWQN8Z/SN9HY0XipUxo86Y40rqOM3+1C88EyfZ4MeOJvTHbO4R8fbst95nG2jmyrDjPYM8/ayFPdPfIsi1e++IaQdMPiw0cpTVm8Kes5RBcl7/UKNohC/LxTDr5XYRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401325; c=relaxed/simple;
	bh=ou3iD8shgadPVxQRtF41FaHPfXiCub7fMhAggBLVXMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIK1BTXrRUzIbeO8wFyOuRuBiD4ndwXhbtS+o9mCWHAKjuJkjWoM9BLrVjoqHm6iODw67pBqn6VPkXymOXOivAFl8E7dbE5J7W0Qy5C2oJxYWzHyMOAJh87t6trgYWvLxC1BHhID6z3PXChBEh9iTC14EKEiOJP1zYGmTP2Sif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnmNyIm6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnmNyIm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A72BC4CEF4;
	Thu, 28 Aug 2025 17:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401324;
	bh=ou3iD8shgadPVxQRtF41FaHPfXiCub7fMhAggBLVXMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnmNyIm6kveacQ6zFjHwSr/ld+cbNXoqmfCrawHp1gvsXVCDDljqqxTV+b1zApRgH
	 5lcwKbYEv5XvzJ74pZRRlHz4xMMdbU2hypSAtpXWfDMqRVbb/qc2SqQSSCNqbZ1peQ
	 BdR01HGV590kQ600i1NoQpXCyGOYKnHeIsk3mGhcH3PGq+tQybbYkfchgS5mr5H49F
	 IvJGdW2sSi79scStsbkC/ihQucpNHR67O3EvTjBCfBwOnwU2YHvQc3Mh/Yo09lKjUz
	 oioVDuGo8iH8GapTPxpdVPh2h5wOe61XtWreqwSjOT2z6hU8npwTgtY7JSO24epBr/
	 2W6Y4P8WQ/UJw==
Date: Thu, 28 Aug 2025 11:15:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
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
Message-ID: <aLCOqIaoaKUEOdeh@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
 <aLBzeMNT3WOrjprC@kbusch-mbp>
 <20250828165427.GB10073@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828165427.GB10073@unreal>

On Thu, Aug 28, 2025 at 07:54:27PM +0300, Leon Romanovsky wrote:
> On Thu, Aug 28, 2025 at 09:19:20AM -0600, Keith Busch wrote:
> > On Tue, Aug 19, 2025 at 08:36:59PM +0300, Leon Romanovsky wrote:
> > > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > > index 09b99d52fd36..283058bcb5b1 100644
> > > --- a/include/linux/blk_types.h
> > > +++ b/include/linux/blk_types.h
> > > @@ -387,6 +387,7 @@ enum req_flag_bits {
> > >  	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
> > >  	__REQ_ATOMIC,		/* for atomic write operations */
> > >  	__REQ_P2PDMA,		/* contains P2P DMA pages */
> > > +	__REQ_MMIO,		/* contains MMIO memory */
> > >  	/*
> > >  	 * Command specific flags, keep last:
> > >  	 */
> > > @@ -420,6 +421,7 @@ enum req_flag_bits {
> > >  #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
> > >  #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
> > >  #define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
> > > +#define REQ_MMIO	(__force blk_opf_t)(1ULL << __REQ_MMIO)
> > 
> > Now that my integrity metadata DMA series is staged, I don't think we
> > can use REQ flags like this because data and metadata may have different
> > mapping types. I think we should add a flags field to the dma_iova_state
> > instead.
> 
> Before integrity metadata code was merged, the assumption was that request is
> only one type or p2p or host. Is it still holding now?

I don't think that was ever the case. Metadata is allocated
independently of the data payload, usually by the kernel in
bio_integrity_prep() just before dispatching the request. The bio may
have a p2p data payload, but the integrity metadata is just a kmalloc
buf in that path.

> And we can't store in dma_iova_state() as HMM/RDMA code works in page-based
> granularity and one dma_iova_state() can mix different types.

I see.

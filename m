Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6848121C9FD;
	Sat, 15 Nov 2025 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763229952; cv=none; b=r0O4UaXqiq6Biv0uKlPKFlTzIFDkKo+Rb+7SYpuJGE/ETW0/6OPYEUGtX2/YwBfM08pp9af1TC+bzlWMPYvOJNvcnRWNUoHs2Qa3wNUgRUFWRXLiutMX971fnNvstr2k95NejK0E+/BuA5fceakhqNPyWe22WNX7o3F1EhNe6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763229952; c=relaxed/simple;
	bh=wvUeJI+DQ6+5SXIRBrGQ2XvF6W1kb5RLVw8OzwUxO2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8xEtLzW3ORGfnzmRL8SkoHSdUbru9nySjmVJKmFiTywbWr8lqGNJhydnayCmM8YZPomkdTs8Tw7+ss7jgzQgtvgEByod3+IYrZ3eBzeCdXYnca7bJ2AvB4iqJElWolWmUMj0p0TVOsuzHpQv5SGA7BUtDw0VtS7am8bvCysAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnAsuQdZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnAsuQdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4263C4CEF5;
	Sat, 15 Nov 2025 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763229952;
	bh=wvUeJI+DQ6+5SXIRBrGQ2XvF6W1kb5RLVw8OzwUxO2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnAsuQdZQfdOUNV6MATOCoxHSrFYsX/MdUFL323mV8HqIbd81xoVr3bdvJ9HPebH5
	 oSq7BQJfVu+IrWONB0rgCtP1kBJxSoZA7AZDWY8MO1g7Y9Db0ynAFK5teKdlyJLiKk
	 UMaVWoKFq03YtsKj7N4HPlpWfR2BBGWa/I9smxKJpF6BS9Qastb7uCIMf+feT2E4TT
	 wvo+VJroVt9iiU3fENZveCa6i7CT/gJEeHAnMPRFQaiXUEeNmc5cTneDzwTpeyWnS8
	 UrdvVTl5MMOTiHdcZLlYKD24Z74zwq5oXSLgxS/2j4NQqzxTtQZ6lf3xgIgazSAAXj
	 kHXzLEUW5S9oQ==
Date: Sat, 15 Nov 2025 20:05:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251115180547.GC147495@unreal>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
 <20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
 <20251115173341.4a59c97f@pumpkin>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115173341.4a59c97f@pumpkin>

On Sat, Nov 15, 2025 at 05:33:41PM +0000, David Laight wrote:
> On Sat, 15 Nov 2025 18:22:45 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > This patch changes the length variables from unsigned int to size_t.
> > Using size_t ensures that we can handle larger sizes, as size_t is
> > always equal to or larger than the previously used u32 type.
> 
> Where are requests larger than 4GB going to come from?

The main goal is to reuse phys_vec structure. It is going to represent PCI
regions exposed through VFIO DMABUF interface. Their length is more than u32.

> 
> > Originally, u32 was used because blk-mq-dma code evolved from
> > scatter-gather implementation, which uses unsigned int to describe length.
> > This change will also allow us to reuse the existing struct phys_vec in places
> > that don't need scatter-gather.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  block/blk-mq-dma.c      | 14 +++++++++-----
> >  drivers/nvme/host/pci.c |  4 ++--
> >  2 files changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > index e9108ccaf4b0..cc3e2548cc30 100644
> > --- a/block/blk-mq-dma.c
> > +++ b/block/blk-mq-dma.c
> > @@ -8,7 +8,7 @@
> >  
> >  struct phys_vec {
> >  	phys_addr_t	paddr;
> > -	u32		len;
> > +	size_t		len;
> >  };
> >  
> >  static bool __blk_map_iter_next(struct blk_map_iter *iter)
> > @@ -112,8 +112,8 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
> >  		struct phys_vec *vec)
> >  {
> >  	enum dma_data_direction dir = rq_dma_dir(req);
> > -	unsigned int mapped = 0;
> >  	unsigned int attrs = 0;
> > +	size_t mapped = 0;
> >  	int error;
> >  
> >  	iter->addr = state->addr;
> > @@ -296,8 +296,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
> >  	blk_rq_map_iter_init(rq, &iter);
> >  	while (blk_map_iter_next(rq, &iter, &vec)) {
> >  		*last_sg = blk_next_sg(last_sg, sglist);
> > -		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
> > -				offset_in_page(vec.paddr));
> > +
> > +		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));
> 
> I'm not at all sure you need that test.
> blk_map_iter_next() has to guarantee that vec.len is valid.
> (probably even less than a page size?)
> Perhaps this code should be using a different type for the addr:len pair?

I added this test for future proof, this is why it doesn't "return" on
overflow, but prints dump stack and continues. It can't happen.

> 
> > +		sg_set_page(*last_sg, phys_to_page(vec.paddr),
> > +			    (unsigned int)vec.len, offset_in_page(vec.paddr));
> 
> You definitely don't need the explicit cast.

We degrade type from u64 to u32. Why don't we need cast?

Thanks

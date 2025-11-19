Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8883594F;
	Wed, 19 Nov 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560707; cv=none; b=LRUM0BFgHd7P29re7eA9uJBCnR3GYdMxtEugE8Q8zvLoVDRfC9Vw1QrLix31TGzPe5IDrl6XQyuFm8c5jIheQgXNLoreLk8lKAaJGD+hhyYd3OTM0e7oUs77aj+xAXo7in2h1JwSzcPkx1bgbh2e4Ns3nZiSGGRttdM2hvPOjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560707; c=relaxed/simple;
	bh=ZJMRoWNDVSvg2ELqZhSj0MYsT3uXuatCNruN91d8KZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGSzorVjrFmjxCAURvkmNVHyHuNtamQIOrli6h5At1mQkkJjQGx4W7tydUiva0lZKbe0rIdXz0ylVhjIZT2mHU7xhgeH9NLMqN8xPwOSwESihtCQ0wcME0XepOLnRcMjasvbWxIe0GDiDSVhyHPoNeIYcpkVvGbFOmNWnMTmYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0QZ0z4o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0QZ0z4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBB3C4AF09;
	Wed, 19 Nov 2025 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763560706;
	bh=ZJMRoWNDVSvg2ELqZhSj0MYsT3uXuatCNruN91d8KZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0QZ0z4oFik1hKykUihU+68Oxa7XG5dwGBEBOE5chOgV1H/fpsbuaC0N7RwZ3uBJZ
	 6NQ/WK7++1X6MR8ZwBmjFrUZ1+e8moGP93HumNh60hRzzeVsvehwPRG1JOzurCyUqF
	 JMxMPatoCFYQJnHDG7YT/fKkHeNMgJllhvvDo0QGe2AWKiLSUhPNxrSo5kDlUX6NrJ
	 g+haK8MtFmhG1fWvX+CzqmU+xIXaJCrCePu711PqeLqldbmpdLi2XsPdP4TxzVOY3N
	 byeJxedETGMzbIbqhjRkhPqEox+eM8c8ohR4StaJhQlB7Sfs77/T/KdEuvs2efNgDI
	 iph0OqcZnXflg==
Date: Wed, 19 Nov 2025 15:58:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119135821.GH18335@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <20251118050311.GA21569@lst.de>
 <20251119095516.GA13783@unreal>
 <20251119133615.2eefb7db@pumpkin>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119133615.2eefb7db@pumpkin>

On Wed, Nov 19, 2025 at 01:36:15PM +0000, David Laight wrote:
> On Wed, 19 Nov 2025 11:55:16 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Tue, Nov 18, 2025 at 06:03:11AM +0100, Christoph Hellwig wrote:
> > > On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:  
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > This patch changes the length variables from unsigned int to size_t.
> > > > Using size_t ensures that we can handle larger sizes, as size_t is
> > > > always equal to or larger than the previously used u32 type.
> > > > 
> > > > Originally, u32 was used because blk-mq-dma code evolved from
> > > > scatter-gather implementation, which uses unsigned int to describe length.
> > > > This change will also allow us to reuse the existing struct phys_vec in places
> > > > that don't need scatter-gather.
> > > > 
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > ---
> > > >  block/blk-mq-dma.c      | 8 ++++++--
> > > >  drivers/nvme/host/pci.c | 4 ++--
> > > >  2 files changed, 8 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > > > index e9108ccaf4b0..e7d9b54c3eed 100644
> > > > --- a/block/blk-mq-dma.c
> > > > +++ b/block/blk-mq-dma.c
> > > > @@ -8,7 +8,7 @@
> > > >  
> > > >  struct phys_vec {
> > > >  	phys_addr_t	paddr;
> > > > -	u32		len;
> > > > +	size_t		len;
> > > >  };  
> > > 
> > > So we're now going to increase memory usage by 50% again after just
> > > reducing it by removing the scatterlist?  
> > 
> > It is slightly less.
> > 
> > Before this change: 96 bits
> 
> Did you actually look?

No, I simply performed sizeof(phys_addr_t) + sizeof(size_t).

> There will normally be 4 bytes of padding at the end of the structure.
> 
> About the only place where it will be 12 bytes is a 32bit system with
> 64bit phyaddr that aligns 64bit items on 32bit boundaries - so x86.

So does it mean that Christoph's comment about size increase is not correct?

Thanks

> 
> 	David
> 
> > After this change (on 64bits system): 128 bits.
> > 
> > It is 33% increase per-structure.
> > 
> > So what is the resolution? Should I drop this patch or not?
> > 
> > Thanks 
> > 
> 

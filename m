Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27B1F4169
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763245735; cv=none; b=JO/IFFmySNLBjSJhdCw9sgZ3o7Z6GiWo5W5vjJk7LofXSMLfyHfUM7WI6suNn1Hay6ygMkerZfSzmcUMvzZOwfoQc4BSc5cHDU7BoP0WUs3/BXfsPN3wYS7fOn/Mw2SZeWcB8yGKS7GzRtC3MFC5XXdpxvCaYrc2aeoyNtUI5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763245735; c=relaxed/simple;
	bh=vqLnIy97OLSwwnZrHUatO8NqOIRbbuX7cuBH6ihrevM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujEQJ3cI8vMljzMzvNEuqMgGsFqNhXoVZPZyd4ABu3zayoKKH8PBkmE4B+gfIfRz1wJ3R+x5oA90znytLTJEL/t2I7pk+oqIWIfYcIESN6fdLJKMlK6DIvPQdjBlAlHarssiWZIjLxOldnKmjEpME7mLfzyz12kHPhq1Qoq1FFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPxU364+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPxU364+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4710022571cso28872665e9.3
        for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 14:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763245732; x=1763850532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2Xrv0xJ9oC9kn5c/x2EsBp3So4jCy6049Ql9XrALiM=;
        b=iPxU364+L9MdesvtriTEbrjMJDnq4ub2uMoZsAmT7CphPk4ri2x1Il63Ob3mnakbUP
         CEURtz13cKVBSVLqpOUudNunD0GEyR+kJFkY2WR4CNSFZCvibB6W3xMcCvSCbNfuxenz
         jIAC/bLnbOGTbElgO8pd9pObBRXZ/mokp5Ea3PJfHztsnZ7pb6oVb8kiFqkwfQ7a2p82
         56HDVbzZyHR2xyyC7oIf2LLFWdaHDrS8YNUdcBcssSxg09/9oSX/JLQ/5m/JDz8OBAd/
         AQGyQl0xl5gQEncJNQbgfcZAB1IloMlU5mjnJo5pypavotZgp0orkUFDNTRTjj00aPTB
         h/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763245732; x=1763850532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2Xrv0xJ9oC9kn5c/x2EsBp3So4jCy6049Ql9XrALiM=;
        b=P4BQEl1Seas+KHaOpbZ7ngLulxyilHiFVO8/eUA4HS2TDJGN0fSWl3so+Iydl3Q53j
         XWroA9zht3wh/hFWcRET0aC9MJFRHOGjqJV6LBzQmtYZzOwOLbCquGBlbX1XFZZpIp7r
         ZnFZQBs1SMSl4Falbl/3ssua7LiHfwm8mxPorY5sXzxVfIR6kSQ1n8Dl2NZEJJEiCdvP
         r86oG2OnNW1XPdF2+rmwGWEZcqbgGrRV/QTh6YcbJSEmmiTqt6FHrL9qhNP7kiV0j9N4
         TGyqM4vC2WELJeWBwYcwCrerz3jTuI0S6CjbSsgp1a50PCg+b6Q3bO6PJYx4cA1Gd8EB
         ctcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC062u9IUGg7PSx/aJhm1f/KYDuKTDAvNWyAJEYTWPOTqq23FKXlz4tRduce7MjBNCS+hu+R2/JIxfHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEvrJlnZtAYnQX1zQXiD4KqLyqUxH0kSB7cjPxVP4HOdREFYw
	6Enz6LhJhSULaXXX+/v0z5tIgQLdQOUl8Gg19cNR3AN1p6zfPpyKpr8LGNfHOQ==
X-Gm-Gg: ASbGncsaJksCOBnfvGNdFjE9VmvROJz2SGIv3MPD5PJCPpXgh9uYM4eRfREI/adteh5
	eBseu9grCXxocJsEwmBEFV7pX8nNPw2IM0LrP86tlZTZyAnTo8cjkYvuobZtAcgx4lsOTaImBoB
	WeDJb8x77UOTLURDn8JlblJfT2CZaHkRdvbPvMbyIzPvIitNIthReZoX1shb+yOQx1YaQgLyfmK
	M9xa3uwNcVUuNNb00GkJsHo7SC31e2j9FRXLMLi4OwOi7jSDy5WtoaNSWZHT3mx2AEG9MMlpZ3k
	ivWLem2j8wHs8ydg1bOEIEI+E/jYKNaghoV+jaXCHg1gufylgHDxoTJiFlO3LrFSdW76OPKuoPy
	psIKnIv8nEyS8bDwzFXswjy7bjvaoCoJXCq3cGxRAedI6q8mBvIOXYwIF1RofihHQK3IwKOg8j9
	LUHKMTJzSMkdBgJgpcmnsWkj5yOQIbMvJbtityk/b5aeQ+HAq35zkg
X-Google-Smtp-Source: AGHT+IFdxdzmeev3HrNzWJ2sskEhMPRWYP1zgllLH3n3dfgpFJwxPquIa2N+BHT4Jqy6QmXptGNXLQ==
X-Received: by 2002:a05:600c:8b43:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-4778fe6098dmr71627895e9.18.1763245731840;
        Sat, 15 Nov 2025 14:28:51 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb34278sm76630295e9.4.2025.11.15.14.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 14:28:51 -0800 (PST)
Date: Sat, 15 Nov 2025 22:28:50 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251115222850.183b8557@pumpkin>
In-Reply-To: <20251115180547.GC147495@unreal>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
	<20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
	<20251115173341.4a59c97f@pumpkin>
	<20251115180547.GC147495@unreal>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Nov 2025 20:05:47 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Sat, Nov 15, 2025 at 05:33:41PM +0000, David Laight wrote:
> > On Sat, 15 Nov 2025 18:22:45 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:
> >   
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > This patch changes the length variables from unsigned int to size_t.
> > > Using size_t ensures that we can handle larger sizes, as size_t is
> > > always equal to or larger than the previously used u32 type.  
> > 
> > Where are requests larger than 4GB going to come from?  
> 
> The main goal is to reuse phys_vec structure. It is going to represent PCI
> regions exposed through VFIO DMABUF interface. Their length is more than u32.

Unless you actually need to have the same structure (because some function
is used in both places) there isn't really any need to have a single structure
for a a phy_addr:length pair.
Indeed keeping them separate can even remove bugs.

For instance (I think) blk_map_iter_next() returns an addr:len pair
that is only only used for the following sg_set_page() call - which
has separate parameters for phys_to_page(addr) and len.
So unless there are other place it is used it doesn't need to be
the same structure at all.
(Other people might disagree...)

> 
> >   
> > > Originally, u32 was used because blk-mq-dma code evolved from
> > > scatter-gather implementation, which uses unsigned int to describe length.
> > > This change will also allow us to reuse the existing struct phys_vec in places
> > > that don't need scatter-gather.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  block/blk-mq-dma.c      | 14 +++++++++-----
> > >  drivers/nvme/host/pci.c |  4 ++--
> > >  2 files changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > > index e9108ccaf4b0..cc3e2548cc30 100644
> > > --- a/block/blk-mq-dma.c
> > > +++ b/block/blk-mq-dma.c
> > > @@ -8,7 +8,7 @@
> > >  
> > >  struct phys_vec {
> > >  	phys_addr_t	paddr;
> > > -	u32		len;
> > > +	size_t		len;
> > >  };
> > >  
> > >  static bool __blk_map_iter_next(struct blk_map_iter *iter)
> > > @@ -112,8 +112,8 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
> > >  		struct phys_vec *vec)
> > >  {
> > >  	enum dma_data_direction dir = rq_dma_dir(req);
> > > -	unsigned int mapped = 0;
> > >  	unsigned int attrs = 0;
> > > +	size_t mapped = 0;
> > >  	int error;
> > >  
> > >  	iter->addr = state->addr;
> > > @@ -296,8 +296,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
> > >  	blk_rq_map_iter_init(rq, &iter);
> > >  	while (blk_map_iter_next(rq, &iter, &vec)) {
> > >  		*last_sg = blk_next_sg(last_sg, sglist);
> > > -		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
> > > -				offset_in_page(vec.paddr));
> > > +
> > > +		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));  
> > 
> > I'm not at all sure you need that test.
> > blk_map_iter_next() has to guarantee that vec.len is valid.
> > (probably even less than a page size?)
> > Perhaps this code should be using a different type for the addr:len pair?  
> 
> I added this test for future proof, this is why it doesn't "return" on
> overflow, but prints dump stack and continues. It can't happen.

No, on a large number of installed systems it prints the stack an panicks.
Were it to continue the effect would be all wrong anyway.
But blk_map_iter_next() guarantees to return a sane length.

> 
> >   
> > > +		sg_set_page(*last_sg, phys_to_page(vec.paddr),
> > > +			    (unsigned int)vec.len, offset_in_page(vec.paddr));  
> > 
> > You definitely don't need the explicit cast.  
> 
> We degrade type from u64 to u32. Why don't we need cast?

Because you don't need to cast pretty much all integer conversions.
Any warnings compilers might output for such assignments really are best
disabled.
The more casts you add to code to remove 'silly' compiler warnings the
harder it is to find the ones that actually have a desired effect and/or
unwanted effects that are actually bugs.

I'm busy trying to fix a load of min_t(u32, a, b) which mask off high
significant bits from u64 values.
The casts got added (implicitly by using min_t() instead of min()) because
min() required the types match - and in a lot of cases the programmer
picked the type of the result not that of the larger parameter.
Others are just cut&paste of another line.
But the effect is the same, the casts add bugs rather than making the
code better.

I've even seen:
	uchar_buf[0] = (unsigned char)(int_val & 0xff);
(Presumably written to avoid compiler warnings.)
and looked at the object code to find the compiler (not gcc) anded the
value with 0xff for the '& 0xff', anded it with 0xff again for the cast
and then did a memory write of the low bits.

casts could easily be the next 'bug'...

	David

> 
> Thanks


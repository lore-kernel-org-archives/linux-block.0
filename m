Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2134D4C1
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561588; cv=none; b=uq5x+i9YSLyorPruEaMHrq/3ftYzBWJ/FT9MznZ2KjS34AQ9IlR3nfX0aASs/pzyH1uB7tnI/7Pxku4K2BGvnxSAKWZbtpK/kB6qchy7dUf5J+uJnmavFrGuDgJvHgMJ5xXjG5CVVpGhqIpCLgzuMPkRlf2BOAcgZtRjyldZE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561588; c=relaxed/simple;
	bh=Z1Z7q1ac2+gy8DVlTXkfsVfycrNnZK4yyj/tSUXz1Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJzZtFnakxltrvERXG6VTwWLfdBscrXijubAcC3a8XSqwD3tZ7yE1rC6kH7JlLe3wO7nci7IjjT902f3Qqpmwy648PJZP9bvjT/qJdqdqYKggRFkv1tjgyPHvuZ4wDX73CIteeCg2g/ND4kFCtu2JOpPOkOHP1WmRwr58Zwqnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFBhr/r0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFBhr/r0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a219db05so24963605e9.2
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 06:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763561583; x=1764166383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7aP8W+Aeaqnc8t5oPu3wVtzhhr1g6oARpgSmq5CAOE=;
        b=kFBhr/r0XLnUdrOln1WexVHp6ChFVXgc6rOPgLic5GpwbEdKkhBcwfebjEEQBu+t8n
         96W24pCeAG5m95vHbgcG9pI/LA6UwQP/GFBgcMzfU1uf6v2KuzXuCxrv9ktuWUzZLlPv
         1TyqzlwuIGa0K3QIJ40KgXhU1MEzBpYw0TUGy/8/FhnWBevNXnhtfXeKUStIDBvTQeED
         pKrHQlBj7S6lpmyPB8V1CFW0zBe6+psscyOjyiz1JJisWLtgYwkXcOT+rFaiQnI5wAv2
         N90temWyTq9A70+GrwAvn905Md5HjglbVq7hjPAyV2mS93UJDaC2JrawF18iX3Jq6DPc
         n/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561583; x=1764166383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S7aP8W+Aeaqnc8t5oPu3wVtzhhr1g6oARpgSmq5CAOE=;
        b=nmz1OxIIPKCGp55V9EulKnHZon6maXkaPwSEtGzNR/KqC11KTkUJ9FKg3wgGVzc0Ec
         B2JLxGvAxwHu3nosg6jBbvtcscYDvftWtn6wLreaAzRW6g4Od6IOTlJujcaDyNn7IVpN
         SMWK4uv2r2bMRdQJnkJrj4Se5DtFJCarFapPbWWXpP0Eeti73NBrweNb7vbLEXA4FQqM
         CWP193yrXOyAI+IJhMJ2XFWwbvol5ySPx3RYofCmkqNbFhQdgq1Ja8ASW/Lo+pUC2UQJ
         guoYAO0aqu46dFNKS07yHelfHltzbMe0Dra1pBQ2BpGVgLhiDfiYuXqQpaiYdD/2MdPv
         oKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPmSfd6MaRE/13HOvs98z+LLyaw1OI5XPtClGmdZ8p9YJhl0joehvIXvLrRUXBJGdZ9agfzrDk1QPsTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLy9sMYRR4dycWYn01JifOik/ZYzQHzhb8SFXwNNDuFiEDh2py
	JznhC2WEfYnuGVUTdoRvng141z09AWU0F/686bgLIxru0onUpKkJfzrb
X-Gm-Gg: ASbGnctWHKAoJtYybUDE77P4pGzp8Xt1yphEnpwcoYs2fUA25airsRDSll4IwRbUvJJ
	7Xtazg9MJOzWtdee7iXHK7FnUpB+n0Pzi+FW6XJ46loybybnkgsX6+hgVM3r8jXQrhYn83WhH/T
	6rc4pKGJm+vq2nuSuGni/juwdQM3XtFPushlS8q4nX/yKo1wsFRFlRrYrDMrYXR8yuUgg1ZFjrr
	82bBmKc5UHhCNNK8/I8jkUXQ1J7TyAJyjuubFGNoUwQ1bXFkHfCK3n6GLqd/xlVJmHJB66u/hQh
	yvpkqQRZMv51Oyep9p9mBbnDGQ8vZW9gQrz1TRnZYI1Np1S7c2FifddE0fKpAQa3x1nom54t2LK
	HjRGlPJMsMvxWE/f2KlIpfJUuM5OezB2TanEilr2wsML7660kK4bKx1aB9uiF+jgFI+Rk+LZ95e
	2QDi22Ddmept3f/V/FMesoUHAMmgMY0xEO9ofDR6Hg5XtSNw2pjapK
X-Google-Smtp-Source: AGHT+IEtVM7lrLxA2BQPvt9R5nz+4TxPuoPf0muPqE8Gc4OLySQB28IfuFlpBF7XjUUBcohtoZ0Sgg==
X-Received: by 2002:a05:600c:3b19:b0:475:daba:d03c with SMTP id 5b1f17b1804b1-4778fe62088mr167939805e9.13.1763561582690;
        Wed, 19 Nov 2025 06:13:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm39416229f8f.17.2025.11.19.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:13:02 -0800 (PST)
Date: Wed, 19 Nov 2025 14:13:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119141300.2209ea72@pumpkin>
In-Reply-To: <20251119135821.GH18335@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
	<20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
	<20251118050311.GA21569@lst.de>
	<20251119095516.GA13783@unreal>
	<20251119133615.2eefb7db@pumpkin>
	<20251119135821.GH18335@unreal>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 15:58:21 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Wed, Nov 19, 2025 at 01:36:15PM +0000, David Laight wrote:
> > On Wed, 19 Nov 2025 11:55:16 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:
> >   
> > > On Tue, Nov 18, 2025 at 06:03:11AM +0100, Christoph Hellwig wrote:  
> > > > On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:    
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > This patch changes the length variables from unsigned int to size_t.
> > > > > Using size_t ensures that we can handle larger sizes, as size_t is
> > > > > always equal to or larger than the previously used u32 type.
> > > > > 
> > > > > Originally, u32 was used because blk-mq-dma code evolved from
> > > > > scatter-gather implementation, which uses unsigned int to describe length.
> > > > > This change will also allow us to reuse the existing struct phys_vec in places
> > > > > that don't need scatter-gather.
> > > > > 
> > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > > ---
> > > > >  block/blk-mq-dma.c      | 8 ++++++--
> > > > >  drivers/nvme/host/pci.c | 4 ++--
> > > > >  2 files changed, 8 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > > > > index e9108ccaf4b0..e7d9b54c3eed 100644
> > > > > --- a/block/blk-mq-dma.c
> > > > > +++ b/block/blk-mq-dma.c
> > > > > @@ -8,7 +8,7 @@
> > > > >  
> > > > >  struct phys_vec {
> > > > >  	phys_addr_t	paddr;
> > > > > -	u32		len;
> > > > > +	size_t		len;
> > > > >  };    
> > > > 
> > > > So we're now going to increase memory usage by 50% again after just
> > > > reducing it by removing the scatterlist?    
> > > 
> > > It is slightly less.
> > > 
> > > Before this change: 96 bits  
> > 
> > Did you actually look?  
> 
> No, I simply performed sizeof(phys_addr_t) + sizeof(size_t).
> 
> > There will normally be 4 bytes of padding at the end of the structure.
> > 
> > About the only place where it will be 12 bytes is a 32bit system with
> > 64bit phyaddr that aligns 64bit items on 32bit boundaries - so x86.  
> 
> So does it mean that Christoph's comment about size increase is not correct?

Correct - ie there is no size increase.

> 
> Thanks
> 
> > 
> > 	David
> >   
> > > After this change (on 64bits system): 128 bits.
> > > 
> > > It is 33% increase per-structure.
> > > 
> > > So what is the resolution? Should I drop this patch or not?
> > > 
> > > Thanks 
> > >   
> >   


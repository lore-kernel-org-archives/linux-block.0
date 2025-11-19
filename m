Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B82BE04C
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559380; cv=none; b=liktwNboUM1Ebyp2UHkIssRv7HjhreVbcczb498zudPgRNvuTkXFM9s4p4E7FBLqHfYOuwfB3BOwoJovWMTk3/TEMkXJoJGG6OxSBZ0iP/KWfmiD+dNEsrD58W8VQqzNcWvbIicfHKRqGcKZHVkvCvcKzmDMOvFeWhFDpatVCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559380; c=relaxed/simple;
	bh=NES7ghcCP3m1ExfoU/vAhaTBSd5OHINmQXVjgEbzWRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpA2s9+O4i69xqRzG0SivsPWU4fF16jtzn7HW46WX9erepT04raltgWTqFdVAmg74VAPUiYIOgdS8fLrhd7Pp/PpMQ8b2UDNSYF18eHCaaNv42DJERC7z5AHwoe5GgNmxO3NAoyGCuipyrM5Ksih8IJAgIU4B+V+rKkfz/Lzq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPMKhCJs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPMKhCJs"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so45369575e9.3
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 05:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763559377; x=1764164177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7Vh9iH410ocW2kXRvDe/advl/kXNqnUGcQOJSCBMWA=;
        b=aPMKhCJsOa4CIu7MSY5XLAVo/IFxiUZLkb+BjsMVPj2GaPEdhmsBK4qOFB7/JvTL3U
         SLNTHS8HwSQe810mcdC91TTBJNWyK9I02561CrCzpS/H9rlJuz/hvrgS3vJV2krHUYhW
         Av60yvxhfm3g3aJSpVeroGHvj14GJ43xijwIjYW62QgkecohOGoRQqEvDz8Y6A10DXPr
         JtxT7bjGhtNa2j5i01iInPqp0amjta1lQTQfsDf78b3J8L1+uy1luJ3cJ479Rvksc5WP
         y0kqyZPCIg+hb4LbEQFK/T7aZCTrmRKDOfAoAxIACfDf6ri8H/T/e3Hqh87Ohn7UqVX8
         bOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559377; x=1764164177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7Vh9iH410ocW2kXRvDe/advl/kXNqnUGcQOJSCBMWA=;
        b=LH5w7jerTjJxxVlOJRj2EokzIc0YTTdddiOngsI69UP5A5PGtGpqISeMkjXyJR7sWM
         JphrpP1o9EwTt7BQPs5zvhk2D6Y65+KM8oBZl4qdonFfMWiVh+TY8JYv/ikMuL/QL0QN
         +VbgJj/Xmm5ym8bj5kpFwqeU9cRJ0Ec/GhiWTeW7HIU1rx9ELZsZZYmxtHgB7hzSoDI2
         xDGm0sypPDYCjzxM61YqdTR51uWW5y9AFJaog4Y4k/+D/1YSRTMKyiDxcGbo6oaed87Z
         EoQMfo5udEHPxkXfvLFs8RQaDzcWUEzowaeSSoYSyV+FU0vEGK7/ePPWwkM/2oYVipKr
         dyMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfeYkikVOGb8Kl17dK9X0tg8rg5jYxXx3yFJkPNWKVwz3a7U0y8i4PNmCp1ajftSnu2T/naIe2bJmOmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9lKuJD6QHeYwhhSoT3Il3kJLgdQR+G/TaMJgIA8xyONVpPYxA
	Y+edfUL5URq0+EIUPuspb02iPtyDLw4JIW/vT0LtTk6hmiAJj2oEog3J
X-Gm-Gg: ASbGncvsh/lJBXMPcELaX8Qa/jECffhVc1T48pUP+W1O5JZ6iUJixIx7kkljwJAuINW
	Jy4R2DhQpqF1tpguG8f0m9qRgl7Jk1jETPSAy6hLITpEFjeowj/5ksKD6Xjgid3rx/7noXML3Uv
	9uR5af6ms2eilLAvGFTct9wBqEQ8pedVf7AASaXYLvKJnB9EIQlBarcyldnX+7fJPTS4BgrJkEe
	s7omn19LqqHV2tDuMc30cW4d1xMnNZOi7XWaQi5b5OOYS6sdFfgpqwmVPPVGnKT0aLVkDNVxU+c
	nuUGXSkc9gHDVKUbh7cA7qswuDX+rSC34ct8n/Gor18DZo8XCIF1BstZdUvuSvuLcrSnFYPNruE
	jMWvNr5KkGKsh6UkqquBlw671Nf74GQiG3iFi33SRj32oU4PB2aFzzPJVWcEK2uiuborzB52xIe
	A5yvxEl1uyf0teu4+t9mByUTAVp2vVQyDBZe98Bb3BilkzcI8Nkzj6BvTPTiBQ0iE=
X-Google-Smtp-Source: AGHT+IE3Y1AoF6Zbsj6EnPiZSX/ljTgCnU9UJMmTnq9iwUTestBp2d1ByiGJgV/xm8MwNcR4oa6vPw==
X-Received: by 2002:a05:600c:3ba8:b0:471:9da:524c with SMTP id 5b1f17b1804b1-477b198ca22mr26146925e9.12.1763559376963;
        Wed, 19 Nov 2025 05:36:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1012a92sm49026715e9.4.2025.11.19.05.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:36:16 -0800 (PST)
Date: Wed, 19 Nov 2025 13:36:15 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119133615.2eefb7db@pumpkin>
In-Reply-To: <20251119095516.GA13783@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
	<20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
	<20251118050311.GA21569@lst.de>
	<20251119095516.GA13783@unreal>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 11:55:16 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Tue, Nov 18, 2025 at 06:03:11AM +0100, Christoph Hellwig wrote:
> > On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:  
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > This patch changes the length variables from unsigned int to size_t.
> > > Using size_t ensures that we can handle larger sizes, as size_t is
> > > always equal to or larger than the previously used u32 type.
> > > 
> > > Originally, u32 was used because blk-mq-dma code evolved from
> > > scatter-gather implementation, which uses unsigned int to describe length.
> > > This change will also allow us to reuse the existing struct phys_vec in places
> > > that don't need scatter-gather.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > ---
> > >  block/blk-mq-dma.c      | 8 ++++++--
> > >  drivers/nvme/host/pci.c | 4 ++--
> > >  2 files changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > > index e9108ccaf4b0..e7d9b54c3eed 100644
> > > --- a/block/blk-mq-dma.c
> > > +++ b/block/blk-mq-dma.c
> > > @@ -8,7 +8,7 @@
> > >  
> > >  struct phys_vec {
> > >  	phys_addr_t	paddr;
> > > -	u32		len;
> > > +	size_t		len;
> > >  };  
> > 
> > So we're now going to increase memory usage by 50% again after just
> > reducing it by removing the scatterlist?  
> 
> It is slightly less.
> 
> Before this change: 96 bits

Did you actually look?
There will normally be 4 bytes of padding at the end of the structure.

About the only place where it will be 12 bytes is a 32bit system with
64bit phyaddr that aligns 64bit items on 32bit boundaries - so x86.

	David

> After this change (on 64bits system): 128 bits.
> 
> It is 33% increase per-structure.
> 
> So what is the resolution? Should I drop this patch or not?
> 
> Thanks 
> 


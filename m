Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098321D4335
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911551; cv=none; b=KmTbhcEzQ0CieYsgERkN/rj/wonudVMEDrq/XimCpwBYHsnaIkBLTgIHSBmJx0O8Dv7USDBZq86kOlfkCfu067+l76B0hzueJ0p6RuXPDknpXGgELIBFGbt80s4veYKoNGa+KVOreJq4981azrmSN3TFDSQJ5Rjs127LFKhE1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911551; c=relaxed/simple;
	bh=gc3RP/0P0JdzF/BDYzfxagvHOhA61NzsSD7nKlydGWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE9hjmKRWhC6EaXWwA2qRKSDziUUz+ntqYuWxkdz9egjsQj5iX6bIplia/UKnpay4yvGysSdGz37iQK77Foh392IIZOmCGF/rapvoUmojXvqYlGDqFEjaC1/kTAcAxJSOBOL3dX0j6j3BM5vCVqPuL1ScXRzi76atqQR8/cx0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S4Uzpb9d; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S4Uzpb9d"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc29ac55b5so1126655a91.2
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 12:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739911549; x=1740516349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0mGua/Ma6eV6C9Fy5HjGJ6Vk0axOaTEsT8ftn0BtmY=;
        b=S4Uzpb9drFXVXy4Da5MY1Y8jyyaeIiCetISFf9WaZNsCiRyFGBt9gXFwyEs36CJl2D
         eQivamRXlvYd8te6DiRi2eCnbQH6MHFM2ZDSGnwfbJoAn/knJMKG1MtV0bXWEXE9p/4t
         5l6rjXlSveNjKV+6w3NOYJTEoDblNUBuUXqHr9+to1E3BNp9nz2spMR8w+K/Vmfvi5pD
         C1wUhnxPzHO4oIr8/7/a7pkTwXNs3Pmw7LtHYa8pLHuHs9nSiBTMXWi8/i0to1068v57
         pDc14IEuHomeaZS6qdyVm/iH2bMKuDkrKJHTnKz/JBWVljWEA2cZhIawVUfV7bGY+Y7c
         aBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739911549; x=1740516349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0mGua/Ma6eV6C9Fy5HjGJ6Vk0axOaTEsT8ftn0BtmY=;
        b=eWPsC81h3XRRT63mXq1pzJh4bn7PVRh5txk+/7CjCd2xIK9PH92At0TZUuyyPpzpqh
         jtyhwW8u+woxyDJ60fW2TAfqkU4wx/a1Q5sCbZrMBZj1V/GGrq1aCk8rJQyl4R64dUcm
         xXqosXV6k4yaMS6lUdi47jLo4FuIwjv1hqS8ToVFl9jf0vXbL3yecZvik9IxUGO8P81P
         d82jgN+YDQSgCJDajqdJG3TXE84zBUoFaqKg4zA7bCulOteAkf8MmoUTmgWTxGmX51rR
         agdo0q2ny1fFgTsntKJd40fVDV8C6TCeeFs4HteY3oMSq7WFlNscbrzrW6e8JBokeyuq
         J0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVXOF7N18jv4uj1P0GY9vns68c9cwW2EPNivfKVRrvoovyEz0Dw/Nilgruuc+4ETsTDC3tfJ6cOmgM46Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhI4HKyakULDaL/faWxlWJvpC0TKYlQwkVCWCnVLC+MkpgBzD
	6drPs6C7h/qK3s+A73XktniZfiHn5Yk9bn/fflFlFMTbgrmsuPj9+zKZfot40KN4YC/K3mhWRCj
	g3JnS2o0+hBmJqg2zNCGkM3fHsM0EbWFF0cua2w==
X-Gm-Gg: ASbGncuwfCFVmKR8kpqMMQU/aflHfpOi4ESpomEnr7EeKDgfIwUVhVOPnWJUaF7pVXP
	H816gDguRx2CE56NMDfbzjUFcx5Basft1+w5trxkXOHodR+uIg73MmwcFtFpnvrNZFU1lplA=
X-Google-Smtp-Source: AGHT+IGfALKgUqDALD/4sLBrBcMFpBT3n6eej/o0Bmt9OTOO7UBBJMFyK+1UCppjNjFjx+6h0CClEQpahL8mdfLrYlg=
X-Received: by 2002:a17:90b:2241:b0:2ee:b665:12c2 with SMTP id
 98e67ed59e1d1-2fc40d1246amr8774025a91.2.1739911549252; Tue, 18 Feb 2025
 12:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214154348.2952692-1-kbusch@meta.com> <20250214154348.2952692-6-kbusch@meta.com>
 <CADUfDZpM-TXBYQy0B4xRnKjT=-OfX+AYo+6HGA7e7pyT39LxEA@mail.gmail.com>
 <CADUfDZrfmpy3hxD5z0ADxCUkWPbU0aZDMiqpyPE+AZbeDSgZ=g@mail.gmail.com> <Z7TptdubsPCFulfV@kbusch-mbp>
In-Reply-To: <Z7TptdubsPCFulfV@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 18 Feb 2025 12:45:38 -0800
X-Gm-Features: AWEUYZkU0HQ5Ia4fNBDiB57kFmWi9Rcb3_aZzJWUz4eHCh0QO05fO6eJnoexxXI
Message-ID: <CADUfDZqCooGdCDRYeT8MscehLgQ7OQA6mT97+Tf0NF6Ki3MLWw@mail.gmail.com>
Subject: Re: [PATCHv3 5/5] io_uring: cache nodes and mapped buffers
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com, asml.silence@gmail.com, 
	axboe@kernel.dk, linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 12:12=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Sun, Feb 16, 2025 at 02:43:40PM -0800, Caleb Sander Mateos wrote:
> > > > +       io_alloc_cache_free(&table->imu_cache, kfree);
> > > > +}
> > > > +
> > > >  int io_sqe_buffers_unregister(struct io_ring_ctx *ctx)
> > > >  {
> > > >         if (!ctx->buf_table.data.nr)
> > > >                 return -ENXIO;
> > > > -       io_rsrc_data_free(ctx, &ctx->buf_table.data);
> > > > +       io_rsrc_buffer_free(ctx, &ctx->buf_table);
> > > >         return 0;
> > > >  }
> > > >
> > > > @@ -716,6 +767,15 @@ bool io_check_coalesce_buffer(struct page **pa=
ge_array, int nr_pages,
> > > >         return true;
> > > >  }
> > > >
> > > > +static struct io_mapped_ubuf *io_alloc_imu(struct io_ring_ctx *ctx=
,
> > > > +                                          int nr_bvecs)
> > > > +{
> > > > +       if (nr_bvecs <=3D IO_CACHED_BVECS_SEGS)
> > > > +               return io_cache_alloc(&ctx->buf_table.imu_cache, GF=
P_KERNEL);
> > >
> > > If there is no entry available in the cache, this will heap-allocate
> > > one with enough space for all IO_CACHED_BVECS_SEGS bvecs. Consider
> > > using io_alloc_cache_get() instead of io_cache_alloc(), so the
> > > heap-allocated fallback uses the minimal size.
> > >
> > > Also, where are these allocations returned to the imu_cache? Looks
> > > like kvfree(imu) in io_buffer_unmap() and io_sqe_buffer_register()
> > > needs to try io_alloc_cache_put() first.
> >
> > Another issue I see is that io_alloc_cache elements are allocated with
> > kmalloc(), so they can't be freed with kvfree().
>
> You actually can kvfree(kmalloc()); Here's the kernel doc for it:
>
>   kvfree frees memory allocated by any of vmalloc(), kmalloc() or kvmallo=
c()

Good to know, thanks for the pointer! I guess it might be a bit more
efficient to call kfree() if we know based on nr_bvecs that the
allocation came from kmalloc(), but at least this isn't corrupting the
heap.

Best,
Caleb

>
> > When the imu is
> > freed, we could check nr_bvecs <=3D IO_CACHED_BVECS_SEGS to tell whethe=
r
> > to call io_alloc_cache_put() (with a fallback to kfree()) or kvfree().
>
> But you're right, it shouldn't even hit this path because it's supposed
> to try to insert the imu into the cache if that's where it was allocated
> from.

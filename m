Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993501BD9D8
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731048686; cv=none; b=W1HnXFYpAw+NpLWnlCdSCniB1oWt4DQtssqPbQJaSuijo8YChomWWyvVvMKGkprD1m/QGxi+GvFnHxGwnIlzeTuXBFVE9zOGiEusHE81yUTkZu+lSDyhMKFc9Z7RY/R/Ei864pyIIbczzUOh2NU0vW7gxjQfK5EuxyHNv9NRdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731048686; c=relaxed/simple;
	bh=Uwj8TZfhAdUXNOP0gmz6Rozx/iAres4gBdo+x6A1W6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DetpvvWRklkdiOt1sl2W6A9in8FeHr1K3kxjC/AVCpRKRCyN0JXsDwiXwkDhsxlIznCGPH/F59k/o8O5ITwwpRuDaflW7WGHd2h3k6o7194SmkF317vFPJStpfu6/Ks4pah7QDNsjt0N6hslnpANbbFHQ1DabhYasYzgryY8Dc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Srr7hZ7+; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srr7hZ7+"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50d34db4edeso1312324e0c.0
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 22:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731048683; x=1731653483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/x8OS/dbVQbN/39ZA54E6EOHTTw1AI3bxvOtuzpiWo=;
        b=Srr7hZ7+oOUWqtMtt6gd+feGUwwJzdnUsShP79nRi1Jr7fBW3iOGd9F7c5bimttxo7
         rLsOs9SJC9MqCf2MuAwmF2S3az2NjJBiEEQAuNhki5quAnTihETrvhJ1o/e8u2OMFgSZ
         XpHD+R8Zq9ra1FYzFzKriToPhUMyDqG9+4ZoHcgN8ARtuY1SiBe1dDqQN04SYIJfwZ1Q
         5aNgt7IsFZwUNS2wN/gV2JNQMR5Qaps9Brvex5HMC5BYVKsjZ5mEsW2gi1JGt863Y42w
         nDOS6bQ9fVpCEUPdKKjwx/l2pdF57SfW1bJOjMaP15fvC6Zv72+UzpnsNtGvCEaXQOkH
         e2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731048683; x=1731653483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/x8OS/dbVQbN/39ZA54E6EOHTTw1AI3bxvOtuzpiWo=;
        b=HonQbQIXeCUAlZh7zgC359E1n/+DU5s9DwhAkQIey7qYsjB+5Rrj79hEuRyqbXY9XU
         8H8t5ctQKfsvsXSAEDt7RJ3Lv7W3Wo68n1FyODBCRWXd8EXX+TyQahTm6DrY2fPZMDV1
         cj8YVyK5toLad/7EfPEyCAdzo+LGEDtytgZ/uO4OUrYb/z+aEjSPiIz6MaeAx9yN9dSw
         zD8oYC2SWgTBKSIRnKfd6dNgbihjEwNXsJ0+GEgPhD6NWvtZk6zHex5htz+vLJ5F6qzz
         6kGNFjvX9RARcTwzVki8f+OMFkE8iBrJV7iItfwPKuJRYHP7te6ZrekVoMc3Hrc+epxV
         4y4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcntzEF+H3izCjwbHcy+yQz7EhpvB6DJzICnf0fgWsnvyrup2rwdDKqQVbrlRSTQmgN05fodCVAU1oNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaXM31ySiq2SnTNvlsf1aPwFb9FFpBiY0WGYHLvr6/G3XflB13
	+wrdyYnPbp4gAZqxWOS7Ijp/Pj/iV6p3pfraU5Zx55icMfc9hzPpTvgfM4DmtxuY1rCQ/Jd1woP
	6QoUgMkKEoTKTePwuw2jwH19R52g=
X-Google-Smtp-Source: AGHT+IH7kUuIZa2vfKwPYPTg9nq9/C2sMTAeKq8r3tJMucaNqEigVgTz4bKbe03UFM9znsRNLTpYPaK+o9Pzpot+Wqw=
X-Received: by 2002:a05:6122:1d56:b0:50d:6cfc:ac4d with SMTP id
 71dfb90a1353d-514026152dcmr1169824e0c.5.1731048683318; Thu, 07 Nov 2024
 22:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com> <87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 8 Nov 2024 19:51:12 +1300
Message-ID: <CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, axboe@kernel.dk, 
	bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com, 
	linux-block@vger.kernel.org, minchan@kernel.org, nphamcs@gmail.com, 
	senozhatsky@chromium.org, surenb@google.com, terrelln@fb.com, 
	v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, willy@infradead.org, 
	yosryahmed@google.com, yuzhao@google.com, zhengtangquan@oppo.com, 
	zhouchengming@bytedance.com, usamaarif642@gmail.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 6:23=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Hi, Barry,
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > When large folios are compressed at a larger granularity, we observe
> > a notable reduction in CPU usage and a significant improvement in
> > compression ratios.
> >
> > mTHP's ability to be swapped out without splitting and swapped back in
> > as a whole allows compression and decompression at larger granularities=
.
> >
> > This patchset enhances zsmalloc and zram by adding support for dividing
> > large folios into multi-page blocks, typically configured with a
> > 2-order granularity. Without this patchset, a large folio is always
> > divided into `nr_pages` 4KiB blocks.
> >
> > The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
> > setting, where the default of 2 allows all anonymous THP to benefit.
> >
> > Examples include:
> > * A 16KiB large folio will be compressed and stored as a single 16KiB
> >   block.
> > * A 64KiB large folio will be compressed and stored as four 16KiB
> >   blocks.
> >
> > For example, swapping out and swapping in 100MiB of typical anonymous
> > data 100 times (with 16KB mTHP enabled) using zstd yields the following
> > results:
> >
> >                         w/o patches        w/ patches
> > swap-out time(ms)       68711              49908
> > swap-in time(ms)        30687              20685
> > compression ratio       20.49%             16.9%
>
> The data looks good.  Thanks!
>
> Have you considered the situation that the large folio fails to be
> allocated during swap-in?  It's possible because the memory may be very
> fragmented.

That's correct, good question. On phones, we use a large folio pool to main=
tain
a relatively high allocation success rate. When mTHP allocation fails, we h=
ave
a workaround to allocate nr_pages of small folios and map them together to
avoid partial reads.  This ensures that the benefits of larger block compre=
ssion
and decompression are consistently maintained.  That was the code running
on production phones.

We also previously experimented with maintaining multiple buffers for
decompressed
large blocks in zRAM, allowing upcoming do_swap_page() calls to use them wh=
en
falling back to small folios. In this setup, the buffers achieved a
high hit rate, though
I don=E2=80=99t recall the exact number.

I'm concerned that this fault-around-like fallback to nr_pages small
folios may not
gain traction upstream. Do you have any suggestions for improvement?

>
> > -v2:
> >  While it is not mature yet, I know some people are waiting for
> >  an update :-)
> >  * Fixed some stability issues.
> >  * rebase againest the latest mm-unstable.
> >  * Set default order to 2 which benefits all anon mTHP.
> >  * multipages ZsPageMovable is not supported yet.
> >
> > Tangquan Zheng (2):
> >   mm: zsmalloc: support objects compressed based on multiple pages
> >   zram: support compression at the granularity of multi-pages
> >
> >  drivers/block/zram/Kconfig    |   9 +
> >  drivers/block/zram/zcomp.c    |  17 +-
> >  drivers/block/zram/zcomp.h    |  12 +-
> >  drivers/block/zram/zram_drv.c | 450 +++++++++++++++++++++++++++++++---
> >  drivers/block/zram/zram_drv.h |  45 ++++
> >  include/linux/zsmalloc.h      |  10 +-
> >  mm/Kconfig                    |  18 ++
> >  mm/zsmalloc.c                 | 232 +++++++++++++-----
> >  8 files changed, 699 insertions(+), 94 deletions(-)
>
> --
> Best Regards,
> Huang, Ying

Thanks
barry

Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4BF4C91
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374722; cv=none; b=HQ4Wl58aF5lmi79wvM1giG+5SJhvyEmwvGT8PcaLQhCXPVXV7G/tJc3qiQoRSZYog9lw2Gp7vYzjl6wsGlQy8IRqoEcrlE7LM5nLwxSsB37NU2BuAnlUezDLXa10zu8vZTgJp8ZwCjB6XeR+bGCHHSPta0XvqIllwLwjBdoldCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374722; c=relaxed/simple;
	bh=RysFHVSo5o7jqW3JPG7m2y5uotteeAUJaRVhWomsPsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwLvqVK5CNbKXdHjOCrUH+cmSlhvmz9A9FYWPjxPrkkKjWS6JaRZuC8LALqD0cBRkv1DrNC5NcZT/bmLl5p4pYZrVBC3VXhOwGBM3sTycVnAps9oSbbQFxHTqUlrvi215VxGZySUzdhISxTCO78dXtT/H01iB5hfBXlVxiyasXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9JN2EaY; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9JN2EaY"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84fcb49691fso1949021241.3
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 17:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731374719; x=1731979519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Jb8HZFwjTgBBgQWpyumYyekfI9KcaXCVTYppwT7xjU=;
        b=K9JN2EaY8GSByYeDNd+M7hiisxXTu73MZeigOnB8rCZj8AvNjBli+BgZ4HMjHw4BhS
         v0VE7D5i3TJ04zlt85wqy80GwFNINKzfe174XeumAHJ9zyHTuzJvWsZL0wBwQEn6VjCX
         DISpNZ8eQwTNS74IIZyxcq46iiYULy04bYfgKYl0nqkqpo8JgLqkD59mr4MT5FAnzCJn
         nKwHJ47GGyLeDQDWt7aX3PzI/27eGQOsIhrCweCWtVrVLDJnN1l62ZlxeFchxB4KU4ji
         Q3Fdge4+tZxPLbhdGH2FhTwaxSlS1deO07R2mWljCzwJnW4M90a3UTMTECRCtJdSPOEs
         revg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731374719; x=1731979519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Jb8HZFwjTgBBgQWpyumYyekfI9KcaXCVTYppwT7xjU=;
        b=xQHX+IWEDw5IfAeaj8dz7k3EVDGCydxOKKUcxOyn9TYiQ+oNU+DWpUK7rWaEPao4ZO
         rVi+4G13cpoKb58MBr/mDaH9SunFxcq1PB80pccR2VCnkQsQD82O8KIld/J60yi9QbGG
         28Heh5+f7+yqSLlPw/WF4aJSe3wxig7EA7yDRonbxIpoflGElHa2OzHZVjjoi+YyCPxM
         giPfPQKUbcOX0ACoJC1UkMsc4KWOy7wFj9DQD7AghOBT0Qsl2fd1/0RLyXhVV6VBLNj3
         nOBPIE/st0V5t0Ip3QWGS/2Pz4j+j7+3jz5+HJGEsBlKV0ZmUx8poG+39xLkt1n9RMMi
         nvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOZLdq+sdAPTmMMVk8lDP8v9DoUZWpfuuivKlB3qSym8sBF3fGWvGZjpVYNE+lY927IR5yo1HU6i6/6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4JCnwYHV0dubWvwdoGVYwa5CUv7+PwAg7NliMfnW979YFXok
	Yp2vp7++cTvQMsrJn74jCq+/CCCGQoXmwnKAmuMqPDfrLaUOrAfVIkxXvqUQKMKlIPb8W9IQZnZ
	4axN1WYtmpc+HctAhenDyBw4Fa+0=
X-Google-Smtp-Source: AGHT+IESKdmJLz3BQ/czXr6ySr7v/cZowB2uRuxM5sPu1mAN9fnOFfYjMoB216FVIDyikFzvneMbFhNHq9JyffnnPtI=
X-Received: by 2002:a05:6102:3f4e:b0:4a4:7928:637c with SMTP id
 ada2fe7eead31-4ac297a4616mr975258137.8.1731374719449; Mon, 11 Nov 2024
 17:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com> <87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com> <87pln1z2da.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87pln1z2da.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 12 Nov 2024 14:25:08 +1300
Message-ID: <CAGsJ_4xVB4EKR9pitLa3aUmxiHUr8VNSS=QQ12_peO7PGvTZfg@mail.gmail.com>
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

On Tue, Nov 12, 2024 at 2:11=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Fri, Nov 8, 2024 at 6:23=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> Hi, Barry,
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >
> >> > When large folios are compressed at a larger granularity, we observe
> >> > a notable reduction in CPU usage and a significant improvement in
> >> > compression ratios.
> >> >
> >> > mTHP's ability to be swapped out without splitting and swapped back =
in
> >> > as a whole allows compression and decompression at larger granularit=
ies.
> >> >
> >> > This patchset enhances zsmalloc and zram by adding support for divid=
ing
> >> > large folios into multi-page blocks, typically configured with a
> >> > 2-order granularity. Without this patchset, a large folio is always
> >> > divided into `nr_pages` 4KiB blocks.
> >> >
> >> > The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
> >> > setting, where the default of 2 allows all anonymous THP to benefit.
> >> >
> >> > Examples include:
> >> > * A 16KiB large folio will be compressed and stored as a single 16Ki=
B
> >> >   block.
> >> > * A 64KiB large folio will be compressed and stored as four 16KiB
> >> >   blocks.
> >> >
> >> > For example, swapping out and swapping in 100MiB of typical anonymou=
s
> >> > data 100 times (with 16KB mTHP enabled) using zstd yields the follow=
ing
> >> > results:
> >> >
> >> >                         w/o patches        w/ patches
> >> > swap-out time(ms)       68711              49908
> >> > swap-in time(ms)        30687              20685
> >> > compression ratio       20.49%             16.9%
> >>
> >> The data looks good.  Thanks!
> >>
> >> Have you considered the situation that the large folio fails to be
> >> allocated during swap-in?  It's possible because the memory may be ver=
y
> >> fragmented.
> >
> > That's correct, good question. On phones, we use a large folio pool to =
maintain
> > a relatively high allocation success rate. When mTHP allocation fails, =
we have
> > a workaround to allocate nr_pages of small folios and map them together=
 to
> > avoid partial reads.  This ensures that the benefits of larger block co=
mpression
> > and decompression are consistently maintained.  That was the code runni=
ng
> > on production phones.
> >
> > We also previously experimented with maintaining multiple buffers for
> > decompressed
> > large blocks in zRAM, allowing upcoming do_swap_page() calls to use the=
m when
> > falling back to small folios. In this setup, the buffers achieved a
> > high hit rate, though
> > I don=E2=80=99t recall the exact number.
> >
> > I'm concerned that this fault-around-like fallback to nr_pages small
> > folios may not
> > gain traction upstream. Do you have any suggestions for improvement?
>
> It appears that we still haven't a solution to guarantee 100% mTHP
> allocation success rate.  If so, we need a fallback solution for that.
>
> Another possible solution is,
>
> 1) If failed to allocate mTHP with nr_pages, allocate nr_pages normal (4k=
)
>    folios instead
>
> 2) Revise the decompression interface to accept a set of folios (instead
>    of one folio) as target.  Then, we can decompress to the normal
>    folios allocated in 1).
>
> 3) in do_swap_page(), we can either map all folios or just the fault
>    folios.  We can put non-fault folios into swap cache if necessary.
>
> Does this work?

this is exactly what we did in production phones:

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/blob/oneplu=
s/sm8650_u_14.0.0_oneplus12/mm/memory.c#L4656
[2] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/blob/oneplu=
s/sm8650_u_14.0.0_oneplus12/mm/memory.c#L5439

I feel that we don't need to fall back to nr_pages (though that's what
we used on phones);
using a dedicated 4 should be sufficient, as if zsmalloc is handling
compression and
decompression of 16KB. However, we are not adding them to the
swapcache; instead,
they are mapped immediately.

>
> >>
> >> > -v2:
> >> >  While it is not mature yet, I know some people are waiting for
> >> >  an update :-)
> >> >  * Fixed some stability issues.
> >> >  * rebase againest the latest mm-unstable.
> >> >  * Set default order to 2 which benefits all anon mTHP.
> >> >  * multipages ZsPageMovable is not supported yet.
> >> >
> >> > Tangquan Zheng (2):
> >> >   mm: zsmalloc: support objects compressed based on multiple pages
> >> >   zram: support compression at the granularity of multi-pages
> >> >
> >> >  drivers/block/zram/Kconfig    |   9 +
> >> >  drivers/block/zram/zcomp.c    |  17 +-
> >> >  drivers/block/zram/zcomp.h    |  12 +-
> >> >  drivers/block/zram/zram_drv.c | 450 +++++++++++++++++++++++++++++++=
---
> >> >  drivers/block/zram/zram_drv.h |  45 ++++
> >> >  include/linux/zsmalloc.h      |  10 +-
> >> >  mm/Kconfig                    |  18 ++
> >> >  mm/zsmalloc.c                 | 232 +++++++++++++-----
> >> >  8 files changed, 699 insertions(+), 94 deletions(-)
> >>
>
> --
> Best Regards,
> Huang, Ying

Thanks
barry

Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CC85C5E
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361071; cv=none; b=tyCBTaRbAmQ0hwzqHTFv5xDcFmDL9ZtrvxOVWuxMipTmqELfLAVdpbBt9O3c28dP8enNEw6Lit3bbGoqnJvHtOKzc5IMqox96H6RhhpsVO1EXfOMYL8yFHJO4gdfu+VQJVqDRJPSs1lKsxCwHQrWGW+gBjDY9GWBx6F3kGXOxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361071; c=relaxed/simple;
	bh=Zd0120qwwdJ7nQ6bQS8hCwF+ppErEZKCYVwd5Cdzc9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eF7q8Ml+CxwvzAhMKNJDA8LYsGD8NrYzVcla8PR67ajzfM9waKX58f2Rc6G6a/ctNQnEh22YQnIqxA0PeMHm1K6JsOp7hZtoybMy4MlkvOv3M0nzDd8nrGiBDEZ5T6ZACDG6JB2jolDWnlbu7OfxxCBtJ5yXlzCEmSPJKSOn4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsz3UnZV; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsz3UnZV"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-513de426863so1797173e0c.0
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 13:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731361069; x=1731965869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuDxd3x4l+C+rN/QwF5MT9fpvKTkpINe3cU070JO6c0=;
        b=bsz3UnZVtYpYhXc4b+6Hao8IqgX68r+dDeDPD8HrfQRf3u4pVmH0zZ00vWVFDi9zeF
         tR8gkDQpEdkGdGM39YyNbOlAdeIK+drZQGLnbeTWC+0nfF/l9j/vzXtZp8Vt2lKgZoIz
         eDgpTtC8uzwnR8w9BIlMm/SHjYw6ZpjS3vaZOHW4jRgyyb+1kVWBnFbX2NYXh/kOSql4
         Ucq4s25R83Jz91Gt3dOacax2DFD0KnI0oa9UnzUu1tkJ6edmOACO2Nra5B6hTwNAUbEu
         yomcXdlSaT523vWWgn7aI43j1ET631wY2EbzfJjoQQ+KVc4sBH0ScSnAG5cUp3OE2py0
         JSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731361069; x=1731965869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuDxd3x4l+C+rN/QwF5MT9fpvKTkpINe3cU070JO6c0=;
        b=s44C8xN8YftxOodVI+A1JjO1lb383BtiDvNA1TmlfDqftrFc36wzSm1qiTJXrrWy9p
         0vz/JK0DZrEPRVmSc03XQvx8iRYUkQFXHL/WKrtbWjMQBRikRuxKfH70BcnjixJVLIXC
         2bZsekwTSwIOo2Z0nOuoLgX3yIII3OV1LLx8vNhTX1/0THgz+EozhGL1xpWlSE0BJrYk
         Kw5V41tPdl7TaKXDAl99iiTUvnaXf1iXxjAuMIKppTpIMoE18m1wGal5v+I7XVT+bRpv
         iHakIxNWD6OrsO4JPCTkOrmL1w4OQKxQv4+xAVEbWWArPb2bB1gwuLrVdfRpVI2SVxpY
         iphA==
X-Forwarded-Encrypted: i=1; AJvYcCX+l/RX8JVKLnML5Esrx/ryOTL60VlmKsIET1AQsyDSvOE1mnNNhS7zqDiWt5Dac0PWazNYgpmxRM/PMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDzW9msQWI3Nt4cQjshwmm60DZLo1HspiRPIjwoy02itRnTjsG
	iGWAjq2fzpm6A09LXLZZEmKnCHKue9K9toLfXuqf5AoZZxHjKkBQtVDL5KzU9tgfnFU5TMqldOM
	MYg/LMlwhY2isP3XQZeSqI1x4kH4=
X-Google-Smtp-Source: AGHT+IEZbfVH8+TjKOm7Cz6Xy1F3alpjr90SF2ywe2hZD+zQKQYhqpmH0zHzRU3SUvid+W4BwYmepJO/jJ8vuu8Pa1A=
X-Received: by 2002:a05:6122:1816:b0:50d:bfd3:c834 with SMTP id
 71dfb90a1353d-51401bc6114mr13314982e0c.4.1731361068531; Mon, 11 Nov 2024
 13:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com> <CAKEwX=OAE9r_VH38c3M0ekmBYWb5qKS-LPiBFBqToaJwEg3hJw@mail.gmail.com>
In-Reply-To: <CAKEwX=OAE9r_VH38c3M0ekmBYWb5qKS-LPiBFBqToaJwEg3hJw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 12 Nov 2024 10:37:37 +1300
Message-ID: <CAGsJ_4y+DeCo7oF+Ty8x9rHreh9LaS9XDU85yz81U9FQgBYE8A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, axboe@kernel.dk, 
	bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com, 
	linux-block@vger.kernel.org, minchan@kernel.org, senozhatsky@chromium.org, 
	surenb@google.com, terrelln@fb.com, v-songbaohua@oppo.com, 
	wajdi.k.feghali@intel.com, willy@infradead.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, zhengtangquan@oppo.com, 
	zhouchengming@bytedance.com, usamaarif642@gmail.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:30=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Nov 7, 2024 at 2:10=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
> >
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
> The data looks very promising :) My understanding is it also results
> in memory saving as well right? Since zstd operates better on bigger
> inputs.
>
> Is there any end-to-end benchmarking? My intuition is that this patch
> series overall will improve the situations, assuming we don't fallback
> to individual zero order page swapin too often, but it'd be nice if
> there is some data backing this intuition (especially with the
> upstream setup, i.e without any private patches). If the fallback
> scenario happens frequently, the patch series can make a page fault
> more expensive (since we have to decompress the entire chunk, and
> discard everything but the single page being loaded in), so it might
> make a difference.
>
> Not super qualified to comment on zram changes otherwise - just a
> casual observer to see if we can adopt this for zswap. zswap has the
> added complexity of not supporting THP zswap in (until Usama's patch
> series lands), and the presence of mixed backing states (due to zswap
> writeback), increasing the likelihood of fallback :)

Correct. As I mentioned to Usama[1], this could be a problem, and we are
collecting data. The simplest approach to work around the issue is to fall
back to four small folios instead of just one, which would prevent the need
for three extra decompressions.

[1] https://lore.kernel.org/linux-mm/CAGsJ_4yuZLOE0_yMOZj=3DKkRTyTotHw4g5g-=
t91W=3DMvS5zA4rYw@mail.gmail.com/

Thanks
Barry

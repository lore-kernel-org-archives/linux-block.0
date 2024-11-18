Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923743D551
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925637; cv=none; b=CnC91sp64VPm3pRg0HP90Wgx9LTaxDu5gQly+vhVGOt3KzeLbFhqx+OJMfw7I690mEpC6R/17dcDeq0v4J6M14b1dDRs06u7RZwxP+WX3Mg4MNSrMB+zH91DCWKLyBG7mUcR6StbdcqwFohFA3lDg67I3RlP09Get/KLLwCn9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925637; c=relaxed/simple;
	bh=qsF5EMCSVWsk9DWsMsNg+VBeabQR4pZiruiM7gIboKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsFEXsdGBntr/1cYGZZPZoXTV9A/KxTjAoYs/8ILw8UrQfqZBIVYswv8qqfTfVpIi0u+tk9teeW7eNdNqpv2V+RYmWzZJcKY0u1R44qe/qpivFzCMKq2EuVXVLlmWZZhI2JcWHBzQXzqpkdjJcQfM+nDctgcRb+hp6U73hWMXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMp8Df49; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMp8Df49"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50e08caccaaso1552717e0c.3
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 02:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731925634; x=1732530434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBKIink2BgWRUKJgTW5YrrRAT4RmtW/o5Huze++s3JY=;
        b=PMp8Df4918CcuH9Q2j4xqs6VO1stmCVtYzPR1rMO7rF2vdT3bNvIB/MNXiIPqzPm4N
         0KnIQjoY4pGuQwV909+/v0g7qOZ17ytvMfK/XdjSgJjoS5JaqBUGxGcbWe+ZSgPsK4kI
         iT3i3Tl7cldWlzXbT+81u9mkwK79YF+cl1iZCfsX27rzAa0b9uO9B0TxYL2qYbbDhaBO
         W2SoVnKFz6bBHnYlD4T2jvuYbDdhKuxGLINNHCD7xtRrehMalfQHMwA6TxftkCtD8blz
         EnZO7WoZ6CBKybg/fiyoeazGkobvN2iwPaam0J3j16V4n3dt4CcpqfHfn8XiDXSjQGIc
         pEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925634; x=1732530434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBKIink2BgWRUKJgTW5YrrRAT4RmtW/o5Huze++s3JY=;
        b=fyXHgWSeVpFDF7zo8fZ4Vxv4u0K7XfPlWqmc48pDfU3OEtltWLNNqyDZWcx9INKvhH
         r7QYFfwWlDUqEMSvYzYF7ep9KZ6zuTWJUCtY6mVQn8Or1xyOF9avBnhRSL8bLFoGnvFC
         Uf1P1l84t7GP+03zuZzNzGbf0+EDrOEXxVgwnSkK/reDAg36cFEZgNw5hSsl/+jyqYSX
         meHXP+/d90hIW93gX+DyZvOGU6G8U+8m6nhMPubSG4ktUrXA17quEnGTQ68PkAcUEqWk
         Ytls2yOtVgkICVbU6bhhi36CsXusykiBmcwFwQl2HO4QEtdxKP+sd5EamFGb0a84GFhY
         UFlw==
X-Forwarded-Encrypted: i=1; AJvYcCVC+qmgo50fJ6Yq2wrl/Anqv2jsmz9ACIgoEDSg/CLaravnnNB29cNrLg/bjus8+NKWDFXsHkQh+6ozXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtfoNMYuirwCAMpE8gF7Z/X4eppAQXI/DtjPn9QSmqIH87zMga
	z8kd/iX1W6jSOgwvt5jHqNu5QFAJmyttNy00MPbfaUScZw/ktBY9JNRVa9HZVkckF4gWl/c/Ipw
	IJDSVczhrCt/4fCwJhX7q7x01LUM=
X-Google-Smtp-Source: AGHT+IEgFQ/P+plwWw9WRkDaMfhRIUQJ4AFOdPn7FZ2NhFgWj5MBtua6yEaCfs/JRDtKIdMV/4GaSIsr1H5na+53xlg=
X-Received: by 2002:a05:6122:54b:b0:50d:869a:e542 with SMTP id
 71dfb90a1353d-51477f99ce3mr10392529e0c.9.1731925634344; Mon, 18 Nov 2024
 02:27:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com> <CAKEwX=OAE9r_VH38c3M0ekmBYWb5qKS-LPiBFBqToaJwEg3hJw@mail.gmail.com>
 <CAGsJ_4y+DeCo7oF+Ty8x9rHreh9LaS9XDU85yz81U9FQgBYE8A@mail.gmail.com>
In-Reply-To: <CAGsJ_4y+DeCo7oF+Ty8x9rHreh9LaS9XDU85yz81U9FQgBYE8A@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 18 Nov 2024 23:27:03 +1300
Message-ID: <CAGsJ_4zojYeEqgTcH-sKek9LW0pYOUoXcrzOzjoMuzMMODujbA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Nhat Pham <nphamcs@gmail.com>, usamaarif642@gmail.com, ying.huang@intel.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, axboe@kernel.dk, 
	bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com, 
	linux-block@vger.kernel.org, minchan@kernel.org, senozhatsky@chromium.org, 
	surenb@google.com, terrelln@fb.com, v-songbaohua@oppo.com, 
	wajdi.k.feghali@intel.com, willy@infradead.org, yosryahmed@google.com, 
	yuzhao@google.com, zhengtangquan@oppo.com, zhouchengming@bytedance.com, 
	ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 10:37=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Tue, Nov 12, 2024 at 8:30=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Thu, Nov 7, 2024 at 2:10=E2=80=AFAM Barry Song <21cnbao@gmail.com> w=
rote:
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > When large folios are compressed at a larger granularity, we observe
> > > a notable reduction in CPU usage and a significant improvement in
> > > compression ratios.
> > >
> > > mTHP's ability to be swapped out without splitting and swapped back i=
n
> > > as a whole allows compression and decompression at larger granulariti=
es.
> > >
> > > This patchset enhances zsmalloc and zram by adding support for dividi=
ng
> > > large folios into multi-page blocks, typically configured with a
> > > 2-order granularity. Without this patchset, a large folio is always
> > > divided into `nr_pages` 4KiB blocks.
> > >
> > > The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
> > > setting, where the default of 2 allows all anonymous THP to benefit.
> > >
> > > Examples include:
> > > * A 16KiB large folio will be compressed and stored as a single 16KiB
> > >   block.
> > > * A 64KiB large folio will be compressed and stored as four 16KiB
> > >   blocks.
> > >
> > > For example, swapping out and swapping in 100MiB of typical anonymous
> > > data 100 times (with 16KB mTHP enabled) using zstd yields the followi=
ng
> > > results:
> > >
> > >                         w/o patches        w/ patches
> > > swap-out time(ms)       68711              49908
> > > swap-in time(ms)        30687              20685
> > > compression ratio       20.49%             16.9%
> >
> > The data looks very promising :) My understanding is it also results
> > in memory saving as well right? Since zstd operates better on bigger
> > inputs.
> >
> > Is there any end-to-end benchmarking? My intuition is that this patch
> > series overall will improve the situations, assuming we don't fallback
> > to individual zero order page swapin too often, but it'd be nice if
> > there is some data backing this intuition (especially with the
> > upstream setup, i.e without any private patches). If the fallback
> > scenario happens frequently, the patch series can make a page fault
> > more expensive (since we have to decompress the entire chunk, and
> > discard everything but the single page being loaded in), so it might
> > make a difference.
> >
> > Not super qualified to comment on zram changes otherwise - just a
> > casual observer to see if we can adopt this for zswap. zswap has the
> > added complexity of not supporting THP zswap in (until Usama's patch
> > series lands), and the presence of mixed backing states (due to zswap
> > writeback), increasing the likelihood of fallback :)
>
> Correct. As I mentioned to Usama[1], this could be a problem, and we are
> collecting data. The simplest approach to work around the issue is to fal=
l
> back to four small folios instead of just one, which would prevent the ne=
ed
> for three extra decompressions.
>
> [1] https://lore.kernel.org/linux-mm/CAGsJ_4yuZLOE0_yMOZj=3DKkRTyTotHw4g5=
g-t91W=3DMvS5zA4rYw@mail.gmail.com/
>

Hi Nhat, Usama, Ying,

I committed to providing data for cases where large folio allocation fails =
and
swap-in falls back to swapping in small folios. Here is the data that Tangq=
uan
helped collect:

* zstd, 100MB typical anon memory swapout+swapin 100times

1. 16kb mTHP swapout + 16kb mTHP swapin + w/o zsmalloc large block
(de)compression
swap-out(ms) 63151
swap-in(ms)  31551
2. 16kb mTHP swapout + 16kb mTHP swapin + w/ zsmalloc large block
(de)compression
swap-out(ms) 43925
swap-in(ms)  21763
3. 16kb mTHP swapout + 100% fallback to small folios swap-in + w/
zsmalloc large block (de)compression
swap-out(ms) 43423
swap-in(ms)   68660

Thus, "swap-in(ms) 68660," where mTHP allocation always fails, is significa=
ntly
slower than "swap-in(ms) 21763," where mTHP allocation succeeds.

If there are no objections, I could send a v3 patch to fall back to 4
small folios
instead of one. However, this would significantly increase the complexity o=
f
do_swap_page(). My gut feeling is that the added complexity might not be
well-received :-)

Thanks
Barry

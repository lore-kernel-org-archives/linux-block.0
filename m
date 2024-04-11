Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1C13C824
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821773; cv=none; b=AYmp3Rixuf5FylGTiJ6Kybf4mz6flWK0D0youPWhJPokYto64Z5wZVzMrbb4Qx8ycusP/+cSF8Plv2u/eFaKcLsPcohaAX4R59fzZZdZlBmpPa+Dp7gam1aJY9yqQIFYcxV8PwSu9e7Afex27EOVkXShoW3WJgbRAdrmMFqPsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821773; c=relaxed/simple;
	bh=uKfasO+V1YcKfip/nXPiQAGSPvWsitLuqDYKoaHdZSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLe1sC4OwEH9EIDnAggP7uygvgxNZVHg+whvbx/z5jUi9MZEfPFQwkmRNO6Q2DfiHrQQZ77TQe0AyYETXqUr8lUOhnjcIvwykwjzMk8rrn+l00TE58GNHEhg5vjqfppI5BsnbIHMzs05sTQYATL7NWnfW+jGsa7iS5SHAt2V2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGQU4Uio; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGQU4Uio"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4dac4791267so1595801e0c.1
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712821771; x=1713426571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgOGhyO6cgIV85Qu6uWJE0ADxev/ScH0tSyhkHUdhk0=;
        b=iGQU4UioLykVrJCQmascJbSfUFxfamV+qFl3tdAx/vpa8rpcCnBR3aT8D04zBxCpfn
         xLj0wIEmLgSVB5P/Vf32+YlnmDPzgzkaoKdyHOGRlGRhkEXJgqyzz8esBD/5xu07fEIu
         827yQxG0i6n6++CZ/FfepcCCB3UWaLzFVYSUQsTTVpsnnEOSw7E8Sd7JMwDEZ5juZ2Ex
         URrHvEb+V45Yp0iMwQF5ATv5YH/1sMIJKz0Xs6O8ZDfcLgKFZU+5nuy8BPLerp0MtUeT
         RHUZjUvLa9dBmGWgEnRoctaVDdftZlf0y0a3gUUGGlaXc2QaauqkBNdUbc/jXBiNfW7x
         qMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821771; x=1713426571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgOGhyO6cgIV85Qu6uWJE0ADxev/ScH0tSyhkHUdhk0=;
        b=UShW0v3Mcty3ypd8mwgADD6uJY6aeoYVjY9PcwIT+dTeBW/7j2muM3zvEA+ibyNxQG
         GFJjEwiK5bVzBJmQXoBW+UlhP4UAi1TjkJce41rTUVs1IIyz0+tMZLskabFJedaUg2T4
         WE1GGrgUyUtNEfnubXMETJUcgbfnSYkU92MGwxlrNJ8HJvFjplVyCHImcxQaWJ9LnqTi
         Hcp2WmScB7xPzmQa/y2Xsca6oVg4XJXPXGd/YvlWouuqI0NzOCAuCJRsb2bALj1QpdW7
         l3doPIgfX6mmQ5g5EkpiRzpNL8lMyfbLaq8XQX7eGrIUeKMreplrQkSUtYWDfq+W9YR+
         ffcw==
X-Forwarded-Encrypted: i=1; AJvYcCWIatgoOFjBjEVx/ssiUclk3Wk/iFfqJ7AcqxTMZysWRyzxWfU2zRjthUsKyUmXOxtWnEb/Oi8aM2km9B8OeR/kjnehrBgB8nY80RM=
X-Gm-Message-State: AOJu0YxYpGnGmIvAIEe2btHu6HJMt/SFe2+tVFnzBxdBjJzOw7p+tBfZ
	yWQ1PQ0i8QiGq5dNnU0vwyurWyoVdaiWdDIzODLeMGn/r938TPVumRV4tnGjkeoxA51LFFPy+Au
	u3kmHNOuNwmtq6V/8GW5BisflREM=
X-Google-Smtp-Source: AGHT+IEKHwMSh8DfsEiYJBygkbD+8y9BaD1im3rQpj/+3WpWg7RIrW2kftpH+XVf7bzByVZ/h087DAyPy7j43kwVKlM=
X-Received: by 2002:ac5:c216:0:b0:4d4:1fe2:c398 with SMTP id
 m22-20020ac5c216000000b004d41fe2c398mr4493920vkk.2.1712821770948; Thu, 11 Apr
 2024 00:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327214816.31191-1-21cnbao@gmail.com> <20240327214816.31191-3-21cnbao@gmail.com>
 <20240411014237.GB8743@google.com> <CAGsJ_4yKjfr1kgFKufM68yJoTysgT_gri4Dbg-aghj70F0Zf0Q@mail.gmail.com>
 <20240411041429.GC8743@google.com>
In-Reply-To: <20240411041429.GC8743@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 11 Apr 2024 19:49:19 +1200
Message-ID: <CAGsJ_4wdBtoBUbwmDs+FnPvinG-PtKKY7SzOinr_6DzrZ22_0A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] zram: support compression at the granularity of multi-pages
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, linux-block@vger.kernel.org, 
	axboe@kernel.dk, linux-mm@kvack.org, terrelln@fb.com, chrisl@kernel.org, 
	david@redhat.com, kasong@tencent.com, yuzhao@google.com, 
	yosryahmed@google.com, nphamcs@gmail.com, willy@infradead.org, 
	hannes@cmpxchg.org, ying.huang@intel.com, surenb@google.com, 
	wajdi.k.feghali@intel.com, kanchana.p.sridhar@intel.com, corbet@lwn.net, 
	zhouchengming@bytedance.com, Tangquan Zheng <zhengtangquan@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 4:14=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/04/11 14:03), Barry Song wrote:
> > > [..]
> > >
> > > > +static int zram_bvec_write_multi_pages_partial(struct zram *zram, =
struct bio_vec *bvec,
> > > > +                                u32 index, int offset, struct bio =
*bio)
> > > > +{
> > > > +     struct page *page =3D alloc_pages(GFP_NOIO | __GFP_COMP, ZCOM=
P_MULTI_PAGES_ORDER);
> > > > +     int ret;
> > > > +     void *src, *dst;
> > > > +
> > > > +     if (!page)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     ret =3D zram_read_multi_pages(zram, page, index, bio);
> > > > +     if (!ret) {
> > > > +             src =3D kmap_local_page(bvec->bv_page);
> > > > +             dst =3D kmap_local_page(page);
> > > > +             memcpy(dst + offset, src + bvec->bv_offset, bvec->bv_=
len);
> > > > +             kunmap_local(dst);
> > > > +             kunmap_local(src);
> > > > +
> > > > +             atomic64_inc(&zram->stats.zram_bio_write_multi_pages_=
partial_count);
> > > > +             ret =3D zram_write_page(zram, page, index);
> > > > +     }
> > > > +     __free_pages(page, ZCOMP_MULTI_PAGES_ORDER);
> > > > +     return ret;
> > > > +}
> > >
> > > What type of testing you run on it? How often do you see partial
> > > reads and writes? Because this looks concerning - zsmalloc memory
> > > usage reduction is one metrics, but this also can be achieved via
> > > recompression, writeback, or even a different compression algorithm,
> > > but higher CPU/power usage/higher requirements for physically contig
> > > pages cannot be offset easily. (Another corner case, assume we have
> > > partial read requests on every CPU simultaneously.)
> >
> > This question brings up an interesting observation. In our actual produ=
ct,
> > we've noticed a success rate of over 90% when allocating large folios i=
n
> > do_swap_page, but occasionally, we encounter failures. In such cases,
> > instead of resorting to partial reads, we opt to allocate 16 small foli=
os and
> > request zram to fill them all. This strategy effectively minimizes part=
ial reads
> > to nearly zero. However, integrating this into the upstream codebase se=
ems
> > like a considerable task, and for now, it remains part of our
> > out-of-tree code[1],
> > which is also open-source.
> > We're gradually sending patches for the swap-in process, systematically
> > cleaning up the product's code.
>
> I see, thanks for explanation.
> Does this sound like this series is ahead of its time?

I feel it is necessary to present the whole picture together with large fol=
ios
swp-in series[1]. On the other hand, there is a possibility this can
land earlier
before everything is really with default "disable", but for those
platforms which
have finely tuned partial read/write, they can enable it.

[1] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.=
com/

>
> > To enhance the success rate of large folio allocation, we've reserved s=
ome
> > page blocks for mTHP. This approach is currently absent from the mainli=
ne
> > codebase as well (Yu Zhao is trying to provide TAO [2]). Consequently, =
we
> > anticipate that partial reads may reach 50% or more until this method i=
s
> > incorporated upstream.
>
> These partial reads/writes are difficult to justify - instead of doing
> comp_op(PAGE_SIZE) we, in the worst case, now can do ZCOMP_MULTI_PAGES_NR
> of comp_op(ZCOMP_MULTI_PAGES_ORDER) (assuming a access pattern that
> touches each of multi-pages individually). That is a potentially huge
> increase in CPU/power usage, which cannot be easily sacrificed. In fact,
> I'd probably say that power usage is more important here than zspool
> memory usage (that we have means to deal with).

Once Ryan's mTHP swapout without splitting [2] is integrated into the
mainline, this
patchset certainly gains an advantage for SWPOUT. However, for SWPIN,
the situation
is more nuanced. There's a risk of failing to allocate mTHP, which
could result in the
allocation of a small folio instead. In such cases, decompressing a
large folio but
copying only one subpage leads to inefficiency.

In real-world products, we've addressed this challenge in two ways:
1. We've enhanced reserved page blocks for mTHP to boost allocation
success rates.
2. In instances where we fail to allocate a large folio, we fall back
to allocating nr_pages
small folios instead of just one. so we still only decompress once for
multi-pages.

With these measures in place, we consistently achieve wins in both
power consumption and
memory savings. However, it's important to note that these
optimizations are specific to our
product, and there's still much work needed to upstream them all.

[2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.roberts@=
arm.com/

>
> Have you evaluated power usage?
>
> I also wonder if it brings down the number of ZRAM_SAME pages. Suppose
> when several pages out of ZCOMP_MULTI_PAGES_ORDER are filled with zeroes
> (or some other recognizable pattern) which previously would have been
> stored using just unsigned long. Makes me even wonder if ZRAM_SAME test
> makes sense on multi-page at all, for that matter.

I don't think we need to worry about ZRAM_SAME. ARM64 supports 4KB, 16KB, a=
nd
64KB base pages. Even if we configure the base page to 16KB or 64KB,
there's still
a possibility of missing out on identifying SAME PAGES that are
identical at the 4KB
level but not at the 16/64KB granularity.

In our product, we continue to observe many SAME PAGES using
multi-page mechanisms.
Even if we miss some opportunities to identify same pages at the 4KB
level, the compressed
data remains relatively small, though not as compact as SAME_PAGE.
Overall, in typical
12GiB/16GiB phones, we still achieve a memory saving of around 800MiB
by this patchset.

mTHP offers a means to emulate a 16KiB/64KiB base page while
maintaining software
compatibility with a 4KiB base page. The primary concern here lies in
partial read/write
operations. In our product, we've successfully addressed these issues. Howe=
ver,
convincing people in the mainline community may take considerable time
and effort :-)

Thanks
Barry

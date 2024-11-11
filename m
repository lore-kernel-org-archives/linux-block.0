Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01500159209
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357083; cv=none; b=V9yOACmjfGB5lMavUBmvp1hfDzK2QTHNa1byVs/EVnFSql6BKYt0twT0VZc1rq5jE747qTQEhAlXUFE2R9S0fa8KSo2Q8ujbcbKsjHC5S1u43Fco1gBAMF4gNd5tOeFstZoAYeXHAG8uImDvUcxNKacDxDJm4vamMaMY2deuG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357083; c=relaxed/simple;
	bh=WVsBGUrgv4i7gykId+W2jyP76NbT30luy/uA7ke+J2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqqIcW2Chs9azMAgBT3gzTucwVcLgNPHN10KI+LDZmZYgJC56ep0jES9FNIMpU6RPIr50jmC/Lh4aQb6x24yVGSpPduojAJqP3X443Q+179FhsAgzkbdnltqBdnnlYau1o0QgoNhFkEC8iLAJTYdlTsuooTinbtVetxOyOxOqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMAsOurT; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMAsOurT"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d431b0ae2so4495043e0c.1
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 12:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731357081; x=1731961881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m+CAl8xmjRRoAU9r3aqEsFRGdffCDozgyQfRK4HAzg=;
        b=mMAsOurT0qKpD+PUlbN3u5AH2kIRAY45DtnflqhzSQsWXpi2KQuBMKyb3ORwVAqsOM
         P4zDnnZMkYNNyo3Izo+HoCEOI4VEy4zGMSrqmsSbqfeHOSgSlFy21KBSkR4XyuB53Pw5
         wvSXzxEe9kZn9Tl6dx2E1u9qOB4YaICO/rXMg9tmo2NhFWV/pcpIWz7zWRm7rIit9Mzo
         rRErtV4mM6Wwi+s/wH2H3lQrsjoz0M/BAYbrZ0NF2DMgcbVPAkvf1YkSRcyfjXGrlI8C
         On1fSC8aFaLUxERGyaAdjOdc4SRBv5IrlWA3wRnvRT8N7fSZN2+iYEelhmOVWp5gWzMc
         xT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731357081; x=1731961881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4m+CAl8xmjRRoAU9r3aqEsFRGdffCDozgyQfRK4HAzg=;
        b=K+qeZdosoz5w5IlvLdCRyS7g+TAWEsKx5YV2tdkSQAYvOF6x4QmZ+UZvjcpzD4hhqK
         kiRMoZWhaIDuCFqyxjEcul5bCr1OdWeQHoxKwPi0asjRHsoOt2pCEyIF+KCXItPMAOju
         HxIYiiG3rT/K86hFS13g6cQhlCPaycAsySTmMPfmxbxn1LK1fhwiwRBCCNx8JP5LHrq4
         1l3rsiGdLBcCZs/wC5zDwhIyaNhnyrGuQm3L9HbqKLWOyNuNiI+9btAYXX1lJuYaAk0U
         83xxSz+OvefExjLN1WcqIk0PqnXjl2Pf0tG6lYC9QEITJSZSJXBgLu42EIsfqVht04uM
         7kdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRuUpCkTIrnx096bh/9M0wcXHQ4AKo/TSominc4x194CCLopkotFJ452GdQEewzjOiaK/vif/JidTAIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/dCF/CYxa7fC23iTJbBOLRZXuPl2mATh28ETm4AmC0RTDRMr
	ve1SPbAYeYi8uXfZ1JEjrrdQ8ctaZaAdhL+eGsai2MA6mUf9pQO4A+f3+bCbgH1ozKAqmMoA85G
	NLqn8rZWgBEw3I5d4XZ1t2p8FSXI=
X-Google-Smtp-Source: AGHT+IH8p5KmEazeLGjGEu9FVBZXAN7xs55SO7VcOtUW9hovlquT8qaaf2S22O4V5mTf7Y9ydqnw4J6SWv663bs5oTw=
X-Received: by 2002:a05:6122:640c:20b0:50d:5754:c903 with SMTP id
 71dfb90a1353d-513fffc8fc0mr8960702e0c.4.1731357080535; Mon, 11 Nov 2024
 12:31:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com> <87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com> <28446805-f533-44fe-988a-71dcbdb379ab@gmail.com>
In-Reply-To: <28446805-f533-44fe-988a-71dcbdb379ab@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 12 Nov 2024 09:31:09 +1300
Message-ID: <CAGsJ_4yuZLOE0_yMOZj=KkRTyTotHw4g5g-t91W=MvS5zA4rYw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	axboe@kernel.dk, bala.seshasayee@linux.intel.com, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, 
	kasong@tencent.com, linux-block@vger.kernel.org, minchan@kernel.org, 
	nphamcs@gmail.com, senozhatsky@chromium.org, surenb@google.com, 
	terrelln@fb.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com, 
	zhengtangquan@oppo.com, zhouchengming@bytedance.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 5:43=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 08/11/2024 06:51, Barry Song wrote:
> > On Fri, Nov 8, 2024 at 6:23=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> Hi, Barry,
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> When large folios are compressed at a larger granularity, we observe
> >>> a notable reduction in CPU usage and a significant improvement in
> >>> compression ratios.
> >>>
> >>> mTHP's ability to be swapped out without splitting and swapped back i=
n
> >>> as a whole allows compression and decompression at larger granulariti=
es.
> >>>
> >>> This patchset enhances zsmalloc and zram by adding support for dividi=
ng
> >>> large folios into multi-page blocks, typically configured with a
> >>> 2-order granularity. Without this patchset, a large folio is always
> >>> divided into `nr_pages` 4KiB blocks.
> >>>
> >>> The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
> >>> setting, where the default of 2 allows all anonymous THP to benefit.
> >>>
> >>> Examples include:
> >>> * A 16KiB large folio will be compressed and stored as a single 16KiB
> >>>   block.
> >>> * A 64KiB large folio will be compressed and stored as four 16KiB
> >>>   blocks.
> >>>
> >>> For example, swapping out and swapping in 100MiB of typical anonymous
> >>> data 100 times (with 16KB mTHP enabled) using zstd yields the followi=
ng
> >>> results:
> >>>
> >>>                         w/o patches        w/ patches
> >>> swap-out time(ms)       68711              49908
> >>> swap-in time(ms)        30687              20685
> >>> compression ratio       20.49%             16.9%
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
>
> Thanks for sending the v2!
>
> How is the large folio pool maintained. I dont think there is something i=
n upstream

In production phones, we have extended the migration type for mTHP
separately during Linux
boot[1].

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/blob/oneplu=
s/sm8650_u_14.0.0_oneplus12/mm/page_alloc.c#L2089

These pageblocks have their own migration type, resulting in a separate bud=
dy
free list.

We prevent order-0 allocations from drawing memory from this pool, ensuring=
 a
relatively high success rate for mTHP allocations.

In one instance, phones reported an mTHP allocation success rate of less th=
an 5%
after running for a few hours without this kind of reservation
mechanism. Therefore,
we need an upstream solution in the kernel to ensure sustainable mTHP suppo=
rt
across all scenarios.

> kernel for this? The only thing that I saw on the mailing list is TAO for=
 pmd-mappable
> THPs only? I think that was about 7-8 months ago and wasn't merged?

TAO supports mTHP as long as it can be configured through the bootcmd:
nomerge=3D25%,4
This means we are providing a 4-order mTHP pool with 25% of total memory
reserved.

Note that the Android common kernel has already integrated TAO[2][3],
so we are trying
to use TAO to replace our previous approach of extending the migration type=
.

[2] https://android.googlesource.com/kernel/common/+/c1ff6dcf209e4abc23584d=
2cd117f725421bccac
[3] https://android.googlesource.com/kernel/common/+/066872d13d0c0b076785f0=
b794b650de0941c1c9

> The workaround to allocate nr_pages of small folios and map them
> together to avoid partial reads is also not upstream, right?

Correct. It's running on the phones[4][5], but I still don't know how
to handle it upstream
properly.

[4] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/blob/oneplu=
s/sm8650_u_14.0.0_oneplus12/mm/memory.c#L4656
[5] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/blob/oneplu=
s/sm8650_u_14.0.0_oneplus12/mm/memory.c#L5439

>
> Do you have any data how this would perform with the upstream kernel, i.e=
. without
> a large folio pool and the workaround and if large granularity compressio=
n is worth having
> without those patches?

I=E2=80=99d say large granularity compression isn=E2=80=99t a problem, but =
large
granularity decompression
could be.

The worst case would be if we swap out a large block, such as 16KB,
but end up swapping in
4 times due to allocation failures, falling back to smaller folios. In
this scenario, we would need
to perform three redundant decompressions. I will work with Tangquan
to provide this data this
week.

But once we swap in small folios, they remain small (we can't collapse
them for mTHP).
As a result, the next time, they will be swapped out and swapped in as
small folios.
Therefore, this potential loss is one-time.

>
> Thanks,
> Usama
>
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
> >
> >>
> >>> -v2:
> >>>  While it is not mature yet, I know some people are waiting for
> >>>  an update :-)
> >>>  * Fixed some stability issues.
> >>>  * rebase againest the latest mm-unstable.
> >>>  * Set default order to 2 which benefits all anon mTHP.
> >>>  * multipages ZsPageMovable is not supported yet.
> >>>
> >>> Tangquan Zheng (2):
> >>>   mm: zsmalloc: support objects compressed based on multiple pages
> >>>   zram: support compression at the granularity of multi-pages
> >>>
> >>>  drivers/block/zram/Kconfig    |   9 +
> >>>  drivers/block/zram/zcomp.c    |  17 +-
> >>>  drivers/block/zram/zcomp.h    |  12 +-
> >>>  drivers/block/zram/zram_drv.c | 450 +++++++++++++++++++++++++++++++-=
--
> >>>  drivers/block/zram/zram_drv.h |  45 ++++
> >>>  include/linux/zsmalloc.h      |  10 +-
> >>>  mm/Kconfig                    |  18 ++
> >>>  mm/zsmalloc.c                 | 232 +++++++++++++-----
> >>>  8 files changed, 699 insertions(+), 94 deletions(-)
> >>
> >> --
> >> Best Regards,
> >> Huang, Ying
> >

Thanks
barry

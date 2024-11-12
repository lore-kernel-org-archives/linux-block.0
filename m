Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78502AF06
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374950; cv=none; b=YLiykr0Ow/NOT8DW5cUHCEN4hr455GdG/UeLNVge9zjaXbPufm3LFQ5Q64xVjWDzE8gUlPLe950rGEjOoaxyU6zwSsUkn6taBBn9yJzjIn/E6Z1WyJgdj4PMvjz/6KsOezrzx9mM1KECRq6E9q+mW4BpfTE6WyB5CApAPduoEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374950; c=relaxed/simple;
	bh=78FiGBevGAlrD+lEeXYFeqSXsf/4SebGYSRVDN/r1ag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PvQfivWoD8rv6p1tLqtopP8WtdfBKyB5lf9YpRA/RMW/81/dor602K4xQDuNYQ39ThyYmOIS8Ej4gLYhDUMSXxxfNhnH07GZAl2wMwBi1S1mMdbJuasnUZbPQpvk1+b87MT/KPBEevHSLUcSQdu3KjaCzmVm41iiCl5ZrPWKwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KI8ubR1L; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KI8ubR1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731374949; x=1762910949;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=78FiGBevGAlrD+lEeXYFeqSXsf/4SebGYSRVDN/r1ag=;
  b=KI8ubR1LJf5b9IpyyU00/JCLKrumkBQ4tN4ZP1tnZFC9iLLTYUN54Nwk
   s6aOJ4mAdDU4iTrcAVvujU5ERah3cWZZeMWz3/oXntDPJdVVT3lNCVt2P
   L/MaxiBipkvQZI0+wx7NlTM7wKrVjTCr4lg9z5uHmmtm1pfCLVCL/ilJR
   qpci9lT3cWdsQxnhMWv6vEKQaxjrdhCtr1glgePyaoKtxbzxQvMvVsx0Q
   icBRsHPyZXkRUV0AbjNNulx8I0uq7r7Uu0/ECQH2czhThb0VjVRsoh++r
   itUhgU6cgB29mfeZCP4oYtocy0GoH0/owcxmMLxhMT/4aa7vVWXtFDNe6
   A==;
X-CSE-ConnectionGUID: /NU04Bc9TDC8HUXO2HrySQ==
X-CSE-MsgGUID: +3yPoZ1IQJ6tFq1hoqW0sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="48705475"
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="48705475"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 17:29:08 -0800
X-CSE-ConnectionGUID: MGc6mV94TsKcmP4dRr02gg==
X-CSE-MsgGUID: o4vKLpv1RU21iN1q31NYFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="91701896"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 17:29:03 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org,  akpm@linux-foundation.org,  axboe@kernel.dk,
  bala.seshasayee@linux.intel.com,  chrisl@kernel.org,  david@redhat.com,
  hannes@cmpxchg.org,  kanchana.p.sridhar@intel.com,  kasong@tencent.com,
  linux-block@vger.kernel.org,  minchan@kernel.org,  nphamcs@gmail.com,
  senozhatsky@chromium.org,  surenb@google.com,  terrelln@fb.com,
  v-songbaohua@oppo.com,  wajdi.k.feghali@intel.com,  willy@infradead.org,
  yosryahmed@google.com,  yuzhao@google.com,  zhengtangquan@oppo.com,
  zhouchengming@bytedance.com,  usamaarif642@gmail.com,
  ryan.roberts@arm.com
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and
 zram based on multi-pages
In-Reply-To: <CAGsJ_4xVB4EKR9pitLa3aUmxiHUr8VNSS=QQ12_peO7PGvTZfg@mail.gmail.com>
	(Barry Song's message of "Tue, 12 Nov 2024 14:25:08 +1300")
References: <20241107101005.69121-1-21cnbao@gmail.com>
	<87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com>
	<87pln1z2da.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4xVB4EKR9pitLa3aUmxiHUr8VNSS=QQ12_peO7PGvTZfg@mail.gmail.com>
Date: Tue, 12 Nov 2024 09:25:30 +0800
Message-ID: <87h68dz1it.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Tue, Nov 12, 2024 at 2:11=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Fri, Nov 8, 2024 at 6:23=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
>> >>
>> >> Hi, Barry,
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > From: Barry Song <v-songbaohua@oppo.com>
>> >> >
>> >> > When large folios are compressed at a larger granularity, we observe
>> >> > a notable reduction in CPU usage and a significant improvement in
>> >> > compression ratios.
>> >> >
>> >> > mTHP's ability to be swapped out without splitting and swapped back=
 in
>> >> > as a whole allows compression and decompression at larger granulari=
ties.
>> >> >
>> >> > This patchset enhances zsmalloc and zram by adding support for divi=
ding
>> >> > large folios into multi-page blocks, typically configured with a
>> >> > 2-order granularity. Without this patchset, a large folio is always
>> >> > divided into `nr_pages` 4KiB blocks.
>> >> >
>> >> > The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
>> >> > setting, where the default of 2 allows all anonymous THP to benefit.
>> >> >
>> >> > Examples include:
>> >> > * A 16KiB large folio will be compressed and stored as a single 16K=
iB
>> >> >   block.
>> >> > * A 64KiB large folio will be compressed and stored as four 16KiB
>> >> >   blocks.
>> >> >
>> >> > For example, swapping out and swapping in 100MiB of typical anonymo=
us
>> >> > data 100 times (with 16KB mTHP enabled) using zstd yields the follo=
wing
>> >> > results:
>> >> >
>> >> >                         w/o patches        w/ patches
>> >> > swap-out time(ms)       68711              49908
>> >> > swap-in time(ms)        30687              20685
>> >> > compression ratio       20.49%             16.9%
>> >>
>> >> The data looks good.  Thanks!
>> >>
>> >> Have you considered the situation that the large folio fails to be
>> >> allocated during swap-in?  It's possible because the memory may be ve=
ry
>> >> fragmented.
>> >
>> > That's correct, good question. On phones, we use a large folio pool to=
 maintain
>> > a relatively high allocation success rate. When mTHP allocation fails,=
 we have
>> > a workaround to allocate nr_pages of small folios and map them togethe=
r to
>> > avoid partial reads.  This ensures that the benefits of larger block c=
ompression
>> > and decompression are consistently maintained.  That was the code runn=
ing
>> > on production phones.
>> >
>> > We also previously experimented with maintaining multiple buffers for
>> > decompressed
>> > large blocks in zRAM, allowing upcoming do_swap_page() calls to use th=
em when
>> > falling back to small folios. In this setup, the buffers achieved a
>> > high hit rate, though
>> > I don=E2=80=99t recall the exact number.
>> >
>> > I'm concerned that this fault-around-like fallback to nr_pages small
>> > folios may not
>> > gain traction upstream. Do you have any suggestions for improvement?
>>
>> It appears that we still haven't a solution to guarantee 100% mTHP
>> allocation success rate.  If so, we need a fallback solution for that.
>>
>> Another possible solution is,
>>
>> 1) If failed to allocate mTHP with nr_pages, allocate nr_pages normal (4=
k)
>>    folios instead
>>
>> 2) Revise the decompression interface to accept a set of folios (instead
>>    of one folio) as target.  Then, we can decompress to the normal
>>    folios allocated in 1).
>>
>> 3) in do_swap_page(), we can either map all folios or just the fault
>>    folios.  We can put non-fault folios into swap cache if necessary.
>>
>> Does this work?
>
> this is exactly what we did in production phones:

I think that this is upstreamable.

> [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/blob/onep=
lus/sm8650_u_14.0.0_oneplus12/mm/memory.c#L4656
> [2] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/blob/onep=
lus/sm8650_u_14.0.0_oneplus12/mm/memory.c#L5439
>
> I feel that we don't need to fall back to nr_pages (though that's what
> we used on phones);
> using a dedicated 4 should be sufficient, as if zsmalloc is handling
> compression and
> decompression of 16KB.

Yes.  We only need the number of normal folios to make decompress work.

> However, we are not adding them to the
> swapcache; instead,
> they are mapped immediately.

I think that works.

>>
>> >>
>> >> > -v2:
>> >> >  While it is not mature yet, I know some people are waiting for
>> >> >  an update :-)
>> >> >  * Fixed some stability issues.
>> >> >  * rebase againest the latest mm-unstable.
>> >> >  * Set default order to 2 which benefits all anon mTHP.
>> >> >  * multipages ZsPageMovable is not supported yet.
>> >> >
>> >> > Tangquan Zheng (2):
>> >> >   mm: zsmalloc: support objects compressed based on multiple pages
>> >> >   zram: support compression at the granularity of multi-pages
>> >> >
>> >> >  drivers/block/zram/Kconfig    |   9 +
>> >> >  drivers/block/zram/zcomp.c    |  17 +-
>> >> >  drivers/block/zram/zcomp.h    |  12 +-
>> >> >  drivers/block/zram/zram_drv.c | 450 ++++++++++++++++++++++++++++++=
+---
>> >> >  drivers/block/zram/zram_drv.h |  45 ++++
>> >> >  include/linux/zsmalloc.h      |  10 +-
>> >> >  mm/Kconfig                    |  18 ++
>> >> >  mm/zsmalloc.c                 | 232 +++++++++++++-----
>> >> >  8 files changed, 699 insertions(+), 94 deletions(-)
>> >>

--
Best Regards,
Huang, Ying

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760EA14F9E2
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373865; cv=none; b=LNaqLqriL+KtZ8dGERmNb0p2L/qBuz6FnmG473ZAIiA1Sv8Xdv2pJmg65WV3LbOXvbc5+LbWt+P3dAf/rUJUtrTpZnRSA5Lc9uRAkVYSCpN3x1qYFNGeKuTksYhuFPna8MYnfDJ9AMIiNkIM6oGxac/J56dHfUiLid00zOVkdwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373865; c=relaxed/simple;
	bh=OdPiV1x6N7eLcgt/wagqnC5tGbJ81o7cqLh0BqMeYIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Igi3pBEIr6mRJAQopGHhZP+SkVF7zkhnZK7lMp+IXVOdnPrvyaaKNEDzafXRNOTaK686EUIOyY8DXt6AZ7ZQKzBd/N28jlzkii9T4BwYjItMV67VE+TsSai1o0erie1IFVaE249U0642iDRY3Lg14liyyR44yNpCpQUE4otq4ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USGJz6Wl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USGJz6Wl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731373862; x=1762909862;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=OdPiV1x6N7eLcgt/wagqnC5tGbJ81o7cqLh0BqMeYIo=;
  b=USGJz6WlYgMCwjeFtFQVFornBdLcmSTaHiaWJQBsshq845F9nmYBzslX
   DQVVXw0R7YjACGsQJlz+eMqG4CVbore3Q1lwl+ta2srVZgOu2Ef0KQOE1
   jAeCfAKrcJkmR5ru1GTs+0O+7zkInQDhYFfdBBUWWIhTqG8ZEbuGfBBly
   jb+3fDHh05WpdZMNId0NUecLmZDza5IQzcvPLOoe1gKvyTf4nXp6RUcVH
   aG8/gX4N5JORlUaNZv2fWHlJ+Fjzn7hbpfLWHlE5ldsGXchpDsZYwi2C9
   bzoM+am1ft5yIPCARqTe2eVan+rD3Q5kT2FMz6T0F9/UoFx4r2tbmcodT
   w==;
X-CSE-ConnectionGUID: yc1qtzCyRv+RkMfijcLRyA==
X-CSE-MsgGUID: srLqjK1xQZGLrj0hvw7F8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31153189"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31153189"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 17:11:01 -0800
X-CSE-ConnectionGUID: DHcYIxvAQ564c/AwbOyE7A==
X-CSE-MsgGUID: erUP9rnQQHiGIrEUfitbpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="87549601"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 17:10:55 -0800
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
In-Reply-To: <CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com>
	(Barry Song's message of "Fri, 8 Nov 2024 19:51:12 +1300")
References: <20241107101005.69121-1-21cnbao@gmail.com>
	<87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com>
Date: Tue, 12 Nov 2024 09:07:13 +0800
Message-ID: <87pln1z2da.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Fri, Nov 8, 2024 at 6:23=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Hi, Barry,
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > From: Barry Song <v-songbaohua@oppo.com>
>> >
>> > When large folios are compressed at a larger granularity, we observe
>> > a notable reduction in CPU usage and a significant improvement in
>> > compression ratios.
>> >
>> > mTHP's ability to be swapped out without splitting and swapped back in
>> > as a whole allows compression and decompression at larger granularitie=
s.
>> >
>> > This patchset enhances zsmalloc and zram by adding support for dividing
>> > large folios into multi-page blocks, typically configured with a
>> > 2-order granularity. Without this patchset, a large folio is always
>> > divided into `nr_pages` 4KiB blocks.
>> >
>> > The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
>> > setting, where the default of 2 allows all anonymous THP to benefit.
>> >
>> > Examples include:
>> > * A 16KiB large folio will be compressed and stored as a single 16KiB
>> >   block.
>> > * A 64KiB large folio will be compressed and stored as four 16KiB
>> >   blocks.
>> >
>> > For example, swapping out and swapping in 100MiB of typical anonymous
>> > data 100 times (with 16KB mTHP enabled) using zstd yields the following
>> > results:
>> >
>> >                         w/o patches        w/ patches
>> > swap-out time(ms)       68711              49908
>> > swap-in time(ms)        30687              20685
>> > compression ratio       20.49%             16.9%
>>
>> The data looks good.  Thanks!
>>
>> Have you considered the situation that the large folio fails to be
>> allocated during swap-in?  It's possible because the memory may be very
>> fragmented.
>
> That's correct, good question. On phones, we use a large folio pool to ma=
intain
> a relatively high allocation success rate. When mTHP allocation fails, we=
 have
> a workaround to allocate nr_pages of small folios and map them together to
> avoid partial reads.  This ensures that the benefits of larger block comp=
ression
> and decompression are consistently maintained.  That was the code running
> on production phones.
>
> We also previously experimented with maintaining multiple buffers for
> decompressed
> large blocks in zRAM, allowing upcoming do_swap_page() calls to use them =
when
> falling back to small folios. In this setup, the buffers achieved a
> high hit rate, though
> I don=E2=80=99t recall the exact number.
>
> I'm concerned that this fault-around-like fallback to nr_pages small
> folios may not
> gain traction upstream. Do you have any suggestions for improvement?

It appears that we still haven't a solution to guarantee 100% mTHP
allocation success rate.  If so, we need a fallback solution for that.

Another possible solution is,

1) If failed to allocate mTHP with nr_pages, allocate nr_pages normal (4k)
   folios instead

2) Revise the decompression interface to accept a set of folios (instead
   of one folio) as target.  Then, we can decompress to the normal
   folios allocated in 1).

3) in do_swap_page(), we can either map all folios or just the fault
   folios.  We can put non-fault folios into swap cache if necessary.

Does this work?

>>
>> > -v2:
>> >  While it is not mature yet, I know some people are waiting for
>> >  an update :-)
>> >  * Fixed some stability issues.
>> >  * rebase againest the latest mm-unstable.
>> >  * Set default order to 2 which benefits all anon mTHP.
>> >  * multipages ZsPageMovable is not supported yet.
>> >
>> > Tangquan Zheng (2):
>> >   mm: zsmalloc: support objects compressed based on multiple pages
>> >   zram: support compression at the granularity of multi-pages
>> >
>> >  drivers/block/zram/Kconfig    |   9 +
>> >  drivers/block/zram/zcomp.c    |  17 +-
>> >  drivers/block/zram/zcomp.h    |  12 +-
>> >  drivers/block/zram/zram_drv.c | 450 +++++++++++++++++++++++++++++++---
>> >  drivers/block/zram/zram_drv.h |  45 ++++
>> >  include/linux/zsmalloc.h      |  10 +-
>> >  mm/Kconfig                    |  18 ++
>> >  mm/zsmalloc.c                 | 232 +++++++++++++-----
>> >  8 files changed, 699 insertions(+), 94 deletions(-)
>>

--
Best Regards,
Huang, Ying

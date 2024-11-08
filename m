Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B51CABF
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731043419; cv=none; b=BR4yY7yjtNcdEyurHWPGfiSnKUrMzutOEzYEVxxbHJmODLXxeYa13vbuKFHlXORAg4HCnNlT4wT2MIBPs63EBlFed+PNvbyjKcPCLEnDckpPgWYJ8forQKv+c1nZ4rCN/FtYxrb6zOXg9SwW2d3qU84H3U/Ih4NqA5AcdR4YZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731043419; c=relaxed/simple;
	bh=Pm84jUB4Q4GhAHCSho72ISNQX/wNFi2qj7M1nJIExKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nwIq3T2turNS6eLQDSRbFyFzGHQbmFUPzv3CagK/Wod74mX0eq4Q10fJTgb6NznwGle4X047Reuy8JUoyBhk4coCrBHJl857+RQ1q8zFy4am/o74tMpP6S3vATOs1tr0hNxb6GCloeZStBRevdiwSuhqpLvFx+AQTmr9uTGQbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jz+Ik4E6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jz+Ik4E6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731043418; x=1762579418;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Pm84jUB4Q4GhAHCSho72ISNQX/wNFi2qj7M1nJIExKA=;
  b=jz+Ik4E6epz0fGrXzuNFwel030DKQy8VOdMcScmEpPHbesBq67CNh1az
   mnTmAOaGxruYzBd8Z8X2/qiw7fY7/4b4J4FbKJd5s40W1g1/eveyYZa3o
   03PbZmTlLq/+U7D+srzJy2u6fwTKv6JjPYqFnqoj3H3rEqAzFAJPXTAd1
   7N4gVBhzUwk8GzOZzg6rYeBMEg5Gx6XlaTB4d0xhr8dn8uwki20Vgic1B
   kDITRgRR8Q1QwmOikAs6biSkNQW+a1cyYIyx4pP0gijo652ZioUeAWKnm
   FlIxgq3QENSWZFFxhDMloPgyV2E/JRCRRVBr2IqZyEzHaB/5iKbd0hsWB
   g==;
X-CSE-ConnectionGUID: BgiBYXHlRrOH04gCDdM8GA==
X-CSE-MsgGUID: sQdzcf1FTZO21CgP3qKysw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="18542246"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="18542246"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 21:23:37 -0800
X-CSE-ConnectionGUID: 76HCYjVPQAy7iccZitqowQ==
X-CSE-MsgGUID: 4Mt08sVmRGmA9id38Rqz6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85373663"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 21:23:31 -0800
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
In-Reply-To: <20241107101005.69121-1-21cnbao@gmail.com> (Barry Song's message
	of "Thu, 7 Nov 2024 23:10:02 +1300")
References: <20241107101005.69121-1-21cnbao@gmail.com>
Date: Fri, 08 Nov 2024 13:19:58 +0800
Message-ID: <87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Barry,

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> When large folios are compressed at a larger granularity, we observe
> a notable reduction in CPU usage and a significant improvement in
> compression ratios.
>
> mTHP's ability to be swapped out without splitting and swapped back in
> as a whole allows compression and decompression at larger granularities.
>
> This patchset enhances zsmalloc and zram by adding support for dividing
> large folios into multi-page blocks, typically configured with a
> 2-order granularity. Without this patchset, a large folio is always
> divided into `nr_pages` 4KiB blocks.
>
> The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
> setting, where the default of 2 allows all anonymous THP to benefit.
>
> Examples include:
> * A 16KiB large folio will be compressed and stored as a single 16KiB
>   block.
> * A 64KiB large folio will be compressed and stored as four 16KiB
>   blocks.
>
> For example, swapping out and swapping in 100MiB of typical anonymous
> data 100 times (with 16KB mTHP enabled) using zstd yields the following
> results:
>
>                         w/o patches        w/ patches
> swap-out time(ms)       68711              49908
> swap-in time(ms)        30687              20685
> compression ratio       20.49%             16.9%

The data looks good.  Thanks!

Have you considered the situation that the large folio fails to be
allocated during swap-in?  It's possible because the memory may be very
fragmented.

> -v2:
>  While it is not mature yet, I know some people are waiting for
>  an update :-)
>  * Fixed some stability issues.
>  * rebase againest the latest mm-unstable.
>  * Set default order to 2 which benefits all anon mTHP.
>  * multipages ZsPageMovable is not supported yet.
>
> Tangquan Zheng (2):
>   mm: zsmalloc: support objects compressed based on multiple pages
>   zram: support compression at the granularity of multi-pages
>
>  drivers/block/zram/Kconfig    |   9 +
>  drivers/block/zram/zcomp.c    |  17 +-
>  drivers/block/zram/zcomp.h    |  12 +-
>  drivers/block/zram/zram_drv.c | 450 +++++++++++++++++++++++++++++++---
>  drivers/block/zram/zram_drv.h |  45 ++++
>  include/linux/zsmalloc.h      |  10 +-
>  mm/Kconfig                    |  18 ++
>  mm/zsmalloc.c                 | 232 +++++++++++++-----
>  8 files changed, 699 insertions(+), 94 deletions(-)

--
Best Regards,
Huang, Ying

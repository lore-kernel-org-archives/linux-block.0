Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040418A6BD
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343430; cv=none; b=NdAsE9BMTGcRFig1uGSZfplCeD3RWa+TwA/hrC4bmBAyO52xM7JtpJJ9TXGJCFopE8WRAdern3lXKoJNBdUbfK+/+CgKuaFxPbyLGti2APqRDo7sMeWhr/uRzisHV4+M5sE1fBAqBDHhN9mXtbH4z4ICx6uvvwOhA1ky9Bdg+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343430; c=relaxed/simple;
	bh=sVQCtohcGK0/fAlU1SOcgZuqMvZCOlvnUR5qbzGRXEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlTCRrPf+SsYQSIRY2Z38Z3C5M4lqhKNaBCK5SLAV6Idk5J1a8cnp9ZIvF7NYVVV9sKGR+vbXIXfvHdUaac/78+5cMU1sXmyLvSPeBuw63MiS0bgJto2TXzgEMoMq/OpS3GgDUdD8GYrj/dm/BGsr6vkuImlqMOpUnkZh8S4oTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfDIbyPF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfDIbyPF"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso240473166b.1
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 08:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731343427; x=1731948227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTdD7QysOJTqQ3CRzqhbna3iriQuo3cuHHiOE2WfJCw=;
        b=lfDIbyPFqtyqSlWi4fE2DGgBPLLs6F/qCkYANTgh8225qtB8iPn+nliMm1CBw+GEmg
         vMeOx7iRBNL80XToedGsrveOt/3o8u26h0X0JEbgJwFGbeSdVfJvr6QjotGdBjOqaQGp
         TS6t+j95Jmju4W+pQbus+gWep6TJ1vnBZpmGbqlkQvBKdkslP+yzJ1fvhEOhJvv6xXxN
         sRd5nEV8uZBj8Iz65SLTxfZOPTH3YRq59mumeckxUflF7tBL9sVfaaL6lzLhiRgSFeXa
         RrkFsYj2D9bF5IJvIz9wmEym0TyR/DCd0E1w/6vPtJlp7vA8oYSBPCcLTCUUKkEGYbyB
         FL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343427; x=1731948227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTdD7QysOJTqQ3CRzqhbna3iriQuo3cuHHiOE2WfJCw=;
        b=psGGWvEfPUcX9Q+zNdu0Rshjbc+g84uIF962WnGlPCLw74eN+F9pzMkw1Nj0r3hMDU
         9sxF3NnXWjYEGEi+U+daSFT9S8XDnaYw+bvtHbIzQdBp2vclha52YInUc4W0qTuaA3Xo
         MOAawJdLg66sb9/8YRIWJpKDMAuE5ZPcDHEh/hEZLve4jjZZGW7Id8lP1NGptN57dfep
         80tJkMnsUg5dR7y947aBL5lPb4i7Cat78PRHfdyz8GFI4ExyH0FTanLg6vgBvKyliu7V
         cIY36IRZE6vscgzD3Kolb0XnBAQY17WuwsiSCNB9H7/mPC1vw3Rz/je5E5v4aHgI0smz
         d0pA==
X-Forwarded-Encrypted: i=1; AJvYcCUO0UNlxXtr+yonjxF9jTTgKl8NraXDBEcK3vIJUVKSWc1rYo9kv9xr9Ehdz8NZeL/x5NK1vf0rPMK2yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0WpkGiDdxw5s045FBX4lm+LtAvgC4QHvSNBRyPazxOpzmH5C
	leUkARwJcgfoizHIRZ+9qNff7bj7S447IiTXU3yLC0giez56N7R1
X-Google-Smtp-Source: AGHT+IG+pyWNBu+SfCu0aqNLnvyakYpTQxl3ePgpwKjSUtklRFNhnK3xfZR6ecdqSLB/E0KaRNGDpA==
X-Received: by 2002:a17:907:72c3:b0:a9e:c947:d5e5 with SMTP id a640c23a62f3a-a9eeff445b3mr1266994266b.28.1731343426569;
        Mon, 11 Nov 2024 08:43:46 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:975d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a46119sm610041866b.46.2024.11.11.08.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 08:43:46 -0800 (PST)
Message-ID: <28446805-f533-44fe-988a-71dcbdb379ab@gmail.com>
Date: Mon, 11 Nov 2024 16:43:45 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Barry Song <21cnbao@gmail.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, axboe@kernel.dk,
 bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com,
 linux-block@vger.kernel.org, minchan@kernel.org, nphamcs@gmail.com,
 senozhatsky@chromium.org, surenb@google.com, terrelln@fb.com,
 v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, zhengtangquan@oppo.com,
 zhouchengming@bytedance.com, ryan.roberts@arm.com
References: <20241107101005.69121-1-21cnbao@gmail.com>
 <87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08/11/2024 06:51, Barry Song wrote:
> On Fri, Nov 8, 2024 at 6:23 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Hi, Barry,
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> When large folios are compressed at a larger granularity, we observe
>>> a notable reduction in CPU usage and a significant improvement in
>>> compression ratios.
>>>
>>> mTHP's ability to be swapped out without splitting and swapped back in
>>> as a whole allows compression and decompression at larger granularities.
>>>
>>> This patchset enhances zsmalloc and zram by adding support for dividing
>>> large folios into multi-page blocks, typically configured with a
>>> 2-order granularity. Without this patchset, a large folio is always
>>> divided into `nr_pages` 4KiB blocks.
>>>
>>> The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
>>> setting, where the default of 2 allows all anonymous THP to benefit.
>>>
>>> Examples include:
>>> * A 16KiB large folio will be compressed and stored as a single 16KiB
>>>   block.
>>> * A 64KiB large folio will be compressed and stored as four 16KiB
>>>   blocks.
>>>
>>> For example, swapping out and swapping in 100MiB of typical anonymous
>>> data 100 times (with 16KB mTHP enabled) using zstd yields the following
>>> results:
>>>
>>>                         w/o patches        w/ patches
>>> swap-out time(ms)       68711              49908
>>> swap-in time(ms)        30687              20685
>>> compression ratio       20.49%             16.9%
>>
>> The data looks good.  Thanks!
>>
>> Have you considered the situation that the large folio fails to be
>> allocated during swap-in?  It's possible because the memory may be very
>> fragmented.
> 
> That's correct, good question. On phones, we use a large folio pool to maintain
> a relatively high allocation success rate. When mTHP allocation fails, we have
> a workaround to allocate nr_pages of small folios and map them together to
> avoid partial reads.  This ensures that the benefits of larger block compression
> and decompression are consistently maintained.  That was the code running
> on production phones.
> 

Thanks for sending the v2!

How is the large folio pool maintained. I dont think there is something in upstream
kernel for this? The only thing that I saw on the mailing list is TAO for pmd-mappable
THPs only? I think that was about 7-8 months ago and wasn't merged?
The workaround to allocate nr_pages of small folios and map them
together to avoid partial reads is also not upstream, right?

Do you have any data how this would perform with the upstream kernel, i.e. without
a large folio pool and the workaround and if large granularity compression is worth having
without those patches?

Thanks,
Usama

> We also previously experimented with maintaining multiple buffers for
> decompressed
> large blocks in zRAM, allowing upcoming do_swap_page() calls to use them when
> falling back to small folios. In this setup, the buffers achieved a
> high hit rate, though
> I don’t recall the exact number.
> 
> I'm concerned that this fault-around-like fallback to nr_pages small
> folios may not
> gain traction upstream. Do you have any suggestions for improvement?
> 
>>
>>> -v2:
>>>  While it is not mature yet, I know some people are waiting for
>>>  an update :-)
>>>  * Fixed some stability issues.
>>>  * rebase againest the latest mm-unstable.
>>>  * Set default order to 2 which benefits all anon mTHP.
>>>  * multipages ZsPageMovable is not supported yet.
>>>
>>> Tangquan Zheng (2):
>>>   mm: zsmalloc: support objects compressed based on multiple pages
>>>   zram: support compression at the granularity of multi-pages
>>>
>>>  drivers/block/zram/Kconfig    |   9 +
>>>  drivers/block/zram/zcomp.c    |  17 +-
>>>  drivers/block/zram/zcomp.h    |  12 +-
>>>  drivers/block/zram/zram_drv.c | 450 +++++++++++++++++++++++++++++++---
>>>  drivers/block/zram/zram_drv.h |  45 ++++
>>>  include/linux/zsmalloc.h      |  10 +-
>>>  mm/Kconfig                    |  18 ++
>>>  mm/zsmalloc.c                 | 232 +++++++++++++-----
>>>  8 files changed, 699 insertions(+), 94 deletions(-)
>>
>> --
>> Best Regards,
>> Huang, Ying
> 
> Thanks
> barry


Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05871E501B
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961741; cv=none; b=sU5m8NcWpww8olq1l0+MZDq2o8qFHHq+3HePdmTTNZkwcI2FiP4FGFZGAUfVeQsQNqsYOkJ7AD0FrNajBVobQNPBqD6BXweK3SGpJtyiXU0fwD+z6HOAGsVZKdeFDFHLA0hNcdcvtsxJkuHlYMAKUcQz5rJ0wPh0BrN9JVH1cuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961741; c=relaxed/simple;
	bh=HiLPNUsMN8jFhraBQF5Iu7f4MBwO4J+REYNARlAHTIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2ViAMK2f3w7IlbyZL2PzXwejlo4Ym53BGW2PZ2902kgbvha2XtHcTXzEHkHidUdab4DmtGIHG8BOFAkvfxsos8AHiEAcf1KqS90x07iLdu4CEWlCyB+BbV+fg3yEkTvlarVGn5gJLS3xa8NjfE4EdCtcK/ot9On/idyyois5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6UxnP0i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6UxnP0i"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211fb27cc6bso19703425ad.0
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 12:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731961739; x=1732566539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=remZFZr7j+fDJ2l19DEONWkqHuM9FVu6W7lwTvaNClg=;
        b=Z6UxnP0iyeFe+8iDr/m476SexzLYWHskQeb7sqRsrFSeGrZTt/C6Ph/0IjGN0h1rEq
         D+k74SsPDGjFV/lA8eqCqu5V2ysLLARZ1uz11bq6gn4kHr7QupzVMPBVDvWL5lGBSjsP
         7KthNrcv9gYHwk0OiUS0h6R5fKp899vR3dB3rB1NlUWyOAAgJ60h6iSMUHtmOiySF8n3
         366GI6WgBbJhVhv/tQrqDxXr1VbWnuOWXyGdd7GZ+jc5KYaleuJ6h4rgfrooB9YzXKBz
         AnZ5eEoPfV103PrC0jpu+XVTP2JYbJgYDyMbU4B3L3r2ga1RD5QINEtrQwGIKta6e7m0
         XHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731961739; x=1732566539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=remZFZr7j+fDJ2l19DEONWkqHuM9FVu6W7lwTvaNClg=;
        b=tF9o/unGulT6awEkufDuM3OtcWrqjopktJaDln6Z3/4g0muiLNMHUaHKRbkEtCJl7W
         dm4VQW+/wWB71y2HWGnvyTBMtkMLyHRH51uF3LcvIhzv06yAAfvIoJSeyW1AnUH2AcDE
         ciQH06uT2SvyCcWcHhAxPUYXJCE8ZoeFACzOAXIDfVMo0l6452mnkH1rBn1Fsq3hD0wr
         /kQ/fZwN5cBAYSbk2yg/YXWAhp4FQeL8fp5JZsnBQMZwlgEu6GcvLWPN4azXkdx39I4v
         Ov2w8Nrb2n4oRpX2uMekVFKMX1t7Ai2TpldF3h+zD7DyTYlxsFNzCM4TUUAiu0wlKPP1
         rSzA==
X-Forwarded-Encrypted: i=1; AJvYcCXsjwmMy0inmY4CzhGDtcdPJGu6tIhIEb94CV81JFg7BDB2h0A0tsrld3Y8umthl4Dh24Xg45IZ+B4Bcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jB1oBHPMb2UWafPHdIJAKAl1SfJjkEIPkjbZcdm09sN/A+Gc
	+6isR8iLldeiAM72Udmv2LqgZapKlfyDMMWg80Lpzp56uQKKZcEn
X-Google-Smtp-Source: AGHT+IGlKPr6I3gREpjEvm/P8z81hxXxxthwouDkF1+agNyX0nr18Y3stsudiL7ynDxNrdO8TILhVQ==
X-Received: by 2002:a17:903:2a8b:b0:20f:ab4a:db2e with SMTP id d9443c01a7336-211d0d7f556mr187876095ad.29.1731961739149;
        Mon, 18 Nov 2024 12:28:59 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:1814:7077:ef3e:914? ([2620:10d:c090:500::7:b3a3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f47ae7sm59156775ad.208.2024.11.18.12.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 12:28:58 -0800 (PST)
Message-ID: <92b25b7b-63e8-4eb1-b2a6-9c221de2b7e4@gmail.com>
Date: Mon, 18 Nov 2024 12:28:56 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Barry Song <21cnbao@gmail.com>, Nhat Pham <nphamcs@gmail.com>,
 ying.huang@intel.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, axboe@kernel.dk,
 bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com,
 linux-block@vger.kernel.org, minchan@kernel.org, senozhatsky@chromium.org,
 surenb@google.com, terrelln@fb.com, v-songbaohua@oppo.com,
 wajdi.k.feghali@intel.com, willy@infradead.org, yosryahmed@google.com,
 yuzhao@google.com, zhengtangquan@oppo.com, zhouchengming@bytedance.com,
 ryan.roberts@arm.com
References: <20241107101005.69121-1-21cnbao@gmail.com>
 <CAKEwX=OAE9r_VH38c3M0ekmBYWb5qKS-LPiBFBqToaJwEg3hJw@mail.gmail.com>
 <CAGsJ_4y+DeCo7oF+Ty8x9rHreh9LaS9XDU85yz81U9FQgBYE8A@mail.gmail.com>
 <CAGsJ_4zojYeEqgTcH-sKek9LW0pYOUoXcrzOzjoMuzMMODujbA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4zojYeEqgTcH-sKek9LW0pYOUoXcrzOzjoMuzMMODujbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/11/2024 02:27, Barry Song wrote:
> On Tue, Nov 12, 2024 at 10:37 AM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Tue, Nov 12, 2024 at 8:30 AM Nhat Pham <nphamcs@gmail.com> wrote:
>>>
>>> On Thu, Nov 7, 2024 at 2:10 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> When large folios are compressed at a larger granularity, we observe
>>>> a notable reduction in CPU usage and a significant improvement in
>>>> compression ratios.
>>>>
>>>> mTHP's ability to be swapped out without splitting and swapped back in
>>>> as a whole allows compression and decompression at larger granularities.
>>>>
>>>> This patchset enhances zsmalloc and zram by adding support for dividing
>>>> large folios into multi-page blocks, typically configured with a
>>>> 2-order granularity. Without this patchset, a large folio is always
>>>> divided into `nr_pages` 4KiB blocks.
>>>>
>>>> The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
>>>> setting, where the default of 2 allows all anonymous THP to benefit.
>>>>
>>>> Examples include:
>>>> * A 16KiB large folio will be compressed and stored as a single 16KiB
>>>>   block.
>>>> * A 64KiB large folio will be compressed and stored as four 16KiB
>>>>   blocks.
>>>>
>>>> For example, swapping out and swapping in 100MiB of typical anonymous
>>>> data 100 times (with 16KB mTHP enabled) using zstd yields the following
>>>> results:
>>>>
>>>>                         w/o patches        w/ patches
>>>> swap-out time(ms)       68711              49908
>>>> swap-in time(ms)        30687              20685
>>>> compression ratio       20.49%             16.9%
>>>
>>> The data looks very promising :) My understanding is it also results
>>> in memory saving as well right? Since zstd operates better on bigger
>>> inputs.
>>>
>>> Is there any end-to-end benchmarking? My intuition is that this patch
>>> series overall will improve the situations, assuming we don't fallback
>>> to individual zero order page swapin too often, but it'd be nice if
>>> there is some data backing this intuition (especially with the
>>> upstream setup, i.e without any private patches). If the fallback
>>> scenario happens frequently, the patch series can make a page fault
>>> more expensive (since we have to decompress the entire chunk, and
>>> discard everything but the single page being loaded in), so it might
>>> make a difference.
>>>
>>> Not super qualified to comment on zram changes otherwise - just a
>>> casual observer to see if we can adopt this for zswap. zswap has the
>>> added complexity of not supporting THP zswap in (until Usama's patch
>>> series lands), and the presence of mixed backing states (due to zswap
>>> writeback), increasing the likelihood of fallback :)
>>
>> Correct. As I mentioned to Usama[1], this could be a problem, and we are
>> collecting data. The simplest approach to work around the issue is to fall
>> back to four small folios instead of just one, which would prevent the need
>> for three extra decompressions.
>>
>> [1] https://lore.kernel.org/linux-mm/CAGsJ_4yuZLOE0_yMOZj=KkRTyTotHw4g5g-t91W=MvS5zA4rYw@mail.gmail.com/
>>
> 
> Hi Nhat, Usama, Ying,
> 
> I committed to providing data for cases where large folio allocation fails and
> swap-in falls back to swapping in small folios. Here is the data that Tangquan
> helped collect:
> 
> * zstd, 100MB typical anon memory swapout+swapin 100times
> 
> 1. 16kb mTHP swapout + 16kb mTHP swapin + w/o zsmalloc large block
> (de)compression
> swap-out(ms) 63151
> swap-in(ms)  31551
> 2. 16kb mTHP swapout + 16kb mTHP swapin + w/ zsmalloc large block
> (de)compression
> swap-out(ms) 43925
> swap-in(ms)  21763
> 3. 16kb mTHP swapout + 100% fallback to small folios swap-in + w/
> zsmalloc large block (de)compression
> swap-out(ms) 43423
> swap-in(ms)   68660
> 

Hi Barry,

Thanks for the numbers!

In what condition was it falling back to small folios. Did you just added a hack
in alloc_swap_folio to just jump to fallback? or was it due to cgroup limited memory
pressure?

Would it be good to test with something like kernel build test (or something else that
causes swap thrashing) to see if the regression worsens with large granularity decompression?
i.e. would be good to have numbers for real world applications. 

> Thus, "swap-in(ms) 68660," where mTHP allocation always fails, is significantly
> slower than "swap-in(ms) 21763," where mTHP allocation succeeds.
> 
> If there are no objections, I could send a v3 patch to fall back to 4
> small folios
> instead of one. However, this would significantly increase the complexity of
> do_swap_page(). My gut feeling is that the added complexity might not be
> well-received :-)
> 

If there is space for 4 small folios, then maybe it might be worth passing
__GFP_DIRECT_RECLAIM? as that can trigger compaction and give a large folio.

Thanks,
Usama

> Thanks
> Barry


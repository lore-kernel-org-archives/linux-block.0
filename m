Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6020B1FF
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980169; cv=none; b=aHC8bIsLd+e3mwUhZdBJ3WPdbX/XzQCo9ICo093GLai/458lAbN1gxjGYAYhXwhD3a4wCfrBdim6HumZd/hp2Mto2Wgqu/K5wY9QBX4uytiGNBTpuwUeqs4P1cmKQjlhWRT9ag40hogYiQ+424EWYh8Uum8+j/+P8X12ybZbsvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980169; c=relaxed/simple;
	bh=cc+nt+GTOlJR7BqttFFd/F2ZLTh/DLiO8L1kVa6x2hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOKIqkOaNz93RVYB+Cb+nqJpMXzMKU0EaLLJfGu6HyD+4rpi44QybNyyEuQZ8mkT9o0OpfNSZkETq7WyjTt6qkNDQgSABeI4miZQ4VBNYrtJwnhGwqMXk211rbvFnxnkddddLlheoKadkZbMRIWyozF0roVCZKgwQmOROjtzADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKdrbDDK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKdrbDDK"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e7e73740so687507e87.3
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 03:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730980164; x=1731584964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFFsDH3Mu5TMadcSw1srkjRsUpQh30Wi0O92w8u4+6U=;
        b=mKdrbDDKTw4xuhk3O3aiapS9Tkyh067GkbwQKk9LwE48YgVlohmavlW9PUM02NQpKz
         6z+dv4pdK/i9OGX8ALTBlTDGP8ReyoUc5m/vaAMJKgjfBOPelay7heAKpRMiZ7q797bM
         fYdeSpIhieyMhm8dBBzu3LjdInvxOBI94bcGJpHQsvrGOZa0PPgC/eh+LYyPJxVeVlHL
         Nmp+qdprupJO5X3sW3zvXn2uVwoH2R+qVny54+F7m7sfbyWh56QtDPLHvwD0pDhUO2Bm
         LqKFnQRevxq5XnzPfWrcsq4Z3WQw8smV9oHPJrrAZjiN9Zx14rLgzujCDM4252v5PNTN
         mG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730980164; x=1731584964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFFsDH3Mu5TMadcSw1srkjRsUpQh30Wi0O92w8u4+6U=;
        b=KzL9SNrYE+3jw0wLBPyQxOhNghWZxp1bx/Yny5Sv92VG0/XjibcToFb6YDxoGnbRH3
         2MPjUSOkDwdXaQqI+UpKwJFr22R72+WAOYyBaoC8LhSd/JkTRm2dE0D6qqneb8zTgLXg
         vHaTVnemPoztNx82ufpWx58fKcVM9PV9NskV1eqUBzGj7C7ZbS4Cn+PnvxsX3Gfs4cfF
         kZya6mVkiOnrY1exW0C2DmsIgH0hDfLU7zSOQskzo1Llaaep8HBblWj1Tss2z+daoY/p
         x6MsJFjFj8LLpkHMUERAW73snIK/8hWOkzy2/Cn2zgmKQqtOHbErfkbHy5Lxg5z9qJXi
         sbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYpgKu3yY22jezwujJG6Wl5eIrdkmFv45oDasnbfbVvXh/BR2gd6hML5kz/j85QnPMvCOx3G9nlCJEdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6MXLpXXYZ6cRu0QCuR6IfMWGw8bdpBpkPCXPV5nb63hUgpcK
	rgo9lcW+Mu9j8jGG0dO6DAYBb3e37+XFoPYdL6lC+CHuKl4UR5bw
X-Google-Smtp-Source: AGHT+IEjGs0GpGaOS2ecdEB9mYTJBJRH2L9b6YQ3R7UJnbJCAX+MOCsP9YvF6DS0ys/O3skA8V/wgw==
X-Received: by 2002:a05:6512:110d:b0:539:f13c:e5d1 with SMTP id 2adb3069b0e04-53d840a29femr525991e87.38.1730980163970;
        Thu, 07 Nov 2024 03:49:23 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b2c32sm57167285e9.10.2024.11.07.03.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 03:49:23 -0800 (PST)
Message-ID: <490a923e-d450-4476-a9f5-2a247b6d3a12@gmail.com>
Date: Thu, 7 Nov 2024 11:49:22 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] zram: support compression at the granularity of
 multi-pages
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, chrisl@kernel.org,
 corbet@lwn.net, david@redhat.com, kanchana.p.sridhar@intel.com,
 kasong@tencent.com, linux-block@vger.kernel.org, linux-mm@kvack.org,
 minchan@kernel.org, nphamcs@gmail.com, senozhatsky@chromium.org,
 surenb@google.com, terrelln@fb.com, v-songbaohua@oppo.com,
 wajdi.k.feghali@intel.com, willy@infradead.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, zhengtangquan@oppo.com,
 zhouchengming@bytedance.com, bala.seshasayee@linux.intel.com,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20240327214816.31191-3-21cnbao@gmail.com>
 <20241021232852.4061-1-21cnbao@gmail.com>
 <eabf4f2c-4192-42d5-b6cc-f36a3c7ad0f2@gmail.com>
 <CAGsJ_4w0f_eqHvmAr59FRNCsydjc2EQu4eHhSGFvurJn=TuvJA@mail.gmail.com>
 <CAGsJ_4yrsCSyZpjtv7+bKN3TuLFaQ86v_zx9HtNQKtVhve0zDA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4yrsCSyZpjtv7+bKN3TuLFaQ86v_zx9HtNQKtVhve0zDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/11/2024 10:31, Barry Song wrote:
> On Thu, Nov 7, 2024 at 11:25 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Thu, Nov 7, 2024 at 5:23 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 22/10/2024 00:28, Barry Song wrote:
>>>>> From: Tangquan Zheng <zhengtangquan@oppo.com>
>>>>>
>>>>> +static int zram_bvec_write_multi_pages(struct zram *zram, struct bio_vec *bvec,
>>>>> +                       u32 index, int offset, struct bio *bio)
>>>>> +{
>>>>> +    if (is_multi_pages_partial_io(bvec))
>>>>> +            return zram_bvec_write_multi_pages_partial(zram, bvec, index, offset, bio);
>>>>> +    return zram_write_page(zram, bvec->bv_page, index);
>>>>> +}
>>>>> +
>>>
>>> Hi Barry,
>>>
>>> I started reviewing this series just to get a better idea if we can do something
>>> similar for zswap. I haven't looked at zram code before so this might be a basic
>>> question:
>>> How would you end up in zram_bvec_write_multi_pages_partial if using zram for swap?
>>
>> Hi Usama,
>>
>> There’s a corner case where, for instance, a 32KiB mTHP is swapped
>> out. Then, if userspace
>> performs a MADV_DONTNEED on the 0~16KiB portion of this original mTHP,
>> it now consists
>> of 8 swap entries(mTHP has been released and unmapped). With
>> swap0-swap3 released
>> due to DONTNEED, they become available for reallocation, and other
>> folios may be swapped
>> out to those entries. Then it is a combination of the new smaller
>> folios with the original 32KiB
>> mTHP.
> 

Hi Barry,

Thanks for this. So in this example of 32K folio, when swap slots 0-3 are
released zram_slot_free_notify will only clear the ZRAM_COMP_MULTI_PAGES
flag on the 0-3 index and return (without calling zram_free_page on them).

I am assuming that if another folio is now swapped out to those entries,
zram allows to overwrite those pages, eventhough they haven't been freed?

Also, even if its allowed, I still dont think you will end up in
zram_bvec_write_multi_pages_partial when you try to write a 16K or
smaller folio to swap0-3. As want_multi_pages_comp will evaluate to false
as 16K is less than 32K, you will just end up in zram_bio_write_page?

Thanks,
Usama


> Sorry, I forgot to mention that the assumption is ZSMALLOC_MULTI_PAGES_ORDER=3,
> so data is compressed in 32KiB blocks.
> 
> With Chris' and Kairui's new swap optimization, this should be minor,
> as each cluster has
> its own order. However, I recall that order-0 can still steal swap
> slots from other orders'
> clusters when swap space is limited by scanning all slots? Please
> correct me if I'm
> wrong, Kairui and Chris.
> 
>>
>>>
>>> We only swapout whole folios. If ZCOMP_MULTI_PAGES_SIZE=64K, any folio smaller
>>> than 64K will end up in zram_bio_write_page. Folios greater than or equal to 64K
>>> would be dispatched by zram_bio_write_multi_pages to zram_bvec_write_multi_pages
>>> in 64K chunks. So for e.g. 128K folio would end up calling zram_bvec_write_multi_pages
>>> twice.
>>
>> In v2, I changed the default order to 2, allowing all anonymous mTHP
>> to benefit from this
>> feature.
>>
>>>
>>> Or is this for the case when you are using zram not for swap? In that case, I probably
>>> dont need to consider zram_bvec_write_multi_pages_partial write case for zswap.
>>>
>>> Thanks,
>>> Usama
>>
> 
> Thanks
> barry


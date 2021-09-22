Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A49DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED553611C9
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhIVM7f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhIVM7f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 08:59:35 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AA2C061756
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:58:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b10so3169900ioq.9
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQmTeeI9SmVhpWXFHOOADd2pL7AYSuP57rY9o9YQggQ=;
        b=Q2bgtXzBfU+xjTojiQA8LyZH3763j5d7nj2Ly2NI76so2njbQUvzg65LJZQ092Wy2Q
         VvI66chJiA5mW8ZKmmQsPO97CZjGqDrKG310YyKphE5+k8Rdf9i4Om2P4W1G37yidir4
         UFEJ9aE6eZt/J6i4DDK5xKr3M5sI2V6LnQNKCaaWmfub3P6A/645tcH2MhHLZ0kGIUSL
         sncKoAU3GnfWsFwnJJ62SEtAdDfoxELXKNZtsRWqQg49LrjqyKg2k7w9qJMFrnVCEQTN
         kde1kyQFr20CU5Io6gXvfdSeoUqtEjyT8PN7Iy/RJBBqwLwYAW/Kaek+V/Odkc9++H9g
         h8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQmTeeI9SmVhpWXFHOOADd2pL7AYSuP57rY9o9YQggQ=;
        b=28FBMdWBcMvDpDokoUBsnwgowKMWGoDGb740cnDc7SHb3BbAjA9WNhMavRrz4JFcYS
         WDf2TSkydeugd8W3rV07z8zzjNm3HUOtSkvITq0jjuow06x3GLTzh9NRVb0ukeSRqzwb
         1gEk1iWR3WR9awKK6lthBy8CSRg3A07gP6GZuDJ/8quhlSNZI/Uzri1TBQMlZwfifGKy
         MNONYttm/sbMGZ0wOnIw1NEXHYGaElTvhbV/b7eVhooFrGKyxDGkIW8Sz3OzSceeNwK2
         JzERm85KIeWbIJhjCQ1EYJbRIzj77QhcW0mTXw88hSXKKOHkbRaWd2v5+0zgNfkAWWih
         TRHw==
X-Gm-Message-State: AOAM530DYaoipRvduS6egg+0SdBdKFktYpsCm6gdCCXz0hZaVS3dSR0W
        ITbCWlyLSw2ZR7eXv4b+EuVmoA==
X-Google-Smtp-Source: ABdhPJx2uF78lzrG6cPMKm0MQ8uI7yebjSSryN4YgHlkldLqtkdgq95l0JJCd72wzgvgPNAjZQOdOw==
X-Received: by 2002:a05:6638:1389:: with SMTP id w9mr4665060jad.138.1632315484395;
        Wed, 22 Sep 2021 05:58:04 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y124sm996408iof.8.2021.09.22.05.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 05:58:04 -0700 (PDT)
Subject: Re: [RFC v2 PATCH] mm, sl[au]b: Introduce lockless cache
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        John Garry <john.garry@huawei.com>,
        linux-block@vger.kernel.org, netdev@vger.kernel.org
References: <20210920154816.31832-1-42.hyeyoo@gmail.com>
 <ebea2af2-90d0-248f-8461-80f2e834dfea@kernel.dk>
 <20210922081906.GA78305@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <688e6750-87e9-fb44-ce40-943bad072e48@kernel.dk>
Date:   Wed, 22 Sep 2021 06:58:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210922081906.GA78305@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/21 2:19 AM, Hyeonggon Yoo wrote:
> On Tue, Sep 21, 2021 at 09:37:40AM -0600, Jens Axboe wrote:
>>> @@ -424,6 +431,57 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>>>  }
>>>  EXPORT_SYMBOL(kmem_cache_create);
>>>  
>>> +/**
>>> + * kmem_cache_alloc_cached - try to allocate from cache without lock
>>> + * @s: slab cache
>>> + * @flags: SLAB flags
>>> + *
>>> + * Try to allocate from cache without lock. If fails, fill the lockless cache
>>> + * using bulk alloc API
>>> + *
>>> + * Be sure that there's no race condition.
>>> + * Must create slab cache with SLAB_LOCKLESS_CACHE flag to use this function.
>>> + *
>>> + * Return: a pointer to free object on allocation success, NULL on failure.
>>> + */
>>> +void *kmem_cache_alloc_cached(struct kmem_cache *s, gfp_t gfpflags)
>>> +{
>>> +	struct kmem_lockless_cache *cache = this_cpu_ptr(s->cache);
>>> +
>>> +	BUG_ON(!(s->flags & SLAB_LOCKLESS_CACHE));
>>> +
>>> +	if (cache->size) /* fastpath without lock */
>>> +		return cache->queue[--cache->size];
>>> +
>>> +	/* slowpath */
>>> +	cache->size = kmem_cache_alloc_bulk(s, gfpflags,
>>> +			KMEM_LOCKLESS_CACHE_QUEUE_SIZE, cache->queue);
>>> +	if (cache->size)
>>> +		return cache->queue[--cache->size];
>>> +	else
>>> +		return NULL;
>>> +}
>>> +EXPORT_SYMBOL(kmem_cache_alloc_cached);
> 
> Hello Jens, I'm so happy that you gave comment.
> 
>> What I implemented for IOPOLL doesn't need to care about interrupts,
>> hence preemption disable is enough. But we do need that, at least.
> 
> To be honest, that was my mistake. I was mistakenly using percpu API.
> it's a shame :> Thank you for pointing that.
> 
> Fixed it in v3 (work in progress now)

Another thing to fix from there, just make it:

if (cache->size)
	return cached item
return NULL;

No need for an if/else with the return.

> 
>> There are basically two types of use cases for this:
>>
>> 1) Freeing can happen from interrupts
>> 2) Freeing cannot happen from interrupts
>>
> 
> I considered only case 2) when writing code. Well, To support 1),
> I think there are two ways:
> 
>  a) internally call kmem_cache_free when in_interrupt() is true
>  b) caller must disable interrupt when freeing
> 
> I think a) is okay, how do you think?

If the API doesn't support freeing from interrupts, then I'd make that
the rule. Caller should know better if that can happen, and then just
use kmem_cache_free() if in a problematic context. That avoids polluting
the fast path with that check. I'd still make it a WARN_ON_ONCE() as
described and it can get removed later, hopefully.

But note it's not just the freeing side that would be problematic. If
you do support from-irq freeing, then the alloc side would need
local_irq_save/restore() instead of just basic preempt protection. That
would make it more expensive all around.

> note that b) can be problematic with kmem_cache_free_bulk
> as it says interrupts must be enabled.

Not sure that's actually true, apart from being bitrot.

>> How does this work for preempt? You seem to assume that the function is
>> invoked with preempt disabled, but then it could only be used with
>> GFP_ATOMIC.
> 
> I wrote it just same prototype with kmem_cache_alloc, and the gfpflags
> parameter is unnecessary as you said. Okay, let's remove it in v3.

Please also run some actual comparitative benchmarks on this, with a
real workload. You also need an internal user of this, a stand-alone
feature isn't really useful. It needs someone using it, and the
benchmarks would be based on that (or those) use cases.

Another consideration - is it going to be OK to ignore slab pruning for
this? Probably. But it needs to be thought about.

In terms of API, not sure why these are separate functions. Creating the
cache with SLAB_FOO should be enough, and then kmem_cache_alloc() tries
the cache first. If nothing there, fallback to the regular path.
Something like this would only be used for cases that have a high
alloc+free rate, would seem like a shame to need two function calls for
the case where you just want a piece of memory and the cache is empty.

-- 
Jens Axboe


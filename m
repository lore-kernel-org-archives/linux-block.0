Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E94C76195
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 23:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjCXXLR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjCXXLQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 19:11:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D9313D76
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 16:11:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso6745940pjf.0
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 16:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679699474; x=1682291474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AG8XZ588zOoU/1W2BkCpxa6WVbxvvO3WvuuWjv7bwk=;
        b=tOs5ucW1H6zBo5LjLmuiOfwM9Gjjqflwr4RNqQ5TCMafD31qkjDCQI6pyybp2sglQA
         N6+5ijJBX3i68XonDvK5w1InVnBbeyAhPzFTFFUSlpXjll/SAK+gpWADoddBI0HvI3oa
         Z6pD7LbV7LdQ0mzaT/S2bI6YzhXlHx3WncV5YLlZQxpu3rY4QG4i4Xa+XPZSUdLimHt1
         5KgNNQi6T5txwUXb62SJEKkvutec4Diq8HpIuJDWFKY8HNFBi2/3T4YFv/n2CPlhro4L
         CxTuDozFc3n+YZGUA2hIU7C3ZFQMiOpD/bkx+GB+yF/d9QuUyjg4WbPMdDGjFgE7hICc
         WKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679699474; x=1682291474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AG8XZ588zOoU/1W2BkCpxa6WVbxvvO3WvuuWjv7bwk=;
        b=CPh1gk8Ycew9gVeCVTaAs45o2AadxYvlGRze7dbeyKeTGa3LuGBwrIgfjbUrZFMGcE
         kJlORbETkB0T8I7MgzRcTSf5c/ORoCtxGFPIsuUGhsLvourayDswguB/mTgVEViXtLJe
         4SWSUdjU06xf500wU7UM/vaidgtkdxN5oNuEthFtkEAbN24eA/Ohb30zvMuHpe4ut+se
         WnAb4ATKBJsFygzzB50Bz2Rro7nlx6nPizL6IBQ+W3bp6DlJneMTxGmMI+krmkoHEEnf
         2vCuIvTsxVLHRdid3pT8g5JkHzcrtoboPUTzng9InpRBWzdUr9Huo0bdYg6YcgKOq0Hi
         zVKA==
X-Gm-Message-State: AO0yUKVoaPQma48EsUc+AYpd+6u4xGfxrIjbX4fLipADt3RwnSqN2fuX
        whfxEIVmPNAmOP3qIdKV97t2rw==
X-Google-Smtp-Source: AK7set+XFzZaJLA53+kx0/SHeEfdBJK/e85/nJlzWqlLgjz6Hp+dUQCBbIoXUqWljtYv1QX69csjBA==
X-Received: by 2002:a05:6a20:6914:b0:cc:bf13:7b1c with SMTP id q20-20020a056a20691400b000ccbf137b1cmr3206485pzj.0.1679699473818;
        Fri, 24 Mar 2023 16:11:13 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d10-20020a634f0a000000b0050f56964426sm11899902pgb.54.2023.03.24.16.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 16:11:13 -0700 (PDT)
Message-ID: <e552ad80-37fe-247e-aaf1-064572ccc154@kernel.dk>
Date:   Fri, 24 Mar 2023 17:11:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [dm-6.4 PATCH v2 3/9] dm bufio: improve concurrent IO performance
Content-Language: en-US
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, ebiggers@kernel.org, keescook@chromium.org,
        heinzm@redhat.com, nhuck@google.com, linux-block@vger.kernel.org,
        ejt@redhat.com, mpatocka@redhat.com, luomeng12@huawei.com
References: <20230324175656.85082-1-snitzer@kernel.org>
 <20230324175656.85082-4-snitzer@kernel.org>
 <a1b8ceb8-0a67-86a1-2222-1625f6ebbe33@kernel.dk>
 <ZB4p2NfwIhh9raxa@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZB4p2NfwIhh9raxa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/23 4:53?PM, Mike Snitzer wrote:
> On Fri, Mar 24 2023 at  3:34P -0400,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> Just some random drive-by comments.
>>
>>> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
>>> index 1de1bdcda1ce..a58f8ac3ba75 100644
>>> --- a/drivers/md/dm-bufio.c
>>> +++ b/drivers/md/dm-bufio.c
>>> +static void lru_destroy(struct lru *lru)
>>> +{
>>> +	BUG_ON(lru->cursor);
>>> +	BUG_ON(!list_empty(&lru->iterators));
>>> +}
>>
>> Ehm no, WARN_ON_ONCE() for these presumably.
> 
> Yeah, I raised concern about the BUG_ONs with Joe. Will try to rid the
> code of BUG_ONs as follow-on work.

Please do.

>>> @@ -116,9 +366,579 @@ struct dm_buffer {
>>>  #endif
>>>  };
>>>  
>>> +/*--------------------------------------------------------------*/
>>> +
>>> +/*
>>> + * The buffer cache manages buffers, particularly:
>>> + *  - inc/dec of holder count
>>> + *  - setting the last_accessed field
>>> + *  - maintains clean/dirty state along with lru
>>> + *  - selecting buffers that match predicates
>>> + *
>>> + * It does *not* handle:
>>> + *  - allocation/freeing of buffers.
>>> + *  - IO
>>> + *  - Eviction or cache sizing.
>>> + *
>>> + * cache_get() and cache_put() are threadsafe, you do not need to
>>> + * protect these calls with a surrounding mutex.  All the other
>>> + * methods are not threadsafe; they do use locking primitives, but
>>> + * only enough to ensure get/put are threadsafe.
>>> + */
>>> +
>>> +#define NR_LOCKS 64
>>> +#define LOCKS_MASK (NR_LOCKS - 1)
>>> +
>>> +struct tree_lock {
>>> +	struct rw_semaphore lock;
>>> +} ____cacheline_aligned_in_smp;
>>> +
>>> +struct dm_buffer_cache {
>>> +	/*
>>> +	 * We spread entries across multiple trees to reduce contention
>>> +	 * on the locks.
>>> +	 */
>>> +	struct tree_lock locks[NR_LOCKS];
>>> +	struct rb_root roots[NR_LOCKS];
>>> +	struct lru lru[LIST_SIZE];
>>> +};
>>
>> This:
>>
>> struct foo_tree {
>> 	struct rw_semaphore lock;
>> 	struct rb_root root;
>> 	struct lru lru;
>> } ____cacheline_aligned_in_smp;
>>
>> would be a lot better.
>>
>> And where does this NR_LOCKS come from? Don't make up magic values out
>> of thin air. Should this be per-cpu? per-node? N per node? I'll bet you
>> that 64 is way too much for most use cases, and too little for others.
> 
> I cannot speak to the 64 magic value (other than I think it worked
> well for Joe's testbed).  But the point of this exercise is to split
> the lock to avoid contention.  Using 64 accomplishes this. Having
> there be more or less isn't _that_ critical.  The hash to get the
> region index isn't a function of cpu.  We aren't after lockless here.

I don't doubt it worked well in his setup, and it'll probably be fine in
a lot of setups. But the point still stands - it's a magic value, it
should at least be documented. And 64 is likely way too much on a lot of
machines.

> Now that said, will certainly discuss further with Joe and see if we
> can be smarter here.
> 
> Your suggestion to combine members certainly makes a lot of sense.  I
> ran with it relative to the bio-prison-v1 (patch 9) changes which have
> the same layout. Definitely a win on in-core memory as well as
> avoiding cacheline thrashing while accessing the lock and then the
> rb_root members (as is always expected):

Right, this is why I suggested doing it like that. It's not very smart
to split related members like that, wastes both memory and is less
efficient than doing the right thing.

>> I stopped reading here, the patch is just too long. Surely this could be
>> split up?
>>
>>  1 file changed, 1292 insertions(+), 477 deletions(-)
>>
>> That's not a patch, that's a patch series.
> 
> I don't want to upset you or the community but saying this but:
> in this narrow instance where a sizable percentage of the file got
> rewritten: to properly review this work you need to look at the full
> scope of the changes in combination.

That's nonsense. That's like saying "to see what this series does, apply
the whole thing and compare it with the file before". With that logic,
why even split changes ever.

A big patch that could be split is harder to properly review than a lot
of small patches. Nobody ever reviews a 1000+ line patch. But I guess we
can just stop reviewing?

It should be split, it's really not up for debate.

-- 
Jens Axboe


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56F0C433ED
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 17:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CDB61449
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 17:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244554AbhDURDa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhDURDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 13:03:30 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C9C06174A
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 10:02:57 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id c3so29354226ils.5
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e6ikmwrjpKlkKeFeYdJhgy/KR5GGwTCdvDEKKhnDAnE=;
        b=v3GKwl6bWv+npcYPfhiU/swRwUtSuonAoyOq5y2B2kzwkD+L0xgO6V+8rspLM6mQhl
         wgP9lGU/rqwZhIFK6h3UOMfJjLkKqi4rwADtAljbvdHsoXUNTy3AeZFP7TyyylhJGzS/
         qPbxQbVuKhfYfsgxGD32Zv5XiXe1V6wkRVUIDCWZ1owEpToeWN9IdYWJRFJytvwRo4xd
         b6N7Zhe0wEoA7drDLJhs9kHF5dRWoWRFwxCKBdjWmwCad/+NuERoLBx7gQKAnFQvWQfn
         z7dyAnPePLsclWZenlGc7nvMQRrG/czmpTdgQspHc4QJ+TnvX63/6kWjA9+vpslX+Qno
         qnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e6ikmwrjpKlkKeFeYdJhgy/KR5GGwTCdvDEKKhnDAnE=;
        b=r+c3pJ4kpAxaL8bg8l+9ssM8klf3iqiEdx2fSyXg2hBGXuHRBbm3kSVZ1y6aaIcGvG
         i6boMPigzPrr+YwTFwk/7EBqQGIlupkkk/loVUGIBLjucypO0KCaDmfCmS7dJqEhZGkm
         t6wEHkXSN/JT/lM8M/trL6cLlqbOJnZibuMFsxikMwsg3WblRbqWeNzK1sWBA6tV4zQY
         JmLLC21BnRoLLHMouY9A0RVepixNtimYa+OS96GrvyMjjDCo6fgYsmj8p2Gjj4DV2JgY
         z/v/OX/lw7FyUvZeePKbc+lELlI9e1n9YeKpIbtFtgpFapww0nxBtft1KJUOiHCqZLJo
         CwhA==
X-Gm-Message-State: AOAM530voLZElF6Qkwm2uBVK36KYcOdh5KOPgg+GY0LBX/jj70pMg/vW
        pDIHWQeofZ40AtXJLalgoh6j3g==
X-Google-Smtp-Source: ABdhPJwOkXpmfCJXELkJX2DMvit+8kHricfSAyoW7CAGmDffCgqn9Lrze7CzJ05ggcUsIIqI+J0LIw==
X-Received: by 2002:a92:3212:: with SMTP id z18mr25972960ile.171.1619024575267;
        Wed, 21 Apr 2021 10:02:55 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k14sm2116iov.35.2021.04.21.10.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 10:02:54 -0700 (PDT)
Subject: Re: [PATCH V6 0/3] block: add two statistic tables
To:     Jinpu Wang <jinpu.wang@ionos.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Md Haris Iqbal <haris.iqbal@ionos.com>,
        linux-block <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@ionos.com>
References: <20210409160305.711318-1-haris.iqbal@ionos.com>
 <ef59e838-4d7f-cab4-e1ac-26944cb7db75@kernel.dk>
 <CAMGffE=ZdCUc_HABY3_F_aK6pqCt8maB4yi9Qu4gKoox6ub6QQ@mail.gmail.com>
 <16182211-0e85-540d-1061-6411ec3351a5@kernel.dk>
 <CAMGffE=t85WAgpzHu5zaM+NAa4hrBYcUEOo=z2jNkkr9ZSc0bg@mail.gmail.com>
 <967e1953-6eb7-4a63-f5f4-91d99a6a7f5a@gmail.com>
 <CAMGffEnnhbPje7bB-W3jaMUF-JGBT0w0jCWeupsU8mwFFOHwSA@mail.gmail.com>
 <38b295a6-3260-a694-c8cf-1135c92b28d6@gmail.com>
 <CAMGffEmFsvv-0OkxycG-8CXA1N42VN66QLWFgtC05pH3Dkv-BQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f79aca16-bc22-0c27-5a55-f85ac64ccba4@kernel.dk>
Date:   Wed, 21 Apr 2021 11:02:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMGffEmFsvv-0OkxycG-8CXA1N42VN66QLWFgtC05pH3Dkv-BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/21 5:57 AM, Jinpu Wang wrote:
> On Wed, Apr 21, 2021 at 1:55 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 4/21/21 12:50 PM, Jinpu Wang wrote:
>> [snip]
>>>>> Hi Jens,
>>>>> The problem with using blktrace at production may cause a performance
>>>>> drop ~30%. while with the block stats here, we only see ~3% when
>>>>> enabled.
>>>>
>>>> It's probably was asked before, but let's refresh as the discussion
>>>> erupted again.
>>>>
>>>> I get your problem with blktrace(8), IIRC it definitely can deteriorate
>>>> performance if run constantly, but did you try to write a bpf program
>>>> that does smarter accumulation in the kernel? Like making bpf to collect
>>>> a latency table (right as in your patches do) and flushing it to the
>>>> disk periodically?
>>> Hi Pavel,
>>>
>>> Thanks for the suggestion.
>>>
>>> We did test with ebpf with kprobe in the past (~kernel 4.4/4.14), we
>>> saw 10% performance drop, that's the reason we develop this
>>> stats patches.
>>>
>>> But I just did another test with bpftrace on k 5.10.30, I do not see
>>> performance lost.
>>> It must be ebpf is improving very much since then.
>>>
>>> So to summarize, we can use bpftrace to do the drop in latest kernel,
>>> there is no need to have it build into the kernel.
>>
>> Perfect, and I'm sure it will be even more convenient for you, for
>> instance to gather other stats or do it somehow differently
> 
> Yeah, agree.
> Thanks again!

Perfect, thanks! I'll drop the series.

-- 
Jens Axboe


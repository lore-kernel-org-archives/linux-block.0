Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B025ECAAA1
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 13:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJ1NSC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 09:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1NSC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 09:18:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F1C2CAF
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 06:18:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so5467956wms.1
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h74hDRhazqx7rczW4tdW53NSClc8kInQUERZYrOsvhg=;
        b=DbLvo3at4CgKl7sFbB8NoffY+FF2WrtI+slnOhr4dduuRGBmh/T3l+6f1z2QBWnsHh
         tuiI4m15TENzsGaA8C+NTr7pIueXpHbiTH5yMQY8R26+guwBIBhag2yk8QqI5HpTQNH1
         pZ+ceXw3jClm7YlJrHDKpHjQ+f82V6oti/vJYiQgoXgZ9hMRj1oO1TailM7hEFDjPMNK
         zgw7Xw9FkC0uqkr7bouDw/o7qSir1rRCbm7BaSMbh+ujssbUflD1mq9Mggr4sKq/5JER
         xkKIInYkxqvhRk+HBsDgX6TWAvVBxdpXpk7YHkejVF1aJEI6tcslFcLVPNg+zrWOvKe8
         +ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h74hDRhazqx7rczW4tdW53NSClc8kInQUERZYrOsvhg=;
        b=5CNhoI1VVIl7eK5zn9J49pYMMCg9P/xy4HZVLV0zqLUOF3WSdvDjwnMkOgSgRnxVuC
         z4u7L0Ic2iUTiZq+Wx3gV/wgMVMH2uxAx8pIBNBgBUPvgi3pGDj3kYqpRJPTqJ+QP5ST
         vJjuLfwkJ9wv6LREl2dwzxVC8UG3irstDhgzi5dh5RhGe0MxbLpb3AVbS3F2KXq2XKmk
         CLefUzaE3c3VmjJz5whEowekmAN9I3Sh+IHVtv3Qt/1dZaPAeItL6KFPPvoVkp8k8zu+
         vJjIWaCPmTVm3H9CZ1HaaYSUoOZyTpKFtMy7Tbjt+igv93Cy/PhDoTu64X8zZIKpzkWi
         EdwQ==
X-Gm-Message-State: ACrzQf22mHhYGRnehssje7zEGnujUDa6C34Z3KSyOki1QESDHw4T+7yR
        NSLRqTEQNhuK3qzvVufl1aLMfnGu2CxOAg==
X-Google-Smtp-Source: AMsMyM7uwxFjWoUh42inUVjFb6XPwRtW4vgsL/NdWWyUK2oFKygXdFVjmVpupu6vU9VgO50PWTpB+A==
X-Received: by 2002:a7b:ca51:0:b0:3cf:4969:9be6 with SMTP id m17-20020a7bca51000000b003cf49699be6mr9622552wml.24.1666963079809;
        Fri, 28 Oct 2022 06:17:59 -0700 (PDT)
Received: from [192.168.43.77] (82-132-219-192.dab.02.net. [82.132.219.192])
        by smtp.gmail.com with ESMTPSA id i8-20020a1c5408000000b003c5571c27a1sm5250779wmb.32.2022.10.28.06.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:17:59 -0700 (PDT)
Message-ID: <6153ac75-61dd-ef57-bf35-8f9d01c78969@gmail.com>
Date:   Fri, 28 Oct 2022 14:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH for-6.1 0/2] iopoll bio pcpu cache fix
Content-Language: en-US
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <cover.1666886282.git.asml.silence@gmail.com>
 <983a4fda-5e42-3a26-81f6-65e8cd343f8e@kernel.dk>
 <13b597a1-b955-ba52-aa1b-174d789a5d7b@kernel.dk>
 <6d882bc4-3c9d-ee4b-8a98-3ef61ed3201f@gmail.com>
In-Reply-To: <6d882bc4-3c9d-ee4b-8a98-3ef61ed3201f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/22 01:13, Pavel Begunkov wrote:
> On 10/28/22 00:55, Jens Axboe wrote:
>> On 10/27/22 5:27 PM, Jens Axboe wrote:
>>> On 10/27/22 4:14 PM, Pavel Begunkov wrote:
>>>> There are ways to deprive bioset mempool of requests using pcpu caches
>>>> and never return them back, which breaks forward progress guarantees bioset
>>>> tried to provide. Fix it.
>>>>
>>>> Pavel Begunkov (2):
>>>>    mempool: introduce mempool_is_saturated
>>>>    bio: don't rob bios from starving bioset
>>>>
>>>>   block/bio.c             | 2 ++
>>>>   include/linux/mempool.h | 5 +++++
>>>>   2 files changed, 7 insertions(+)
>>>>
>>>
>>> This isn't really a concern for 6.1 and earlier, because the caching is
>>> just for polled IO. Polled IO will not be grabbing any of the reserved
>>> inflight units on the mempool side, which is what guarantees the forward
>>> progress.
> 
> And after looking it up, apparently it can allocate from reserves.
> 
> 
>>> It'll be a concern for the 6.2 irq based general caching, so it would
>>> need to be handled there. So perhaps this can be a pre-series for a
>>> reposting of that patchset.
>>
>> Just a followup, since we had some out-of-band discussion. This is
>> a potential concern on the bio side, though not on the request side.
>> But this approach is racy, we'll figure something else out.
> 
> I agree that it _may_ be, but I can't think of an counter example
> for arches w/ strong ordering and would need to think more if there
> is an issue in the looser ephemeral world.

Let me try to prove it's not a problem:

It's not interesting if didn't allocate from reserves as it won't affect
mempool. Neither we care about falsely avoiding pcpu cache, i.e. trying
to return into the mempool more than needed. So, the only potential race
problem that requires explanation is when the bio is from reserves but
we see that the mempool is full and it's not. Because of spinlocks
around ->curr_nr modifications and the fact that we won't see random
invented values, it might have only happened if there were both bio
allocations and bio puts strictly after our allocation, after
spin_unlock to be more specific. But then those puts and allocs are
serialised by the mutex, we can take a bio alloc that happened right
after a put that filled the mempool full and recurse all the reasoning.

I'm rusty on formal proves and it can be more formal, but would be
interesting to see if it's flawed and/or get a counter example.
In any case, it only returns more bios into mempool, which won't hurt
the issue.

-- 
Pavel Begunkov

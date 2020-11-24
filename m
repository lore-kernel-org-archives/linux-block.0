Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC6C2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2162B20715
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEhJXI4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389261AbgKXOql (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389259AbgKXOql (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 09:46:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3AAC0613D6;
        Tue, 24 Nov 2020 06:46:40 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so2629459wmd.4;
        Tue, 24 Nov 2020 06:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JAiKboQNcg9PvHpmhhaPNpj27N5kpi4RjRS1qOB3DC8=;
        b=rEhJXI4QN11bEMzT4hn3zISVhwOD47VKobKVOg8DAAdpL24yAbMjAzOyflbGz1XjJu
         T41HIurWkMSbUBZ724HVNRzcfjtHLzcTTO6nplwDW8fEgpOdTDTOPSygHz0Cds6Q8c0U
         E0dJAPdrgfLSaPDLbt9klgV7+7dZLfZ6W7dK9EX1m5R4clZKsXmznT4YQ4EcwFqtItqv
         +o4pFhiQc1/4Olqqixvq/gYQajAl83x3uX6cAD+F4NdKf9QvSiaQb4TGJa97KHQTuxaA
         DL7x0WBXjWtcjTMDREq6jlsdFfn7fhowy9slAwwS+CV2jrza3PmN2UYDncXGgte/sj9I
         siNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JAiKboQNcg9PvHpmhhaPNpj27N5kpi4RjRS1qOB3DC8=;
        b=QWC0qOxj5E9lHJlkURVy/uHQWIpmeBi/U5PcMHG+iokPX1jxdae8F6sxY/8jUsd+JO
         daOFPXufNe5BuukhqHdKld1qEEoOqslBOVSiND9eHpwygDLbqQfl10GR4/4QNJhzKEVz
         AyE3blf7u2Nifj/MjMIpNYgaAuH4hQuo3dsy6xJst55knZj62lg30WlDvZOJRDGeEOSp
         FeDjUHUdGaalZjiykyfgA+kgGo1FWzKVJRMMcyF8KzEowDjJCWD+YCk2G0VFvxnJszNH
         gKjFQDlb1yTNZxyNJm8U8qgzFIyJYpTPPm3jpdWFMUAkHv2oZJW7hBCqtZ99Bv9a+XHM
         hFBA==
X-Gm-Message-State: AOAM533zkgFGOJRCXIsQft1I6pn5GKhlTg2KVxjbKWQRO+Ow7r+bprlC
        6WkDD268X50v29ZGCwH05bdKQOf2p3t6lMNb
X-Google-Smtp-Source: ABdhPJwFKzNoVF/Y4L5Zh2ZGOMGIFGWc2hvXAqZMPAO4p2YXc16KFLAO2puXJCCfgr+9ji5EcAZV+A==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr4849175wml.96.1606229199083;
        Tue, 24 Nov 2020 06:46:39 -0800 (PST)
Received: from [192.168.1.216] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id x13sm5736226wmi.20.2020.11.24.06.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 06:46:38 -0800 (PST)
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1606058975.git.asml.silence@gmail.com>
 <488177c02dccda60c5e8af2e53156c42b7f1acc0.1606058975.git.asml.silence@gmail.com>
 <17b6011c-b519-3332-e9b7-de36109db85a@huawei.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 2/4] sbitmap: remove swap_lock
Message-ID: <5f10de12-ffe1-dfef-d9ff-74b13a7f0426@gmail.com>
Date:   Tue, 24 Nov 2020 14:43:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <17b6011c-b519-3332-e9b7-de36109db85a@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/11/2020 14:22, John Garry wrote:
> On 22/11/2020 15:35, Pavel Begunkov wrote:
>> map->swap_lock protects map->cleared from concurrent modification,
>> however sbitmap_deferred_clear() is already atomically drains it, so
>> it's guaranteed to not loose bits on concurrent
>> sbitmap_deferred_clear().
>>
>> A one threaded tag heavy test on top of nullbk showed ~1.5% t-put
>> increase, and 3% -> 1% cycle reduction of sbitmap_get() according to perf.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   include/linux/sbitmap.h |  5 -----
>>   lib/sbitmap.c           | 14 +++-----------
>>   2 files changed, 3 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index e40d019c3d9d..74cc6384715e 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -32,11 +32,6 @@ struct sbitmap_word {
>>        * @cleared: word holding cleared bits
>>        */
>>       unsigned long cleared ____cacheline_aligned_in_smp;
>> -
>> -    /**
>> -     * @swap_lock: Held while swapping word <-> cleared
>> -     */
>> -    spinlock_t swap_lock;
>>   } ____cacheline_aligned_in_smp;
>>     /**
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index c1c8a4e69325..4fd877048ba8 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -15,13 +15,9 @@
>>   static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>   {
>>       unsigned long mask, val;
>> -    bool ret = false;
>> -    unsigned long flags;
>>   -    spin_lock_irqsave(&map->swap_lock, flags);
>> -
>> -    if (!map->cleared)
>> -        goto out_unlock;
>> +    if (!READ_ONCE(map->cleared))
>> +        return false;
> 
> So if we race with another cpu, won't the 2nd cpu see that the mask is 0 returned from the xchg (not shown)? If so, it's odd to continue to do the CAS - or atomic not, from later patch - on a mask of 0.

Yeah, but this part is legit and I don't expect it to be so
contended to need an additional check, especially with atomic
and from [3/4].

I'm more concerned about sbitmap_resize*() callers to do right
synchronisation (e.g. quiesce) and not rely on that critical
section I remove. Would be great if anyone can confirm that.

> 
> Thanks,
> John
> 
>>         /*
>>        * First get a stable cleared mask, setting the old mask to 0.
>> @@ -35,10 +31,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>           val = map->word;
>>       } while (cmpxchg(&map->word, val, val & ~mask) != val);
>>   -    ret = true;
>> -out_unlock:
>> -    spin_unlock_irqrestore(&map->swap_lock, flags);
>> -    return ret;
>> +    return true;
>>   }
>>     int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>> @@ -80,7 +73,6 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>>       for (i = 0; i < sb->map_nr; i++) {
>>           sb->map[i].depth = min(depth, bits_per_word);
>>           depth -= sb->map[i].depth;
>> -        spin_lock_init(&sb->map[i].swap_lock);
>>       }
>>       return 0;
>>   }
>>
> 

-- 
Pavel Begunkov

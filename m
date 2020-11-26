Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA520C63777
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 13:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE6220DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 13:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYfluQ2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390735AbgKZNru (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 08:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390524AbgKZNru (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 08:47:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97E0C0613D4;
        Thu, 26 Nov 2020 05:47:49 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so2460976wmb.5;
        Thu, 26 Nov 2020 05:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42IiVM2iDa/ycvnEnXQM3gjeNp3QeNAvXnEQm3/xGY0=;
        b=qYfluQ2skD66SH8JAnuV0sEMqK5j03/OX/nqV6NBvOT6AdOLuoaCmixOJmd7sOC4a3
         ojZTWilrnFGf+g2KTnPI/d6n5H4fkvamSdjO3yhiLGNzSuBdBmNZm1i+jmMwyv0PGNDl
         +6pybafgM7CJw/kAfzm2bmUnBN5m+J967YvC6oSi99snsGKO7ugSJQ8B8TrU+zPQQyoP
         z8U/mhR3/h6zqU2+9WCtI/ATFyFSH5ZFT8y9psdULDAXFv5wzG7OGvK85sXjBvLFhkX4
         FyDkRPJ+u62iA/pClMeAn3efEEvn3pQxcKOv3NDmyW/+wrfTR1OZhzpPjsHIyilXNOYc
         1voA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=42IiVM2iDa/ycvnEnXQM3gjeNp3QeNAvXnEQm3/xGY0=;
        b=kcklmcz+OC61Jo9VS+K16TjIVdaV5PyiE7vGxKaHqPV1xlc5dSUUrwNAsG5pkiEwby
         LuHWiIhj9kZEriqWHU+J3qXv7v3IOCDJ/nQ3eKKyXzyYgKnTUAwTvKthhLVhS7MOX/8l
         gyOT8dCoVBG8Y/KsHgz4HodUWrAO+ZSe/bGJW/3iVoh+W8IbV/YgXn89KWj1lD9Z6fF4
         s1f1Sm3CMn+DUgvwApSG9mg6jKSuyVBavHz62xdJTYnRtMEzhoKqFvur/Ro5g5RM7Vu9
         cxrns0e0cuwl9dsQOoy2qHWwUv2hlFfd5nDbv1h6wj9x1CIGnUCiwSRgj6sP0Trjrwte
         2l6Q==
X-Gm-Message-State: AOAM531r1KQgEy45ivSt7bBM+D+r04by1Co99tSOUStG9UsWWZg5duXr
        l7WFdLFyV396iRRk3dXO6270kf6Y7I8=
X-Google-Smtp-Source: ABdhPJxbS/OMVzeUV+23NHkUEkN1xfW7/aEEpUU5Yi1oe6auDrW7iBQ4lg8qAdPyCZALaecBfg/E1A==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr3580414wmi.70.1606398468250;
        Thu, 26 Nov 2020 05:47:48 -0800 (PST)
Received: from [192.168.1.118] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id p19sm9705686wrg.18.2020.11.26.05.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 05:47:47 -0800 (PST)
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>,
        linux-kernel@vger.kernel.org
References: <cover.1606058975.git.asml.silence@gmail.com>
 <488177c02dccda60c5e8af2e53156c42b7f1acc0.1606058975.git.asml.silence@gmail.com>
 <20201126024658.GA42718@T590>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 2/4] sbitmap: remove swap_lock
Message-ID: <3ef0bee9-e0e5-a249-9dfb-3ea3c0af2160@gmail.com>
Date:   Thu, 26 Nov 2020 13:44:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201126024658.GA42718@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26/11/2020 02:46, Ming Lei wrote:
> On Sun, Nov 22, 2020 at 03:35:46PM +0000, Pavel Begunkov wrote:
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
>>  include/linux/sbitmap.h |  5 -----
>>  lib/sbitmap.c           | 14 +++-----------
>>  2 files changed, 3 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index e40d019c3d9d..74cc6384715e 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -32,11 +32,6 @@ struct sbitmap_word {
>>  	 * @cleared: word holding cleared bits
>>  	 */
>>  	unsigned long cleared ____cacheline_aligned_in_smp;
>> -
>> -	/**
>> -	 * @swap_lock: Held while swapping word <-> cleared
>> -	 */
>> -	spinlock_t swap_lock;
>>  } ____cacheline_aligned_in_smp;
>>  
>>  /**
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index c1c8a4e69325..4fd877048ba8 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -15,13 +15,9 @@
>>  static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>  {
>>  	unsigned long mask, val;
>> -	bool ret = false;
>> -	unsigned long flags;
>>  
>> -	spin_lock_irqsave(&map->swap_lock, flags);
>> -
>> -	if (!map->cleared)
>> -		goto out_unlock;
>> +	if (!READ_ONCE(map->cleared))
>> +		return false;
> 
> This way might break sbitmap_find_bit_in_index()/sbitmap_get_shallow().
> Currently if sbitmap_deferred_clear() returns false, it means nothing
> can be allocated from this word. With this patch, even though 'false'
> is returned, free bits still might be available because another
> sbitmap_deferred_clear() can be run concurrently.

But that can happen anyway if someone frees a requests right after we
return from sbitmap_deferred_clear(). Can you elaborate what exactly
it breaks? Something in sbq wakeup paths?

-- 
Pavel Begunkov

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B67EC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B26261990
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 22:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCSW4R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCSW4K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 18:56:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22789C061760
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 15:56:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g15so6898306pfq.3
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e+jorAuKHjccGGronBtEJjxolrvQB+eZ/bSU4ApIaGU=;
        b=eyJU9zSEh0X7QgDoDvtKBN9JoTvhbORmoIkQ8fRIixNzCCry0E9M2bRgybWWCGrsRn
         QhQXQEZUKm6NXw5tjb5fYOhUxAYRzvlpRMRRH7w2C2yIWeb2ijCc+Hj0TMDCnrj9n8QQ
         i/li5jcAD1mEgTZ2yqc0pasmnLRZhT0C22NgaX+HqKN859wzU05R3ilpOw0I4HEZJl5w
         UxKlJgFkJ6HSPYLrl7j457yjyErFDj2GHKRnYykLrty7uTYPRYpQbSMNVdhGfWvw/7/S
         DO/+pLBHBL1AP1X6TBn5EqbZgrMgKiWVD6T2O5BXA/ewwIqM07GSNB4cQCgCU3nQGaoM
         uRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e+jorAuKHjccGGronBtEJjxolrvQB+eZ/bSU4ApIaGU=;
        b=H8dcKcsBENbXXSViTu6EfFqpdw20+B+u/pAVh3+EVqUk5aaBkoFGHrXI2YuGG831eP
         xoGWaYNKx4qexLmds4RxOpBpu1A8ygIi9t/o+7oEMobG6lEj9438DM1bl107Yrwwr8qZ
         vIyp1XjMBacIBlSdAnPpb5npsRmBa+Km7US6X+rWQRABnrRf+wCk+M8EVb5Dl0vcF4FN
         pARYTTyQ5zu4PzhHo4qPFX9Hc3Ny3XmYmV6kPpiGFFzQ3P86QNt9/uKdddg6ncRCGF2/
         ZaA/MjTQUVJZZtgpZ2rD+Sg87UZ5BN+uxnQJ+VThYI9b9ItScgokfgPG6LcQ1R8v3R4y
         o/Vw==
X-Gm-Message-State: AOAM533DNiQ6Y1bG5huUE1AoQuFupABuhZBQaF8AhURUAKo5KoCeIlSh
        CZyHK4ghdgi5MaflttSxkGP7IQ==
X-Google-Smtp-Source: ABdhPJy5BSJaBEGkTgocKKUpwz0gFz9hDkLyzm3Unp+7j3gHj/V4hQkK8oUOofwxQ1QHBJWWQyVPLA==
X-Received: by 2002:a63:db57:: with SMTP id x23mr13332240pgi.432.1616194569650;
        Fri, 19 Mar 2021 15:56:09 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q95sm6236116pjq.20.2021.03.19.15.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 15:56:09 -0700 (PDT)
Subject: Re: [PATCH V3] blk-mq: Trivial typo fix and sentence construction for
 better readability
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210319202359.8893-1-unixbhaskar@gmail.com>
 <771aa286-5270-9642-7d6d-9cdb2f7014f8@kernel.dk> <YFUMFBB8iuoSULxL@Gentoo>
 <080d3720-3174-e47f-95a1-ad7640a64051@kernel.dk> <YFUryzVjSQU0RqCv@Gentoo>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a5956c2c-1390-5c88-b61a-dffd10753de9@kernel.dk>
Date:   Fri, 19 Mar 2021 16:56:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFUryzVjSQU0RqCv@Gentoo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/19/21 4:55 PM, Bhaskar Chowdhury wrote:
> On 16:19 Fri 19 Mar 2021, Jens Axboe wrote:
>> On 3/19/21 2:39 PM, Bhaskar Chowdhury wrote:
>>> On 14:27 Fri 19 Mar 2021, Jens Axboe wrote:
>>>> On 3/19/21 2:23 PM, Bhaskar Chowdhury wrote:
>>>>>
>>>>> A typo fix and sentence reconstruction for better readability.
>>>>>
>>>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>>>> ---
>>>>>   Changes from V2:
>>>>>   Thanks, Randy and Tom for the suggestion,mould it.
>>>>>   Missed the subject line prefix of pattern,so added back
>>>>>
>>>>>  block/blk-mq-tag.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>>>> index 9c92053e704d..9da426d20f12 100644
>>>>> --- a/block/blk-mq-tag.c
>>>>> +++ b/block/blk-mq-tag.c
>>>>> @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>>>>>  }
>>>>>
>>>>>  /**
>>>>> - * blk_mq_tagset_wait_completed_request - wait until all completed req's
>>>>> - * complete funtion is run
>>>>> + * blk_mq_tagset_wait_completed_request - wait until all the req's
>>>>> + * functions completed their run
>>>>
>>>> This is still nonsense, see reply to previous version.
>>>>
>>> Well, I was just trying get a sense of your sense...so ...it's all yours
>>> fella,take on ...
>>
>> It's not my sense, I didn't write that function or comment. Just seems
>> pointless to me to update it and not get it actually legible and
>> correct, which is why I sent you a suggestion to what should be. From
>> that point of view, the suggested change actually makes it _worse_,
>> because "requests functions completed their run" doesn't mean anything.
>> At least the current one is kind of legible, since the "complete
>> function" refers to the IPI completion function, which is what we're
>> waiting for here.
>>
>> In any case, what I replied in v2 should be generally readable, and
>> avoids the weird req's thing too which I really dislike. Just uses
>> requests, that's correct and avoids a nonsensical possessive.
>>
>> So do send a v4 if you want with that wording.
>>
> I am apologetic about the pain I caused you to take this long route. I shall be
>   prudent in the future. Thanks for standing, Jens.

Well, at least the end result pulled it to completion :-)

-- 
Jens Axboe


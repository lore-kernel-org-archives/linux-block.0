Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A5CC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9AD61988
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhCSU02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhCSU0G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 16:26:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F92C06175F
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 13:26:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y200so6686876pfb.5
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DZnZz49iawE3OZlAe1Ih+YRDhBu+JzguYvzhzsJxLQQ=;
        b=BNgkduZW1CtflRKtlMGZvaKNp3OQC2y/o3lEnR9p4G43/wVO1iWiYNI//ZeUyPYczL
         JxQmlabl0+UevAMdYJDZyfLGANjBUf51GHntjCiG1Ll7BuJc1mBWROvSmfqvgA+I4jaA
         /JaHybC//mimlScpJ2Lyg4WyGYYV8k+iJNfjPO3RXIGJFVU3bz59Ckuf6Zl9B9DJPVBn
         QcRqoAx/KegyaaXpeu1TZvJK3hCUNvquczHAeEFDo4p8k/tuCstTLk3cLioExTXgLFQQ
         0yiTJIGQLSf1QENbMRBcl7Vly70ss8xDwGtelMH8m14fyyIHeXhZZujTRSvUHnoNaIaJ
         fZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DZnZz49iawE3OZlAe1Ih+YRDhBu+JzguYvzhzsJxLQQ=;
        b=qY0n5yPoI0JEL9wwB4vt59JZ+6T2y5t+Q2d1tXX0j4d1BoMVKQBEwLoqRjIQEtR6E1
         ZvfOPTkVGJHqJOO15OUKdBJToxat14v70Nl8SVy9q48x5HYdR8tV9WjRsHLa1WTMUDKi
         /TCGa4e4IFksHft0w3WampuFAZsmajesJmTGGcvUgYoqiXhACtky1BmeBSwzSWB6eQZK
         9xij4rl9HDZ0dEfaEj9BES3IOp7dzrw3pzuVsXbO0rzYGqILe2H5xdDlrFgI4viyOgZD
         1A0Qps5T2UgdvlnrQx25dOiRX+ohuyuxlN9ACaNuXtJWTTzHCX0ufUTrtC6I3YkjQ+kO
         RpjA==
X-Gm-Message-State: AOAM532YLm0DgFZ15QDbLvkNRtFrreHepja2YxgFW/kUnecGmURvCY8p
        TkiDpUoJHcgVClPfj0D8VRJgzA==
X-Google-Smtp-Source: ABdhPJwgDCOD+fVy9f1NB/SJZgCnmAks8peYsEJrcP/owyjiSB2PNfW1J2EQu5hvf8JhzwJIV1mDaw==
X-Received: by 2002:a63:b12:: with SMTP id 18mr13052286pgl.45.1616185565830;
        Fri, 19 Mar 2021 13:26:05 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 197sm6306527pfc.1.2021.03.19.13.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 13:26:04 -0700 (PDT)
Subject: Re: [PATCH V2] Trivial typo fix and sentence construction for better
 readability
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@bombadil.infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319195451.32456-1-unixbhaskar@gmail.com>
 <5ac591a4-2ed-311a-fcc2-3cc8443d71ef@bombadil.infradead.org>
 <YFUEgeN+oR9n8uoN@Gentoo>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bbe0aede-d821-3d26-d8b0-999f0adb406d@kernel.dk>
Date:   Fri, 19 Mar 2021 14:26:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFUEgeN+oR9n8uoN@Gentoo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/19/21 2:07 PM, Bhaskar Chowdhury wrote:
> On 13:03 Fri 19 Mar 2021, Randy Dunlap wrote:
>>
>> Hm, needs some spacing fixes IMO. See below.
>>
>>
>> On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:
>>
>>>
>>> s/funtion/functions/
>>>
>>> Plus the sentence reconstructed for better readability.
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>> ---
>>> Changes from V1:
>>>  Randy's suggestions incorporated.
>>>
>>> block/blk-mq-tag.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index 9c92053e704d..c2bef283db63 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>>> }
>>>
>>> /**
>>> - * blk_mq_tagset_wait_completed_request - wait until all completed req's
>>> - * complete funtion is run
>>> + * blk_mq_tagset_wait_completed_request - wait until all the  req's
>>
>>                                                             the req's
>>
>>> + *  functions completed their run
>>
>> and more indentation + wording on that line above:
>>  *        functions have completed their run
>>
> Apology...my bad ...fixing ...V3 ...in quick time ...

Easy, let's get this right instead of spinning tons of versions of a
trivial patch. The text should be:

Wait until all scheduled request completions have finished.

If we're fixing a typo, let's actually make it understandable too...

-- 
Jens Axboe


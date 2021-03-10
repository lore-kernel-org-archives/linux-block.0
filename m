Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE6AC433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 20:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECE364FC9
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 20:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhCJUkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 15:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhCJUk1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 15:40:27 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD4C061756
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 12:40:27 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id m7so389437iow.7
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 12:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DOt2uzG5UdlIpzOf4PwD5PjSE+FFilkpfVBNl0BIvD4=;
        b=0RuQSIfe6Bg9s6XzpiKi+YtnsV43XXno+xYwYNEUZssZwrNYQlpWCM06r1H1xuv2HT
         waaZfIV8fgWHqEQlL43DscRNc7N7hmUblElv9e0NbjC75lZWvCKxV7LF+szxRAPkFl+n
         /r/fkHiYBQKXjqhYG9bgt1NY+kH9WbGrBRibZkqmEEdcjX/QsvJbgjYUIVu7jYQhahve
         t9MLBSvaFsg2Cb7Bz9nE8vw7zMTGWrjvWJjP1jUpPETKME4A0n4u+78kfkrrLQOo/UA7
         KCwlnPmovdY/nr/4ZAINNbAjWS7+7eshSpc43/ttYmvldCWmYVYL9xj6Sj4U7pzZE4nb
         mfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DOt2uzG5UdlIpzOf4PwD5PjSE+FFilkpfVBNl0BIvD4=;
        b=syu5/QzneFW3mNLL/LIeNml3ZuImuvaRcYWOk3cTc2gWC+l6jE6Z+Neel49PUKMRtM
         ULdb5UXehnRWcstgwGhcrq/G6Zbg0BYFai20v5D/6sim8nn3nLXJeayE6h5ky1Lstw9L
         9+TEHudXFEy/t6POjyZSOKEsx6aIT3XH5HvJGRUTJ509VZ0uBWf5vbdL9rUnegpX9Yox
         jPZym/TbS6f3WSi3ffTE7CmlA+XKli9GWjlnn9V5d/XzCxLnAHc7lk5LzD5eIMEYWX0k
         cw2w8j0cbwUUP2l64FpB9sZeCztduBKq/Bd7yKGFpPjPHbEDx0m80JkOVUrLORWk1ECb
         q1RA==
X-Gm-Message-State: AOAM5304N1L+IT/MWsDsBZ9sOqXYpH9NKzyTfUiiSF3SNl8/2/b18lHw
        24s8sjBZsMkEk8xqFSyLz78SBw==
X-Google-Smtp-Source: ABdhPJzrL66CEnJ5j3MXWw7GIN3Wl2X0RziWK5/q8dk34mOYXqHpBRiilZ7AfwFSk5ErX/sGzwvz4Q==
X-Received: by 2002:a05:6638:3809:: with SMTP id i9mr343389jav.24.1615408826452;
        Wed, 10 Mar 2021 12:40:26 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k14sm203630ilv.41.2021.03.10.12.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 12:40:26 -0800 (PST)
Subject: Re: -Walign-mismatch in block/blk-mq.c
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
 <99cf90ea-81c0-e110-4815-dd1f7df36cb4@kernel.dk>
 <20210310203323.35w2q7tlnxe23ukg@Ryzen-9-3900X.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e43dba61-8c74-757d-862d-99d23559cf50@kernel.dk>
Date:   Wed, 10 Mar 2021 13:40:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310203323.35w2q7tlnxe23ukg@Ryzen-9-3900X.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/21 1:33 PM, Nathan Chancellor wrote:
> On Wed, Mar 10, 2021 at 01:21:52PM -0700, Jens Axboe wrote:
>> On 3/10/21 11:23 AM, Nathan Chancellor wrote:
>>> Hi Jens,
>>>
>>> There is a new clang warning added in the development branch,
>>> -Walign-mismatch, which shows an instance in block/blk-mq.c:
>>>
>>> block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to
>>> 32-byte aligned parameter 2 of 'smp_call_function_single_async' may
>>> result in an unaligned pointer access [-Walign-mismatch]
>>>                 smp_call_function_single_async(cpu, &rq->csd);
>>>                                                     ^
>>> 1 warning generated.
>>>
>>> There appears to be some history here as I can see that this member was
>>> purposefully unaligned in commit 4ccafe032005 ("block: unalign
>>> call_single_data in struct request"). However, I later see a change in
>>> commit 7c3fb70f0341 ("block: rearrange a few request fields for better
>>> cache layout") that seems somewhat related. Is it possible to get back
>>> the alignment by rearranging the structure again? This seems to be the
>>> only solution for the warning aside from just outright disabling it,
>>> which would be a shame since it seems like it could be useful for
>>> architectures that cannot handle unaligned accesses well, unless I am
>>> missing something obvious :)
>>
>> It should not be hard to ensure that alignment without re-introducing
>> the bloat. Is there some background on why 32-byte alignment is
>> required?
>>
> 
> This alignment requirement was introduced in commit 966a967116e6 ("smp:
> Avoid using two cache lines for struct call_single_data") and it looks
> like there was a thread between you and Peter Zijlstra that has some
> more information on this:
> https://lore.kernel.org/r/a9beb452-7344-9e2d-fc80-094d8f5a0394@kernel.dk/

Ah now I remember - so it's not that it _needs_ to be 32-byte aligned,
it's just a handy way to ensure that it doesn't straddle two cachelines.
In fact, there's no real alignment concern, outside of performance
reasons we don't want it touching two cachelines.

So... what exactly is your concern? Just silencing that warning? Because
there doesn't seem to be an issue with just having it wherever in struct
request.

-- 
Jens Axboe


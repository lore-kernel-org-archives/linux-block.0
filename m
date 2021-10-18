Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4756CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4F160F9D
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhJRXbM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 19:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhJRXbM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 19:31:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5630CC061745
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 16:29:00 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n7so18334566iod.0
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 16:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O94bgt1Sgda3wuf13sMsvUOaDM9c47WSdizpfOCKTbw=;
        b=5aJhP1SXcBI44MmvCXGYxEJ2AudPwV47iAFALFOD4UtHgx+L52mgAUVJ2/35rgKWzY
         zUxyDRfytERiUR8kaVIZBZ6jW4qDHDrrmTfa/VDUVVLPhEgq5bLvd5ImynQoWg6NvwzY
         COKGiQ9T2OroidnAvB2iha5jQUTEV+mVnWGmLQmtWhc7M7BNuqQ9OVgeumKd+HyYW0Y/
         pgMfSpPrvflzBtMt+5ZNa0QHLiLGHgMEW5I/vSIKxgyffaezKkeVupvUQ68BrbJHCb1B
         hGoJWUqlLhNxhUgvFHx2rOauLQ2wvs64t8QdhRqgy1HzhRHAwPq9y2zbnz49vcMFzGoT
         IYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O94bgt1Sgda3wuf13sMsvUOaDM9c47WSdizpfOCKTbw=;
        b=yAda2wVCGA3cTi3RZtB+QWgKJKLaDVFeke/TcxR25OMOp1q7m6cFVJEzQuxmk9nNr6
         HsdqN/ZCaOYs+8vlY9us7ajm1NkCgEsTOQ0Q0LeJBQN4bPL+wzPlqw44XXebCaEyPPHW
         F+LHbhjeZwsyYWY92KbT9h9gicPz4OTkyDcvjhUyPVVPZ/+7gYG4y4CmOJKhE1FqY8nW
         XHq1MSwxikhSLzG9IiF+gMyb7J52etWaC16rjuBKrpbmWrC2ZWrXSv/zS2Ik/zgNVEa+
         holLRlVh9HAN41nKIk3z8ADX4J9AngqmzTe3uTJgfUrrWz2pCS6mcsfBOGqMDz02Rhxl
         OVqg==
X-Gm-Message-State: AOAM531xVtbQ1rOtO3oW3bGb1PRqZVUSRUODShDKzRna5L7/r3IbP1jt
        tvfRX07XrIPXJCnWmm+WZZZ4fg==
X-Google-Smtp-Source: ABdhPJz1E1isHmYJBs6xKhDIWScY2qYqnWLlZS762JjfuRhiOygVNnoxfrUogRMzAav37Il0yrj1Bg==
X-Received: by 2002:a02:8643:: with SMTP id e61mr1774232jai.97.1634599739310;
        Mon, 18 Oct 2021 16:28:59 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t12sm7483163ilp.43.2021.10.18.16.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 16:28:58 -0700 (PDT)
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20211018222157.12238-1-schmitzmic@gmail.com>
 <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
 <97323ce2-4f5c-3af2-83ac-686edf672aea@linux-m68k.org>
 <7f64bd89-e0a5-8bc9-e504-add00dc63cf6@kernel.dk>
 <604778bc-816a-3f2e-d2ad-d39d7f7f230@linux-m68k.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <460a172c-6103-3839-eecc-a193d1cc208f@kernel.dk>
Date:   Mon, 18 Oct 2021 17:28:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <604778bc-816a-3f2e-d2ad-d39d7f7f230@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 5:17 PM, Finn Thain wrote:
> On Mon, 18 Oct 2021, Jens Axboe wrote:
> 
>>> It is much more difficult to report regressions than it is to use a 
>>> workaround (i.e. boot a known good kernel). And I have plenty of 
>>> sympathy for end-users who may assume that the people and corporations 
>>> who create the breakage will take responsibility for fixing it.
>>
>> We're talking about a floppy driver here, and one for ATARI no less. 
>> It's not much of a leap of faith to assume that
>>
>> a) those users are more savvy than the average computer user, as they
>>    have to compile their own kernels anyway.
>>
>> b) that there are essentially zero of them left. The number is clearly
>>    different from zero, but I doubt by much.
>>
> 
> Well, that assumption is as dangerous as any. The floppy interface is 
> still important even if most of the old mechanisms have been replaced.
> 
> http://hxc2001.free.fr/floppy_drive_emulator/
> https://amigastore.eu/en/220-sd-floppy-emulator-rev-c.html
> https://www.bigmessowires.com/floppy-emu/
> 
>> Hence it would stand to reason that if someone was indeed in the group 
>> of ATARI floppy users that they would know how to report a bug. 
> 
> Yes, it would if the premise was valid. But the premise is just a flawed 
> assumption.

Oh please, can we skip the empty words, this is tiresome and
unproductive. Since you apparently have a much better grasp on this than
I do, answer me this:

1) How many users of ataflop are there?

2) How big of a subset of that group are capable of figuring out where
   to send a bug report?

By your reasoning, any bug would go unreported for years, no matter how
big the user group is. That is patently false. It's most commonly a
combination of how hard it is to hit, and how many can potentially hit
it. Yes, some people will work around a bug, but others will not. Hence
a subset of people that hit it will report it. Decades of bug reports
have proven this to be true on my end.

Nobody has reported the ataflop issue in 3 years. Either these people
never upgrade (which may be true), or none of them are using ataflop.
It's as simple as that.

-- 
Jens Axboe


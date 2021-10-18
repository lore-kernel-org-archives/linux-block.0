Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3A0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C446108E
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhJRXmd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 19:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhJRXmc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 19:42:32 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C0C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 16:40:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e144so18314067iof.3
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 16:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/qge6pFYrqnOf+QMTc/80qCHlsCGaYE973MgzPFuciY=;
        b=hP48IRMxt+SSOLX1k4yjrvUWutPwe/M+8QBE0heC1yYKmgK51RnaWTb/YA0OiKQ6hb
         R2Iyk4VM3S8ZPnYnuNhuKto9h7XqN7u2eSWaPi8jK4xN1QowFCDva7EOIH7R3T0A3XxB
         icdXhlovVnpHkLqYwhF+xSM317Y3k47/aAO1+f+FYWT5rwUI5mr1F7WWwB4DwKQPRTqk
         NO531mOhUlE7sXWuZyMSEY44iNR2gNdtBWc9xvmz4aRQAuqQn7ZXc7su5PuXRwznxE1t
         ylz+RB5wJ8J9D+mxNB3FvfPkCCrCjEhoPtQKHTeWpioZXPjf3efdCoTDD4CRqKlwmnqS
         n8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/qge6pFYrqnOf+QMTc/80qCHlsCGaYE973MgzPFuciY=;
        b=uc9Zza7LvMSYIiwz09LVzjngx1t1COERuMNKTP+CvJpBHbKoRLCgjW4o2p9BeaPHlM
         ZOs0pG7RN5bqOg3yVYm8+HWcaAGe7d+DHzhBZYIWymFRYYNpa6FWHaBFMHxLSC+9ScSY
         sLgXsd2ydlaiv6w+31rZYsi4E+/5TSDVUIJvWzS/uIfNGFgRr32ZCfdI9MgTJiyA4w2l
         Lkr9dXHoowaaWkhKk0ijM/KJVh8jrbbmmyEB8LMwcxI5Grus2/HPRzJV6XFz0gBQ1mjy
         UdOC7josF11GK6wvCvBxtiVEjNfloXsrgJkIqE5/C1adkj8O89qFezwgIs/9x7q+owJ4
         ll0g==
X-Gm-Message-State: AOAM531pRKeElGwJ2pbW+infb09julnJM4C8nzKvRPpn5ofZHGxf0+MK
        THkNy5vOxuvpfXthP4ybcyDrJQ==
X-Google-Smtp-Source: ABdhPJz3dFh6viW98V1O7wDnU9a7+4u6vg6AyRlnvytaSXg61A6gXu26Xf0+GheNgAHsJZI7Re4MNg==
X-Received: by 2002:a5d:9051:: with SMTP id v17mr16526700ioq.134.1634600420645;
        Mon, 18 Oct 2021 16:40:20 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id p2sm2281271ios.47.2021.10.18.16.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 16:40:20 -0700 (PDT)
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20211018222157.12238-1-schmitzmic@gmail.com>
 <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
 <791e1173-4794-a547-2c84-112cc6627a1f@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <859908de-0ca0-0425-1220-a3192c1e9110@kernel.dk>
Date:   Mon, 18 Oct 2021 17:40:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <791e1173-4794-a547-2c84-112cc6627a1f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 5:35 PM, Michael Schmitz wrote:
> Hi Jens,
> 
> On 19/10/21 11:30, Jens Axboe wrote:
>> Was going to ask if this driver was used by anyone, since it's taken 3
> 
> Can't honestly say - I'm not following any other user forum than 
> linux-m68k (and that's not really a user forum either).
> 
>> years for the breakage to be spotted... In all fairness, it was pretty
>> horribly broken before the change too (like waiting in request_fn, under
>> a lock).
> 
> In all fairness, it was a pretty broken design, but it did at least 
> work. I concede that it was unmaintainable in its old form, and still 
> largely is, just surprised that I didn't see a call for testing on 
> linux-m68k, considering the committer realized it probably wouldn't work.

I don't remember the details on that front, it's usually very difficult
to get people to test this kind of change, unfortunately. But thanks for
tackling it now!

>> So I'm curious, are you actively using it, or was it just an exercise in
>> curiosity?
> 
> I've used it quite a bit in the past, but not for many years. For legacy 
> hardware, floppies are often the only way to get data on or off the 
> device, and I consider this driver an important fallback option should 
> my network adapter (which is a pretty horrible kludge to use an old ISA 
> NE2000 card on the ROM cartridge port) fail.
> 
> But then, any use of this legacy hardware is an exercise in curiosity 
> mostly.

OK, that's good enough then. Was mostly just curious if was actually
being used.

>>> Testing this change, I've only ever seen single sector requests with the
>>> 'last' flag set. If there is a way to send requests to the driver
>>> without that flag set, I'd appreciate a hint. As it now stands,
>>> the driver won't release the ST-DMA lock on requests that don't have
>>> this flag set, but won't accept further requests because the attempt
>>> to acquire the already-held lock once more will fail.
>>
>> 'last' is set if it's the last of a sequence of ->queue_rq() calls. If
>> you just do sync IO, then last is always set, as there is no sequence.
>> It's not hard to generate sequences, but on a floppy with basically no
>> queue depth the most you'd ever get is 2. You could try and set:
>>
>> /sys/block/<dev>/queue/max_sectors_kb
>>
>> to 4 for example, and then do something that generates a larger than 4k
>> write or read. Ideally that should give you more than 1.
> 
> Thanks, tried that - that does indeed cause multiple requests queued to 
> the driver (which rejects them promptly).
> 
> Now fails because ataflop_commit_rqs() unconditionally calls 
> finish_fdc() right after the first request started processing- and 
> promptly wipes it again.
> 
> What is the purpose of .commit_rqs? The PC legacy floppy driver doesn't 
> use it ...

You only need to care about bd->last if you have something in the driver
that can make it cheaper to commit more than one request. An example is
a driver that fills in requests, and then has an operation to ring the
submission doorbell to flush them out. The latter is what ->commit_rqs
is for.

For a floppy driver, just ignore bd->last and don't implement
commit_rqs, I don't think we're squeezing a lot of extra efficiency out
of it through that! Think many hundreds of thousands of IOPS or millions
of IOPS, not a handful of IOPS or less.

-- 
Jens Axboe


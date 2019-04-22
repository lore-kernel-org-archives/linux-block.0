Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E33C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 17:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864D42077C
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 17:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hgFuCbl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfDVREx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:04:53 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:34431 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVREw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 13:04:52 -0400
Received: by mail-io1-f46.google.com with SMTP id n11so10088151ioh.1
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=iM2eWTp5ienmg5dDT9BkO7mv55quK5TrPQzVTNDQzgI=;
        b=hgFuCbl/VbclBGvRUhGjm6Fy1QBNg5A9xu57XJYPi00PHH79R1COV/kA2PpqZh1r9h
         mZVqGegINYhuMwqPw/Xu/avgmvMastRHL13A2vNOCrWR1N0PgtLMtFAVMmMVAMGNyYr5
         RB72QFnompaB4Zta4oz3jYVajIekTJ7SVNZN+huH40pJCaBIUX7dja7HxvJUM0lZHjUS
         y6Tn3J9l291qBuHaxgacpyd82IIkJ3wNec3PcBqzj2ZJqO+jdPj/OeVXUepaonn08uDQ
         Fig46/+ejBOgO7nf/OQec8IRpPgeIDje3tuM409xt4mVPTMrLtTyIMIm8xu4nJ8vYCoe
         HnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iM2eWTp5ienmg5dDT9BkO7mv55quK5TrPQzVTNDQzgI=;
        b=B73gDVDYKCHNBd2KBvql9qY+VGm8diFLOmrvnyB7kyuH5gMx56C2l1a2wDFZYuGHn/
         tBX9Okbz8AU1ugHzlOI+RMoNySTAewfXwVgf8SVfy7COuS/EMtt3exu4HjnU0X/sLl86
         2d1B7Q9nCN7KfqASU3ml1x1erSnzFT1P1RlYudBZLuMLvBdhTzWqI2kjm2//QjUcENZr
         77yTNqbPqcr6UDPTz+KgF/mlneSTjwf1w79kHIrmwwGUn0Kuo/lBs0rxTQ6x/j06Id4a
         lVKh1Q6NyiVyudruwqr+Qsrh8rAATbr7uyWRhJeKQgaEZ16dlDthhE8h3cFDotBIw2Px
         TuHQ==
X-Gm-Message-State: APjAAAWJuV24U4KadvIFQuU2QG6xtNBT/8MsXRV0fbF76VG9u4/7r4/6
        stEqExzMKymIELB4qxdkA511kDf2riwFIQ==
X-Google-Smtp-Source: APXvYqwyJy+Au/RLutuOpucQH6rCVGhqSxGtd0u75IaEuVj92VKEhuF4f8O19TECXBoQdntUf0H5PQ==
X-Received: by 2002:a6b:6c1a:: with SMTP id a26mr12616042ioh.135.1555952692044;
        Mon, 22 Apr 2019 10:04:52 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o143sm6438017ito.18.2019.04.22.10.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 10:04:50 -0700 (PDT)
Subject: Re: io_uring memory ordering (and broken queue-is-full checks)
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <608965d0-84e0-4d96-8835-afab2b6f2a1a@stbuehler.de>
 <03cdf146-12a7-95de-eb78-31cd7df4bb44@kernel.dk>
 <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <91366210-d56c-acfe-589e-8765cb8475f7@kernel.dk>
Date:   Mon, 22 Apr 2019 11:04:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 3:29 AM, Stefan Bühler wrote:
> Hi,
> 
> On 17.04.19 17:02, Jens Axboe wrote:
>> [...]
>>
>> Care to turn the pseudo code into a real patch? Would be easier to
>> digest. But thanks for taking a look at this!
> 
> Fair enough; I'm working on it.
> 
> I'll start with the actual bugs, and will try to cleanup unneeded
> barriers/docs later.

That sounds great, thanks. The three patches look good to me, I've
queued them up.

>>> The "userspace" liburing looks even worse.  For starters,
>>> `io_uring_get_completion` cannot safely return a pointer to the CQ entry
>>> *AND* increment head: you need to actually read the entry before
>>> incrementing head.
>>
>> That's a good point, we should actually have this split in two to avoid
>> the case where the kernel will then fill in a new entry for us.
> 
> I see you already did so in the liburing repo.

Yep

> When going through liburing code again, I noticed io_uring_submit
> assumes there might be pending submission entries in the SQ queue.
> 
> But those entries are not "reserved" in the SQE queue; so
> io_uring_get_sqe might overwrite SQE data that isn't read by the kernel
> through SQ yet.
> 
> Is there any motivation behind the indirection?  I see two possible ideas:
> - allocate fixed SQE entries for operations, and just add them to SQ
>   when needed
> - have multiple threads fill SQE in parallel, and only add them to SQ
>   when done
> 
> Are those actually worth the cost?
> 
> liburing doesn't look like it is going to take advantage of it, and the
> library I'm writing in Rust right now isn't going to either (actually
> even using a fixed sq_ndx == sqe_ndx mapping, i.e. it'll only write
> sq->array on startup).
> 
> At least consider documenting the motivation :)

I'll take a look at this case and see if the complexity is warranted,
or at least make sure that it's exposed in a safe fashion.

>>> Last but not least the kernel side has two lines it checks whether a
>>> queue is full or not and uses `tail + 1 == head`: this is only true if
>>> there were U32_MAX entries in the queue.  You should check `(tail -
>>> head) == SIZE` instead.
>>
>> Good catch, this is a leftover from when the rings were indeed capped by
>> the mask of the entries. I've fixed this one and pushed it out, and
>> added a liburing test case for it as well.
> 
> I think you missed the second one in io_uring_poll (looking at your
> for-linus branch), so I will send a patch for that too.

I did indeed, my grep failed me. Thanks for catching that!

-- 
Jens Axboe


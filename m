Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C32CC433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 22:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2122E20855
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 22:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="euZw+zWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHUWJ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgHUWJ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 18:09:26 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD7C061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 15:09:26 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e11so2647970ils.10
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 15:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3JTlKfwYZO54zOTBt8Cq1/9FUYP4Dv7ytu+UorBz3V4=;
        b=euZw+zWT98+XunedhITkdLE16s+iV35OQOXS9tLU3BriTqpFhk0K7loBGSs3F5noka
         ynLJfFAxgnmRouTlT7hFqGTPDi0UBEbbnjZW5B+8pdYV9vEL7ZrurlZF1JaYeT3Kz+69
         uDSUdaVZ8GPaZmPh94dEv80BFp+453LEv5iyVLeFOkhOeK69ljKCcX1cAAiOie7LeB0J
         t47MDdQ1xhRvFC7aaeKKiY/vBeJPau5Ig43yaMi3Qxbk/vPmeKUe+Ndv+v9e8Jt/XAtJ
         6IjLCfwuNtIdSc+bpfNXczvVgMhhFuT6rqu+ttaDZmOjKFemwsHuOSYEE2Mb2iLOwHlx
         cXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3JTlKfwYZO54zOTBt8Cq1/9FUYP4Dv7ytu+UorBz3V4=;
        b=je2OqgMpa+5rVOFaYoubh3+dpDeM3j3KuqYWV0hEjddqg0hUQDTWBRj+6/nne+36Z0
         v/RqAMqi5jzTMgIIYRhsn61V0N29CBfKVGrzsJq83pNT9tRPysK1QjdAf9yhUs320WeR
         5PrNu0n+A7hqUTRUnsQgODK5kG+t6pEYpXKiOi0PrWZ26yeugDD7ZCZlLzC9p8wi3zoa
         7tKixi9hPHSRVCSoAa1KNfJEsu2tTPRQI2QeuBbxKdkV3l2rc+Wyo8M/O9+tRBKSAIUA
         c63gqdvlL7dsdyOY+qBJhoxtt9Fcb7UKGQY66QgFPYQmRYVW1y1x4c0cbT54uaJC6ihj
         VYRg==
X-Gm-Message-State: AOAM532e7W9Nh+Ej1NIRbJlIvWs76yx9s7/lIccnyBIqL55bs5dhivaG
        gavNzPqI32lFOEUfXNrXyk3GH9jTS+BYgp9k
X-Google-Smtp-Source: ABdhPJxgXzHJ19Al7meQdrTHP2xvTvVio8iSeQSkV5LZcpDIF5Uff29UjkdJ8S3YTWmUAktYNnokLA==
X-Received: by 2002:a92:89cf:: with SMTP id w76mr3816772ilk.215.1598047765602;
        Fri, 21 Aug 2020 15:09:25 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 3sm2074991ily.31.2020.08.21.15.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 15:09:25 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.9-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <2e213354-a1f8-cdb6-0f3c-24473a2a2ef8@kernel.dk>
 <CAHk-=wiFwUUEpCQ2FDWxBFb3XSxu=+yODHGfLPncvTQa9BeP9w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22fc2c2f-1ab9-6c57-df94-4768a64644e9@kernel.dk>
Date:   Fri, 21 Aug 2020 16:09:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiFwUUEpCQ2FDWxBFb3XSxu=+yODHGfLPncvTQa9BeP9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/20 3:58 PM, Linus Torvalds wrote:
> On Fri, Aug 21, 2020 at 1:51 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>> Some general fixes, and a bit of late stragglers that missed -rc1 and
>> really should have been there. Nothing major, though. I
> 
> Pulled, test-built, and unpulled.
> 
> This crap doesn't even compile cleanly.
> 
> It is printing out an 'int' using '%ld', so nobody could possibly have
> compile-tested this.

I had to look for that, because it obviously didn't complain for me.
Looks like it's the one in drivers/block/rnbd/rnbd-srv.c which changes
from PTR_ERR() to using 'err' which is indeed an int.

> And as I've said elsewhere - compile-testing doesn't mean "show it to
> a compiler".
> 
> It means "look at what the compiler says" too. Otherwise it's not
> compile-testing, it's just throwing it away.
> 
> So send me a properly tested and *MINIMAL* pull request. because I
> will not take this crap, and I will not take anythign that *looks*&
> like this crap.
> 
> Real fixes, and fixes ONLY.

I think you're overreacting here. I *always* test these pulls, it's run
through the test box with the tests there, and it's always running on my
laptop a day or two in advance. Typing it right now from that branch.
Stop making it sound like it's not being tested at all, according to the
above it obviously never saw a compiler which is just blatantly untrue.

I obviously missed a *warning* because I don't have any way to test that
part and it's not part of my config. Hardly seems like a shootable
offense. I have to defer to the maintainer there, which did ack this
patch.

This is all fixes and innocous changes otherwise. My suggestion here
would be:

1) You pull it, change that rnbd mistake at merge time.
2) I queue a patch on top with that single change.

Let me know what you prefer, and can we please tone down the aggression
here?

-- 
Jens Axboe


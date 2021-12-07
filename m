Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF4C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 16:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhLGQNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhLGQNv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Dec 2021 11:13:51 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B76C061574
        for <linux-block@vger.kernel.org>; Tue,  7 Dec 2021 08:10:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y12so58715938eda.12
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otbD5hBznqHR7VBYTusWIJyDWHMzOVHHmZJEdWTlm4Y=;
        b=Ebu9BclZTHW88tpIhWIGM5uFABs9quYXdDpMUVbFLA2B9mUrRisrp2I7WcNJhXPz4J
         ywK+c87S2hSWryMlZT1pXkiK/Y1MKegM3tbaeeFp68oQjt5B4MMnwp33BpauarvpIoy+
         CtLb6n2yUXHbIDOh9Z4WFRmDM9u/vp7T5yP2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otbD5hBznqHR7VBYTusWIJyDWHMzOVHHmZJEdWTlm4Y=;
        b=ZPmHNO9FIN99aZFeMsU77NIwKo6AWdH7xXq3gfdqBUKju7hNPadPo3WKkb+2mFZhWI
         QGIZnJmN4JC5M+EOuhcKJL/LU7qm2GQellplwmbnts/4y9sRF2KHT1VFss4zDGfr/LBq
         zliJ14hN2IjvtcTyxLlrU/6LZ4R/9U0MJQtGB6svCqcw+h5QgL0L5t+uGQiny7is60/y
         Em0908n7vC1/2Ts6U8HAAKpBzB8xuGlPB/sAEVbBJA/Dx/br1kjyDSOB1w640jtoubm4
         NffwieNOw0Hx4QT/Gonkr8p3vRhg5sjBjCPxwhq0TYKDpNATrG+GRWBQ/u9lNCb6RC1I
         xDjw==
X-Gm-Message-State: AOAM530ABCJ69VoEASbRFxSYVsKgGu2oj/uF7hZqxbfvL3bPLwsRMOjk
        q7JObcLMjnh6OoMz5EJPdwai8hP64d8PCR7q
X-Google-Smtp-Source: ABdhPJyPMzgQp1UACeYxUryMXrjMAU6w1lOJJTI2TilRdFASXogidMZY+h3uXEtoFG5dps2PiV+7Ow==
X-Received: by 2002:a05:6402:2686:: with SMTP id w6mr10471904edd.141.1638893418846;
        Tue, 07 Dec 2021 08:10:18 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id r3sm8871039ejr.79.2021.12.07.08.10.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:10:18 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id p18so11158860wmq.5
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 08:10:18 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr8189198wmq.26.1638893418059;
 Tue, 07 Dec 2021 08:10:18 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk> <202112061247.C5CD07E3C@keescook>
 <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
 <202112061455.F23512C3CB@keescook> <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
 <Ya83zQRVUCRRYNHQ@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya83zQRVUCRRYNHQ@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 08:10:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWJv6xNPQMk+FFumWix+_O1gfwTiCx6tpmcQ4cY=_F=A@mail.gmail.com>
Message-ID: <CAHk-=whWJv6xNPQMk+FFumWix+_O1gfwTiCx6tpmcQ4cY=_F=A@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 7, 2021 at 2:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 06, 2021 at 04:13:00PM -0800, Linus Torvalds wrote:
>
> > IOW, I think that "try_get_page()" function is basically the *much*
> > superior version of what is currently a broken "refcount_inc()".
>
> That places the burden of the unlikely overflow case on the user. Now
> every driver author needs to consider the overflow case and have a
> corresponding error path. How many bugs will that introduce?

Did you even *look* at the patch that started this discussion?

The patch replaced refcount_t, made for no more complex code.

> Why is saturation; iow. leaking the memory, a worse option than having
> bad/broken/never-tested error paths all over the kernel?

.. which is why I'm fine with refcount_t - for driver reference counts
etc sysfs behavior etc.

What I am *NOT* fine with is somebody then piping up claimign that
refcount_t is "better" than doing it properly by hand, and complaining
about patches that replace it with something else.

See the difference here?

'refcount_t' is fundamentally broken, cannot handle overflows
properly, and is *designed* to do that. You even seem to make excuses
for that very design.

And that "lazy mans overflow protection" is fine if we're talking
random code, and are talking maintainers who doesn't want to deal with
it.

But that is also why I do not EVER want to hear "no, don't convert
away from refcount_t".

Can you really not understand my dislike of a data type that is
fundamentally a lazy shortcut and intentionally hides error cases with
leaks?

Doing it properly is always the better option, and "refcount_t" really
*fundamentally* can never do it properly. It doesn't have the proper
interfaces, and it doesn't return enough information to recover.

I'm not arguing that we have to replace every refcount_t user.

But I *am* arguing that if somebody wants to replace their refcount_t
with something better - whatever the reason - they had better not hear
the mindless whining about it.

                Linus

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E95EC433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 21:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350893AbhLFVVJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 16:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351096AbhLFVVG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 16:21:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CF5C0613F8
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 13:17:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v1so48484844edx.2
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 13:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JO2IWhnphPSYCFUexakELVjEvf2J2IXcJ5uKztle0+I=;
        b=W7xIySANjVFarMf5vuIrBmPHB2Azy+jRK+7H+vkSa6q5fkxiWR98ODDWY7IlBrlK2C
         UJAWT+skk9pyUI6iJu0ednt8cVK2C7n3TwtqlFIxZ64sSjQtPdTlc42vVh1gTeF1eD5H
         5hH1w4uRtrEdC8GEK6+zNcoVDSlKXCSTPcZTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JO2IWhnphPSYCFUexakELVjEvf2J2IXcJ5uKztle0+I=;
        b=4+OcMflvN2DM7QrSxHQwSWmMbMZ8QUQqGAEYJ9/lggnImA2ANqIqSrotmIHnvgZaUt
         CLf5lDqMgQsx5ef/xdeZ8pes1Ia4fwnbOHfhzYZzHrWY+BXkEVVZvr3MTcuoSZdX3IJE
         Ybq83T6yyb0COeLjBvbElh7q5DmSTua9O5Fx98uWzbXZMOplqTiT4wFesd3RkosSBbXz
         e/mAqM4w3G5l86OJEx3GPLKYm5huiFniWu1DD6z1mmiIzdHjjJ++nNcSZ9NF+9gnuOYX
         POSxw/yWjp0p+yVmEn3NFA9qka8F7umRbsORpyzO6B+HvCuTAzuEcnlNPRXrLSye9wGC
         5Kiw==
X-Gm-Message-State: AOAM530uqx+k9upJgRtU0Eue27V0QilaR2ct5hiu1DQGLmCGdJJzc6Ke
        uJ0N//mCILHsz5YaN6m/aeBFg14qvnSTLp4G
X-Google-Smtp-Source: ABdhPJz1z116/zLrHOEgQlm/RR4foMeQRl0rvdqWlAzEPV5zIAQrigUgHQHkzcVeZkUEL6tPXwC47w==
X-Received: by 2002:a05:6402:35d2:: with SMTP id z18mr2418548edc.188.1638825454883;
        Mon, 06 Dec 2021 13:17:34 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id jz4sm7223557ejc.19.2021.12.06.13.17.34
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 13:17:34 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so541635wmi.1
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 13:17:34 -0800 (PST)
X-Received: by 2002:a1c:800e:: with SMTP id b14mr1338191wmd.155.1638825454105;
 Mon, 06 Dec 2021 13:17:34 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk> <202112061247.C5CD07E3C@keescook>
In-Reply-To: <202112061247.C5CD07E3C@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Dec 2021 13:17:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
Message-ID: <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 6, 2021 at 12:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> I'd like core code to be safe too, though. :)

I've told you before, and I'll tell you again: 'refcount_t' is not "safe".

refcount_t is pure garbage, and is HORRID.

The saturating arithmetic is a fundamental and fatal flaw. It is pure
and utter crap.

It means that you *cannot* recover from mistakes, and the refcount
code is broken.

Stop calling it "safe" or arguing that it protects against anything at all.

It is literally and objectively WORSE than what the page counting code
does using atomics.

I don't know why you cannot seem to admit to that. refcount_t is
misdesigned in a very fundamental way.

It generates horrible code, but it also generates actively BROKEN
code. Saturation is not the answer. Saturation is the question, and
the answer is "No".

And no, anybody who thinks that saturation is "safe" is just lying to
themselves and others.

The most realistic main worry for refcounting tends to be underflow,
and the whole recount underflow situation is no better than an atomic
with a warning.

Because by the time the underflow is detected, it's already too late -
the "decrement to zero" was what resulted in the data being free'd -
so the whole "decrement past zero" is when things have already gone
south earlier, and all you can do is warn.

End result: atomics with warnings are no worse in the underflow case.

And the overflow case where the saturation is 'safe", has been
literally mis-designed to not be recoverable, so refcount_t is
literally broken.

End result: atomics are _better_ in the overflow case, and it's why
the page counters could not use the garbage that is refcount_t, and
instead did it properly.

See? In absolutely neither case is recount_t "safer". It's only worse.

I like Jens' patches. They take the _good_ code - the code we use for
page counters - and make that proper interface available to others.

Not the broken refcount_t code that is unfixable, and only good for
"we have a thousand drivers, let them wallow in this thing because we
can never make them all handle overflows properly".

And every single core use of refcount_t that doesn't have a million
random drivers using it should be converted to use that proper atomic
interface.

                    Linus

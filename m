Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8484AC433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 00:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351463AbhLGAQu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 19:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350331AbhLGAQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 19:16:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216E0C061746
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 16:13:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r25so49671472edq.7
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 16:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZ4NTQl4vqWUi0q6qLDZFhtehtmC6acMk0BEOAwbblk=;
        b=THF2y8xIsbgj5uAmVksnApdBv0DkrP52LvcVJCs49feiZbKcjSFTUV7i34T5SFjKsj
         W8X6BM/2tJM6v4IENQbUJNn/c2/8x0+v2Jf86RR/4zzOaqoziLA6pCEdcJ7HNAmPe5kL
         a2MqXb/XXou6gEQllsBvCq+OuNsrCaOkkLk+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZ4NTQl4vqWUi0q6qLDZFhtehtmC6acMk0BEOAwbblk=;
        b=eq56W0OyfRwlr3UQvGFZQopLcmt2fV4+0xrNUfRs1J+d4WMTMPLbfVN+TZ/xTbCsc4
         xg07GVAt9Hop7BLcL7u6qY8iKgT2sAwQG1ZGOz2YvrUc9g/i4rOYEerwPHJq+g4C/F/p
         XXAyI3bPDy2sfRKNbaWGgjJF12cTSS1SVds30WFgbo20A425l9Xx40VfDHpij8tnA0BU
         omkbXClqHnIL4y4ENnpEkVYJUEuChQtNlGYeKhKRCKDYrH7yed4wsG3Z1r23+/FRrdyj
         FazGBmsLQuGVqPvkDp43i0MEFr6CiFdmGSccXV7nFxnuC2TDenONQ99HtVag3rGTguje
         kDjQ==
X-Gm-Message-State: AOAM5337zpLZgNu+NUEZ56Gmfueqqv9S9aoe+ly5ZiMyNQ96Cpj3e4eS
        V9y3K9OIgQpxA6ed+znnrpcHkMH+K5u3X7h4
X-Google-Smtp-Source: ABdhPJwCv+cErPbwf0P9t57EUaGHrhwW15spKkVNIrmBHH7Jpb/OEz0q/gFXZySzHD3ITRON/JakjA==
X-Received: by 2002:a17:907:7f8c:: with SMTP id qk12mr48848383ejc.169.1638835998267;
        Mon, 06 Dec 2021 16:13:18 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id ho30sm7734067ejc.30.2021.12.06.16.13.16
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 16:13:17 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so704649wmi.1
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 16:13:16 -0800 (PST)
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr2274622wmg.152.1638835996701;
 Mon, 06 Dec 2021 16:13:16 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk> <202112061247.C5CD07E3C@keescook>
 <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com> <202112061455.F23512C3CB@keescook>
In-Reply-To: <202112061455.F23512C3CB@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Dec 2021 16:13:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
Message-ID: <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
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

On Mon, Dec 6, 2021 at 3:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> I'm not arguing for refcount_t -- I'm arguing for an API that isn't a
> regression of features that have been protecting the kernel from bugs.

Maybe somebody could actually just fix refcount_t instead. Somebody
who cares about that currently horrendously bad interface.

Fix it to not do the fundamentally broken saturation that actively
destroys state: fix it to have a safe "try to increment", instead of
an unsafe "increment and do bad things".

Fix it to not unnecessarily use expensive compare-and-exchange loops,
when you can safely just race a bit, safe in the knowledge that you're
not going to race 2**31 times.

IOW, I think that "try_get_page()" function is basically the *much*
superior version of what is currently a broken "refcount_inc()".

And yes, it does warn about that overflow case that you claim only
refcount_t does. And does so without the broken semantics that
refcount h as.

                Linus

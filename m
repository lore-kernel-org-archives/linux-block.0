Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F2C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 23:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbhLGX0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 18:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbhLGX0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Dec 2021 18:26:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CD1C061574
        for <linux-block@vger.kernel.org>; Tue,  7 Dec 2021 15:23:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v1so2172554edx.2
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 15:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFqKn/JH+GK+DPO0IYtLG54mM/YPzkAV7Qb7f0SlT3Q=;
        b=OlRpfi8Z2djbQ1ovqBbkrOfDN/aezMU9Fd5Y7kDd//OahmypBQLJ1F/mW/C7X0LDIJ
         LwSOIk/qo/V+IhZF2uHzna5UXytN0bYl3/kXllmYdNjdi3+/+Nhm9ddysoQ/qwby0mjh
         ZsCJMXooRGgSw4lYlE0AjfXqnyjwQyXsf+KEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFqKn/JH+GK+DPO0IYtLG54mM/YPzkAV7Qb7f0SlT3Q=;
        b=hU1Y+glcQ5/1XoDifvMW71R1DNccdRcmY7cCeCw/uoaRvf/C3/FtvwmNBqpkbpFGL2
         g3Ne0GDpKHBebo1V/PBAqtDqSz4+dnCkKKBrjKyyniA7jxPtbqoblaLRiCSIR/O3S6yK
         5JVyXjwwdq6Rhry7vA2wA20MlcwBY/2iPGQOUSw379BrsPNwi8lQAcpC5kvVOJsQp7so
         i4pQ9+V4n/lub0LwUuq/VPYgtOT+Hipj3V3G061VfTcTpDy6xnVITUG1w7wLI6ynByYN
         5Tat4U0X7ngWc1rYeTwTMyXruXoOguYi0BJRHEnMCrxMR/keeAm+gYedn869u8ysYNuP
         xreQ==
X-Gm-Message-State: AOAM530FQN8wp38eXVbLQe4nNi1JhpauVcS+41BWqxjYKjxTjCypn5pm
        hZ6QgCTKAdQMFLQWlM/fN1Q8lkdRkihTtyAtNLQ=
X-Google-Smtp-Source: ABdhPJyvisXex4Ge5gRpcP12zXt8mJ5IWxv0svgTWzhzh/h7FLCnbxvgdj1eFJcjwr5HhjU5yjaWmA==
X-Received: by 2002:a05:6402:3549:: with SMTP id f9mr14296487edd.23.1638919400005;
        Tue, 07 Dec 2021 15:23:20 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id z25sm476910ejd.80.2021.12.07.15.23.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 15:23:19 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id o29so552651wms.2
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 15:23:18 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr11077730wmq.8.1638919398284;
 Tue, 07 Dec 2021 15:23:18 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net> <20211207202831.GA18361@worktop.programming.kicks-ass.net>
In-Reply-To: <20211207202831.GA18361@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 15:23:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com>
Message-ID: <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 7, 2021 at 12:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Argh.. __atomic_add_fetch() != __atomic_fetch_add(); much confusion for
> GCC having both. With the right primitive it becomes:
>
>         movl    $1, %eax
>         lock xaddl      %eax, (%rdi)
>         testl   %eax, %eax
>         je      .L5
>         js      .L6
>
> Which makes a whole lot more sense.

Note that the above misses the case where the old value was MAX_INT
and the result now became negative.

That isn't a _problem_, of course. I think it's fine. But if you cared
about it, you'd have to do something like

>         movl    $1, %eax
>         lock xaddl      %eax, (%rdi)
>         jl      .L6
>         testl   %eax, %eax
>         je      .L5

instead (I might have gotten that "jl" wrong, needs more testing.

But if you don't care about the MAX_INT overflow and make the overflow
boundary be the next increment, then just make it be one error case:

>         movl    $1, %eax
>         lock xaddl      %eax, (%rdi)
>         testl   %eax, %eax
>         jle      .L5

and then (if you absolutely have to distinguish them) you can test eax
again in the slow path.

                     Linus

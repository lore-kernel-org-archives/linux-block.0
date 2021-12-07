Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EABC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 16:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhLGQHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhLGQHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Dec 2021 11:07:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1DC061746
        for <linux-block@vger.kernel.org>; Tue,  7 Dec 2021 08:03:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v1so58905359edx.2
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6REykS5njvBGMivZTFNSyYs1+FcgFY2B6TDMRdG6y74=;
        b=P8XfxkWGrdPjDAtXf3kITM9nkzXBmtALtIE7T2YGWhJwKi3Q2RahEAxEoFEJKhCNGS
         Xb5H4EeiW+1PIUN7y/0cl+qNbKvgYcxpBYwZYarEfgRK7oYQ9V8qbqmMyfjA8lllP8sp
         VdSZ1aJDQrDeda1Su4wXbATTKE686P895iUeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6REykS5njvBGMivZTFNSyYs1+FcgFY2B6TDMRdG6y74=;
        b=FRrk5V1iVzx3xopgMhe+STOuNKRLfULE67epUBL17KpPEwln5mWOlNnzEFHyXp38ow
         qhnvpEjU1V6HRCNrgYYy3WNBWnR9Sgs7KPaJkBCsRe3N77g5hAj+NMdyA8+RLAw7p7SE
         RUlbiQ42DATuHVj4EdF8a0YlK+42GUxIa9N9ZMxFspbryDohmxkui82OkZNf+kNeRaYg
         PXLsZzjvFfO3yXE79u6+txeSxyBvzLz5mnQMVsTdNl09h29qy8FPCH9/ZqubY8vVPxoV
         qbgvCG9Qj8ckbsD1HaMUETmBVjD4B7KYkWtQe6wBMbdBu3hrR+R6khZknDzb0P/RqSZl
         QPSg==
X-Gm-Message-State: AOAM530S0UNEBujZsXMH1Gz5f6akpJnePKASAmLrQaGskrRsGkVao77i
        E2pmoBdhi4d+MCKot+q7ET/pY63rmHgDfSJW
X-Google-Smtp-Source: ABdhPJzJhsIBgBN+rta9yi+rXr/RiRfb0+WKjxEtkTItussJHlbyVHwJ4rMzZODT1Z/v4LvOWAnbuA==
X-Received: by 2002:a17:907:a414:: with SMTP id sg20mr293320ejc.183.1638893017057;
        Tue, 07 Dec 2021 08:03:37 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id sb8sm9114984ejc.51.2021.12.07.08.03.36
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:03:36 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id a18so30535769wrn.6
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 08:03:36 -0800 (PST)
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr50447953wrx.378.1638893016148;
 Tue, 07 Dec 2021 08:03:36 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk> <202112061247.C5CD07E3C@keescook>
 <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
 <202112061455.F23512C3CB@keescook> <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
 <Ya8qptlJ4yLVUSBi@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya8qptlJ4yLVUSBi@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 08:03:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6NyZeMEfw8YDyqCeoev7X319DDF41p0YSJFVNEkVQfw@mail.gmail.com>
Message-ID: <CAHk-=wh6NyZeMEfw8YDyqCeoev7X319DDF41p0YSJFVNEkVQfw@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 1:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Now, it could be GCC generates atrociously bad code simply because it
> doesn't know it can use the flags from the XADD in which case we can
> look at doing an arch asm implementation.

That may help.

This thread started because of alleged performance problems with
refcount_t.  No numbers, and maybe it was wrong, but they have been
seen before, so I wouldn't dismiss the issue.

What I've seen personally is the horrendous "multiple different calls
to overflow functions with different arguments", which makes
__refcount_add() do stupid things and blow up the code. All for
entirely pointless debugging code.

                  Linus

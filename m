Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A116C433EF
	for <linux-block@archiver.kernel.org>; Wed,  8 Dec 2021 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbhLHSEB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Dec 2021 13:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhLHSEA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Dec 2021 13:04:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2C7C0617A2
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 10:00:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so11302829edd.0
        for <linux-block@vger.kernel.org>; Wed, 08 Dec 2021 10:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQVnw3DRw1idYMIt2bxr1QkRxBmjweu7by1DubDefj4=;
        b=dZpjfmfNnw8abmpZM3rtZdvQjU3mzKHx4IgP71E0dyTTShnbX9ekmKS7DY+mIPF2Dy
         at3NZ9rdlw+xlQRzLQYy7m7PlEsxlg9J6Xh8Uqe02eNoeF/+/Io5xjs7aLSs5n3lh4HH
         Uj2cd+XJxcVaIeMi6kD0KwPsDFWlELGVBDNYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQVnw3DRw1idYMIt2bxr1QkRxBmjweu7by1DubDefj4=;
        b=5a80uedfNgYeaJFLs1Kgdx9s3Geg8IZUIlWQtUvukvaimBpb5dPkVAqZaRFLZJehbQ
         Hbfo4pjjtCdO/4w1viOtGUVvsRAk5UfQiS/3aw2h3leZlfXRqLH1C4MzeGiLa7H+XWM3
         75+HYMB2BnWkocJb8sY5wc0yI88xDghtIpLk16Q/iyZSLfUeOLaVkh1fTk7tToCB6+2/
         H4URfy3L0nv3BPYKSrvpgzTP3sgIbm4Cgqmg34/4U2zuhpghuLU81TwApZ/n8aa/4j/X
         zI2XXS6ozsdVisIfj6n11Wf+ozwXdXMJRSkUwIkH1Whx9IojES121ssdcJ0cVhJu5/LG
         he/w==
X-Gm-Message-State: AOAM53037QXuuzpzMZ9kvLAR0WSLP0wuR2pMAFLBL62HI5Q59L/LE08Q
        2d2YnQBB7aI2vw9EBLnzdbRq4856GMtKPsqP+fM=
X-Google-Smtp-Source: ABdhPJyCtFjENviGRt97DXcyP9X+teFt3yOmpLTg/h/xt+/nitUEhEFOXowVOpxuAmN/1ScaX9T07Q==
X-Received: by 2002:a05:6402:1911:: with SMTP id e17mr21092074edz.43.1638986422943;
        Wed, 08 Dec 2021 10:00:22 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id aq14sm1871235ejc.23.2021.12.08.10.00.21
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:00:22 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id t9so5483111wrx.7
        for <linux-block@vger.kernel.org>; Wed, 08 Dec 2021 10:00:21 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr272155wrn.318.1638986421450;
 Wed, 08 Dec 2021 10:00:21 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net> <20211207202831.GA18361@worktop.programming.kicks-ass.net>
 <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com> <YbDmWFM5Kh1J2YqS@hirez.programming.kicks-ass.net>
In-Reply-To: <YbDmWFM5Kh1J2YqS@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Dec 2021 10:00:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiFLbv2M9gRkh6_Zkwiza17QP0gJLAL7AgDqDArGBGpSQ@mail.gmail.com>
Message-ID: <CAHk-=wiFLbv2M9gRkh6_Zkwiza17QP0gJLAL7AgDqDArGBGpSQ@mail.gmail.com>
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

On Wed, Dec 8, 2021 at 9:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> IOW, the effective range becomes: [1..INT_MIN], which is a bit
> counter-intuitive, but then so is most of this stuff.

I'd suggest not codifying it too strictly, because the exact range at
the upper end might depend on what is convenient for an architecture
to do.

For x86, 'xadd' has odd semantics in that the flags register is about
the *new* state, but the returned value is about the *old* state.

That means that on x86, some things are cheaper to test based on the
pre-inc/dec values, and other things are cheaper to test based on the
post-inc/dec ones.

It's also why for "page->_mapcount" we have the "free" value being -1,
not 0, and the refcount is "off by one". It makes the special cases of
"increment from zero" and "decrement to zero" be very easy and
straightforward to test for.

That might be an option for an "atomic_ref" type - with our existing
"page_mapcount()" code being the thing we'd convert first, and make be
the example for it.

I think it should also make the error cases be very easy to check for
without extra tests. If you make "decrement from zero" be the "ok, now
it's free", then that shows in the carry flag. But otherwise, if SF or
OF is set, it's an error.  That means we can use the regular atomics
and flags (although not "dec" and "inc", since we'd care about CF).

So on x86, I think "atomic_dec_ref()" could be

        lock subl $1,ptr
        jc now_its_free
        jl this_is_an_error

if we end up having that "off by one" model.

And importantly, "atomic_inc_ref()" would be just

        lock incl ptr
        jle this_is_an_error

and this avoids us having to have the value in a register and test it
separately.

So your suggestion is _close_, but note how you can't do the "inc_ofl"
without that "off-by-one" model.

And again - I might have gotten the exact flag test instructions
wrong. That's what you get for not actually doing serious assembly
language for a couple of decades.

            Linus

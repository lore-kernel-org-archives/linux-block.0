Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C293C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 16:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhLGQR3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239546AbhLGQR3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Dec 2021 11:17:29 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF86C061574
        for <linux-block@vger.kernel.org>; Tue,  7 Dec 2021 08:13:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so58784230eda.11
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwPB+JhWs3rhc/KUIs5o7e8MHxx1rjeX2nly04y/rhI=;
        b=WXs/H+X0iq64oI6ybEXVgw5Oq3co1L94LFoO0+Jdl36KnxOqZNwGS1DjBdRt3d9oP0
         hZ21CrfUB+EGbcCUIQanY949m4C8dgey0lQP8AwFHZ4ItDVKWeX7eljHRVkWA0cgRwzE
         d5HYCj/66Pn5lDO/4WYCgsTCjAZG9E4rj3krc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwPB+JhWs3rhc/KUIs5o7e8MHxx1rjeX2nly04y/rhI=;
        b=oNuB+Q7EeTcMR7gFXyB6Q0UfK0Jbt6u410ZiFiaNgKUhfdyXM0xFfVu9BoaAncNADr
         2cLH5s7NabqbNcGS0x8ri7iGSYsrC/IbNo2VHZV1AELEq0BMuoYw3e5nk9KV+Q1PM4A8
         G+KQpgOpqh6syJfn/mVCAXs/4cTgpVG4eslhjqjca0ARrE+ygjJvHU9/5UPfSqRPMq7j
         txHcPpCXq8UbcUc5rcy2sTcvwW8sAExfJcx1IMgBALGxBMvzjOF1iQzYIDUNEkYBGPUO
         V3n/YQk+AdxLXVGVzCbwgFrB3ekMyNXQO2REmEIBRhoJka+ODduS7jA2vAmZ+Ezq4oeE
         kYOw==
X-Gm-Message-State: AOAM533YzaswWrW2HbFNE7ybSmV9S4wgmG8jLsJOqPU8Emrj0vupx46K
        511CH2nQG1/c2qN7QVhYaOKrrq0V1FGOyAJu
X-Google-Smtp-Source: ABdhPJzyE8bmR3SUkHSe3Zz40jkQKzRJGS1zSELGm/6nCfzkxZxgsZw4rMolL5JT7gWmq7GxbZvX2w==
X-Received: by 2002:a17:906:e85:: with SMTP id p5mr362790ejf.159.1638893635501;
        Tue, 07 Dec 2021 08:13:55 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id s16sm103750edt.30.2021.12.07.08.13.54
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:13:55 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id o29so11200366wms.2
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 08:13:54 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr8239503wmq.8.1638893634718;
 Tue, 07 Dec 2021 08:13:54 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 08:13:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
Message-ID: <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 5:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> +#define refcount_dec_and_test refcount_dec_and_test
> +static inline bool refcount_dec_and_test(refcount_t *r)
> +{
> +       asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
> +                          "jz %l[cc_zero]\n\t"
> +                          "jl %l[cc_error]"
> +                          : : [var] "m" (r->refs.counter)
> +                          : "memory"
> +                          : cc_zero, cc_error);
> +       return false;
> +
> +cc_zero:
> +       return true;
> +
> +cc_error:
> +       refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
> +       return false;
> +}

Please don't add broken arch-specific helpers that are useless for
anything else than the broken refcount_t use.

Make it return three return values, call it atomic_dec_and_test_ref()
or something like that, and now people can use it without having to
use a refcount_t.

Nobody really wants two different error cases anyway. The fact that
refcount_warn_saturate() has different cases is only an annoyance.

             Linus

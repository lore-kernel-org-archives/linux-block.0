Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A19C433FE
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 17:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbhLGRq6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbhLGRq5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Dec 2021 12:46:57 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381E7C061746
        for <linux-block@vger.kernel.org>; Tue,  7 Dec 2021 09:43:27 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o20so60085758eds.10
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 09:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Y/rEbxcGNF3MAPp6cBp9cVx3Zbkbk32Q1fY5/ZaBHM=;
        b=ALV5YLtBTRmrWneGLJ872Xmnlcr4WZC8qOh0ul0elwkcEzismugq1By5INcWr9ZuVy
         mXPepSiQZFyXw/5uy+Y1la7gu/cWplmZaXd69ja0pcXFSE/NKxW5qsixZblTPt917wft
         37LQeFqJi7XZZz7WNWGx/afsBI8CTVhIduL6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Y/rEbxcGNF3MAPp6cBp9cVx3Zbkbk32Q1fY5/ZaBHM=;
        b=b1lZKvbv6Uu7xReiwLrzO3DKyL4gXaAdyiqU8F1sDZ/xYS4eYP7+zTWF7S4QfFhRpA
         HfIYPebO9J16Od5r6k2PDS+vIrkjgrolSLahKl4mwQe21YSs+0PVB7pbj//FM2ntRvQo
         yNFIRMz/u8qJKi/L84y5iB4s6jN3H47eVXfus9YglA16qSfvSDVMvl/d0foq3yuAQWXg
         bEqkD0TS/5zM7zeoVCossZrE1XIhX6w/Ug2m6tjF40QIRshyRof8xEpOtEb4XlF1Alcu
         Kd/jOggB+hIBw+6bNaaTE2aJYxyNOtM0b7HeS6mOnufRf7ff5PK2mocJ11M4TJEV9S8w
         5CuA==
X-Gm-Message-State: AOAM532gyOgsZq7rF0wA0pssf6YI/gz8KQGKFftSxCk34d8FKZgW3Zyz
        eLJGPm5vh0dyAO2hKA4vWAtkbaGv8ruEFzxk
X-Google-Smtp-Source: ABdhPJyf8eTXfS+k7/0LuhiGPCcbWxrYXlGVphxYyxZU9I99M/LfBK/R46p0bNfseq2L2lFVS5lxDg==
X-Received: by 2002:a17:907:c0b:: with SMTP id ga11mr919011ejc.39.1638899005627;
        Tue, 07 Dec 2021 09:43:25 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id f16sm325301edd.37.2021.12.07.09.43.23
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 09:43:23 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id o13so31020359wrs.12
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 09:43:23 -0800 (PST)
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr51063976wrx.378.1638899003390;
 Tue, 07 Dec 2021 09:43:23 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net> <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
 <Ya+RPbdgEn6l6RbS@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya+RPbdgEn6l6RbS@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 09:43:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkx24ON4Ow0xkz-FSyb6nsZxxps5gEh7gCaSOvq4MNMw@mail.gmail.com>
Message-ID: <CAHk-=whkx24ON4Ow0xkz-FSyb6nsZxxps5gEh7gCaSOvq4MNMw@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 8:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> How about we do something like the unsafe_ uaccess functions and do it
> like so?

Look ok by me, but I'd suggest simply making both error cases labels
in that case.

If somebody wants to distinguish them, it's easy to do, and if not you
can just use the same label.

Yes, it's a bit unusual, but once you start using labels for the
exceptional cases, why not do so consistently?

In the case of "dec_and_test" the "decrement to zero" case may not be
hugely exceptional, but if you do the same for "increment with
overflow protection" you do end up having the two different "zero vs
too big", so it would actually be more consistent, I think..

                     Linus

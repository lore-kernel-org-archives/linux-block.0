Return-Path: <SRS0=8nuL=VY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C40C7618B
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FAF208C0
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 17:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P118mdqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbfG0RiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Jul 2019 13:38:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43027 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbfG0RiP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jul 2019 13:38:15 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so111342629ios.10
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2019 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxuNjFEA7s07C73APXQQNAta426oIXYom1FUbQczxhw=;
        b=P118mdqtL3CISSKDME3yit/FU9M8ypTF8xHVnp2a9Yup3YhcYXMS74ai0jUKBP3yIN
         GiUzFZoan4DR4QjDabidqUZnhIGnlj68IN+bCTQHVANJlKtwprPgM3f8DGezqFyUm97k
         Mh+PJLGZhGI+2gCBl6sFKQeXoWbs2M7VW+F90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxuNjFEA7s07C73APXQQNAta426oIXYom1FUbQczxhw=;
        b=JhqFbVLYyoOYRv7M1u9fpe4FvBqTA9/CNCj0uYO/1vwIgIMjwCEzxzkyrhk3R6nKHf
         ao1dcpVdCQz3w4Ft3NA7/Ce7iy4k3whMpQ3AVHzioYCRcWphEB5xDoWxqTS9v9Xl7frm
         +0/y/bubDCnAjVyTTQuxUOdOUL1C9i/tkzF96/5P7x8AtFFwiq65Glxc5hGftE0FAxA/
         8PxbyB+Ji1YgJwzyj2AhHx0Z1Kh0xK0P3aEgDv3onW1KeA6DwA18hfISyLiuKd5CcBFY
         lCtWpMoYr7mCvf1bA2qWR5ZUF6iNJ07SV1P5foOBxf6SaEPPv6lFx32YjuuRgCIbf1RZ
         Q7Nw==
X-Gm-Message-State: APjAAAUu9qP+YajB0JAyj83M7Y6rFK2k+LLQEE59KC8YRfwb5btCeqEg
        S6GcRwB5XIwU0wbf17rRPQkD8lRUmbk=
X-Google-Smtp-Source: APXvYqwdRSKL2JKWqskpZ811s8kAhPCcEvCknt7JYDN82zS2soYAIal0fYV8Jh5cOGP1+g3VRlTBYg==
X-Received: by 2002:a5e:9e03:: with SMTP id i3mr23456571ioq.66.1564249094143;
        Sat, 27 Jul 2019 10:38:14 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id v13sm46254783ioq.13.2019.07.27.10.38.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 10:38:12 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id i10so111336471iol.13
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2019 10:38:12 -0700 (PDT)
X-Received: by 2002:a6b:5103:: with SMTP id f3mr88917182iob.142.1564249092231;
 Sat, 27 Jul 2019 10:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190625051249.39265-1-paolo.valente@linaro.org> <20190625051249.39265-6-paolo.valente@linaro.org>
In-Reply-To: <20190625051249.39265-6-paolo.valente@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 27 Jul 2019 10:38:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W23cFq_MxbhZJ9tC9y0y9VqQ-mm8biOOMG_6Enbvb+3A@mail.gmail.com>
Message-ID: <CAD=FV=W23cFq_MxbhZJ9tC9y0y9VqQ-mm8biOOMG_6Enbvb+3A@mail.gmail.com>
Subject: Re: [PATCH BUGFIX IMPROVEMENT V2 5/7] block, bfq: detect wakers and
 unconditionally inject their I/O
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LinusW <linus.walleij@linaro.org>, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, bottura.nicola95@gmail.com,
        srivatsa@csail.mit.edu, Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Mon, Jun 24, 2019 at 10:13 PM Paolo Valente <paolo.valente@linaro.org> wrote:
>
> A bfq_queue Q may happen to be synchronized with another
> bfq_queue Q2, i.e., the I/O of Q2 may need to be completed for Q to
> receive new I/O. We call Q2 "waker queue".
>
> If I/O plugging is being performed for Q, and Q is not receiving any
> more I/O because of the above synchronization, then, thanks to BFQ's
> injection mechanism, the waker queue is likely to get served before
> the I/O-plugging timeout fires.
>
> Unfortunately, this fact may not be sufficient to guarantee a high
> throughput during the I/O plugging, because the inject limit for Q may
> be too low to guarantee a lot of injected I/O. In addition, the
> duration of the plugging, i.e., the time before Q finally receives new
> I/O, may not be minimized, because the waker queue may happen to be
> served only after other queues.
>
> To address these issues, this commit introduces the explicit detection
> of the waker queue, and the unconditional injection of a pending I/O
> request of the waker queue on each invocation of
> bfq_dispatch_request().
>
> One may be concerned that this systematic injection of I/O from the
> waker queue delays the service of Q's I/O. Fortunately, it doesn't. On
> the contrary, next Q's I/O is brought forward dramatically, for it is
> not blocked for milliseconds.
>
> Reported-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> Tested-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 270 ++++++++++++++++++++++++++++++++++++++------
>  block/bfq-iosched.h |  25 +++-
>  2 files changed, 261 insertions(+), 34 deletions(-)

FYI that there is some evidence that this commit, which landed as
commit 13a857a4c4e8 ("block, bfq: detect wakers and unconditionally
inject their I/O"), is causing use-after-frees, as identified by using
slub_debug and/or KASAN.

If folks are willing to follow a link to the Chrome OS bug tracker,
you can find more details starting at:

https://bugs.chromium.org/p/chromium/issues/detail?id=931295#c46


The most relevant part from that discussion so far is that one crash
can be seen in bfq_exit_icq_bfqq():

/* reset waker for all queues in woken list */
hlist_for_each_entry_safe(item, n, &bfqq->woken_list, woken_list_node) {
    item->waker_bfqq = NULL;
    bfq_clear_bfqq_has_waker(item);
==> hlist_del_init(&item->woken_list_node);
}

...where "item" has already been freed.  Hopefully Paolo has some
ideas here since I'm not sure I'll be able to do any more detailed
debugging in the short term.  Happy to throw on a test patch and
re-start tests though.

-Doug

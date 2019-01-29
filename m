Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F129C282D0
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5881920882
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfA2L66 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:58:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46658 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbfA2L64 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:58:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so11277585qkf.13;
        Tue, 29 Jan 2019 03:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EYd9MBtH4J9IZGVnGDQjgUdCtbkiZp5w52yBxkwatco=;
        b=NL679hfkBXE4kL0G2H+HoUxQ7J7xYSEkHqO/x8YzCwTU1vjKtyZIBeZBWdadFhJR1N
         ahT5qLrKywPNg5jUid6lRzTC6p+iZa9ebO0F7K8aksU2f1bN8M89GRK1f7jZcr5JG8GA
         Tl/7ox98yjTjnHfCSQwYphyKM/xhpP7W4JvxhbU9Ouvw/qZtxfKZ3HQKTxUu+gnpvKyf
         3A3zeVgaHHHmru5rR6kmYrWq2OmbCh0mhrzUdldso15hsd50z1qsG1Y3H+Ubop37mRdb
         YCX45pkG0nrTf3QhJKICaSziO8WGIzFV1I6/MYF8TdenvmPFlgT0o+wXX4gebWo0FMQR
         cP3Q==
X-Gm-Message-State: AJcUukclxLRfFhuHoTiQazGLu6kMER3XMjWmK4k5TuMrQxXLg4fe3R26
        Rf2Z296HSMvUelUV8GEYyXe+6bclAkeiuwwwyyA=
X-Google-Smtp-Source: ALg8bN7jxF1+/b2RVrMckoVOgLVAi/zAmhHQ7ZKPwiX2NJFurNRY7Xuh9OhSh0WgM53OEGQVzBaWltSrc6Dfx1VTZTk=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr22704012qkf.330.1548763134097;
 Tue, 29 Jan 2019 03:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-6-axboe@kernel.dk>
 <20190128145700.GA9795@lst.de> <2729ab43-b2bf-44b0-d41d-dbb495ddffbf@kernel.dk>
 <20190129063043.GC2996@lst.de>
In-Reply-To: <20190129063043.GC2996@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 29 Jan 2019 12:58:37 +0100
Message-ID: <CAK8P3a1x4BsFfacxOmaDXKOKmmQ2j0ypX2+mCNCbjH3E7nC4DQ@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 7:30 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jan 28, 2019 at 11:25:12AM -0700, Jens Axboe wrote:
> > > Especially with poll support now in the series, don't we need a ѕigmask
> > > argument similar to pselect/ppoll/io_pgetevents now to deal with signal
> > > blocking during waiting for events?
> >
> > Is there any way to avoid passing in the sigset_t size? If it's just a
> > 32-bit/64-bit thing, surely the in_compat_syscall() could cover it? Or
> > are there other cases that need to be catered to?
>
> As far as I can tell we never look at it, never looked at it and don't
> have any plans to look at it anytime soon.  But when I tried to omit
> it for io_pgetevents I got stong pushback and thus had to add the
> crazy double indirection calling convention.

Deepa has recently reworked the handling for the sigset_t handling
to be more consistent. As I understand it, we only ever check the
size argument to ensure that user and kernel space agree on
the size, as it there had been some historic differences.

If you pass a signal mask to a syscall, you should now just use the
set_user_sigmask()/set_compat_user_sigmask()/restore_user_sigmask()
helpers. The compat version is required for the incompatible bit order
between 32-bit and 64-bit big-endian architectures (on little-endian, compat
and native signal masks are compatible), and to deal with the one
architecture that has an _NSIG defined to something other than 64:
MIPS uses 128 because of a historic accident.

I think Deepa originally suggested combining set_user_sigmask()
and set_compat_user_sigmask(), using an in_compat_syscall()
check. This would let us simplify a number of compat syscalls
(ppoll, ppoll_time32, pselect6, pselect6_time32, epoll_pwait()
io_pgetevents_time64, io_pgetevents_time32). I advised against
changing it at the time for consistency with other compat syscalls,
but it's something we can still do now.

There was a recent discussion about the size of sigset_t in glibc,
which is 1024 bits there instead of 64 bits in the kernel, the idea
being that the kernel might eventually grow more signals at
some point in the future, as we did when we extended from 32
to 64 a long time ago with the addition of the rt_sig* signals;
see the thread around
https://www.spinics.net/lists/linux-snps-arc/msg04860.html

    Arnd

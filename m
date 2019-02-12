Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F6CC282CE
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 21:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C83222C0
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 21:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0Dz2BBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfBLVm7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40291 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732210AbfBLVm6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so371215oth.7
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 13:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0F1VOpjaU1MAdnBQ+W3gOK6Z7JMIWI8b6QJW5As3Hc=;
        b=R0Dz2BBosLHCzL742Idg9FCk1XOe72kOCOwQMqV0D0gNs8RbepO9tUbE1LwairW1mt
         MG1/Dn2qbf3DxKRakuhvlVzY2J5QRJDRaSeShnFXjw2nWPxiJEiNTwTYI6iMWxrcRwwB
         +nSLO+vqIdufsAt0IYW6V8y8A/QVINEhtym8XInmBirEbrK1AfhEvX22x8T9Bcywj3Fv
         EYm44+9qCVStAHykqe7Wv+P3SzVGM8EDKsIsBhAJrjNZCxGTjP1R6Dr5XetoMo5yBH4N
         oFXyyBJg4hkXxvJFFCdjjp9Ye7ZUJYnp8J/h56+qbTTwtUaLyIk0njBE2QSH9Zm7kfiG
         A5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0F1VOpjaU1MAdnBQ+W3gOK6Z7JMIWI8b6QJW5As3Hc=;
        b=S5CQRgw+2j88lBqo8EGchoI2erzhD6V4aEVJdWjpJvl0BbM3PnAV2p5Lljni5jDmM3
         hQ/9/l2rx0NDE7KDelnoptWZvbGNjiq21NZ7tc1jrhiUG2XjFza4bzUKt5XpnIYuDIhs
         MJHT+shVTxhvKr/K1i9WhQ6r0pU6/rSiB/TK62PhYRWOTP+V1OcN9jGY7esrDZBFiQTH
         FdtyOxkRQh+uTt76PTNDQgb3MtZyznPWVptl/Fw3MWCBUlFDJIFolevvhtlzPtQWaa0k
         MG8ZmGyeEiBkZAJ3oWC+IBDOmTnRBsiL9DwMabrpCd8hUtqIx2iIoKYlEz7ARwcHSWPR
         pZ0g==
X-Gm-Message-State: AHQUAuZFV9/ydBxO/Q0ww8geXhwxVBtfPSYL9MSbQJAbjHSgIws3Z1Ho
        5yx0phJuAP4MoQDqNEbxyfAjN5bRb6hFVkE7eiA6Zg==
X-Google-Smtp-Source: AHgI3IZb/OqHaICmu24udXoqSqMAgvoAoluO8Aw21iC5tyBO/0wIMJ4e4yOvXFczbH1H/Q/aZ90gCZ+EJ62Y+hHcDpw=
X-Received: by 2002:a9d:66d0:: with SMTP id t16mr6173698otm.35.1550007777115;
 Tue, 12 Feb 2019 13:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20190208173423.27014-1-axboe@kernel.dk> <20190208173423.27014-6-axboe@kernel.dk>
 <CAG48ez2Qc9XOApLRb5fnNiOjxaURO8vjZ-EHX7g25gje3weZ6A@mail.gmail.com> <42eea00c-81fb-2e28-d884-03be5bb229c8@kernel.dk>
In-Reply-To: <42eea00c-81fb-2e28-d884-03be5bb229c8@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 12 Feb 2019 22:42:31 +0100
Message-ID: <CAG48ez2c=7f34AX_FFKTFFnNqJojULs9GwdqaMv=WO2tYLZE3g@mail.gmail.com>
Subject: Re: [PATCH 05/19] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 9, 2019 at 5:15 AM Jens Axboe <axboe@kernel.dk> wrote:
> On 2/8/19 3:12 PM, Jann Horn wrote:
> > On Fri, Feb 8, 2019 at 6:34 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> The submission queue (SQ) and completion queue (CQ) rings are shared
> >> between the application and the kernel. This eliminates the need to
> >> copy data back and forth to submit and complete IO.
> >>
> >> IO submissions use the io_uring_sqe data structure, and completions
> >> are generated in the form of io_uring_cqe data structures. The SQ
> >> ring is an index into the io_uring_sqe array, which makes it possible
> >> to submit a batch of IOs without them being contiguous in the ring.
> >> The CQ ring is always contiguous, as completion events are inherently
> >> unordered, and hence any io_uring_cqe entry can point back to an
> >> arbitrary submission.
> >>
> >> Two new system calls are added for this:
> >>
> >> io_uring_setup(entries, params)
> >>         Sets up an io_uring instance for doing async IO. On success,
> >>         returns a file descriptor that the application can mmap to
> >>         gain access to the SQ ring, CQ ring, and io_uring_sqes.
> >>
> >> io_uring_enter(fd, to_submit, min_complete, flags, sigset, sigsetsize)
> >>         Initiates IO against the rings mapped to this fd, or waits for
> >>         them to complete, or both. The behavior is controlled by the
> >>         parameters passed in. If 'to_submit' is non-zero, then we'll
> >>         try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
> >>         kernel will wait for 'min_complete' events, if they aren't
> >>         already available. It's valid to set IORING_ENTER_GETEVENTS
> >>         and 'min_complete' == 0 at the same time, this allows the
> >>         kernel to return already completed events without waiting
> >>         for them. This is useful only for polling, as for IRQ
> >>         driven IO, the application can just check the CQ ring
> >>         without entering the kernel.
> >>
> >> With this setup, it's possible to do async IO with a single system
> >> call. Future developments will enable polled IO with this interface,
> >> and polled submission as well. The latter will enable an application
> >> to do IO without doing ANY system calls at all.
> >>
> >> For IRQ driven IO, an application only needs to enter the kernel for
> >> completions if it wants to wait for them to occur.
> >>
> >> Each io_uring is backed by a workqueue, to support buffered async IO
> >> as well. We will only punt to an async context if the command would
> >> need to wait for IO on the device side. Any data that can be accessed
> >> directly in the page cache is done inline. This avoids the slowness
> >> issue of usual threadpools, since cached data is accessed as quickly
> >> as a sync interface.
[...]
> >> +static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
> >> +{
> >> +       struct io_kiocb *req;
> >> +       ssize_t ret;
> >> +
> >> +       /* enforce forwards compatibility on users */
> >> +       if (unlikely(s->sqe->flags))
> >> +               return -EINVAL;
> >> +
> >> +       req = io_get_req(ctx);
> >> +       if (unlikely(!req))
> >> +               return -EAGAIN;
> >> +
> >> +       req->rw.ki_filp = NULL;
> >> +
> >> +       ret = __io_submit_sqe(ctx, req, s, true);
> >> +       if (ret == -EAGAIN) {
> >> +               memcpy(&req->submit, s, sizeof(*s));
> >> +               INIT_WORK(&req->work, io_sq_wq_submit_work);
> >> +               queue_work(ctx->sqo_wq, &req->work);
> >> +               ret = 0;
> >> +       }
> >> +       if (ret)
> >> +               io_free_req(req);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static void io_commit_sqring(struct io_ring_ctx *ctx)
> >> +{
> >> +       struct io_sq_ring *ring = ctx->sq_ring;
> >> +
> >> +       if (ctx->cached_sq_head != ring->r.head) {
> >> +               WRITE_ONCE(ring->r.head, ctx->cached_sq_head);
> >> +               /* write side barrier of head update, app has read side */
> >> +               smp_wmb();
> >
> > Can you elaborate on what this memory barrier is doing? Don't you need
> > some sort of memory barrier *before* the WRITE_ONCE(), to ensure that
> > nobody sees the updated head before you're done reading the submission
> > queue entry? Or is that barrier elsewhere?
>
> The matching read barrier is in the application, it must do that before
> reading ->head for the SQ ring.
>
> For the other barrier, since the ring->r.head now has a READ_ONCE(),
> that should be all we need to ensure that loads are done.

READ_ONCE() / WRITE_ONCE are not hardware memory barriers that enforce
ordering with regard to concurrent execution on other cores. They are
only compiler barriers, influencing the order in which the compiler
emits things. (Well, unless you're on alpha, where READ_ONCE() implies
a memory barrier that prevents reordering of dependent reads.)

As far as I can tell, between the READ_ONCE(ring->array[...]) in
io_get_sqring() and the WRITE_ONCE() in io_commit_sqring(), you have
no *hardware* memory barrier that prevents reordering against
concurrently running userspace code. As far as I can tell, the
following could happen:

 - The kernel reads from ring->array in io_get_sqring(), then updates
the head in io_commit_sqring(). The CPU reorders the memory accesses
such that the write to the head becomes visible before the read from
ring->array has completed.
 - Userspace observes the write to the head and reuses the array slots
the kernel has freed with the write, clobbering ring->array before the
kernel reads from ring->array.

Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B937DC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 22:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7771E222BB
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 22:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXI9MpO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfBLWlD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:41:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33020 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfBLWlD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 17:41:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so703998otl.0
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 14:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4tI/n+DAW2n3H6cuw59U50QqRgdIchoF8LGQrOzgVg=;
        b=rXI9MpO1cxY9zLdrUPyAVDaiPi5voLOJ+W+uF0yGRMv00CHn/5JHJkslVW8+wWidYq
         4cacyDciscZdSwjSah8XrU1FfZsNwS3ZrcYTQV3T0t9sGcoh07w5F4vDoMzghRMI9Fwx
         PxfMC5hCB2ey9tdihBXZg00LFutZjw0tglRCgZjpIwr7ldXqTkQJPKbrMzSUyDXVCt9N
         M1IXDKc8h8shNGqLibacBVTlP9s423vHIqy8Bmwzxch+piqhAZ2HBOlngm5ua4wRKQBe
         TcRY2wAle5trcIsLu1Jr8G7roxCGwFPxcgXptNcusGJPmj8O3nQsplS9jXZx113qGW98
         ZQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4tI/n+DAW2n3H6cuw59U50QqRgdIchoF8LGQrOzgVg=;
        b=EB/FJmujwFWhz9y0LULBQ7Dh6fxQDRaA61w921RP8a8LAnLd5X27iEcRNd9gshpqXO
         PWpLwvZLV+LTuodS/fURbPyNlzPJXUkBuI3sGkKuRdNLCNur21kyAbRIiRib9xIburNq
         OGT8LluNdr3Pby/74mQmzkgi+8Ianj6aha1pEmH56GdgZuyuJORCoZAhP24GYCrdMH5c
         3HLztMUmtIwI3LomZuWlJ2qxEsH1q33OePXWkSLT16rAuUU3osC0DMBCsgorN/UvWtOf
         zY6Hn/ttWM5pNgviKV7j6SJGue6NKv7M1/El/lmZa98mfpKfumPgKMcUOdofxnNfPCA7
         C/Ug==
X-Gm-Message-State: AHQUAubc4k7sGULZUUT+SMko5uXPiYmfh7/ueGc4JBazvsaZcgPFzslr
        vniC8TMarbhUBWA2iudfZVdNBriGufViIhTXUam9kQ==
X-Google-Smtp-Source: AHgI3IZ/Dc+PW2Fsj9zukxESEFDudbpBUW5FVSONT/fz6RuVE5LXcqktvwUM8r5ysuPgpn/gQ52/0ck2zSPDKPFPR4Y=
X-Received: by 2002:a9d:66d0:: with SMTP id t16mr6410891otm.35.1550011261995;
 Tue, 12 Feb 2019 14:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20190208173423.27014-1-axboe@kernel.dk> <20190208173423.27014-6-axboe@kernel.dk>
 <CAG48ez2Qc9XOApLRb5fnNiOjxaURO8vjZ-EHX7g25gje3weZ6A@mail.gmail.com>
 <42eea00c-81fb-2e28-d884-03be5bb229c8@kernel.dk> <CAG48ez2c=7f34AX_FFKTFFnNqJojULs9GwdqaMv=WO2tYLZE3g@mail.gmail.com>
 <1ca9f039-c6f0-cae7-8484-7db0a4e4e213@kernel.dk> <f20b8e79-d10f-6316-561f-3c77cab71ee0@kernel.dk>
In-Reply-To: <f20b8e79-d10f-6316-561f-3c77cab71ee0@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 12 Feb 2019 23:40:35 +0100
Message-ID: <CAG48ez0rJU8bx4EFJwzXOpUX1C2J86pDFHtwEdvKf2K2tsWuig@mail.gmail.com>
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

On Tue, Feb 12, 2019 at 11:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/12/19 3:03 PM, Jens Axboe wrote:
> > On 2/12/19 2:42 PM, Jann Horn wrote:
> >> On Sat, Feb 9, 2019 at 5:15 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>> On 2/8/19 3:12 PM, Jann Horn wrote:
> >>>> On Fri, Feb 8, 2019 at 6:34 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>> The submission queue (SQ) and completion queue (CQ) rings are shared
> >>>>> between the application and the kernel. This eliminates the need to
> >>>>> copy data back and forth to submit and complete IO.
> >>>>>
> >>>>> IO submissions use the io_uring_sqe data structure, and completions
> >>>>> are generated in the form of io_uring_cqe data structures. The SQ
> >>>>> ring is an index into the io_uring_sqe array, which makes it possible
> >>>>> to submit a batch of IOs without them being contiguous in the ring.
> >>>>> The CQ ring is always contiguous, as completion events are inherently
> >>>>> unordered, and hence any io_uring_cqe entry can point back to an
> >>>>> arbitrary submission.
> >>>>>
> >>>>> Two new system calls are added for this:
> >>>>>
> >>>>> io_uring_setup(entries, params)
> >>>>>         Sets up an io_uring instance for doing async IO. On success,
> >>>>>         returns a file descriptor that the application can mmap to
> >>>>>         gain access to the SQ ring, CQ ring, and io_uring_sqes.
> >>>>>
> >>>>> io_uring_enter(fd, to_submit, min_complete, flags, sigset, sigsetsize)
> >>>>>         Initiates IO against the rings mapped to this fd, or waits for
> >>>>>         them to complete, or both. The behavior is controlled by the
> >>>>>         parameters passed in. If 'to_submit' is non-zero, then we'll
> >>>>>         try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
> >>>>>         kernel will wait for 'min_complete' events, if they aren't
> >>>>>         already available. It's valid to set IORING_ENTER_GETEVENTS
> >>>>>         and 'min_complete' == 0 at the same time, this allows the
> >>>>>         kernel to return already completed events without waiting
> >>>>>         for them. This is useful only for polling, as for IRQ
> >>>>>         driven IO, the application can just check the CQ ring
> >>>>>         without entering the kernel.
> >>>>>
> >>>>> With this setup, it's possible to do async IO with a single system
> >>>>> call. Future developments will enable polled IO with this interface,
> >>>>> and polled submission as well. The latter will enable an application
> >>>>> to do IO without doing ANY system calls at all.
> >>>>>
> >>>>> For IRQ driven IO, an application only needs to enter the kernel for
> >>>>> completions if it wants to wait for them to occur.
> >>>>>
> >>>>> Each io_uring is backed by a workqueue, to support buffered async IO
> >>>>> as well. We will only punt to an async context if the command would
> >>>>> need to wait for IO on the device side. Any data that can be accessed
> >>>>> directly in the page cache is done inline. This avoids the slowness
> >>>>> issue of usual threadpools, since cached data is accessed as quickly
> >>>>> as a sync interface.
> >> [...]
> >>>>> +static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
> >>>>> +{
> >>>>> +       struct io_kiocb *req;
> >>>>> +       ssize_t ret;
> >>>>> +
> >>>>> +       /* enforce forwards compatibility on users */
> >>>>> +       if (unlikely(s->sqe->flags))
> >>>>> +               return -EINVAL;
> >>>>> +
> >>>>> +       req = io_get_req(ctx);
> >>>>> +       if (unlikely(!req))
> >>>>> +               return -EAGAIN;
> >>>>> +
> >>>>> +       req->rw.ki_filp = NULL;
> >>>>> +
> >>>>> +       ret = __io_submit_sqe(ctx, req, s, true);
> >>>>> +       if (ret == -EAGAIN) {
> >>>>> +               memcpy(&req->submit, s, sizeof(*s));
> >>>>> +               INIT_WORK(&req->work, io_sq_wq_submit_work);
> >>>>> +               queue_work(ctx->sqo_wq, &req->work);
> >>>>> +               ret = 0;
> >>>>> +       }
> >>>>> +       if (ret)
> >>>>> +               io_free_req(req);
> >>>>> +
> >>>>> +       return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static void io_commit_sqring(struct io_ring_ctx *ctx)
> >>>>> +{
> >>>>> +       struct io_sq_ring *ring = ctx->sq_ring;
> >>>>> +
> >>>>> +       if (ctx->cached_sq_head != ring->r.head) {
> >>>>> +               WRITE_ONCE(ring->r.head, ctx->cached_sq_head);
> >>>>> +               /* write side barrier of head update, app has read side */
> >>>>> +               smp_wmb();
> >>>>
> >>>> Can you elaborate on what this memory barrier is doing? Don't you need
> >>>> some sort of memory barrier *before* the WRITE_ONCE(), to ensure that
> >>>> nobody sees the updated head before you're done reading the submission
> >>>> queue entry? Or is that barrier elsewhere?
> >>>
> >>> The matching read barrier is in the application, it must do that before
> >>> reading ->head for the SQ ring.
> >>>
> >>> For the other barrier, since the ring->r.head now has a READ_ONCE(),
> >>> that should be all we need to ensure that loads are done.
> >>
> >> READ_ONCE() / WRITE_ONCE are not hardware memory barriers that enforce
> >> ordering with regard to concurrent execution on other cores. They are
> >> only compiler barriers, influencing the order in which the compiler
> >> emits things. (Well, unless you're on alpha, where READ_ONCE() implies
> >> a memory barrier that prevents reordering of dependent reads.)
> >>
> >> As far as I can tell, between the READ_ONCE(ring->array[...]) in
> >> io_get_sqring() and the WRITE_ONCE() in io_commit_sqring(), you have
> >> no *hardware* memory barrier that prevents reordering against
> >> concurrently running userspace code. As far as I can tell, the
> >> following could happen:
> >>
> >>  - The kernel reads from ring->array in io_get_sqring(), then updates
> >> the head in io_commit_sqring(). The CPU reorders the memory accesses
> >> such that the write to the head becomes visible before the read from
> >> ring->array has completed.
> >>  - Userspace observes the write to the head and reuses the array slots
> >> the kernel has freed with the write, clobbering ring->array before the
> >> kernel reads from ring->array.
> >
> > I'd say this is highly theoretical for the normal use case, as we
> > will have submitted IO in between. Hence the load must have been done.

Sorry, I'm confused. Who is "we", and which load are you referring to?
io_sq_thread() goes directly from io_get_sqring() to
io_commit_sqring(), with only a conditional io_sqe_needs_user() in
between, if the `i == ARRAY_SIZE(sqes)` check triggers. There is no
"submitting IO" in the middle.

> > The only case that needs it is the sq thread case, since we bundle
> > those up. This should do it:
>
> Actually, I take that back, as in this particular case the sq thread
> is the only one that reads it.

What is "it"? The head pointer is written by the sq thread and read by
userspace, not the other way around. Are you talking about
ring->array? Sorry, I'm lost.

> Hence it'll have done a full submission
> of the read SQE entries before reading a new round. Not that it matters
> for that case, as a preempt would have implied a full barrier anyway.

> The non-sq thread case does not need the store-vs-load ordering
> barrier, as SQEs are either discarded or submitted before we commit
> the sqring. Since that's the case, by definition all loads are done.

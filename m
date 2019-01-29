Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCB5C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 02:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAAC2177E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 02:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmDwI1z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfA2CV2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 21:21:28 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44845 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfA2CV2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 21:21:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id g16so12567463otg.11
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 18:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/RTUmsXQFDrzF/j+XKFU2Kw4i263ggkodwjoN69BJM=;
        b=KmDwI1z3ypVwfKSyns+P4BLXhNsYsUhVxHSVZlLhJvzzmZHmCyQsJQWtbxko9fdVRY
         WtQEREmxNR8PMmj+o+k4/ap1WybZHq3h88RMNsOAPds322jwqw9n9TJJJN+eSSX9PcrP
         3flYlrcyRlsI1mFmlX46UmpR7lKZayoFTWGmo6xIplRYUnf/ABgXtyxEeFBvdANTB+lG
         CIiFnsDNZ6vI1h8OchYVFiO787WxLefGhjiPtorceObDZbVAX+1NOxWvFkQevd56FFKM
         LAz+ul8N3/7Hsc2vDnIzo2cyocb3lDTbB7+96cXmT+y0OfZWIHH/OODUL6rLMPgls+yc
         D5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/RTUmsXQFDrzF/j+XKFU2Kw4i263ggkodwjoN69BJM=;
        b=VwAuwWpimjiRvkNy2gff5FoOtq254Au/noHa2db3u5LxRB3D5kugfq4tl4T2951TWX
         GOp15Dac6yck1OgBn4z5my1DhCW+c0K44WwRKv8JMfkqzSMvHqQBsWgHvdWgsEstYR/1
         4/HG/YcycqwKgLf4v6aDIJ0/JQf6jbSszIsOealo9oSjzQvIeVbRtlt9nZeTeIlRcKUq
         8kP6vxR+epmuL7o8K8PIEPPyK1DRJ8ssW1i+mW6/+D/p/S3fZQI4xy+MkgvvLBJetScd
         jAxxRmHRUs0FdDBbhKps3HhrV4PdFMPjcTyEuDruTIHW9x30YL5J6JJ+YckURrKmP3aA
         Xu0Q==
X-Gm-Message-State: AJcUukcNiVTOSPthTgUwcNn6CMrzCr/93dVk8+uQi+puxf+mG654ftNE
        lICBHR9Xavw9binyo4A/8MpgSaPQ94j6L1zzv/OrvA==
X-Google-Smtp-Source: ALg8bN5QZwuQqMsSzCgo2NKXvzsxoM9DVi70rxjndtSai5KapRPIxgyieL+k7n02GyUo8UfEfIM0xPTtLU8iKIvuCZc=
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr17083378otr.292.1548728486787;
 Mon, 28 Jan 2019 18:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez1qxZLfJzK95kjh0RiQ6kvZLbQhr6Dr0EjBNQB6Fr7NXQ@mail.gmail.com>
In-Reply-To: <CAG48ez1qxZLfJzK95kjh0RiQ6kvZLbQhr6Dr0EjBNQB6Fr7NXQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 03:21:00 +0100
Message-ID: <CAG48ez1Ms+NPTXPj_UiQyv=2aMaMR3akCdp5SdDL3x7x7gd_ig@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 2:07 AM Jann Horn <jannh@google.com> wrote:
> On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
> > The submission queue (SQ) and completion queue (CQ) rings are shared
> > between the application and the kernel. This eliminates the need to
> > copy data back and forth to submit and complete IO.
> [...]
> > +static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
> > +{
> > +       struct io_sq_ring *ring = ctx->sq_ring;
> > +       unsigned head;
> > +
> > +       /*
> > +        * The cached sq head (or cq tail) serves two purposes:
> > +        *
> > +        * 1) allows us to batch the cost of updating the user visible
> > +        *    head updates.
> > +        * 2) allows the kernel side to track the head on its own, even
> > +        *    though the application is the one updating it.
> > +        */
> > +       head = ctx->cached_sq_head;
> > +       smp_rmb();
> > +       if (head == READ_ONCE(ring->r.tail))
> > +               return false;
> > +
> > +       head = ring->array[head & ctx->sq_mask];
> > +       if (head < ctx->sq_entries) {
> > +               s->index = head;
> > +               s->sqe = &ctx->sq_sqes[head];
>
> ring->array can be mapped writable into userspace, right? If so: This
> looks like a double-read issue; the compiler might assume that
> ring->array is not modified concurrently and perform separate memory
> accesses for the "if (head < ctx->sq_entries)" check and the
> "&ctx->sq_sqes[head]" computation. Please use READ_ONCE()/WRITE_ONCE()
> for all accesses to memory that userspace could concurrently modify in
> a malicious way.
>
> There have been some pretty severe security bugs caused by missing
> READ_ONCE() annotations around accesses to shared memory; see, for
> example, https://www.blackhat.com/docs/us-16/materials/us-16-Wilhelm-Xenpwn-Breaking-Paravirtualized-Devices.pdf
> . Slides 35-48 show how the code "switch (op->cmd)", where "op" is a
> pointer to shared memory, allowed an attacker to break out of a Xen
> virtual machine because the compiler generated multiple memory
> accesses.

Oh, actually, it's even worse (comments with "//" added by me):

io_sq_thread() does this:

        do {
                // sqes[i].sqe is pointer to shared memory, result of
                // io_sqe_needs_user() is unreliable
                if (all_fixed && io_sqe_needs_user(sqes[i].sqe))
                        all_fixed = false;

                i++;
                if (i == ARRAY_SIZE(sqes))
                        break;
        } while (io_get_sqring(ctx, &sqes[i]));
        // sqes[...].sqe are pointers to shared memory

        io_commit_sqring(ctx);

        /* Unless all new commands are FIXED regions, grab mm */
        if (!all_fixed && !cur_mm) {
                mm_fault = !mmget_not_zero(ctx->sqo_mm);
                if (!mm_fault) {
                        use_mm(ctx->sqo_mm);
                        cur_mm = ctx->sqo_mm;
                }
        }

        inflight += io_submit_sqes(ctx, sqes, i, mm_fault);

Then the shared memory pointers go into io_submit_sqes():

static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
                          unsigned int nr, bool mm_fault)
{
        struct io_submit_state state, *statep = NULL;
        int ret, i, submitted = 0;
        // sqes[...].sqe are pointers to shared memory
        [...]
        for (i = 0; i < nr; i++) {
                if (unlikely(mm_fault))
                        ret = -EFAULT;
                else
                        ret = io_submit_sqe(ctx, &sqes[i], statep);
                [...]
        }
        [...]
}

And on into io_submit_sqe():

static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
                         struct io_submit_state *state)
{
        [...]
        ret = __io_submit_sqe(ctx, req, s, true, state);
        [...]
}

And there it gets interesting:

static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
                           struct sqe_submit *s, bool force_nonblock,
                           struct io_submit_state *state)
{
        // s->sqe is a pointer to shared memory
        const struct io_uring_sqe *sqe = s->sqe;
        // sqe is a pointer to shared memory
        ssize_t ret;

        if (unlikely(s->index >= ctx->sq_entries))
                return -EINVAL;
        req->user_data = sqe->user_data;

        ret = -EINVAL;
        // switch() on read from shared memory, potential instruction pointer
        // control
        switch (sqe->opcode) {
        [...]
        case IORING_OP_READV:
                if (unlikely(sqe->buf_index))
                        return -EINVAL;
                ret = io_read(req, sqe, force_nonblock, state);
                break;
        [...]
        case IORING_OP_READ_FIXED:
                ret = io_read(req, sqe, force_nonblock, state);
                break;
        [...]
        }
        [...]
}

On into io_read():

static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
                       bool force_nonblock, struct io_submit_state *state)
{
[...]
        // sqe is a pointer to shared memory
        ret = io_prep_rw(req, sqe, force_nonblock, state);
        [...]
}

And then io_prep_rw() does multiple reads even in the source code:

static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
                      bool force_nonblock, struct io_submit_state *state)
{
        struct io_ring_ctx *ctx = req->ctx;
        struct kiocb *kiocb = &req->rw;
        int ret;

        // sqe is a pointer to shared memory

        // double-read of sqe->flags, see end of function
        if (sqe->flags & IOSQE_FIXED_FILE) {
                // double-read of sqe->fd for the bounds check and the
array access, potential OOB pointer read
                if (unlikely(!ctx->user_files || sqe->fd >= ctx->nr_user_files))
                        return -EBADF;
                kiocb->ki_filp = ctx->user_files[sqe->fd];
                req->flags |= REQ_F_FIXED_FILE;
        } else {
                kiocb->ki_filp = io_file_get(state, sqe->fd);
        }
        if (unlikely(!kiocb->ki_filp))
                return -EBADF;
        kiocb->ki_pos = sqe->off;
        kiocb->ki_flags = iocb_flags(kiocb->ki_filp);
        kiocb->ki_hint = ki_hint_validate(file_write_hint(kiocb->ki_filp));
        // three reads of sqe->ioprio, bypassable capability check
        if (sqe->ioprio) {
                ret = ioprio_check_cap(sqe->ioprio);
                if (ret)
                        goto out_fput;

                kiocb->ki_ioprio = sqe->ioprio;
        } else
                kiocb->ki_ioprio = get_current_ioprio();
        [...]
        return 0;
out_fput:
        // double-read of sqe->flags, changed value can lead to
unbalanced refcount
        if (!(sqe->flags & IOSQE_FIXED_FILE))
                io_file_put(state, kiocb->ki_filp);
        return ret;
}

Please create a local copy of the request before parsing it to keep
the data from changing under you. Additionally, it might make sense to
annotate every pointer to shared memory with a comment, or something
like that, to ensure that anyone looking at the code can immediately
see for which pointers special caution is required on access.

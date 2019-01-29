Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71D4C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 20:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDDF214D8
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 20:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGKkNyC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfA2UsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:48:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36328 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfA2UsR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 15:48:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so19178476otk.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 12:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXkP7hOwFgiGW0oh2UjZxqbUBgpKiE6gNiSbUqfg8M0=;
        b=HGKkNyC3ISIB4254bSbo2wW/YFxeqZTh/GTwm9Hru16YofiMZQAyHz/wEdjrTCSqjH
         yuFim5ZRtdi+dv/PFQST7yLOPzMTNt/YWYf8CJ9bbAZnoO8tJQPlMg+U8WBHqIYz+Ok+
         yE+x7CE5f8D4dT+HFhpnS33e0msUstfiAC6ad0NYyyq11ZvMaDSGU7MCScsSPWXtTRYy
         Xf8+V+xsCA9QYfjqto27xbXSlJeHJaxFwa8Y5eiYh1lao89GbFc80Z4CwP3R0xKR5nQF
         lxfSJ08nOvfZQs9WVbzxot9ngaT49O+6D9jwIyLlIkHL4efjt6e7Ds85B9Km8XE8r7lt
         9cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXkP7hOwFgiGW0oh2UjZxqbUBgpKiE6gNiSbUqfg8M0=;
        b=KNa3mDUpMgIeDmRuZXP6iP/0EwFz3IIhDPMUEJEr5unLQAyoPzYmIX3EG5yKyVjq83
         Pvy4yvVzEKjfhFbREj8oNYXBoS/H+EbxkDMWCcJsD57GOHOgpG77O1RPYHPeDTMnKAzQ
         KEhXR2pDLDTIsKZtlcZy1ro/VkE1EriqhGN//mdickQhlpVK2XsWuhG5kfKy25OTOqso
         NnoMNWd0ge9HFLkKmJF0Vj+lb1/qaAHvOf4ZHFfxnRS5CvQ1qmI689Tj1xVUNKht5qSi
         t6tnGRP6pW/bd9n9mEux9OGKmeiCokSBnXDgstL9IOjyPg/qH0JagSxeL/66K5D4yWcV
         Zjpg==
X-Gm-Message-State: AJcUukf7O3PTx5IHjd1IRl/4wd+PCY0UtIKTgo80o72Pe2Af33WidMwa
        bkMZt3s+iqm7gKfr6G5U2FKi9bkPWfOHD0wmQXA4PA==
X-Google-Smtp-Source: ALg8bN4QKlzc9V8t4aITlS1jV/41gzON3ViWQHRiTCG5EJcE2tAsf2FDIGmkxHeobgzPFGCzEbv9emeNshI49oozTtc=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr20952437otf.242.1548794896591;
 Tue, 29 Jan 2019 12:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20190129192702.3605-1-axboe@kernel.dk> <20190129192702.3605-8-axboe@kernel.dk>
In-Reply-To: <20190129192702.3605-8-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 21:47:50 +0100
Message-ID: <CAG48ez270gG64wmHtG8pNUoBWiSwYiGxsyuSCQ_4wn7v_n_h_w@mail.gmail.com>
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
> Add support for a polled io_uring context. When a read or write is
> submitted to a polled context, the application must poll for completions
> on the CQ ring through io_uring_enter(2). Polled IO may not generate
> IRQ completions, hence they need to be actively found by the application
> itself.
>
> To use polling, io_uring_setup() must be used with the
> IORING_SETUP_IOPOLL flag being set. It is illegal to mix and match
> polled and non-polled IO on an io_uring.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
[...]
> @@ -102,6 +102,8 @@ struct io_ring_ctx {
>
>         struct {
>                 spinlock_t              completion_lock;
> +               bool                    poll_multi_file;
> +               struct list_head        poll_list;

Please add a comment explaining what protects poll_list against
concurrent modification, and ideally also put lockdep asserts in the
functions that access the list to allow the kernel to sanity-check the
locking at runtime.

As far as I understand:
Elements are added by io_iopoll_req_issued(). io_iopoll_req_issued()
can't race with itself because, depending on IORING_SETUP_SQPOLL,
either you have to come through sys_io_uring_enter() (which takes the
uring_lock), or you have to come from the single-threaded
io_sq_thread().
io_do_iopoll() iterates over the list and removes completed items.
io_do_iopoll() is called through io_iopoll_getevents(), which can be
invoked in two ways during normal operation:
 - sys_io_uring_enter -> __io_uring_enter -> io_iopoll_check
->io_iopoll_getevents; this is only protected by the uring_lock
 - io_sq_thread -> io_iopoll_check ->io_iopoll_getevents; this doesn't
hold any locks
Additionally, the following exit paths:
 - io_sq_thread -> io_iopoll_reap_events -> io_iopoll_getevents
 - io_uring_release -> io_ring_ctx_wait_and_kill ->
io_iopoll_reap_events -> io_iopoll_getevents
 - io_uring_release -> io_ring_ctx_wait_and_kill -> io_ring_ctx_free
-> io_iopoll_reap_events -> io_iopoll_getevents

So as far as I can tell, you can have various races around access to
the poll_list.

[...]
> +static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
> +{
> +       if (*nr) {
> +               kmem_cache_free_bulk(req_cachep, *nr, reqs);
> +               io_ring_drop_ctx_refs(ctx, *nr);
> +               *nr = 0;
> +       }
> +}
[...]
> +static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
> +                              struct list_head *done)
> +{
> +       void *reqs[IO_IOPOLL_BATCH];
> +       struct io_kiocb *req;
> +       int to_free = 0;
> +
> +       while (!list_empty(done)) {
> +               req = list_first_entry(done, struct io_kiocb, list);
> +               list_del(&req->list);
> +
> +               io_cqring_fill_event(ctx, req->user_data, req->error, 0);
> +
> +               reqs[to_free++] = req;
> +               (*nr_events)++;
> +
> +               fput(req->rw.ki_filp);
> +               if (to_free == ARRAY_SIZE(reqs))
> +                       io_free_req_many(ctx, reqs, &to_free);
> +       }
> +       io_commit_cqring(ctx);
> +
> +       if (to_free)
> +               io_free_req_many(ctx, reqs, &to_free);

Nit: You check here whether to_free==0, and then io_free_req_many()
does that again. You can delete one of those checks; I'd probably
delete this one.

> +}
[...]

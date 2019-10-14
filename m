Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C92ECE587
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 09:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7504720882
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 09:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFuDEwZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfJNJmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:42:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37600 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfJNJmX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 05:42:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so11322099lff.4
        for <linux-block@vger.kernel.org>; Mon, 14 Oct 2019 02:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2Ua6hANCarvccUo5gZADvZkckLwm4uleN58EaH/0Kk=;
        b=QFuDEwZCzRv1ihub1QOzASpkOsgTsUNDlhwAZ3UrKj8RVLcLzVq40zdV8N1WsS0TnA
         0C0+W5HrrZcDFCpnN0jm1IjFraZpLIhZOa1GUryxfBvFWrmD6LUkGjb/HrPV593azd6H
         fGirVnJI5P+sPynlKfzQegF41I43Od2iTxq6UKg/auNYv2ewCAUXu0eqSxH1+m1RN02N
         /9Y8v8yjCHQFNTErVjOyzhmKvYld85fZ08ulfT8J6//NLkOtTa67j4dMOHCWW3o8aXRA
         qk9Vq+cF+NtPfvldiFX3SiLyZA+2JQfhAsKJdKv2Za+5Ig9eLfa8POFiMl1EQz75C7+y
         dIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2Ua6hANCarvccUo5gZADvZkckLwm4uleN58EaH/0Kk=;
        b=fthwE7AVxpIPH8qR/2aaZtKaJn+JmOYXWdvoJRb9DUE8X4htRVEocbAKLIQp6t+vRQ
         iqsIJhllc+xRUvLYIPrbPKTZ0yQK00vHehsusN0NYV8Ghrt2YZlLmILAdH631QtHszlj
         qXdv1uqgnJ1VtVwIznABIOidO3SB5u83Loq59KSZxAQj6ZJSdJ9ce375o7o95OlX+oKo
         GyPB2tgXK55lmPE34ZcaHekFdLFt6XHf5lGwkkr6eJofbhnCOZFrS4RDkDay8iZg6aC4
         08aBrpbFpinwdg67JRpPeOJAvp18AOQnH5zZRwgFGij28beaHO6lkjq+Q7WVjgPKxh59
         Zb0A==
X-Gm-Message-State: APjAAAX4xFtUQc44MP08I0DciSsCOpacdZTwVc1UHSyHTFLD70H6ORwn
        LC1Go8BxXhrw/POn/We8EstUixPwr5ZEI9UnaEjvr2aO
X-Google-Smtp-Source: APXvYqx5BRyf40CHiwguQhezyWwsG1IFJSveG/hX4xksVTSDmKRaL+d+qamCHKCJs4OlmkAd39hoErJ2w8JZ1fLIhtA=
X-Received: by 2002:a19:48d6:: with SMTP id v205mr3827658lfa.27.1571046140766;
 Mon, 14 Oct 2019 02:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191013154245.23538-1-9erthalion6@gmail.com> <9d4f1a2d-ac8a-7884-2aaf-0b611114e159@kernel.dk>
In-Reply-To: <9d4f1a2d-ac8a-7884-2aaf-0b611114e159@kernel.dk>
From:   Dmitry Dolgov <9erthalion6@gmail.com>
Date:   Mon, 14 Oct 2019 11:43:25 +0200
Message-ID: <CA+q6zcWaYxR+kvdfQUtog_MNUbs4gNjJD7XWCAhzpmaed8-k_Q@mail.gmail.com>
Subject: Re: [RFC v2] io_uring: add set of tracing events
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Sun, Oct 13, 2019 at 11:45 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> > diff --git a/fs/io_uring.c b/fs/io_uring.c
> > index bfbb7ab3c4e..730f7182b2a 100644
> > --- a/fs/io_uring.c
> > +++ b/fs/io_uring.c
> > @@ -71,6 +71,9 @@
> >   #include <linux/sizes.h>
> >   #include <linux/hugetlb.h>
> >
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/io_uring.h>
> > +
> >   #include <uapi/linux/io_uring.h>
> >
> >   #include "internal.h"
> > @@ -483,6 +486,7 @@ static inline void io_queue_async_work(struct io_ring_ctx *ctx,
> >               }
> >       }
> >
> > +     trace_io_uring_queue_async_work(ctx, rw, req, &req->work, req->flags);
> >       queue_work(ctx->sqo_wq[rw], &req->work);
> >   }
> >
> > @@ -707,6 +711,7 @@ static void io_fail_links(struct io_kiocb *req)
> >   {
> >       struct io_kiocb *link;
> >
> > +     trace_io_uring_fail_links(req);
> >       while (!list_empty(&req->link_list)) {
> >               link = list_first_entry(&req->link_list, struct io_kiocb, list);
> >               list_del(&link->list);
>
> Doesn't look like you have completion events, which makes it hard to
> tell which dependants got killed when failing the links. Maybe a good
> thing to add?

Do you mean an event like "this dependant got killed due to failing a link".
Yes, sounds useful.

> > @@ -1292,6 +1297,7 @@ static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
> >                                               iovec, iter);
> >   #endif
> >
> > +     trace_io_uring_import_iovec(ctx, buf);
> >       return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);
> >   }
> >
>
> Not sure I see much merrit in this trace event.

Yep. The original idea was to somehow expose the information about "not using"
ctx->user_bufs, but after playing around with this events, I see that this one
called more often as I thought, and probably just confusing.

> > @@ -2021,6 +2027,7 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
> >       req->submit.sqe = sqe_copy;
> >
> >       INIT_WORK(&req->work, io_sq_wq_submit_work);
> > +     trace_io_uring_defer(ctx, req, false);
> >       list_add_tail(&req->list, &ctx->defer_list);
> >       spin_unlock_irq(&ctx->completion_lock);
> >       return -EIOCBQUEUED;
> > @@ -2327,6 +2334,7 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
> >       } else {
> >               if (s->needs_fixed_file)
> >                       return -EBADF;
> > +             trace_io_uring_file_get(ctx, fd);
> >               req->file = io_file_get(state, fd);
> >               if (unlikely(!req->file))
> >                       return -EBADF;
> > @@ -2357,6 +2365,8 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
> >                               INIT_WORK(&req->work, io_sq_wq_submit_work);
> >                               io_queue_async_work(ctx, req);
> >                       }
> > +                     else
> > +                             trace_io_uring_add_to_prev(ctx, req);
> >
> >                       /*
> >                        * Queued up for async execution, worker will release
>
> Maybe put this one in io_add_to_prev_work()? Probably just using the
> 'ret' as part of the trace, to avoid a branch for this?

I thought about this, but then there will be no pointer to the context, and it
would be harder to figure out to what exactly this event corresponds to.

On the other hand we can track down the pointer to req, and then everything
should be clear. It involved a bit more efforts to analyze, but probably it
acceptable. So, I will indeed it move into io_add_to_prev_work.

> Failing that, the style is off a bit, should be:
>
>         } else {
>                 trace_io_uring_add_to_prev(ctx, req);
>         }
>
> > @@ -4194,6 +4210,9 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
> >       mutex_lock(&ctx->uring_lock);
> >       ret = __io_uring_register(ctx, opcode, arg, nr_args);
> >       mutex_unlock(&ctx->uring_lock);
> > +     if (ret >= 0)
> > +             trace_io_uring_register(ctx, opcode, ctx->nr_user_files,
> > +                                                             ctx->nr_user_bufs, ctx->cq_ev_fd != NULL);
>
> Just trace 'ret' as well?
> > + * io_uring_add_to_prev - called after a request was added into a previously
> > + *                                             submitted work
> > + *
> > + * @ctx:     pointer to a ring context structure
> > + * @req:     pointer to a request, added to a previous
> > + *
> > + * Allows to track merged work, to figure out how oftern requests are piggy
>
> often

Sure, will fix both typo and 'ret' tracing. Thanks for the comments!

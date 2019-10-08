Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE11C10F14
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 12:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9395B2196E
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 12:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDe4KAmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfJHMxX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:53:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33426 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfJHMxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 08:53:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so17423327ljd.0
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2019 05:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iI2O9V2GuLiQi4mqjQXQBKAidEX6x043O9hnn8TCN08=;
        b=BDe4KAmhFHDtt+LGp/mwyyL6zHv5c3gQMmrOk9+BNj80zyQ07fO/HCB2Tr0roRygFY
         tX2YJ/1B0ThiYTRjQGlwordU8bbvh++M0+aouUfOL2axf9qLwd6gudcMMwMR2d1+2Vdr
         Qy7g5klqXifxAbvfUm0lrqjvV0Tgek42njjRkjxjRVj3A4YFY16QFMl8aC3t/OlDsU/i
         EkCFGq25C6P6JTeTs/TE7t4VYQoyQ1EeEGHiB0FItcNN9yszIfjjScuRjJJgUHXYOoFv
         FdTUOFSAkQ0n6MLpTVGsocle+H+eGVoCIA2pf2jeU4cM09umZARFm2HBZEhx54L5Mc2o
         Icbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iI2O9V2GuLiQi4mqjQXQBKAidEX6x043O9hnn8TCN08=;
        b=Di8M6cnxUwFMoPDhDmiz8yq0OWOhizlV+nVWdXEwf6wEm1i5FLUfLNCdHe9AHb5sCP
         DJCMWZXOC9WXBzGTpyKU6aScSujyGWjtgyAsGraZXf/gUf7CBbqgrgSs3VWSaHf9w+nl
         NYbYnIt2GRaPhvFdfft6W4XT3/xuP4QngFFbcyxARBemzGuSIzGAdCOLPqAtzdObn3Jv
         hivWR2nyc3yXaCvfTTioQAfh+g/e8/oC7dB1BSQZse7lgnzUsTTnz1Y9ncR/yU4Tl05N
         Dx5Wby1Ow2Sc+j+ZG+6GpzckBB7JzTgPqW6KmSSColuJhLXpWF/WXAZCtmMQIWIKd86C
         k3RQ==
X-Gm-Message-State: APjAAAV97epMjxwUAoDFAK5KjiOfi9ia41wJ9KwAYHT1EKKN/tErPJI2
        p2MWJxJKiOU5paLld2n20+pZT6ObO8pW+tAUzez8pnSs
X-Google-Smtp-Source: APXvYqzLhh8XC02hqMJTuQsE7L1Va3ECxZ+FyhkEbja43SI76zpUIjVnkp+fm+7iMiC3p8QtCQmHobIBXoDRy2jfbZw=
X-Received: by 2002:a2e:7d0d:: with SMTP id y13mr22308780ljc.170.1570539200950;
 Tue, 08 Oct 2019 05:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191008125357.25265-1-9erthalion6@gmail.com>
In-Reply-To: <20191008125357.25265-1-9erthalion6@gmail.com>
From:   Dmitry Dolgov <9erthalion6@gmail.com>
Date:   Tue, 8 Oct 2019 14:54:21 +0200
Message-ID: <CA+q6zcX1EiFVR8W=2rcFdb3mSRC7D+bfV44UeL5VFAvy2FEdvw@mail.gmail.com>
Subject: Re: [RFC v1] io_uring: add io_uring_link trace event
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Tue, Oct 8, 2019 at 2:52 PM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> To trace io_uring activity one can get an information from workqueue and
> io trace events, but looks like some parts could be hard to identify.
> E.g. it's not easy to figure out that one work was started after another
> due to a link between them.
>
> For that purpose introduce io_uring_link trace event, that will be fired
> when a request is added to a link_list.
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>  fs/io_uring.c                   |  4 ++++
>  include/Kbuild                  |  1 +
>  include/trace/events/io_uring.h | 42 +++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
>  create mode 100644 include/trace/events/io_uring.h
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index bfbb7ab3c4e..63e4b592d69 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -71,6 +71,9 @@
>  #include <linux/sizes.h>
>  #include <linux/hugetlb.h>
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/io_uring.h>
> +
>  #include <uapi/linux/io_uring.h>
>
>  #include "internal.h"
> @@ -2488,6 +2491,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
>
>                 s->sqe = sqe_copy;
>                 memcpy(&req->submit, s, sizeof(*s));
> +               trace_io_uring_link(&req->work, &prev->work);
>                 list_add_tail(&req->list, &prev->link_list);
>         } else if (s->sqe->flags & IOSQE_IO_LINK) {
>                 req->flags |= REQ_F_LINK;
> diff --git a/include/Kbuild b/include/Kbuild
> index ffba79483cc..61b66725d25 100644
> --- a/include/Kbuild
> +++ b/include/Kbuild
> @@ -1028,6 +1028,7 @@ header-test-                      += trace/events/fsi_master_gpio.h
>  header-test-                   += trace/events/huge_memory.h
>  header-test-                   += trace/events/ib_mad.h
>  header-test-                   += trace/events/ib_umad.h
> +header-test-                   += trace/events/io_uring.h
>  header-test-                   += trace/events/iscsi.h
>  header-test-                   += trace/events/jbd2.h
>  header-test-                   += trace/events/kvm.h
> diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
> new file mode 100644
> index 00000000000..56245c31a1e
> --- /dev/null
> +++ b/include/trace/events/io_uring.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM io_uring
> +
> +#if !defined(_TRACE_IO_URING_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_IO_URING_H
> +
> +#include <linux/tracepoint.h>
> +
> +/**
> + * io_uring_link - called immediately before the io_uring work added into
> + *                                link_list of the another request.
> + * @work:                      pointer to linked struct work_struct
> + * @target_work:       pointer to previous struct work_struct,
> + *                                     that would contain @work
> + *
> + * Allows to track linked requests in io_uring.
> + */
> +TRACE_EVENT(io_uring_link,
> +
> +       TP_PROTO(struct work_struct *work, struct work_struct *target_work),
> +
> +       TP_ARGS(work, target_work),
> +
> +       TP_STRUCT__entry (
> +               __field(  void *,       work                    )
> +               __field(  void *,       target_work             )
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->work                   = work;
> +               __entry->target_work    = target_work;
> +       ),
> +
> +       TP_printk("io_uring work struct %p linked after %p",
> +                         __entry->work, __entry->target_work)
> +);
> +
> +#endif /* _TRACE_IO_URING_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> --
> 2.21.0
>

If I'm missing something and it doesn't make sense, then I would be glad to
hear if there are any best practices or ideas, and in general how to look at
io_uring from the tracing point of view.

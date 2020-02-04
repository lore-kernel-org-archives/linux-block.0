Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D26C3524B
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 18:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEE42087E
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 18:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHBqARzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgBDS0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:26:45 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40127 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgBDS0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Feb 2020 13:26:44 -0500
Received: by mail-il1-f195.google.com with SMTP id i7so16741973ilr.7
        for <linux-block@vger.kernel.org>; Tue, 04 Feb 2020 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXW19wXJC3hVKT8Q66ZK6uUNSfw5Qexl8aHI+Ttvtxs=;
        b=WHBqARzUWFjo+MMe3akW5up70rA/ST5BWP8DO296nQBjZJ4mNrYdyCelzTgqa3aDt1
         pUmZOE5j+5GS7tEjY22hT/hcjlyEI/hBQgEMbEX9bUDk+/TU68QF8NQky2ZwkjT3ouio
         kEREvuPj90Q9fkwac5nGf/66rjfMk0ANG1/jPZeIOaccvYa6k6SkfRJYD5Jro35nOB21
         CtR2qo1S5SudrdMHwsvJXklMjL34qvYuvfSZC9Ry1cGLb/QWeJhuJq6kzgugG7sMLhEC
         vdZyg2mcdBnYCsc5O7qDg53GB0OT9qIN44HTAefcAaSzCBYikoEu/pL0UnDZVEIh23g4
         vPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXW19wXJC3hVKT8Q66ZK6uUNSfw5Qexl8aHI+Ttvtxs=;
        b=Wy6Za40UUb523h9HtV35s2KZqM7n04ILxxNH1bSmXpwMlzGCPMV+/grnFFUHHWWpaS
         ZCO9yvFfe0gT/2uxS4o1WSndoseEho5+abNONqzFwEeQFcZDo4Z8JMzwPzCjTSrH/ytK
         4BDQd5nFHhqLdxOu7pZKB/S/PnkSjb7FPZ1j/OqCqqZoDr2jY6IA48u21Eg6uFRIR2c0
         kcKW9h6IlmB7ucMh282s3s8W0t96/1ydzsYlz9SXAW0UBRXUi2c7xj4RqHAfomd5bIIX
         dIsYKhWkmUxg4l5rXrGDTZ33zXn0iIJV/g4i+OF5VreZeueG4oV3r6M3stZcww4OY2QA
         3f4Q==
X-Gm-Message-State: APjAAAXSOJbyFog4kFwBGYPEeRhU+fyIxLLicTzl0O0PvA/slWa2bdO3
        iisRM/yoIu36TXLPhJ+DgxjjukGuOPU+EBLdtCG62g==
X-Google-Smtp-Source: APXvYqyWlZJUlxQ2VY87YbQcTXag2pqAuJZii8aCl5eXc/BIwIavBIBZoHQXyGZml0g66L+XiREwrBzGWy5ET7lYbYQ=
X-Received: by 2002:a05:6e02:df2:: with SMTP id m18mr28041600ilj.56.1580840801910;
 Tue, 04 Feb 2020 10:26:41 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8U03G27b6E7Z6mBo6RB=D7bKS_MQPwexEZiA7SOt_Lyvw@mail.gmail.com>
 <20200203205950.127629-1-sqazi@google.com> <20200204092004.GB19922@ming.t460p>
In-Reply-To: <20200204092004.GB19922@ming.t460p>
From:   Salman Qazi <sqazi@google.com>
Date:   Tue, 4 Feb 2020 10:26:29 -0800
Message-ID: <CAKUOC8Xvxa8nixstFOdjuf7_sCZNV6EqSDxTAQZjLhvf86LESA@mail.gmail.com>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 4, 2020 at 1:20 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Feb 03, 2020 at 12:59:50PM -0800, Salman Qazi wrote:
> > We observed that it is possible for a flush to bypass the I/O
> > scheduler and get added to hctx->dispatch in blk_mq_sched_bypass_insert.
>
> We always bypass io scheduler for flush request.
>
> > This can happen while a kworker is running blk_mq_do_dispatch_sched call
> > in blk_mq_sched_dispatch_requests.
> >
> > However, the blk_mq_do_dispatch_sched call doesn't end in bounded time.
> > As a result, the flush can sit there indefinitely, as the I/O scheduler
> > feeds an arbitrary number of requests to the hardware.
>
> blk-mq supposes to handle requests in hctx->dispatch with higher
> priority, see blk_mq_sched_dispatch_requests().
>
> However, there is single hctx->run_work, so async run queue for dispatching
> flush request can only be run until another async run queue from scheduler
> is done.
>
> >
> > The solution is to periodically poll hctx->dispatch in
> > blk_mq_do_dispatch_sched, to put a bound on the latency of the commands
> > sitting there.
> >
> > Signed-off-by: Salman Qazi <sqazi@google.com>
> > ---
> >  block/blk-mq-sched.c   |  6 ++++++
> >  block/blk-mq.c         |  4 ++++
> >  block/blk-sysfs.c      | 33 +++++++++++++++++++++++++++++++++
> >  include/linux/blkdev.h |  2 ++
> >  4 files changed, 45 insertions(+)
> >
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index ca22afd47b3d..75cdec64b9c7 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -90,6 +90,7 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >       struct request_queue *q = hctx->queue;
> >       struct elevator_queue *e = q->elevator;
> >       LIST_HEAD(rq_list);
> > +     int count = 0;
> >
> >       do {
> >               struct request *rq;
> > @@ -97,6 +98,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >               if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
> >                       break;
> >
> > +             if (count > 0 && count % q->max_sched_batch == 0 &&
> > +                 !list_empty_careful(&hctx->dispatch))
> > +                     break;
>
> q->max_sched_batch may not be needed, and it is reasonable to always
> disaptch requests in hctx->dispatch first.
>
> Also such trick is missed in dispatch from sw queue.

I will update the commit message, drop max_sched_batch and just turn
it into a simple check and add the same
thing to the dispatch from the sw queue.

>
>
> Thanks,
> Ming
>

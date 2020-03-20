Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88432C4332D
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 10:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E6220754
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 10:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6gPVTca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgCTK14 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:27:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43281 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTK14 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 06:27:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id u15so5524957lji.10;
        Fri, 20 Mar 2020 03:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KA3DiKpRKIX/hbeKWBTq21sCs+Gaeors/SyAmXeRfv4=;
        b=N6gPVTcaxf+LZ3KQQ/bJmpu6TqTAXApwtvY2LclvnHHoaZ2W0JUcgYnYcobV8XNNnR
         UxGz6ffD83wGq0bZMxIn8OjGJBYBF2Zj1jFY8D1taEdkQUqVAftGESvJbnImOrXC0MdO
         W4k04rw5tSwwGw3jfmXgtF7QvMBX7jOP4yg95vlBFVj5weckj/aauplZVuJPrnZ+y3n0
         oSSwlnfeLxb7VCbI5jMLgqm/o1QA6DSxejTaRTMIlFd9o20RrzaPM6UhFx/WRoRKrw95
         ay6OrS9s9UlMw8UPnfzDutaHcbLIG6+x1mWgtpQS4+ae4QLLlFmoBSyEJBgdgh4sJClx
         bXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KA3DiKpRKIX/hbeKWBTq21sCs+Gaeors/SyAmXeRfv4=;
        b=OLVXDWMIcNBLOXXx4cz4vQ7u1TVm2vCirr8PgatCFd2FLspZGY2fPbIR1I1Kzcf29y
         JpUK4d6toVvfJWJC7I37NJ+v28H2huevf+qaHZ/J865b6BfEwJStkU1t0hlwD7cnDNbM
         nie5RsDVsn7yHlpJSb1L4/3JEkr9j5pOwQN134GERDTVuzJ95Zq3vas4srazaD9hcGUA
         06Z6wn3GoU8r4mWh6Imqfxn9mctoFYwvijXg5qPwhB4mlrraFuBBV77at+EoIiepjoJ4
         RCsdPV7qhr+6SXEb5+gImsOImAnwr1oV5wFK3vTgcdrPvbC4DYQaetR1EJ8UFSmnBPkV
         WGNg==
X-Gm-Message-State: ANhLgQ0hIIdDbsbNfZqg5wWNkSWbmOeoq8K5/6BM3qTrvOOapVtjEaMA
        7N3/gGBQwIXiPeKi9v71bWOSR8z3ZyUdsCcgXw8=
X-Google-Smtp-Source: ADFU+vuSUyQ8WOefVEzO38JdXAY/d8OYzxzdExJWM/HjYE//93Jcm6La3bWKNaCR3TMAFyVA1H/VCxkOJsq79H6SiGA=
X-Received: by 2002:a2e:8059:: with SMTP id p25mr4907405ljg.196.1584700072626;
 Fri, 20 Mar 2020 03:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584350380.git.baolin.wang7@gmail.com> <c2e62e5a9942fb833dfc0cdc8c967a12f3c34b03.1584350380.git.baolin.wang7@gmail.com>
 <20200318100123.GA27531@ming.t460p> <CADBw62qbdpoyPZd+_np6f0L+83Ah8B218EYKmi8xiUbBf5c6+A@mail.gmail.com>
In-Reply-To: <CADBw62qbdpoyPZd+_np6f0L+83Ah8B218EYKmi8xiUbBf5c6+A@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 20 Mar 2020 18:27:41 +0800
Message-ID: <CADBw62rWWk=Jeg7=3nEBqK2prQjLzCGcFyJ+WkZ0D6_grcETHA@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 2/8] block: Allow sending a batch of requests
 from the scheduler to hardware
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, Paolo Valente <paolo.valente@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Wed, Mar 18, 2020 at 6:26 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Ming,
>
> On Wed, Mar 18, 2020 at 6:01 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Mar 16, 2020 at 06:01:19PM +0800, Baolin Wang wrote:
> > > As we know, some SD/MMC host controllers can support packed request,
> > > that means we can package several requests to host controller at one
> > > time to improve performence. So the hardware driver expects the blk-mq
> > > can dispatch a batch of requests at one time, and driver can use bd.last
> > > to indicate if it is the last request in the batch to help to combine
> > > requests as much as possible.
> > >
> > > Thus we should add batch requests setting from the block driver to tell
> > > the scheduler how many requests can be dispatched in a batch, as well
> > > as changing the scheduler to dispatch more than one request if setting
> > > the maximum batch requests number.
> > >
> >
> > I feel this batch dispatch style is more complicated, and some other
> > drivers(virtio blk/scsi) still may get benefit if we can pass real 'last' flag in
> > .queue_rq().
> >
> > So what about the following way by extending .commit_rqs() to this usage?
> > And you can do whatever batch processing in .commit_rqs() which will be
> > guaranteed to be called if BLK_MQ_F_FORCE_COMMIT_RQS is set by driver.
>
> I'm very appreciated for your good suggestion, which is much simpler than mine.
> It seems to solve my problem, and I will try it on my platform to see
> if it can work and give you the feadback. Thanks again.

I tried your approach on my platform, but met some problems, see below.

>
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 856356b1619e..cd2bbe56f83f 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -85,11 +85,12 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> >   * its queue by itself in its completion handler, so we don't need to
> >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> >   */
> > -static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > +static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  {
> >         struct request_queue *q = hctx->queue;
> >         struct elevator_queue *e = q->elevator;
> >         LIST_HEAD(rq_list);
> > +       bool ret = false;
> >
> >         do {
> >                 struct request *rq;
> > @@ -112,7 +113,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >                  * in blk_mq_dispatch_rq_list().
> >                  */
> >                 list_add(&rq->queuelist, &rq_list);
> > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > +       } while (ret);
> > +
> > +       return ret;
> >  }
> >
> >  static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > @@ -131,11 +135,12 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> >   * its queue by itself in its completion handler, so we don't need to
> >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> >   */
> > -static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > +static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> >  {
> >         struct request_queue *q = hctx->queue;
> >         LIST_HEAD(rq_list);
> >         struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
> > +       bool ret = false;
> >
> >         do {
> >                 struct request *rq;
> > @@ -161,10 +166,12 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> >
> >                 /* round robin for fair dispatch */
> >                 ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
> > -
> > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > +       } while (ret);
> >
> >         WRITE_ONCE(hctx->dispatch_from, ctx);
> > +
> > +       return ret;
> >  }
> >
> >  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > @@ -173,6 +180,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >         struct elevator_queue *e = q->elevator;
> >         const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> >         LIST_HEAD(rq_list);
> > +       bool dispatch_ret;
> >
> >         /* RCU or SRCU read lock is needed before checking quiesced flag */
> >         if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
> > @@ -206,20 +214,26 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >          */
> >         if (!list_empty(&rq_list)) {
> >                 blk_mq_sched_mark_restart_hctx(hctx);
> > -               if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
> > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> > +               if (dispatch_ret) {
> >                         if (has_sched_dispatch)
> > -                               blk_mq_do_dispatch_sched(hctx);
> > +                               dispatch_ret = blk_mq_do_dispatch_sched(hctx);

If we dispatched a request successfully by blk_mq_dispatch_rq_list(),
and got dispatch_ret = true now. Then we will try to dispatch more
reuqests from scheduler by blk_mq_do_dispatch_sched(), but if now no
more requests in scheduler, then we will got dispatch_ret = false. In
this case, we will not issue commit_rqs() to tell the hardware to
handle previous request dispatched from &rq_list.

So I think we should not overlap the 'dispatch_ret'? Or do you have
any other thoughts to fix?

> >                         else
> > -                               blk_mq_do_dispatch_ctx(hctx);
> > +                               dispatch_ret = blk_mq_do_dispatch_ctx(hctx);
> >                 }
> >         } else if (has_sched_dispatch) {
> > -               blk_mq_do_dispatch_sched(hctx);
> > +               dispatch_ret = blk_mq_do_dispatch_sched(hctx);
> >         } else if (hctx->dispatch_busy) {
> >                 /* dequeue request one by one from sw queue if queue is busy */
> > -               blk_mq_do_dispatch_ctx(hctx);
> > +               dispatch_ret = blk_mq_do_dispatch_ctx(hctx);
> >         } else {
> >                 blk_mq_flush_busy_ctxs(hctx, &rq_list);
> > -               blk_mq_dispatch_rq_list(q, &rq_list, false);
> > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> > +       }
> > +
> > +       if (dispatch_ret) {
> > +               if (hctx->flags & BLK_MQ_F_FORCE_COMMIT_RQS)
> > +                       hctx->queue->mq_ops->commit_rqs(hctx);
> >         }
> >  }
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 87c6699f35ae..9b46f5d6c7fd 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1238,11 +1238,15 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> >                  * Flag last if we have no more requests, or if we have more
> >                  * but can't assign a driver tag to it.
> >                  */
> > -               if (list_empty(list))
> > -                       bd.last = true;
> > -               else {
> > -                       nxt = list_first_entry(list, struct request, queuelist);
> > -                       bd.last = !blk_mq_get_driver_tag(nxt);
> > +               if (!(hctx->flags & BLK_MQ_F_FORCE_COMMIT_RQS)) {
> > +                       if (list_empty(list))
> > +                               bd.last = true;
> > +                       else {
> > +                               nxt = list_first_entry(list, struct request, queuelist);
> > +                               bd.last = !blk_mq_get_driver_tag(nxt);
> > +                       }
> > +               } else {
> > +                       bd.last = false;

If we enabled BLK_MQ_F_FORCE_COMMIT_RQS flag, we will always get
bd.last = false even for the real last request in the IO scheduler. I
know you already use commit_irqs() to help to kick driver. But I
worried if it is reasonable that drivers always get bd.last = false.

Thanks for your approach.

> >                 }
> >
> >                 ret = q->mq_ops->queue_rq(hctx, &bd);
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index 07fa767bff86..c0ef6990b698 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -394,6 +394,7 @@ enum {
> >         BLK_MQ_F_SHOULD_MERGE   = 1 << 0,
> >         BLK_MQ_F_TAG_SHARED     = 1 << 1,
> >         BLK_MQ_F_NO_MANAGED_IRQ = 1 << 2,
> > +       BLK_MQ_F_FORCE_COMMIT_RQS = 1 << 3,
> >         BLK_MQ_F_BLOCKING       = 1 << 5,
> >         BLK_MQ_F_NO_SCHED       = 1 << 6,
> >         BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
> >
> > Thanks,
> > Ming
> >
>
>
> --
> Baolin Wang



-- 
Baolin Wang

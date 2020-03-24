Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9C0C4332B
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C0F20724
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 08:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpB3aHNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCXI3W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:29:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42720 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgCXI3W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 04:29:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so17568475ljp.9;
        Tue, 24 Mar 2020 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WanFmU/IK3qVV8f5wqM3tzgw/bp29nR5GvIgKr2Y30g=;
        b=bpB3aHNnF9ZN8RBTBo2sdHIt1xFWu8TAhvRSdguOCUNmC154QgbaWKBr517UCbJwbl
         VEASd7WdHZG/FUBcNMpg9GryQCctSKe2pdzg2Jqj8jy4B72PIfG+ftLWNVYZbMT67M6s
         e7j53j3S5kwR/fngdQ+GTp0Fr7vBHLathKYpMTE9MaahD/saYdA5KorVJHYSp3J97SjX
         7diXl+Rf2DRikDv85Pk7HFrQ4S4+6p8ES2TRXlaqj3s+JFzZgIFNFIwgNCyKAIEqi6iY
         eKmGoHjhN8Imien6a+B/Ve7COsXRNyQmUiTxtNtRdqS1szpOJlxhEFLAMm9X3th63VUB
         t01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WanFmU/IK3qVV8f5wqM3tzgw/bp29nR5GvIgKr2Y30g=;
        b=qIWMZcZMDpLozGadvG4xulRBbm0U6/PXah8OLx7O5PHGcLXbdgi3LifgCQFEvF24Af
         YcjKBHJ2XQVMrDfx7ncFhDP4Wgt5nx/TQCIOyAOivMyWFNBMQKmvEV5RJQ397rzBbGxV
         w6muAjvrF3HXSTPuvQNSQmhZQpsHDhzjlAg22nu83DcmYyZLpQwKgj2jEq5JsWElvCro
         +mtRNaosLou2tSeUOBKRqXjeVl37VFhwLb8KqbBjiaIbQp2GP+uvPg4AiWlyjbSS7Izc
         G8sliJts7Em5nQ0ZdaLrSBffGnIvVmeOrHx73QTyBLQo0v0OUBYHtEXsfV+gMCj0JKWM
         pi0w==
X-Gm-Message-State: ANhLgQ3iRkUHtr/0E/+wwOm6dYxFP5GxwQjGDRS9f1kaP231I96P6nVB
        z8WlX+mSk3dc9ISZU0OQdjcYW7PGbTJs5Btl7kA=
X-Google-Smtp-Source: ADFU+vun1QkGhqf9PpVkRt/CYLx9uGVjRBMVPue6037MM5K6DbwGXDI/lMjKaILYtwAWCyGeC3PrDrH1N+LAE3Q8RwA=
X-Received: by 2002:a2e:9ad2:: with SMTP id p18mr16092394ljj.15.1585038558446;
 Tue, 24 Mar 2020 01:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <c2e62e5a9942fb833dfc0cdc8c967a12f3c34b03.1584350380.git.baolin.wang7@gmail.com>
 <20200318100123.GA27531@ming.t460p> <CADBw62qbdpoyPZd+_np6f0L+83Ah8B218EYKmi8xiUbBf5c6+A@mail.gmail.com>
 <CADBw62rWWk=Jeg7=3nEBqK2prQjLzCGcFyJ+WkZ0D6_grcETHA@mail.gmail.com>
 <20200323034432.GA27507@ming.t460p> <CADBw62rxFdriCSEo78M7_xnS3UiaDPN9CwURtiDOTxGVCevbsg@mail.gmail.com>
 <20200323072640.GA4767@ming.t460p> <CADBw62rDOUUpEdOKxoC3J5R=noSGMLzkJZjjjFa1Mv6J7FX_Aw@mail.gmail.com>
 <20200323082830.GB5616@ming.t460p> <CADBw62rd4Ro2VbfFZqev6ou7jY+sLtn6b9Z6HCcZAigHngj9Fw@mail.gmail.com>
 <20200323095806.GD5616@ming.t460p>
In-Reply-To: <20200323095806.GD5616@ming.t460p>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 24 Mar 2020 16:29:06 +0800
Message-ID: <CADBw62o5X_NpSjCWHL+-s9jDyAD4pp2bMRbo=vhuB4V2i2O8ag@mail.gmail.com>
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

On Mon, Mar 23, 2020 at 5:58 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Mar 23, 2020 at 05:13:27PM +0800, Baolin Wang wrote:
> > On Mon, Mar 23, 2020 at 4:29 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Mon, Mar 23, 2020 at 04:22:38PM +0800, Baolin Wang wrote:
> > > > On Mon, Mar 23, 2020 at 3:27 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > >
> > > > > On Mon, Mar 23, 2020 at 01:36:34PM +0800, Baolin Wang wrote:
> > > > > > On Mon, Mar 23, 2020 at 11:44 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Mar 20, 2020 at 06:27:41PM +0800, Baolin Wang wrote:
> > > > > > > > Hi Ming,
> > > > > > > >
> > > > > > > > On Wed, Mar 18, 2020 at 6:26 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Ming,
> > > > > > > > >
> > > > > > > > > On Wed, Mar 18, 2020 at 6:01 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Mar 16, 2020 at 06:01:19PM +0800, Baolin Wang wrote:
> > > > > > > > > > > As we know, some SD/MMC host controllers can support packed request,
> > > > > > > > > > > that means we can package several requests to host controller at one
> > > > > > > > > > > time to improve performence. So the hardware driver expects the blk-mq
> > > > > > > > > > > can dispatch a batch of requests at one time, and driver can use bd.last
> > > > > > > > > > > to indicate if it is the last request in the batch to help to combine
> > > > > > > > > > > requests as much as possible.
> > > > > > > > > > >
> > > > > > > > > > > Thus we should add batch requests setting from the block driver to tell
> > > > > > > > > > > the scheduler how many requests can be dispatched in a batch, as well
> > > > > > > > > > > as changing the scheduler to dispatch more than one request if setting
> > > > > > > > > > > the maximum batch requests number.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I feel this batch dispatch style is more complicated, and some other
> > > > > > > > > > drivers(virtio blk/scsi) still may get benefit if we can pass real 'last' flag in
> > > > > > > > > > .queue_rq().
> > > > > > > > > >
> > > > > > > > > > So what about the following way by extending .commit_rqs() to this usage?
> > > > > > > > > > And you can do whatever batch processing in .commit_rqs() which will be
> > > > > > > > > > guaranteed to be called if BLK_MQ_F_FORCE_COMMIT_RQS is set by driver.
> > > > > > > > >
> > > > > > > > > I'm very appreciated for your good suggestion, which is much simpler than mine.
> > > > > > > > > It seems to solve my problem, and I will try it on my platform to see
> > > > > > > > > if it can work and give you the feadback. Thanks again.
> > > > > > > >
> > > > > > > > I tried your approach on my platform, but met some problems, see below.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > > > > > > index 856356b1619e..cd2bbe56f83f 100644
> > > > > > > > > > --- a/block/blk-mq-sched.c
> > > > > > > > > > +++ b/block/blk-mq-sched.c
> > > > > > > > > > @@ -85,11 +85,12 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > >   * its queue by itself in its completion handler, so we don't need to
> > > > > > > > > >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> > > > > > > > > >   */
> > > > > > > > > > -static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > +static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > >  {
> > > > > > > > > >         struct request_queue *q = hctx->queue;
> > > > > > > > > >         struct elevator_queue *e = q->elevator;
> > > > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > > > > +       bool ret = false;
> > > > > > > > > >
> > > > > > > > > >         do {
> > > > > > > > > >                 struct request *rq;
> > > > > > > > > > @@ -112,7 +113,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > >                  * in blk_mq_dispatch_rq_list().
> > > > > > > > > >                  */
> > > > > > > > > >                 list_add(&rq->queuelist, &rq_list);
> > > > > > > > > > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > > > > > > > > > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > > > > > > > > > +       } while (ret);
> > > > > > > > > > +
> > > > > > > > > > +       return ret;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > > > > > > > > > @@ -131,11 +135,12 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > > > > > > > > >   * its queue by itself in its completion handler, so we don't need to
> > > > > > > > > >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> > > > > > > > > >   */
> > > > > > > > > > -static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > +static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > >  {
> > > > > > > > > >         struct request_queue *q = hctx->queue;
> > > > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > > > >         struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
> > > > > > > > > > +       bool ret = false;
> > > > > > > > > >
> > > > > > > > > >         do {
> > > > > > > > > >                 struct request *rq;
> > > > > > > > > > @@ -161,10 +166,12 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > >
> > > > > > > > > >                 /* round robin for fair dispatch */
> > > > > > > > > >                 ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
> > > > > > > > > > -
> > > > > > > > > > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > > > > > > > > > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > > > > > > > > > +       } while (ret);
> > > > > > > > > >
> > > > > > > > > >         WRITE_ONCE(hctx->dispatch_from, ctx);
> > > > > > > > > > +
> > > > > > > > > > +       return ret;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > @@ -173,6 +180,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > >         struct elevator_queue *e = q->elevator;
> > > > > > > > > >         const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> > > > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > > > > +       bool dispatch_ret;
> > > > > > > > > >
> > > > > > > > > >         /* RCU or SRCU read lock is needed before checking quiesced flag */
> > > > > > > > > >         if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
> > > > > > > > > > @@ -206,20 +214,26 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > >          */
> > > > > > > > > >         if (!list_empty(&rq_list)) {
> > > > > > > > > >                 blk_mq_sched_mark_restart_hctx(hctx);
> > > > > > > > > > -               if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
> > > > > > > > > > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> > > > > > > > > > +               if (dispatch_ret) {
> > > > > > > > > >                         if (has_sched_dispatch)
> > > > > > > > > > -                               blk_mq_do_dispatch_sched(hctx);
> > > > > > > > > > +                               dispatch_ret = blk_mq_do_dispatch_sched(hctx);
> > > > > > > >
> > > > > > > > If we dispatched a request successfully by blk_mq_dispatch_rq_list(),
> > > > > > > > and got dispatch_ret = true now. Then we will try to dispatch more
> > > > > > > > reuqests from scheduler by blk_mq_do_dispatch_sched(), but if now no
> > > > > > > > more requests in scheduler, then we will got dispatch_ret = false. In
> > > > > > >
> > > > > > > 'dispatch_ret' always holds result of the last blk_mq_do_dispatch_sched().
> > > > > > > When any one request has been dispatched successfully, 'dispatch_ret'
> > > > > > > is true. New request is always added to list before calling
> > > > > > > blk_mq_do_dispatch_sched(), so once blk_mq_do_dispatch_sched() returns
> > > > > > > false, it means that .commit_rqs() has been called.
> > > > > >
> > > > > > Not really, if no requests int the IO cheduler, we will break the loop
> > > > > > in blk_mq_do_dispatch_sched() and return false without calling
> > > > > > .commit_rqs().
> > > > >
> > > > > If there isn't any request to dispatch, false is returned. Otherwise,
> > > > > always return the return value of last 'blk_mq_dispatch_rq_list'.
> > > > >
> > > > > >
> > > > > > So in this case, blk_mq_do_dispatch_sched() will return 'false', which
> > > > > > overlapped the return value of 'true' from blk_mq_dispatch_rq_list(),
> > > > > > and did not call .commit_rqs(). Then the IO processing will be stuck.
> > > > >
> > > > > See below.
> > > > >
> > > > > >
> > > > > > static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > {
> > > > > >         struct request_queue *q = hctx->queue;
> > > > > >         struct elevator_queue *e = q->elevator;
> > > > > >         LIST_HEAD(rq_list);
> > > > > >         bool ret = false;
> > > > >
> > > > > The above initialization is just done once.
> > > > >
> > > > > >
> > > > > >        do {
> > > > > >               struct request *rq;
> > > > > >
> > > > > >               if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
> > > > > >                      break;
> > > > > >
> > > > > >               .......
> > > > >                             ret = blk_mq_dispatch_rq_list(q, list, ...);
> > > > >
> > > > > list includes one request, so blk_mq_dispatch_rq_list() won't return
> > > > > false in case of no request in list.
> > > > >
> > > > > >        } while (ret);
> > > > > >
> > > > > >        return ret;
> > > > >
> > > > > 'ret' is always updated by return value of last blk_mq_dispatch_rq_list()
> > > > > if at least one request is dispatched. So if it becomes false, the loop
> > > > > breaks, that means .commit_rqs() has been called cause 'list' does
> > > > > include one request for blk_mq_dispatch_rq_list(). Otherwise, true is
> > > > > still returned.
> > > >
> > > > Sorry for my confusing description, let me try again to describe the problem.
> > > > When I try to mount the block device, I got the IO stuck with your
> > > > patch, and I did some debugging. I found we missed calling
> > > > commit_rqs() for one case:
> > > >
> > > > void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > @@ -173,6 +180,7 @@ void blk_mq_sched_dispatch_requests(struct
> > > > blk_mq_hw_ctx *hctx)
> > > >         struct elevator_queue *e = q->elevator;
> > > >         const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> > > >         LIST_HEAD(rq_list);
> > > > +       bool dispatch_ret;
> > > >
> > > >         /* RCU or SRCU read lock is needed before checking quiesced flag */
> > > >         if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
> > > > @@ -206,20 +214,26 @@ void blk_mq_sched_dispatch_requests(struct
> > > > blk_mq_hw_ctx *hctx)
> > > >          */
> > > >         if (!list_empty(&rq_list)) {
> > > >                 blk_mq_sched_mark_restart_hctx(hctx);
> > > > -               if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
> > > > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> > > >
> > > > Suppose we dispatch one request to block driver, and return 'true' here.
> > > >
> > > > +               if (dispatch_ret) {
> > > >                         if (has_sched_dispatch)
> > > > -                               blk_mq_do_dispatch_sched(hctx);
> > > > +                               dispatch_ret = blk_mq_do_dispatch_sched(hctx);
> > > >
> > > > Then we will continue to try to dispatch more requests from IO
> > > > scheduler, but if there are no requests in IO scheduler now, it will
> > > > return 'false' here, and set dispatch_ret as false.
> > > >
> > > >                         else
> > > > -                               blk_mq_do_dispatch_ctx(hctx);
> > > > +                               dispatch_ret = blk_mq_do_dispatch_ctx(hctx);
> > >
> > > OK, this one is an issue, but it can be fixed simply by not updating
> > > 'dispatch_ret' for the following dispatch, something like the below
> > > way:
> > >
> > >         if (dispatch_ret) {
> > >                 if (has_sched_dispatch)
> > >                         blk_mq_do_dispatch_sched(hctx);
> > >                 else
> > >                         blk_mq_do_dispatch_ctx(hctx);
> > >         }
> >
> > Yes, this can work.
> >
> > But I found your patch will drop some performance comparing with my
> > method in patch 1/2. My method can fetch several requests from IO
> > scheduler and dispatch them to block driver at one time, but in your
> > patch we still need dispatch request one by one, which will drop some
> > performance I think.
> > What do you think? Thanks.
>
> Please run your test and see if performance drop can be observed.

From my testing (using the same fio configuration in cover letter), I
found your method will drop some performance from below data.

My original patches:
Sequential read: 229.6MiB/s
Random read:180.8MiB/s
Sequential write: 172MiB/s
Random write:169.2MiB/s

Your patches:
Sequential read: 209MiB/s
Random read:177MiB/s
Sequential write: 148MiB/s
Random write:147MiB/s

-- 
Baolin Wang

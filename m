Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D065C55189
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 09:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A2320735
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 09:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBjAj5ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDVJ2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgDVJ2R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 05:28:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7B9C03C1A8;
        Wed, 22 Apr 2020 02:28:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b2so1519354ljp.4;
        Wed, 22 Apr 2020 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmcPTBblJNOUppUFrtzjBzt0XoUjGN8XL20sHA/Jeic=;
        b=lBjAj5ouReOY6xRS1RsrDlvb+Lzk/LrHgLHfDDF5EMjlZFkXypvmWidbmBFPLbpDv4
         nVPscQCzPwuLHI3+y3H1sHiHGPIdwJjeO5ORIZKxj8TpfdrnoQvYWoAnlTnEzGS6lXyX
         MMIexZXhDQCMEOmzfy2oyMUeulEI3BnEuveK8Np2m4Pe36/q1WA2mNo6xZqgQwPBC/LM
         1CP70/h7BMmG3AzY7BaLaVMEwVlnF8+i5FzigOKkLthV8gW2J+M/XCNv5ZmKPonS7eh7
         4lxE70YY9skX22lEf/Bt7kNBbILBNGrDMRsEX/mhMP5I31E5vqxQtdRuYquR99ABn+ll
         jETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmcPTBblJNOUppUFrtzjBzt0XoUjGN8XL20sHA/Jeic=;
        b=m7dki42hvE9yZs0HPNOlX+yLiFltazHKy39Dty/K2ydiRog8iLTkzqtvBCuWjgWbDT
         TdtClIYQ/BB4czXeT6AQwyZPrBEKE5/vIbfMgKokvdz9oMxvMSiuAO6fDPmufu6VU1sm
         l9ylV9CgwolMcz4koecE39ljehAG4t9oukv5kXvoIjFP00FjVgMi6UuPyJGPwuUrR6dl
         PhcxgDxNbT9U4bYm00OQKEAvTzZ3drqPtem9jseKjr9ekBCSrZN5Hp4BO14RenFuIAFI
         mHr8UtijQvDdCAEgjSQv+3Rb7GGZE1jvI+kqQnJz4aG19Wq6VMjEagh9NunqeOZSDCSI
         1GGg==
X-Gm-Message-State: AGi0PuYa4kI0MFf/n+RxgCiwwOulb9cQCEzhztH6yckBYu6rALqXIta8
        OkTQmAJsglcKJxtAsJ6gB8nBfkGh9qYKRnq6MaY=
X-Google-Smtp-Source: APiQypKaurywloyUcxANs98EykY+atsV2UsAXGDCCf1hXoVNycLqwI+FuV9Ghwqo3grCq+W0GoJTOgrkuLsWD/YvHkg=
X-Received: by 2002:a05:651c:2011:: with SMTP id s17mr13576526ljo.242.1587547695275;
 Wed, 22 Apr 2020 02:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200323034432.GA27507@ming.t460p> <CADBw62rxFdriCSEo78M7_xnS3UiaDPN9CwURtiDOTxGVCevbsg@mail.gmail.com>
 <20200323072640.GA4767@ming.t460p> <CADBw62rDOUUpEdOKxoC3J5R=noSGMLzkJZjjjFa1Mv6J7FX_Aw@mail.gmail.com>
 <20200323082830.GB5616@ming.t460p> <CADBw62rd4Ro2VbfFZqev6ou7jY+sLtn6b9Z6HCcZAigHngj9Fw@mail.gmail.com>
 <20200323095806.GD5616@ming.t460p> <CADBw62o5X_NpSjCWHL+-s9jDyAD4pp2bMRbo=vhuB4V2i2O8ag@mail.gmail.com>
 <CADBw62rZ4h80y_98kpd4p=cVfmo1hjKpANqgDUQ6sABQrFpz3g@mail.gmail.com>
 <CADBw62pjh3YWpNYcO-nyF0f7tVLqyBdHSx+siW7LvM8pESXX0w@mail.gmail.com> <20200422092556.GG299948@T590>
In-Reply-To: <20200422092556.GG299948@T590>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 22 Apr 2020 17:28:04 +0800
Message-ID: <CADBw62pFOEiPtFjnfOFkCuJCCi_AQ0i11iNjr5TKs4PoLDWdcg@mail.gmail.com>
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

On Wed, Apr 22, 2020 at 5:26 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Wed, Apr 22, 2020 at 05:21:01PM +0800, Baolin Wang wrote:
> > Hi Ming,
> >
> > On Fri, Mar 27, 2020 at 4:30 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > Hi Ming,
> > >
> > > On Tue, Mar 24, 2020 at 4:29 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > >
> > > > Hi Ming,
> > > >
> > > > On Mon, Mar 23, 2020 at 5:58 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > >
> > > > > On Mon, Mar 23, 2020 at 05:13:27PM +0800, Baolin Wang wrote:
> > > > > > On Mon, Mar 23, 2020 at 4:29 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Mar 23, 2020 at 04:22:38PM +0800, Baolin Wang wrote:
> > > > > > > > On Mon, Mar 23, 2020 at 3:27 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Mar 23, 2020 at 01:36:34PM +0800, Baolin Wang wrote:
> > > > > > > > > > On Mon, Mar 23, 2020 at 11:44 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Mar 20, 2020 at 06:27:41PM +0800, Baolin Wang wrote:
> > > > > > > > > > > > Hi Ming,
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Mar 18, 2020 at 6:26 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Ming,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, Mar 18, 2020 at 6:01 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Mon, Mar 16, 2020 at 06:01:19PM +0800, Baolin Wang wrote:
> > > > > > > > > > > > > > > As we know, some SD/MMC host controllers can support packed request,
> > > > > > > > > > > > > > > that means we can package several requests to host controller at one
> > > > > > > > > > > > > > > time to improve performence. So the hardware driver expects the blk-mq
> > > > > > > > > > > > > > > can dispatch a batch of requests at one time, and driver can use bd.last
> > > > > > > > > > > > > > > to indicate if it is the last request in the batch to help to combine
> > > > > > > > > > > > > > > requests as much as possible.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thus we should add batch requests setting from the block driver to tell
> > > > > > > > > > > > > > > the scheduler how many requests can be dispatched in a batch, as well
> > > > > > > > > > > > > > > as changing the scheduler to dispatch more than one request if setting
> > > > > > > > > > > > > > > the maximum batch requests number.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I feel this batch dispatch style is more complicated, and some other
> > > > > > > > > > > > > > drivers(virtio blk/scsi) still may get benefit if we can pass real 'last' flag in
> > > > > > > > > > > > > > .queue_rq().
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So what about the following way by extending .commit_rqs() to this usage?
> > > > > > > > > > > > > > And you can do whatever batch processing in .commit_rqs() which will be
> > > > > > > > > > > > > > guaranteed to be called if BLK_MQ_F_FORCE_COMMIT_RQS is set by driver.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm very appreciated for your good suggestion, which is much simpler than mine.
> > > > > > > > > > > > > It seems to solve my problem, and I will try it on my platform to see
> > > > > > > > > > > > > if it can work and give you the feadback. Thanks again.
> > > > > > > > > > > >
> > > > > > > > > > > > I tried your approach on my platform, but met some problems, see below.
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > > > > > > > > > > index 856356b1619e..cd2bbe56f83f 100644
> > > > > > > > > > > > > > --- a/block/blk-mq-sched.c
> > > > > > > > > > > > > > +++ b/block/blk-mq-sched.c
> > > > > > > > > > > > > > @@ -85,11 +85,12 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > > > > >   * its queue by itself in its completion handler, so we don't need to
> > > > > > > > > > > > > >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> > > > > > > > > > > > > >   */
> > > > > > > > > > > > > > -static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > > > > > +static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > > > > >  {
> > > > > > > > > > > > > >         struct request_queue *q = hctx->queue;
> > > > > > > > > > > > > >         struct elevator_queue *e = q->elevator;
> > > > > > > > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > > > > > > > > +       bool ret = false;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >         do {
> > > > > > > > > > > > > >                 struct request *rq;
> > > > > > > > > > > > > > @@ -112,7 +113,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > > > > >                  * in blk_mq_dispatch_rq_list().
> > > > > > > > > > > > > >                  */
> > > > > > > > > > > > > >                 list_add(&rq->queuelist, &rq_list);
> > > > > > > > > > > > > > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > > > > > > > > > > > > > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > > > > > > > > > > > > > +       } while (ret);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +       return ret;
> > > > > > > > > > > > > >  }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >  static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > > > > > > > > > > > > > @@ -131,11 +135,12 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > > > > > > > > > > > > >   * its queue by itself in its completion handler, so we don't need to
> > > > > > > > > > > > > >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> > > > > > > > > > > > > >   */
> > > > > > > > > > > > > > -static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > > > > > +static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > > > > >  {
> > > > > > > > > > > > > >         struct request_queue *q = hctx->queue;
> > > > > > > > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > > > > > > > >         struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
> > > > > > > > > > > > > > +       bool ret = false;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >         do {
> > > > > > > > > > > > > >                 struct request *rq;
> > > > > > > > > > > > > > @@ -161,10 +166,12 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >                 /* round robin for fair dispatch */
> > > > > > > > > > > > > >                 ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
> > > > > > > > > > > > > > -
> > > > > > > > > > > > > > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > > > > > > > > > > > > > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > > > > > > > > > > > > > +       } while (ret);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >         WRITE_ONCE(hctx->dispatch_from, ctx);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +       return ret;
> > > > > > > > > > > > > >  }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > > > > > @@ -173,6 +180,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > > > > >         struct elevator_queue *e = q->elevator;
> > > > > > > > > > > > > >         const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> > > > > > > > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > > > > > > > > +       bool dispatch_ret;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >         /* RCU or SRCU read lock is needed before checking quiesced flag */
> > > > > > > > > > > > > >         if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
> > > > > > > > > > > > > > @@ -206,20 +214,26 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > > > > >          */
> > > > > > > > > > > > > >         if (!list_empty(&rq_list)) {
> > > > > > > > > > > > > >                 blk_mq_sched_mark_restart_hctx(hctx);
> > > > > > > > > > > > > > -               if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
> > > > > > > > > > > > > > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> > > > > > > > > > > > > > +               if (dispatch_ret) {
> > > > > > > > > > > > > >                         if (has_sched_dispatch)
> > > > > > > > > > > > > > -                               blk_mq_do_dispatch_sched(hctx);
> > > > > > > > > > > > > > +                               dispatch_ret = blk_mq_do_dispatch_sched(hctx);
> > > > > > > > > > > >
> > > > > > > > > > > > If we dispatched a request successfully by blk_mq_dispatch_rq_list(),
> > > > > > > > > > > > and got dispatch_ret = true now. Then we will try to dispatch more
> > > > > > > > > > > > reuqests from scheduler by blk_mq_do_dispatch_sched(), but if now no
> > > > > > > > > > > > more requests in scheduler, then we will got dispatch_ret = false. In
> > > > > > > > > > >
> > > > > > > > > > > 'dispatch_ret' always holds result of the last blk_mq_do_dispatch_sched().
> > > > > > > > > > > When any one request has been dispatched successfully, 'dispatch_ret'
> > > > > > > > > > > is true. New request is always added to list before calling
> > > > > > > > > > > blk_mq_do_dispatch_sched(), so once blk_mq_do_dispatch_sched() returns
> > > > > > > > > > > false, it means that .commit_rqs() has been called.
> > > > > > > > > >
> > > > > > > > > > Not really, if no requests int the IO cheduler, we will break the loop
> > > > > > > > > > in blk_mq_do_dispatch_sched() and return false without calling
> > > > > > > > > > .commit_rqs().
> > > > > > > > >
> > > > > > > > > If there isn't any request to dispatch, false is returned. Otherwise,
> > > > > > > > > always return the return value of last 'blk_mq_dispatch_rq_list'.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > So in this case, blk_mq_do_dispatch_sched() will return 'false', which
> > > > > > > > > > overlapped the return value of 'true' from blk_mq_dispatch_rq_list(),
> > > > > > > > > > and did not call .commit_rqs(). Then the IO processing will be stuck.
> > > > > > > > >
> > > > > > > > > See below.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > > > > > {
> > > > > > > > > >         struct request_queue *q = hctx->queue;
> > > > > > > > > >         struct elevator_queue *e = q->elevator;
> > > > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > > > >         bool ret = false;
> > > > > > > > >
> > > > > > > > > The above initialization is just done once.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >        do {
> > > > > > > > > >               struct request *rq;
> > > > > > > > > >
> > > > > > > > > >               if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
> > > > > > > > > >                      break;
> > > > > > > > > >
> > > > > > > > > >               .......
> > > > > > > > >                             ret = blk_mq_dispatch_rq_list(q, list, ...);
> > > > > > > > >
> > > > > > > > > list includes one request, so blk_mq_dispatch_rq_list() won't return
> > > > > > > > > false in case of no request in list.
> > > > > > > > >
> > > > > > > > > >        } while (ret);
> > > > > > > > > >
> > > > > > > > > >        return ret;
> > > > > > > > >
> > > > > > > > > 'ret' is always updated by return value of last blk_mq_dispatch_rq_list()
> > > > > > > > > if at least one request is dispatched. So if it becomes false, the loop
> > > > > > > > > breaks, that means .commit_rqs() has been called cause 'list' does
> > > > > > > > > include one request for blk_mq_dispatch_rq_list(). Otherwise, true is
> > > > > > > > > still returned.
> > > > > > > >
> > > > > > > > Sorry for my confusing description, let me try again to describe the problem.
> > > > > > > > When I try to mount the block device, I got the IO stuck with your
> > > > > > > > patch, and I did some debugging. I found we missed calling
> > > > > > > > commit_rqs() for one case:
> > > > > > > >
> > > > > > > > void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > > > > @@ -173,6 +180,7 @@ void blk_mq_sched_dispatch_requests(struct
> > > > > > > > blk_mq_hw_ctx *hctx)
> > > > > > > >         struct elevator_queue *e = q->elevator;
> > > > > > > >         const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > > +       bool dispatch_ret;
> > > > > > > >
> > > > > > > >         /* RCU or SRCU read lock is needed before checking quiesced flag */
> > > > > > > >         if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
> > > > > > > > @@ -206,20 +214,26 @@ void blk_mq_sched_dispatch_requests(struct
> > > > > > > > blk_mq_hw_ctx *hctx)
> > > > > > > >          */
> > > > > > > >         if (!list_empty(&rq_list)) {
> > > > > > > >                 blk_mq_sched_mark_restart_hctx(hctx);
> > > > > > > > -               if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
> > > > > > > > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> > > > > > > >
> > > > > > > > Suppose we dispatch one request to block driver, and return 'true' here.
> > > > > > > >
> > > > > > > > +               if (dispatch_ret) {
> > > > > > > >                         if (has_sched_dispatch)
> > > > > > > > -                               blk_mq_do_dispatch_sched(hctx);
> > > > > > > > +                               dispatch_ret = blk_mq_do_dispatch_sched(hctx);
> > > > > > > >
> > > > > > > > Then we will continue to try to dispatch more requests from IO
> > > > > > > > scheduler, but if there are no requests in IO scheduler now, it will
> > > > > > > > return 'false' here, and set dispatch_ret as false.
> > > > > > > >
> > > > > > > >                         else
> > > > > > > > -                               blk_mq_do_dispatch_ctx(hctx);
> > > > > > > > +                               dispatch_ret = blk_mq_do_dispatch_ctx(hctx);
> > > > > > >
> > > > > > > OK, this one is an issue, but it can be fixed simply by not updating
> > > > > > > 'dispatch_ret' for the following dispatch, something like the below
> > > > > > > way:
> > > > > > >
> > > > > > >         if (dispatch_ret) {
> > > > > > >                 if (has_sched_dispatch)
> > > > > > >                         blk_mq_do_dispatch_sched(hctx);
> > > > > > >                 else
> > > > > > >                         blk_mq_do_dispatch_ctx(hctx);
> > > > > > >         }
> > > > > >
> > > > > > Yes, this can work.
> > > > > >
> > > > > > But I found your patch will drop some performance comparing with my
> > > > > > method in patch 1/2. My method can fetch several requests from IO
> > > > > > scheduler and dispatch them to block driver at one time, but in your
> > > > > > patch we still need dispatch request one by one, which will drop some
> > > > > > performance I think.
> > > > > > What do you think? Thanks.
> > > > >
> > > > > Please run your test and see if performance drop can be observed.
> > > >
> > > > From my testing (using the same fio configuration in cover letter), I
> > > > found your method will drop some performance from below data.
> > > >
> > > > My original patches:
> > > > Sequential read: 229.6MiB/s
> > > > Random read:180.8MiB/s
> > > > Sequential write: 172MiB/s
> > > > Random write:169.2MiB/s
> > > >
> > > > Your patches:
> > > > Sequential read: 209MiB/s
> > > > Random read:177MiB/s
> > > > Sequential write: 148MiB/s
> > > > Random write:147MiB/s
> > >
> > > After some optimiziton and I did more testing, I did not found any
> > > performance issue with your patch comparing with my old method. Sorry
> > > for noise in my last email.
> > >
> > > So will you send out a formal patch? If yes, please add my test-by
> > > tag. Thanks for your help.
> > > Tested-by: Baolin Wang <baolin.wang7@gmail.com>
> >
> > Can I take this patch into my patch set with your authority? Or you
> > want to send it out by yourself? Thanks.
>
> Hi Baolin,
>
> You can fold the patch into your series.

OK. Much thanks for your help.

-- 
Baolin Wang

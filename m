Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D89C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 07:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21582073F
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 07:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YexOT8YM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfK0Htf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:49:35 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41335 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfK0Htf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 02:49:35 -0500
Received: by mail-qv1-f65.google.com with SMTP id g18so8476409qvp.8;
        Tue, 26 Nov 2019 23:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URBhL8PpZl6y4mPSJi9+JN8TebUxyY96sXs5n6EYQtw=;
        b=YexOT8YMMQw8h5ujb5PDiPou7uGp++YsZwMVbYaywb0rTYURRCcaEaWoxFiTRCE4ri
         9HisL3m07ojTE74p9ZAgeV+Z4RjennzrFncRNbrOo34GzZyIFXtvslCZiA/VRdKv0sm4
         LMrUKgmZi64Gn8u0HXqlJWFYJNYxwOsfDcKlbDYyrS4KvsynHh+llNL6G7RAzNV/JukB
         D7W6JOGgk7MFlb6Yxw1dQw0KtuJDINl3fsegOitBgEpxIJ7pnR9v3V746sFU9uHPpS4k
         BDcEuKdN0BBXbyQfoaZx3WxEO8DWjw29irWDEPMW11DfODj1J7oY7oq9zjR0a0O/V4yQ
         nQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URBhL8PpZl6y4mPSJi9+JN8TebUxyY96sXs5n6EYQtw=;
        b=ZmYf34AC92JhzzqWJuevjEdcQnORwLWghU/r93x7XiXW5i3XQGEquzHYGHhnEGBtg5
         jJTtAKLLzHx4yW7NM2/4Flb2YODBh3DgaLDD/3AgfAh3jZGrpbwBwXWwiCIVdSnYm/Jm
         ne5ktLC1dvvbRO/tEjCJ7tGKNTNr4W5eF1xvuVdOgpoPn4/O5SpiSuaFiWxjQb1jBeuo
         815zcN2Vj+7OqPc73CiddSX/i2RAPsl9yQYRDPyLhEMxeSKai+ar+73c9XjcheSgxK1x
         SFfopFYu6VRddJvylU413BuKETO5D1lJJZ0HklD2qglc5ZFq4JPTBdGbatj+sKV4TTTL
         g7SA==
X-Gm-Message-State: APjAAAVVsCZM+RocKLrc6f7y5aiJxjp2wCHgcz0wfHREZBEFygy4zLAL
        eU0RJe592ydMoSBgDpR47NIar8pHMmiWDZw0+pw=
X-Google-Smtp-Source: APXvYqyquwPZMtnggXp1IYxzTVF7MXCTCZ4RMSPiY+woHrAp1dOaJEgDXlOXDjonP8eNOweO2LA7lGiE3vqFdbSqM+k=
X-Received: by 2002:ad4:558c:: with SMTP id e12mr3303406qvx.191.1574840973438;
 Tue, 26 Nov 2019 23:49:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com> <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de>
In-Reply-To: <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 27 Nov 2019 15:49:20 +0800
Message-ID: <CADBw62o83ePHoveo1uKEbakQ+_i3-LLyJ22H0XEU11OqW88dOQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Hannes Reinecke <hare@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 26, 2019 at 7:17 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 11/22/19 10:50 AM, Arnd Bergmann wrote:
> > (adding Paolo as well, maybe he has some more insights)
> >
> > On Mon, Nov 18, 2019 at 11:04 AM (Exiting) Baolin Wang
> > <baolin.wang@linaro.org> wrote:
> >> On Tue, 12 Nov 2019 at 16:48, Baolin Wang <baolin.wang7@gmail.com> wrote:
> >>> On Tue, Nov 12, 2019 at 12:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >>>> On Mon, Nov 11, 2019 at 1:58 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> >>>>>> - With that change in place calling a blocking __mmc_claim_host() is
> >>>>>>   still a problem, so there should still be a nonblocking mmc_try_claim_host()
> >>>>>>   for the submission path, leading to a BLK_STS_DEV_RESOURCE (?)
> >>>>>>   return code from mmc_mq_queue_rq(). Basically mmc_mq_queue_rq()
> >>>>>>   should always return right away, either after having queued the next I/O
> >>>>>>   or with an error, but not waiting for the device in any way.
> >>>>>
> >>>>> Actually not only the mmc_claim_host() will block the MMC request
> >>>>> processing, in this routine, the mmc_blk_part_switch() and
> >>>>> mmc_retune() can also block the request processing. Moreover the part
> >>>>> switching and tuning should be sync operations, and we can not move
> >>>>> them to a work or a thread.
> >>>>
> >>>> Ok, I see.
> >>>>
> >>>> Those would also cause requests to be sent to the device or the host
> >>>> controller, right? Maybe we can treat them as "a non-IO request
> >>>
> >>> Right.
> >>>
> >>>> has successfully been queued to the device" events, returning
> >>>> busy from the mmc_mq_queue_rq() function and then running
> >>>> the queue again when they complete?
> >>>
> >>> Yes, seems reasonable to me.
> >>>
> >>>>
> >>>>>> - For the packed requests, there is apparently a very simple way to implement
> >>>>>>   that without a software queue: mmc_mq_queue_rq() is allowed to look at
> >>>>>>   and dequeue all requests that are currently part of the request_queue,
> >>>>>>   so it should take out as many as it wants to submit at once and send
> >>>>>>   them all down to the driver together, avoiding the need for any further
> >>>>>>   round-trips to blk_mq or maintaining a queue in mmc.
> >>>>>
> >>>>> You mean we can dispatch a request directly from
> >>>>> elevator->type->ops.dispatch_request()?  but we still need some helper
> >>>>> functions to check if these requests can be packed (the package
> >>>>> condition), and need to invent new APIs to start a packed request (or
> >>>>> using cqe interfaces, which means we still need to implement some cqe
> >>>>> callbacks).
> >>>>
> >>>> I don't know how the dispatch_request() function fits in there,
> >>>> what Hannes told me is that in ->queue_rq() you can always
> >>>> look at the following requests that are already queued up
> >>>> and take the next ones off the list. Looking at bd->last
> >>>> tells you if there are additional requests. If there are, you can
> >>>> look at the next one from blk_mq_hw_ctx (not sure how, but
> >>>> should not be hard to find)
> >>>>
> >>>> I also see that there is a commit_rqs() callback that may
> >>>> go along with queue_rq(), implementing that one could make
> >>>> this easier as well.
> >>>
> >>> Yes, we can use queue_rq()/commit_rqs() and bd->last (now bd->last may
> >>> can not work well, see [1]), but like we talked before, for packed
> >>> request, we still need some new interfaces (for example, a interface
> >>> used to start a packed request, and a interface used to complete a
> >>> packed request), but at last we got a consensus that we should re-use
> >>> the CQE interfaces instead of new invention.
> >>>
> >>> [1] https://lore.kernel.org/patchwork/patch/1102897/
> >>>
> >>>>
> >>>>>> - The DMA management (bounce buffer, map, unmap) that is currently
> >>>>>>   done in mmc_blk_mq_issue_rq() should ideally be done in the
> >>>>>>   init_request()/exit_request()  (?) callbacks from mmc_mq_ops so this
> >>>>>>   can be done asynchronously, out of the critical timing path for the
> >>>>>>   submission. With this, there won't be any need for a software queue.
> >>>>>
> >>>>> This is not true, now the blk-mq will allocate some static request
> >>>>> objects (usually the static requests number should be the same with
> >>>>> the hardware queue depth) saved in struct blk_mq_tags. So the
> >>>>> init_request() is used to initialize the static requests when
> >>>>> allocating them, and call exit_request to free the static requests
> >>>>> when freeing the 'struct blk_mq_tags', such as the queue is dead. So
> >>>>> we can not move the DMA management into the init_request/exit_request.
> >>>>
> >>>> Ok, I must have misremembered which callback that is then, but I guess
> >>>> there is some other place to do it.
> >>>
> >>> I checked the 'struct blk_mq_ops', and I did not find a ops can be
> >>> used to do DMA management. And I also checked UFS driver, it also did
> >>> the DMA mapping in the queue_rq() (scsi_queue_rq() --->
> >>> ufshcd_queuecommand() ---> ufshcd_map_sg()). Maybe I missed something?
> >>>
> >>> Moreover like I said above, for the packed request, we still need
> >>> implement something (like the software queue) based on the CQE
> >>> interfaces to help to handle packed requests.
> >>
> >> After some investigation and offline discussion with you, I still have
> >> some concerns about your suggestion.
> >>
> >> 1) Now blk-mq have not supplied some ops to prepare a request, which is
> >> used to do some DMA management asynchronously. But yes, we can
> >> introduce new ops for blk-mq. But there are still some remaining
> >> preparation in mmc_mq_queue_rq(), like mmc part switch. For software
> >> queue, we can prepare a request totally after issuing one.
> >
> > I suppose to make the submission non-blocking, all operations that
> > currently block in the submission path may have to be changed first.
> >
> > For the case of a partition switch (same for retune), I suppose
> > something like this can be done:
> >
> > - in queue_rq() check whether a partition switch is needed. If not,
> >   submit the current rq
> > - if a partition switch is needed, submit the partition switch cmd
> >   instead, and return busy status
> > - when the completion arrives for the partition switch, call back into
> >   blk_mq to have it call queue_rq again.
> >
> > Or possibly even (this might not be possible without signifcant
> > restructuring):
> >
> > - when preparing a request that would require a partition switch,
> >   insert another meta-request to switch the partition ahead of it.
> >
> > I do realize that this is a significant departure from how it was done
> > in the past, but it seems cleaner that way to me.
> >
> I would be treating the partition issue separate from the queued/batched
> submission.
>
> Aligning with the 'traditional' linux way for partition handling is
> definitely the way to go IMO; otherwise you'll end up having to worry
> about resource allocation between distinct queues (like you have to do
> now), and will be having a hard time trying to map it properly to the
> underlying hardware abstraction in blk-mq.
>
> For starters I would keep a partition marker in the driver instance, and
> calculate the parition for each incoming request. If the partition is
> different you'll have to insert a partition switch request before
> submitting the actual one.
>
> To do this efficiently it would be good to know if:
> a) How invasive is the partition switch? Would it be feasible to eg add
> a partition switch for every command? This might sound daft now, but if
> we get request batching going it might not the _that_ expensive after all...

This is expensive I think, now not all SD host controllers or cards
can handle batching request, only for those which can support ADMA3 or
packed command.

> b) Can the request switch command batched together with the normal
> command? IE is is possible to have them both send in one go?

I do not think that the switch command can be batched together with
the normal command. We must wait for the completion of the switch
command before sending the normal command. It should be the SYNC
command in MMC stack.

I think the first method suggested by Arnd can work.

> If so it would make life _so_ much easier; we could submit both command
> at the same time, and won't have to worry about handling internal
> completions ...
>
> >> 2) I wonder if it is appropriate that using the irq threaded context
> >> to dispatch next request, actually we will still introduce a context
> >> switch here. Now we will complete a request in the hard irq handler
> >> and kick the softirq to do time-consuming operations, like DMA
> >> unmapping , and will start next request in the hard irq handler
> >> without context switch. Moreover if we remove the BLK_MQ_F_BLOCKING in
> >> future like you suggested, then we can remove all context switch. And
> >> I think we can dispatch next request in the softirq context (actually
> >> the CQE already did).
> >
> > I hope Hannes (or someone else) can comment here, as I don't
> > know exactly what his objection to kicking off the next cmd in the
> > hardirq was.
> >
> The point being that you'll have to have a context switch anyway
> (between hardirq and softirq), and you'll be able to better handle
> recovery as the hardirq handler is pretty generic and the won't be any
> chance of that one becoming stuck.
> And, of course, modern software design :-)
>
> > I think generally, deferring all slow operations to an irqthread
> > rather than a softirq is a good idea, but I share your concern that
> > this can introduce an unnecessary latency between the the
> > the IRQ is signaled and the time the following cmd is sent to the
> > hardware.
> > > Doing everything in a single (irqthread) context is clearly simpler,
> > so this would need to be measured carefully to avoid unnecessary
> > complexity, but I think don't see anything stopping us from having
> > the fast-path where the low-level driver first checks for any possible
> > error conditions in hardirq context and the fires off a prepared cmd
> > right away whenever it can before triggering the irqthread that does
> > everything else. I think this has to be a per-driver optimization, so
> > the common case would just have an irqthread.
> >
> >> 3) For packed request support, I did not see an example that block
> >> driver can dispatch a request from the IO scheduler in queue_rq() and
> >> no APIs supported from blk-mq. And we do not know where can dispatch a
> >> request in queue_rq(), from IO scheduler? from ctx? or from
> >> hctx->dispatch list? and if this request can not be passed to host
> >> now, how to do it? Seems lots of complicated things.
> >
> > The only way I can see is the ->last flag, so if blk_mq submits multiple
> > requests in a row to queue_rq() with this flag cleared and  calls
> > ->commit_rqs() after the last one. This seems to be what the scsi
> > disk driver and the nvme driver rely on, and we should be able to use
> > it the same way for packed cmds, by checking each time in queue_rq()
> > whether requests can/should be combined and reporting busy otherwise
> > (after preparing a combined mmc cmd).
> > blk_mq will then call commit_rqs, which should do the actual submission
> > to the hardware driver.
> >
> The ->last flag really depends on the submission thread, eg if something
> in the upper layers is using on-stack plugging.
> In my experience this is done only in some specific use-cases resp.
> filesystems, so this is not something you can rely on to make any decisions.

The on-stack plugging is enabled in my case, and from the commit
message of introducing this structure, the ->last flag is used to
indicate the last request in the chain, but seems work abnormally.

"Since we have the notion of a 'last' request in a chain, we can use
    this to have the hardware optimize the issuing of requests. Add
    a list_head parameter to queue_rq that the driver can use to
    temporarily store hw commands for issue when 'last' is true. If we
    are doing a chain of requests, pass in a NULL list for the first
    request to force issue of that immediately, then batch the remainder
    for deferred issue until the last request has been sent."

>
> > Now as you point out, the *big* problem with this is that we never
> > get multiple requests together in practice, i.e. the last flag is almost
> > always set, and any optimization around it has no effect.
> >
> See above. I don't think the using the ->last flag is the way to go here.
> What you really need to do here is to inject some 'pushback' into the
> block layer so that is has a _chance_ of assembling more requests.

How about Arnd's suggestion? looks reasonable to me that we can have a
new API to handle batching request.
https://paste.ubuntu.com/p/MfSRwKqFCs/

>
> But the actual design really needs to take hardware features into account.
>
> As mentioned above, initially I would concentrate on getting the
> partitioning working with a single request queue; once that is done we
> can look at request batching proper.

OK.

>
> And for that you could have a look at the S/390 DASD driver (right,
> Arndt?), which has a very similar concept.

Yes, I've looked at the dasd.c driver, and it used a list to link
requests from blk-mq and handled them with a tasklet, but if this will
cause a long latency if we linked more requests into the list and
dispatched them to the controller slowly?

Thanks for your input.

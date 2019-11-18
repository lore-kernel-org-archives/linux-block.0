Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD0C432C3
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 10:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816E820726
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 10:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oq8tqJYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKRKEm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:04:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40175 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfKRKEm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 05:04:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2so18211640ljg.7
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 02:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hvo5Jw2ZPltQxjs8EbPFo5GfrTv0JS2zLabE1PRBYSA=;
        b=oq8tqJYkfKe496OYK6xiqh34OBWXU0P4avcI3PB3Q3yP2DcUkJJSknYUHlJH1Kn+7k
         WXmL59zHOEQjEnnEmOZgh1QANDUtRlmMMgVV8zGtA9GvJWIDsslUgDbPxDPLr0c1wouR
         5/0PDzIGGOigv4KRLUZyiDzQc3uAYmKUrioGNkeUaJAdt9hKqqbpPGOVGQQFKlPR9GHV
         ItN5qxhnylTOqQbVme4r8bTkSjo5SL8tZMKKZY6kB9uaGu3heWvQznD6QlBLIVQ3268s
         4XjB/k8uphuXBrNS0hJFcXp2ka8A3Q1NNS9X5HIrnZvbESVc04fwVqw+DIQBU2/ELCWF
         Hm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hvo5Jw2ZPltQxjs8EbPFo5GfrTv0JS2zLabE1PRBYSA=;
        b=PuCb9tdR0rdMdI60siFXEf+t57zpzn+Fk9zcW4x8QD/ybkW42oDFpcmXciE6SOIcY+
         tQPuIrf05EtgscDw5nsLP/B42GTbBwLFzYZSqeiYoBdykHa22/vQGEtUZMrMKqUdpPkf
         cY3JO2epdwSYpv2tUHO4ir5Jp3pZoTy9rpB3T3I0hm/Luq3+a0z63zquMu/bFvE3PNFa
         jYeXptRT6UruuCASds4uK6rb5aDQf1KWQzN5GzYQBjKSFe5gcM9cCZDFRPiTy/wjt5Ve
         Lo3F5L7lDPmHiOrHrVZIPNWYHw9SOy3OZqAh0lPHfHWX/pksnTzYSkzAVqpxJrBuR44N
         JxNg==
X-Gm-Message-State: APjAAAVIVomf2ziWLKvL7tPomxLRJ5MT4vlotN0fR7Ny/AomwJQKlQD4
        WOlgidjPszA+AXQnw0EDeY698BohIrmXW7n0mnOQGw==
X-Google-Smtp-Source: APXvYqy0O9Jadnrt9tHT9GICqum5MrN5gCfPfY0FAkpKeg1hArL8l4mtLws1lK2/t3y2iHRL0SevYjWooLN8kbqbA/Y=
X-Received: by 2002:a2e:9104:: with SMTP id m4mr6254727ljg.63.1574071479813;
 Mon, 18 Nov 2019 02:04:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com> <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
In-Reply-To: <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
From:   "(Exiting) Baolin Wang" <baolin.wang@linaro.org>
Date:   Mon, 18 Nov 2019 18:04:28 +0800
Message-ID: <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Arnd,

On Tue, 12 Nov 2019 at 16:48, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 12:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Nov 11, 2019 at 1:58 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > On Mon, 11 Nov 2019 at 17:28, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Mon, Nov 11, 2019 at 8:35 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > - Removing all the context switches and workqueues from the data submission
> > > >   path is also the right idea. As you found, there is still a workqueue inside
> > > >   of blk_mq that is used because it may get called from atomic context but
> > > >   the submission may get blocked in __mmc_claim_host(). This really
> > > >   needs to be changed as well, but not in the way I originally suggested:
> > > >   As Hannes suggested, the host interrrupt handler should always use
> > > >   request_threaded_irq() to have its own process context, and then pass a
> > > >   flag to blk_mq to say that we never need another workqueue there.
> > >
> > > So you mean we should complete the request in the host driver irq
> > > thread context, then issue another request in this context by calling
> > > blk_mq_run_hw_queues()?
> >
> > Yes. I assumed there was already code that would always run
> > blk_mq_run_hw_queue() at I/O completion, but I can't find where
> > that happens today.
>
> OK. Now we will complete a request in block softirq, which means the
> irq thread of host driver should call blk_mq_complete_request() to
> complete this request (triggering the block softirq) and call
> blk_mq_run_hw_queues() to dispatch another request in this context.
>
> >
> > As I understand, the main difference to today is that
> > __blk_mq_delay_run_hw_queue() can call into __blk_mq_run_hw_queue
> > directly rather than using the delayed work queue once we
> > can skip the BLK_MQ_F_BLOCKING check.
>
> Right. Need to improve this as you suggested.
>
> >
> > > > - With that change in place calling a blocking __mmc_claim_host() is
> > > >   still a problem, so there should still be a nonblocking mmc_try_claim_host()
> > > >   for the submission path, leading to a BLK_STS_DEV_RESOURCE (?)
> > > >   return code from mmc_mq_queue_rq(). Basically mmc_mq_queue_rq()
> > > >   should always return right away, either after having queued the next I/O
> > > >   or with an error, but not waiting for the device in any way.
> > >
> > > Actually not only the mmc_claim_host() will block the MMC request
> > > processing, in this routine, the mmc_blk_part_switch() and
> > > mmc_retune() can also block the request processing. Moreover the part
> > > switching and tuning should be sync operations, and we can not move
> > > them to a work or a thread.
> >
> > Ok, I see.
> >
> > Those would also cause requests to be sent to the device or the host
> > controller, right? Maybe we can treat them as "a non-IO request
>
> Right.
>
> > has successfully been queued to the device" events, returning
> > busy from the mmc_mq_queue_rq() function and then running
> > the queue again when they complete?
>
> Yes, seems reasonable to me.
>
> >
> > > > - For the packed requests, there is apparently a very simple way to implement
> > > >   that without a software queue: mmc_mq_queue_rq() is allowed to look at
> > > >   and dequeue all requests that are currently part of the request_queue,
> > > >   so it should take out as many as it wants to submit at once and send
> > > >   them all down to the driver together, avoiding the need for any further
> > > >   round-trips to blk_mq or maintaining a queue in mmc.
> > >
> > > You mean we can dispatch a request directly from
> > > elevator->type->ops.dispatch_request()?  but we still need some helper
> > > functions to check if these requests can be packed (the package
> > > condition), and need to invent new APIs to start a packed request (or
> > > using cqe interfaces, which means we still need to implement some cqe
> > > callbacks).
> >
> > I don't know how the dispatch_request() function fits in there,
> > what Hannes told me is that in ->queue_rq() you can always
> > look at the following requests that are already queued up
> > and take the next ones off the list. Looking at bd->last
> > tells you if there are additional requests. If there are, you can
> > look at the next one from blk_mq_hw_ctx (not sure how, but
> > should not be hard to find)
> >
> > I also see that there is a commit_rqs() callback that may
> > go along with queue_rq(), implementing that one could make
> > this easier as well.
>
> Yes, we can use queue_rq()/commit_rqs() and bd->last (now bd->last may
> can not work well, see [1]), but like we talked before, for packed
> request, we still need some new interfaces (for example, a interface
> used to start a packed request, and a interface used to complete a
> packed request), but at last we got a consensus that we should re-use
> the CQE interfaces instead of new invention.
>
> [1] https://lore.kernel.org/patchwork/patch/1102897/
>
> >
> > > > - The DMA management (bounce buffer, map, unmap) that is currently
> > > >   done in mmc_blk_mq_issue_rq() should ideally be done in the
> > > >   init_request()/exit_request()  (?) callbacks from mmc_mq_ops so this
> > > >   can be done asynchronously, out of the critical timing path for the
> > > >   submission. With this, there won't be any need for a software queue.
> > >
> > > This is not true, now the blk-mq will allocate some static request
> > > objects (usually the static requests number should be the same with
> > > the hardware queue depth) saved in struct blk_mq_tags. So the
> > > init_request() is used to initialize the static requests when
> > > allocating them, and call exit_request to free the static requests
> > > when freeing the 'struct blk_mq_tags', such as the queue is dead. So
> > > we can not move the DMA management into the init_request/exit_request.
> >
> > Ok, I must have misremembered which callback that is then, but I guess
> > there is some other place to do it.
>
> I checked the 'struct blk_mq_ops', and I did not find a ops can be
> used to do DMA management. And I also checked UFS driver, it also did
> the DMA mapping in the queue_rq() (scsi_queue_rq() --->
> ufshcd_queuecommand() ---> ufshcd_map_sg()). Maybe I missed something?
>
> Moreover like I said above, for the packed request, we still need
> implement something (like the software queue) based on the CQE
> interfaces to help to handle packed requests.

After some investigation and offline discussion with you, I still have
some concerns about your suggestion.

1) Now blk-mq have not supplied some ops to prepare a request, which is
used to do some DMA management asynchronously. But yes, we can
introduce new ops for blk-mq. But there are still some remaining
preparation in mmc_mq_queue_rq(), like mmc part switch. For software
queue, we can prepare a request totally after issuing one.

2) I wonder if it is appropriate that using the irq threaded context
to dispatch next request, actually we will still introduce a context
switch here. Now we will complete a request in the hard irq handler
and kick the softirq to do time-consuming operations, like DMA
unmapping , and will start next request in the hard irq handler
without context switch. Moreover if we remove the BLK_MQ_F_BLOCKING in
future like you suggested, then we can remove all context switch. And
I think we can dispatch next request in the softirq context (actually
the CQE already did).

3) For packed request support, I did not see an example that block
driver can dispatch a request from the IO scheduler in queue_rq() and
no APIs supported from blk-mq. And we do not know where can dispatch a
request in queue_rq(), from IO scheduler? from ctx? or from
hctx->dispatch list? and if this request can not be passed to host
now, how to do it? Seems lots of complicated things.

Moreover, we still need some interfaces for the packed request
handling, from previous discussion, we still need something like MMC
software queue based on  the CQE to help to handle the packed request.

So I think I still need to introduce the MMC software queue, on the one
hand is that it can really improve the performance from fio data and
avoid a long latency, on the other hand we can expand it to support
packed request easily in future. Thanks.

(Anyway I will still post the V7 to address Adrian's comments and to
see if we can get a consensus there).

-- 
Baolin Wang
Best Regards

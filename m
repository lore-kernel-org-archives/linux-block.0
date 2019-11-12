Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A4C43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 08:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911EB2196E
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 08:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve3lo0ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfKLIso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:48:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41371 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfKLIso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 03:48:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id o3so18915935qtj.8;
        Tue, 12 Nov 2019 00:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYpmcMMqlT0yk3qneW+aFmnPdVZOuZEw3kSyEOhlztI=;
        b=Ve3lo0jiYJa14s3msCDNn9GhL6p/qKWcyhW9L+uj13YuJJlTSxLB583XojGwXpWMVX
         BxDYQmKB9eLD/KgpQ8HLXRWKnKCjVts5VltLViERwCLdtfj7LUpeJw8gs/I8xnagawgk
         pM3wV73ZyPXWeAofuphgsR2zz0l7rkMVrsDENGkaPeDJ5NePysvrsSB7CzFJLEc7dV5T
         vRrn8jN94HYtx7Mb3Lo6eIkJco/RH6MLAB3NwFHzy1uTG7e1437GbPtex6eMTqViYBve
         p9wPF6636QeHTweuImCwMIDOWiCNF8NKgoeAp58dradBoy40ebKmg1ocub1suSEA9Gv/
         AQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYpmcMMqlT0yk3qneW+aFmnPdVZOuZEw3kSyEOhlztI=;
        b=MkoV2ERSNxGzHG6Lw0Mkm+mHe/96Jp/uETqSBjP8rQcpQCSqxFlAY77fYmT3aecAQB
         IIaY3lMm+DUgOsoMXdV4clo2QOhhupaw+i9Dq28Q0jnduLvD2DFIK5YGe2AD4+xg1IQc
         l6LzTzV9VBUW900LxqE2XIm4giQe8l6w6n3Arvk/BkJWGJuanQ8Ht36aj8+j5WyLt1JW
         zogFFdDig9I5hIZ6yENClH7JEk39pjCKRpXy7kLSLpJvoaN56kKtCkmj4VVKCXS94XJf
         fvkF8dkacKhLooi1oT3jMuOypN6/aPUTmV1WjuL/oHvkgNgJ7x1nKCkvm8P5c944FDpi
         fIQQ==
X-Gm-Message-State: APjAAAUq7EMXqjn6Gvcr7cdDtTI/0vK4XhC++aOd0sbKA9aW0plpENqm
        ILljsSKXOwNLFhMGuV4GFM0b0ILXoy8QGoy2Usc=
X-Google-Smtp-Source: APXvYqxkp1jFnexlebfbXASIu1U5hQGAC2jxZMUc41DFcbrEOVmcUn50Kgp0PNnoln36L7QiwSNYKH+uzN6b9fxwlkM=
X-Received: by 2002:ac8:28c7:: with SMTP id j7mr32051234qtj.4.1573548522730;
 Tue, 12 Nov 2019 00:48:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com> <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
In-Reply-To: <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 12 Nov 2019 16:48:30 +0800
Message-ID: <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
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

On Tue, Nov 12, 2019 at 12:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Nov 11, 2019 at 1:58 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Mon, 11 Nov 2019 at 17:28, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Nov 11, 2019 at 8:35 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > - Removing all the context switches and workqueues from the data submission
> > >   path is also the right idea. As you found, there is still a workqueue inside
> > >   of blk_mq that is used because it may get called from atomic context but
> > >   the submission may get blocked in __mmc_claim_host(). This really
> > >   needs to be changed as well, but not in the way I originally suggested:
> > >   As Hannes suggested, the host interrrupt handler should always use
> > >   request_threaded_irq() to have its own process context, and then pass a
> > >   flag to blk_mq to say that we never need another workqueue there.
> >
> > So you mean we should complete the request in the host driver irq
> > thread context, then issue another request in this context by calling
> > blk_mq_run_hw_queues()?
>
> Yes. I assumed there was already code that would always run
> blk_mq_run_hw_queue() at I/O completion, but I can't find where
> that happens today.

OK. Now we will complete a request in block softirq, which means the
irq thread of host driver should call blk_mq_complete_request() to
complete this request (triggering the block softirq) and call
blk_mq_run_hw_queues() to dispatch another request in this context.

>
> As I understand, the main difference to today is that
> __blk_mq_delay_run_hw_queue() can call into __blk_mq_run_hw_queue
> directly rather than using the delayed work queue once we
> can skip the BLK_MQ_F_BLOCKING check.

Right. Need to improve this as you suggested.

>
> > > - With that change in place calling a blocking __mmc_claim_host() is
> > >   still a problem, so there should still be a nonblocking mmc_try_claim_host()
> > >   for the submission path, leading to a BLK_STS_DEV_RESOURCE (?)
> > >   return code from mmc_mq_queue_rq(). Basically mmc_mq_queue_rq()
> > >   should always return right away, either after having queued the next I/O
> > >   or with an error, but not waiting for the device in any way.
> >
> > Actually not only the mmc_claim_host() will block the MMC request
> > processing, in this routine, the mmc_blk_part_switch() and
> > mmc_retune() can also block the request processing. Moreover the part
> > switching and tuning should be sync operations, and we can not move
> > them to a work or a thread.
>
> Ok, I see.
>
> Those would also cause requests to be sent to the device or the host
> controller, right? Maybe we can treat them as "a non-IO request

Right.

> has successfully been queued to the device" events, returning
> busy from the mmc_mq_queue_rq() function and then running
> the queue again when they complete?

Yes, seems reasonable to me.

>
> > > - For the packed requests, there is apparently a very simple way to implement
> > >   that without a software queue: mmc_mq_queue_rq() is allowed to look at
> > >   and dequeue all requests that are currently part of the request_queue,
> > >   so it should take out as many as it wants to submit at once and send
> > >   them all down to the driver together, avoiding the need for any further
> > >   round-trips to blk_mq or maintaining a queue in mmc.
> >
> > You mean we can dispatch a request directly from
> > elevator->type->ops.dispatch_request()?  but we still need some helper
> > functions to check if these requests can be packed (the package
> > condition), and need to invent new APIs to start a packed request (or
> > using cqe interfaces, which means we still need to implement some cqe
> > callbacks).
>
> I don't know how the dispatch_request() function fits in there,
> what Hannes told me is that in ->queue_rq() you can always
> look at the following requests that are already queued up
> and take the next ones off the list. Looking at bd->last
> tells you if there are additional requests. If there are, you can
> look at the next one from blk_mq_hw_ctx (not sure how, but
> should not be hard to find)
>
> I also see that there is a commit_rqs() callback that may
> go along with queue_rq(), implementing that one could make
> this easier as well.

Yes, we can use queue_rq()/commit_rqs() and bd->last (now bd->last may
can not work well, see [1]), but like we talked before, for packed
request, we still need some new interfaces (for example, a interface
used to start a packed request, and a interface used to complete a
packed request), but at last we got a consensus that we should re-use
the CQE interfaces instead of new invention.

[1] https://lore.kernel.org/patchwork/patch/1102897/

>
> > > - The DMA management (bounce buffer, map, unmap) that is currently
> > >   done in mmc_blk_mq_issue_rq() should ideally be done in the
> > >   init_request()/exit_request()  (?) callbacks from mmc_mq_ops so this
> > >   can be done asynchronously, out of the critical timing path for the
> > >   submission. With this, there won't be any need for a software queue.
> >
> > This is not true, now the blk-mq will allocate some static request
> > objects (usually the static requests number should be the same with
> > the hardware queue depth) saved in struct blk_mq_tags. So the
> > init_request() is used to initialize the static requests when
> > allocating them, and call exit_request to free the static requests
> > when freeing the 'struct blk_mq_tags', such as the queue is dead. So
> > we can not move the DMA management into the init_request/exit_request.
>
> Ok, I must have misremembered which callback that is then, but I guess
> there is some other place to do it.

I checked the 'struct blk_mq_ops', and I did not find a ops can be
used to do DMA management. And I also checked UFS driver, it also did
the DMA mapping in the queue_rq() (scsi_queue_rq() --->
ufshcd_queuecommand() ---> ufshcd_map_sg()). Maybe I missed something?

Moreover like I said above, for the packed request, we still need
implement something (like the software queue) based on the CQE
interfaces to help to handle packed requests.

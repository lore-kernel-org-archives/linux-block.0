Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E523BC43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 16:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EA120679
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 16:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKKQ7Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:59:24 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:53627 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfKKQ7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 11:59:24 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MKsaz-1iBJdX1Vmv-00LIvc; Mon, 11 Nov 2019 17:59:22 +0100
Received: by mail-qt1-f169.google.com with SMTP id r20so2301401qtp.13;
        Mon, 11 Nov 2019 08:59:22 -0800 (PST)
X-Gm-Message-State: APjAAAWzh2rNG7Ir5NiGDXSmuzJYgBAbjIfK1wxowWcPQnzP8lp2wNxq
        huKlawMpl6uEb8mB/XxWU0WPSqxrdlkXs3Ixjoc=
X-Google-Smtp-Source: APXvYqwdpCREOtyE93H9Pt1lAWwTPnjT7PbL4Gw+dA+pJFVEH9MO3ijOUHhBfbs9wSdqzXpcqYACk9InxetZ/cZN4Ss=
X-Received: by 2002:ac8:1908:: with SMTP id t8mr26432376qtj.18.1573491561034;
 Mon, 11 Nov 2019 08:59:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
In-Reply-To: <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 17:59:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
Message-ID: <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        baolin.wang7@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qgSgaiHikjIpEOImULQPeWlakma4RKciwFOLji7+fC7/BbIdHgT
 RB2gPue3reW9Ylv6Lrj150quuj/QUh00y3LYskGDABnjKcnD/yzvlotUzV0cPoK+4WuL15S
 MY+A01y5zg1mrv4F7g0JHQ9Xn+tv2qoVeaEWji3mIhyoYHELlzDlGBP/q8V99PkRqPyBgL4
 8ZGuzhwSBy09rzEeAu96w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BBG3QbBEaaw=:kgUTLp4XoqEJGHXbWpyMle
 BWo/L+GdaARLlCrP8M0/skZ5GRvMnbDFz2qri9bB7nxfnYC4CHg6wd5vwI/RGCsU0h/Iu3bz/
 M2uWFLYgnTVzROR2cx8fVrXTe6sPR0qmc8SOvf8/XdbwmNNTxPz1KiJ+PSWdqG+UAPh37hwmd
 q3dVn0Le9egTF1RyTU+J/12h8HeSVHdq9nv7M/ue8tZgsu2AHiZ2QmqxkoJppPexDLq7WiV9C
 w09zjsIogb2PYkx4Dlk21vMfwtTepwM+ocSCgb2DurjSHdciWpsWl3vAAAoADAZ2l4E3v1eYT
 JcSOkQS8NEDKvRHHB1+04ExKwR/gN5n/FDCraBQS5nGHN/GbfiYYhnDNArxYYV0X3sfiiAKTT
 hkaT4PfoRpPgwfQKf8UUH1YJddmYZfnUiGYUu/o6Jy5bpZIOM7KH29hS/66+ukTNlwetdYvH6
 tANgu3Xl0lNv1Xa/iCw26LNkOjhv/3q6Dm76axjxlQh7nE7afyHufTLu0Ekp7yxOaCVllLPIP
 Wox29Y3zCfgQ112AqdQd57+AfQ9deV2c3mKRjydjSQe8heCHBGlIwQXNQv9REzF0HyQfbFhaH
 MJF6o6SyzwiNNbXWZQ+UnBN+nzazzuOjlUKmcLoZYvCe+NjR3WDcxKvY/snMxNDZylNGs6yXB
 5kGyHFk2kFzrtnazWcGCXj55Ko35B/IQ6Im2ce0l2hEJlRAotNtWF5qYSDSG/IEx5o94g/H81
 +98etpwjsmKhsAvtxnZZweJQ+NtEDvJDvi16zaLGwFD3MPESMNH2RjXNUDwnGb3UWrMODdC4r
 EFeaY+ddj4GqovHOmSngSBD1097G/qFS5uM8fgsIwyeSzmtg+89GVsKeQ4bVRXJJOlQMilYED
 9MrmUIYqgLRB4xIAEhmw==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 11, 2019 at 1:58 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Mon, 11 Nov 2019 at 17:28, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Nov 11, 2019 at 8:35 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > - Removing all the context switches and workqueues from the data submission
> >   path is also the right idea. As you found, there is still a workqueue inside
> >   of blk_mq that is used because it may get called from atomic context but
> >   the submission may get blocked in __mmc_claim_host(). This really
> >   needs to be changed as well, but not in the way I originally suggested:
> >   As Hannes suggested, the host interrrupt handler should always use
> >   request_threaded_irq() to have its own process context, and then pass a
> >   flag to blk_mq to say that we never need another workqueue there.
>
> So you mean we should complete the request in the host driver irq
> thread context, then issue another request in this context by calling
> blk_mq_run_hw_queues()?

Yes. I assumed there was already code that would always run
blk_mq_run_hw_queue() at I/O completion, but I can't find where
that happens today.

As I understand, the main difference to today is that
__blk_mq_delay_run_hw_queue() can call into __blk_mq_run_hw_queue
directly rather than using the delayed work queue once we
can skip the BLK_MQ_F_BLOCKING check.

> > - With that change in place calling a blocking __mmc_claim_host() is
> >   still a problem, so there should still be a nonblocking mmc_try_claim_host()
> >   for the submission path, leading to a BLK_STS_DEV_RESOURCE (?)
> >   return code from mmc_mq_queue_rq(). Basically mmc_mq_queue_rq()
> >   should always return right away, either after having queued the next I/O
> >   or with an error, but not waiting for the device in any way.
>
> Actually not only the mmc_claim_host() will block the MMC request
> processing, in this routine, the mmc_blk_part_switch() and
> mmc_retune() can also block the request processing. Moreover the part
> switching and tuning should be sync operations, and we can not move
> them to a work or a thread.

Ok, I see.

Those would also cause requests to be sent to the device or the host
controller, right? Maybe we can treat them as "a non-IO request
has successfully been queued to the device" events, returning
busy from the mmc_mq_queue_rq() function and then running
the queue again when they complete?

> > - For the packed requests, there is apparently a very simple way to implement
> >   that without a software queue: mmc_mq_queue_rq() is allowed to look at
> >   and dequeue all requests that are currently part of the request_queue,
> >   so it should take out as many as it wants to submit at once and send
> >   them all down to the driver together, avoiding the need for any further
> >   round-trips to blk_mq or maintaining a queue in mmc.
>
> You mean we can dispatch a request directly from
> elevator->type->ops.dispatch_request()?  but we still need some helper
> functions to check if these requests can be packed (the package
> condition), and need to invent new APIs to start a packed request (or
> using cqe interfaces, which means we still need to implement some cqe
> callbacks).

I don't know how the dispatch_request() function fits in there,
what Hannes told me is that in ->queue_rq() you can always
look at the following requests that are already queued up
and take the next ones off the list. Looking at bd->last
tells you if there are additional requests. If there are, you can
look at the next one from blk_mq_hw_ctx (not sure how, but
should not be hard to find)

I also see that there is a commit_rqs() callback that may
go along with queue_rq(), implementing that one could make
this easier as well.

> > - The DMA management (bounce buffer, map, unmap) that is currently
> >   done in mmc_blk_mq_issue_rq() should ideally be done in the
> >   init_request()/exit_request()  (?) callbacks from mmc_mq_ops so this
> >   can be done asynchronously, out of the critical timing path for the
> >   submission. With this, there won't be any need for a software queue.
>
> This is not true, now the blk-mq will allocate some static request
> objects (usually the static requests number should be the same with
> the hardware queue depth) saved in struct blk_mq_tags. So the
> init_request() is used to initialize the static requests when
> allocating them, and call exit_request to free the static requests
> when freeing the 'struct blk_mq_tags', such as the queue is dead. So
> we can not move the DMA management into the init_request/exit_request.

Ok, I must have misremembered which callback that is then, but I guess
there is some other place to do it.

       Arnd

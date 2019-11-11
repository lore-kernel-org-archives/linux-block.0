Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CC3C43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 12:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34FB2190F
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 12:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j51APIZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKKM65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:58:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40062 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKM64 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 07:58:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so13684705ljg.7
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2019 04:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fP8qGeeYCqsmCHBhpSi7mUsQY2mDE3jSPTMoBzVNYCY=;
        b=j51APIZM9l4QFnSomd22PB9SIDNlzFWOioD606nkVqo7AE5WQH0WvFnyY0xXZbsT5D
         Wzp6o5/Aip0GSI/c/hxDhaPnY2GfpK80x5YqkqTYspEryIzf92aboHJw8pKLs3nKoBJ1
         74jdyt3/iQK3j2D0RkZPO95aRHSKy4JAm5o0x85uWP5LmWmXeNM4CvS7w2bJ1xQoqGWp
         PpDD56TFvGmrJDGWbMqnb8mJx0tXrY/JbzISzYoR1bcgh7Vm8mF6jl7aZ9wL8UMzYyOT
         N/Eg/ijxqzKBZWk11nEQRQo2kA+pWt9k9us4/OaQVD/2C+e9o425WdL8uYfPLUaDdjOh
         GE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fP8qGeeYCqsmCHBhpSi7mUsQY2mDE3jSPTMoBzVNYCY=;
        b=dNQ3HBiK3GbTuQykRpPSFqxqnCjpj2eVeloB66/Uetgm43VHA7PbvF7SsGpkeAzgrX
         GnMW91UcSTzXrE/kE1zbIkYTw4Et9Z8qhw2kVuaWVtkn8k2RKQZfwM5LyXz2EnVKqrMM
         ssg6F+rvdiYX8UIqgY2vgMoxK9sDJLQC54EEYrr9A583x+P76haL1VxUjRm4uUlBni43
         4ZRtQ50BNX4j9JEbIIidDkWjnQD5oOUD9kzDTSlI+ye3WKOAE8qr/Q+8yVbn5hMKehEx
         iXpSM3iFKb4bFUR867qmXzZg1wyqLPLQDY4MoTWkNEyOkLDbuWGEQwG1C1clyuf87XRc
         Dqlw==
X-Gm-Message-State: APjAAAXQqJrmZP8DQCAzBv1jFYUlo5rWOnXMaCdeJvBhxYtG+/n1qYd/
        s+PwHxj3V+IHE5OwAbWYAL/1dy/ekz9HBaxSl7d+nA==
X-Google-Smtp-Source: APXvYqx7YJ2OUJ8XPyPz7W+D9S5fNZz6nmW+fRP/NfliVasg1pfLiiHzTNsIPK1SIHDxmaC2Nxe+n9E+oa8Pjdg19pw=
X-Received: by 2002:a2e:9104:: with SMTP id m4mr16634432ljg.63.1573477133612;
 Mon, 11 Nov 2019 04:58:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
In-Reply-To: <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 11 Nov 2019 20:58:40 +0800
Message-ID: <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Arnd Bergmann <arnd@arndb.de>
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
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Arnd,

On Mon, 11 Nov 2019 at 17:28, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Nov 11, 2019 at 8:35 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > Hi All,
> >
> > Now the MMC read/write stack will always wait for previous request is
> > completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> > or queue a work to complete request, that will bring context switching
> > overhead, especially for high I/O per second rates, to affect the IO
> > performance.
>
> Hi Baolin,
>
> I had a chance to discuss your changes and what other improvements
> can be done to the way mmc-blk works with Hannes Reinecke during the ELC
> conference. He had some good suggestions. Adding him and the linux-block
> mailing list to Cc to make sure I'm correctly representing this.

Great, thanks for your input.

>
> - For the queue_depth of a non-queuing block device, you indeed need to
>   leave it at e.g. 32 or 64 rather than 1 or 2, as you do now (I was wrong
>   here originally, but just confirmed that). The queue depth is just used to
>   ensure there is room for reordering and merging, as you also noticed.

Right.

>
> - Removing all the context switches and workqueues from the data submission
>   path is also the right idea. As you found, there is still a workqueue inside
>   of blk_mq that is used because it may get called from atomic context but
>   the submission may get blocked in __mmc_claim_host(). This really
>   needs to be changed as well, but not in the way I originally suggested:
>   As Hannes suggested, the host interrrupt handler should always use
>   request_threaded_irq() to have its own process context, and then pass a
>   flag to blk_mq to say that we never need another workqueue there.

So you mean we should complete the request in the host driver irq
thread context, then issue another request in this context by calling
blk_mq_run_hw_queues()?

>
> - With that change in place calling a blocking __mmc_claim_host() is
>   still a problem, so there should still be a nonblocking mmc_try_claim_host()
>   for the submission path, leading to a BLK_STS_DEV_RESOURCE (?)
>   return code from mmc_mq_queue_rq(). Basically mmc_mq_queue_rq()
>   should always return right away, either after having queued the next I/O
>   or with an error, but not waiting for the device in any way.

Actually not only the mmc_claim_host() will block the MMC request
processing, in this routine, the mmc_blk_part_switch() and
mmc_retune() can also block the request processing. Moreover the part
switching and tuning should be sync operations, and we can not move
them to a work or a thread.

>
> - For the packed requests, there is apparently a very simple way to implement
>   that without a software queue: mmc_mq_queue_rq() is allowed to look at
>   and dequeue all requests that are currently part of the request_queue,
>   so it should take out as many as it wants to submit at once and send
>   them all down to the driver together, avoiding the need for any further
>   round-trips to blk_mq or maintaining a queue in mmc.

You mean we can dispatch a request directly from
elevator->type->ops.dispatch_request()?  but we still need some helper
functions to check if these requests can be packed (the package
condition), and need to invent new APIs to start a packed request (or
using cqe interfaces, which means we still need to implement some cqe
callbacks).

>
> - The DMA management (bounce buffer, map, unmap) that is currently
>   done in mmc_blk_mq_issue_rq() should ideally be done in the
>   init_request()/exit_request()  (?) callbacks from mmc_mq_ops so this
>   can be done asynchronously, out of the critical timing path for the
>   submission. With this, there won't be any need for a software queue.

This is not true, now the blk-mq will allocate some static request
objects (usually the static requests number should be the same with
the hardware queue depth) saved in struct blk_mq_tags. So the
init_request() is used to initialize the static requests when
allocating them, and call exit_request to free the static requests
when freeing the 'struct blk_mq_tags', such as the queue is dead. So
we can not move the DMA management into the init_request/exit_request.

>
> Hannes,
>
> Let me know if I misunderstood any of the above, or if I missed any
> additional points.
>
>        Arnd
>
> > Thus this patch set will introduce the MMC software command queue support
> > based on command queue engine's interfaces, and set the queue depth as 32
> > to allow more requests can be be prepared, merged and inserted into IO
> > scheduler, but we only allow 2 requests in flight, that is enough to let
> > the irq handler always trigger the next request without a context switch,
> > as well as avoiding a long latency.
> >
> > Moreover we can expand the MMC software queue interface to support
> > MMC packed request or packed command instead of adding new interfaces,
> > according to previosus discussion.
> >
> > Below are some comparison data with fio tool. The fio command I used
> > is like below with changing the '--rw' parameter and enabling the direct
> > IO flag to measure the actual hardware transfer speed in 4K block size.
> >
> > ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=1G --group_reporting --numjobs=20 --name=test_read
> >
> > My eMMC card working at HS400 Enhanced strobe mode:
> > [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> > [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> > [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> > [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> > [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
> >
> > 1. Without MMC software queue
> > I tested 5 times for each case and output a average speed.
> >
> > 1) Sequential read:
> > Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
> > Average speed: 59.66MiB/s
> >
> > 2) Random read:
> > Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
> > Average speed: 27.04MiB/s
> >
> > 3) Sequential write:
> > Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
> > Average speed: 69.68MiB/s
> >
> > 4) Random write:
> > Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
> > Average speed: 35.96MiB/s
> >
> > 2. With MMC software queue
> > I tested 5 times for each case and output a average speed.
> >
> > 1) Sequential read:
> > Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
> > Average speed: 60.68MiB/s
> >
> > 2) Random read:
> > Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
> > Average speed: 31.36MiB/s
> >
> > 3) Sequential write:
> > Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
> > Average speed: 71.66MiB/s
> >
> > 4) Random write:
> > Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
> > Average speed: 68.76MiB/s
> >
> > Form above data, we can see the MMC software queue can help to improve some
> > performance obviously for random read and write, though no obvious improvement
> > for sequential read and write.
> >
> > Any comments are welcome. Thanks a lot.
> >
> > Hi Ulf,
> >
> > This patch set was pending for a while, and I've tested it several times and
> > have not found any recessions. Hope this patch set can be merged into v5.5
> > if no objection from you, since I still have some patches introducing the
> > packed request depend on the mmc software queue as we talked before.
> > Thanks a lot.
> >
> > Changes from v5:
> >  - Modify the condition of defering to complete request suggested by Adrian.
> >
> > Changes from v4:
> >  - Add a seperate patch to introduce a variable to defer to complete
> >  data requests for some host drivers, when using host software queue.
> >
> > Changes from v3:
> >  - Use host software queue instead of sqhci.
> >  - Fix random config building issue.
> >  - Change queue depth to 32, but still only allow 2 requests in flight.
> >  - Update the testing data.
> >
> > Changes from v2:
> >  - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
> >  instead adding 'struct sqhci_host', which is only used by software queue.
> >
> > Changes from v1:
> >  - Add request_done ops for sdhci_ops.
> >  - Replace virtual command queue with software queue for functions and
> >  variables.
> >  - Rename the software queue file and add sqhci.h header file.
> >
> > Baolin Wang (4):
> >   mmc: Add MMC host software queue support
> >   mmc: host: sdhci: Add request_done ops for struct sdhci_ops
> >   mmc: host: sdhci-sprd: Add software queue support
> >   mmc: host: sdhci: Add a variable to defer to complete requests if
> >     needed
> >
> >  drivers/mmc/core/block.c      |   61 ++++++++
> >  drivers/mmc/core/mmc.c        |   13 +-
> >  drivers/mmc/core/queue.c      |   33 +++-
> >  drivers/mmc/host/Kconfig      |    8 +
> >  drivers/mmc/host/Makefile     |    1 +
> >  drivers/mmc/host/mmc_hsq.c    |  344 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/mmc_hsq.h    |   30 ++++
> >  drivers/mmc/host/sdhci-sprd.c |   26 ++++
> >  drivers/mmc/host/sdhci.c      |   14 +-
> >  drivers/mmc/host/sdhci.h      |    3 +
> >  include/linux/mmc/host.h      |    3 +
> >  11 files changed, 523 insertions(+), 13 deletions(-)
> >  create mode 100644 drivers/mmc/host/mmc_hsq.c
> >  create mode 100644 drivers/mmc/host/mmc_hsq.h
> >
> > --
> > 1.7.9.5
> >



-- 
Baolin Wang
Best Regards

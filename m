Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F40C43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 09:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974772075C
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 09:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfKKJ2w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:28:52 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:50149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfKKJ2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 04:28:51 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M5wY1-1iWa2V3SiR-007R0n; Mon, 11 Nov 2019 10:28:49 +0100
Received: by mail-qk1-f174.google.com with SMTP id 15so10575809qkh.6;
        Mon, 11 Nov 2019 01:28:48 -0800 (PST)
X-Gm-Message-State: APjAAAVwD8dC+4GN/GFLwBWbdd8HutqZPCzHtzLfX5Bh6xqp/F1fpg2W
        EULLDsCXWqriL7UV/6pxfv39+6pBnO+dBWLwXdA=
X-Google-Smtp-Source: APXvYqwSu9lgfUBDF0nm5OtSH0s90suFF6U6hyuHCymJtgyPoF0wodDyO+XeG82Hd3hh9gp5e0Ri92Us7MzrxXcNFWY=
X-Received: by 2002:a05:620a:a0e:: with SMTP id i14mr9083164qka.3.1573464527336;
 Mon, 11 Nov 2019 01:28:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1573456283.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 10:28:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
Message-ID: <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
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
X-Provags-ID: V03:K1:NlmBSiEUcJdUp+oONEBeZKwIJlNQNohnkpRONpwp95+rgwaRFxR
 DLHHG0cPDGRDd3FngkKns5Bl01wyLBARZ57tYrLrqbbdbFbQmLBLpHlWQC5SG4WFEJZFTEm
 SQhQ6b26vKjVfyBpn42oMJ184hNdaUeghrItCRzHGHAZEli4XT2Lz2x426fa9UJXXaFQ/BR
 xteH+vzD5YxXNB9JQDZ0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e1qDkpaWia4=:PGv/l0hvWS2wIlyAKoXPEG
 k+r6DT3klBoQCgzXNmU648JQirHfptvCKrCjrXNsDzv6dP45CxcmXnff2neV+CJX715KpaNnM
 pQprNGuajq+e5zJhXpt3uRY+jSnpe3+xTKT7NFvcEasOs/P4gtDr8GvSWBEDnK7jmF4HgiGma
 cr7uUqZrRT8dDki9QqoX8P5Mewq+wAFF2An8o7F4/8PZERD5bW2USpNOPkl8CmcaOlKRhqRaP
 wlgfCnv9P5dluLTs9Q+BBN/eO1RMl2UAP5ouvmanowvO9ngXIjeaW+bQ1ulPJ6fhVSJjPV6fX
 e97CiY0rJq3o6iUgvmv/93DLPcGqcHSl/WUCUU1QOWgZMJDFB1+iwPsTjLd1uCpQE2bhPVdTw
 CICDl+tgFC2L/4kZ55G2CVlrJlrNa7qgSn15ckR0Ra/4FfbTzCRwddNtmiJqteC6gv/4/1nU+
 b9s/o2xpxTjUIDLjR/jRj0/oqoBr9/ROykNXxlVP0/YM+kvZrTeuLYfAeSvcqKlp583olYkOj
 YGkMVtDQA2f9MapiarwkaMT/eqhfAdyc6g3DOU1A85ug5WLR6Exmc54CBiA3MuAJpPJo4xg4M
 mbmC4iANc+s4yxSG4yGoGQ08wUYo+LfbDjFGsEoowxmIGourVH6oMPmj8eJLiDKvL3YmbzP+3
 0mSZR6lVSUJhRnkKB7hpwIm+48mNccXjz2jbi9l5Z5P8gWvk3iZ2Id/PI/xGqX/LmbQg2pyRI
 u/C7oiZDC+fVD6i9yaJgoxPcfDXjKiKa55Q5axC/2fBsssag3bX6WAxTFKMDZhhkEL/91WfKt
 PPcIFaX3vRqMUNsZgSHhdnaiW9pTl74u53TEVuOQuckPoJ/JMLQ/JCGra+war5k8pQKMaPGCZ
 Hg0RfwMsdKh4UCgjrn/Q==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 11, 2019 at 8:35 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi All,
>
> Now the MMC read/write stack will always wait for previous request is
> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> or queue a work to complete request, that will bring context switching
> overhead, especially for high I/O per second rates, to affect the IO
> performance.

Hi Baolin,

I had a chance to discuss your changes and what other improvements
can be done to the way mmc-blk works with Hannes Reinecke during the ELC
conference. He had some good suggestions. Adding him and the linux-block
mailing list to Cc to make sure I'm correctly representing this.

- For the queue_depth of a non-queuing block device, you indeed need to
  leave it at e.g. 32 or 64 rather than 1 or 2, as you do now (I was wrong
  here originally, but just confirmed that). The queue depth is just used to
  ensure there is room for reordering and merging, as you also noticed.

- Removing all the context switches and workqueues from the data submission
  path is also the right idea. As you found, there is still a workqueue inside
  of blk_mq that is used because it may get called from atomic context but
  the submission may get blocked in __mmc_claim_host(). This really
  needs to be changed as well, but not in the way I originally suggested:
  As Hannes suggested, the host interrrupt handler should always use
  request_threaded_irq() to have its own process context, and then pass a
  flag to blk_mq to say that we never need another workqueue there.

- With that change in place calling a blocking __mmc_claim_host() is
  still a problem, so there should still be a nonblocking mmc_try_claim_host()
  for the submission path, leading to a BLK_STS_DEV_RESOURCE (?)
  return code from mmc_mq_queue_rq(). Basically mmc_mq_queue_rq()
  should always return right away, either after having queued the next I/O
  or with an error, but not waiting for the device in any way.

- For the packed requests, there is apparently a very simple way to implement
  that without a software queue: mmc_mq_queue_rq() is allowed to look at
  and dequeue all requests that are currently part of the request_queue,
  so it should take out as many as it wants to submit at once and send
  them all down to the driver together, avoiding the need for any further
  round-trips to blk_mq or maintaining a queue in mmc.

- The DMA management (bounce buffer, map, unmap) that is currently
  done in mmc_blk_mq_issue_rq() should ideally be done in the
  init_request()/exit_request()  (?) callbacks from mmc_mq_ops so this
  can be done asynchronously, out of the critical timing path for the
  submission. With this, there won't be any need for a software queue.

Hannes,

Let me know if I misunderstood any of the above, or if I missed any
additional points.

       Arnd

> Thus this patch set will introduce the MMC software command queue support
> based on command queue engine's interfaces, and set the queue depth as 32
> to allow more requests can be be prepared, merged and inserted into IO
> scheduler, but we only allow 2 requests in flight, that is enough to let
> the irq handler always trigger the next request without a context switch,
> as well as avoiding a long latency.
>
> Moreover we can expand the MMC software queue interface to support
> MMC packed request or packed command instead of adding new interfaces,
> according to previosus discussion.
>
> Below are some comparison data with fio tool. The fio command I used
> is like below with changing the '--rw' parameter and enabling the direct
> IO flag to measure the actual hardware transfer speed in 4K block size.
>
> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=1G --group_reporting --numjobs=20 --name=test_read
>
> My eMMC card working at HS400 Enhanced strobe mode:
> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
>
> 1. Without MMC software queue
> I tested 5 times for each case and output a average speed.
>
> 1) Sequential read:
> Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
> Average speed: 59.66MiB/s
>
> 2) Random read:
> Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
> Average speed: 27.04MiB/s
>
> 3) Sequential write:
> Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
> Average speed: 69.68MiB/s
>
> 4) Random write:
> Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
> Average speed: 35.96MiB/s
>
> 2. With MMC software queue
> I tested 5 times for each case and output a average speed.
>
> 1) Sequential read:
> Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
> Average speed: 60.68MiB/s
>
> 2) Random read:
> Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
> Average speed: 31.36MiB/s
>
> 3) Sequential write:
> Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
> Average speed: 71.66MiB/s
>
> 4) Random write:
> Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
> Average speed: 68.76MiB/s
>
> Form above data, we can see the MMC software queue can help to improve some
> performance obviously for random read and write, though no obvious improvement
> for sequential read and write.
>
> Any comments are welcome. Thanks a lot.
>
> Hi Ulf,
>
> This patch set was pending for a while, and I've tested it several times and
> have not found any recessions. Hope this patch set can be merged into v5.5
> if no objection from you, since I still have some patches introducing the
> packed request depend on the mmc software queue as we talked before.
> Thanks a lot.
>
> Changes from v5:
>  - Modify the condition of defering to complete request suggested by Adrian.
>
> Changes from v4:
>  - Add a seperate patch to introduce a variable to defer to complete
>  data requests for some host drivers, when using host software queue.
>
> Changes from v3:
>  - Use host software queue instead of sqhci.
>  - Fix random config building issue.
>  - Change queue depth to 32, but still only allow 2 requests in flight.
>  - Update the testing data.
>
> Changes from v2:
>  - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
>  instead adding 'struct sqhci_host', which is only used by software queue.
>
> Changes from v1:
>  - Add request_done ops for sdhci_ops.
>  - Replace virtual command queue with software queue for functions and
>  variables.
>  - Rename the software queue file and add sqhci.h header file.
>
> Baolin Wang (4):
>   mmc: Add MMC host software queue support
>   mmc: host: sdhci: Add request_done ops for struct sdhci_ops
>   mmc: host: sdhci-sprd: Add software queue support
>   mmc: host: sdhci: Add a variable to defer to complete requests if
>     needed
>
>  drivers/mmc/core/block.c      |   61 ++++++++
>  drivers/mmc/core/mmc.c        |   13 +-
>  drivers/mmc/core/queue.c      |   33 +++-
>  drivers/mmc/host/Kconfig      |    8 +
>  drivers/mmc/host/Makefile     |    1 +
>  drivers/mmc/host/mmc_hsq.c    |  344 +++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h    |   30 ++++
>  drivers/mmc/host/sdhci-sprd.c |   26 ++++
>  drivers/mmc/host/sdhci.c      |   14 +-
>  drivers/mmc/host/sdhci.h      |    3 +
>  include/linux/mmc/host.h      |    3 +
>  11 files changed, 523 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/mmc/host/mmc_hsq.c
>  create mode 100644 drivers/mmc/host/mmc_hsq.h
>
> --
> 1.7.9.5
>

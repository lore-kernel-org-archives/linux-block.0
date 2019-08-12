Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63768C433FF
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 05:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AB32070C
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 05:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZMjNpkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHLFUs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 01:20:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46895 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfHLFUs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 01:20:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id z17so36178443otk.13
        for <linux-block@vger.kernel.org>; Sun, 11 Aug 2019 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNApVqLDhxhV5GW+zjfatyr91CgCXJ+9+OYZrhYmN0Q=;
        b=GZMjNpkNtxbv5PiNrferR3A8fwAHY/VcpmdZARBlA76B2M92CFLkLkNykU1a7MUxEM
         gf5KI4t+UMfh9YZc1CBtJTUKYN1bzpAX3O1aZgmt0t//8ciWbiPdScaO8I5odj227eKa
         aqbJQSGPXHWV6cKG58qpbARELDufXd5JCj1f7rmT98kUIJfelJNs3fQbFgksRz8/gLHN
         H9iQlsG2MDvF2uzYw/96/Bu9zoCXKJbhMV2wvHK/yYPaYxw7ydvULdMby9ux5Xjk5lyo
         0WOzTn7t77IeKH8rylwRvNnOAvdz4IODRHMpHIOxdl/eCcXX5K6VRnU8BWKh4/X86gVx
         2OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNApVqLDhxhV5GW+zjfatyr91CgCXJ+9+OYZrhYmN0Q=;
        b=Ab0xhnsZXdQJJOhhfkDoelUDOjNwURU+tgZ7m+nDtbsLbqIlaLFA4WGkgqa0T1YEbB
         WHP3Hhk9HiSJccAJfkPkOHf2Z+PM7RENLc0uxLTsIDAYYjH+JAxEQ+8aYm74NrHDso/r
         GuMxtp9sFu7XxktOpyUV97pZGCPO0vZDICe3z/bbeyYwNnq+zE2T+SN6iwqgiGHx0sqx
         g5wjb4u2MilGBhgFEdjNKIVk4MA+2oQJiEAhteT3leJhYXjovS8TfTnRecD67Cw9ccx5
         Uj4gQxVYX4gAv44AVpf2wpJNi72iW0IXz2Aw06hTRxhX2lN1VrSlIrxKVVEuFQa+FoZi
         r31g==
X-Gm-Message-State: APjAAAUMEChuqmN2ROYBQxPUqXnUR//nk2q2C+dSy4e1leP+97fmKLfl
        ufB7yOjlsiGkWSPOhvNhlBi5Hosj5drNWu2LEy6cVA==
X-Google-Smtp-Source: APXvYqwc1J0LHVsxC15wIek6Y+de63tnfv65ANYE5KIuFICkP6M9TU7xNixOegAoyyDezFKzLAeXegf32xgO/no/RNM=
X-Received: by 2002:a9d:590d:: with SMTP id t13mr18440283oth.281.1565587246724;
 Sun, 11 Aug 2019 22:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 12 Aug 2019 13:20:35 +0800
Message-ID: <CAMz4ku+NjcqLY0tWRxrBCRUnkpyWih42LYieKaf0FO6WsqO2vA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Add MMC packed function
To:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Mon, 22 Jul 2019 at 21:10, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi All,
>
> Now some SD/MMC controllers can support packed command or packed request,
> that means it can package multiple requests to host controller to be handled
> at one time, which can improve the I/O performence. Thus this patchset is
> used to add the MMC packed function to support packed request or packed
> command.
>
> In this patch set, I implemented the SD host ADMA3 transfer mode to support
> packed request. The ADMA3 transfer mode can process a multi-block data transfer
> by using a pair of command descriptor and ADMA2 descriptor. In future we can
> easily expand the MMC packed function to support packed command.
>
> Below are some comparison data between packed request and non-packed request
> with fio tool. The fio command I used is like below with changing the
> '--rw' parameter and enabling the direct IO flag to measure the actual hardware
> transfer speed.
>
> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read
>
> My eMMC card working at HS400 Enhanced strobe mode:
> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
>
> 1. Non-packed request
> I tested 3 times for each case and output a average speed.
>
> 1) Sequential read:
> Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
> Average speed: 28.7MiB/s
>
> 2) Random read:
> Speed: 18.2MiB/s, 8.9MiB/s, 15.8MiB/s
> Average speed: 14.3MiB/s
>
> 3) Sequential write:
> Speed: 21.1MiB/s, 27.9MiB/s, 25MiB/s
> Average speed: 24.7MiB/s
>
> 4) Random write:
> Speed: 21.5MiB/s, 18.1MiB/s, 18.1MiB/s
> Average speed: 19.2MiB/s
>
> 2. Packed request
> In packed request mode, I set the host controller can package maximum 10
> requests at one time (Actually I can increase the package number), and I
> enabled read/write packed request mode. Also I tested 3 times for each
> case and output a average speed.
>
> 1) Sequential read:
> Speed: 165MiB/s, 167MiB/s, 164MiB/s
> Average speed: 165.3MiB/s
>
> 2) Random read:
> Speed: 147MiB/s, 141MiB/s, 144MiB/s
> Average speed: 144MiB/s
>
> 3) Sequential write:
> Speed: 87.8MiB/s, 89.1MiB/s, 90.0MiB/s
> Average speed: 89MiB/s
>
> 4) Random write:
> Speed: 90.9MiB/s, 89.8MiB/s, 90.4MiB/s
> Average speed: 90.4MiB/s
>
> Form above data, we can see the packed request can improve the performance greatly.
> Any comments are welcome. Thanks a lot.

Any comments for this patch set? Thanks.

>
> Baolin Wang (7):
>   blk-mq: Export blk_mq_hctx_has_pending() function
>   mmc: core: Add MMC packed request function
>   mmc: host: sdhci: Introduce ADMA3 transfer mode
>   mmc: host: sdhci: Factor out the command configuration
>   mmc: host: sdhci: Remove redundant sg_count member of struct
>     sdhci_host
>   mmc: host: sdhci: Add MMC packed request support
>   mmc: host: sdhci-sprd: Add MMC packed request support
>
>  block/blk-mq.c                |    3 +-
>  drivers/mmc/core/Kconfig      |    2 +
>  drivers/mmc/core/Makefile     |    1 +
>  drivers/mmc/core/block.c      |   71 +++++-
>  drivers/mmc/core/block.h      |    3 +-
>  drivers/mmc/core/core.c       |   51 ++++
>  drivers/mmc/core/core.h       |    3 +
>  drivers/mmc/core/packed.c     |  478 ++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/queue.c      |   28 ++-
>  drivers/mmc/host/Kconfig      |    1 +
>  drivers/mmc/host/sdhci-sprd.c |   22 +-
>  drivers/mmc/host/sdhci.c      |  513 +++++++++++++++++++++++++++++++++++------
>  drivers/mmc/host/sdhci.h      |   59 ++++-
>  include/linux/blk-mq.h        |    1 +
>  include/linux/mmc/core.h      |    1 +
>  include/linux/mmc/host.h      |    3 +
>  include/linux/mmc/packed.h    |  123 ++++++++++
>  17 files changed, 1286 insertions(+), 77 deletions(-)
>  create mode 100644 drivers/mmc/core/packed.c
>  create mode 100644 include/linux/mmc/packed.h
>
> --
> 1.7.9.5
>


-- 
Baolin Wang
Best Regards

Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8588C76190
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C6021985
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXY2REcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfGVNKG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:10:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42493 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfGVNKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 09:10:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so17632212pgb.9
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rhr5L0lJCTkJeuj/HNYVCdn0BZMbl+CV9ZUpdrzuyTw=;
        b=QXY2REcfVkPG8xBvC6Rntckx7BRxEKc6vC5EEteAgJSXYea5/nO7lbzTQYvbcfdxmO
         rUglTqi5RcGd/nKbWkhCfJV8SlE/r6ki9n96BfiJo9IajI2GsE10EShmhfi3gDGY/Xhj
         JeqsBq4QtXcxvTt/OBXZqPy2CnNfTlvpivrnSAnmDLl2ZU0d0JXeSUwJsvPQyMiptzPX
         M1DO+kvwoZ07UWqBQ/GyXuv7B5a28MYAgZZ+adqlSIRfESXaVeFhWLlYyHUe8mb9hUib
         6IrZAs1qEH61GdHdhmjKpnhDxxIcpspQaUfV4fbUBf3Jyr2DAE3tpP2RMqGapIabsRq+
         qfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rhr5L0lJCTkJeuj/HNYVCdn0BZMbl+CV9ZUpdrzuyTw=;
        b=NL+IkRIph+cEDcPhKZ/Xi6qwLfMthtSA8G3y7r63qv26YGJPGGzy27GLCQDQV7uyF4
         aEAK90xPcgz9CEqdTQlmrPRYmwDTLjORqS63akfYZ7ufl/0yaOS6XwpegYfC4FEezFwF
         FhSrwnlkOVEA074kplvBVvWFbHCj5hPz2BJH3SLjuB0zCu/8bXQ7l3QeIsitRViTDDXQ
         wfmCFmSYTPp8AEXVaU6xfyTRhrSsox5I41fx08nzF876XLUoGXJ9pRIKWlU11tcJYyK3
         J5zoBzoYtQ15lpjGX4aRDtx64gQNZhotkPiIxgxeIP59hZBHtHs3rbwDcHz9AKs8QB09
         cLNw==
X-Gm-Message-State: APjAAAVXlqa3atz8VcD7LPnIlnPv47mYZ+bHCKjA4DSH4fNRpewAbbv5
        epzlXF5DmGbqdxKhECqen1/4HQ==
X-Google-Smtp-Source: APXvYqxVwxROYKuolLD+Ib7sWeYb8N8VYSJJ89V18PIniiG7gUbzqxN/Zw/4kR1e11tbayaZAQm7oQ==
X-Received: by 2002:a17:90a:3ae8:: with SMTP id b95mr75245281pjc.68.1563801005826;
        Mon, 22 Jul 2019 06:10:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm47013192pfn.99.2019.07.22.06.10.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:10:05 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 0/7] Add MMC packed function
Date:   Mon, 22 Jul 2019 21:09:35 +0800
Message-Id: <cover.1563782844.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi All,

Now some SD/MMC controllers can support packed command or packed request,
that means it can package multiple requests to host controller to be handled
at one time, which can improve the I/O performence. Thus this patchset is
used to add the MMC packed function to support packed request or packed
command.

In this patch set, I implemented the SD host ADMA3 transfer mode to support
packed request. The ADMA3 transfer mode can process a multi-block data transfer
by using a pair of command descriptor and ADMA2 descriptor. In future we can
easily expand the MMC packed function to support packed command.

Below are some comparison data between packed request and non-packed request
with fio tool. The fio command I used is like below with changing the
'--rw' parameter and enabling the direct IO flag to measure the actual hardware
transfer speed.

./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read

My eMMC card working at HS400 Enhanced strobe mode:
[    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB 
[    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
[    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
[    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)

1. Non-packed request
I tested 3 times for each case and output a average speed.

1) Sequential read:
Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
Average speed: 28.7MiB/s

2) Random read:
Speed: 18.2MiB/s, 8.9MiB/s, 15.8MiB/s
Average speed: 14.3MiB/s

3) Sequential write:
Speed: 21.1MiB/s, 27.9MiB/s, 25MiB/s
Average speed: 24.7MiB/s

4) Random write:
Speed: 21.5MiB/s, 18.1MiB/s, 18.1MiB/s
Average speed: 19.2MiB/s

2. Packed request
In packed request mode, I set the host controller can package maximum 10
requests at one time (Actually I can increase the package number), and I
enabled read/write packed request mode. Also I tested 3 times for each
case and output a average speed.

1) Sequential read:
Speed: 165MiB/s, 167MiB/s, 164MiB/s
Average speed: 165.3MiB/s

2) Random read:
Speed: 147MiB/s, 141MiB/s, 144MiB/s
Average speed: 144MiB/s

3) Sequential write:
Speed: 87.8MiB/s, 89.1MiB/s, 90.0MiB/s
Average speed: 89MiB/s

4) Random write:
Speed: 90.9MiB/s, 89.8MiB/s, 90.4MiB/s
Average speed: 90.4MiB/s

Form above data, we can see the packed request can improve the performance greatly.
Any comments are welcome. Thanks a lot.

Baolin Wang (7):
  blk-mq: Export blk_mq_hctx_has_pending() function
  mmc: core: Add MMC packed request function
  mmc: host: sdhci: Introduce ADMA3 transfer mode
  mmc: host: sdhci: Factor out the command configuration
  mmc: host: sdhci: Remove redundant sg_count member of struct
    sdhci_host
  mmc: host: sdhci: Add MMC packed request support
  mmc: host: sdhci-sprd: Add MMC packed request support

 block/blk-mq.c                |    3 +-
 drivers/mmc/core/Kconfig      |    2 +
 drivers/mmc/core/Makefile     |    1 +
 drivers/mmc/core/block.c      |   71 +++++-
 drivers/mmc/core/block.h      |    3 +-
 drivers/mmc/core/core.c       |   51 ++++
 drivers/mmc/core/core.h       |    3 +
 drivers/mmc/core/packed.c     |  478 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/queue.c      |   28 ++-
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   22 +-
 drivers/mmc/host/sdhci.c      |  513 +++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci.h      |   59 ++++-
 include/linux/blk-mq.h        |    1 +
 include/linux/mmc/core.h      |    1 +
 include/linux/mmc/host.h      |    3 +
 include/linux/mmc/packed.h    |  123 ++++++++++
 17 files changed, 1286 insertions(+), 77 deletions(-)
 create mode 100644 drivers/mmc/core/packed.c
 create mode 100644 include/linux/mmc/packed.h

-- 
1.7.9.5


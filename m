Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDDFC33CB6
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75302082F
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCEp05ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAQFZL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:25:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39814 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgAQFZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 00:25:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so9376781plp.6;
        Thu, 16 Jan 2020 21:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L+66nYz0wEe6sQe0zmNfPK1RvdK/xz0FGcDzl1cja9o=;
        b=kCEp05ow4Tcg/FcPAbaaFrCLn+UGiHKOFkUnYmyjpfw6EmZFvgYLaY6bvVIbilaZZB
         U1465JtT8BYtCRJXe0rnNa/HVu6iOdr/HZSJ/zvo0JVfVhb+AjfNpCJ3+zHecebjqGvV
         DG0oBOMF6kVx9z1C2jG3WKX52S3xStbQLF8oVhX6ugsCm7h98sB4joGLZO7zogqiRVkA
         zQb1OapHM4u9taS4aHiXYhDhN/bw3O9s0nMllqWjgT86IfEjbdfiKxJ+5wofKO1BmUp+
         oqeT88vnMuOBsYmkTHQFOObsRKXrGRgi0pQUtd8AxJPRxYlOVeiUNMohZmYFoDxTVFzh
         2lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L+66nYz0wEe6sQe0zmNfPK1RvdK/xz0FGcDzl1cja9o=;
        b=Yo/BlYpNYI4cl8Ho07bWOPox4Qwpl21O6RX/XOVwqhhjfMRKSVFZr28j8kNeu9uyTe
         2ekWoQhP5mz/6vrPTgESVJNPvbZEVDy5vOhXe27UUro87p1FQoqhlGWFmgslrIs7+xRF
         OlzsRZvbWBMSgQy+Hwy/WGcGOaXUSxG8oDTkOwMu5WR3EYSMijYBxt9hpW7E/gBIYPCg
         6mADbH0HD2Y1lvq7VWg5dkJuDxeg7UNbhaiyaplblJEbsag2ytFI5a14cPdVUFUWGey4
         BLcf+a15EiSD+KUNiOsspFXsrp+cKWxYsmSFJ9n6nNXkI85ZrMmS3P9YhGmZRIkb5lwM
         owDQ==
X-Gm-Message-State: APjAAAU0VjD/YheZUn2Yn1kl+5Jhx39VT0+1xsfFxkJ3JFd23vxDqzn5
        va7IhmPL1ivfiWSQixom91M=
X-Google-Smtp-Source: APXvYqyzfJfPFf/i08Achz8mEYaEaLjaBdyCAnIj6oH9IaOg/Z/5Gbsrqmb4aczrE2f98cWJtmgq3Q==
X-Received: by 2002:a17:90a:2e88:: with SMTP id r8mr3568477pjd.85.1579238710059;
        Thu, 16 Jan 2020 21:25:10 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c26sm28844756pfj.101.2020.01.16.21.25.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jan 2020 21:25:09 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [RFC PATCH 0/8] Add MMC packed request support
Date:   Fri, 17 Jan 2020 13:24:19 +0800
Message-Id: <cover.1579164455.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi All,

Now some SD/MMC controllers can support packed command or packed request,
that means it can package multiple requests to host controller to be handled
at one time, which can improve the I/O performence. Thus this patch set
tries to add the MMC packed request function to support packed request or
packed command.

In this patch set, I changed the dispatch_request() interface to allow
dispatching a batch of requests to hardware and expanded the MMC software
queue to support packed request. I also implemented the SD host ADMA3
transfer mode to support packed request. The ADMA3 transfer mode can process
a multi-block data transfer by using a pair of command descriptor and ADMA2
descriptor. In future we can easily expand the MMC packed function to support
packed command.

Below are some comparison data between packed request and non-packed request
with fio tool. The fio command I used is like below with changing the
'--rw' parameter and enabling the direct IO flag to measure the actual hardware
transfer speed. I tested 5 times for each case and output a average speed.

./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read

My eMMC card working at HS400 Enhanced strobe mode:
[    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB 
[    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
[    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
[    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)

1. Non-packed request
1) Sequential read:
Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
Average speed: 60.68MiB/s

2) Random read:
Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
Average speed: 31.36MiB/s

3) Sequential write:
Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
Average speed: 71.66MiB/s

4) Random write:
Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
Average speed: 68.76MiB/s

2. Packed request
1) Sequential read:
Speed: 230MiB/s, 230MiB/s, 229MiB/s, 230MiB/s, 229MiB/s
Average speed: 229.6MiB/s

2) Random read:
Speed: 181MiB/s, 181MiB/s, 181MiB/s, 180MiB/s, 181MiB/s
Average speed: 180.8MiB/s

3) Sequential write:
Speed: 175MiB/s, 171MiB/s, 171MiB/s, 172MiB/s, 171MiB/s
Average speed: 172MiB/s

4) Random write:
Speed: 169MiB/s, 169MiB/s, 171MiB/s, 167MiB/s, 170MiB/s
Average speed: 169.2MiB/s

From above data, we can see the packed request can improve the performance
greatly. Any comments are welcome. Thanks a lot.

Baolin Wang (8):
  block: Change the dispatch_request() API to support batch requests
  block: Allow sending a batch of requests from the scheduler to
    hardware
  mmc: Add MMC packed request support for MMC software queue
  mmc: host: sdhci: Introduce ADMA3 transfer mode
  mmc: host: sdhci: Factor out the command configuration
  mmc: host: sdhci: Remove redundant sg_count member of struct
    sdhci_host
  mmc: host: sdhci: Add MMC packed request support
  mmc: host: sdhci-sprd: Add MMC packed request support

 block/bfq-iosched.c           |   38 +++-
 block/blk-mq-sched.c          |   15 +-
 block/blk-mq.c                |    2 -
 block/blk-settings.c          |   13 ++
 block/kyber-iosched.c         |   80 ++++---
 block/mq-deadline.c           |   26 ++-
 drivers/mmc/core/block.c      |   22 +-
 drivers/mmc/core/block.h      |    3 +-
 drivers/mmc/core/core.c       |   26 +++
 drivers/mmc/core/core.h       |    2 +
 drivers/mmc/core/queue.c      |   22 +-
 drivers/mmc/host/mmc_hsq.c    |  310 ++++++++++++++++++++++---
 drivers/mmc/host/mmc_hsq.h    |   26 ++-
 drivers/mmc/host/sdhci-sprd.c |   30 ++-
 drivers/mmc/host/sdhci.c      |  499 +++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci.h      |   61 ++++-
 include/linux/blkdev.h        |    8 +
 include/linux/elevator.h      |    2 +-
 include/linux/mmc/core.h      |    6 +
 include/linux/mmc/host.h      |    9 +
 20 files changed, 1015 insertions(+), 185 deletions(-)

-- 
1.7.9.5


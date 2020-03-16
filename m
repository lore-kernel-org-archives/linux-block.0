Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6B2C0044D
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC132051A
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMi+kbBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgCPKBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:01:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46396 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbgCPKBk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 06:01:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id c19so9630722pfo.13;
        Mon, 16 Mar 2020 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ro97S81NR4iEY3FTCqC1SAZxpYSVOetJ8waF14o+rO0=;
        b=aMi+kbBQ6zLBSLEhtm4cHSCIgdWBBP1AXocoRztyhfNGUKNw8TWk7S4o6rSK9SN8lq
         O7fQC8bQ390gM/3b6FqZmywyz66Z/HfazUEEf9a1C+3HmfK46M7r+BvlTNUpELSWSyN4
         GtZE/S7UC7Gg/Wr/C/SDNPGnFa9kkGbXZ+iEpmj4GvO5a23h5DAZCfnSJtxLJmKkuqFy
         iMXQ1SGhQcVli6NPc2MGnjURbp6VjbtTy+xC7omctGMm2jAtlM7FR08YzqR4eROfx2Sg
         QL7AioXzH78p9eZElznBnF2LNvV+kNX5Ty77x2O20Y/ARSwiT7Fb5LmPKYaoW3gq1pT5
         rSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ro97S81NR4iEY3FTCqC1SAZxpYSVOetJ8waF14o+rO0=;
        b=Us4WIEShze7MRIoH1TrV51YuRACUgJht+9aOjqADr0VsBZyyNC8AE5Km8CrmRYm/MW
         9XmozO2XTkzcUEf+iXzn4GhqrgZD0uieigs+er9E+pKh/x5geOog9pPihC/BBveRp0yS
         twKVehWdlTp/sL7scT/Irm94qDW2ZkalOV+8TSCmky/ELVJg7dxa6z2G6Hbtk9XX65EO
         EoDCIPBlC+4ZXlT2D183AQCeDrAY6SQOc4nEiaoG/PYPaplWWLCRjweoY88Ms60wuf+b
         f311CbJK19oS0ZK61iDiF0y6GrFRffWXzFlG3jKiVFZ4zwoaZDnVpzlj+LxiyVSpsIXq
         V+Ow==
X-Gm-Message-State: ANhLgQ3Y1cHhqBq0wp9IW4cKwMIwdyRNRSTZrTdu8lt82G5Uqo8H2WoL
        gK8X5aOwU3YlbpY7o0AboQkWfYjD
X-Google-Smtp-Source: ADFU+vs4lEU6M8Ai/sE/F2p9HuhWB5j/uTJXWiwaO7E5BoojoPRFMeB+XKivuD8ylE8CM5x2nsEkPg==
X-Received: by 2002:a62:e211:: with SMTP id a17mr29022646pfi.198.1584352898844;
        Mon, 16 Mar 2020 03:01:38 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 136sm63970411pgh.26.2020.03.16.03.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 03:01:38 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     ming.lei@redhat.com, arnd@arndb.de, linus.walleij@linaro.org,
        baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH 0/8] Add MMC packed request support
Date:   Mon, 16 Mar 2020 18:01:17 +0800
Message-Id: <cover.1584350380.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
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

 block/bfq-iosched.c           |  38 +++-
 block/blk-mq-sched.c          |  15 +-
 block/blk-mq.c                |   2 -
 block/blk-settings.c          |  13 ++
 block/kyber-iosched.c         |  80 ++++---
 block/mq-deadline.c           |  26 ++-
 drivers/mmc/core/block.c      |  35 ++-
 drivers/mmc/core/block.h      |   3 +-
 drivers/mmc/core/core.c       |  26 +++
 drivers/mmc/core/core.h       |   2 +
 drivers/mmc/core/queue.c      |  22 +-
 drivers/mmc/host/mmc_hsq.c    | 271 ++++++++++++++++++++---
 drivers/mmc/host/mmc_hsq.h    |  25 ++-
 drivers/mmc/host/sdhci-sprd.c |  30 ++-
 drivers/mmc/host/sdhci.c      | 499 ++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci.h      |  61 +++++-
 include/linux/blkdev.h        |   8 +
 include/linux/elevator.h      |   2 +-
 include/linux/mmc/core.h      |   6 +
 include/linux/mmc/host.h      |   9 +
 20 files changed, 991 insertions(+), 182 deletions(-)

-- 
1.9.1


Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A422C55191
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C192080C
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtx4Mp4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgDZJjU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDZJjU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 05:39:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E4DC061A0C;
        Sun, 26 Apr 2020 02:39:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t4so427760plr.0;
        Sun, 26 Apr 2020 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YVsxCnebxifmDBwxjT1fH4HMDs9oBu6XSeSoPFuESmw=;
        b=jtx4Mp4gTuzQyxoO7zkNiYH6cfBfU58l9H3W6+KFourVv/nZdNRu8IpL8gIXLTrtI7
         xY++WEqTRi32qBFF/Fh0HaUyMib8F8PS/9VslS9Y6P3X5EdpigAR/blaB3/8Bf7G3zQ1
         HTLtIFAf7Da+Ha2WyqAPoFpxByFY/zB+YChtROfDbfoyBX9/NxQf0YKXNIuWD+YrXCdX
         yf/AXhmWwWpzwP/GF7VrspNzWCT9WalV0GomfNY1daGBI3veN6a2v1mUOdkqMM0TzZkY
         RHx4Q722sl+8Eqkhq0OG/0dC5pAYAoC35JJN8/fozgbYDZVw/9tlCbzSQUbb6wyH8kxb
         OnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YVsxCnebxifmDBwxjT1fH4HMDs9oBu6XSeSoPFuESmw=;
        b=UThqFg7vziqYVbJroEAwfTWQSHH+aII2uc/yJay3gb+40ouDr8ejDe4B5A3K8J22L9
         aina6c7N7/xhr+9B63d3vd69INoypf+Oqg+S/4LZfql/oZuvy7OAZs9h5Y4gQQwuXr6A
         gM+nvgywTqyUao750VSkXxtdqOcqKZ2ViXxjvGruXVrGC2FUNkoFbuDKil2EO05z/0tO
         bJNNrBCfIMUJIU9/y7XVU87F3tTGXDzfrIZCq1zQhH8Xr94ZMfgAYTSrpVD7drO4RNLY
         1hSheGpG84N56mVpY85g2oAocfUvP4p2Ie6VKtaHGF7qt6vL7kaGBn6DC2+un3k9tDQ1
         H+ag==
X-Gm-Message-State: AGi0PuYqZEOHx9L1fpxzi6fMdtlzoHaEPL8f9u3dIsIY/sQCVinIDKjV
        jhIkahaXO2ZxSl9KJ+8+6fU=
X-Google-Smtp-Source: APiQypLwkX+HozorDPIzAYErvQqpXWR22PEjsHsIpDHCfNLEEVEbD686I5Olw3lY2GjIqQNdx7qW8Q==
X-Received: by 2002:a17:90a:20ea:: with SMTP id f97mr17157742pjg.157.1587893957380;
        Sun, 26 Apr 2020 02:39:17 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id m129sm1835245pga.47.2020.04.26.02.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 02:39:16 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, linus.walleij@linaro.org, paolo.valente@linaro.org,
        ming.lei@redhat.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/7] Add MMC packed request support
Date:   Sun, 26 Apr 2020 17:38:53 +0800
Message-Id: <cover.1587888520.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
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

In this patch set, I extanded commit_rqs() to do batch processing suggested
by Ming, to allow dispatching a batch of requests to hardware and expanded
the MMC software queue to support packed request. I also implemented the
SD host ADMA3 transfer mode to support packed request. The ADMA3 transfer
mode can process a multi-block data transfer by using a pair of command
descriptor and ADMA2 descriptor. In future we can easily expand the MMC
packed function to support packed command.

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

Changes from RFC v1:
 - Re-implement the batch processing according to Ming's suggestion
 - Remove the bd.last validation in MMC block.c, since we always get bd.last == false
 according to the new batch processing method.

Baolin Wang (6):
  mmc: Add MMC packed request support for MMC software queue
  mmc: host: sdhci: Introduce ADMA3 transfer mode
  mmc: host: sdhci: Factor out the command configuration
  mmc: host: sdhci: Remove redundant sg_count member of struct
    sdhci_host
  mmc: host: sdhci: Add MMC packed request support
  mmc: host: sdhci-sprd: Add MMC packed request support

Ming Lei (1):
  block: Extand commit_rqs() to do batch processing

 block/blk-mq-sched.c          |  29 +-
 block/blk-mq.c                |  15 +-
 drivers/mmc/core/block.c      |  14 +
 drivers/mmc/core/core.c       |  26 ++
 drivers/mmc/core/core.h       |   2 +
 drivers/mmc/core/queue.c      |  19 +-
 drivers/mmc/host/mmc_hsq.c    | 292 +++++++++++++++++---
 drivers/mmc/host/mmc_hsq.h    |  25 +-
 drivers/mmc/host/sdhci-sprd.c |  30 +-
 drivers/mmc/host/sdhci.c      | 504 +++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.h      |  61 +++-
 include/linux/blk-mq.h        |   1 +
 include/linux/mmc/core.h      |   6 +
 include/linux/mmc/host.h      |   9 +
 14 files changed, 900 insertions(+), 133 deletions(-)

-- 
2.17.1


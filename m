Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9340BC001B0
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 18:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjHKSeq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjHKSep (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 14:34:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8FF271B
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 11:34:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc4dc65aa7so2919225ad.0
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691778883; x=1692383683;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFYspMZjwiRYV+CxQww+dsk3orw7wUcWJtFF73xYoiI=;
        b=ucA11McWTBUbp6aTXmxM/LuMOZL5TaB03licKTyJs7Ou4Z2rKRa403uX2Ub1NkCqws
         4lWJq9/0ogiDoALSBDFkZe36wJiCUh3e92IE/VxjYLVIZYbQaZuWG/E3Lrs/V9NMqgED
         XAY04fLDSINO/W4Uh+/xbHa0EHUHzjpkvt7fc1sQbKGZSIWRrRfJXrkOWoRek5a5g95/
         JrwbzBymZ7irg2Sm4/v/xSJCdzO9tbmBjq1/vwD00C46o8p6n+k3HWpnC4AcD0YSekEs
         6qT9XIjyeHzZ16PVbTJ7ROwvI2lALeHjaTWrOb05n4UZeHM1SbusUKnpS8xdnF7Wnl6+
         LW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691778883; x=1692383683;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cFYspMZjwiRYV+CxQww+dsk3orw7wUcWJtFF73xYoiI=;
        b=BrhqApB0d6k4GEwlk1j9X8OkxqRgcFuyCCpdO9XZOFeodI1pJqgsUuk/+F3aexXY6W
         40X4jfcmhN0kDxdG3n+IvsX2yAxm1ogiG8HJJX7XZpbnHxyXxmk5u+QfMDjX2dYNb7DA
         gRy/HkXlGGGI2+sXVFHScqdM8m/c6AAxk0ap4lcCpg5phn8rGgB/1xRZ6O6gjN8/VKoE
         fxLUeZJr2ArQD8DwNK7jI4r8H9N0/aQGH7L57XXYQYLJrv5O8exSYFNOimWXwow0BQh5
         5BPZDFYEEGLmAA9VtObftkLTHj0wx+M5KggsqHPDPUT4qV6LWWlobo8ri6UJaofkAdZe
         u3dQ==
X-Gm-Message-State: AOJu0YwgS33pzQWV4JR3+y6nWGb7crZyn21mUrBzWa0m8oBb35+KZOo/
        riNWS6y6LCsPIVWmThJBuO6ulpKwqwcs6ul7bzk=
X-Google-Smtp-Source: AGHT+IF7N6SiOIj4ayENrPCISGS7YRxzRGBEZXO/gqWf5nEHeNzB7b03t5HqzN070NVV4UT37xZqkg==
X-Received: by 2002:a17:902:f543:b0:1bb:d7d4:e2b with SMTP id h3-20020a170902f54300b001bbd7d40e2bmr3237354plf.0.1691778883371;
        Fri, 11 Aug 2023 11:34:43 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709028c8c00b001b8b4730355sm4246025plo.287.2023.08.11.11.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:34:42 -0700 (PDT)
Message-ID: <82f36827-2599-4736-ace5-8f9e9cba2e43@kernel.dk>
Date:   Fri, 11 Aug 2023 12:34:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.5-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Fixes for the block side that should go into the 6.5 kernel release:

- NVMe pull request via Keith:
	- Fixes for request_queue state (Ming)
	- Another uuid quirk (August)

- RCU poll fix for NVMe (Ming)

- Fix for an IO stall with polled IO (me)

- Fix for blk-iocost stats enable/disable accounting (Chengming)

- Regression fix for large pages for zram (Christoph)

Please pull!


The following changes since commit 3e9dce80dbf91972aed972c743f539c396a34312:

  ublk: return -EINTR if breaking from waiting for existed users in DEL_DEV (2023-07-27 07:17:36 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.5-2023-08-11

for you to fetch changes up to a7a7dabb5dd72d2875bc3ce56f94ea5ceb259d5b:

  nvme: core: don't hold rcu read lock in nvme_ns_chr_uring_cmd_iopoll (2023-08-11 08:12:32 -0600)

----------------------------------------------------------------
block-6.5-2023-08-11

----------------------------------------------------------------
August Wikerfors (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G

Chengming Zhou (1):
      blk-iocost: fix queue stats accounting

Christoph Hellwig (1):
      zram: take device and not only bvec offset into account

Jens Axboe (3):
      Merge tag 'nvme-6.5-2023-08-02' of git://git.infradead.org/nvme into block-6.5
      block: get rid of unused plug->nowait flag
      block: don't make REQ_POLLED imply REQ_NOWAIT

Ming Lei (4):
      nvme: fix possible hang when removing a controller during error recovery
      nvme-tcp: fix potential unbalanced freeze & unfreeze
      nvme-rdma: fix potential unbalanced freeze & unfreeze
      nvme: core: don't hold rcu read lock in nvme_ns_chr_uring_cmd_iopoll

 block/blk-core.c              |  6 ------
 block/blk-iocost.c            |  5 +++--
 block/fops.c                  |  7 ++++---
 drivers/block/zram/zram_drv.c | 32 ++++++++++++++++++++------------
 drivers/nvme/host/core.c      | 10 +++++++---
 drivers/nvme/host/ioctl.c     |  2 --
 drivers/nvme/host/pci.c       |  3 ++-
 drivers/nvme/host/rdma.c      |  3 ++-
 drivers/nvme/host/tcp.c       |  3 ++-
 include/linux/bio.h           |  2 +-
 include/linux/blkdev.h        |  1 -
 11 files changed, 41 insertions(+), 33 deletions(-)

-- 
Jens Axboe


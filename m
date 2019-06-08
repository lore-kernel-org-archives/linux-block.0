Return-Path: <SRS0=tJY/=UH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC248C28CC5
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 08:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD85214AE
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 08:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="US5s0eEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfFHIVD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Jun 2019 04:21:03 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39387 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFHIVC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 Jun 2019 04:21:02 -0400
Received: by mail-yb1-f195.google.com with SMTP id c5so1676705ybk.6
        for <linux-block@vger.kernel.org>; Sat, 08 Jun 2019 01:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VwS8/bH/uSRQPiysNJnDghi2gLi5GCWncGBEfPFVy6g=;
        b=US5s0eEYVOWdIPrHViQJ7ltMZVO/zATyFc6iJO1KiUamZO+AudRy9Kg8xmviCgJzox
         gOyoPJEJ3K+0jTVJ+/KDDFpQ1Z2tDjKHKLSJGn9w7Kf1zdlgyXxEmCKNt4mq/ZbQTzq6
         ir5jRFfRp1XT2gXvJQ12mVezInj8siKG31WFk+j9tFUPqpE7uqnNJkHb7v9T4RpcsIqz
         CVLCdJSRMi19pNvwd3+vls1VnUktyzXXpuzKDjKQs6/NTcRe1HzgflFQKsGb+efQ0dP2
         0cij0KtLhqfou6mtxRMSmHQ7bq4CEmewu+bOeO9BAJlLWPD0zINHirQLk2N1NEcZW0mL
         +EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VwS8/bH/uSRQPiysNJnDghi2gLi5GCWncGBEfPFVy6g=;
        b=ODnsqYyCxbbn9B8hTDJEZdXJizlUEP07U5+BY7ukvVaQkyKSehrqszl4T4GgjLXvS9
         SIrEsFn/upNCVnXmDZFBLk39ZNX3LWA2AxgvBztHLguNvk1CO4uf4McThwUdEmj8ecBY
         hwVa1jHq9QI1ONvlz7ek8j2P6ikRswVR0gCLoatkMLR3U8fQmo0PCpfmxLs0QEHEJhxp
         QNS0XFEXhLk2HL6gRq65RVknyK2s1RT8XPfL9QC+7ZbHH9G2vCaVZ7oMv8VEyhehlw3K
         GLUx6cZeDooFFLBit6W3xS9RUhHchocvCiDnBghagS+PWnPq15JfjuRRUkq8aUjAWyjl
         VG1w==
X-Gm-Message-State: APjAAAXAr/O9ljOQu2fUYBSAZJyTWHbSF5WAumI3Z7oN84nNL63b+Jaq
        5ft+LdBIuC395Fpkz1aAlBc+YxNB2LkHvw==
X-Google-Smtp-Source: APXvYqw5sH4kd3lKSRT9+IVlS/ke0mLLyDzyAuOK2Mz5NBcXl0juEw6JmriJc5mGZ7aE3jcNhc/qvg==
X-Received: by 2002:a25:df86:: with SMTP id w128mr22116193ybg.214.1559982061130;
        Sat, 08 Jun 2019 01:21:01 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-58-221.mycingular.net. [166.172.58.221])
        by smtp.gmail.com with ESMTPSA id i131sm1308287ywi.70.2019.06.08.01.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 01:21:00 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.2-rc4
Message-ID: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
Date:   Sat, 8 Jun 2019 02:20:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of fixes that should go into this release. This pull request
contains:

- Allow symlink from the bfq.weight cgroup parameter to the general
  weight (Angelo)

- Damien is new skd maintainer (Bart)

- NVMe pull request from Sagi, with a few small fixes.

- Ensure we set DMA segment size properly, dma-debug is now tripping on
  these (Christoph)

- Remove useless debugfs_create() return check (Greg)

- Remove redundant unlikely() check on IS_ERR() (Kefeng)

- Fixup request freeing on exit (Ming)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190608


----------------------------------------------------------------
Angelo Ruocco (2):
      cgroup: let a symlink too be created with a cftype file
      block, bfq: add weight symlink to the bfq.weight cgroup parameter

Bart Van Assche (1):
      MAINTAINERS: Hand over skd maintainership

Christoph Hellwig (4):
      nvme-pci: don't limit DMA segement size
      rsxx: don't call dma_set_max_seg_size
      mtip32xx: also set max_segment_size in the device
      mmc: also set max_segment_size in the device

Greg Kroah-Hartman (1):
      block: aoe: no need to check return value of debugfs_create functions

Jaesoo Lee (1):
      nvme: Fix u32 overflow in the number of namespace list calculation

Jens Axboe (1):
      Merge branch 'nvme-5.2-rc-next' of git://git.infradead.org/nvme into for-linus

Kefeng Wang (1):
      block: Drop unlikely before IS_ERR(_OR_NULL)

Max Gurtovoy (1):
      nvme-rdma: use dynamic dma mapping per command

Ming Lei (1):
      block: free sched's request pool in blk_cleanup_queue

Minwoo Im (1):
      nvmet: fix data_len to 0 for bdev-backed write_zeroes

Sagi Grimberg (2):
      nvme-rdma: fix queue mapping when queue count is limited
      nvme-tcp: fix queue mapping when queue count is limited

 MAINTAINERS                       |   2 +-
 block/bfq-cgroup.c                |   6 +-
 block/blk-cgroup.c                |   2 +-
 block/blk-core.c                  |  13 ++++
 block/blk-mq-sched.c              |  30 +++++++-
 block/blk-mq-sched.h              |   1 +
 block/blk-sysfs.c                 |   2 +-
 block/blk.h                       |  10 ++-
 block/elevator.c                  |   2 +-
 drivers/block/aoe/aoeblk.c        |  16 +---
 drivers/block/mtip32xx/mtip32xx.c |   1 +
 drivers/block/rsxx/core.c         |   1 -
 drivers/mmc/core/queue.c          |   2 +
 drivers/nvme/host/core.c          |   3 +-
 drivers/nvme/host/pci.c           |   6 ++
 drivers/nvme/host/rdma.c          | 152 ++++++++++++++++++++++++--------------
 drivers/nvme/host/tcp.c           |  57 ++++++++++++--
 drivers/nvme/target/io-cmd-bdev.c |   1 +
 include/linux/cgroup-defs.h       |   3 +
 kernel/cgroup/cgroup.c            |  33 ++++++++-
 20 files changed, 251 insertions(+), 92 deletions(-)

-- 
Jens Axboe


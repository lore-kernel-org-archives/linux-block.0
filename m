Return-Path: <SRS0=iFeA=WN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EC4C3A59B
	for <linux-block@archiver.kernel.org>; Sat, 17 Aug 2019 22:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1D521773
	for <linux-block@archiver.kernel.org>; Sat, 17 Aug 2019 22:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GezYn6ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfHQWpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Aug 2019 18:45:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34478 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfHQWpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Aug 2019 18:45:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so4768275pgc.1
        for <linux-block@vger.kernel.org>; Sat, 17 Aug 2019 15:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=siGxiqpTU1g2CCN/RvhKgTSfo8Vi2werH32k4WXJHa0=;
        b=GezYn6gaggYCZQ27o3kAxlHVitE2Tt9z1Ha+Z64RvloHn+Gf64X5IrLanoHFf/Hyfy
         NKItmnwLFuYv9zytNg5Hh2jZcq3AqhaswAOPR3MS0RtjoL3672rt22jPzyrUv7xdxnXk
         4VM4GKA3Wrq2wDwCTh2JtM7UPd/SPjsg1kI2Qs8ENfy8aSwtxiCG7hFIWU5ityrhJ+M0
         p/TG0bBC34RfIJhkXwjSZcHieheuoWkKyqo6Zw0XhOw5gL7YGqbAHS2bO1NUV2rzz6g4
         jUtKhBtZjLxXY8zCbEBdX0g+mfmL2EmzGKr20mdcRh4lcAOxa9a8jgfbmMh2scdOz4CH
         bqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=siGxiqpTU1g2CCN/RvhKgTSfo8Vi2werH32k4WXJHa0=;
        b=IHUL1WuPE+dkBD8gK1GO/9Rwmi+BL0D635tPDQUPRGKbUoUHKm8jY1bf8CUfTJOLbc
         eQsRFzMKWUkqloztq/U/qwRU5r8fx4qvHtGRlmWiU0c8e82uUd8fTdFAcCRHboIYJqA3
         UuCpd5zmHisc+HueudP0fdBfRIRkYOorwJA7FcxXRFAUM/LLxG/BeZ6+N9e5j6QQSnIk
         WCKIr1ExV0k+8tq5MX/aVzCRn+wJ9LQZAenQCZ6N6bfDY+0NpXQnJ48hY+bxgLKUA5xY
         7naBXTX//ZfdRlmd5+c8w2KkH6wqqjQ8twq7JabuE84Vqty0tAN0TyIjOcuhIBpBI17o
         VrVg==
X-Gm-Message-State: APjAAAWNkUXz0pBOc5ZxLyjfgDZsg4Cm2xJ4EoOOyCWOuYPjqTqAqkN2
        sjL5uOgaAtdcSLYkSOX9Di+NyHgpBgg8SQ==
X-Google-Smtp-Source: APXvYqyT/VP5r/m5AImPHZ4sVroWIYLhI3FhDdoYX+t1xN0d+MyrZGRcf0We73oEUtASJwrjANK9hg==
X-Received: by 2002:a17:90a:7304:: with SMTP id m4mr13964405pjk.73.1566081918236;
        Sat, 17 Aug 2019 15:45:18 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id x2sm9922572pja.22.2019.08.17.15.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2019 15:45:17 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.3-rc5
Message-ID: <cb805bba-1f68-15bc-a8eb-ebbce15e1dfa@kernel.dk>
Date:   Sat, 17 Aug 2019 16:45:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Collection of fixes that should go into this series. This pull request
contains:

- Revert of the REQ_NOWAIT_INLINE and associated dio changes. There were
  still corner cases there, and even though I had a solution for it,
  it's too involved for this stage. (me)

- Set of NVMe fixes (via Sagi)

- io_uring fix for fixed buffers (Anthony)

- io_uring defer issue fix (Jackie)

- Regression fix for queue sync at exit time (zhengbin)

- xen blk-back memory leak fix (Wenwen)


Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-2019-08-17


----------------------------------------------------------------
Aleix Roca Nonell (1):
      io_uring: fix manual setup of iov_iter for fixed buffers

Anthony Iliopoulos (1):
      nvme-multipath: revalidate nvme_ns_head gendisk in nvme_validate_ns

Jackie Liu (1):
      io_uring: fix an issue when IOSQE_IO_LINK is inserted into defer list

Jens Axboe (2):
      Merge branch 'nvme-5.3-rc' of git://git.infradead.org/nvme into for-linus
      block: remove REQ_NOWAIT_INLINE

Keith Busch (1):
      nvme-pci: Fix async probe remove race

Logan Gunthorpe (4):
      nvmet: Fix use-after-free bug when a port is removed
      nvmet-loop: Flush nvme_delete_wq when removing the port
      nvmet-file: fix nvmet_file_flush() always returning an error
      nvme-core: Fix extra device_put() call on error path

Sagi Grimberg (3):
      nvme: fix a possible deadlock when passthru commands sent to a multipath device
      nvme-rdma: fix possible use-after-free in connect error flow
      nvme: fix controller removal race with scan work

Wenwen Wang (1):
      xen/blkback: fix memory leaks

zhengbin (1):
      blk-mq: move cancel of requeue_work to the front of blk_exit_queue

 block/blk-mq.c                     | 10 +----
 block/blk-sysfs.c                  |  3 ++
 drivers/block/xen-blkback/xenbus.c |  6 +--
 drivers/nvme/host/core.c           | 15 +++++++-
 drivers/nvme/host/multipath.c      | 76 +++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h           | 21 ++++++++++-
 drivers/nvme/host/pci.c            |  3 +-
 drivers/nvme/host/rdma.c           | 16 +++++---
 drivers/nvme/target/configfs.c     |  1 +
 drivers/nvme/target/core.c         | 15 ++++++++
 drivers/nvme/target/loop.c         |  8 ++++
 drivers/nvme/target/nvmet.h        |  3 ++
 fs/block_dev.c                     | 49 +++---------------------
 fs/io_uring.c                      | 20 +++++-----
 include/linux/blk_types.h          |  5 +--
 15 files changed, 167 insertions(+), 84 deletions(-)

-- 
Jens Axboe


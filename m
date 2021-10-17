Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B5DC433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 13:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B47660FD8
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 13:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343761AbhJQNp6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343753AbhJQNps (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 09:45:48 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A92C061765
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 06:43:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n7so13300592iod.0
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JkM+w2483E9vSqQ5BV6e/ARAk6otI7EOh2cVtw+LqVw=;
        b=nMKZpuzTLVnuoR1Z1heG5VZwjg/Ycapnsie/hbXh7BQ9SwR8N3Hk3got6WQHEUw9vs
         oLUAW7AUMKY7npwm4yVFgLjij73pb/qXZ9O9lT+Qat7sy99Qg9ldicbJ+lkAiq2PnhXT
         J4NJyMR21WDWsIMTLwuxK+guogviFFggQYxUmOJxfIze4tHGqiIjQI+7zXg0nl0Goev8
         bKmSy4Kz334hkXq0wnZKHvPOrGEA6T0g2J90bkdVM+yznFwqUNBIPDDedZTT9ONNAKBr
         qobTu8SXNfdcghxnbhPf99kBJyThKsr/Ej5dHNncen8Rh0pRB8xXPipB8RKdItZJOM3l
         Je4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JkM+w2483E9vSqQ5BV6e/ARAk6otI7EOh2cVtw+LqVw=;
        b=F0S2bPzGfmJpkxAbzJtHD3mBxrcSfMtgNQBFEldygLF0dk9ljpFsOLMbM0vXgK4T9o
         eYJ9bKzp5+7Zp9wZv3mrjItAk9UfSKRBIQb+7iS/GpRl2BIcR4XKbtS1/6acOBZYVaDf
         mm7cJDf36D36HMpHqwqKuUKnlKfL6vtMSuDcnW5RCbhLznn0PCGhand6xrlKy14rvqBk
         8bFQdEegvWUeK8sofRNncPsV5Ca2jm22EIeB0xMsgeaKRVBNKfe97GpWTmJckhstoSx3
         RpaVIygihgxSBYvEOCrCcp0KFy08hSa0hjYAQPJqW4m7j3Y9eZHFNi7C1vWN5O4XlDZE
         tNdg==
X-Gm-Message-State: AOAM5334gYyyPDDTZhFE2OOmyePuZb+gk4i7UOahYN36ORDwu1CJiuQp
        ML7UL43I15tYHslBBvcyfgWxr/oOEVMVZw==
X-Google-Smtp-Source: ABdhPJx4rxhiJH/K70P/yWiG8onQ3JeWYi0PbtjzNE6x1CgPj4elYexV8quCgvy5/CLIBCEmvDfMYQ==
X-Received: by 2002:a5d:87c8:: with SMTP id q8mr10932876ios.117.1634478218438;
        Sun, 17 Oct 2021 06:43:38 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y11sm5476455ior.4.2021.10.17.06.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 06:43:38 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.15-rc6
Message-ID: <17c55a10-ef17-7503-2a83-664de7255582@kernel.dk>
Date:   Sun, 17 Oct 2021 07:43:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Bigger than usual for this point in time, the majority is fixing some
issues around BDI lifetimes with the move from the request_queue to the
disk in this release. In detail:

- Series on draining fs IO for del_gendisk() (Christoph)

- NVMe pull request via Christoph:
	- fix the abort command id (Keith Busch)
	- nvme: fix per-namespace chardev deletion (Adam Manzanares)

- brd locking scope fix (Tetsuo)

- BFQ fix (Paolo)

Please pull!


The following changes since commit 1dbdd99b511c966be9147ad72991a2856ac76f22:

  block: decode QUEUE_FLAG_HCTX_ACTIVE in debugfs output (2021-10-04 06:58:39 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-17

for you to fetch changes up to d29bd41428cfff9b582c248db14a47e2be8457a8:

  block, bfq: reset last_bfqq_created on group change (2021-10-17 07:03:02 -0600)

----------------------------------------------------------------
block-5.15-2021-10-17

----------------------------------------------------------------
Adam Manzanares (1):
      nvme: fix per-namespace chardev deletion

Christoph Hellwig (7):
      block: call submit_bio_checks under q_usage_counter
      block: factor out a blk_try_enter_queue helper
      block: split bio_queue_enter from blk_queue_enter
      block: drain file system I/O on del_gendisk
      block: keep q_usage_counter in atomic mode after del_gendisk
      kyber: avoid q->disk dereferences in trace points
      block: warn when putting the final reference on a registered disk

Dan Carpenter (1):
      block/rnbd-clt-sysfs: fix a couple uninitialized variable bugs

Jens Axboe (1):
      Merge tag 'nvme-5.15-2021-10-14' of git://git.infradead.org/nvme into block-5.15

Keith Busch (1):
      nvme-pci: Fix abort command id

Paolo Valente (1):
      block, bfq: reset last_bfqq_created on group change

Tetsuo Handa (1):
      brd: reduce the brd_devices_mutex scope

 block/bfq-cgroup.c                  |   6 ++
 block/blk-core.c                    | 148 +++++++++++++++++++-----------------
 block/blk-mq.c                      |   9 ++-
 block/blk.h                         |   2 +
 block/genhd.c                       |  23 ++++++
 block/kyber-iosched.c               |  10 ++-
 drivers/block/brd.c                 |  44 +++++------
 drivers/block/rnbd/rnbd-clt-sysfs.c |   4 +-
 drivers/nvme/host/core.c            |  21 ++---
 drivers/nvme/host/multipath.c       |   2 -
 drivers/nvme/host/pci.c             |   2 +-
 include/linux/genhd.h               |   1 +
 include/trace/events/kyber.h        |  19 +++--
 13 files changed, 171 insertions(+), 120 deletions(-)

-- 
Jens Axboe


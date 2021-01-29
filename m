Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81707C433DB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 19:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFF264DE3
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 19:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhA2TRA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jan 2021 14:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhA2TPl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jan 2021 14:15:41 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5DC061573
        for <linux-block@vger.kernel.org>; Fri, 29 Jan 2021 11:14:59 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q129so10458512iod.0
        for <linux-block@vger.kernel.org>; Fri, 29 Jan 2021 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bVA6kONXMxGkwUl0cqmJ9iW9Uyz4+cUITfJtOrUOrno=;
        b=FF+4bbrR2UcLabga+kYpsxammsvW7hNiQWFif0UmzHT5xDhL5Xo9AirjdAItzH3/G8
         Anq8HjaE065HnbFW22Ui1tXGIbmvE0TsANNffEEEPs5FN4y7ziNe9B0zWUht3lADDif9
         ooeoFovP3WcZXtC4OYbmu6iggd2oNmevkcUqDmh43KZXbalm4EKhHDNwebcHSgXo5hR+
         V4mWyWTa6zphUKpPWYm9a0p2598QjsJDnr/GEyL/x9nMuXYBBeNgDAteynkCaT9ERmcr
         /W4YNkoH2DA7vBE7fQsS9kdMVp1hn3XmRNXR66TlTOjKWLfv0cwFJqi4cspEVqIsSJ7S
         jr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bVA6kONXMxGkwUl0cqmJ9iW9Uyz4+cUITfJtOrUOrno=;
        b=pChQDmv1hLLt9XXz5aCSxpBXiWLiiSc241bmkc70/d3QZHqc92r7+YueAd0EsXBAvI
         skl04G5HhObi3LEQbRhOWovYivZ3FqlLU8QhitH/xbYMjpzXhjTnT4SSP8YrWPQYFPGO
         yMiW4FYlFU6nFN318sbwwJXk4KTx+3WYituZ2Xl3suJfWwrk/qrFMZllw+3aS7w3qffs
         LeuKpG0Sq9Up5sSjO7L+Jx7uvuDaN/Ytr+gFZd6mmUkT3DRAqlNqjO6QbOjbJRfb2TLZ
         qUOgfjthgnBHQI259YuxtTLsozpEya9bw6o62pKeiRnPnIF+XpsMjlonyfK8LOV2N9kR
         D19g==
X-Gm-Message-State: AOAM531dqEphF15qqDLLrY00UUEFbQbn7Kgo+NJ68Dj4QXpbIlSBegUk
        KMs6t1oD8s0BYXcP3Q8IHguepUPeTAsupdfT
X-Google-Smtp-Source: ABdhPJwEyMImAhsl6PGwQDQwUB/+/cgN3x4+1vPuy7Z6Tlcc523jgkwC3Mjonv6DaPK8J24TQV3KKQ==
X-Received: by 2002:a6b:f107:: with SMTP id e7mr4616316iog.191.1611947698995;
        Fri, 29 Jan 2021 11:14:58 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k16sm4423013ioj.35.2021.01.29.11.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 11:14:58 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.11-rc6
Message-ID: <eb91c072-f5e2-147d-792d-165b53406313@kernel.dk>
Date:   Fri, 29 Jan 2021 12:14:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

All over the place fixes for this release:

- blk-cgroup iteration teardown resched fix (Baolin)

- NVMe pull request from Christoph:
	- add another Write Zeroes quirk (Chaitanya Kulkarni)
	- handle a no path available corner case (Daniel Wagner)
	- use the proper RCU aware list_add helper (Chao Leng)

- bcache regression fix (Coly)

- bdev->bd_size_lock IRQ fix. This will be fixed in drivers for 5.12,
  but for now, we'll make it IRQ safe (Damien)

- null_blk zoned init fix (Damien)

- add_partition() error handling fix (Dinghao)

- s390 dasd kobject fix (Jan)

- nbd fix for freezing queue while adding connections (Josef)

- Tag queueing regression fix (Ming)

- Revert of a patch that inadvertently meant that we regressed write
  performance on raid (Maxim)

Please pull!


The following changes since commit 97784481757fba7570121a70dd37ca74a29f50a8:

  lightnvm: fix memory leak when submit fails (2021-01-21 05:45:51 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-29

for you to fetch changes up to cd92cdb9c8bcfc27a8f28bcbf7c414a0ea79e5ec:

  null_blk: cleanup zoned mode initialization (2021-01-29 07:49:22 -0700)

----------------------------------------------------------------
block-5.11-2021-01-29

----------------------------------------------------------------
Baolin Wang (1):
      blk-cgroup: Use cond_resched() when destroy blkgs

Chaitanya Kulkarni (1):
      nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a SPCC device

Chao Leng (1):
      nvme-core: use list_add_tail_rcu instead of list_add_tail for nvme_init_ns_head

Coly Li (1):
      bcache: only check feature sets when sb->version >= BCACHE_SB_VERSION_CDEV_WITH_FEATURES

Damien Le Moal (2):
      block: fix bd_size_lock use
      null_blk: cleanup zoned mode initialization

Daniel Wagner (1):
      nvme-multipath: Early exit if no path is available

Dinghao Liu (1):
      block: Fix an error handling in add_partition

Jan Höppner (1):
      s390/dasd: Fix inconsistent kobject removal

Jens Axboe (1):
      Merge tag 'nvme-5.11-2021-01-28' of git://git.infradead.org/nvme into block-5.11

Josef Bacik (1):
      nbd: freeze the queue while we're adding connections

Maxim Mikityanskiy (1):
      Revert "block: simplify set_init_blocksize" to regain lost performance

Ming Lei (1):
      blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared in hctx_may_queue

 block/blk-cgroup.c               | 18 +++++++++++++-----
 block/blk-mq.h                   |  2 +-
 block/genhd.c                    |  5 +++--
 block/partitions/core.c          |  8 +++++---
 drivers/block/nbd.c              |  8 ++++++++
 drivers/block/null_blk/zoned.c   | 16 +++++++++-------
 drivers/md/bcache/features.h     |  6 ++++++
 drivers/nvme/host/core.c         |  2 +-
 drivers/nvme/host/multipath.c    |  2 +-
 drivers/nvme/host/pci.c          |  2 ++
 drivers/s390/block/dasd_devmap.c | 20 ++++++++++++++------
 drivers/s390/block/dasd_eckd.c   |  3 ++-
 drivers/s390/block/dasd_int.h    |  2 +-
 fs/block_dev.c                   | 10 +++++++++-
 14 files changed, 75 insertions(+), 29 deletions(-)

-- 
Jens Axboe


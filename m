Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A51C43334
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 05:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbiFCFg7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 01:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbiFCFg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 01:36:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D9FE0F
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 22:36:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f7-20020a1c3807000000b0039c1a10507fso3761130wma.1
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2022 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=tCL49V1mbAryKUIBaJWelcmoBwoZ8ij+4fK8tFV8xu0=;
        b=nDYE3tSJ4GKZqjj6lUDzwrUOaGXaTT9t1kX+/3c/m4jj4yADAv8ttf/qsrvNSJcUHq
         A+pm2gxU2Aelog/JQRs43x1lw6svW6hnkcT36njdhb7t64JTN5riL4MaGFrZGsiJDaam
         C5qqAmUZz5PPYLDzPFdZTPuHvKCRUiaQtGRJiAcK88+CoRMpD+JRg7vCdbU/xaPlJNYT
         5LCHszu2Ll9wM/N4qgpXNaYleGMn5+jgVqxJ+WCaeW+Vxfztb83pFHg1f72A+AI/Vpjw
         BRrudW4mlntcBvKgLdSeF7UjNJEWzzyT+CdAng6JjbEGAqt3sXluTVa3KmXoOjOpRXtt
         q6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=tCL49V1mbAryKUIBaJWelcmoBwoZ8ij+4fK8tFV8xu0=;
        b=J5ojLNLTkD5nnF3rTjzCHLrc5h1jTX80WPqYKB1p7Y+jDTVsXHIpkZXXqIt5z3u3DO
         jkk7rOQ1esAyZXLjvjl9YJ2l6OdbYbCx4mJQfIfTP9CrBQio9IS2vvazK4kNCMnQEJ5K
         wlMDETPIFkxyrFVtVc/Z5flgZ8D4V5GOAFPUG7mQ02pm9+QU9vSu1TWswQf1xyVzeY6a
         fHS/DXi5NCIMALqFU+3ue6UFTG0DYQiT0LRK5rfehjPPd+ktOnTQxnWagAZHCB/CRlci
         sspXTcpMW2o10cGnrvWQKPmebXFS7wm0Zj+siKFhrHhjeKpOS3G+NVJ7Vxe6OEGlPZxR
         UDng==
X-Gm-Message-State: AOAM533USoLpb4FVhB1eyiYNfEeS357uEBmFEVnHyJl8bn4iaThcwWM4
        owyAWQFIdIPLG3vRsLvYeErBILtEvResMxFr
X-Google-Smtp-Source: ABdhPJxWpedsU+1Bp3nw9a/kVM4xv8RZdUCFWVkebdo+EtrgUZgNSDdDZQWcbMwiuDLptiuECZk8Kg==
X-Received: by 2002:a05:600c:21c3:b0:39c:38da:e3ec with SMTP id x3-20020a05600c21c300b0039c38dae3ecmr2623253wmj.120.1654234611897;
        Thu, 02 Jun 2022 22:36:51 -0700 (PDT)
Received: from [10.188.163.71] (cust-east-parth2-46-193-73-98.wb.wifirst.net. [46.193.73.98])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d6a83000000b0020cfed0bb7fsm6210968wru.53.2022.06.02.22.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 22:36:51 -0700 (PDT)
Message-ID: <c47ef1fc-eac8-5b2b-9952-6e5fcdbce590@kernel.dk>
Date:   Thu, 2 Jun 2022 23:36:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block drivers followup pull request
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A collection of stragglers that were late on sending in their changes
and just followup fixes.

- NVMe fixes pull request via Christoph:
	- set controller enable bit in a separate write (Niklas Cassel)
	- disable namespace identifiers for the MAXIO MAP1001 (Christoph)
	- fix a comment typo (Julia Lawall)"

- MD fixes pull request via Song:
	- Remove uses of bdevname (Christoph Hellwig)
	- Bug fixes (Guoqing Jiang, and Xiao Ni)

- bcache fixes series (Coly)

- null_blk zoned write fix (Damien)

- nbd fixes (Yu, Zhang)

- Fix for loop partition scanning (Christoph)

Please pull!


The following changes since commit 537b9f2bf60f4bbd8ab89cea16aaab70f0c1560d:

  mtip32xx: fix typo in comment (2022-05-21 06:32:27 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.19/drivers-2022-06-02

for you to fetch changes up to aacae8c469f9ce4b303a2eb61593ff522c1420bc:

  block: null_blk: Fix null_zone_write() (2022-06-02 07:11:28 -0600)

----------------------------------------------------------------
for-5.19/drivers-2022-06-02

----------------------------------------------------------------
Christoph Hellwig (3):
      md: remove most calls to bdevname
      block, loop: support partitions without scanning
      nvme-pci: disable namespace identifiers for the MAXIO MAP1001

Coly Li (6):
      bcache: improve multithreaded bch_btree_check()
      bcache: improve multithreaded bch_sectors_dirty_init()
      bcache: remove incremental dirty sector counting for bch_sectors_dirty_init()
      bcache: avoid journal no-space deadlock by reserving 1 journal bucket
      bcache: memset on stack variables in bch_btree_check() and bch_sectors_dirty_init()
      bcache: avoid unnecessary soft lockup in kworker update_writeback_rate()

Damien Le Moal (1):
      block: null_blk: Fix null_zone_write()

Guoqing Jiang (2):
      md: don't unregister sync_thread with reconfig_mutex held
      md: protect md_unregister_thread from reentrancy

Jens Axboe (2):
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.19/drivers
      Merge tag 'nvme-5.19-2022-06-02' of git://git.infradead.org/nvme into for-5.19/drivers

Jia-Ju Bai (1):
      md: bcache: check the return value of kzalloc() in detached_dev_do_request()

Julia Lawall (1):
      nvmet: fix typo in comment

Niklas Cassel (1):
      nvme: set controller enable bit in a separate write

Xiao Ni (2):
      md: Don't set mddev private to NULL in raid0 pers->free
      md: fix double free of io_acct_set bioset

Yu Kuai (5):
      nbd: call genl_unregister_family() first in nbd_cleanup()
      nbd: fix race between nbd_alloc_config() and module removal
      nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
      nbd: fix io hung while disconnecting device
      nbd: use pr_err to output error message

Zhang Wensheng (1):
      nbd: fix possible overflow on 'first_minor' in nbd_dev_add()

 block/genhd.c                     |   2 +
 drivers/block/loop.c              |   8 +-
 drivers/block/nbd.c               | 114 +++++++++++++----------
 drivers/block/null_blk/main.c     |   6 --
 drivers/block/null_blk/null_blk.h |   7 ++
 drivers/block/null_blk/zoned.c    |   6 +-
 drivers/md/bcache/bcache.h        |   7 ++
 drivers/md/bcache/btree.c         |  59 ++++++------
 drivers/md/bcache/btree.h         |   2 +-
 drivers/md/bcache/journal.c       |  31 +++++--
 drivers/md/bcache/journal.h       |   2 +
 drivers/md/bcache/request.c       |   6 ++
 drivers/md/bcache/super.c         |   1 +
 drivers/md/bcache/writeback.c     | 131 ++++++++++++---------------
 drivers/md/bcache/writeback.h     |   2 +-
 drivers/md/dm-raid.c              |   2 +-
 drivers/md/md-linear.c            |   5 +-
 drivers/md/md-multipath.c         |  15 ++--
 drivers/md/md.c                   | 185 +++++++++++++++++---------------------
 drivers/md/md.h                   |   2 +-
 drivers/md/raid0.c                |  29 +++---
 drivers/md/raid1.c                |  24 +++--
 drivers/md/raid10.c               |  54 +++++------
 drivers/md/raid5-cache.c          |   5 +-
 drivers/md/raid5-ppl.c            |  27 +++---
 drivers/md/raid5.c                |  37 ++++----
 drivers/nvme/host/core.c          |  10 ++-
 drivers/nvme/host/pci.c           |   2 +
 drivers/nvme/target/passthru.c    |   2 +-
 include/linux/blkdev.h            |   1 +
 30 files changed, 394 insertions(+), 390 deletions(-)

-- 
Jens Axboe


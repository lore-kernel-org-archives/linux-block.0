Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6FDC433E0
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 16:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F66822527
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 16:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbhAJQYe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 11:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbhAJQYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 11:24:33 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331DBC061794
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 08:23:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f14so6299167pju.4
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9LE3tKJoLPti5Bv5ITA0hso/5BdQW6vQ2MnMdBvJzaU=;
        b=YgPDenPQ8DN+DYixFJmYSwtBSDVNv8Lc8J8W4hs1MeYYHVlXibCbdQXT72bmXRN/EC
         vPr7LFR7JfOl1zRQgIEOKCU7XmDiEZmV7JeBdDbQc8j6XWXm1Ur8p8BSVDE3EZt+7Xov
         6A/eyo5jvD2EbyVfnfPH7NMbYB/xkydUz/cSz8U9ESH8BJ/iblfaQtEeJs4PmQZEIMIx
         Rg2HsBPIPykgi4sfa6EUQiAdxOOKHkDJUGri5Rq2C8yKo+8K1hdjQ1gfgWXv/n/5P3hq
         p/0UWmsraslnv1QhkJo7UXmu7cCzWPYGoOPWcJzW1nGFGHzViYu4bHIrPAMmJclsjc4n
         PKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9LE3tKJoLPti5Bv5ITA0hso/5BdQW6vQ2MnMdBvJzaU=;
        b=GALBZpCNTr78/dnpqXZApOMDfDxYpgDaJYa9rFqpXLaFn6alRm8KPJcfpIOitEBMK9
         avTEaSAdOf/WFnP4yBvijPiLj1IafjomNYe5guKrdCbXU8YrospE1W6ZeC2kQ2EB0Ias
         KCJMmzqXXHYf+2R1vdemP4QOnCZxF1uHrX1X9fHEI/h0jjcji6+hhExeNlQvTwNuP3gU
         4pQdTgNBgp0IrGIuImI6weEaudw+fsd8fZhW27gcXAejbvZ8JMfYJbLE5dvBYHP1jMx3
         Vr4np4U8gOh4foXMVF1U8h4eJ+cIiyDwqQyrxSJhBlgsp5lvbdSOK1WT2I316m37aeF+
         jC2w==
X-Gm-Message-State: AOAM532xHdp3/o8UM2m49/DmZwjQypd+wHVrQAo+hdosGUmE3koAtILQ
        kbllPlCQy8Cx576Fe5ifbJFA7lSqAZyUzw==
X-Google-Smtp-Source: ABdhPJymh06xVwPzERSrduOX440jwpG4w51eU3y26LPa/c0UK63h4P+K4aqOe7jQwCa02+7T/SbF0Q==
X-Received: by 2002:a17:902:ee02:b029:db:c0d6:57f9 with SMTP id z2-20020a170902ee02b02900dbc0d657f9mr12909725plb.65.1610295832459;
        Sun, 10 Jan 2021 08:23:52 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y6sm21212148pjl.0.2021.01.10.08.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 08:23:51 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.11-rc3
Message-ID: <f53ed2e5-3ee5-0e2f-6d4f-ed6a70a1981a@kernel.dk>
Date:   Sun, 10 Jan 2021 09:23:51 -0700
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

- Missing CRC32 selections (Arnd)

- Fix for a merge window regression with bdev inode init (Christoph)

- bcache fixes

- rnbd fixes

- NVMe pull request from Christoph:
	- fix a race in the nvme-tcp send code (Sagi Grimberg)
	- fix a list corruption in an nvme-rdma error path
	  (Israel Rukshin)
	- avoid a possible double fetch in nvme-pci
	  (Lalithambika Krishnakumar)
	- add the susystem NQN quirk for a Samsung driver
	  (Gopal Tiwari)
	- fix two compiler warnings in nvme-fcloop (James Smart)
	- don't call sleeping functions from irq context in nvme-fc
	  (James Smart)
	- remove an unused argument (Max Gurtovoy)
	- remove unused exports (Minwoo Im)

- Use-after-free fix for partition iteration (Ming)

- Missing blk-mq debugfs flag annotation (John)

- Bdev freeze regression fix (Satya)

- blk-iocost NULL pointer deref fix (Tejun)

Please pull!


The following changes since commit dc30432605bbbd486dfede3852ea4d42c40a84b4:

  block: add debugfs stanza for QUEUE_FLAG_NOWAIT (2020-12-29 16:47:46 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-10

for you to fetch changes up to 5342fd4255021ef0c4ce7be52eea1c4ebda11c63:

  bcache: set bcache device into read-only mode for BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET (2021-01-09 09:21:03 -0700)

----------------------------------------------------------------
block-5.11-2021-01-10

----------------------------------------------------------------
Arnd Bergmann (2):
      block: rsxx: select CONFIG_CRC32
      lightnvm: select CONFIG_CRC32

Christoph Hellwig (1):
      block: pre-initialize struct block_device in bdev_alloc_inode

Coly Li (4):
      bcache: fix typo from SUUP to SUPP in features.h
      bcache: check unsupported feature sets for bcache register
      bcache: introduce BCH_FEATURE_INCOMPAT_LOG_LARGE_BUCKET_SIZE for large bucket
      bcache: set bcache device into read-only mode for BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET

Gopal Tiwari (1):
      nvme-pci: mark Samsung PM1725a as IGNORE_DEV_SUBNQN

Guoqing Jiang (1):
      block/rnbd-clt: Fix sg table use after free

Israel Rukshin (1):
      nvmet-rdma: Fix list_del corruption on queue establishment failure

Jack Wang (3):
      block/rnbd: Select SG_POOL for RNBD_CLIENT
      block/rnbd-srv: Fix use after free in rnbd_srv_sess_dev_force_close
      block/rnbd-clt: avoid module unload race with close confirmation

James Smart (2):
      nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios from interrupt context
      nvme-fcloop: Fix sscanf type and list_first_entry_or_null warnings

Jan Kara (1):
      bfq: Fix computation of shallow depth

Jens Axboe (1):
      Merge tag 'nvme-5.11-2021-01-07' of git://git.infradead.org/nvme into block-5.11

John Garry (1):
      blk-mq-debugfs: Add decode for BLK_MQ_F_TAG_HCTX_SHARED

Lalithambika Krishnakumar (1):
      nvme: avoid possible double fetch in handling CQE

Max Gurtovoy (1):
      nvme: remove the unused status argument from nvme_trace_bio_complete

Ming Lei (1):
      block: fix use-after-free in disk_part_iter_next

Minwoo Im (1):
      nvme: unexport functions with no external caller

Sagi Grimberg (1):
      nvme-tcp: Fix possible race of io_work and direct send

Satya Tangirala (1):
      fs: Fix freeze_bdev()/thaw_bdev() accounting of bd_fsfreeze_sb

Swapnil Ingle (1):
      block/rnbd: Adding name to the Contributors List

Tejun Heo (1):
      blk-iocost: fix NULL iocg deref from racing against initialization

Yi Li (1):
      bcache: set pdev_set_uuid before scond loop iteration

 block/bfq-iosched.c           |  8 +++----
 block/blk-iocost.c            | 16 +++++++++----
 block/blk-mq-debugfs.c        |  1 +
 block/genhd.c                 | 11 +++++----
 drivers/block/Kconfig         |  1 +
 drivers/block/rnbd/Kconfig    |  1 +
 drivers/block/rnbd/README     |  1 +
 drivers/block/rnbd/rnbd-clt.c | 18 +++++++--------
 drivers/block/rnbd/rnbd-srv.c |  8 ++++---
 drivers/lightnvm/Kconfig      |  1 +
 drivers/md/bcache/features.c  |  2 +-
 drivers/md/bcache/features.h  | 30 ++++++++++++++++++++----
 drivers/md/bcache/super.c     | 53 +++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/core.c      |  8 +++----
 drivers/nvme/host/fc.c        | 15 +++++++++++-
 drivers/nvme/host/nvme.h      |  9 ++------
 drivers/nvme/host/pci.c       | 10 ++++----
 drivers/nvme/host/tcp.c       | 12 +++++++++-
 drivers/nvme/target/fcloop.c  |  7 +++---
 drivers/nvme/target/rdma.c    | 10 ++++++++
 fs/block_dev.c                |  7 ++++--
 include/uapi/linux/bcache.h   |  2 +-
 22 files changed, 172 insertions(+), 59 deletions(-)

-- 
Jens Axboe


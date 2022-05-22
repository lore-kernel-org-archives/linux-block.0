Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CADCC433EF
	for <linux-block@archiver.kernel.org>; Sun, 22 May 2022 22:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiEVWAi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 May 2022 18:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiEVWAh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 May 2022 18:00:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10829C82
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 15:00:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l14so12405703pjk.2
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 15:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=q/BGPJ0kTW90Qt4FQhm8M70CxmiiM7eCaT0D6/acFUY=;
        b=8GRFDc1lyIxiXa0TIp4KxpCdauKVqal3Yu8TGMZf03KywH1Lo+jjTQiNuVcKni2UJq
         GpZu+sH5NjFMgiLt0OhW3KrCHZNhMIxk4gtlfjEWIOm90X875qOOyZKL1buIm0fO4AjQ
         2bsvQtX5VMRbdiULknYwtd+WxMeDPdFqVjBb94dROiyQ+NSs+f/2aQcqDPdTYsEV3s82
         DtoGZFTMruGGa3yAIHxPz4qZWy8kP6E1fhb9gdUcsgUAKNlvUL0i9wCOygTO7rT0rR5d
         q2sVUGyc7S/14HlI2NRY1X1828MZBelgtZQY0ShwMNlPzxHLdAwWuEAMzf+2pNGDtZsM
         xaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=q/BGPJ0kTW90Qt4FQhm8M70CxmiiM7eCaT0D6/acFUY=;
        b=pBT7MQiSdcO/mNDZhDjSdpMK5epQn73LNbC0txLrXS6TiUcmfP88oSzLQpgIBAhhQm
         cVh/rNbko44UGQN1ZF7yk772Y55HgRzEvGCEgRTVCqGrXJ2bAHduhNEO87NW3u1bs8+p
         LczvraeGxD5tKbUdFla7UzeLVLUhuDz1/Ol+ZbVl6OxuZRLj+98VJ5rneBzs+JjMpYVp
         HXLLbcI6H/2cfeT23PkAwmPXQwyrPy2nfLgY0Hjsb7lI1GDaByqmVWQZ3C3RxzclF874
         vnmVHQFs47oBwZcVuTuoO+AK+LPNpUjy4/Oip21KPg7vciG3AgvP0fSNnUyugRV3mYQQ
         vYNw==
X-Gm-Message-State: AOAM533F6uusqIHEcSq9f068v9jiW+kHYiPaImTpm1iKAXpGP4ZJ6Jeq
        KL4UNifUGafNJKPiLACd/gsdalsHkrdJ1w==
X-Google-Smtp-Source: ABdhPJzhxTWd1ij2Z+GxmiaSd9zZpGvb/frHhjFFQ6QsdIfmARyDmudBN4d9qamJSn4E8Kbvoc2tTw==
X-Received: by 2002:a17:902:bcc6:b0:15f:4990:baec with SMTP id o6-20020a170902bcc600b0015f4990baecmr19943098pls.102.1653256834927;
        Sun, 22 May 2022 15:00:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v17-20020a62c311000000b005087c23ad8dsm5819559pfg.0.2022.05.22.15.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 15:00:34 -0700 (PDT)
Message-ID: <78d44e6d-cc98-83a6-8bb3-2b9e75501cfe@kernel.dk>
Date:   Sun, 22 May 2022 16:00:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver updates for 5.19-rc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core block changes, here are the driver updates queued up
for 5.19. This pull request contains:

- NVMe pull requests via Christoph:
	- tighten the PCI presence check (Stefan Roese)
	- fix a potential NULL pointer dereference in an error path
	  (Kyle Miller Smith)
	- fix interpretation of the DMRSL field (Tom Yan)
	- relax the data transfer alignment (Keith Busch)
	- verbose error logging improvements
	  (Max Gurtovoy, Chaitanya Kulkarni)
	- misc cleanups (Chaitanya Kulkarni, Christoph)
	- set non-mdts limits in nvme_scan_work (Chaitanya Kulkarni)
	- add support for TP4084 - Time-to-Ready Enhancements
	  (Christoph)

- MD pull request via Song:
	- Improve annotation in raid5 code, by Logan Gunthorpe
	- Support MD_BROKEN flag in raid-1/5/10, by Mariusz Tkaczyk
	- Other small fixes/cleanups

- null_blk series making the configfs side much saner (Damien)

- Various minor drbd cleanups and fixes (Haowen, Uladzislau, Jiapeng,
  Arnd, Cai)

- Avoid using the system workqueue (and hence flushing it) in rnbd
  (Jack)

- Avoid using the system workqueue (and hence flushing it) in aoe
  (Tetsuo)

- Series fixing discard_alignment issues in drivers (Christoph)

- Small series fixing drivers poking at disk->part0 for openers
  information (Christoph)

- Series fixing deadlocks in loop (Christoph, Tetsuo)

- Remove loop.h and add SPDX headers (Christoph)

- Various fixes and cleanups (Julia, Xie, Yu)

Please pull!


The following changes since commit c22198e78d523c8fa079bbb70b2523bb6aa51849:

  direct-io: remove random prefetches (2022-04-17 19:50:02 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.19/drivers-2022-05-22

for you to fetch changes up to 537b9f2bf60f4bbd8ab89cea16aaab70f0c1560d:

  mtip32xx: fix typo in comment (2022-05-21 06:32:27 -0600)

----------------------------------------------------------------
for-5.19/drivers-2022-05-22

----------------------------------------------------------------
Arnd Bergmann (2):
      drbd: fix duplicate array initializer
      drbd: address enum mismatch warnings

Cai Huoqing (2):
      drbd: Make use of PFN_UP helper macro
      drbd: Replace "unsigned" with "unsigned int"

Chaitanya Kulkarni (3):
      nvme: mark internal passthru request RQF_QUIET
      nvme-fabrics: add a request timeout helper
      nvme: set non-mdts limits in nvme_scan_work

Christoph Hellwig (31):
      nbd: use the correct block_device in nbd_bdev_reset
      zram: cleanup reset_store
      zram: cleanup zram_remove
      block: add a disk_openers helper
      block: turn bdev->bd_openers into an atomic_t
      loop: de-duplicate the idle worker freeing code
      loop: initialize the worker tracking fields once
      loop: remove the racy bd_inode->i_mapping->nrpages asserts
      loop: don't freeze the queue in lo_release
      loop: only freeze the queue in __loop_clr_fd when needed
      loop: implement ->free_disk
      loop: suppress uevents while reconfiguring the device
      loop: remove lo_refcount and avoid lo_mutex in ->open / ->release
      loop: don't destroy lo->workqueue in __loop_clr_fd
      ubd: don't set the discard_alignment queue limit
      nbd: don't set the discard_alignment queue limit
      null_blk: don't set the discard_alignment queue limit
      virtio_blk: fix the discard_granularity and discard_alignment queue limits
      dm-zoned: don't set the discard_alignment queue limit
      raid5: don't set the discard_alignment queue limit
      dasd: don't set the discard_alignment queue limit
      loop: remove a spurious clear of discard_alignment
      nvme: remove a spurious clear of discard_alignment
      rnbd-srv: use bdev_discard_alignment
      xen-blkback: use bdev_discard_alignment
      loop: remove loop.h
      loop: add a SPDX header
      loop: remove most the top-of-file boilerplate comment
      loop: remove most the top-of-file boilerplate comment from the UAPI header
      nvme: split the enum used for various register constants
      nvme: add support for TP4084 - Time-to-Ready Enhancements

Damien Le Moal (4):
      block: null_blk: Fix code style issues
      block: null_blk: Cleanup device creation and deletion
      block: null_blk: Cleanup messages
      block: null_blk: Improve device creation with configfs

David Sloan (1):
      md: Replace role magic numbers with defined constants

Haowen Bai (1):
      drbd: Return true/false (not 1/0) from bool functions

Heming Zhao (2):
      md/bitmap: don't set sb values if can't pass sanity check
      md: replace deprecated strlcpy & remove duplicated line

Jack Wang (1):
      block/rnbd-clt: Avoid flush_workqueue(system_long_wq) usage

Jens Axboe (3):
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.19/drivers
      Merge tag 'nvme-5.19-2022-05-18' of git://git.infradead.org/nvme into for-5.19/drivers
      Merge tag 'nvme-5.19-2022-05-19' of git://git.infradead.org/nvme into for-5.19/drivers

Jiapeng Chong (1):
      block: drbd: drbd_receiver: Remove redundant assignment to err

Julia Lawall (1):
      mtip32xx: fix typo in comment

Keith Busch (1):
      nvme: set dma alignment to dword

Logan Gunthorpe (7):
      md/raid5: Cleanup setup_conf() error returns
      md/raid5: Un-nest struct raid5_percpu definition
      md/raid5: Add __rcu annotation to struct disk_info
      md/raid5: Annotate rdev/replacement accesses when nr_pending is elevated
      md/raid5: Annotate rdev/replacement access when mddev_lock is held
      md/raid5-ppl: Annotate with rcu_dereference_protected()
      md/raid5: Annotate functions that hold device_lock with __must_hold

Mariusz Tkaczyk (2):
      md: Set MD_BROKEN for RAID1 and RAID10
      raid5: introduce MD_BROKEN

Max Gurtovoy (2):
      nvme: add missing status values to verbose logging
      nvme: remove unneeded include from constants file

Pascal Hambourg (1):
      md/raid0: Ignore RAID0 layout if the second zone has only one device

Smith, Kyle Miller (Nimble Kernel) (1):
      nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags

Stefan Roese (1):
      nvme-pci: harden drive presence detect in nvme_dev_disable()

Tetsuo Handa (2):
      loop: avoid loop_validate_mutex/lo_mutex in ->release
      aoe: Avoid flush_scheduled_work() usage

Tom Yan (1):
      nvme: fix interpretation of DMRSL

Uladzislau Rezki (Sony) (1):
      drdb: Switch to kvfree_rcu() API

Xiaomeng Tong (2):
      md: fix an incorrect NULL check in does_sb_need_changing
      md: fix an incorrect NULL check in md_reload_sb

Xie Yongji (1):
      nbd: Fix hung on disconnect request if socket is closed before

Yu Kuai (1):
      null-blk: save memory footprint for struct nullb_cmd

 arch/um/drivers/ubd_kern.c         |   1 -
 block/bdev.c                       |  16 +-
 block/partitions/core.c            |   2 +-
 drivers/block/aoe/aoe.h            |   2 +
 drivers/block/aoe/aoeblk.c         |   2 +-
 drivers/block/aoe/aoecmd.c         |   2 +-
 drivers/block/aoe/aoedev.c         |   4 +-
 drivers/block/aoe/aoemain.c        |  10 +-
 drivers/block/drbd/drbd_bitmap.c   |   2 +-
 drivers/block/drbd/drbd_main.c     |  11 +-
 drivers/block/drbd/drbd_nl.c       |  33 ++--
 drivers/block/drbd/drbd_receiver.c |  15 +-
 drivers/block/drbd/drbd_req.c      |   2 +-
 drivers/block/drbd/drbd_state.c    |   3 +-
 drivers/block/drbd/drbd_worker.c   |   2 +-
 drivers/block/loop.c               | 366 +++++++++++++++++--------------------
 drivers/block/loop.h               |  72 --------
 drivers/block/mtip32xx/mtip32xx.c  |   2 +-
 drivers/block/nbd.c                |  32 ++--
 drivers/block/null_blk/main.c      |  92 +++++++---
 drivers/block/null_blk/null_blk.h  |   8 +-
 drivers/block/null_blk/zoned.c     |   7 +-
 drivers/block/rnbd/rnbd-clt.c      |  14 +-
 drivers/block/rnbd/rnbd-srv-dev.h  |   2 +-
 drivers/block/virtio_blk.c         |   7 +-
 drivers/block/xen-blkback/xenbus.c |   5 +-
 drivers/block/zram/zram_drv.c      |  29 ++-
 drivers/md/dm-zoned-target.c       |   2 +-
 drivers/md/md-bitmap.c             |  45 ++---
 drivers/md/md-cluster.c            |   2 +-
 drivers/md/md.c                    |  62 ++++---
 drivers/md/md.h                    |  62 ++++---
 drivers/md/raid0.c                 |  31 ++--
 drivers/md/raid1.c                 |  43 +++--
 drivers/md/raid10.c                |  40 ++--
 drivers/md/raid5-ppl.c             |  13 +-
 drivers/md/raid5.c                 | 227 ++++++++++++++---------
 drivers/md/raid5.h                 |  23 ++-
 drivers/nvme/host/constants.c      |   5 +-
 drivers/nvme/host/core.c           | 105 +++++++++--
 drivers/nvme/host/fabrics.h        |   8 +
 drivers/nvme/host/nvme.h           |   1 +
 drivers/nvme/host/pci.c            |   5 +-
 drivers/nvme/host/rdma.c           |   5 +-
 drivers/nvme/host/tcp.c            |   5 +-
 drivers/s390/block/dasd_fba.c      |   1 -
 include/linux/blk_types.h          |   2 +-
 include/linux/blkdev.h             |  15 ++
 include/linux/nvme.h               |  46 ++++-
 include/uapi/linux/loop.h          |   7 +-
 50 files changed, 845 insertions(+), 653 deletions(-)
 delete mode 100644 drivers/block/loop.h

-- 
Jens Axboe


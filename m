Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B6AC11F67
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 19:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D5F613E3
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 19:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhF2TmF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhF2TmF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 15:42:05 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39325C061760
        for <linux-block@vger.kernel.org>; Tue, 29 Jun 2021 12:39:37 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l5so118749iok.7
        for <linux-block@vger.kernel.org>; Tue, 29 Jun 2021 12:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/NEzZFPrrLxOS7WIZR8O5KD5P+/pfZKRTNL1he6dMvw=;
        b=emobG4snOmDrl6Ho/2Ct0VsoQsuKzmb5yY1anY9Be+dqskfbhZLZ7nxcGl9WaX7jSo
         NEtROe70bRfzsfTPbsS5JOGF+0lM0Ci9ym+czemddGPRt5jc1lX5dAQjYwqITnrDY0dP
         XfVKAQ2YifWHi3Dw9Zq3Gz5nD0UhVaq3yVnOLYPR7Q39uxhb/c0rvrAnCuiDFz0ejZJw
         hnNHYFRS6lY/TAcZUReNI7JcBMD+o/ckW5qV2gXhNnBRl8CK4c4tsFizSNHdKc+Xyu6H
         hZs6OO2oXA8tkGnQT22Her7RqVkY/0Yvwo/q85c5Ja4jrfZh2XObd7oqy0fHmOwH9/GT
         ipOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/NEzZFPrrLxOS7WIZR8O5KD5P+/pfZKRTNL1he6dMvw=;
        b=e3vudQ/lf++8BRBWrWBCxWtmsEik8mlvs0+onSxDtsh4Wf7Uk5/eHssRgBpzZzxEKa
         uDrVR5M50OwKy/m2ohzwQWd9E+cZDbW8exWk5LKzAIWDL6YcWu4X5PFOgUKLOaNZ9+ld
         tMF9p6CZyPlWqjZUSZf+uXTG7JdgcUF4q42r1kQU7ARds8IuAmGkUHUXRahOTlguFbzt
         mXvpd6ch3XTOEOuI4QETnuTNFa1TmRW2PUlcQPnVvxDYsQ/3z6e6tgu604i+ZpnXYS0I
         MXMJ3RPBuNjK3ASWRhL7dpR3/nJy7ctaUwcLSiNywIJMWCNJK48JIAQiIwHN5k+x1CAv
         Nldg==
X-Gm-Message-State: AOAM533h2HBrfxyX8RsOO2VtdXRKFKrZgDjz1A9z0ATVm3xDemmGYoRQ
        /AhvT73u6B5FrUkEbqAgUGdFB3nmTozh6Q==
X-Google-Smtp-Source: ABdhPJzf8PKX+Wxx2rS4g2U66m7asXmfvD5CObaaymZzXp5hYOWpgr8IMlmyrJzVdngaI/lqOnE09g==
X-Received: by 2002:a02:9665:: with SMTP id c92mr5784343jai.56.1624995575988;
        Tue, 29 Jun 2021 12:39:35 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id h18sm10415978ilr.86.2021.06.29.12.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 12:39:35 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Core block changes for 5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <ab2255de-8bbc-8c6f-7309-25cbb506000f@kernel.dk>
Date:   Tue, 29 Jun 2021 13:39:34 -0600
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

Here are the core block changes for the 5.14-rc1 merge window. This pull
request contains:

- disk events cleanup (Christoph)

- gendisk and request queue allocation simplifications (Christoph)

- bdev_disk_changed cleanups (Christoph)

- IO priority improvements (Bart)

- Chained bio completion trace fix (Edward)

- blk-wbt fixes (Jan)

- blk-wbt enable/disable fix (Zhang)

- Scheduler dispatch improvements (Jan, Ming)

- Shared tagset scheduler improvements (John)

- BFQ updates (Paolo, Luca, Pietro)

- BFQ lock inversion fix (Jan)

- Documentation improvements (Kir)

- CLONE_IO block cgroup fix (Tejun)

- Remove of ancient and deprecated block dump feature (zhangyi)

- Discard merge fix (Ming)

- Misc fixes or followup fixes (Colin, Damien, Dan, Long, Max, Thomas,
  Yang)

Please pull!


The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.14/block-2021-06-29

for you to fetch changes up to 2705dfb2094777e405e065105e307074af8965c1:

  block: fix discard request merge (2021-06-29 07:41:08 -0600)

----------------------------------------------------------------
for-5.14/block-2021-06-29

----------------------------------------------------------------
Bart Van Assche (18):
      block: Update blk_update_request() documentation
      block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ entries consecutive
      block/blk-cgroup: Swap the blk_throtl_init() and blk_iolatency_init() calls
      block/blk-rq-qos: Move a function from a header file into a C file
      block: Introduce the ioprio rq-qos policy
      block/mq-deadline: Add several comments
      block/mq-deadline: Add two lockdep_assert_held() statements
      block/mq-deadline: Remove two local variables
      block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()
      block/mq-deadline: Improve compile-time argument checking
      block/mq-deadline: Improve the sysfs show and store macros
      block/mq-deadline: Reserve 25% of scheduler tags for synchronous requests
      block/mq-deadline: Micro-optimize the batching algorithm
      block/mq-deadline: Add I/O priority support
      block/mq-deadline: Track I/O statistics
      block/mq-deadline: Add cgroup support
      block/mq-deadline: Prioritize high-priority requests
      block/mq-deadline: Remove a WARN_ON_ONCE() call

Christoph Hellwig (70):
      block: refactor device number setup in __device_add_disk
      block: move the DISK_MAX_PARTS sanity check into __device_add_disk
      block: automatically enable GENHD_FL_EXT_DEVT
      block: add a flag to make put_disk on partially initalized disks safer
      block: add blk_alloc_disk and blk_cleanup_disk APIs
      brd: convert to blk_alloc_disk/blk_cleanup_disk
      drbd: convert to blk_alloc_disk/blk_cleanup_disk
      pktcdvd: convert to blk_alloc_disk/blk_cleanup_disk
      rsxx: convert to blk_alloc_disk/blk_cleanup_disk
      zram: convert to blk_alloc_disk/blk_cleanup_disk
      lightnvm: convert to blk_alloc_disk/blk_cleanup_disk
      bcache: convert to blk_alloc_disk/blk_cleanup_disk
      dm: convert to blk_alloc_disk/blk_cleanup_disk
      md: convert to blk_alloc_disk/blk_cleanup_disk
      nvdimm-blk: convert to blk_alloc_disk/blk_cleanup_disk
      nvdimm-btt: convert to blk_alloc_disk/blk_cleanup_disk
      nvdimm-pmem: convert to blk_alloc_disk/blk_cleanup_disk
      nvme-multipath: convert to blk_alloc_disk/blk_cleanup_disk
      nfblock: convert to blk_alloc_disk/blk_cleanup_disk
      simdisk: convert to blk_alloc_disk/blk_cleanup_disk
      n64cart: convert to blk_alloc_disk
      ps3vram: convert to blk_alloc_disk/blk_cleanup_disk
      dcssblk: convert to blk_alloc_disk/blk_cleanup_disk
      xpram: convert to blk_alloc_disk/blk_cleanup_disk
      null_blk: convert to blk_alloc_disk/blk_cleanup_disk
      block: unexport blk_alloc_queue
      block: split __blkdev_get
      block: move sync_blockdev from __blkdev_put to blkdev_put
      block: move bd_mutex to struct gendisk
      block: move adjusting bd_part_count out of __blkdev_get
      block: split __blkdev_put
      block: move bd_part_count to struct gendisk
      block: factor out a part_devt helper
      block: remove bdget_disk
      blk-mq: factor out a blk_mq_alloc_sq_tag_set helper
      blk-mq: improve the blk_mq_init_allocated_queue interface
      blk-mq: add the blk_mq_alloc_disk APIs
      virtio-blk: use blk_mq_alloc_disk
      pcd: use blk_mq_alloc_disk
      pf: use blk_mq_alloc_disk
      ms_block: use blk_mq_alloc_disk
      mspro: use blk_mq_alloc_disk
      mtd_blkdevs: use blk_mq_alloc_disk
      ps3disk: use blk_mq_alloc_disk
      swim3: use blk_mq_alloc_disk
      swim: use blk_mq_alloc_disk
      sunvdc: use blk_mq_alloc_disk
      gdrom: use blk_mq_alloc_disk
      blk-mq: remove blk_mq_init_sq_queue
      aoe: use blk_mq_alloc_disk and blk_cleanup_disk
      floppy: use blk_mq_alloc_disk and blk_cleanup_disk
      loop: use blk_mq_alloc_disk and blk_cleanup_disk
      nbd: use blk_mq_alloc_disk and blk_cleanup_disk
      nullb: use blk_mq_alloc_disk
      pd: use blk_mq_alloc_disk and blk_cleanup_disk
      rbd: use blk_mq_alloc_disk and blk_cleanup_disk
      rnbd: use blk_mq_alloc_disk and blk_cleanup_disk
      sx8: use blk_mq_alloc_disk and blk_cleanup_disk
      xen-blkfront: use blk_mq_alloc_disk and blk_cleanup_disk
      ubi: use blk_mq_alloc_disk and blk_cleanup_disk
      scm_blk: use blk_mq_alloc_disk and blk_cleanup_disk
      amiflop: use blk_mq_alloc_disk and blk_cleanup_disk
      ataflop: use blk_mq_alloc_disk and blk_cleanup_disk
      z2ram: use blk_mq_alloc_disk and blk_cleanup_disk
      mtd_blkdevs: initialze new->rq in add_mtd_blktrans_dev
      loop: fix order of cleaning up the queue and freeing the tagset
      block: move the disk events code to a separate file
      block: add the events* attributes to disk_attrs
      block: move bdev_disk_changed
      block: pass a gendisk to bdev_disk_changed

Colin Ian King (1):
      null_blk: Fix null pointer dereference on nullb->disk on blk_cleanup_disk call

Damien Le Moal (1):
      block: Remove unnecessary elevator operation checks

Dan Carpenter (1):
      blk-mq: fix an IS_ERR() vs NULL bug

Dan Williams (1):
      libnvdimm/pmem: Fix blk_cleanup_disk() usage

Edward Hsieh (1):
      block: fix trace completion for chained bio

Jan Kara (4):
      block: Do not pull requests from the scheduler when we cannot dispatch them
      rq-qos: fix missed wake-ups in rq_qos_throttle try two
      bfq: Remove merged request already in bfq_requests_merged()
      blk: Fix lock inversion between ioc lock and bfqd lock

John Garry (2):
      blk-mq: Some tag allocation code refactoring
      blk-mq: Use request queue-wide tags for tagset-wide sbitmap

Kir Kolyshkin (3):
      docs: block/bfq: describe per-device weight
      docs/cgroup-v1/blkio: stop abusing itemized list
      docs/cgroup-v1/blkio: update for 5.x kernels

Long Li (1):
      block: return the correct bvec when checking for gaps

Luca Mariotti (1):
      block, bfq: fix delayed stable merge check

Max Gurtovoy (1):
      block: remove unneeded parenthesis from blk-sysfs

Ming Lei (9):
      block: avoid double io accounting for flush request
      blk-mq: grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter
      blk-mq: clear stale request in tags->rq[] before freeing one request pool
      blk-mq: clearing flush request reference in tags->rqs[]
      block: fix race between adding/removing rq qos and normal IO
      block: mark queue init done at the end of blk_register_queue
      blk-mq: fix use-after-free in blk_mq_exit_sched
      blk-mq: update hctx->dispatch_busy in case of real scheduler
      block: fix discard request merge

Paolo Valente (5):
      block, bfq: let also stably merged queues enjoy weight raising
      block, bfq: consider also creation time in delayed stable merge
      block, bfq: avoid delayed merge of async queues
      block, bfq: check waker only for queues with no in-flight I/O
      block, bfq: reset waker pointer with shared queues

Pietro Pedroni (1):
      block, bfq: boost throughput by extending queue-merging times

Tejun Heo (1):
      blkcg: drop CLONE_IO check in blkcg_can_attach()

Thomas Bracht Laumann Jespersen (1):
      block/partitions/msdos: Fix typo inidicator -> indicator

Yang Yingliang (1):
      aoe: remove unnecessary mutex_init()

Zhang Yi (2):
      blk-wbt: introduce a new disable state to prevent false positive by rwb_enabled()
      blk-wbt: make sure throttle is enabled properly

lijiazi (1):
      blk-wbt: remove outdated comment

zhangyi (F) (3):
      block_dump: remove block_dump feature in mark_inode_dirty()
      block_dump: remove block_dump feature
      block_dump: remove comments in docs

 .../admin-guide/cgroup-v1/blkio-controller.rst     |  155 +--
 Documentation/admin-guide/cgroup-v2.rst            |   55 +
 Documentation/admin-guide/laptops/laptop-mode.rst  |   11 -
 Documentation/admin-guide/sysctl/vm.rst            |    8 -
 Documentation/block/bfq-iosched.rst                |   38 +-
 Documentation/filesystems/locking.rst              |    2 +-
 arch/m68k/emu/nfblock.c                            |   20 +-
 arch/xtensa/platforms/iss/simdisk.c                |   29 +-
 block/Kconfig                                      |   19 +-
 block/Kconfig.iosched                              |    6 +
 block/Makefile                                     |    6 +-
 block/bfq-iosched.c                                |  115 +-
 block/bio.c                                        |   13 +-
 block/blk-cgroup.c                                 |   41 +-
 block/blk-core.c                                   |   22 +-
 block/blk-flush.c                                  |    3 +-
 block/blk-ioprio.c                                 |  262 +++++
 block/blk-ioprio.h                                 |   19 +
 block/blk-merge.c                                  |   27 +-
 block/blk-mq-debugfs.c                             |   15 +
 block/blk-mq-sched.c                               |   99 +-
 block/blk-mq-sched.h                               |    5 +-
 block/blk-mq-tag.c                                 |  114 +-
 block/blk-mq-tag.h                                 |   15 +-
 block/blk-mq.c                                     |  206 ++--
 block/blk-mq.h                                     |   14 +
 block/blk-rq-qos.c                                 |    4 +-
 block/blk-rq-qos.h                                 |   38 +-
 block/blk-sysfs.c                                  |   45 +-
 block/blk-wbt.c                                    |   12 +-
 block/blk-wbt.h                                    |    1 +
 block/blk.h                                        |   17 +-
 block/disk-events.c                                |  469 ++++++++
 block/elevator.c                                   |   17 +-
 block/genhd.c                                      |  701 ++----------
 block/ioctl.c                                      |    2 +-
 block/mq-deadline-cgroup.c                         |  126 +++
 block/mq-deadline-cgroup.h                         |  114 ++
 block/mq-deadline-main.c                           | 1175 ++++++++++++++++++++
 block/mq-deadline.c                                |  815 --------------
 block/partitions/core.c                            |  129 ++-
 block/partitions/msdos.c                           |    2 +-
 drivers/block/amiflop.c                            |   16 +-
 drivers/block/aoe/aoeblk.c                         |   33 +-
 drivers/block/aoe/aoecmd.c                         |    2 -
 drivers/block/aoe/aoedev.c                         |    3 +-
 drivers/block/ataflop.c                            |   16 +-
 drivers/block/brd.c                                |   94 +-
 drivers/block/drbd/drbd_main.c                     |   23 +-
 drivers/block/floppy.c                             |   20 +-
 drivers/block/loop.c                               |   46 +-
 drivers/block/n64cart.c                            |    8 +-
 drivers/block/nbd.c                                |   53 +-
 drivers/block/null_blk/main.c                      |   37 +-
 drivers/block/paride/pcd.c                         |   19 +-
 drivers/block/paride/pd.c                          |   30 +-
 drivers/block/paride/pf.c                          |   18 +-
 drivers/block/pktcdvd.c                            |   11 +-
 drivers/block/ps3disk.c                            |   36 +-
 drivers/block/ps3vram.c                            |   31 +-
 drivers/block/rbd.c                                |   52 +-
 drivers/block/rnbd/rnbd-clt.c                      |   35 +-
 drivers/block/rsxx/dev.c                           |   39 +-
 drivers/block/rsxx/rsxx_priv.h                     |    1 -
 drivers/block/sunvdc.c                             |   47 +-
 drivers/block/swim.c                               |   34 +-
 drivers/block/swim3.c                              |   33 +-
 drivers/block/sx8.c                                |   23 +-
 drivers/block/virtio_blk.c                         |   26 +-
 drivers/block/xen-blkfront.c                       |  104 +-
 drivers/block/z2ram.c                              |   15 +-
 drivers/block/zram/zram_drv.c                      |   37 +-
 drivers/block/zram/zram_drv.h                      |    2 +-
 drivers/cdrom/gdrom.c                              |   45 +-
 drivers/lightnvm/core.c                            |   24 +-
 drivers/md/bcache/super.c                          |   15 +-
 drivers/md/dm-rq.c                                 |    9 +-
 drivers/md/dm.c                                    |   16 +-
 drivers/md/md.c                                    |   25 +-
 drivers/md/md.h                                    |    6 +-
 drivers/memstick/core/ms_block.c                   |   26 +-
 drivers/memstick/core/mspro_block.c                |   26 +-
 drivers/mtd/mtd_blkdevs.c                          |   49 +-
 drivers/mtd/ubi/block.c                            |   68 +-
 drivers/nvdimm/blk.c                               |   27 +-
 drivers/nvdimm/btt.c                               |   25 +-
 drivers/nvdimm/btt.h                               |    2 -
 drivers/nvdimm/pmem.c                              |   21 +-
 drivers/nvme/host/core.c                           |    1 -
 drivers/nvme/host/multipath.c                      |   46 +-
 drivers/s390/block/dasd_genhd.c                    |   12 +-
 drivers/s390/block/dcssblk.c                       |   26 +-
 drivers/s390/block/scm_blk.c                       |   21 +-
 drivers/s390/block/xpram.c                         |   26 +-
 drivers/scsi/sd.c                                  |    4 +-
 fs/block_dev.c                                     |  244 ++--
 fs/btrfs/volumes.c                                 |    2 +-
 fs/fs-writeback.c                                  |   25 -
 fs/super.c                                         |    8 +-
 include/linux/bio.h                                |   12 +-
 include/linux/blk-mq.h                             |   24 +-
 include/linux/blk_types.h                          |    4 -
 include/linux/blkdev.h                             |    5 +-
 include/linux/elevator.h                           |    4 +-
 include/linux/genhd.h                              |   32 +-
 include/linux/wait.h                               |    2 +-
 include/linux/writeback.h                          |    1 -
 init/do_mounts.c                                   |   10 +-
 kernel/sched/wait.c                                |    9 +-
 kernel/sysctl.c                                    |    8 -
 mm/page-writeback.c                                |    5 -
 111 files changed, 3776 insertions(+), 3069 deletions(-)
 create mode 100644 block/blk-ioprio.c
 create mode 100644 block/blk-ioprio.h
 create mode 100644 block/disk-events.c
 create mode 100644 block/mq-deadline-cgroup.c
 create mode 100644 block/mq-deadline-cgroup.h
 create mode 100644 block/mq-deadline-main.c
 delete mode 100644 block/mq-deadline.c

-- 
Jens Axboe


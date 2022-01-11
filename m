Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4218C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 21:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiAKVrJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244652AbiAKVrH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 16:47:07 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF34C061748
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 13:47:07 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id w9so738928iol.13
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 13:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/XOOphy/Re6PQQyuWxFUm3dRimPvMQu/VHe5XKL5tPs=;
        b=RE5Bn8e8hLDKfXn0opCoFDjRY4orv+NhqtRBx8Y3Sj4He1wszdijm+I625kjx6WbLN
         g8OlEZKRlnDht+CRZ2+K5XLIp3bPNQmLbZXaMrjRMEjZ+jawF9Pi3mGBR1icCX6Y1i30
         l/GidG8LGhAVgUnf1UgyFJdeIuMsulC97iCDXS9oEgQJ1WYeukVcbFkXD1f30R3OJU4y
         uDsGZZiBw6KFE1YmE6OCAyhgyrgdelc8J71jyFRzSh82owWSqBUr3gUXhkq31vRcPjJk
         1uzvSIpuh6QSEsJYjnJD7Zvcx3oxOQtZPnID9SdMDcwmj7m1873VeJ8+bj0H3J4jvb4N
         +DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/XOOphy/Re6PQQyuWxFUm3dRimPvMQu/VHe5XKL5tPs=;
        b=UqqOfojM6xbFSTtkbZy5+YAb15uItuXJxRIJRjb8Q9OIRWnrrYJTvIwyWPjtY/0ntS
         /1MeM5VVZsOGZhoeEiuvugHQy0C1L+VERm4b7hwBZ12nDh40yHttP0qKLEBCTj2T034b
         r+63A13kwqmJFFBlgSn50JSFlXhsH6DvfYaUFtb9SNdiEzPnDBLrCAEMDeg8ePPbVsq8
         n5q2gXPD4bu1tPnCGAxeaplffcqXN3xFfMvTUyoUW6fQnrR9GpucncbgEHdLyuZJTPhx
         nVr57RusmY6ekcMJ2EIJQR8MDtoK6IKggD0vEINCdElNKd/SUZs0yYUIi1v9VGzmffxm
         5q4w==
X-Gm-Message-State: AOAM531249lodiibwuHWpoQqSNqEsSs9Sogtww4apL6qew7pwLNowm8g
        xEwleifp4aV+qKp4YyUn8jqMnRyF+pPUeA==
X-Google-Smtp-Source: ABdhPJxFbOMqo6P6sIs/vQ7ri6KODxXFB4F3RjAh85O3Dqqw1vjJFdZz5a4cTNQRy6L14XEtwNs/zQ==
X-Received: by 2002:a02:6d15:: with SMTP id m21mr3237125jac.83.1641937626829;
        Tue, 11 Jan 2022 13:47:06 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a14sm6560980ilm.48.2022.01.11.13.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 13:47:06 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 5.17-rc
Message-ID: <c4086937-5e74-b8e8-d8a1-5e203c926c71@kernel.dk>
Date:   Tue, 11 Jan 2022 14:47:06 -0700
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

Here are the core block changes for the 5.17-rc1 merge window. This pull
request contains:

- Unify where the struct request handling code is located in the blk-mq
  code (Christoph)

- Header cleanups (Christoph)

- Clean up the io_context handling code (Christoph, me)

- Get rid of ->rq_disk in struct request (Christoph)

- Error handling fix for add_disk() (Christoph)

- request allocation cleanusp (Christoph)

- Documentation updates (Eric, Matthew)

- Remove trivial crypto unregister helper (Eric)

- Reduce shared tag overhead (John)

- Reduce poll_stats memory overhead (me)

- Known indirect function call for dio (me)

- Use atomic references for struct request (me)

- Support request list issue for block and NVMe (me)

- Improve queue dispatch pinning (Ming)

- Improve the direct list issue code (Keith)

- BFQ improvements (Jan)

- Direct completion helper and use it in mmc block (Sebastian)

- Use raw spinlock for the blktrace code (Wander)

- fsync error handling fix (Ye)

- Various fixes and cleanups (Lukas, Randy, Yang, Tetsuo, Ming, me)

Please pull!


The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.17/block-2022-01-11

for you to fetch changes up to f029cedb9bb5bab7f1bb3042be348f2dac0ee66e:

  MAINTAINERS: add entries for block layer documentation (2022-01-09 18:59:10 -0700)

----------------------------------------------------------------
for-5.17/block-2022-01-11

----------------------------------------------------------------
Christoph Hellwig (68):
      block: move blk_rq_err_bytes to scsi
      block: remove rq_flush_dcache_pages
      block: remove blk-exec.c
      blk-mq: move blk_mq_flush_plug_list
      block: move request based cloning helpers to blk-mq.c
      block: move blk_rq_init to blk-mq.c
      block: move blk_steal_bios to blk-mq.c
      block: move blk_account_io_{start,done} to blk-mq.c
      block: move blk_dump_rq_flags to blk-mq.c
      block: move blk_print_req_error to blk-mq.c
      block: don't include blk-mq headers in blk-core.c
      block: move GENHD_FL_NATIVE_CAPACITY to disk->state
      block: move GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE to disk->event_flags
      block: remove GENHD_FL_CD
      block: remove a dead check in show_partition
      block: merge disk_scan_partitions and blkdev_reread_part
      block: rename GENHD_FL_NO_PART_SCAN to GENHD_FL_NO_PART
      block: remove the GENHD_FL_HIDDEN check in blkdev_get_no_open
      null_blk: don't suppress partitioning information
      mmc: don't set GENHD_FL_SUPPRESS_PARTITION_INFO
      block: remove GENHD_FL_SUPPRESS_PARTITION_INFO
      block: remove GENHD_FL_EXT_DEVT
      block: don't set GENHD_FL_NO_PART for hidden gendisks
      block: cleanup the GENHD_FL_* definitions
      sr: set GENHD_FL_REMOVABLE earlier
      blk-mq: simplify the plug handling in blk_mq_submit_bio
      blk-mq: move more plug handling from blk_mq_submit_bio into blk_add_rq_to_plug
      block: move blk_get_flush_queue to blk-flush.c
      block: remove elevator_exit
      block: remove the e argument to elevator_exit
      block: don't include blk-mq-sched.h in blk.h
      block: don't include blk-mq.h in blk.h
      block: don't include <linux/blk-mq.h> in blk.h
      block: don't include <linux/idr.h> in blk.h
      block: don't include <linux/part_stat.h> in blk.h
      blk-mq: cleanup request allocation
      RDMA/qib: rename copy_io to qib_copy_io
      fork: move copy_io to block/blk-ioc.c
      bfq: simplify bfq_bic_lookup
      bfq: use bfq_bic_lookup in bfq_limit_depth
      Revert "block: Provide blk_mq_sched_get_icq()"
      block: mark put_io_context_active static
      block: move blk_mq_sched_assign_ioc to blk-ioc.c
      block: move the remaining elv.icq handling to the I/O scheduler
      block: remove get_io_context_active
      block: factor out a alloc_io_context helper
      block: use alloc_io_context in __copy_io
      block: return the io_context from create_task_io_context
      block: simplify ioc_create_icq
      block: simplify ioc_lookup_icq
      mtd_blkdevs: remove the sector out of range check in do_blktrans_request
      block: don't check ->rq_disk in merges
      block: remove the ->rq_disk field in struct request
      block: remove the gendisk argument to blk_execute_rq
      scsi: remove the gendisk argument to scsi_ioctl
      mtd_blkdevs: don't scan partitions for plain mtdblock
      block: remove the nr_task field from struct io_context
      block: simplify struct io_context refcounting
      block: refactor put_iocontext_active
      block: remove the NULL ioc check in put_io_context
      block: refactor put_io_context
      block: cleanup ioc_clear_queue
      block: move set_task_ioprio to blk-ioc.c
      block: fold get_task_io_context into set_task_ioprio
      block: open code create_task_io_context in set_task_ioprio
      block: fold create_task_io_context into ioc_find_get_icq
      block: only build the icq tracking code when needed
      block: fix error unwinding in device_add_disk

Colin Ian King (1):
      block: Remove redundant initialization of variable ret

Eric Biggers (9):
      blk-crypto: remove blk_crypto_unregister()
      docs: sysfs-block: move to stable directory
      docs: sysfs-block: sort alphabetically
      docs: sysfs-block: add contact for nomerges
      docs: sysfs-block: fill in missing documentation from queue-sysfs.rst
      docs: sysfs-block: document stable_writes
      docs: sysfs-block: document virt_boundary_mask
      docs: block: remove queue-sysfs.rst
      MAINTAINERS: add entries for block layer documentation

Guo Zhengkui (1):
      blk_mq: remove repeated includes

Jan Kara (8):
      block: Provide blk_mq_sched_get_icq()
      bfq: Track number of allocated requests in bfq_entity
      bfq: Store full bitmap depth in bfq_data
      bfq: Limit number of requests consumed by each cgroup
      bfq: Limit waker detection in time
      bfq: Provide helper to generate bfqq name
      bfq: Log waker detections
      bfq: Do not let waker requests skip proper accounting

Jens Axboe (16):
      blk-ioprio: don't set bio priority if not needed
      block: only allocate poll_stats if there's a user of them
      block: move io_context creation into where it's needed
      block: get rid of useless goto and label in blk_mq_get_new_requests()
      block: fix double bio queue when merging in cached request path
      mm: move filemap_range_needs_writeback() into header
      block: move direct_IO into our own read_iter handler
      block: switch to atomic_t for request references
      block: make queue stat accounting a reference
      block: add completion handler for fast path
      block: use singly linked list for bio cache
      block: add mq_ops->queue_rqs hook
      nvme: split command copy into a helper
      nvme: separate command prep and issue
      nvme: add support for mq_ops->queue_rqs()
      block: fix error in handling dead task for ioprio setting

John Garry (3):
      blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument
      blk-mq: Delete busy_iter_fn
      blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags

Keith Busch (6):
      blk-mq: blk-mq: check quiesce state before queue_rqs
      block: remove unnecessary trailing '\'
      block: move rq_list macros to blk-mq.h
      block: introduce rq_list_for_each_safe macro
      block: introduce rq_list_move
      nvme-pci: fix queue_rqs list splitting

Lukas Bulwahn (1):
      block: drop needless assignment in set_task_ioprio()

Matthew Wilcox (Oracle) (1):
      bdev: Improve lookup_bdev documentation

Ming Lei (10):
      blk-mq: use bio->bi_opf after bio is checked
      blk-mq: check q->poll_stat in queue_poll_stat_show
      blk-mq: remove hctx_lock and hctx_unlock
      blk-mq: move srcu from blk_mq_hw_ctx to request_queue
      blk-mq: pass request queue to blk_mq_run_dispatch_ops
      blk-mq: run dispatch lock once in case of issuing from list
      blk-mq: don't run might_sleep() if the operation needn't blocking
      blk-mq: don't use plug->mq_list->q directly in blk_mq_run_dispatch_ops()
      block: call blk_exit_queue() before freeing q->stats
      block: don't protect submit_bio_checks by q_usage_counter

Randy Dunlap (1):
      bio.h: fix kernel-doc warnings

Sebastian Andrzej Siewior (2):
      blk-mq: Add blk_mq_complete_request_direct()
      mmc: core: Use blk_mq_complete_request_direct().

Tetsuo Handa (2):
      block: use "unsigned long" for blk_validate_block_size().
      block: check minor range in device_add_disk()

Wander Lairson Costa (1):
      blktrace: switch trace spinlock to a raw spinlock

Yang Li (1):
      block: fix old-style declaration

Ye Bin (1):
      block: Fix fsync always failed if once failed

 Documentation/ABI/stable/sysfs-block               | 676 ++++++++++++++
 Documentation/ABI/testing/sysfs-block              | 346 --------
 Documentation/block/index.rst                      |   1 -
 Documentation/block/queue-sysfs.rst                | 321 -------
 Documentation/core-api/kernel-api.rst              |   3 -
 .../translations/zh_CN/core-api/kernel-api.rst     |   2 -
 MAINTAINERS                                        |   2 +
 block/Kconfig                                      |   3 +
 block/Kconfig.iosched                              |   1 +
 block/Makefile                                     |   2 +-
 block/bdev.c                                       |  24 +-
 block/bfq-iosched.c                                | 304 ++++---
 block/bfq-iosched.h                                |  35 +-
 block/bio.c                                        |  13 +-
 block/blk-cgroup.c                                 |   1 +
 block/blk-core.c                                   | 391 +--------
 block/blk-crypto-profile.c                         |   5 -
 block/blk-exec.c                                   | 116 ---
 block/blk-flush.c                                  |  18 +-
 block/blk-integrity.c                              |   2 +-
 block/blk-ioc.c                                    | 318 ++++---
 block/blk-ioprio.c                                 |  13 +-
 block/blk-merge.c                                  |  18 +-
 block/blk-mq-debugfs.c                             |   5 +-
 block/blk-mq-sched.c                               |  29 +-
 block/blk-mq-sched.h                               |   2 -
 block/blk-mq-sysfs.c                               |   2 -
 block/blk-mq-tag.c                                 |  67 +-
 block/blk-mq-tag.h                                 |   2 +-
 block/blk-mq.c                                     | 974 ++++++++++++++-------
 block/blk-mq.h                                     |  22 +-
 block/blk-stat.c                                   |  39 +-
 block/blk-stat.h                                   |   2 +
 block/blk-sysfs.c                                  |  13 +-
 block/blk-throttle.c                               |   1 +
 block/blk.h                                        | 115 +--
 block/bsg-lib.c                                    |   2 +-
 block/elevator.c                                   |  10 +-
 block/fops.c                                       |  37 +-
 block/genhd.c                                      |  60 +-
 block/ioctl.c                                      |  31 +-
 block/ioprio.c                                     |  32 -
 block/kyber-iosched.c                              |   1 +
 block/partitions/core.c                            |  24 +-
 drivers/block/amiflop.c                            |   3 +-
 drivers/block/ataflop.c                            |   7 +-
 drivers/block/brd.c                                |   1 -
 drivers/block/drbd/drbd_main.c                     |   1 +
 drivers/block/floppy.c                             |   7 +-
 drivers/block/loop.c                               |   9 +-
 drivers/block/mtip32xx/mtip32xx.c                  |   2 +-
 drivers/block/n64cart.c                            |   2 +-
 drivers/block/null_blk/main.c                      |   1 -
 drivers/block/null_blk/trace.h                     |   2 +-
 drivers/block/paride/pcd.c                         |   5 +-
 drivers/block/paride/pd.c                          |   6 +-
 drivers/block/paride/pf.c                          |   5 +-
 drivers/block/pktcdvd.c                            |   4 +-
 drivers/block/ps3vram.c                            |   1 +
 drivers/block/rbd.c                                |   6 +-
 drivers/block/rnbd/rnbd-clt.c                      |   4 +-
 drivers/block/sunvdc.c                             |  19 +-
 drivers/block/swim.c                               |   1 +
 drivers/block/swim3.c                              |   2 +-
 drivers/block/sx8.c                                |   4 +-
 drivers/block/virtio_blk.c                         |   3 +-
 drivers/block/xen-blkback/xenbus.c                 |   2 +-
 drivers/block/xen-blkfront.c                       |  26 +-
 drivers/block/z2ram.c                              |   1 +
 drivers/block/zram/zram_drv.c                      |   1 +
 drivers/cdrom/gdrom.c                              |   1 +
 drivers/infiniband/hw/qib/qib_verbs.c              |   4 +-
 drivers/md/dm-mpath.c                              |   1 -
 drivers/md/dm.c                                    |   1 +
 drivers/md/md.c                                    |   5 -
 drivers/mmc/core/block.c                           |  38 +-
 drivers/mtd/mtd_blkdevs.c                          |  26 +-
 drivers/mtd/ubi/block.c                            |   7 +-
 drivers/nvme/host/core.c                           |   4 +-
 drivers/nvme/host/fault_inject.c                   |   2 +-
 drivers/nvme/host/pci.c                            | 147 +++-
 drivers/nvme/host/trace.h                          |   6 +-
 drivers/nvme/target/passthru.c                     |   3 +-
 drivers/scsi/ch.c                                  |   2 +-
 drivers/scsi/scsi_bsg.c                            |   2 +-
 drivers/scsi/scsi_error.c                          |   2 +-
 drivers/scsi/scsi_ioctl.c                          |  43 +-
 drivers/scsi/scsi_lib.c                            |  47 +-
 drivers/scsi/scsi_logging.c                        |   4 +-
 drivers/scsi/sd.c                                  |  27 +-
 drivers/scsi/sd_zbc.c                              |   8 +-
 drivers/scsi/sg.c                                  |   6 +-
 drivers/scsi/sr.c                                  |  17 +-
 drivers/scsi/st.c                                  |   4 +-
 drivers/scsi/ufs/ufshpb.c                          |   4 +-
 drivers/scsi/virtio_scsi.c                         |   2 +-
 drivers/target/target_core_pscsi.c                 |   2 +-
 drivers/usb/storage/transport.c                    |   2 +-
 fs/io_uring.c                                      |   2 +-
 fs/iomap/direct-io.c                               |   1 +
 include/linux/bio.h                                |   4 +-
 include/linux/blk-mq.h                             | 105 ++-
 include/linux/blkdev.h                             |  47 +-
 include/linux/fs.h                                 |   2 -
 include/linux/genhd.h                              |  85 +-
 include/linux/iocontext.h                          |  49 +-
 include/linux/pagemap.h                            |  29 +
 include/scsi/scsi_cmnd.h                           |   2 +-
 include/scsi/scsi_device.h                         |   4 +-
 include/scsi/scsi_ioctl.h                          |   4 +-
 include/trace/events/block.h                       |   8 +-
 kernel/fork.c                                      |  26 -
 kernel/trace/blktrace.c                            |  20 +-
 mm/filemap.c                                       |  32 +-
 114 files changed, 2563 insertions(+), 2484 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-block
 delete mode 100644 Documentation/ABI/testing/sysfs-block
 delete mode 100644 Documentation/block/queue-sysfs.rst
 delete mode 100644 block/blk-exec.c

-- 
Jens Axboe


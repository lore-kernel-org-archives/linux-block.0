Return-Path: <SRS0=z7Vg=BM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13F6C433DF
	for <linux-block@archiver.kernel.org>; Sun,  2 Aug 2020 21:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A0320738
	for <linux-block@archiver.kernel.org>; Sun,  2 Aug 2020 21:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="htYqnUcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHBVlS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Aug 2020 17:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgHBVlR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Aug 2020 17:41:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67162C06174A
        for <linux-block@vger.kernel.org>; Sun,  2 Aug 2020 14:41:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f9so10282399pju.4
        for <linux-block@vger.kernel.org>; Sun, 02 Aug 2020 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ovF885ncz0cvRBZlkxVIidaE6uZpVOGmXeFSwrZN0UU=;
        b=htYqnUclJ433RQ5ocA66ZloqKYIExi0Z9aJba9Isz4GJLK/f67ktwrrXAnVHPOWOYn
         SgSReAbq9dGksMlrx6SGSiKIulsHJLGAqf0AbdNW1epKVfNGUriXnAKCzOmhDphkDCfa
         Vqp8zkjdFFotXxhsDjGmVGL9yv4IaTjY9+1f7ixjvFs9lMlzEYg4+xWQFC0Yf3CcGkbE
         HICfRPgEn5v/2m7+OsP+V6aeaZvGjF6QtkxXN2uC8uxtKFb55r1KMDokj5rnsXi8k53O
         74O+W60HDc8RyxQAxQC4/BRLwGWgTMhzzPUXlGLPKoM51DVrPtEpikhOLaA6gN6Z4Nkh
         NxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ovF885ncz0cvRBZlkxVIidaE6uZpVOGmXeFSwrZN0UU=;
        b=ksHSuDixXONg0U5m4ZyxMao8gdJO+UNn8gEarjHwuIbqwGR6sL9QF2jbRvj2f9lm78
         49diMEq2zG46fPWJwGBZt8W19H8oaCFZ+DdH3TNXy9oMT7asTQFOWe81UNHa601D+BGd
         KIpFm/o7GuQOe/vobHV2SAYGmA4TvPyFE47ip4QFzuV88ezz9XC8KYRf8NrX+MuITrDo
         NAMREOFXt0RxG9cgBhHrKIRE+nUHO1w3rax8BrAaRlSHl/TFY92Q8axCOGd9Tbh6NNl/
         n7QWXO513bqUl7NDGMvVf0NC6q9fMv5kdLno0FE8wx72NJH6NBXtGXcYaDyU1OJRgAxT
         UIbg==
X-Gm-Message-State: AOAM532Ic702w8FVZnCi2nY4NnEWowHX85uUl1v4qDssS/l9NC9GEKE/
        4NzsJNuKvpLCPIz45ILae86cqTEQXQs=
X-Google-Smtp-Source: ABdhPJyHdyYwNPf6AG3D+f+RYMwx0TQanW8Uhi9pfxvqtx9a1pQ+agIkMC8QGyeH2SslIOORT4Osrw==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr11766787plr.225.1596404476192;
        Sun, 02 Aug 2020 14:41:16 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gz7sm2258043pjb.45.2020.08.02.14.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 14:41:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Core block changes for 5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <9127f74b-d312-6812-ee5f-d761301215ff@kernel.dk>
Date:   Sun, 2 Aug 2020 15:41:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the core block changes queued up for this merge window. Good
amount of cleanups and tech debt removals in here, and as a result, the
diffstat shows a nice net reduction in code.

Changes:

- Softirq completion cleanups (Christoph)

- Stop using ->queuedata (Christoph)

- Cleanup bd claiming (Christoph)

- Use check_events, moving away from the legacy media change (Christoph)

- Use inode i_blkbits consistently (Christoph)

- Remove old unused writeback congestion bits (Christoph)

- Cleanup/unify submission path (Christoph)

- Use bio_uninit consistently, instead of bio_disassociate_blkg
  (Christoph)

- sbitmap cleared bits handling (John)

- Request merging blktrace event addition (Jan)

- sysfs add/remove race fixes (Luis)

- blk-mq tag fixes/optimizations (Ming)

- Duplicate words in comments (Randy)

- Flush deferral cleanup (Yufen)

- IO context locking/retry fixes (John)

- struct_size() usage (Gustavo)

- blk-iocost fixes (Chengming)

- blk-cgroup IO stats fixes (Boris)

- Various little fixes

Please pull!


The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.9/block-20200802

for you to fetch changes up to d958e343bdc3de2643ce25225bed082dc222858d:

  block: blk-timeout: delete duplicated word (2020-07-31 16:29:47 -0600)

----------------------------------------------------------------
for-5.9/block-20200802

----------------------------------------------------------------
Baolin Wang (2):
      blk-mq: Remove unnecessary local variable
      blk-mq: remove redundant validation in __blk_mq_end_request()

Boris Burkov (2):
      blk-cgroup: make iostat functions visible to stat printing
      blk-cgroup: show global disk stats in root cgroup io.stat

Chengming Zhou (2):
      iocost: Fix check condition of iocg abs_vdebt
      iocost_monitor: start from the oldest usage index

Christoph Hellwig (81):
      blk-mq: merge blk-softirq.c into blk-mq.c
      blk-mq: factor out a helper to reise the block softirq
      blk-mq: remove raise_blk_irq
      blk-mq: complete polled requests directly
      blk-mq: short cut the IPI path in blk_mq_force_complete_rq for !SMP
      blk-mq: merge the softirq vs non-softirq IPI logic
      blk-mq: move failure injection out of blk_mq_complete_request
      blk-mq: remove the get_cpu/put_cpu pair in blk_mq_complete_request
      blk-mq: factor out a blk_mq_complete_need_ipi helper
      blk-mq: add a new blk_mq_complete_request_remote API
      nvme-rdma: factor out a nvme_rdma_end_request helper
      nvme: use blk_mq_complete_request_remote to avoid an indirect function call
      nvme-rdma: fix a missing completion with remove invalidation
      tty/sysrq: emergency_thaw_all does not depend on CONFIG_BLOCK
      block: mark bd_finish_claiming static
      fs: remove an unused block_device_operations forward declaration
      fs: remove the HAVE_UNLOCKED_IOCTL and HAVE_COMPAT_IOCTL defines
      fs: remove the mount_bdev and kill_block_super stubs
      block: simplify sb_is_blkdev_sb
      block: move block-related definitions out of fs.h
      fs: move the buffer_heads_over_limit stub to buffer_head.h
      block: reduce ifdef CONFIG_BLOCK madness in headers
      block: move struct block_device to blk_types.h
      dm: use bio_uninit instead of bio_disassociate_blkg
      block: remove bio_disassociate_blkg
      block: really clone the block cgroup in bio_clone_blkg_association
      block: merge __bio_associate_blkg into bio_associate_blkg_from_css
      block: move bio_associate_blkg_from_page to mm/page_io.c
      block: move the bio cgroup associatation helpers to blk-cgroup.c
      block: merge blkg_lookup_create and __blkg_lookup_create
      block: bypass blkg_tryget_closest for the root_blkg
      block: move the initial blkg lookup into blkg_tryget_closest
      blk-cgroup: remove the !bio->bi_blkg check in blkcg_bio_issue_check
      cgroup: unexport cgroup_rstat_updated
      blk-cgroup: move rcu locking from blkcg_bio_issue_check to blk_throtl_bio
      blk-cgroup: remove blkcg_bio_issue_check
      blk-cgroup: remove a dead check in blk_throtl_bio
      blk-mq: remove the BLK_MQ_REQ_INTERNAL flag
      nfblock: stop using ->queuedata
      simdisk: stop using ->queuedata
      drbd: stop using ->queuedata
      null_blk: stop using ->queuedata for bio mode
      ps3vram: stop using ->queuedata
      rsxx: stop using ->queuedata
      umem: stop using ->queuedata
      zram: stop using ->queuedata
      bcache: stop setting ->queuedata
      dm: stop using ->queuedata
      fs: remove a weird comment in submit_bh_wbc
      block: remove the request_queue argument from blk_queue_split
      block: tidy up a warning in bio_check_ro
      block: remove the NULL queue check in generic_make_request_checks
      block: remove the nr_sectors variable in generic_make_request_checks
      block: move ->make_request_fn to struct block_device_operations
      block: rename generic_make_request to submit_bio_noacct
      block: refator submit_bio_noacct
      block: shortcut __submit_bio_noacct for blk-mq drivers
      block: remove direct_make_request
      floppy: use block_size
      dcssblk: don't set bd_block_size in ->open
      block: simplify set_init_blocksize
      block: remove the bd_block_size field from struct block_device
      block: remove the bd_queue field from struct block_device
      block: remove the unused bd_private field from struct block_device
      block: remove the all_bdevs list
      block: initialize current->bio_list[1] in __submit_bio_noacct_mq
      block: remove a bogus warning in __submit_bio_noacct_mq
      md: switch to ->check_events for media change notifications
      cdrom: remove the unused cdrom_media_changed function
      block: remove flush_disk
      isofs: remove a stale comment
      xtensa/simdisk: remove the call to check_disk_change
      mmc: remove the call to check_disk_change
      drbd: remove a bogus bdi_rw_congested call
      writeback: remove {set,clear}_wb_congested
      writeback: remove struct bdi_writeback_congested
      writeback: remove bdi->congested_fn
      block: simplify the restart case in __blkdev_get
      block: refactor bd_start_claiming
      block: use bd_prepare_to_claim directly in the loop driver
      block: integrate bd_start_claiming into __blkdev_get

Colin Ian King (1):
      blk-cgroup: clean up indentation

Coly Li (2):
      block: change REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL to be odd numbers
      block: improve discard bio alignment in __blkdev_issue_discard()

Daniel Wagner (2):
      block: Use non _rcu version of list functions for tag_set_list
      block: Remove callback typedefs for blk_mq_ops

Guo Xuenan (1):
      blk-rq-qos: remove redundant finish_wait to rq_qos_wait.

Gustavo A. R. Silva (2):
      block: bio: Use struct_size() in kmalloc()
      blk-iocost: Use struct_size() in kzalloc_node()

Hongnan Li (1):
      blk-iolatency: only call ktime_get() if needed

Hou Tao (1):
      blk-mq: remove pointless call of list_entry_rq() in hctx_show_busy_rq()

Jan Kara (1):
      blktrace: Provide event for request merging

Jens Axboe (4):
      dm: remove unused variable
      Revert "blk-mq: put driver tag when this request is completed"
      block: relax jiffies rounding for timeouts
      Revert "blk-rq-qos: remove redundant finish_wait to rq_qos_wait."

John Garry (1):
      sbitmap: Consider cleared bits in sbitmap_bitmap_show()

John Ogness (2):
      block: remove unnecessary ioc nested locking
      block: remove retry loop in ioc_release_fn()

Luis Chamberlain (8):
      block: add docs for gendisk / request_queue refcount helpers
      block: clarify context for refcount increment helpers
      block: revert back to synchronous request_queue removal
      blktrace: annotate required lock on do_blk_trace_setup()
      loop: be paranoid on exit and prevent new additions / removals
      blktrace: fix debugfs use after free
      blktrace: ensure our debugfs dir exists
      block: create the request_queue debugfs_dir on registration

Ming Lei (13):
      blk-mq: put driver tag when this request is completed
      blk-mq: pass request queue into get/put budget callback
      blk-mq: pass hctx to blk_mq_dispatch_rq_list
      blk-mq: move getting driver tag and budget into one helper
      blk-mq: remove dead check from blk_mq_dispatch_rq_list
      blk-mq: pass obtained budget count to blk_mq_dispatch_rq_list
      blk-mq: support batching dispatch in case of io
      blk-mq: move blk_mq_get_driver_tag into blk-mq.c
      blk-mq: move blk_mq_put_driver_tag() into blk-mq.c
      blk-mq: centralise related handling into blk_mq_get_driver_tag
      blk-mq: streamline handling of q->mq_ops->queue_rq result
      blk-mq: centralise related handling into blk_mq_get_driver_tag
      block: always remove partitions from blk_drop_partitions()

Randy Dunlap (7):
      block: bfq-iosched: fix duplicated word
      block: bio: delete duplicated words
      block: elevator: delete duplicated word and fix typos
      block: genhd: delete duplicated words
      block: blk-mq: delete duplicated word
      block: blk-mq-sched: delete duplicated word
      block: blk-timeout: delete duplicated word

Wei Yongjun (1):
      block: make blk_timeout_init() static

Yufen Yu (1):
      block: defer flush request no matter whether we have elevator

 Documentation/admin-guide/cgroup-v2.rst           |   3 +-
 Documentation/block/biodoc.rst                    |   2 +-
 Documentation/block/writeback_cache_control.rst   |   2 +-
 Documentation/cdrom/cdrom-standard.rst            |  18 +-
 Documentation/fault-injection/fault-injection.rst |   2 +-
 Documentation/filesystems/locking.rst             |   4 +-
 Documentation/trace/ftrace.rst                    |   4 +-
 arch/m68k/emu/nfblock.c                           |   8 +-
 arch/xtensa/platforms/iss/simdisk.c               |  11 +-
 block/Makefile                                    |   2 +-
 block/bfq-iosched.c                               |   2 +-
 block/bio.c                                       | 165 +--------
 block/blk-cgroup.c                                | 402 +++++++++++++++-------
 block/blk-core.c                                  | 286 +++++++--------
 block/blk-crypto-fallback.c                       |   2 +-
 block/blk-crypto.c                                |   2 +-
 block/blk-flush.c                                 |  23 +-
 block/blk-ioc.c                                   |  42 +--
 block/blk-iocost.c                                |   5 +-
 block/blk-iolatency.c                             |   3 +-
 block/blk-lib.c                                   |  31 +-
 block/blk-merge.c                                 |  25 +-
 block/blk-mq-debugfs.c                            |   8 +-
 block/blk-mq-sched.c                              | 103 +++++-
 block/blk-mq-tag.c                                |  62 +---
 block/blk-mq-tag.h                                |  41 ++-
 block/blk-mq.c                                    | 396 +++++++++++++--------
 block/blk-mq.h                                    |  17 +-
 block/blk-softirq.c                               | 156 ---------
 block/blk-sysfs.c                                 |  52 +--
 block/blk-throttle.c                              |  14 +-
 block/blk-timeout.c                               |  30 +-
 block/blk.h                                       |  37 +-
 block/bounce.c                                    |   2 +-
 block/bsg-lib.c                                   |   5 +-
 block/elevator.c                                  |   4 +-
 block/genhd.c                                     |  85 ++++-
 block/partitions/core.c                           |   2 -
 drivers/block/brd.c                               |   5 +-
 drivers/block/drbd/drbd_int.h                     |   8 +-
 drivers/block/drbd/drbd_main.c                    |  71 +---
 drivers/block/drbd/drbd_proc.c                    |   1 -
 drivers/block/drbd/drbd_receiver.c                |   2 +-
 drivers/block/drbd/drbd_req.c                     |   8 +-
 drivers/block/drbd/drbd_worker.c                  |   2 +-
 drivers/block/floppy.c                            |   7 +-
 drivers/block/loop.c                              |  17 +-
 drivers/block/mtip32xx/mtip32xx.c                 |   3 +-
 drivers/block/nbd.c                               |   5 +-
 drivers/block/null_blk_main.c                     |  24 +-
 drivers/block/pktcdvd.c                           |  15 +-
 drivers/block/ps3vram.c                           |  20 +-
 drivers/block/rsxx/dev.c                          |  14 +-
 drivers/block/skd_main.c                          |   9 +-
 drivers/block/umem.c                              |  11 +-
 drivers/block/virtio_blk.c                        |   3 +-
 drivers/block/xen-blkfront.c                      |   3 +-
 drivers/block/zram/zram_drv.c                     |  14 +-
 drivers/cdrom/cdrom.c                             |  28 +-
 drivers/dax/super.c                               |   2 +-
 drivers/lightnvm/core.c                           |   8 +-
 drivers/lightnvm/pblk-init.c                      |  16 +-
 drivers/lightnvm/pblk-read.c                      |   2 +-
 drivers/md/bcache/bcache.h                        |   2 +-
 drivers/md/bcache/btree.c                         |   2 +-
 drivers/md/bcache/request.c                       |  58 +---
 drivers/md/bcache/request.h                       |   4 +-
 drivers/md/bcache/super.c                         |  25 +-
 drivers/md/dm-cache-target.c                      |  25 +-
 drivers/md/dm-clone-target.c                      |  25 +-
 drivers/md/dm-crypt.c                             |   6 +-
 drivers/md/dm-delay.c                             |   2 +-
 drivers/md/dm-era-target.c                        |  17 +-
 drivers/md/dm-integrity.c                         |   4 +-
 drivers/md/dm-mpath.c                             |   2 +-
 drivers/md/dm-raid.c                              |  12 -
 drivers/md/dm-raid1.c                             |   2 +-
 drivers/md/dm-rq.c                                |   3 +-
 drivers/md/dm-snap-persistent.c                   |   2 +-
 drivers/md/dm-snap.c                              |   6 +-
 drivers/md/dm-table.c                             |  37 +-
 drivers/md/dm-thin.c                              |  20 +-
 drivers/md/dm-verity-target.c                     |   2 +-
 drivers/md/dm-writecache.c                        |   2 +-
 drivers/md/dm-zoned-target.c                      |   2 +-
 drivers/md/dm.c                                   |  80 ++---
 drivers/md/dm.h                                   |   1 -
 drivers/md/md-faulty.c                            |   4 +-
 drivers/md/md-linear.c                            |  28 +-
 drivers/md/md-multipath.c                         |  27 +-
 drivers/md/md.c                                   |  51 +--
 drivers/md/md.h                                   |   4 -
 drivers/md/raid0.c                                |  24 +-
 drivers/md/raid1.c                                |  45 +--
 drivers/md/raid10.c                               |  54 +--
 drivers/md/raid5.c                                |  35 +-
 drivers/mmc/core/block.c                          |  11 +-
 drivers/nvdimm/blk.c                              |   5 +-
 drivers/nvdimm/btt.c                              |   5 +-
 drivers/nvdimm/pmem.c                             |   5 +-
 drivers/nvme/host/core.c                          |   3 +-
 drivers/nvme/host/fc.c                            |   4 +-
 drivers/nvme/host/multipath.c                     |  18 +-
 drivers/nvme/host/nvme.h                          |   7 +-
 drivers/nvme/host/pci.c                           |   3 +-
 drivers/nvme/host/rdma.c                          |  35 +-
 drivers/nvme/host/tcp.c                           |   6 +-
 drivers/nvme/target/core.c                        |   2 +-
 drivers/nvme/target/loop.c                        |   3 +-
 drivers/s390/block/dasd.c                         |   2 +-
 drivers/s390/block/dcssblk.c                      |  12 +-
 drivers/s390/block/scm_blk.c                      |   3 +-
 drivers/s390/block/xpram.c                        |   8 +-
 drivers/scsi/scsi_lib.c                           |  20 +-
 drivers/tty/sysrq.c                               |   2 -
 fs/adfs/super.c                                   |   1 +
 fs/affs/file.c                                    |   1 +
 fs/befs/linuxvfs.c                                |   1 +
 fs/block_dev.c                                    | 315 ++++++-----------
 fs/btrfs/disk-io.c                                |  23 --
 fs/buffer.c                                       |   5 -
 fs/direct-io.c                                    |   4 +-
 fs/efs/super.c                                    |   1 +
 fs/hfs/inode.c                                    |   1 +
 fs/internal.h                                     |  17 +-
 fs/isofs/inode.c                                  |   3 -
 fs/jfs/jfs_mount.c                                |   1 +
 fs/jfs/resize.c                                   |   1 +
 fs/ntfs/dir.c                                     |   1 +
 fs/proc/devices.c                                 |   1 +
 fs/quota/dquot.c                                  |   1 +
 fs/reiserfs/procfs.c                              |   1 +
 fs/xfs/xfs_pwork.c                                |   2 +-
 include/linux/backing-dev-defs.h                  |  43 +--
 include/linux/backing-dev.h                       |  22 +-
 include/linux/bio.h                               |  12 -
 include/linux/blk-cgroup.h                        | 107 +-----
 include/linux/blk-mq.h                            |  67 ++--
 include/linux/blk_types.h                         |  37 +-
 include/linux/blkdev.h                            | 165 +++++----
 include/linux/buffer_head.h                       |   1 +
 include/linux/cdrom.h                             |   2 -
 include/linux/dasd_mod.h                          |   2 +
 include/linux/device-mapper.h                     |  11 -
 include/linux/fs.h                                | 169 +--------
 include/linux/genhd.h                             |  40 ++-
 include/linux/jbd2.h                              |   1 +
 include/linux/lightnvm.h                          |   3 +-
 include/trace/events/block.h                      |  15 +
 kernel/cgroup/rstat.c                             |   1 -
 kernel/trace/blktrace.c                           |  86 +++--
 lib/sbitmap.c                                     |   3 +
 mm/backing-dev.c                                  | 157 +--------
 mm/page_io.c                                      |  17 +
 mm/swapfile.c                                     |   2 +-
 security/loadpin/loadpin.c                        |   1 +
 tools/cgroup/iocost_monitor.py                    |   2 +-
 157 files changed, 1829 insertions(+), 2640 deletions(-)
 delete mode 100644 block/blk-softirq.c

-- 
Jens Axboe


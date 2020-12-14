Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525EDC4361B
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 15:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1ABD225AB
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 15:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgLNPHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 10:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408141AbgLNPHE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 10:07:04 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13639C0613D3
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 07:06:24 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id r17so16037500ilo.11
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 07:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+JS4cc6gaaHpZXrXHS3mG0mIIdKjlA6m0Q1E6D3fNoo=;
        b=IaFfCLsYocMBf6HAp5HG8V1kCAzpwiMkq2jMV1MKamAtd1tkl2Od6+WjPuTmPDZYdD
         hVWqo0t/0xNE2qb7kxieIw83S+5lPbTQ4yeCbBt4ukQB/7nZPDe8jYFvIyGmMVziT3qz
         nlZLqf+EtvHK/dvZwgfkN6CEnzrfdSFus/Z7H+4rWzAKHIs1/9FCgTkxbWfImWgFpwK6
         Iaf5jAYbUZYUA7wSkeMNWA6OFOs5GgMpquXUqq/Ho1Ukr0gCc21fDyrZpJF2/T39g1T5
         ZKt9LNgpGdFpXgfTFatdqsLSmE/jkDhhhN01qQkXzmBlKd4jEOVP2fRl3pzznimARyGO
         ns0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+JS4cc6gaaHpZXrXHS3mG0mIIdKjlA6m0Q1E6D3fNoo=;
        b=YvLQHjFOXZ+OcRg7u/ttTZkFu3xGKuv9ww+adcBjWVividtz93YI/mh56wZnfMSJ+M
         gqMcIDRXnzzJ1KdtmT0HXnR38HRyIZKUILrjXGypEwA4CNR/ZAj0uWgyTiFyD5rH0y3/
         9PpaBwDC19Vt+D9N39Swii6V6wGafcfcPz9LwsFBgoE2ycmHDQBSDYnLnhxxcw4TYP5f
         LLXbdDu+V7FJjD5piLchbjkjblxLy3WoVWC+PxT9XIt9V8fGAdJ+tVnuT+4NT3nNFK0n
         SPACbW/7N+Uiz+gPR+wIj76DKJCZgG+rKi1fXKrpv88P0xhaMVKfSDFaQEd+c+Wgsgqr
         KJkg==
X-Gm-Message-State: AOAM530D8Pt3BvL0dIyKqsjBimFTtBS7xvs6hVqZ4Jssf0hdSvyzHaRX
        aj3E+JPUUnWWTNS1TOGPd6G3bwhibR4eRA==
X-Google-Smtp-Source: ABdhPJyOQnxQuSCbcU4n5C/cYJxkqKoEXqQWJUxhvHQc3EIvhm1zVnX6Mq6ZATiFff3FgZPezGSvEQ==
X-Received: by 2002:a05:6e02:1010:: with SMTP id n16mr34985017ilj.3.1607958382947;
        Mon, 14 Dec 2020 07:06:22 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e1sm9297879iod.17.2020.12.14.07.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 07:06:22 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 5.10
Message-ID: <774c987e-0743-6a7b-cfa7-1c65c35931b3@kernel.dk>
Date:   Mon, 14 Dec 2020 08:06:21 -0700
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

Another series of killing more code than what is being added, again
thanks to Christoph's relentless cleanups and tech debt tackling. Note
that there are a fix merge resolutions that need to be done, see below
changelog.

This pull request contains:

- blk-iocost improvements (Baolin Wang)

- part0 iostat fix (Jeffle Xu)

- Disable iopoll for split bios (Jeffle Xu)

- block tracepoint cleanups (Christoph Hellwig)

- Merging of struct block_device and hd_struct (Christoph Hellwig)

- Rework/cleanup of how block device sizes are updated (Christoph
  Hellwig)

- Simplification of gendisk lookup and removal of block device aliasing
  (Christoph Hellwig)

- Block device ioctl cleanups (Christoph Hellwig)

- Removal of bdget()/blkdev_get() as exported API (Christoph Hellwig)

- Disk change rework, avoid ->revalidate_disk() (Christoph Hellwig)

- sbitmap improvements (Pavel Begunkov)

- Hybrid polling fix (Pavel Begunkov)

- bvec iteration improvements (Pavel Begunkov)

- Zone revalidation fixes (Damien Le Moal)

- blk-throttle limit fix (Yu Kuai)

- Various little fixes

Note that pulling this will throw a merge conflict due to the late
reverts of the md discard bits, and also a silent merge failure due to a
late fix (b7131ee0bac5) for 5.10 fixing a memory leak. Three in total,
they are:

- drivers/md/md.c: this one does throw a merge error, fix is simply
  removing md_submit_discard_bio().

- drivers/md/raid0.c: Remove the first argument to
  trace_block_bio_remap().

- block/blk-cgroup.c: remove disk_put_part(part) in
  blkcg_fill_root_iostats().

I've pushed out a for-5.11/block-merged branch that has these
resolutions in place, for reference.

Please pull!


The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.11/block-2020-12-14

for you to fetch changes up to fa94ba8a7b22890e6a17b39b9359e114fe18cd59:

  blk-mq: fix msec comment from micro to milli seconds (2020-12-12 11:13:41 -0700)

----------------------------------------------------------------
for-5.11/block-2020-12-14

----------------------------------------------------------------
Baolin Wang (5):
      blk-iocost: Fix some typos in comments
      blk-iocost: Remove unnecessary advance declaration
      blk-iocost: Move the usage ratio calculation to the correct place
      blk-iocost: Factor out the active iocgs' state check into a separate function
      blk-iocost: Factor out the base vrate change into a separate function

Christoph Hellwig (102):
      mtd_blkdevs: don't override BLKFLSBUF
      block: don't call into the driver for BLKFLSBUF
      block: add a new set_read_only method
      rbd: implement ->set_read_only to hook into BLKROSET processing
      md: implement ->set_read_only to hook into BLKROSET processing
      dasd: implement ->set_read_only to hook into BLKROSET processing
      block: don't call into the driver for BLKROSET
      loop: use set_disk_ro
      block: remove set_device_ro
      block: remove __blkdev_driver_ioctl
      block: cleanup del_gendisk a bit
      block: open code kobj_map into in block/genhd.c
      block: split block_class_lock
      block: rework requesting modules for unclaimed devices
      block: add an optional probe callback to major_names
      ide: remove ide_{,un}register_region
      swim: don't call blk_register_region
      sd: use __register_blkdev to avoid a modprobe for an unregistered dev_t
      brd: use __register_blkdev to allocate devices on demand
      loop: use __register_blkdev to allocate devices on demand
      md: use __register_blkdev to allocate devices on demand
      ide: switch to __register_blkdev for command set probing
      floppy: use a separate gendisk for each media format
      amiflop: use separate gendisks for Amiga vs MS-DOS mode
      ataflop: use a separate gendisk for each media format
      z2ram: reindent
      z2ram: use separate gendisk for the different modes
      block: switch gendisk lookup to a simple xarray
      block: fix the kerneldoc comment for __register_blkdev
      block: remove the call to __invalidate_device in check_disk_size_change
      loop: let set_capacity_revalidate_and_notify update the bdev size
      nvme: let set_capacity_revalidate_and_notify update the bdev size
      sd: update the bdev size in sd_revalidate_disk
      block: remove the update_bdev parameter to set_capacity_revalidate_and_notify
      nbd: remove the call to set_blocksize
      nbd: move the task_recv check into nbd_size_update
      nbd: refactor size updates
      nbd: validate the block size in nbd_set_size
      nbd: use set_capacity_and_notify
      aoe: don't call set_capacity from irq context
      dm: use set_capacity_and_notify
      pktcdvd: use set_capacity_and_notify
      nvme: use set_capacity_and_notify in nvme_set_queue_dying
      drbd: use set_capacity_and_notify
      rbd: use set_capacity_and_notify
      rnbd: use set_capacity_and_notify
      zram: use set_capacity_and_notify
      dm-raid: use set_capacity_and_notify
      md: use set_capacity_and_notify
      md: remove a spurious call to revalidate_disk_size in update_size
      virtio-blk: remove a spurious call to revalidate_disk_size
      block: unexport revalidate_disk_size
      filemap: consistently use ->f_mapping over ->i_mapping
      fs: remove get_super_thawed and get_super_exclusive_thawed
      fs: simplify freeze_bdev/thaw_bdev
      mtip32xx: remove the call to fsync_bdev on removal
      zram: do not call set_blocksize
      loop: do not call set_blocksize
      dm: simplify flush_bio initialization in __send_empty_flush
      dm: remove the block_device reference in struct mapped_device
      block: remove a duplicate __disk_get_part prototype
      block: remove a superflous check in blkpg_do_ioctl
      block: add a bdev_kobj helper
      block: use disk_part_iter_exit in disk_part_iter_next
      block: use put_device in put_disk
      block: change the hash used for looking up block devices
      block: switch bdgrab to use igrab
      init: refactor name_to_dev_t
      init: refactor devt_from_partuuid
      init: cleanup match_dev_by_uuid and match_dev_by_label
      block: refactor __blkdev_put
      block: refactor blkdev_get
      block: move bdput() to the callers of __blkdev_get
      block: opencode devcgroup_inode_permission
      block: remove i_bdev
      block: simplify bdev/disk lookup in blkdev_get
      block: remove ->bd_contains
      block: simplify the block device claiming interface
      block: simplify part_to_disk
      block: initialize struct block_device in bdev_alloc
      block: remove the nr_sects field in struct hd_struct
      block: move disk stat accounting to struct block_device
      block: move the start_sect field to struct block_device
      block: move the partition_meta_info to struct block_device
      block: move holder_dir to struct block_device
      block: move make_it_fail to struct block_device
      block: move the policy field to struct block_device
      block: allocate struct hd_struct as part of struct bdev_inode
      block: switch partition lookup to use struct block_device
      block: remove the partno field from struct hd_struct
      block: pass a block_device to blk_alloc_devt
      block: pass a block_device to invalidate_partition
      block: switch disk_part_iter_* to use a struct block_device
      f2fs: remove a few bd_part checks
      block: merge struct block_device and struct hd_struct
      block: stop using bdget_disk for partition 0
      block: remove the unused block_sleeprq tracepoint
      block: simplify and extend the block_bio_merge tracepoint class
      block: remove the request_queue argument to the block_split tracepoint
      block: remove the request_queue argument to the block_bio_remap tracepoint
      block: remove the request_queue to argument request based tracepoints
      blktrace: fix up a kerneldoc comment

Damien Le Moal (1):
      block: Improve blk_revalidate_disk_zones() checks

Jeffle Xu (3):
      block: remove unused BIO_SPLIT_ENTRIES
      block: fix inflight statistics of part0
      block: disable iopoll for split bio

Lei Chen (1):
      block: wbt: Remove unnecessary invoking of wbt_update_limits in wbt_init

Ming Lei (3):
      blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
      nvme-loop: use blk_mq_hctx_set_fq_lock_class to set loop's lock class
      Revert "block: Fix a lockdep complaint triggered by request queue flushing"

Minwoo Im (3):
      blk-mq: add helper allocating tagset->tags
      blk-mq: update arg in comment of blk_mq_map_queue
      blk-mq: fix msec comment from micro to milli seconds

Pavel Begunkov (7):
      block: optimise for_each_bvec() advance
      bio: optimise bvec iteration
      blk-mq: skip hybrid polling if iopoll doesn't spin
      sbitmap: optimise sbitmap_deferred_clear()
      sbitmap: remove swap_lock
      sbitmap: replace CAS with atomic and
      sbitmap: simplify wrap check

Yu Kuai (1):
      blk-throttle: don't check whether or not lower limit is valid if CONFIG_BLK_DEV_THROTTLING_LOW is off

 block/bio.c                                  |  10 +-
 block/blk-cgroup.c                           |  50 +-
 block/blk-core.c                             |  70 ++-
 block/blk-flush.c                            |  32 +-
 block/blk-iocost.c                           | 287 +++++-----
 block/blk-lib.c                              |   2 +-
 block/blk-merge.c                            |  18 +-
 block/blk-mq-sched.c                         |   2 +-
 block/blk-mq.c                               |  46 +-
 block/blk-mq.h                               |   9 +-
 block/blk-throttle.c                         |   6 +
 block/blk-wbt.c                              |   1 -
 block/blk-zoned.c                            |  16 +-
 block/blk.h                                  |  85 +--
 block/bounce.c                               |   2 +-
 block/genhd.c                                | 565 ++++++--------------
 block/ioctl.c                                |  74 +--
 block/partitions/core.c                      | 250 +++------
 drivers/block/amiflop.c                      |  98 ++--
 drivers/block/aoe/aoecmd.c                   |  15 +-
 drivers/block/ataflop.c                      | 135 +++--
 drivers/block/brd.c                          |  39 +-
 drivers/block/drbd/drbd_main.c               |   6 +-
 drivers/block/drbd/drbd_receiver.c           |   2 +-
 drivers/block/drbd/drbd_worker.c             |   3 +-
 drivers/block/floppy.c                       | 154 ++++--
 drivers/block/loop.c                         |  64 +--
 drivers/block/mtip32xx/mtip32xx.c            |  15 -
 drivers/block/mtip32xx/mtip32xx.h            |   2 -
 drivers/block/nbd.c                          |  94 ++--
 drivers/block/pktcdvd.c                      |   9 +-
 drivers/block/rbd.c                          |  43 +-
 drivers/block/rnbd/rnbd-clt.c                |   3 +-
 drivers/block/swim.c                         |  17 -
 drivers/block/virtio_blk.c                   |   3 +-
 drivers/block/xen-blkback/common.h           |   4 +-
 drivers/block/xen-blkfront.c                 |  22 +-
 drivers/block/z2ram.c                        | 547 ++++++++++---------
 drivers/block/zram/zram_drv.c                |  34 +-
 drivers/block/zram/zram_drv.h                |   1 -
 drivers/ide/ide-probe.c                      |  66 +--
 drivers/ide/ide-tape.c                       |   2 -
 drivers/md/bcache/request.c                  |   9 +-
 drivers/md/bcache/super.c                    |  29 +-
 drivers/md/dm-core.h                         |   7 -
 drivers/md/dm-raid.c                         |   3 +-
 drivers/md/dm-rq.c                           |   2 +-
 drivers/md/dm-table.c                        |   9 +-
 drivers/md/dm.c                              |  58 +-
 drivers/md/md-cluster.c                      |   8 +-
 drivers/md/md-linear.c                       |   6 +-
 drivers/md/md.c                              | 120 ++---
 drivers/md/raid0.c                           |   4 +-
 drivers/md/raid1.c                           |   7 +-
 drivers/md/raid10.c                          |   6 +-
 drivers/md/raid5.c                           |  15 +-
 drivers/mtd/mtd_blkdevs.c                    |  28 -
 drivers/mtd/mtdsuper.c                       |  17 +-
 drivers/nvme/host/core.c                     |  18 +-
 drivers/nvme/host/multipath.c                |   3 +-
 drivers/nvme/target/admin-cmd.c              |  20 +-
 drivers/nvme/target/loop.c                   |  10 +
 drivers/s390/block/dasd.c                    |   9 +-
 drivers/s390/block/dasd_int.h                |   3 +-
 drivers/s390/block/dasd_ioctl.c              |  36 +-
 drivers/s390/scsi/zfcp_fsf.c                 |   3 +-
 drivers/scsi/scsicam.c                       |   2 +-
 drivers/scsi/sd.c                            |  28 +-
 drivers/target/target_core_file.c            |   6 +-
 drivers/target/target_core_pscsi.c           |   5 +-
 drivers/usb/gadget/function/storage_common.c |   8 +-
 fs/block_dev.c                               | 755 ++++++++++-----------------
 fs/btrfs/sysfs.c                             |  15 +-
 fs/btrfs/volumes.c                           |  13 +-
 fs/buffer.c                                  |   2 +-
 fs/ext4/ioctl.c                              |   2 +-
 fs/ext4/super.c                              |  18 +-
 fs/ext4/sysfs.c                              |  10 +-
 fs/f2fs/checkpoint.c                         |   5 +-
 fs/f2fs/f2fs.h                               |   2 +-
 fs/f2fs/file.c                               |  14 +-
 fs/f2fs/super.c                              |   8 +-
 fs/f2fs/sysfs.c                              |   9 -
 fs/inode.c                                   |   3 -
 fs/internal.h                                |   7 +-
 fs/io_uring.c                                |  10 +-
 fs/pipe.c                                    |   5 +-
 fs/pstore/blk.c                              |   2 +-
 fs/quota/quota.c                             |  40 +-
 fs/statfs.c                                  |   2 +-
 fs/super.c                                   |  93 +---
 fs/xfs/xfs_fsops.c                           |   7 +-
 include/linux/bio.h                          |  23 +-
 include/linux/blk-cgroup.h                   |   4 +-
 include/linux/blk-mq.h                       |   3 +
 include/linux/blk_types.h                    |  24 +-
 include/linux/blkdev.h                       |  34 +-
 include/linux/blktrace_api.h                 |   5 +-
 include/linux/bvec.h                         |  20 +-
 include/linux/fs.h                           |   5 +-
 include/linux/genhd.h                        | 127 ++---
 include/linux/ide.h                          |   3 -
 include/linux/part_stat.h                    |  45 +-
 include/linux/sbitmap.h                      |   5 -
 include/trace/events/block.h                 | 228 ++------
 init/do_mounts.c                             | 271 +++++-----
 kernel/trace/blktrace.c                      | 181 ++-----
 lib/sbitmap.c                                |  44 +-
 mm/filemap.c                                 |  13 +-
 109 files changed, 2108 insertions(+), 3331 deletions(-)

-- 
Jens Axboe


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A89C00140
	for <linux-block@archiver.kernel.org>; Sun, 31 Jul 2022 15:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiGaPDu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 11:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbiGaPDr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 11:03:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BB3DEE3
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 08:03:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bh13so7614022pgb.4
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=M+CHV26VHg2xl1f7Md0yb49iEnDIed1f5mqDuq1FcZ4=;
        b=APRUx+PSU1G2ZJ1ocQhhalqwESQnVPNYWCD3/XDTqnWw2XTpiMHxAqZAnFxCATBjen
         UyNuFRdI2yD94cIgReB6dXhaoqfCIZpOBdM9SPQ5ivTGXIyNR4W9+6cdiVk6pS+H+DC9
         7bAJFlmYCMsR14ZbdwxvsDPOo6j1lBhIm1JKsryED6NAZVVcDj9ZVTuGQCIupqIcSS/x
         2T8UOijFupO5k3ePPnJzl/q2nNlsHcQ0bUUcBmMCI9tjneBmmvvL47/5WWea1wkinjx3
         ACU5YCU14y5McqvQOF1RnnqtCe//smnwPB5q8BLXknSMzW32VT7Xr1LOCX2nOQX81iA9
         ewug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=M+CHV26VHg2xl1f7Md0yb49iEnDIed1f5mqDuq1FcZ4=;
        b=BfmE6q4aYJ5/BHXHe1OF4K471BrFUSvzuMYO396ZRePfKpq1s9+gONBJHOyUdEQCfw
         oxlXutkwmOyBReDNpUZM5jUubFGviAFkorL2yWWsNy9No+qv3mzfLg9HCsJ8sEA3BLOu
         prU17CUGYkOq3Za0eaCbMI8W1OxqpQo/lKQYimnUKChabiuwzY3bHDNVjG9kaEyPSPhb
         USjeEi9AVkECG5/WcP+jvaCgL4jnPqdyQvsPB1SjBBdKsmCb0G9xJztQZJZEunyQsaKc
         tVwv2bTKXGPtRKEj5KzdD9aN5qbj+O/Q7l5op9UFSrnK5FUVLmDFbV6mFlrQeYvdOR3F
         jLLg==
X-Gm-Message-State: AJIora/nXN5pGDd5eufmEG2IYBvFDEynYHa/PvT/PBdb9Maf4d9W95iD
        4ggNGlxPudOoppwy3IIsPyynZjh9TxTDIw==
X-Google-Smtp-Source: AGRyM1vh2xJB4D6dLdKYZIpE30hOluoynuE6XXmVaLqXFSLo7SgDoFRnM8YKZY4Hw0UpFkgTmoQ06g==
X-Received: by 2002:a63:1f58:0:b0:41a:27e8:d669 with SMTP id q24-20020a631f58000000b0041a27e8d669mr10228030pgm.74.1659279824604;
        Sun, 31 Jul 2022 08:03:44 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090a6e0600b001f31d6fe0f3sm7420090pjk.57.2022.07.31.08.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 08:03:44 -0700 (PDT)
Message-ID: <83a24590-fe65-4b8c-9069-45ad8290a451@kernel.dk>
Date:   Sun, 31 Jul 2022 09:03:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This pull request contains the core block changes queued up for 5.20. In
detail:

- Series improving the type checking of request flags (Bart)

- Ensure queue mapping for a single queues always picks the right queue
  (Bart)

- Series sanitizing the io priority handling (Jan)

- rq-qos race fix (Jinke)

- Reserved tags handling improvements (John)

- Separate memory alignment from file/disk offset aligment for O_DIRECT
  (Keith)

- Add new ublk driver, userspace block driver using io_uring for
  communication with the userspace backend (Ming)

- Use try_cmpxchg() to cleanup the code in various spots (Uros)

- Series finally removing bdevname() (Christoph)

- Series cleaning up the zoned device handling (Christoph)

- Series cleaning up the independent access range support (Christoph)

- Series cleaning up and improving the block sysfs handling (Christoph)

- Series cleaning up and improving teardown of block devices. This turns
  the usual two step process into something that is simpler to implement
  and handle in block drivers (Christoph)

- Series cleaning up the chunk size handling (Christoph)

- Misc cleanups and fixes (Bart, Bo, Dan, GuoYong, Jason, Keith, Liu,
  Ming, Sebastian, Yang, Ying)

Please pull!


The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.20/block-2022-07-29

for you to fetch changes up to 8d9fdb6011b4d413271eba3a62e10f89efecc419:

  ublk_drv: fix double shift bug (2022-07-26 12:30:07 -0600)

----------------------------------------------------------------
for-5.20/block-2022-07-29

----------------------------------------------------------------
Bart Van Assche (70):
      blk-iocost: Simplify ioc_rqos_done()
      block: Rename a blk_mq_map_queue() argument
      block: Make blk_mq_get_sq_hctx() select the proper hardware queue type
      block: bfq: Remove an unused function definition
      block: bfq: Fix kernel-doc headers
      treewide: Rename enum req_opf into enum req_op
      block: Use enum req_op where appropriate
      block: Change the type of the last .rw_page() argument
      block: Change the type of req_op() and bio_op() into enum req_op
      block: Introduce the type blk_opf_t
      block: Use the new blk_opf_t type
      block/bfq: Use the new blk_opf_t type
      block/mq-deadline: Use the new blk_opf_t type
      block/kyber: Use the new blk_opf_t type
      blktrace: Trace remapped requests correctly
      blktrace: Use the new blk_opf_t type
      block/brd: Use the enum req_op type
      block/drbd: Use the enum req_op and blk_opf_t types
      block/drbd: Combine two drbd_submit_peer_request() arguments
      block/floppy: Fix a sparse warning
      block/rnbd: Use blk_opf_t where appropriate
      xen-blkback: Use the enum req_op and blk_opf_t types
      block/zram: Use enum req_op where appropriate
      nvdimm-btt: Use the enum req_op type
      um: Use enum req_op where appropriate
      dm/core: Reduce the size of struct dm_io_request
      dm/core: Rename kcopyd_job.rw into kcopyd.op
      dm/core: Combine request operation type and flags
      dm/ebs: Change 'int rw' into 'enum req_op op'
      dm/dm-flakey: Use the new blk_opf_t type
      dm/dm-integrity: Combine request operation and flags
      dm mirror log: Use the new blk_opf_t type
      dm-snap: Combine request operation type and flags
      dm/zone: Use the enum req_op type
      dm/dm-zoned: Use the enum req_op type
      md/core: Combine two sync_page_io() arguments
      md/bcache: Combine two uuid_io() arguments
      md/bcache: Combine two prio_io() arguments
      md/raid1: Use the new blk_opf_t type
      md/raid10: Use the new blk_opf_t type
      md/raid5: Use the enum req_op and blk_opf_t types
      nvme/host: Use the enum req_op and blk_opf_t types
      nvme/target: Use the new blk_opf_t type
      scsi/core: Improve static type checking
      scsi/core: Change the return type of scsi_noretry_cmd() into bool
      scsi/core: Use the new blk_opf_t type
      scsi/device_handlers: Use the new blk_opf_t type
      scsi/ufs: Rename a 'dir' argument into 'op'
      scsi/target: Use the new blk_opf_t type
      mm: Use the new blk_opf_t type
      fs/buffer: Use the new blk_opf_t type
      fs/buffer: Combine two submit_bh() and ll_rw_block() arguments
      fs/direct-io: Reduce the size of struct dio
      fs/mpage: Use the new blk_opf_t type
      fs/btrfs: Use the enum req_op and blk_opf_t types
      fs/ext4: Use the new blk_opf_t type
      fs/f2fs: Use the enum req_op and blk_opf_t types
      fs/gfs2: Use the enum req_op and blk_opf_t types
      fs/hfsplus: Use the enum req_op and blk_opf_t types
      fs/iomap: Use the new blk_opf_t type
      fs/jbd2: Fix the documentation of the jbd2_write_superblock() callers
      fs/nfs: Use enum req_op where appropriate
      fs/nilfs2: Use the enum req_op and blk_opf_t types
      fs/ntfs3: Use enum req_op where appropriate
      fs/ocfs2: Use the enum req_op and blk_opf_t types
      PM: Use the enum req_op and blk_opf_t types
      fs/xfs: Use the enum req_op and blk_opf_t types
      fs/zonefs: Use the enum req_op type for tracing request operations
      fs/buffer: Fix the ll_rw_block() kernel-doc header
      blktrace: Fix the blk_fill_rwbs() kernel-doc header

Bo Liu (1):
      block: Directly use ida_alloc()/free()

Christoph Hellwig (58):
      block: factor out a chunk_size_left helper
      dm: open code blk_max_size_offset in max_io_len
      block: open code blk_max_size_offset in blk_rq_get_max_sectors
      block: cleanup variable naming in get_max_io_size
      block: fold blk_max_size_offset into get_max_io_size
      block: move blk_queue_get_max_sectors to blk.h
      mtip32xx: remove the device_status debugfs file
      mtip32xx: fix device removal
      block: remove QUEUE_FLAG_DEAD
      block: stop setting the nomerges flags in blk_cleanup_queue
      block: simplify disk shutdown
      block: remove blk_cleanup_disk
      block: simplify blktrace sysfs attribute creation
      block: remove a superflous queue kobject reference
      block: use default groups to register the queue attributes
      block: remove the extra gendisk reference in __blk_mq_register_dev
      blk-mq: rename blk_mq_sysfs_{,un}register
      blk-mq: cleanup disk sysfs registration
      block: move ->ia_ranges from the request_queue to the gendisk
      block: simplify disk_set_independent_access_ranges
      block: remove a superflous ifdef in blkdev.h
      block: call blk_queue_free_zone_bitmaps from disk_release
      block: use bdev_is_zoned instead of open coding it
      block: simplify blk_mq_plug
      block: simplify blk_check_zone_append
      block: pass a gendisk to blk_queue_set_zoned
      block: pass a gendisk to blk_queue_clear_zone_settings
      block: pass a gendisk to blk_queue_free_zone_bitmaps
      block: remove queue_max_open_zones and queue_max_active_zones
      block: pass a gendisk to blk_queue_max_open_zones and blk_queue_max_active_zones
      block: replace blkdev_nr_zones with bdev_nr_zones
      block: use bdev based helpers in blkdev_zone_mgmt{,all}
      nvmet:: use bdev based helpers in nvmet_bdev_zone_mgmt_emulate_all
      dm-zoned: cleanup dmz_fixup_devices
      block: remove blk_queue_zone_sectors
      block: move zone related fields to struct gendisk
      block: stop using bdevname in bdev_write_inode
      block: stop using bdevname in __blkdev_issue_discard
      drbd: stop using bdevname in drbd_report_io_error
      pktcdvd: stop using bdevname in pkt_seq_show
      pktcdvd: stop using bdevname in pkt_new_dev
      rnbd-srv: remove the name field from struct rnbd_dev
      ocfs2/cluster: remove the hr_dev_name field from struct o2hb_region
      ext4: only initialize mmp_bdevname once
      block: remove bdevname
      ublk: remove UBLK_IO_F_INTEGRITY
      ublk: add a MAINTAINERS entry
      ublk: remove UBLK_IO_F_PREFLUSH
      ublk: remove the empty open and release block device operations
      ublk: simplify ublk_ch_open and ublk_ch_release
      ublk: cleanup ublk_ctrl_uring_cmd
      ublk: fold __ublk_create_dev into ublk_ctrl_add_dev
      ublk: rewrite ublk_ctrl_get_queue_affinity to not rely on hctx->cpumask
      ublk: defer disk allocation
      blk-mq: fix error handling in __blk_mq_alloc_disk
      block: call blk_mq_exit_queue from disk_release for never added disks
      block: remove __blk_get_queue
      ublk_drv: fix error handling of ublk_add_dev

Dan Carpenter (2):
      ublk_drv: fix an IS_ERR() vs NULL check
      ublk_drv: fix double shift bug

GuoYong Zheng (1):
      bfq: Remove useless code in bfq_lookup_next_entity

Jan Kara (9):
      block: fix default IO priority handling again
      block: Return effective IO priority from get_current_ioprio()
      block: Generalize get_current_ioprio() for any task
      block: Make ioprio_best() static
      block: Fix handling of tasks without ioprio in ioprio_get(2)
      blk-ioprio: Remove unneeded field
      blk-ioprio: Convert from rqos policy to direct call
      block: Initialize bio priority earlier
      block: Always initialize bio IO priority on submit

Jason Yan (2):
      blk-cgroup: factor out blkcg_iostat_update()
      blk-cgroup: factor out blkcg_free_all_cpd()

Jinke Han (1):
      block: don't allow the same type rq_qos add more than once

John Garry (6):
      scsi: core: Remove reserved request time-out handling
      blk-mq: Add a flag for reserved requests
      blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
      scsi: fnic: Drop reserved request handling
      blk-mq: Drop 'reserved' arg of busy_tag_iter_fn
      blk-mq: Drop local variable for reserved tag

Keith Busch (11):
      block: fix infinite loop for invalid zone append
      block/bio: remove duplicate append pages code
      block: export dma_alignment attribute
      block: introduce bdev_dma_alignment helper
      block: add a helper function for dio alignment
      block/merge: count bytes instead of sectors
      block/bounce: count bytes instead of sectors
      iov: introduce iov_iter_aligned
      block: introduce bdev_iter_is_aligned helper
      block: relax direct io memory alignment
      iomap: add support for dma aligned direct-io

Liu Song (1):
      blk-mq: blk_mq_tag_busy is no need to return a value

Ming Lei (8):
      blk-mq: don't create hctx debugfs dir until q->debugfs_dir is created
      ublk_drv: add io_uring based userspace block driver
      ublk_drv: support to complete io command via task_work_add
      ublk_drv: fix request queue leak
      ublk_drv: fix build warning with -Wmaybe-uninitialized and one sparse warning
      mmc: fix disk/queue leak in case of adding disk failure
      ublk_drv: fix lockdep warning
      ublk_drv: make sure that correct flags(features) returned to userspace

Sebastian Andrzej Siewior (1):
      blk-mq: Don't disable preemption around __blk_mq_run_hw_queue().

Uros Bizjak (4):
      block/rq_qos: Use atomic_try_cmpxchg in atomic_inc_below
      block: Use try_cmpxchg in update_io_ticks
      blk-iolatency: Use atomic{,64}_try_cmpxchg
      blk-cgroup: Use atomic{,64}_try_cmpxchg

Yang Li (1):
      ublk_drv: remove unneeded semicolon

Yang Yingliang (1):
      ublk_drv: fix missing error return code in ublk_add_dev()

Ying Sun (1):
      block: remove "select BLK_RQ_IO_DATA_LEN" from BLK_CGROUP_IOCOST dependency

 Documentation/ABI/stable/sysfs-block        |    9 +
 Documentation/scsi/scsi_eh.rst              |    3 +-
 Documentation/scsi/scsi_mid_low_api.rst     |    2 +-
 MAINTAINERS                                 |    7 +
 arch/m68k/emu/nfblock.c                     |    4 +-
 arch/um/drivers/ubd_kern.c                  |    8 +-
 arch/xtensa/platforms/iss/simdisk.c         |    4 +-
 block/Kconfig                               |    1 -
 block/bdev.c                                |   10 +-
 block/bfq-cgroup.c                          |   34 +-
 block/bfq-iosched.c                         |   16 +-
 block/bfq-iosched.h                         |    8 +-
 block/bfq-wf2q.c                            |    5 +-
 block/bio.c                                 |  126 +--
 block/blk-cgroup-rwstat.h                   |    8 +-
 block/blk-cgroup.c                          |   76 +-
 block/blk-cgroup.h                          |   12 +-
 block/blk-core.c                            |   80 +-
 block/blk-flush.c                           |    6 +-
 block/blk-ia-ranges.c                       |   65 +-
 block/blk-ioc.c                             |    2 +
 block/blk-iocost.c                          |   22 +-
 block/blk-iolatency.c                       |   30 +-
 block/blk-ioprio.c                          |   57 +-
 block/blk-ioprio.h                          |    9 +
 block/blk-lib.c                             |    6 +-
 block/blk-merge.c                           |   79 +-
 block/blk-mq-debugfs-zoned.c                |    6 +-
 block/blk-mq-debugfs.c                      |   19 +-
 block/blk-mq-sysfs.c                        |   45 +-
 block/blk-mq-tag.c                          |   31 +-
 block/blk-mq-tag.h                          |   10 +-
 block/blk-mq.c                              |  105 +-
 block/blk-mq.h                              |   39 +-
 block/blk-rq-qos.c                          |   10 +-
 block/blk-rq-qos.h                          |   11 +-
 block/blk-settings.c                        |   11 +-
 block/blk-sysfs.c                           |   60 +-
 block/blk-throttle.c                        |    7 +-
 block/blk-wbt.c                             |   30 +-
 block/blk-zoned.c                           |   92 +-
 block/blk.h                                 |   34 +-
 block/bounce.c                              |   13 +-
 block/bsg-lib.c                             |    6 +-
 block/elevator.h                            |    2 +-
 block/fops.c                                |   28 +-
 block/genhd.c                               |   80 +-
 block/ioctl.c                               |    2 +-
 block/ioprio.c                              |   58 +-
 block/kyber-iosched.c                       |    8 +-
 block/mq-deadline.c                         |    4 +-
 block/partitions/core.c                     |    3 +-
 drivers/block/Kconfig                       |    9 +
 drivers/block/Makefile                      |    2 +
 drivers/block/amiflop.c                     |    2 +-
 drivers/block/aoe/aoeblk.c                  |    2 +-
 drivers/block/aoe/aoedev.c                  |    2 +-
 drivers/block/ataflop.c                     |    5 +-
 drivers/block/brd.c                         |    8 +-
 drivers/block/drbd/drbd_actlog.c            |    9 +-
 drivers/block/drbd/drbd_bitmap.c            |    2 +-
 drivers/block/drbd/drbd_int.h               |    5 +-
 drivers/block/drbd/drbd_main.c              |    4 +-
 drivers/block/drbd/drbd_receiver.c          |   24 +-
 drivers/block/drbd/drbd_req.c               |    6 +-
 drivers/block/drbd/drbd_worker.c            |    2 +-
 drivers/block/floppy.c                      |    8 +-
 drivers/block/loop.c                        |    3 +-
 drivers/block/mtip32xx/mtip32xx.c           |  307 +-----
 drivers/block/mtip32xx/mtip32xx.h           |    5 -
 drivers/block/n64cart.c                     |    2 +-
 drivers/block/nbd.c                         |    9 +-
 drivers/block/null_blk/main.c               |   15 +-
 drivers/block/null_blk/null_blk.h           |   12 +-
 drivers/block/null_blk/trace.h              |    2 +-
 drivers/block/null_blk/zoned.c              |   12 +-
 drivers/block/paride/pcd.c                  |    4 +-
 drivers/block/paride/pd.c                   |    6 +-
 drivers/block/paride/pf.c                   |    4 +-
 drivers/block/pktcdvd.c                     |   14 +-
 drivers/block/ps3disk.c                     |    4 +-
 drivers/block/ps3vram.c                     |    4 +-
 drivers/block/rbd.c                         |    2 +-
 drivers/block/rnbd/rnbd-clt.c               |    6 +-
 drivers/block/rnbd/rnbd-proto.h             |    7 +-
 drivers/block/rnbd/rnbd-srv-dev.c           |    1 -
 drivers/block/rnbd/rnbd-srv-dev.h           |    1 -
 drivers/block/rnbd/rnbd-srv-sysfs.c         |    5 +-
 drivers/block/rnbd/rnbd-srv.c               |    9 +-
 drivers/block/rnbd/rnbd-srv.h               |    3 +-
 drivers/block/sunvdc.c                      |    4 +-
 drivers/block/swim.c                        |    2 +-
 drivers/block/swim3.c                       |    2 +-
 drivers/block/sx8.c                         |    6 +-
 drivers/block/ublk_drv.c                    | 1545 +++++++++++++++++++++++++++
 drivers/block/virtio_blk.c                  |    3 +-
 drivers/block/xen-blkback/blkback.c         |    6 +-
 drivers/block/xen-blkfront.c                |    4 +-
 drivers/block/z2ram.c                       |    3 +-
 drivers/block/zram/zram_drv.c               |    8 +-
 drivers/cdrom/gdrom.c                       |    3 +-
 drivers/infiniband/ulp/srp/ib_srp.c         |    3 +-
 drivers/md/bcache/super.c                   |   27 +-
 drivers/md/dm-bufio.c                       |   26 +-
 drivers/md/dm-ebs-target.c                  |   15 +-
 drivers/md/dm-flakey.c                      |    8 +-
 drivers/md/dm-integrity.c                   |   76 +-
 drivers/md/dm-io.c                          |   38 +-
 drivers/md/dm-kcopyd.c                      |   26 +-
 drivers/md/dm-log.c                         |    8 +-
 drivers/md/dm-raid.c                        |    2 +-
 drivers/md/dm-raid1.c                       |   12 +-
 drivers/md/dm-snap-persistent.c             |   25 +-
 drivers/md/dm-table.c                       |    6 +-
 drivers/md/dm-writecache.c                  |   12 +-
 drivers/md/dm-zone.c                        |   88 +-
 drivers/md/dm-zoned-metadata.c              |    5 +-
 drivers/md/dm-zoned-target.c                |   25 +-
 drivers/md/dm-zoned.h                       |    2 +-
 drivers/md/dm.c                             |   33 +-
 drivers/md/md-bitmap.c                      |    6 +-
 drivers/md/md.c                             |   16 +-
 drivers/md/md.h                             |    3 +-
 drivers/md/raid1.c                          |   14 +-
 drivers/md/raid10.c                         |   22 +-
 drivers/md/raid5-cache.c                    |   12 +-
 drivers/md/raid5-ppl.c                      |   12 +-
 drivers/md/raid5.c                          |    3 +-
 drivers/memstick/core/ms_block.c            |    3 +-
 drivers/memstick/core/mspro_block.c         |    3 +-
 drivers/mmc/core/block.c                    |    6 +-
 drivers/mmc/core/queue.c                    |    4 +-
 drivers/mtd/mtd_blkdevs.c                   |    4 +-
 drivers/mtd/ubi/block.c                     |    4 +-
 drivers/nvdimm/btt.c                        |    8 +-
 drivers/nvdimm/pmem.c                       |    6 +-
 drivers/nvme/host/apple.c                   |    5 +-
 drivers/nvme/host/core.c                    |    5 +-
 drivers/nvme/host/fc.c                      |   18 +-
 drivers/nvme/host/ioctl.c                   |    4 +-
 drivers/nvme/host/multipath.c               |    4 +-
 drivers/nvme/host/nvme.h                    |    4 +-
 drivers/nvme/host/pci.c                     |    4 +-
 drivers/nvme/host/rdma.c                    |   15 +-
 drivers/nvme/host/tcp.c                     |   15 +-
 drivers/nvme/host/zns.c                     |    6 +-
 drivers/nvme/target/io-cmd-bdev.c           |   17 +-
 drivers/nvme/target/loop.c                  |   12 +-
 drivers/nvme/target/zns.c                   |   24 +-
 drivers/s390/block/dasd.c                   |    4 +-
 drivers/s390/block/dasd_genhd.c             |    4 +-
 drivers/s390/block/dasd_int.h               |    2 +-
 drivers/s390/block/dcssblk.c                |    8 +-
 drivers/s390/block/scm_blk.c                |    4 +-
 drivers/scsi/aacraid/comminit.c             |    2 +-
 drivers/scsi/aacraid/linit.c                |    2 +-
 drivers/scsi/device_handler/scsi_dh_alua.c  |    4 +-
 drivers/scsi/device_handler/scsi_dh_emc.c   |    2 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c |    4 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c  |    2 +-
 drivers/scsi/fnic/fnic_scsi.c               |   14 +-
 drivers/scsi/hosts.c                        |   14 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c             |   16 +-
 drivers/scsi/scsi_error.c                   |   22 +-
 drivers/scsi/scsi_lib.c                     |   26 +-
 drivers/scsi/scsi_priv.h                    |    4 +-
 drivers/scsi/scsi_sysfs.c                   |    2 +-
 drivers/scsi/sd.c                           |   10 +-
 drivers/scsi/sd_zbc.c                       |   12 +-
 drivers/scsi/sr.c                           |    4 +-
 drivers/target/target_core_iblock.c         |    4 +-
 drivers/ufs/core/ufshcd.c                   |    4 +-
 drivers/ufs/core/ufshpb.c                   |    7 +-
 fs/btrfs/check-integrity.c                  |    4 +-
 fs/btrfs/compression.c                      |    6 +-
 fs/btrfs/compression.h                      |    2 +-
 fs/btrfs/extent_io.c                        |   18 +-
 fs/btrfs/inode.c                            |    4 +-
 fs/btrfs/raid56.c                           |    4 +-
 fs/buffer.c                                 |   61 +-
 fs/direct-io.c                              |   40 +-
 fs/ext4/ext4.h                              |    8 +-
 fs/ext4/fast_commit.c                       |    4 +-
 fs/ext4/mmp.c                               |   11 +-
 fs/ext4/super.c                             |   20 +-
 fs/f2fs/data.c                              |   11 +-
 fs/f2fs/f2fs.h                              |    6 +-
 fs/f2fs/node.c                              |    2 +-
 fs/f2fs/segment.c                           |    2 +-
 fs/gfs2/bmap.c                              |    5 +-
 fs/gfs2/dir.c                               |    5 +-
 fs/gfs2/log.c                               |    4 +-
 fs/gfs2/log.h                               |    2 +-
 fs/gfs2/lops.c                              |    4 +-
 fs/gfs2/lops.h                              |    2 +-
 fs/gfs2/meta_io.c                           |   18 +-
 fs/gfs2/quota.c                             |    2 +-
 fs/hfsplus/hfsplus_fs.h                     |    2 +-
 fs/hfsplus/part_tbl.c                       |    5 +-
 fs/hfsplus/super.c                          |    4 +-
 fs/hfsplus/wrapper.c                        |   12 +-
 fs/iomap/direct-io.c                        |   12 +-
 fs/isofs/compress.c                         |    2 +-
 fs/jbd2/commit.c                            |    8 +-
 fs/jbd2/journal.c                           |   25 +-
 fs/jbd2/recovery.c                          |    4 +-
 fs/mpage.c                                  |    6 +-
 fs/nfs/blocklayout/blocklayout.c            |   13 +-
 fs/nilfs2/btnode.c                          |    8 +-
 fs/nilfs2/btnode.h                          |    4 +-
 fs/nilfs2/btree.c                           |    6 +-
 fs/nilfs2/gcinode.c                         |    7 +-
 fs/nilfs2/mdt.c                             |   19 +-
 fs/ntfs/aops.c                              |    6 +-
 fs/ntfs/compress.c                          |    2 +-
 fs/ntfs/file.c                              |    2 +-
 fs/ntfs/logfile.c                           |    2 +-
 fs/ntfs/mft.c                               |    4 +-
 fs/ntfs3/file.c                             |    2 +-
 fs/ntfs3/fsntfs.c                           |    2 +-
 fs/ntfs3/inode.c                            |    2 +-
 fs/ntfs3/ntfs_fs.h                          |    2 +-
 fs/ocfs2/aops.c                             |    2 +-
 fs/ocfs2/buffer_head_io.c                   |    8 +-
 fs/ocfs2/cluster/heartbeat.c                |   75 +-
 fs/ocfs2/super.c                            |    2 +-
 fs/reiserfs/inode.c                         |    4 +-
 fs/reiserfs/journal.c                       |   12 +-
 fs/reiserfs/stree.c                         |    4 +-
 fs/reiserfs/super.c                         |    2 +-
 fs/udf/dir.c                                |    2 +-
 fs/udf/directory.c                          |    2 +-
 fs/udf/inode.c                              |    2 +-
 fs/ufs/balloc.c                             |    2 +-
 fs/xfs/xfs_bio_io.c                         |    2 +-
 fs/xfs/xfs_buf.c                            |    4 +-
 fs/xfs/xfs_linux.h                          |    2 +-
 fs/xfs/xfs_log_recover.c                    |    2 +-
 fs/zonefs/super.c                           |   22 +-
 fs/zonefs/trace.h                           |    4 +-
 include/linux/bio.h                         |   10 +-
 include/linux/blk-mq.h                      |   34 +-
 include/linux/blk_types.h                   |  119 ++-
 include/linux/blkdev.h                      |  224 ++--
 include/linux/blktrace_api.h                |   13 +-
 include/linux/buffer_head.h                 |    9 +-
 include/linux/dm-io.h                       |    4 +-
 include/linux/ioprio.h                      |   24 +-
 include/linux/jbd2.h                        |    2 +-
 include/linux/uio.h                         |    2 +
 include/linux/writeback.h                   |    4 +-
 include/scsi/scsi_cmnd.h                    |    4 +-
 include/scsi/scsi_device.h                  |    2 +-
 include/scsi/scsi_host.h                    |    2 +-
 include/trace/events/f2fs.h                 |   22 +-
 include/trace/events/jbd2.h                 |   12 +-
 include/trace/events/nilfs2.h               |    4 +-
 include/uapi/linux/ublk_cmd.h               |  161 +++
 kernel/power/swap.c                         |   29 +-
 kernel/trace/blktrace.c                     |   72 +-
 lib/iov_iter.c                              |   92 ++
 261 files changed, 3635 insertions(+), 2158 deletions(-)
 create mode 100644 drivers/block/ublk_drv.c
 create mode 100644 include/uapi/linux/ublk_cmd.h

-- 
Jens Axboe


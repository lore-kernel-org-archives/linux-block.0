Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C730C433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 21:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbiCRWAs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 18:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbiCRWAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 18:00:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D93FD6CE
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 14:59:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so3390185pjq.2
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=NEbPxMruiChMp50zwQqj6Y0lb2NbeP0OtI5RLj6R5Wc=;
        b=UhtoDrpR/VI34icLKLvj6/zSQuDqYPXBVebMTIlNkPQuz10sgn+Sq+m5HpttIWcHWb
         E060b4Tm5yEkwe6iUStGJIjzcNmwwhGGZmz2WnephwJi2tD9ulWtUwQBswtjpS+0kGui
         nzRuJ4l1YXMwUnUTu+CCNu7CYCijQkwQmTWygWFl8BJr9BDCv7K8DGwtRY+o3r0jck7b
         yZCcI3LHdt/hX//dXBsXxjsyhs9+OavNZFxa7T7ST7n27/4V1CxFGl0loR3ZS1ItBjkT
         rQD2oJnxN+mK6wrTCKpX7Eu46WGRBrmJ3WhqLl0CYLOxKaqN1aqaONCMr1xYsjkRTuUE
         EXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=NEbPxMruiChMp50zwQqj6Y0lb2NbeP0OtI5RLj6R5Wc=;
        b=qC7QXTDoLKVyshLiO7XeqtYuNgIFBvzUPLQR7MpqPHQ6DqCIdV5YRgRuh8Bl977EIJ
         f765yUPqDOfF+Sf/JWGe7bRGQzikitjj78rEWQyI9DGTGxUVY12Hhnf4Tl8QSYudLAsC
         gUiMvj6iqxRjGC0GrqTZHhpKJrPDQ1fijYfrZKZEoHGrGP0rs0ViC2JnSMytnDrn/mwb
         hap/W+A84gEUGxIEJHGl/pSTgmHBWnJcotP2wk9gWZfYmR+2w5UCKQOvvyNXB2aOy933
         ac+MJV8aSeXEuE2ojfluqy8Wty1MbXGWz81ygUJDeGlbiB4Hnb4RokbjBZcXZIv/1w6O
         rETg==
X-Gm-Message-State: AOAM532EqU+RfCmMHbTcWdvbbz8rW8/pfb9e8J3NfeJaQIujoJv6kiQ1
        OIBtZL+DUJ7T+tsia/SgWiMQL92qBwRfoceJ
X-Google-Smtp-Source: ABdhPJyUhEZ8FxRq5Ye+kAb6gJj0214x+HQ0bvj4pMCmDMXhnTIZTvW5eFOzHHaifySr+4wPAPFt2Q==
X-Received: by 2002:a17:90b:3849:b0:1c6:9f29:c55e with SMTP id nl9-20020a17090b384900b001c69f29c55emr8644443pjb.36.1647640766696;
        Fri, 18 Mar 2022 14:59:26 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id nn15-20020a17090b38cf00b001bfceefd8cfsm13121630pjb.48.2022.03.18.14.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 14:59:26 -0700 (PDT)
Message-ID: <e54f7c1a-90d1-1886-cbb4-6a78d490f0a9@kernel.dk>
Date:   Fri, 18 Mar 2022 15:59:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the block changes queued up for the 5.18-rc1 merge window. In
detail:

- BFQ cleanups and fixes (Yu, Zhang, Yahu, Paolo)

- blk-rq-qos completion fix (Tejun)

- blk-cgroup merge fix (Tejun)

- Add offline error return value to distinguish it from an IO error on
  the device (Song)

- IO stats fixes (Zhang, Christoph)

- blkcg refcount fixes (Ming, Yu)

- Fix for indefinite dispatch loop softlockup (Shin'ichiro)

- blk-mq hardware queue management improvements (Ming)

- sbitmap dead code removal (Ming, John)

- Plugging merge improvements (me)

- Show blk-crypto capabilities in sysfs (Eric)

- Multiple delayed queue run improvement (David)

- Block throttling fixes (Ming)

- Start deprecating auto module loading based on dev_t (Christoph)

- bio allocation improvements (Christoph, Chaitanya)

- Get rid of bio_devname (Christoph)

- bio clone improvements (Christoph)

- Block plugging improvements (Christoph)

- Get rid of genhd.h header (Christoph)

- Ensure drivers use appropriate flush helpers (Christoph)

- Refcounting improvements (Christoph)

- Queue initialization and teardown improvements (Ming, Christoph)

- Misc fixes/improvements (Barry, Chaitanya, Colin, Dan, Jiapeng, Lukas,
  Nian, Yang, Eric, Chengming)

This will throw a merge conflicts in drivers/block/virtio_blk.c since
sg_elems got removed in the 5.17 release series. Trivial fixup, both
sg_elems and refs just need to be removed from the struct.

Please pull!


The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/block-2022-03-18

for you to fetch changes up to 8f9e7b65f833cb9a4b2e2f54a049d74df394d906:

  block: cancel all throttled bios in del_gendisk() (2022-03-18 09:57:56 -0600)

----------------------------------------------------------------
for-5.18/block-2022-03-18

----------------------------------------------------------------
Barry Song (1):
      docs: block: biodoc.rst: Drop the obsolete and incorrect content

Chaitanya Kulkarni (2):
      block: pass a block_device and opf to blk_next_bio
      blk-lib: don't check bdev_get_queue() NULL check

Chengming Zhou (1):
      blk-cgroup: set blkg iostat after percpu stat aggregation

Christoph Hellwig (70):
      block: deprecate autoloading based on dev_t
      block: move disk_{block,unblock,flush}_events to blk.h
      block: move blk_drop_partitions to blk.h
      block: remove genhd.h
      fs: remove mpage_alloc
      nilfs2: remove nilfs_alloc_seg_bio
      nfs/blocklayout: remove bl_alloc_init_bio
      ntfs3: remove ntfs_alloc_bio
      dm: bio_alloc can't fail if it is allowed to sleep
      dm-crypt: remove clone_init
      dm-snap: use blkdev_issue_flush instead of open coding it
      dm-thin: use blkdev_issue_flush instead of open coding it
      drbd: bio_alloc can't fail if it is allow to sleep
      rnbd-srv: simplify bio mapping in process_rdma
      rnbd-srv: remove struct rnbd_dev_blk_io
      xen-blkback: bio_alloc can't fail if it is allow to sleep
      block: move blk_next_bio to bio.c
      block: pass a block_device and opf to bio_alloc_bioset
      block: pass a block_device and opf to bio_alloc_kiocb
      block: pass a block_device and opf to bio_alloc
      block: pass a block_device and opf to bio_init
      block: pass a block_device and opf to bio_reset
      block: remove blk_needs_flush_plug
      block: check that there is a plug in blk_flush_plug
      block: fix the kerneldoc for bio_end_io_acct
      MAINTAINERS: add bio.h to the block section
      block: call bio_associate_blkg from bio_reset
      drbd: set ->bi_bdev in drbd_req_new
      dm: add a clone_to_tio helper
      dm: fold clone_bio into __clone_and_map_data_bio
      dm: fold __send_duplicate_bios into __clone_and_map_simple_bio
      dm: move cloning the bio into alloc_tio
      dm: pass the bio instead of tio to __map_bio
      dm: retun the clone bio from alloc_tio
      dm: simplify the single bio fast path in __send_duplicate_bios
      dm-cache: remove __remap_to_origin_clear_discard
      block: clone crypto and integrity data in __bio_clone_fast
      dm: use bio_clone_fast in alloc_io/alloc_tio
      block: initialize the target bio in __bio_clone_fast
      block: pass a block_device to bio_clone_fast
      block: remove biodoc.rst
      blk-mq: make the blk-mq stacking code optional
      blk-mq: fold blk_cloned_rq_check_limits into blk_insert_cloned_request
      blk-mq: remove the request_queue argument to blk_insert_cloned_request
      dm: remove useless code from dm_dispatch_clone_request
      dm: remove dm_dispatch_clone_request
      block: add a ->free_disk method
      memstick/ms_block: simplify refcounting
      memstick/mspro_block: fix handling of read-only devices
      memstick/mspro_block: simplify refcounting
      virtio_blk: simplify refcounting
      block: default BLOCK_LEGACY_AUTOLOAD to y
      block: fix and cleanup bio_check_ro
      block: remove handle_bad_sector
      pktcdvd: remove a pointless debug check in pkt_submit_bio
      dm-crypt: stop using bio_devname
      dm-integrity: stop using bio_devname
      md-multipath: stop using bio_devname
      raid1: stop using bio_devname
      raid5-ppl: stop using bio_devname
      ext4: stop using bio_devname
      block: remove bio_devname
      blk-mq: do not include passthrough requests in I/O accounting
      scsi: don't use disk->private_data to find the scsi_driver
      sd: rename the scsi_disk.dev field
      sd: call sd_zbc_release_disk before releasing the scsi_device reference
      sd: delay calling free_opal_dev
      sd: implement ->free_disk to simplify refcounting
      sr: implement ->free_disk to simplify refcounting
      block: do more work in elevator_exit

Colin Ian King (1):
      block/bfq-iosched: Fix spelling mistake "tenative" -> "tentative"

Dan Carpenter (1):
      fs/ntfs3: remove unnecessary NULL check

David Jeffery (1):
      blk-mq: avoid extending delays of active hctx from blk_mq_delay_run_hw_queues

Eric Biggers (3):
      block: simplify calling convention of elv_unregister_queue()
      block: don't delete queue kobject before its children
      blk-crypto: show crypto capabilities in sysfs

Jens Axboe (2):
      block: ensure plug merging checks the correct queue at least once
      block: flush plug based on hardware and software queue order

Jiapeng Chong (1):
      block: fix boolreturn.cocci warning

John Garry (1):
      sbitmap: Delete old sbitmap_queue_get_shallow()

Lukas Bulwahn (1):
      sr: simplify the local variable initialization in sr_block_open()

Ming Lei (26):
      lib/sbitmap: kill 'depth' from sbitmap_word
      block: remove THROTL_IOPS_MAX
      block: move initialization of q->blkg_list into blkcg_init_queue
      block: partition include/linux/blk-cgroup.h
      block: move submit_bio_checks() into submit_bio_noacct
      block: move blk_crypto_bio_prep() out of blk-mq.c
      block: don't declare submit_bio_checks in local header
      block: don't check bio in blk_throtl_dispatch_work_fn
      block: merge submit_bio_checks() into submit_bio_noacct
      block: throttle split bio in case of iops limit
      block: don't try to throttle split bio if iops limit isn't set
      block: revert 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios")
      blk-mq: figure out correct numa node for hw queue
      blk-mq: simplify reallocation of hw ctxs a bit
      blk-mq: reconfigure poll after queue map is changed
      block: mtip32xx: don't touch q->queue_hw_ctx
      blk-mq: prepare for implementing hctx table via xarray
      blk-mq: manage hctx map via xarray
      blk-mq: handle already freed tags gracefully in blk_mq_free_rqs
      block: move blkcg initialization/destroy into disk allocation/release handler
      block: don't remove hctx debugfs dir from blk_mq_exit_queue
      block: move q_usage_counter release into blk_queue_release
      block: move blk_exit_queue into disk_release
      block: move rq_qos_exit() into disk_release()
      block: avoid use-after-free on throttle data
      block: let blkcg_gq grab request queue's refcnt

Nian Yanchuan (1):
      block: remove redundant semicolon

Paolo Valente (1):
      Revert "Revert "block, bfq: honor already-setup queue merges""

Shin'ichiro Kawasaki (1):
      block: limit request dispatch loop duration

Song Liu (3):
      block: introduce BLK_STS_OFFLINE
      block: return -ENODEV for BLK_STS_OFFLINE
      scsi: use BLK_STS_OFFLINE for not fully online devices

Tejun Heo (2):
      block: fix rq-qos breakage from skipping rq_qos_done_bio()
      block: don't merge across cgroup boundaries if blkcg is enabled

Yahu Gao (1):
      block/bfq_wf2q: correct weight to ioprio

Yang Shi (1):
      block: introduce block_rq_error tracepoint

Yu Kuai (4):
      block, bfq: cleanup bfq_bfqq_to_bfqg()
      block, bfq: avoid moving bfqq to it's parent bfqg
      block, bfq: don't move oom_bfqq
      block: cancel all throttled bios in del_gendisk()

Zhang Wensheng (2):
      block: update io_ticks when io hang
      bfq: fix use-after-free in bfq_dispatch_request

 Documentation/ABI/stable/sysfs-block |   49 ++
 Documentation/block/biodoc.rst       | 1164 ----------------------------------
 Documentation/block/capability.rst   |    2 +-
 Documentation/block/index.rst        |    1 -
 MAINTAINERS                          |    1 +
 arch/m68k/atari/stdma.c              |    1 -
 arch/m68k/bvme6000/config.c          |    1 -
 arch/m68k/emu/nfblock.c              |    1 -
 arch/m68k/kernel/setup_mm.c          |    1 -
 arch/m68k/mvme147/config.c           |    1 -
 arch/m68k/mvme16x/config.c           |    1 -
 block/Kconfig                        |   13 +
 block/Makefile                       |    3 +-
 block/bdev.c                         |   11 +-
 block/bfq-cgroup.c                   |   16 +-
 block/bfq-iosched.c                  |   37 +-
 block/bfq-iosched.h                  |    2 -
 block/bfq-wf2q.c                     |   17 +-
 block/bio-integrity.c                |    1 -
 block/bio.c                          |  190 +++---
 block/blk-cgroup-rwstat.h            |    2 +-
 block/blk-cgroup.c                   |   20 +-
 block/blk-cgroup.h                   |  494 +++++++++++++++
 block/blk-core.c                     |  293 ++++-----
 block/blk-crypto-fallback.c          |    2 +-
 block/blk-crypto-internal.h          |   12 +
 block/blk-crypto-sysfs.c             |  172 +++++
 block/blk-crypto.c                   |    4 +-
 block/blk-flush.c                    |    4 +-
 block/blk-iocost.c                   |    2 +-
 block/blk-iolatency.c                |    4 +-
 block/blk-ioprio.c                   |    2 +-
 block/blk-lib.c                      |   46 +-
 block/blk-merge.c                    |   33 +-
 block/blk-mq-debugfs.c               |    6 +-
 block/blk-mq-debugfs.h               |    2 +
 block/blk-mq-sched.c                 |   18 +-
 block/blk-mq-sysfs.c                 |   16 +-
 block/blk-mq-tag.c                   |    6 +-
 block/blk-mq.c                       |  303 ++++-----
 block/blk-mq.h                       |    2 +-
 block/blk-rq-qos.h                   |   20 +-
 block/blk-sysfs.c                    |   44 +-
 block/blk-throttle.c                 |  110 ++--
 block/blk-throttle.h                 |   19 +-
 block/blk-zoned.c                    |   14 +-
 block/blk.h                          |   10 +-
 block/bounce.c                       |   11 +-
 block/disk-events.c                  |    2 +-
 block/elevator.c                     |   16 +-
 block/fops.c                         |   35 +-
 block/genhd.c                        |   67 +-
 block/holder.c                       |    2 +-
 block/partitions/check.h             |    1 -
 block/partitions/core.c              |    1 -
 block/partitions/efi.h               |    1 -
 block/partitions/ldm.h               |    1 -
 block/sed-opal.c                     |    2 +-
 drivers/base/class.c                 |    2 +-
 drivers/base/core.c                  |    2 +-
 drivers/base/devtmpfs.c              |    2 +-
 drivers/block/aoe/aoeblk.c           |    1 -
 drivers/block/aoe/aoecmd.c           |    1 -
 drivers/block/drbd/drbd_actlog.c     |    5 +-
 drivers/block/drbd/drbd_bitmap.c     |    7 +-
 drivers/block/drbd/drbd_int.h        |    1 -
 drivers/block/drbd/drbd_receiver.c   |   32 +-
 drivers/block/drbd/drbd_req.c        |    5 +-
 drivers/block/drbd/drbd_worker.c     |    4 +-
 drivers/block/floppy.c               |    4 +-
 drivers/block/mtip32xx/mtip32xx.c    |    5 +-
 drivers/block/mtip32xx/mtip32xx.h    |    1 -
 drivers/block/pktcdvd.c              |   21 +-
 drivers/block/rnbd/rnbd-clt.c        |    2 +-
 drivers/block/rnbd/rnbd-srv-dev.c    |   61 +-
 drivers/block/rnbd/rnbd-srv-dev.h    |   18 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c  |    1 -
 drivers/block/rnbd/rnbd-srv.c        |   45 +-
 drivers/block/rnbd/rnbd-srv.h        |    1 -
 drivers/block/sunvdc.c               |    1 -
 drivers/block/virtio_blk.c           |   66 +-
 drivers/block/xen-blkback/blkback.c  |   25 +-
 drivers/block/zram/zram_drv.c        |   17 +-
 drivers/cdrom/gdrom.c                |    1 -
 drivers/char/random.c                |    2 +-
 drivers/md/Kconfig                   |    1 +
 drivers/md/bcache/io.c               |    3 +-
 drivers/md/bcache/journal.c          |   16 +-
 drivers/md/bcache/movinggc.c         |    4 +-
 drivers/md/bcache/request.c          |   22 +-
 drivers/md/bcache/super.c            |    9 +-
 drivers/md/bcache/writeback.c        |    4 +-
 drivers/md/dm-cache-target.c         |   26 +-
 drivers/md/dm-core.h                 |    1 -
 drivers/md/dm-crypt.c                |   46 +-
 drivers/md/dm-integrity.c            |    5 +-
 drivers/md/dm-io.c                   |    5 +-
 drivers/md/dm-log-writes.c           |   39 +-
 drivers/md/dm-rq.c                   |   26 +-
 drivers/md/dm-snap.c                 |   21 +-
 drivers/md/dm-thin.c                 |   41 +-
 drivers/md/dm-writecache.c           |    7 +-
 drivers/md/dm-zoned-metadata.c       |   26 +-
 drivers/md/dm-zoned-target.c         |    3 +-
 drivers/md/dm.c                      |  172 ++---
 drivers/md/md-faulty.c               |    4 +-
 drivers/md/md-multipath.c            |   13 +-
 drivers/md/md.c                      |   29 +-
 drivers/md/raid1.c                   |   47 +-
 drivers/md/raid10.c                  |   30 +-
 drivers/md/raid5-cache.c             |   19 +-
 drivers/md/raid5-ppl.c               |   26 +-
 drivers/md/raid5.c                   |   16 +-
 drivers/memstick/core/ms_block.c     |   64 +-
 drivers/memstick/core/ms_block.h     |    1 -
 drivers/memstick/core/mspro_block.c  |   57 +-
 drivers/mtd/mtdswap.c                |    2 +-
 drivers/mtd/nand/raw/sharpsl.c       |    1 -
 drivers/nvdimm/blk.c                 |    1 -
 drivers/nvdimm/btt.c                 |    1 -
 drivers/nvdimm/btt_devs.c            |    1 -
 drivers/nvdimm/bus.c                 |    1 -
 drivers/nvdimm/nd_virtio.c           |    6 +-
 drivers/nvdimm/pfn_devs.c            |    1 -
 drivers/nvme/target/io-cmd-bdev.c    |   18 +-
 drivers/nvme/target/passthru.c       |    7 +-
 drivers/nvme/target/zns.c            |   14 +-
 drivers/s390/block/dasd_int.h        |    1 -
 drivers/s390/block/scm_blk.c         |    1 -
 drivers/s390/block/scm_blk.h         |    1 -
 drivers/scsi/scsi_debug.c            |    1 -
 drivers/scsi/scsi_lib.c              |    2 +-
 drivers/scsi/scsicam.c               |    1 -
 drivers/scsi/sd.c                    |  115 +---
 drivers/scsi/sd.h                    |   12 +-
 drivers/scsi/sr.c                    |  131 +---
 drivers/scsi/sr.h                    |    6 -
 drivers/scsi/st.c                    |    1 -
 drivers/scsi/st.h                    |    1 -
 drivers/scsi/ufs/ufshpb.c            |    4 +-
 drivers/target/target_core_iblock.c  |   12 +-
 drivers/target/target_core_pscsi.c   |    1 -
 fs/btrfs/check-integrity.c           |    1 -
 fs/btrfs/disk-io.c                   |   10 +-
 fs/btrfs/extent_io.c                 |    6 +-
 fs/buffer.c                          |   14 +-
 fs/crypto/bio.c                      |   13 +-
 fs/dax.c                             |    1 -
 fs/direct-io.c                       |    5 +-
 fs/erofs/zdata.c                     |    5 +-
 fs/ext4/page-io.c                    |    8 +-
 fs/ext4/readpage.c                   |    8 +-
 fs/f2fs/data.c                       |    7 +-
 fs/fs-writeback.c                    |    6 +-
 fs/gfs2/lops.c                       |    8 +-
 fs/gfs2/meta_io.c                    |    4 +-
 fs/gfs2/ops_fstype.c                 |    4 +-
 fs/gfs2/sys.c                        |    2 +-
 fs/hfs/mdb.c                         |    2 +-
 fs/hfsplus/wrapper.c                 |    5 +-
 fs/iomap/buffered-io.c               |   26 +-
 fs/iomap/direct-io.c                 |    8 +-
 fs/jfs/jfs_logmgr.c                  |   11 +-
 fs/jfs/jfs_metapage.c                |    9 +-
 fs/ksmbd/vfs.c                       |    1 -
 fs/mpage.c                           |   34 +-
 fs/nfs/blocklayout/blocklayout.c     |   26 +-
 fs/nfs/blocklayout/rpc_pipefs.c      |    1 -
 fs/nfsd/blocklayout.c                |    1 -
 fs/nilfs2/segbuf.c                   |   31 +-
 fs/ntfs3/fsntfs.c                    |   36 +-
 fs/ocfs2/cluster/heartbeat.c         |    4 +-
 fs/squashfs/block.c                  |   11 +-
 fs/xfs/xfs_bio_io.c                  |   14 +-
 fs/xfs/xfs_buf.c                     |    4 +-
 fs/xfs/xfs_log.c                     |   14 +-
 fs/zonefs/super.c                    |    9 +-
 include/linux/bio.h                  |   38 +-
 include/linux/blk-cgroup.h           |  461 +-------------
 include/linux/blk-mq.h               |    6 +-
 include/linux/blk_types.h            |   10 +-
 include/linux/blkdev.h               |  296 ++++++++-
 include/linux/genhd.h                |  291 ---------
 include/linux/part_stat.h            |    2 +-
 include/linux/sbitmap.h              |   51 +-
 include/scsi/scsi_cmnd.h             |    9 -
 include/scsi/scsi_driver.h           |    9 +-
 include/trace/events/block.h         |   49 +-
 init/do_mounts.c                     |    1 -
 kernel/exit.c                        |    2 +-
 kernel/power/hibernate.c             |    1 -
 kernel/power/swap.c                  |    6 +-
 kernel/sched/core.c                  |    7 +-
 lib/sbitmap.c                        |   40 +-
 mm/page_io.c                         |   10 +-
 security/integrity/ima/ima_policy.c  |    1 -
 196 files changed, 2412 insertions(+), 3998 deletions(-)
 delete mode 100644 Documentation/block/biodoc.rst
 create mode 100644 block/blk-cgroup.h
 create mode 100644 block/blk-crypto-sysfs.c
 delete mode 100644 include/linux/genhd.h

-- 
Jens Axboe


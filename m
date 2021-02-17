Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F5AC433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 22:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0130360241
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 22:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhBQWs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Feb 2021 17:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhBQWqO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Feb 2021 17:46:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5BC061786
        for <linux-block@vger.kernel.org>; Wed, 17 Feb 2021 14:45:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gx20so193595pjb.1
        for <linux-block@vger.kernel.org>; Wed, 17 Feb 2021 14:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vlVEDTH3/wM9kBKsQf6lkQyk5KKYdlPoLlNZjXWAq10=;
        b=ifYvjL7E/qB1XQUsBki+Vx1MqEiPN6L96kyZ1WCQaYMRL7Cbp6oWHOPR2ko069MHtT
         2LeeLrJqcgFWtyQ1vmjI6zcUe7s1aMOzZ2vhELxSulYWf7dzNGZhykWi0+rICsJQT/m2
         8XohgkMMeTWOmWXqskZYWZ09FnNa55ch0slEg805xCIHFvrZpSP0XnbaAe1TqbdKPu6N
         p4BQ6dkWiwMU4dDRodkny56b/0c1OXXXVnOCalDGAb1ZoY1oi2rhjpi+ZWoj1Yt37MtX
         yet53RP9fxo0rtagsLBd546Rxdy7A1kxo/NDOhhqrJ6yqXO7MxxAtbLCzX951MKZuagQ
         1VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vlVEDTH3/wM9kBKsQf6lkQyk5KKYdlPoLlNZjXWAq10=;
        b=Xlqrsb6NHKwUdJBlvRLA2cZHHI/FCyA6UCX4wnoY5bneIRpD97fSU6qU7+jzcsnJQR
         l+SMitZMH0qBAeeqjhim1UOguv04M4PZp7KvuTONIgeESwZGds24qS3zyecdzJVwoidH
         quKYS2U13qiy0fMDJaegPDHTcpzH7MXgRzhBLtBKvnCPOaxrVjyE5mQVWZxXVvauRqks
         AHAGEUAsbcz6+RuPpnG7vCeNtL0LSzldpJk5S5jPexUt8Rjz0EQRj9Tx8dDIh0uPux5r
         gtHOiO9jcbVSI6H4q6EJ6gRpQg42K1hXR5enzRGEUXge2f5giyUoEbGMBtOWjAIuODcq
         rMiA==
X-Gm-Message-State: AOAM530IsjghpuUwM5C5Tprob9qILWIiQod/WDv+t7pC59Z2X39llSyI
        QtSAq+w1W1ugK97je1rbmMvUAeG0XhGcKA==
X-Google-Smtp-Source: ABdhPJwlay/qdwgQ27I395gMyUigPWr9qN3vabZevdPa8vsXofAilaSvXDHturcCGTyf2ym5eBNNew==
X-Received: by 2002:a17:90a:c083:: with SMTP id o3mr1028325pjs.30.1613601929067;
        Wed, 17 Feb 2021 14:45:29 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21e1::19db? ([2620:10d:c090:400::5:5c48])
        by smtp.gmail.com with ESMTPSA id w11sm3498129pge.28.2021.02.17.14.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 14:45:28 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Core block changes for 5.12-rc
Message-ID: <ff4cdd19-1930-bf79-c0fd-f022147095f7@kernel.dk>
Date:   Wed, 17 Feb 2021 15:45:27 -0700
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

Core block changes for the 5.12-rc merge window. Another nice round of
removing more code than what is added, mostly due to Christoph's
relentless pursuit of tech debt removal/cleanups. This pull request
contains:

- Two series of BFQ improvements (Paolo, Jan, Jia)

- Block iov_iter improvements (Pavel)

- bsg error path fix (Pan)

- blk-mq scheduler improvements (Jan)

- -EBUSY discard fix (Jan)

- bvec allocation improvements (Ming, Christoph)

- bio allocation and init improvements (Christoph)

- Store bdev pointer in bio instead of gendisk + partno (Christoph)

- Block trace point cleanups (Christoph)

- hard read-only vs read-only split (Christoph)

- Block based swap cleanups (Christoph)

- Zoned write granularity support (Damien)

- Various fixes/tweaks (Chunguang, Guoqing, Lei, Lukas, Huhai)

Two known merge issues with the btrfs tree:

https://lore.kernel.org/lkml/20210202135714.6470f476@canb.auug.org.au/
https://lore.kernel.org/lkml/20210202134559.175ae62f@canb.auug.org.au/

Please pull!


The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.12/block-2021-02-17

for you to fetch changes up to f885056a48ccf4ad4332def91e973f3993fa8695:

  mm: simplify swapdev_block (2021-02-10 08:23:04 -0700)

----------------------------------------------------------------
for-5.12/block-2021-02-17

----------------------------------------------------------------
Baolin Wang (1):
      blk-cgroup: Remove obsolete macro

Chaitanya Kulkarni (1):
      nvme-core: check bdev value for NULL

Christoph Hellwig (53):
      dm: use bdev_read_only to check if a device is read-only
      block: remove the NULL bdev check in bdev_read_only
      block: add a hard-readonly flag to struct gendisk
      block: propagate BLKROSET on the whole device to all partitions
      rbd: remove the ->set_read_only method
      nvme: allow revalidate to set a namespace read-only
      brd: remove the end of device check in brd_do_bvec
      dcssblk: remove the end of device check in dcssblk_submit_bio
      block: store a block_device pointer in struct bio
      block: simplify submit_bio_checks a bit
      block: do not reassig ->bi_bdev when partition remapping
      block: use ->bi_bdev for bio based I/O accounting
      blk-mq: use ->bi_bdev for I/O accounting
      block: add a disk_uevent helper
      block: remove DISK_PITER_REVERSE
      block: use an xarray for disk->part_tbl
      target/file: allocate the bvec array as part of struct target_core_file_cmd
      block: skip bio_check_eod for partition-remapped bios
      nvme: use bio_set_dev to assign ->bi_bdev
      bcache: use bio_set_dev to assign ->bi_bdev
      block: inherit BIO_REMAPPED when cloning bios
      block: unexport truncate_bdev_range
      zonefs: use bio_alloc in zonefs_file_dio_append
      btrfs: use bio_kmalloc in __alloc_device
      blk-crypto: use bio_kmalloc in blk_crypto_clone_bio
      block: split bio_kmalloc from bio_alloc_bioset
      block: use an on-stack bio in blkdev_issue_flush
      dm-clone: use blkdev_issue_flush in commit_metadata
      f2fs: use blkdev_issue_flush in __submit_flush_wait
      f2fs: remove FAULT_ALLOC_BIO
      drbd: remove bio_alloc_drbd
      drbd: remove drbd_req_make_private_bio
      md: remove bio_alloc_mddev
      md: simplify sync_page_io
      md: remove md_bio_alloc_sync
      md/raid6: refactor raid5_read_one_chunk
      nfs/blocklayout: remove cruft in bl_alloc_init_bio
      nilfs2: remove cruft in nilfs_alloc_seg_bio
      mm: remove get_swap_bio
      md: check for NULL ->meta_bdev before calling bdev_read_only
      md: use rdev_read_only in restart_array
      block: reuse BIO_INLINE_VECS for integrity bvecs
      block: move struct biovec_slab to bio.c
      block: factor out a bvec_alloc_gfp helper
      block: streamline bvec_alloc
      block: remove the 1 and 4 vec bvec_slabs entries
      block: turn the nr_iovecs argument to bio_alloc* into an unsigned short
      block: remove a layer of indentation in bio_iov_iter_get_pages
      block: set BIO_NO_PAGE_REF in bio_iov_bvec_set
      block: mark the bio as cloned in bio_iov_bvec_set
      md/raid10: remove dead code in reshape_request
      block: use bi_max_vecs to find the bvec pool
      mm: simplify swapdev_block

Chunguang Xu (1):
      blkcg: delete redundant get/put operations for queue

Damien Le Moal (8):
      block: document zone_append_max_bytes attribute
      nvme: cleanup zone information initialization
      nullb: use blk_queue_set_zoned() to setup zoned devices
      block: use blk_queue_set_zoned in add_partition()
      block: introduce zone_write_granularity limit
      zonefs: use zone write granularity as block size
      block: introduce blk_queue_clear_zone_settings()
      sd_zbc: clear zone resources for non-zoned case

Guoqing Jiang (2):
      block: remove unnecessary argument from blk_execute_rq_nowait
      block: remove unnecessary argument from blk_execute_rq

Jan Kara (6):
      Revert "blk-mq, elevator: Count requests per hctx to improve performance"
      blk-mq: Improve performance of non-mq IO schedulers with multiple HW queues
      bdev: Do not return EBUSY if bdev discard races with write
      bfq: Avoid false bfq queue merging
      bfq: Use 'ttime' local variable
      bfq: Use only idle IO periods for think time calculations

Jens Axboe (2):
      bfq: bfq_check_waker() should be static
      mm: only make map_swap_entry available for CONFIG_HIBERNATION

Jia Cheng Hu (1):
      block, bfq: set next_rq to waker_bfqq->next_rq in waker injection

Lei Chen (1):
      blk: wbt: remove unused parameter from wbt_should_throttle

Lukas Bulwahn (2):
      block: remove typo in kernel-doc of set_disk_ro()
      block: drop removed argument from kernel-doc of blk_execute_rq()

Ming Lei (7):
      block: manage bio slab cache by xarray
      block: don't pass BIOSET_NEED_BVECS for q->bio_split
      block: don't allocate inline bvecs if this bioset needn't bvecs
      block: set .bi_max_vecs as actual allocated vector number
      block: move three bvec helpers declaration into private helper
      bcache: don't pass BIOSET_NEED_BVECS for the 'bio_set' embedded in 'cache_set'
      block: fix memory leak of bvec

Pan Bian (1):
      bsg: free the request before return error code

Paolo Valente (11):
      block, bfq: use half slice_idle as a threshold to check short ttime
      block, bfq: increase time window for waker detection
      block, bfq: do not raise non-default weights
      block, bfq: avoid spurious switches to soft_rt of interactive queues
      block, bfq: do not expire a queue when it is the only busy one
      block, bfq: replace mechanism for evaluating I/O intensity
      block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
      block, bfq: fix switch back from soft-rt weitgh-raising
      block, bfq: save also weight-raised service on queue merging
      block, bfq: save also injection state on queue merging
      block, bfq: make waker-queue detection more robust

Pavel Begunkov (6):
      splice: don't generate zero-len segement bvecs
      bvec/iter: disallow zero-length segment bvecs
      block/psi: remove PSI annotations from direct IO
      iov_iter: optimise bvec iov_iter_advance()
      bio: add a helper calculating nr segments to alloc
      bio: don't copy bvec for direct IO

huhai (1):
      bfq: don't duplicate code for different paths

 Documentation/block/biovecs.rst       |   2 +
 Documentation/block/queue-sysfs.rst   |  13 +
 Documentation/filesystems/f2fs.rst    |   1 -
 Documentation/filesystems/porting.rst |  16 +
 arch/m68k/emu/nfblock.c               |   2 +-
 arch/xtensa/platforms/iss/simdisk.c   |   2 +-
 block/bfq-iosched.c                   | 445 ++++++++++++++++----------
 block/bfq-iosched.h                   |  29 +-
 block/bfq-wf2q.c                      |   3 -
 block/bio-integrity.c                 |  35 +--
 block/bio.c                           | 569 +++++++++++++++-------------------
 block/blk-cgroup.c                    |  22 +-
 block/blk-core.c                      |  99 +++---
 block/blk-crypto-fallback.c           |   6 +-
 block/blk-crypto.c                    |   2 +-
 block/blk-exec.c                      |  14 +-
 block/blk-flush.c                     |  17 +-
 block/blk-merge.c                     |  17 +-
 block/blk-mq.c                        |  69 ++++-
 block/blk-settings.c                  |  41 ++-
 block/blk-sysfs.c                     |   8 +
 block/blk-throttle.c                  |   2 +-
 block/blk-wbt.c                       |   4 +-
 block/blk-zoned.c                     |  17 +
 block/blk.h                           |  12 +-
 block/bounce.c                        |   4 +-
 block/bsg.c                           |   6 +-
 block/genhd.c                         | 306 +++---------------
 block/kyber-iosched.c                 |   1 +
 block/mq-deadline.c                   |   6 -
 block/partitions/core.c               |  36 +--
 block/scsi_ioctl.c                    |   6 +-
 drivers/block/brd.c                   |   8 +-
 drivers/block/drbd/drbd_actlog.c      |   2 +-
 drivers/block/drbd/drbd_bitmap.c      |   2 +-
 drivers/block/drbd/drbd_int.h         |   6 +-
 drivers/block/drbd/drbd_main.c        |  13 -
 drivers/block/drbd/drbd_req.c         |   7 +-
 drivers/block/drbd/drbd_req.h         |  12 -
 drivers/block/drbd/drbd_worker.c      |   5 +-
 drivers/block/mtip32xx/mtip32xx.c     |   2 +-
 drivers/block/null_blk/main.c         |   2 +-
 drivers/block/null_blk/zoned.c        |   8 +-
 drivers/block/paride/pd.c             |   2 +-
 drivers/block/pktcdvd.c               |   6 +-
 drivers/block/ps3vram.c               |   2 +-
 drivers/block/rbd.c                   |  19 --
 drivers/block/rsxx/dev.c              |   2 +-
 drivers/block/sx8.c                   |   4 +-
 drivers/block/umem.c                  |   2 +-
 drivers/block/virtio_blk.c            |   2 +-
 drivers/block/zram/zram_drv.c         |   2 +-
 drivers/cdrom/cdrom.c                 |   2 +-
 drivers/ide/ide-atapi.c               |   2 +-
 drivers/ide/ide-cd.c                  |   2 +-
 drivers/ide/ide-cd_ioctl.c            |   2 +-
 drivers/ide/ide-devsets.c             |   2 +-
 drivers/ide/ide-disk.c                |   2 +-
 drivers/ide/ide-ioctls.c              |   4 +-
 drivers/ide/ide-park.c                |   2 +-
 drivers/ide/ide-pm.c                  |   4 +-
 drivers/ide/ide-tape.c                |   2 +-
 drivers/ide/ide-taskfile.c            |   2 +-
 drivers/lightnvm/pblk-init.c          |   2 +-
 drivers/md/bcache/debug.c             |   2 +-
 drivers/md/bcache/request.c           |  39 ++-
 drivers/md/bcache/super.c             |   2 +-
 drivers/md/dm-bio-record.h            |   9 +-
 drivers/md/dm-cache-metadata.c        |   2 +-
 drivers/md/dm-clone-target.c          |  14 +-
 drivers/md/dm-raid1.c                 |  10 +-
 drivers/md/dm-thin-metadata.c         |   2 +-
 drivers/md/dm-zoned-metadata.c        |   6 +-
 drivers/md/dm.c                       |  14 +-
 drivers/md/md-linear.c                |   2 +-
 drivers/md/md.c                       |  73 ++---
 drivers/md/md.h                       |   8 +-
 drivers/md/raid1.c                    |   8 +-
 drivers/md/raid10.c                   |  18 +-
 drivers/md/raid5-ppl.c                |   2 +-
 drivers/md/raid5.c                    | 110 +++----
 drivers/mmc/core/block.c              |  10 +-
 drivers/nvdimm/blk.c                  |   4 +-
 drivers/nvdimm/btt.c                  |   4 +-
 drivers/nvdimm/pmem.c                 |   4 +-
 drivers/nvme/host/core.c              |  31 +-
 drivers/nvme/host/lightnvm.c          |   7 +-
 drivers/nvme/host/multipath.c         |   6 +-
 drivers/nvme/host/pci.c               |   4 +-
 drivers/nvme/host/rdma.c              |   2 +-
 drivers/nvme/host/zns.c               |  11 +-
 drivers/nvme/target/io-cmd-bdev.c     |   2 +-
 drivers/nvme/target/passthru.c        |   2 +-
 drivers/s390/block/dasd.c             |  26 +-
 drivers/s390/block/dcssblk.c          |   6 +-
 drivers/s390/block/xpram.c            |   2 +-
 drivers/scsi/scsi_error.c             |   2 +-
 drivers/scsi/scsi_lib.c               |   2 +-
 drivers/scsi/sd_zbc.c                 |  43 ++-
 drivers/scsi/sg.c                     |   3 +-
 drivers/scsi/st.c                     |   2 +-
 drivers/target/target_core_file.c     |  20 +-
 drivers/target/target_core_pscsi.c    |   3 +-
 fs/block_dev.c                        |  20 +-
 fs/btrfs/check-integrity.c            |  10 +-
 fs/btrfs/raid56.c                     |   7 +-
 fs/btrfs/scrub.c                      |   2 +-
 fs/btrfs/volumes.c                    |   2 +-
 fs/direct-io.c                        |   4 +-
 fs/exfat/file.c                       |   2 +-
 fs/ext4/fast_commit.c                 |   4 +-
 fs/ext4/fsync.c                       |   2 +-
 fs/ext4/ialloc.c                      |   2 +-
 fs/ext4/super.c                       |   2 +-
 fs/f2fs/data.c                        |  40 +--
 fs/f2fs/f2fs.h                        |   2 -
 fs/f2fs/segment.c                     |  12 +-
 fs/f2fs/super.c                       |   1 -
 fs/fat/file.c                         |   2 +-
 fs/hfsplus/inode.c                    |   2 +-
 fs/hfsplus/super.c                    |   2 +-
 fs/iomap/direct-io.c                  |   9 +-
 fs/jbd2/checkpoint.c                  |   2 +-
 fs/jbd2/commit.c                      |   4 +-
 fs/jbd2/recovery.c                    |   2 +-
 fs/libfs.c                            |   2 +-
 fs/nfs/blocklayout/blocklayout.c      |   5 -
 fs/nfsd/blocklayout.c                 |   2 +-
 fs/nilfs2/segbuf.c                    |   4 -
 fs/nilfs2/the_nilfs.h                 |   2 +-
 fs/ocfs2/file.c                       |   2 +-
 fs/reiserfs/file.c                    |   2 +-
 fs/splice.c                           |   9 +-
 fs/super.c                            |   3 +-
 fs/xfs/xfs_super.c                    |   2 +-
 fs/zonefs/super.c                     |  13 +-
 include/linux/bio.h                   |  55 ++--
 include/linux/blk-mq.h                |   8 +-
 include/linux/blk_types.h             |  33 +-
 include/linux/blkdev.h                |  53 ++--
 include/linux/elevator.h              |   2 +
 include/linux/genhd.h                 |  27 +-
 include/linux/swap.h                  |   1 -
 kernel/trace/blktrace.c               |  16 +-
 lib/iov_iter.c                        |  21 +-
 mm/page_io.c                          |  47 +--
 mm/swapfile.c                         |  36 +--
 147 files changed, 1340 insertions(+), 1605 deletions(-)

-- 
Jens Axboe


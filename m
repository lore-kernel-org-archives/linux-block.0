Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C217AC433EF
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17A560F46
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhJaToN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhJaToN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Oct 2021 15:44:13 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CA3C061570
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:41:41 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id s3so16488668ild.0
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Bqb79K/DwcCdv0MLWL5yqGCM62f7FxUJYp6icD8BEJM=;
        b=8GcKlpFP2Dr1WaatyOODqiWW5KebCXAWyhOo6MKDTcM0bwOWOxQJYEVE2yhSlXweoL
         2kjAJRHaoJbQ2MUMR7fjs4CY9oGoF1TO0rmQscHadtCGR64wl3cySmwvTPIOdEboG8qw
         ZU73EK5M5LK7Q1wrOdKjHoW50PFk9mcbi8m+GVET9g7phsQpG6T0BzVBtvy9+ZBtQG38
         pPYvyvuhOLLxOhACTK83wjD2owszrhO9A5CbdIN4sYkgqTmxestrSUo+IXMHY0kPjzwL
         UUPsmIaNdDzR2KuNUCZSVjP2zMWVBN6G9FxQqFt8YoFciWJ1vAhoXjX7vNIYP44sXjkh
         sGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Bqb79K/DwcCdv0MLWL5yqGCM62f7FxUJYp6icD8BEJM=;
        b=MQRdksXf7LqyOVqCqW4W6N0MzArbG03QNiLq8GTBOzMThX1cjw+srJrigiIXxuDCXK
         dkN8nhWCaXli4I8waF3qQw05A3Jyq1MZZcvYbYDusBQqyiqTyJ9Yc1Vw82XT6XRjVOBO
         PyQrDaPtIPlud4hHiHYzmBEWSEC6vQx7ilT2APtXGtC6XFkeTuNyVRxLq2XiGkk+1n94
         1JyywkXmHlppsAOzEL4tz1NuspFKw2N2eAuMkFrgjm+EB2W4pMxFSEWysUFQ2smcMXNY
         gSaUG+JvHRUrvD/kIvpr4jGjw5ICJlyThIivZg/K3uRC87nAoaZIu5l+z8F5jFT0W0bJ
         c5vg==
X-Gm-Message-State: AOAM533rLdfutCPFugZee+yJOhQX26D9xuSG5wvCsxUod+N4ExdpfGsl
        Rwe+ICSvs02NmahJtfRl1/A6e1kugF+nnA==
X-Google-Smtp-Source: ABdhPJzse6cAIk23HLAw0+Bn0wncVzu8BLzYjYGPQffrbfnYJejtq3/bOY6EgnNeu7p3NkfHdPtjtA==
X-Received: by 2002:a05:6e02:1c4a:: with SMTP id d10mr2635485ilg.157.1635709300275;
        Sun, 31 Oct 2021 12:41:40 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g10sm6911206ila.34.2021.10.31.12.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:41:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <f32307c6-5b97-00f6-3738-0732d3de5e62@kernel.dk>
Date:   Sun, 31 Oct 2021 13:41:39 -0600
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

Here are the block updates for the 5.16-rc1 merge window:

- mq-deadline accounting improvements (Bart)

- blk-wbt timer fix (Andrea)

- Untangle the block layer includes (Christoph)

- Rework the poll support to be bio based, which will enable adding
  support for polling for bio based drivers (Christoph)

- Block layer core support for multi-actuator drives (Damien)

- blk-crypto improvements (Eric)

- Batched tag allocation support (me)

- Request completion batching support (me)

- Plugging improvements (me)

- Shared tag set improvements (John)

- Concurrent queue quiesce support (Ming)

- Cache bdev in ->private_data for block devices (Pavel)

- bdev dio improvements (Pavel)

- Block device invalidation and block size improvements (Xie)

- Various cleanups, fixes, and improvements (Christoph, Jackie, Masahira,
  Tejun, Yu, Pavel, Zheng, me)

Please pull!


The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/block-2021-10-29

for you to fetch changes up to 9b84c629c90374498ab5825dede74a06ea1c775b:

  blk-mq-debugfs: Show active requests per queue for shared tags (2021-10-29 06:53:34 -0600)

----------------------------------------------------------------
for-5.16/block-2021-10-29

----------------------------------------------------------------
Andrea Righi (1):
      blk-wbt: prevent NULL pointer dereference in wb_timer_fn

Bart Van Assche (4):
      block/mq-deadline: Improve request accounting further
      block/mq-deadline: Add an invariant check
      block/mq-deadline: Stop using per-CPU counters
      block/mq-deadline: Prioritize high-priority requests

Christoph Hellwig (51):
      mm: don't include <linux/blk-cgroup.h> in <linux/writeback.h>
      mm: don't include <linux/blk-cgroup.h> in <linux/backing-dev.h>
      mm: don't include <linux/blkdev.h> in <linux/backing-dev.h>
      mm: remove spurious blkdev.h includes
      arch: remove spurious blkdev.h includes
      kernel: remove spurious blkdev.h includes
      sched: move the <linux/blkdev.h> include out of kernel/sched/sched.h
      block: remove the unused rq_end_sector macro
      block: remove the unused blk_queue_state enum
      block: remove the cmd_size field from struct request_queue
      block: remove the struct blk_queue_ctx forward declaration
      block: move elevator.h to block/
      block: drop unused includes in <linux/blkdev.h>
      block: drop unused includes in <linux/genhd.h>
      block: move a few merge helpers out of <linux/blkdev.h>
      block: move integrity handling out of <linux/blkdev.h>
      block: move struct request to blk-mq.h
      block: print the current process in handle_bad_sector
      blk-mq: cleanup and rename __blk_mq_alloc_request
      blk-mq: cleanup blk_mq_submit_bio
      block: unexport blkdev_ioctl
      block: move the *blkdev_ioctl declarations out of blkdev.h
      block: merge block_ioctl into blkdev_ioctl
      block: remove BIO_BUG_ON
      block: don't include <linux/ioprio.h> in <linux/bio.h>
      block: move bio_mergeable out of bio.h
      block: fold bio_cur_bytes into blk_rq_cur_bytes
      block: move bio_full out of bio.h
      block: mark __bio_try_merge_page static
      block: move bio_get_{first,last}_bvec out of bio.h
      block: mark bio_truncate static
      direct-io: remove blk_poll support
      block: don't try to poll multi-bio I/Os in __blkdev_direct_IO
      iomap: don't try to poll multi-bio I/Os in __iomap_dio_rw
      io_uring: fix a layering violation in io_iopoll_req_issued
      blk-mq: factor out a blk_qc_to_hctx helper
      blk-mq: factor out a "classic" poll helper
      blk-mq: remove blk_qc_t_to_tag and blk_qc_t_is_internal
      blk-mq: remove blk_qc_t_valid
      block: replace the spin argument to blk_iopoll with a flags argument
      io_uring: don't sleep when polling for I/O
      block: rename REQ_HIPRI to REQ_POLLED
      block: use SLAB_TYPESAFE_BY_RCU for the bio slab
      block: switch polling to be bio based
      block: don't allow writing to the poll queue attribute
      nvme-multipath: enable polled I/O
      block: don't call blk_status_to_errno in blk_update_request
      blk-mq: don't handle non-flush requests in blk_insert_flush
      blk-mq: only flush requests from the plug in blk_mq_submit_bio
      blk-mq: move blk_mq_flush_plug_list to block/blk-mq.h
      block: cleanup the flush plug helpers

Damien Le Moal (1):
      block: Add independent access ranges support

Eric Biggers (4):
      blk-crypto-fallback: properly prefix function and struct names
      blk-crypto: rename keyslot-manager files to blk-crypto-profile
      blk-crypto: rename blk_keyslot_manager to blk_crypto_profile
      blk-crypto: update inline encryption documentation

Jackie Liu (1):
      fs: bdev: fix conflicting comment from lookup_bdev

Jens Axboe (42):
      block: move blk-throtl fast path inline
      block: inherit request start time from bio for BLK_CGROUP
      block: bump max plugged deferred size from 16 to 32
      block: pre-allocate requests if plug is started and is a batch
      block: don't dereference request after flush insertion
      sbitmap: add __sbitmap_queue_get_batch()
      block: improve batched tag allocation
      block: only check previous entry for plug merge attempt
      block: use flags instead of bit fields for blkdev_dio
      block: handle fast path of bio splitting inline
      block: don't bother iter advancing a fully done bio
      block: remove useless caller argument to print_req_error()
      block: move update request helpers into blk-mq.c
      block: improve layout of struct request
      block: only mark bio as tracked if it really is tracked
      block: store elevator state in request
      block: remove debugfs blk_mq_ctx dispatched/merged/completed attributes
      block: remove some blk_mq_hw_ctx debugfs entries
      block: provide helpers for rq_list manipulation
      block: add a struct io_comp_batch argument to fops->iopoll()
      sbitmap: add helper to clear a batch of tags
      block: add support for blk_mq_end_request_batch()
      nvme: add support for batched completion of polled IO
      io_uring: utilize the io batching infrastructure for more efficient polled IO
      nvme: wire up completion batching for the IRQ path
      block: fix too broad elevator check in blk_mq_free_request()
      block: move bdev_read_only() into the header
      block: return whether or not to unplug through boolean
      block: get rid of plug list sorting
      block: move blk_mq_tag_to_rq() inline
      block: align blkdev_dio inlined bio to a cacheline
      block: change plugging to use a singly linked list
      block: attempt direct issue of plug list
      block: inline fast path of driver tag allocation
      block: remove inaccurate requeue check
      sched: make task_struct->plug always defined
      sbitmap: silence data race warning
      block: add rq_flags to struct blk_mq_alloc_data
      block: pass in blk_mq_tags to blk_mq_rq_ctx_init()
      block: prefetch request to be initialized
      block: re-flow blk_mq_rq_ctx_init()
      block: improve readability of blk_mq_end_request_batch()

John Garry (17):
      blk-mq: Change rqs check in blk_mq_free_rqs()
      block: Rename BLKDEV_MAX_RQ -> BLKDEV_DEFAULT_RQ
      blk-mq: Relocate shared sbitmap resize in blk_mq_update_nr_requests()
      blk-mq: Invert check in blk_mq_update_nr_requests()
      blk-mq-sched: Rename blk_mq_sched_alloc_{tags -> map_and_rqs}()
      blk-mq-sched: Rename blk_mq_sched_free_{requests -> rqs}()
      blk-mq: Pass driver tags to blk_mq_clear_rq_mapping()
      blk-mq: Don't clear driver tags own mapping
      blk-mq: Add blk_mq_tag_update_sched_shared_sbitmap()
      blk-mq: Add blk_mq_alloc_map_and_rqs()
      blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()
      blk-mq: Use shared tags for shared sbitmap support
      blk-mq: Stop using pointers for blk_mq_tags bitmap tags
      blk-mq: Change shared sbitmap naming to shared tags
      blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
      blk-mq-sched: Don't reference queue tagset in blk_mq_sched_tags_teardown()
      blk-mq-debugfs: Show active requests per queue for shared tags

Masahiro Yamada (4):
      block: remove redundant =y from BLK_CGROUP dependency
      block: simplify Kconfig files
      block: move menu "Partition type" to block/partitions/Kconfig
      block: move CONFIG_BLOCK guard to top Makefile

Ming Lei (8):
      block: define 'struct bvec_iter' as packed
      nvme: add APIs for stopping/starting admin queue
      nvme: apply nvme API to quiesce/unquiesce admin queue
      nvme: prepare for pairing quiescing and unquiescing
      nvme: paring quiesce/unquiesce
      nvme: loop: clear NVME_CTRL_ADMIN_Q_STOPPED after admin queue is reallocated
      blk-mq: support concurrent queue quiesce/unquiesce
      blk-mq: don't issue request directly in case that current is to be blocked

Pavel Begunkov (30):
      block: inline hot paths of blk_account_io_*()
      blk-mq: inline hot part of __blk_mq_sched_restart
      blk-mq: optimise *end_request non-stat path
      block: cache bdev in struct file for raw bdev IO
      block: cache request queue in bdev
      block: use bdev_get_queue() in bdev.c
      block: use bdev_get_queue() in bio.c
      block: use bdev_get_queue() in blk-core.c
      block: convert the rest of block to bdev_get_queue
      block: skip elevator fields init for non-elv queue
      block: blk_mq_rq_ctx_init cache ctx/q/hctx
      block: cache rq_flags inside blk_mq_rq_ctx_init()
      block: turn macro helpers into inline functions
      block: convert leftovers to bdev_get_queue
      block: optimise req_bio_endio()
      block: don't bloat enter_queue with percpu_ref
      block: inline a part of bio_release_pages()
      block: optimise blk_flush_plug_list
      block: optimise boundary blkdev_read_iter's checks
      block: clean up blk_mq_submit_bio() merging
      block: convert fops.c magic constants to SHIFT_SECTOR
      percpu_ref: percpu_ref_tryget_live() version holding RCU
      block: kill extra rcu lock/unlock in queue enter
      block: fix req_bio_endio append error handling
      block: add single bio async direct IO helper
      block: refactor bio_iov_bvec_set()
      block: avoid extra iter advance with async iocb
      block: kill unused polling bits in __blkdev_direct_IO()
      block: kill DIO_MULTI_BIO
      block: add async version of bio_set_polled

Tejun Heo (1):
      blk-cgroup: blk_cgroup_bio_start() should use irq-safe operations on blkg->iostat_cpu

Xie Yongji (8):
      block: Add invalidate_disk() helper to invalidate the gendisk
      loop: Use invalidate_disk() helper to invalidate gendisk
      loop: Remove the unnecessary bdev checks and unused bdev variable
      nbd: Use invalidate_disk() helper on disconnect
      block: Add a helper to validate the block size
      nbd: Use blk_validate_block_size() to validate block size
      loop: Use blk_validate_block_size() to validate block size
      virtio-blk: Use blk_validate_block_size() to validate block size

Yu Kuai (1):
      blk-cgroup: synchronize blkg creation against policy deactivation

Zheng Liang (1):
      block, bfq: fix UAF problem in bfqg_stats_init()

 Documentation/block/inline-encryption.rst  |  451 ++++++------
 Makefile                                   |    3 +-
 arch/m68k/emu/nfblock.c                    |    3 +-
 arch/mips/rb532/prom.c                     |    1 -
 arch/mips/sibyte/common/cfe.c              |    1 -
 arch/mips/sibyte/swarm/setup.c             |    1 -
 arch/openrisc/mm/init.c                    |    1 -
 arch/powerpc/platforms/cell/spufs/inode.c  |    1 +
 arch/um/drivers/ubd_kern.c                 |    1 +
 arch/xtensa/platforms/iss/simdisk.c        |    3 +-
 block/Kconfig                              |   28 +-
 block/Kconfig.iosched                      |    4 -
 block/Makefile                             |    6 +-
 block/bdev.c                               |   18 +-
 block/bfq-cgroup.c                         |   14 +-
 block/bfq-iosched.c                        |    6 +-
 block/bio-integrity.c                      |    4 +-
 block/bio.c                                |  171 +++--
 block/blk-cgroup.c                         |   32 +-
 block/blk-core.c                           |  404 +++++------
 block/blk-crypto-fallback.c                |  119 ++--
 block/blk-crypto-internal.h                |    2 +-
 block/blk-crypto-profile.c                 |  565 +++++++++++++++
 block/blk-crypto.c                         |   29 +-
 block/blk-exec.c                           |   10 +-
 block/blk-flush.c                          |   12 +-
 block/blk-ia-ranges.c                      |  348 ++++++++++
 block/blk-integrity.c                      |    6 +-
 block/blk-iocost.c                         |   12 +-
 block/blk-iolatency.c                      |    1 +
 block/blk-merge.c                          |  127 ++--
 block/blk-mq-debugfs.c                     |  133 +---
 block/blk-mq-sched.c                       |  129 ++--
 block/blk-mq-sched.h                       |   49 +-
 block/blk-mq-tag.c                         |  163 ++---
 block/blk-mq-tag.h                         |   38 +-
 block/blk-mq.c                             | 1034 ++++++++++++++++++----------
 block/blk-mq.h                             |   79 ++-
 block/blk-rq-qos.h                         |    5 +-
 block/blk-sysfs.c                          |   50 +-
 block/blk-throttle.c                       |  163 +----
 block/blk-throttle.h                       |  182 +++++
 block/blk-wbt.c                            |    3 +
 block/blk.h                                |  131 +++-
 block/bounce.c                             |    1 +
 block/elevator.c                           |    4 +-
 {include/linux => block}/elevator.h        |   21 +-
 block/fops.c                               |  282 ++++----
 block/genhd.c                              |   35 +-
 block/holder.c                             |    1 +
 block/ioctl.c                              |   19 +-
 block/keyslot-manager.c                    |  578 ----------------
 block/kyber-iosched.c                      |    6 +-
 block/mq-deadline.c                        |  224 +++---
 block/partitions/Kconfig                   |    4 +
 block/partitions/core.c                    |    5 +-
 block/t10-pi.c                             |    2 +-
 drivers/block/amiflop.c                    |    2 +-
 drivers/block/ataflop.c                    |    1 +
 drivers/block/brd.c                        |   12 +-
 drivers/block/drbd/drbd_int.h              |    2 +-
 drivers/block/drbd/drbd_req.c              |    3 +-
 drivers/block/floppy.c                     |    1 +
 drivers/block/loop.c                       |   32 +-
 drivers/block/n64cart.c                    |   12 +-
 drivers/block/nbd.c                        |   15 +-
 drivers/block/null_blk/main.c              |    3 +-
 drivers/block/pktcdvd.c                    |    7 +-
 drivers/block/ps3vram.c                    |    6 +-
 drivers/block/rbd.c                        |    2 +-
 drivers/block/rnbd/rnbd-clt.c              |    2 +-
 drivers/block/rnbd/rnbd-proto.h            |    2 +-
 drivers/block/rsxx/dev.c                   |    7 +-
 drivers/block/swim.c                       |    1 +
 drivers/block/virtio_blk.c                 |   12 +-
 drivers/block/xen-blkfront.c               |    1 +
 drivers/block/zram/zram_drv.c              |   10 +-
 drivers/gpu/drm/i915/i915_utils.h          |    1 +
 drivers/md/bcache/request.c                |   13 +-
 drivers/md/bcache/request.h                |    4 +-
 drivers/md/dm-bio-record.h                 |    1 +
 drivers/md/dm-core.h                       |    4 +-
 drivers/md/dm-crypt.c                      |    1 +
 drivers/md/dm-ima.c                        |    1 +
 drivers/md/dm-ps-historical-service-time.c |    1 +
 drivers/md/dm-rq.c                         |    1 -
 drivers/md/dm-table.c                      |  169 +++--
 drivers/md/dm-verity-target.c              |    1 +
 drivers/md/dm.c                            |   38 +-
 drivers/md/md.c                            |   12 +-
 drivers/mmc/core/crypto.c                  |   11 +-
 drivers/mmc/core/sd.c                      |    1 +
 drivers/mmc/host/cqhci-crypto.c            |   33 +-
 drivers/mtd/mtdsuper.c                     |    1 +
 drivers/nvdimm/blk.c                       |    5 +-
 drivers/nvdimm/btt.c                       |    5 +-
 drivers/nvdimm/core.c                      |    1 +
 drivers/nvdimm/pmem.c                      |    3 +-
 drivers/nvme/host/core.c                   |   90 ++-
 drivers/nvme/host/fc.c                     |    8 +-
 drivers/nvme/host/multipath.c              |   22 +-
 drivers/nvme/host/nvme.h                   |   18 +
 drivers/nvme/host/pci.c                    |   49 +-
 drivers/nvme/host/rdma.c                   |   17 +-
 drivers/nvme/host/tcp.c                    |   18 +-
 drivers/nvme/target/io-cmd-bdev.c          |    1 +
 drivers/nvme/target/loop.c                 |    6 +-
 drivers/nvme/target/rdma.c                 |    1 +
 drivers/s390/block/dasd_genhd.c            |    1 +
 drivers/s390/block/dcssblk.c               |    7 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c     |    1 +
 drivers/scsi/lpfc/lpfc.h                   |    1 +
 drivers/scsi/scsi_debug.c                  |   10 +-
 drivers/scsi/scsi_lib.c                    |    3 +-
 drivers/scsi/sd.c                          |    1 +
 drivers/scsi/sd_dif.c                      |    2 +-
 drivers/scsi/sg.c                          |    1 +
 drivers/scsi/sr.c                          |    1 +
 drivers/scsi/st.c                          |    1 +
 drivers/scsi/ufs/ufshcd-crypto.c           |   32 +-
 drivers/scsi/ufs/ufshcd-crypto.h           |    9 +-
 drivers/scsi/ufs/ufshcd.c                  |    2 +-
 drivers/scsi/ufs/ufshcd.h                  |    6 +-
 drivers/scsi/virtio_scsi.c                 |    1 +
 drivers/target/target_core_file.c          |    1 +
 drivers/target/target_core_iblock.c        |    2 +
 fs/btrfs/compression.c                     |    1 +
 fs/btrfs/ctree.c                           |    1 +
 fs/btrfs/inode.c                           |    9 +-
 fs/direct-io.c                             |   14 +-
 fs/ext4/file.c                             |    2 +-
 fs/f2fs/compress.c                         |    1 +
 fs/fs-writeback.c                          |    5 +-
 fs/gfs2/file.c                             |    4 +-
 fs/io_uring.c                              |   24 +-
 fs/iomap/direct-io.c                       |   57 +-
 fs/ntfs/file.c                             |    1 +
 fs/ntfs3/file.c                            |    1 +
 fs/orangefs/inode.c                        |    2 +-
 fs/orangefs/super.c                        |    1 +
 fs/quota/quota.c                           |    1 +
 fs/ramfs/inode.c                           |    1 +
 fs/xfs/xfs_file.c                          |    2 +-
 fs/zonefs/super.c                          |    2 +-
 include/linux/backing-dev.h                |   19 +-
 include/linux/bio.h                        |  147 ++--
 include/linux/blk-crypto-profile.h         |  166 +++++
 include/linux/blk-integrity.h              |  183 +++++
 include/linux/blk-mq.h                     |  581 +++++++++++++++-
 include/linux/blk_types.h                  |   37 +-
 include/linux/blkdev.h                     |  909 ++++--------------------
 include/linux/blktrace_api.h               |    2 +-
 include/linux/bvec.h                       |    2 +-
 include/linux/device-mapper.h              |    4 +-
 include/linux/fs.h                         |   10 +-
 include/linux/genhd.h                      |   25 +-
 include/linux/iomap.h                      |    5 +-
 include/linux/keyslot-manager.h            |  120 ----
 include/linux/mmc/host.h                   |    4 +-
 include/linux/part_stat.h                  |    1 +
 include/linux/percpu-refcount.h            |   33 +-
 include/linux/sbitmap.h                    |   24 +
 include/linux/sched.h                      |    2 -
 include/linux/t10-pi.h                     |    2 +-
 include/linux/writeback.h                  |   14 +-
 include/scsi/scsi_device.h                 |    2 +-
 include/trace/events/block.h               |    6 +-
 init/main.c                                |    1 -
 kernel/acct.c                              |    1 -
 kernel/exit.c                              |    1 -
 kernel/fork.c                              |    1 -
 kernel/sched/core.c                        |    7 +-
 kernel/sched/sched.h                       |    1 -
 kernel/trace/blktrace.c                    |    7 +-
 lib/random32.c                             |    1 +
 lib/sbitmap.c                              |   95 ++-
 mm/backing-dev.c                           |   19 +-
 mm/filemap.c                               |    1 -
 mm/highmem.c                               |    1 -
 mm/mempool.c                               |    1 -
 mm/nommu.c                                 |    1 -
 mm/page_io.c                               |   10 +-
 mm/readahead.c                             |    1 -
 mm/shmem.c                                 |    1 -
 mm/swapfile.c                              |    2 +-
 185 files changed, 4989 insertions(+), 4067 deletions(-)
 create mode 100644 block/blk-crypto-profile.c
 create mode 100644 block/blk-ia-ranges.c
 create mode 100644 block/blk-throttle.h
 rename {include/linux => block}/elevator.h (92%)
 delete mode 100644 block/keyslot-manager.c
 create mode 100644 include/linux/blk-crypto-profile.h
 create mode 100644 include/linux/blk-integrity.h
 delete mode 100644 include/linux/keyslot-manager.h

-- 
Jens Axboe


Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31F3C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927632073B
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 17:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tS+vKwLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgFARlZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFARlY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 13:41:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0DAC05BD43
        for <linux-block@vger.kernel.org>; Mon,  1 Jun 2020 10:41:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i12so133423pju.3
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2020 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zGB/kqIxOC4WRKkW7sOsHON0WItwknqOPou5GLqEOYw=;
        b=tS+vKwLcFzxicSEJaC+kaivTS4NJoa904fYq1EcWOWRGiLf8kj/LQnfTWWKVNy7Zbt
         7hDJljIfksWQnkclTx6mpxd9xQL9DzS3TD7McACz3FTKMYcjTJ4rQpohT0sNUb6tgW9T
         1eJE4G926uab7VWXOIVC6VxcG3uBKZM7cQED4FX6jVQrFH8HmGgLTCXeKKXdzXrfIl02
         D1djY7m/1sKk8vV1dV+zYcXSGBF1e2Tpp8Z8a9J9i+eCqp3IwCU0hwpP1SrUyfYm+eaH
         lETJsL1/IfiDigKNs1zPJjdhYnGOZwvT4PnTAlIPs3qeorckr55kkO6BPa1LkR5L/EoJ
         3T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zGB/kqIxOC4WRKkW7sOsHON0WItwknqOPou5GLqEOYw=;
        b=flwJJ0U37ThTyEQch+cEwi/f1SgflDOWw4cKX/AQhJCkTzLmxo97ZViUHOJ1Pc/Dtw
         mv3iMp+UOsKA8X0U1DFYImEizrC4PqIVvN3KFj1TpK8ToHr0zSRWkyB13IKkO6Xz0I8Z
         JYMqlHa4McygBX7OsvvKXrHgeP10CoAmw2brGVViYBfua7iRIoSL1QU/r/IPCZC0fTi4
         tzrBrywftJuRSBE854j2nMGyJTilJzfmP9DO8jnAtTUgrEqfvEsYJAEAVZuAekWUlC/8
         Rt5r+yu5SqNRz1BWU9Grl1xNyfF0yL7zGvLiYMXiffWvETotkwuc1S6Tesqnx6SRay5K
         shHg==
X-Gm-Message-State: AOAM531Tuh5zuQYzSDpGo2CQomCTBQd0cNgS46YoUSdszkyN5KPljCG7
        qZ2hxq6OD52xVcOnBrgqEnlZ8RtXP2hsuw==
X-Google-Smtp-Source: ABdhPJyKIVOKqEI1bVDc4uB+dpdzQZDcb6JP+k0SviIIiqo4LXH8rXDrIIkUpj1iN7DpQZC3IztWcA==
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr19501521pll.252.1591033282060;
        Mon, 01 Jun 2020 10:41:22 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 12sm51243pfj.149.2020.06.01.10.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 10:41:20 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Core block changes for 5.8-rc1
Message-ID: <88e3cc9b-efba-055f-880a-1b7ae8d1e6cb@kernel.dk>
Date:   Mon, 1 Jun 2020 11:41:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Core block changes that have been queued up for this release:

- Remove dead blk-throttle and blk-wbt code (Guoqing)

- Include pid in blktrace note traces (Jan)

- Don't spew I/O errors on wouldblock termination (me)

- Zone append addition (Johannes, Keith, Damien)

- IO accounting improvements (Konstantin, Christoph)

- blk-mq hardware map update improvements (Ming)

- Scheduler dispatch improvement (Salman)

- Inline block encryption support (Satya)

- Request map fixes and improvements (Weiping)

- blk-iocost tweaks (Tejun)

- Fix for timeout failing with error injection (Keith)

- Queue re-run fixes (Douglas)

- CPU hotplug improvements (Christoph)

- Queue entry/exit improvements (Christoph)

- Move DMA drain handling to the few drivers that use it (Christoph)

- Partition handling cleanups (Christoph)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.8/block-2020-06-01


----------------------------------------------------------------
Baolin Wang (1):
      block: Remove unused flush_queue_delayed in struct blk_flush_queue

Bart Van Assche (4):
      block: Fix type of first compat_put_{,u}long() argument
      bio.h: Declare the arguments of the bio iteration functions const
      block: Document the bio_vec properties
      null_blk: Zero-initialize read buffers in non-memory-backed mode

Christoph Hellwig (68):
      block: refactor blkpg_ioctl
      block: pass a hd_struct to delete_partition
      block: cleanup hd_struct freeing
      block: remove hd_struct_kill
      block: remove the disk argument from blk_drop_partitions
      dasd: use blk_drop_partitions instead of badly reimplementing it
      block: don't call invalidate_partition from blk_drop_partitions
      block: simplify block device syncing in bdev_del_partition
      block: mark invalidate_partition static
      block: fold bdev_unhash_inode into invalidate_partition
      block: remove RQF_COPY_USER
      block: provide a blk_rq_map_sg variant that returns the last element
      scsi: merge scsi_init_sgtable into scsi_init_io
      block: move dma drain handling to scsi
      block: move dma_pad handling from blk_rq_map_sg into the callers
      block: unexport bdev_read_page and bdev_write_page
      block: remove create_io_context
      bcache: remove a duplicate ->make_request_fn assignment
      dm: remove the make_request_fn check in device_area_is_invalid
      block: bypass ->make_request_fn for blk-mq drivers
      block: improve the submit_bio and generic_make_request documentation
      block: cleanup the memory stall accounting in submit_bio
      block: replace BIO_QUEUE_ENTERED with BIO_CGROUP_ACCT
      block: add a bio_queue_enter helper
      block: add a cdrom_device_info pointer to struct gendisk
      ide-cd: rename cdrom_read_tocentry
      cdrom: factor out a cdrom_read_tocentry helper
      cdrom: factor out a cdrom_multisession helper
      hfsplus: stop using ioctl_by_bdev
      isofs: stop using ioctl_by_bdev
      udf: stop using ioctl_by_bdev
      driver core: remove device_create_vargs
      bdi: unexport bdi_register_va
      bdi: remove bdi_register_owner
      bdi: simplify bdi_alloc
      bdi: remove the name field in struct backing_dev_info
      hfs: stop using ioctl_by_bdev
      block: rename __bio_add_pc_page to bio_add_hw_page
      block: remove the REQ_NOWAIT_INLINE flag
      blk-mq: move the call to blk_queue_enter_live out of blk_mq_get_request
      blk-mq: remove a pointless queue enter pair in blk_mq_alloc_request
      blk-mq: remove a pointless queue enter pair in blk_mq_alloc_request_hctx
      blk-mq: allow blk_mq_make_request to consume the q_usage_counter reference
      block: mark blk_account_io_completion static
      block: move the blk-mq calls out of part_in_flight{,_rw}
      block: don't call part_{inc,dec}_in_flight for blk-mq devices
      block: merge part_{inc,dev}_in_flight into their only callers
      block: remove the error_sector argument to blkdev_issue_flush
      block: remove the disk and queue NULL checks in blkdev_issue_flush
      block: add disk/bio-based accounting helpers
      drbd: use bio_{start,end}_io_acct
      rsxx: use bio_{start,end}_io_acct
      lightnvm/pblk: use bio_{start,end}_io_acct
      bcache: use bio_{start,end}_io_acct
      dm: use bio_{start,end}_io_acct
      nvdimm: use bio_{start,end}_io_acct
      zram: nvdimm: use bio_{start,end}_io_acct and disk_{start,end}_io_acct
      block: remove generic_{start,end}_io_acct
      block: move update_io_ticks to blk-core.c
      block: always use a percpu variable for disk stats
      block: reduce part_stat_lock() scope
      block: fix a warning when blkdev.h is included for !CONFIG_BLOCK builds
      blk-mq: remove the bio argument to ->prepare_request
      blk-mq: simplify the blk_mq_get_request calling convention
      blk-mq: move more request initialization to blk_mq_rq_ctx_init
      blk-mq: rename BLK_MQ_TAG_FAIL to BLK_MQ_NO_TAG
      blk-mq: use BLK_MQ_NO_TAG in more places
      blk-mq: open code __blk_mq_alloc_request in blk_mq_alloc_request_hctx

Colin Ian King (1):
      block: blk-crypto-fallback: remove redundant initialization of variable err

Damien Le Moal (2):
      block: Modify revalidate zones
      null_blk: Support REQ_OP_ZONE_APPEND

Dongli Zhang (1):
      null_blk: force complete for timeout request

Douglas Anderson (4):
      blk-mq: In blk_mq_dispatch_rq_list() "no budget" is a reason to kick
      blk-mq: Add blk_mq_delay_run_hw_queues() API call
      blk-mq: Rerun dispatching in the case of budget contention
      Revert "scsi: core: run queue if SCSI device queue isn't ready and queue is idle"

Guoqing Jiang (4):
      blk-throttle: remove blk_throtl_drain
      blk-throttle: remove tg_drain_bios
      blk-wbt: remove wbt_update_limits
      blk-wbt: rename __wbt_update_limits to wbt_update_limits

Jan Kara (1):
      blktrace: Report pid with note messages

Jens Axboe (2):
      Merge branch 'block-5.7' into for-5.8/block
      block: mark bio_wouldblock_error() bio with BIO_QUIET

Johannes Thumshirn (6):
      block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
      block: introduce blk_req_zone_write_trylock
      scsi: sd_zbc: factor out sanity checks for zoned commands
      scsi: sd_zbc: emulate ZONE_APPEND commands
      block: export bio_release_pages and bio_iov_iter_get_pages
      zonefs: use REQ_OP_ZONE_APPEND for sync DIO

Keith Busch (3):
      block: Introduce REQ_OP_ZONE_APPEND
      blk-mq: blk-mq: provide forced completion method
      nvme: force complete cancelled requests

Konstantin Khlebnikov (4):
      block: account merge of two requests
      block: add a blk_account_io_merge_bio helper
      block: remove rcu_read_lock() from part_stat_lock()
      block: use __this_cpu_add() instead of access by smp_processor_id()

Ming Lei (9):
      block: alloc map and request for new hardware queue
      block: fix use-after-free on cached last_lookup partition
      block: only define 'nr_sects_seq' in hd_part for 32bit SMP
      block: re-organize fields of 'struct hd_part'
      block: don't hold part0's refcount in IO path
      block: add blk_io_schedule() for avoiding task hung in sync dio
      block: move blk_io_schedule() out of header file
      blk-mq: add blk_mq_all_tag_iter
      blk-mq: drain I/O when all CPUs in a hctx are offline

Salman Qazi (1):
      block: Limit number of items taken from the I/O scheduler in one go

Satya Tangirala (5):
      Documentation: Document the blk-crypto framework
      block: Keyslot Manager for Inline Encryption
      block: Inline encryption support for blk-mq
      block: Make blk-integrity preclude hardware inline encryption
      block: blk-crypto-fallback for Inline Encryption

Stephen Rothwell (1):
      bdi: fix up for "remove the name field in struct backing_dev_info"

Tejun Heo (5):
      blk-iocost: switch to fixed non-auto-decaying use_delay
      blk-iocost: account for IO size when testing latencies
      iocost_monitor: exit successfully if interval is zero
      iocost_monitor: drop string wrap around numbers when outputting json
      iocost: don't let vrate run wild while there's no saturation signal

Weiping Zhang (5):
      block: free both rq_map and request
      block: save previous hardware queue count before udpate
      block: rename __blk_mq_alloc_rq_map
      block: rename blk_mq_alloc_rq_maps
      block: reset mapping if failed to update hardware queue count

Zheng Bin (1):
      blk-mq: make function '__blk_mq_sched_dispatch_requests' static

 Documentation/block/index.rst             |   1 +
 Documentation/block/inline-encryption.rst | 263 +++++++++++++++
 block/Kconfig                             |  18 +
 block/Makefile                            |   2 +
 block/bfq-iosched.c                       |   2 +-
 block/bio-integrity.c                     |   3 +
 block/bio.c                               | 184 ++++++-----
 block/blk-cgroup.c                        |   6 +
 block/blk-core.c                          | 325 ++++++++++++------
 block/blk-crypto-fallback.c               | 657 +++++++++++++++++++++++++++++++++++++
 block/blk-crypto-internal.h               | 201 ++++++++++++
 block/blk-crypto.c                        | 404 +++++++++++++++++++++++
 block/blk-exec.c                          |   2 +-
 block/blk-flush.c                         |  26 +-
 block/blk-integrity.c                     |   7 +
 block/blk-iocost.c                        |  86 +++--
 block/blk-map.c                           |  15 +-
 block/blk-merge.c                         |  76 ++---
 block/blk-mq-debugfs.c                    |   3 +-
 block/blk-mq-sched.c                      |  82 ++++-
 block/blk-mq-tag.c                        |  70 ++--
 block/blk-mq-tag.h                        |   6 +-
 block/blk-mq.c                            | 407 ++++++++++++++++-------
 block/blk-mq.h                            |   4 +-
 block/blk-settings.c                      |  68 ++--
 block/blk-sysfs.c                         |  13 +
 block/blk-throttle.c                      |  63 ----
 block/blk-wbt.c                           |  16 +-
 block/blk-wbt.h                           |   4 -
 block/blk-zoned.c                         |  23 +-
 block/blk.h                               |  88 ++---
 block/bounce.c                            |   2 +
 block/genhd.c                             | 133 ++++----
 block/ioctl.c                             | 154 ++-------
 block/keyslot-manager.c                   | 397 ++++++++++++++++++++++
 block/kyber-iosched.c                     |   2 +-
 block/mq-deadline.c                       |   2 +-
 block/partitions/core.c                   | 187 +++++++++--
 drivers/ata/libata-scsi.c                 |  30 +-
 drivers/base/core.c                       |  37 +--
 drivers/block/aoe/aoeblk.c                |   1 -
 drivers/block/drbd/drbd_req.c             |  27 +-
 drivers/block/loop.c                      |   2 +-
 drivers/block/null_blk_main.c             |  28 +-
 drivers/block/null_blk_zoned.c            |  37 ++-
 drivers/block/paride/pcd.c                |   2 +-
 drivers/block/rsxx/dev.c                  |  19 +-
 drivers/block/zram/zram_drv.c             |  24 +-
 drivers/cdrom/cdrom.c                     |  85 +++--
 drivers/cdrom/gdrom.c                     |   2 +-
 drivers/ide/ide-cd.c                      |  17 +-
 drivers/ide/ide-io.c                      |   7 +-
 drivers/lightnvm/pblk-cache.c             |   8 +-
 drivers/lightnvm/pblk-read.c              |  11 +-
 drivers/md/bcache/request.c               |  19 +-
 drivers/md/dm-integrity.c                 |   2 +-
 drivers/md/dm-rq.c                        |   2 +-
 drivers/md/dm-table.c                     |  17 -
 drivers/md/dm-zoned-metadata.c            |   6 +-
 drivers/md/dm.c                           |  24 +-
 drivers/md/raid5-ppl.c                    |   2 +-
 drivers/mtd/mtdcore.c                     |   3 +-
 drivers/nvdimm/blk.c                      |   6 +-
 drivers/nvdimm/btt.c                      |   6 +-
 drivers/nvdimm/nd.h                       |  19 --
 drivers/nvdimm/pmem.c                     |   6 +-
 drivers/nvme/host/core.c                  |   2 +-
 drivers/nvme/target/io-cmd-bdev.c         |   2 +-
 drivers/s390/block/dasd_genhd.c           |  20 +-
 drivers/scsi/scsi_lib.c                   |  87 +++--
 drivers/scsi/sd.c                         |  16 +-
 drivers/scsi/sd.h                         |  43 ++-
 drivers/scsi/sd_zbc.c                     | 399 ++++++++++++++++++++--
 drivers/scsi/sr.c                         |   3 +-
 fs/block_dev.c                            |  25 +-
 fs/direct-io.c                            |   2 +-
 fs/ext4/fsync.c                           |   2 +-
 fs/ext4/ialloc.c                          |   2 +-
 fs/ext4/super.c                           |   2 +-
 fs/fat/file.c                             |   2 +-
 fs/fs-writeback.c                         |   2 +-
 fs/hfs/mdb.c                              |  32 +-
 fs/hfsplus/inode.c                        |   2 +-
 fs/hfsplus/super.c                        |   2 +-
 fs/hfsplus/wrapper.c                      |  33 +-
 fs/iomap/direct-io.c                      |   2 +-
 fs/isofs/inode.c                          |  54 ++-
 fs/jbd2/checkpoint.c                      |   2 +-
 fs/jbd2/commit.c                          |   4 +-
 fs/jbd2/recovery.c                        |   2 +-
 fs/libfs.c                                |   2 +-
 fs/nilfs2/the_nilfs.h                     |   2 +-
 fs/ocfs2/file.c                           |   2 +-
 fs/reiserfs/file.c                        |   2 +-
 fs/super.c                                |   4 +-
 fs/udf/lowlevel.c                         |  29 +-
 fs/xfs/xfs_super.c                        |   2 +-
 fs/zonefs/super.c                         |  82 ++++-
 include/linux/backing-dev-defs.h          |   2 -
 include/linux/backing-dev.h               |   8 +-
 include/linux/bio.h                       |  13 +-
 include/linux/blk-cgroup.h                |  53 ++-
 include/linux/blk-crypto.h                | 123 +++++++
 include/linux/blk-mq.h                    |  14 +
 include/linux/blk_types.h                 |  24 +-
 include/linux/blkdev.h                    | 122 ++++++-
 include/linux/bvec.h                      |  13 +-
 include/linux/cdrom.h                     |   7 +-
 include/linux/cpuhotplug.h                |   1 +
 include/linux/device.h                    |   4 -
 include/linux/elevator.h                  |   2 +-
 include/linux/fs.h                        |   2 -
 include/linux/genhd.h                     |  40 ++-
 include/linux/keyslot-manager.h           | 106 ++++++
 include/linux/libata.h                    |   2 +
 include/linux/part_stat.h                 |  61 +---
 include/scsi/scsi_cmnd.h                  |   1 +
 include/scsi/scsi_device.h                |   3 +
 include/scsi/scsi_host.h                  |   7 +
 kernel/trace/blktrace.c                   |   4 +-
 mm/backing-dev.c                          |  21 +-
 tools/cgroup/iocost_monitor.py            |  48 +--
 122 files changed, 4510 insertions(+), 1489 deletions(-)
 create mode 100644 Documentation/block/inline-encryption.rst
 create mode 100644 block/blk-crypto-fallback.c
 create mode 100644 block/blk-crypto-internal.h
 create mode 100644 block/blk-crypto.c
 create mode 100644 block/keyslot-manager.c
 create mode 100644 include/linux/blk-crypto.h
 create mode 100644 include/linux/keyslot-manager.h

-- 
Jens Axboe


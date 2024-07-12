Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7360FC12
	for <linux-block@vger.kernel.org>; Fri, 12 Jul 2024 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763073; cv=none; b=K8ilz461saNEPEYItda4qTF3Aw6Jx36WZJQwRU5z6Gmcmxm/1FasLfnKgVBFgbAI3Co1Rp288xbx8tKAMR5fwTVvsp9KAK+fH3WHLN6ixdCM1E879ZUrR5jscxuLjCgslPOZ4CUWVreSLh9lyFwBeYuRoVRXh1pujzIUmTcKGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763073; c=relaxed/simple;
	bh=wLapvYMaHn2I6z0yNbBKG7Hi9lbkNZHAVjh+TRB5A8U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UJJDuPoA8wm+Cy63ChdqFwH2yD+YFD7ZVHAmcaVosGxac715O01yTyir22je22/aFQEzv7h6QpXGRxOW0d/KKgOBbhAWipILYwGI191ESzFhX7OOUxoOg6vc9arfHJAcByagyh4plqZHZxpTugedBgcqQW/xoHBl9rYfZXxhv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L5hbyy9p; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L5hbyy9p"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e9ebb9cbaso241892e87.1
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720763068; x=1721367868; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEXsQVspCF3Wbw7bDNHIzQbL3S4xoDR5LwE9lAvEuqg=;
        b=L5hbyy9pmRFFXp8h0PNnDs1gMBkJFblbXZFw6FxUc9UalBOiRd+fNt5j0qRqR+U+fV
         neCwYyw4yKTRMwZNoK1iVyEX756M3dlrZeo5+aozbuKMpgm+gpNsbuqgvu+AJIjltl7G
         ea5prxx9+kgx+yvrB7V6KvQGljWHQMHH7TYI1AqnP9HPKpVyruJn72Hu3C9qTwTDV99d
         KjFOlJ3vllexuZ5ZvXI306uDT0SP1kaarVP5oF2wLM8QBHDA31gGf1Fkki+vZrlNO9Ge
         bNZlU/NCbyVxxfcJWTAdUo+WD7a4qcbLTy6DAbcpGaOUL6bmjJl2aNjsjZ0GXKcBWm0G
         2YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720763068; x=1721367868;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tEXsQVspCF3Wbw7bDNHIzQbL3S4xoDR5LwE9lAvEuqg=;
        b=lhbPdLNGlBLy9WzRHco2W7dKX9Y0dmx4vNlZvcPcpX7KQvxb4XoPrfN7KmdXnr5MYg
         b1mRK7WOkbdyWaNP3hJ+RT30cHWwNvYvBXq0xdi/OA7K4b7OvGsPEFbvO2WLlRyL7f5N
         n3gGb3bMmD/gkwh4pmzZfiWPhCMA+41JXzpMlzUUnrv1wlCA+S4YwABBHoNRhE+YcSdA
         jObaKO2Z13QPZJzEaPz8kWKWN8W/BwqAbu4eQldtH6uwA1gjdo5e5mCahps3xSSdVakb
         beN+9JAAsaax4POX6xR/t1rEcqR1E5D6UhydIZPCjWfCN0DKv1nDgaqN7LEELVW1pCUk
         Ad9A==
X-Gm-Message-State: AOJu0YwhIYOh781ughqgVMFjPd3tdX8g9teo7OMWl1mQ+MQkVxcKDtaB
	9A5tLf1rWtnKv961Xhe2Gu+kNCafdbqgGNsWSgpbobQqk1RKwPAaywyE3dA1yTrNFpnXovu3s0j
	cwK3bMShR
X-Google-Smtp-Source: AGHT+IF3neM1SEGlbGhfkAWy84SyMvCK1xNZDY4lRdIKhvUGkWoRwBjejuFe+KK78MtqgebwYjUkvg==
X-Received: by 2002:a2e:a788:0:b0:2ee:d55c:255e with SMTP id 38308e7fff4ca-2eed55c2599mr3492631fa.6.1720763067531;
        Thu, 11 Jul 2024 22:44:27 -0700 (PDT)
Received: from [192.168.1.68] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eeb33fff42sm10767441fa.7.2024.07.11.22.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 22:44:26 -0700 (PDT)
Message-ID: <e988d4c4-f8b2-4cdb-9915-790abf69bfed@kernel.dk>
Date: Thu, 11 Jul 2024 23:44:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 6.11-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are the block changes that are queued up for the 6.11 merge
window. This pull request contains:

- NVMe updates via Keith
	- Device initialization memory leak fixes (Keith)
	- More constants defined (Weiwen)
	- Target debugfs support (Hannes)
	- PCIe subsystem reset enhancements (Keith)
	- Queue-depth multipath policy (Redhat and PureStorage)
	- Implement get_unique_id (Christoph)
	- Authentication error fixes (Gaosheng)

- MD updates via Song
	- sync_action fix and refactoring (Yu Kuai)
	- Various small fixes (Christoph Hellwig, Li Nan, and Ofir Gal,
	  Yu Kuai, Benjamin Marzinski, Christophe JAILLET, Yang Li)

- Fix loop detach/open race (Gulam)

- Fix lower control limit for blk-throttle (Yu)

- Add module descriptions to various drivers (Jeff)

- Add support for atomic writes for block devices, and statx reporting
  for same. Includes SCSI and NVMe (John, Prasad, Alan)

- Add IO priority information to block trace points (Dongliang)

- Various zone improvements and tweaks (Damien)

- mq-deadline tag reservation improvements (Bart)

- Ignore direct reclaim swap writes in writeback throttling (Baokun)

- Block integrity improvements and fixes (Anuj)

- Add basic support for rust based block drivers. Has a dummy null_blk
  variant for now (Andreas)

- Series converting driver settings to queue limits, and cleanups and
  fixes related to that (Christoph)

- Cleanup for poking too deeply into the bvec internals, in preparation
  for DMA mapping API changes (Christoph)

- Various minor tweaks and fixes (Jiapeng, John, Kanchan, Mikulas, Ming,
  Zhu, Damien, Christophe, Chaitanya)

Note the statx change for atomic writes will cause a trivial conflict
with a patch that went into the 6.9 kernel via the vfs tree later than
what the 6.11 block tree was based on. Easy to resolve, only mentioning
it for completeness sake.

Please pull!


The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.11/block-20240710

for you to fetch changes up to 3c1743a685b19bc17cf65af4a2eb149fd3b15c50:

  floppy: add missing MODULE_DESCRIPTION() macro (2024-07-10 00:22:03 -0600)

----------------------------------------------------------------
for-6.11/block-20240710

----------------------------------------------------------------
Alan Adamson (1):
      nvme: Atomic write support

Andreas Hindborg (6):
      rust: block: introduce `kernel::block::mq` module
      rust: block: add rnull, Rust null_blk implementation
      MAINTAINERS: add entry for Rust block device driver API
      rust: block: do not use removed queue limit API
      rust: block: do not use removed queue flag API
      rust: block: fix generated bindings after refactoring of features

Anuj Gupta (3):
      block: set bip_vcnt correctly
      block: t10-pi: Return correct ref tag when queue has no integrity profile
      block: reuse original bio_vec array for integrity during clone

Baokun Li (1):
      blk-wbt: don't throttle swap writes in direct reclaim

Bart Van Assche (2):
      block: Call .limit_depth() after .hctx has been set
      block/mq-deadline: Fix the tag reservation code

Benjamin Marzinski (1):
      md/raid5: recheck if reshape has finished with device_lock held

Chaitanya Kulkarni (1):
      block: fix get_max_segment_size() warning

Christoph Hellwig (98):
      md/raid0: don't free conf on raid0_run failure
      md/raid1: don't free conf on raid0_run failure
      ubd: refactor the interrupt handler
      ubd: untagle discard vs write zeroes not support handling
      rbd: increase io_opt again
      block: take io_opt and io_min into account for max_sectors
      sd: simplify the ZBC case in provisioning_mode_store
      sd: add a sd_disable_discard helper
      sd: add a sd_disable_write_same helper
      sd: simplify the disable case in sd_config_discard
      sd: factor out a sd_discard_mode helper
      sd: cleanup zoned queue limits initialization
      sd: convert to the atomic queue limits API
      sr: convert to the atomic queue limits API
      block: remove unused queue limits API
      block: add special APIs for run-time disabling of discard and friends
      block: initialize integrity buffer to zero before writing it to media
      md/raid0: don't free conf on raid0_run failure
      md/raid1: don't free conf on raid0_run failure
      dm-integrity: use the nop integrity profile
      block: remove the blk_integrity_profile structure
      block: remove the blk_flush_integrity call in blk_integrity_unregister
      block: factor out flag_{store,show} helper for integrity
      block: use kstrtoul in flag_store
      block: don't require stable pages for non-PI metadata
      block: bypass the STABLE_WRITES flag for protection information
      block: invert the BLK_INTEGRITY_{GENERATE,VERIFY} flags
      block: move integrity information into queue_limits
      xen-blkfront: don't disable cache flushes when they fail
      sd: remove sd_is_zoned
      sd: move zone limits setup out of sd_read_block_characteristics
      loop: stop using loop_reconfigure_limits in __loop_clr_fd
      loop: always update discard settings in loop_reconfigure_limits
      loop: regularize upgrading the block size for direct I/O
      loop: also use the default block size from an underlying block device
      loop: fold loop_update_rotational into loop_reconfigure_limits
      virtio_blk: remove virtblk_update_cache_mode
      nbd: move setting the cache control flags to __nbd_set_size
      block: freeze the queue in queue_attr_store
      block: remove blk_flush_policy
      block: move cache control settings out of queue->flags
      block: move the nonrot flag to queue_limits
      block: move the add_random flag to queue_limits
      block: move the io_stat flag setting to queue_limits
      block: move the stable_writes flag to queue_limits
      block: move the synchronous flag to queue_limits
      block: move the nowait flag to queue_limits
      block: move the dax flag to queue_limits
      block: move the poll flag to queue_limits
      block: move the zoned flag into the features field
      block: move the zone_resetall flag to queue_limits
      block: move the pci_p2pdma flag to queue_limits
      block: move the skip_tagset_quiesce flag to queue_limits
      block: move the bounce flag into the features field
      block: remove the unused blk_bounce enum
      block: fix spelling and grammar for in writeback_cache_control.rst
      block: renumber and rename the cache disabled flag
      block: move the misaligned flag into the features field
      block: remove the discard_alignment flag
      block: move the raid_partial_stripes_expensive flag into the features field
      block: fix the blk_queue_nonrot polarity
      md: set md-specific flags for all queue limits
      block: correctly report cache type
      block: rename BLK_FEAT_MISALIGNED
      block: convert features and flags to __bitwise types
      block: conding style fixup for blk_queue_max_guaranteed_bio
      block: remove disk_update_readahead
      block: remove the fallback case in queue_dma_alignment
      block: move dma_pad_mask into queue_limits
      bcache: work around a __bitwise to bool conversion sparse warning
      block: only zero non-PI metadata tuples in bio_integrity_prep
      block: simplify adding the payload in bio_integrity_prep
      block: remove allocation failure warnings in bio_integrity_prep
      block: switch on bio operation in bio_integrity_prep
      block: remove bio_integrity_process
      loop: don't set QUEUE_FLAG_NOMERGES
      megaraid_sas: don't set QUEUE_FLAG_NOMERGES
      mpt3sas_scsih: don't set QUEUE_FLAG_NOMERGES
      rnbd: don't set QUEUE_FLAG_SAME_COMP
      rnbd-cnt: don't set QUEUE_FLAG_SAME_FORCE
      block: simplify queue_logical_block_size
      block: add helper macros to de-duplicate the queue sysfs attributes
      block: pass a gendisk to the queue_sysfs_entry methods
      block: remove a duplicate io_min check in blk_validate_limits
      block: don't reduce max_sectors based on io_opt
      nvme: don't set io_opt if NOWS is zero
      xen-blkfront: fix sector_size propagation to the block layer
      loop: remove the unused inode variable in loop_configure
      block: factor out a blk_write_zeroes_limit helper
      block: remove the LBA alignment check in __blkdev_issue_zeroout
      block: move read-only and supported checks into (__)blkdev_issue_zeroout
      block: refacto blkdev_issue_zeroout
      block: limit the Write Zeroes to manually writing zeroes fallback
      blk-lib: check for kill signal in ioctl BLKZEROOUT
      block: add a bvec_phys helper
      block: pass a phys_addr_t to get_max_segment_size
      nvme: implement ->get_unique_id
      block: take offset into account in blk_bvec_map_sg again

Christophe JAILLET (2):
      md-cluster: Constify struct md_cluster_operations
      block/rnbd: Constify struct kobj_type

Damien Le Moal (13):
      block: Improve checks on zone resource limits
      dm: Call dm_revalidate_zones() after setting the queue limits
      dm: Improve zone resource limits handling
      dm: Remove unused macro DM_ZONE_INVALID_WP_OFST
      null_blk: Do not set disk->nr_zones
      block: Define bdev_nr_zones() as an inline function
      block: Cleanup block device zone helpers
      null_blk: Fix description of the fua parameter
      null_blk: Introduce the zone_full parameter
      dm: Refactor is_abnormal_io()
      dm: handle REQ_OP_ZONE_RESET_ALL
      block: Remove REQ_OP_ZONE_RESET_ALL emulation
      block: Remove blk_alloc_zone_bitmap()

Dongliang Cui (1):
      block: Add ioprio to block_rq tracepoint

Gaosheng Cui (1):
      nvmet-auth: fix nvmet_auth hash error handling

Gulam Mohamed (1):
      loop: Fix a race between loop detach and loop open

Hannes Reinecke (7):
      nvmet: add debugfs support
      nvmet: add 'host_traddr' callback for debugfs
      nvmet-tcp: implement host_traddr()
      nvmet-rdma: implement host_traddr()
      nvmet-fc: implement host_traddr()
      nvme-fcloop: implement 'host_traddr'
      lpfc_nvmet: implement 'host_traddr'

Jeff Johnson (9):
      amiflop: add missing MODULE_DESCRIPTION() macro
      ataflop: add missing MODULE_DESCRIPTION() macro
      z2ram: add missing MODULE_DESCRIPTION() macro
      cdrom: Add missing MODULE_DESCRIPTION()
      brd: add missing MODULE_DESCRIPTION() macro
      xen/blkback: add missing MODULE_DESCRIPTION() macro
      ublk_drv: add missing MODULE_DESCRIPTION() macro
      loop: add missing MODULE_DESCRIPTION() macro
      floppy: add missing MODULE_DESCRIPTION() macro

Jens Axboe (7):
      Merge tag 'md-6.11-20240612' of git://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.11/block
      Merge branch 'for-6.11/block-limits' into for-6.11/block
      Merge branch 'for-6.11/block-limits' into for-6.11/block
      Merge branch 'for-6.11/block-limits' into for-6.11/block
      block: use the right type for stub rq_integrity_vec()
      Merge tag 'md-6.11-20240704' of git://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.11/block
      Merge tag 'nvme-6.11-2024-07-08' of git://git.infradead.org/nvme into for-6.11/block

Jiapeng Chong (1):
      bdev: make blockdev_mnt static

John Garry (15):
      block: Drop locking annotation for limits_lock
      block: BFQ: Refactor bfq_exit_icq() to silence sparse warning
      block: Pass blk_queue_get_max_sectors() a request pointer
      block: Generalize chunk_sectors support as boundary support
      block: Add core atomic write support
      block: Add fops atomic write support
      scsi: sd: Atomic write support
      scsi: scsi_debug: Atomic write support
      block: Fix blk_validate_atomic_write_limits() build for arm32
      block: Delete blk_queue_flag_test_and_set()
      virtio_blk: Fix default logical block size fallback
      block: Validate logical block size in blk_validate_limits()
      null_blk: Don't bother validating blocksize
      virtio_blk: Don't bother validating blocksize
      loop: Don't bother validating blocksize

John Meneghini (1):
      nvme-multipath: prepare for "queue-depth" iopolicy

Kanchan Joshi (1):
      block: cleanup flag_{show,store}

Keith Busch (6):
      nvme: apple: fix device reference counting
      nvme: tcp: split controller bringup handling
      nvme: rdma: split controller bringup handling
      nvme: fc: split controller bringup handling
      nvme: split device add from initialization
      nvme-pci: do not directly handle subsys reset fallout

Li Nan (5):
      md: do not delete safemode_timer in mddev_suspend
      md: change the return value type of md_write_start to void
      md: fix deadlock between mddev_suspend and flush bio
      md: make md_flush_request() more readable
      block: clean up the check in blkdev_iomap_begin()

Mikulas Patocka (1):
      block: change rq_integrity_vec to respect the iterator

Ming Lei (1):
      block: check bio alignment in blk_mq_submit_bio

Ofir Gal (1):
      md/md-bitmap: fix writing non bitmap pages

Prasad Singamsetty (3):
      fs: Initial atomic write support
      fs: Add initial atomic write support info to statx
      block: Add atomic write support for statx

Thomas Song (1):
      nvme-multipath: implement "queue-depth" iopolicy

Weiwen Hu (4):
      nvme: rename nvme_sc_to_pr_err to nvme_status_to_pr_err
      nvme: fix status magic numbers
      nvme: rename CDR/MORE/DNR to NVME_STATUS_*
      mailmap: add entry for Weiwen Hu

Yang Li (1):
      md: Remove unneeded semicolon

Yu Kuai (16):
      md: rearrange recovery_flags
      md: add a new enum type sync_action
      md: add new helpers for sync_action
      md: factor out helper to start reshape from action_store()
      md: replace sysfs api sync_action with new helpers
      md: remove parameter check_seq for stop_sync_thread()
      md: don't fail action_store() if sync_thread is not registered
      md: use new helpers in md_do_sync()
      md: replace last_sync_action with new enum type
      md: factor out helpers for different sync_action in md_do_sync()
      md: pass in max_sectors for pers->sync_request()
      md/raid5: avoid BUG_ON() while continue reshape after reassembling
      block, bfq: remove blkg_path()
      blk-throttle: fix lower control under super low iops limit
      md/raid5: fix spares errors about rcu usage
      md: Don't wait for MD_RECOVERY_NEEDED for HOT_REMOVE_DISK ioctl

Zhu Yanjun (1):
      null_blk: don't initialize static 'g_virt_boundary' to false

 .mailmap                                        |   1 +
 Documentation/ABI/stable/sysfs-block            |  53 ++
 Documentation/block/data-integrity.rst          |  49 +-
 Documentation/block/writeback_cache_control.rst |  67 +--
 MAINTAINERS                                     |  14 +
 arch/m68k/emu/nfblock.c                         |   3 +-
 arch/um/drivers/ubd_kern.c                      |  53 +-
 arch/xtensa/platforms/iss/simdisk.c             |   5 +-
 block/Kconfig                                   |   8 +-
 block/Makefile                                  |   3 +-
 block/bdev.c                                    |  38 +-
 block/bfq-cgroup.c                              |  51 --
 block/bfq-iosched.c                             |  38 +-
 block/bfq-iosched.h                             |   3 -
 block/bio-integrity.c                           | 135 ++---
 block/bio.c                                     |   2 +-
 block/blk-cgroup.h                              |  13 -
 block/blk-core.c                                |  45 +-
 block/blk-flush.c                               |  36 +-
 block/blk-integrity.c                           | 228 +++------
 block/blk-lib.c                                 | 210 ++++----
 block/blk-map.c                                 |   2 +-
 block/blk-merge.c                               |  92 +++-
 block/blk-mq-debugfs.c                          |  13 -
 block/blk-mq.c                                  |  89 ++--
 block/blk-settings.c                            | 549 +++++++++------------
 block/blk-sysfs.c                               | 434 ++++++++--------
 block/blk-throttle.c                            |   3 +
 block/blk-wbt.c                                 |  22 +-
 block/blk-zoned.c                               | 126 +----
 block/blk.h                                     |  22 +-
 block/elevator.c                                |   9 +-
 block/elevator.h                                |   4 +-
 block/fops.c                                    |  25 +-
 block/genhd.c                                   |   2 +-
 block/ioctl.c                                   |   2 +-
 block/mq-deadline.c                             |  20 +-
 block/t10-pi.c                                  | 302 ++++++------
 drivers/ata/libata-scsi.c                       |   3 +-
 drivers/ata/pata_macio.c                        |   4 +-
 drivers/block/Kconfig                           |   9 +
 drivers/block/Makefile                          |   3 +
 drivers/block/amiflop.c                         |   6 +-
 drivers/block/aoe/aoeblk.c                      |   1 +
 drivers/block/ataflop.c                         |   6 +-
 drivers/block/brd.c                             |   7 +-
 drivers/block/drbd/drbd_main.c                  |   6 +-
 drivers/block/floppy.c                          |   4 +-
 drivers/block/loop.c                            | 184 +++----
 drivers/block/mtip32xx/mtip32xx.c               |   2 -
 drivers/block/n64cart.c                         |   2 -
 drivers/block/nbd.c                             |  26 +-
 drivers/block/null_blk/main.c                   |  29 +-
 drivers/block/null_blk/null_blk.h               |   1 +
 drivers/block/null_blk/zoned.c                  |  15 +-
 drivers/block/pktcdvd.c                         |   1 +
 drivers/block/ps3disk.c                         |   8 +-
 drivers/block/rbd.c                             |  15 +-
 drivers/block/rnbd/rnbd-clt-sysfs.c             |   2 +-
 drivers/block/rnbd/rnbd-clt.c                   |  16 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c             |   4 +-
 drivers/block/rnull.rs                          |  73 +++
 drivers/block/sunvdc.c                          |   1 +
 drivers/block/swim.c                            |   5 +-
 drivers/block/swim3.c                           |   5 +-
 drivers/block/ublk_drv.c                        |  22 +-
 drivers/block/virtio_blk.c                      |  68 ++-
 drivers/block/xen-blkback/blkback.c             |   1 +
 drivers/block/xen-blkfront.c                    |  73 ++-
 drivers/block/z2ram.c                           |   1 +
 drivers/block/zram/zram_drv.c                   |   6 +-
 drivers/cdrom/cdrom.c                           |   1 +
 drivers/cdrom/gdrom.c                           |   1 +
 drivers/md/bcache/super.c                       |  13 +-
 drivers/md/dm-cache-target.c                    |   1 -
 drivers/md/dm-clone-target.c                    |   1 -
 drivers/md/dm-core.h                            |   1 -
 drivers/md/dm-crypt.c                           |   4 +-
 drivers/md/dm-integrity.c                       |  47 +-
 drivers/md/dm-raid.c                            |   2 +-
 drivers/md/dm-table.c                           | 351 +++----------
 drivers/md/dm-zone.c                            | 254 ++++++++--
 drivers/md/dm-zoned-target.c                    |   2 +-
 drivers/md/dm.c                                 | 174 ++++++-
 drivers/md/dm.h                                 |   4 +
 drivers/md/md-bitmap.c                          |   6 +-
 drivers/md/md-cluster.c                         |   2 +-
 drivers/md/md.c                                 | 630 ++++++++++++------------
 drivers/md/md.h                                 | 136 ++++-
 drivers/md/raid0.c                              |  30 +-
 drivers/md/raid1.c                              |  34 +-
 drivers/md/raid10.c                             |  23 +-
 drivers/md/raid5.c                              | 114 +++--
 drivers/mmc/core/block.c                        |  42 +-
 drivers/mmc/core/queue.c                        |  20 +-
 drivers/mmc/core/queue.h                        |   3 +-
 drivers/mtd/mtd_blkdevs.c                       |   9 +-
 drivers/nvdimm/btt.c                            |  17 +-
 drivers/nvdimm/pmem.c                           |  14 +-
 drivers/nvme/host/Kconfig                       |   1 -
 drivers/nvme/host/apple.c                       |  32 +-
 drivers/nvme/host/constants.c                   |   2 +-
 drivers/nvme/host/core.c                        | 286 +++++++----
 drivers/nvme/host/fabrics.c                     |  25 +-
 drivers/nvme/host/fabrics.h                     |   1 +
 drivers/nvme/host/fault_inject.c                |   2 +-
 drivers/nvme/host/fc.c                          |  55 ++-
 drivers/nvme/host/multipath.c                   | 144 ++++--
 drivers/nvme/host/nvme.h                        |  28 +-
 drivers/nvme/host/pci.c                         |  47 +-
 drivers/nvme/host/pr.c                          |  10 +-
 drivers/nvme/host/rdma.c                        |  34 +-
 drivers/nvme/host/tcp.c                         |  31 +-
 drivers/nvme/host/zns.c                         |   3 +-
 drivers/nvme/target/Kconfig                     |  10 +-
 drivers/nvme/target/Makefile                    |   1 +
 drivers/nvme/target/admin-cmd.c                 |  24 +-
 drivers/nvme/target/auth.c                      |  14 +-
 drivers/nvme/target/core.c                      |  76 ++-
 drivers/nvme/target/debugfs.c                   | 202 ++++++++
 drivers/nvme/target/debugfs.h                   |  42 ++
 drivers/nvme/target/discovery.c                 |  14 +-
 drivers/nvme/target/fabrics-cmd-auth.c          |  16 +-
 drivers/nvme/target/fabrics-cmd.c               |  36 +-
 drivers/nvme/target/fc.c                        |  33 ++
 drivers/nvme/target/fcloop.c                    |  11 +
 drivers/nvme/target/io-cmd-bdev.c               |  28 +-
 drivers/nvme/target/loop.c                      |   5 +
 drivers/nvme/target/nvmet.h                     |  12 +-
 drivers/nvme/target/passthru.c                  |  10 +-
 drivers/nvme/target/rdma.c                      |  22 +-
 drivers/nvme/target/tcp.c                       |  18 +-
 drivers/nvme/target/zns.c                       |  30 +-
 drivers/s390/block/dasd_genhd.c                 |   1 -
 drivers/s390/block/dcssblk.c                    |   2 +-
 drivers/s390/block/scm_blk.c                    |   5 -
 drivers/scsi/Kconfig                            |   1 -
 drivers/scsi/iscsi_tcp.c                        |   8 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                  |  11 +
 drivers/scsi/megaraid/megaraid_sas_base.c       |   2 -
 drivers/scsi/mpt3sas/mpt3sas_scsih.c            |   6 -
 drivers/scsi/scsi_debug.c                       | 588 +++++++++++++++++-----
 drivers/scsi/scsi_lib.c                         |   9 +-
 drivers/scsi/scsi_trace.c                       |  22 +
 drivers/scsi/sd.c                               | 373 ++++++++------
 drivers/scsi/sd.h                               |  31 +-
 drivers/scsi/sd_dif.c                           |  45 +-
 drivers/scsi/sd_zbc.c                           |  52 +-
 drivers/scsi/sr.c                               |  42 +-
 drivers/target/target_core_iblock.c             |  49 +-
 drivers/ufs/core/ufshcd.c                       |  10 +-
 fs/aio.c                                        |   8 +-
 fs/btrfs/ioctl.c                                |   2 +-
 fs/read_write.c                                 |  18 +-
 fs/stat.c                                       |  50 +-
 include/linux/blk-integrity.h                   |  87 ++--
 include/linux/blk_types.h                       |   8 +-
 include/linux/blkdev.h                          | 349 ++++++++-----
 include/linux/bvec.h                            |  14 +
 include/linux/device-mapper.h                   |   7 +
 include/linux/fs.h                              |  20 +-
 include/linux/nvme-fc-driver.h                  |   4 +
 include/linux/nvme.h                            |  19 +-
 include/linux/stat.h                            |   3 +
 include/linux/t10-pi.h                          |  22 +-
 include/scsi/scsi_proto.h                       |   1 +
 include/trace/events/block.h                    |  41 +-
 include/trace/events/scsi.h                     |   1 +
 include/uapi/linux/fs.h                         |   5 +-
 include/uapi/linux/stat.h                       |  12 +-
 io_uring/rw.c                                   |   9 +-
 rust/bindings/bindings_helper.h                 |   5 +
 rust/helpers.c                                  |  16 +
 rust/kernel/block.rs                            |   5 +
 rust/kernel/block/mq.rs                         |  98 ++++
 rust/kernel/block/mq/gen_disk.rs                | 198 ++++++++
 rust/kernel/block/mq/operations.rs              | 245 +++++++++
 rust/kernel/block/mq/raw_writer.rs              |  55 +++
 rust/kernel/block/mq/request.rs                 | 253 ++++++++++
 rust/kernel/block/mq/tag_set.rs                 |  86 ++++
 rust/kernel/error.rs                            |   6 +
 rust/kernel/lib.rs                              |   2 +
 182 files changed, 5849 insertions(+), 3678 deletions(-)
 create mode 100644 drivers/block/rnull.rs
 create mode 100644 drivers/nvme/target/debugfs.c
 create mode 100644 drivers/nvme/target/debugfs.h
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs

-- 
Jens Axboe


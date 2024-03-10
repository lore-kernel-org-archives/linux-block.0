Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574C7F8
	for <linux-block@vger.kernel.org>; Sun, 10 Mar 2024 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710102663; cv=none; b=TVxjtgKIyw24pqS3gvjX3sOuD1/JexxKJ+NENDkJlj3Ya7wLwDqVzVm1RPSzswGOYQKjNiM9TjRUDenOYpw3jRgSnDRp2yczQLGBgOHzYybqmAXeY+qaezw4H2XXsskZwercYceXSi7V2ctdK4ZvtGODbzjeWy5efaZsXl/nCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710102663; c=relaxed/simple;
	bh=R5o8Zcv7PSDm15Bep8rTU50L9klm6YfCfxTowF5IlS4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OMW+pBdxOUpWWd5dsmU6ExHSQlkimeN1R68dZ46Abc4uFwtCzOFgf4kfCGBuUokAun57NWaJFos99bgFCA/ozTShG0zB7beHo9+UjId7Dar//Edb0KQQFTvz45bisRMV6j3GE2JPXtCTJ6p17zCPGm985fuPUZWwX3QOby1cTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Cl5yRRUL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Cl5yRRUL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd8ee2441dso331925ad.1
        for <linux-block@vger.kernel.org>; Sun, 10 Mar 2024 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710102659; x=1710707459; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNrSRRTXeYmDa0Mfo9LyGzq4v8OB1Qg7xLZErAg2nvU=;
        b=Cl5yRRULjorjUXxavMJpRkVLvqwY7K7/ndsMBrj1U/vbjJrj7JjQ+1DL1lmB+/jxf5
         vviBswz8T9dOvgnUCZaDhZdc/5lCnh7VL+OPcoaI7Al1yhYAm74qaf4oHzo6RoqDArJC
         yGPumFtN7itdJ3f1TvrglRxrGODesmNyhwrjA9lZ8YmwqSq4GauV4bJQ7x8axWrbdEr5
         0m+8v3kyskD5Q5AWpgZ4E87xHq0Kkl2ZXAGIg48lFB2ntV5B7M/o8rmwaSFHxBitwk5A
         CnynK4Q3/KSMZMIrobxF4R+YTkBe3R7I2eVjMF/+Ee5D1LBoo2sVWvEI3gaimxFaT//V
         gYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710102659; x=1710707459;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tNrSRRTXeYmDa0Mfo9LyGzq4v8OB1Qg7xLZErAg2nvU=;
        b=qW0avPtA3ycUYIsOhv65THapPIKvz04lTNrfc5mpow3MjRIff9G3pFMeiWMwXKjCY/
         U28kUxRBPiUmvrS6xLSZY3ZYxZ5a3ekronVL7KJszHfNycG0uilj8GxHMzTpl8aUQZVA
         Ujg3huzWlkFoj93qLsRbj4+J2HlmvijirHoUtW+Zr7xqNtSdIKCAHc+PaNnLFP3PwITe
         zbTry/I6VbTCrIurQlZO68MoLuTzLNy24qcIxM/8jNb7kOmPqfWHmzcCIf3rReC0ofZM
         leg1ooFik3ei9lNG+vnvMAK2TKaT1RmdrGD8MKhK4UUfozbncpEhaBVxzd+Zl0N+WAtS
         /dtA==
X-Gm-Message-State: AOJu0YxgGrf5Sz6RYPeGhvYeL9kIO0Q2xz3jWWrwo2Jzbp4R4hyZ4Gvw
	S0aHDo5SyPgs/HzzptKejH672gAQ4rmhk4NpeKRMTQFlf6tkA2KxT/WmGynLwWj7pc03muc+lCQ
	u
X-Google-Smtp-Source: AGHT+IFGnWYQMSWPWhb85yPJtGdoGtntNtXF4IWh36V+dn4m6p0NqsOJrqzaSRTVoeGECOQFybpVkA==
X-Received: by 2002:a17:90b:802:b0:296:db75:c240 with SMTP id bk2-20020a17090b080200b00296db75c240mr3397221pjb.1.1710102658760;
        Sun, 10 Mar 2024 13:30:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a0c1600b0029bae333a85sm4771969pjs.21.2024.03.10.13.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 13:30:58 -0700 (PDT)
Message-ID: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
Date: Sun, 10 Mar 2024 14:30:57 -0600
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
Subject: [GIT PULL] Block updates for 6.9-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here are the core block changes queued for the 6.9-rc1 kernel. This pull
request contains:

- MD pull requests via Song:
	- Cleanup redundant checks, by Yu Kuai.
	- Remove deprecated headers, by Marc Zyngier and Song Liu.
	- Concurrency fixes, by Li Lingfeng.
	- Memory leak fix, by Li Nan.
	- Refactor raid1 read_balance, by Yu Kuai and Paul Luse.
	- Clean up and fix for md_ioctl, by Li Nan.
	- Other small fixes, by Gui-Dong Han and Heming Zhao.
	- MD atomic limits (Christoph)

- NVMe pull request via Keith:
	- RDMA target enhancements (Max)
	- Fabrics fixes (Max, Guixin, Hannes)
	- Atomic queue_limits usage (Christoph)
	- Const use for class_register (Ricardo)
	- Identification error handling fixes (Shin'ichiro, Keith)

- Improvement and cleanup for cached request handling (Christoph)

- Moving towards atomic queue limits. Core changes and driver bits so
  far (Christoph)

- Fix UAF issues in aoeblk (Chun-Yi)

- Zoned fix and cleanups (Damien)

- s390 dasd cleanups and fixes (Jan, Miroslav)

- Block issue timestamp caching (me)

- noio scope guarding for zoned IO (Johannes)

- block/nvme PI improvements (Kanchan)

- Ability to terminate long running discard loop (Keith)

- bdev revalidation fix (Li)

- Get rid of old nr_queues hack for kdump kernels (Ming)

- Support for async deletion of ublk (Ming)

- Improve IRQ bio recycling (Pavel)

- Factor in CPU capacity for remote vs local completion (Qais)

- Add shared_tags configfs entry for null_blk (Shin'ichiro

- Fix for a regression in page refcounts introduced by the folio
  unification (Tony)

- Misc fixes and cleanups (Arnd, Colin, John, Kunwu, Li, Navid, Ricardo,
  Roman, Tang, Uwe, 

Please pull!


The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.9/block-20240310

for you to fetch changes up to 5205a4aa8fc9454853b705b69611c80e9c644283:

  block: partitions: only define function mac_fix_string for CONFIG_PPC_PMAC (2024-03-09 07:31:42 -0700)

----------------------------------------------------------------
for-6.9/block-20240310

----------------------------------------------------------------
Arnd Bergmann (2):
      floppy: fix function pointer cast warnings
      drbd: fix function cast warnings in state machine

Chengming Zhou (1):
      bdev: remove SLAB_MEM_SPREAD flag usage

Christoph Hellwig (108):
      blk-mq: move blk_mq_attempt_bio_merge out blk_mq_get_new_requests
      blk-mq: introduce a blk_mq_peek_cached_request helper
      blk-mq: special case cached requests less
      block: move max_{open,active}_zones to struct queue_limits
      block: refactor disk_update_readahead
      block: decouple blk_set_stacking_limits from blk_set_default_limits
      block: add an API to atomically update queue limits
      block: use queue_limits_commit_update in queue_max_sectors_store
      block: add a max_user_discard_sectors queue limit
      block: use queue_limits_commit_update in queue_discard_max_store
      block: pass a queue_limits argument to blk_alloc_queue
      block: pass a queue_limits argument to blk_mq_init_queue
      block: pass a queue_limits argument to blk_mq_alloc_disk
      virtio_blk: split virtblk_probe
      virtio_blk: pass queue_limits to blk_mq_alloc_disk
      loop: cleanup loop_config_discard
      loop: pass queue_limits to blk_mq_alloc_disk
      loop: use the atomic queue limits update API
      block: pass a queue_limits argument to blk_alloc_disk
      nfblock: pass queue_limits to blk_mq_alloc_disk
      brd: pass queue_limits to blk_mq_alloc_disk
      n64cart: pass queue_limits to blk_mq_alloc_disk
      zram: pass queue_limits to blk_mq_alloc_disk
      bcache: pass queue_limits to blk_mq_alloc_disk
      btt: pass queue_limits to blk_mq_alloc_disk
      pmem: pass queue_limits to blk_mq_alloc_disk
      dcssblk: pass queue_limits to blk_mq_alloc_disk
      ubd: pass queue_limits to blk_mq_alloc_disk
      aoe: pass queue_limits to blk_mq_alloc_disk
      floppy: pass queue_limits to blk_mq_alloc_disk
      mtip: pass queue_limits to blk_mq_alloc_disk
      nbd: pass queue_limits to blk_mq_alloc_disk
      ps3disk: pass queue_limits to blk_mq_alloc_disk
      rbd: pass queue_limits to blk_mq_alloc_disk
      rnbd-clt: pass queue_limits to blk_mq_alloc_disk
      sunvdc: pass queue_limits to blk_mq_alloc_disk
      gdrom: pass queue_limits to blk_mq_alloc_disk
      ms_block: pass queue_limits to blk_mq_alloc_disk
      mspro_block: pass queue_limits to blk_mq_alloc_disk
      mtd_blkdevs: pass queue_limits to blk_mq_alloc_disk
      ubiblock: pass queue_limits to blk_mq_alloc_disk
      scm_blk: pass queue_limits to blk_mq_alloc_disk
      ublk: pass queue_limits to blk_mq_alloc_disk
      mmc: pass queue_limits to blk_mq_alloc_disk
      null_blk: remove the bio based I/O path
      null_blk: initialize the tag_set timeout in null_init_tag_set
      null_blk: refactor tag_set setup
      null_blk: remove null_gendisk_register
      null_blk: pass queue_limits to blk_mq_alloc_disk
      block: fix virt_boundary handling in blk_validate_limits
      pktcdvd: stop setting q->queuedata
      pktcdvd: set queue limits at disk allocation time
      xen-blkfront: set max_discard/secure erase limits to UINT_MAX
      xen-blkfront: rely on the default discard granularity
      xen-blkfront: don't redundantly set max_sements in blkif_recover
      xen-blkfront: atomically update queue limits
      ubd: remove the ubd_gendisk array
      ubd: remove ubd_disk_register
      ubd: move setting the nonrot flag to ubd_add
      ubd: move setting the variable queue limits to ubd_add
      ubd: move set_disk_ro to ubd_add
      ubd: remove the queue pointer in struct ubd
      ubd: open the backing files in ubd_add
      block: add a queue_limits_set helper
      block: add a queue_limits_stack_bdev helper
      dm: use queue_limits_set
      pktcdvd: don't set max_hw_sectors on the underlying device
      nbd: don't clear discard_sectors in nbd_config_put
      nbd: freeze the queue for queue limits updates
      nbd: use the atomic queue limits API in nbd_set_size
      nvme: set max_hw_sectors unconditionally
      nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard
      nvme: remove nvme_revalidate_zones
      nvme: move max_integrity_segments handling out of nvme_init_integrity
      nvme: cleanup the nvme_init_integrity calling conventions
      nvme: move blk_integrity_unregister into nvme_init_integrity
      nvme: don't use nvme_update_disk_info for the multipath disk
      nvme: move a few things out of nvme_update_disk_info
      nvme: move setting the write cache flags out of nvme_set_queue_limits
      nvme: move common logic into nvme_update_ns_info
      nvme: split out a nvme_identify_ns_nvm helper
      nvme: don't query identify data in configure_metadata
      nvme: cleanup nvme_configure_metadata
      nvme: use the atomic queue limits update API
      nvme-multipath: pass queue_limits to blk_alloc_disk
      nvme-multipath: use atomic queue limits API for stacking limits
      dasd: cleamup dasd_state_basic_to_ready
      dasd: move queue setup to common code
      dasd: use the atomic queue limits API
      drbd: pass the max_hw_sectors limit to blk_alloc_disk
      drbd: refactor drbd_reconsider_queue_parameters
      drbd: refactor the backing dev max_segments calculation
      drbd: merge drbd_setup_queue_param into drbd_reconsider_queue_parameters
      drbd: don't set max_write_zeroes_sectors in decide_on_discard_support
      drbd: split out a drbd_discard_supported helper
      drbd: atomically update queue limits in drbd_reconsider_queue_parameters
      bcache: move calculation of stripe_size and io_opt into bcache_device_init
      md: add a mddev_trace_remap helper
      md: add a mddev_add_trace_msg helper
      md: add a mddev_is_dm helper
      md: add queue limit helpers
      md/raid0: use the atomic queue limit update APIs
      md/raid1: use the atomic queue limit update APIs
      md/raid5: use the atomic queue limit update APIs
      md/raid10: use the atomic queue limit update APIs
      md: don't initialize queue limits
      md: remove mddev->queue
      block: remove disk_stack_limits

Chun-Yi Lee (1):
      aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts

Colin Ian King (1):
      block: partitions: only define function mac_fix_string for CONFIG_PPC_PMAC

Damien Le Moal (3):
      block: Clear zone limits for a non-zoned stacked queue
      block: Do not include rbtree.h in blk-zoned.c
      virtio_blk: Do not use disk_set_max_open/active_zones()

Gui-Dong Han (1):
      md/raid5: fix atomicity violation in raid5_cache_count

Guixin Liu (1):
      nvme-fabrics: check max outstanding commands

Hannes Reinecke (1):
      nvme-fabrics: typo in nvmf_parse_key()

Heming Zhao (1):
      md/md-bitmap: fix incorrect usage for sb_index

Jan Höppner (10):
      s390/dasd: Simplify uid string generation
      s390/dasd: Use sysfs_emit() over sprintf()
      s390/dasd: Remove unnecessary errorstring generation
      s390/dasd: Move allocation error message to DBF
      s390/dasd: Remove unused message logging macros
      s390/dasd: Use dev_err() over printk()
      s390/dasd: Remove %p format specifier from error messages
      s390/dasd: Remove PRINTK_HEADER and KMSG_COMPONENT definitions
      s390/dasd: Use dev_*() for device log messages
      s390/dasd: Improve ERP error messages

Jens Axboe (9):
      block: move cgroup time handling code into blk.h
      block: add blk_time_get_ns() and blk_time_get() helpers
      block: cache current nsec time in struct blk_plug
      block: update cached timestamp post schedule/preemption
      Merge tag 'md-6.9-20240216' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.9/block
      Merge tag 'md-6.9-20240301' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.9/block
      Merge tag 'md-6.9-20240305' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.9/block
      Merge tag 'md-6.9-20240306' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.9/block
      Merge tag 'nvme-6.9-2024-03-07' of git://git.infradead.org/nvme into for-6.9/block

Johannes Thumshirn (5):
      zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
      dm: dm-zoned: guard blkdev_zone_mgmt with noio scope
      btrfs: zoned: call blkdev_zone_mgmt in nofs scope
      f2fs: guard blkdev_zone_mgmt with nofs scope
      block: remove gfp_flags from blkdev_zone_mgmt

John Garry (1):
      null_blk: Delete nullb.{queue_depth, nr_queues}

Kanchan Joshi (3):
      block: refactor guard helpers
      block: support PI at non-zero offset within metadata
      nvme: allow integrity when PI is not in first bytes

Keith Busch (5):
      block: blkdev_issue_secure_erase loop style
      block: cleanup __blkdev_issue_write_zeroes
      block: io wait hang check helper
      blk-lib: check for kill signal
      nvme: clear caller pointer on identify failure

Kunwu Chan (1):
      block: Simplify the allocation of slab caches

Li Lingfeng (3):
      md: get rdev->mddev with READ_ONCE()
      md: use RCU lock to protect traversal in md_spares_need_change()
      block: move capacity validation to blkpg_do_ioctl()

Li Nan (11):
      md: fix kmemleak of rdev->serial
      block: fix deadlock between bd_link_disk_holder and partition scan
      md: merge the check of capabilities into md_ioctl_valid()
      md: changed the switch of RAID_VERSION to if
      md: clean up invalid BUG_ON in md_ioctl
      md: return directly before setting did_set_md_closing
      md: Don't clear MD_CLOSING when the raid is about to stop
      md: factor out a helper to sync mddev
      md: sync blockdev before stopping raid or setting readonly
      md: clean up openers check in do_md_stop() and md_set_readonly()
      md: check mddev->pers before calling md_set_readonly()

Li kunyu (2):
      sed-opal: Remove unnecessary ‘0’ values from ret
      sed-opal: Remove the ret variable from the function

Li zeming (2):
      sed-opal: Remove unnecessary ‘0’ values from error
      sed-opal: Remove unnecessary ‘0’ values from err

Marc Zyngier (1):
      md/linear: Get rid of md-linear.h

Max Gurtovoy (8):
      nvme-rdma: move NVME_RDMA_IP_PORT from common file
      nvmet: compare mqes and sqsize only for IO SQ
      nvmet: set maxcmd to be per controller
      nvmet: set ctrl pi_support cap before initializing cap reg
      nvme-rdma: introduce NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
      nvme-rdma: clamp queue size according to ctrl cap
      nvmet: introduce new max queue size configuration entry
      nvmet-rdma: set max_queue_size for RDMA transport

Ming Lei (3):
      blk-mq: don't change nr_hw_queues and nr_maps for kdump kernel
      ublk: improve getting & putting ublk device
      ublk: add UBLK_CMD_DEL_DEV_ASYNC

Miroslav Franc (1):
      s390/dasd: fix double module refcount decrement

Navid Emamdoost (1):
      nbd: null check for nla_nest_start

Pavel Begunkov (2):
      block: extend bio caching to task context
      block: optimise in irq bio put caching

Qais Yousef (2):
      sched: Add a new function to compare if two cpus have the same capacity
      block/blk-mq: Don't complete locally if capacities are different

Ricardo B. Marliere (5):
      block: rbd: make rbd_bus_type const
      nvme: core: constify struct class usage
      nvme: fabrics: make nvmf_class constant
      nvme: fcloop: make fcloop_class constant
      block: make block_class constant

Roman Smirnov (1):
      block: prevent division by zero in blk_rq_stat_sum()

Shin'ichiro Kawasaki (2):
      null_blk: add configfs variable shared_tags
      nvme: host: fix double-free of struct nvme_id_ns in ns_update_nuse()

Song Liu (4):
      md/multipath: Remove md-multipath.h
      Merge branch 'raid1-read_balance' into md-6.9
      Revert "Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d""
      Merge branch 'dmraid-fix-6.9' into md-6.9

Tang Yizhou (1):
      blk-throttle: Eliminate redundant checks for data direction

Tony Battersby (1):
      block: Fix page refcounts for unaligned buffers in __bio_release_pages()

Uwe Kleine-König (2):
      cdrom: gdrom: Convert to platform remove callback returning void
      block/swim: Convert to platform remove callback returning void

Yu Kuai (22):
      md: remove redundant check of 'mddev->sync_thread'
      md: remove redundant md_wakeup_thread()
      md: add a new helper rdev_has_badblock()
      md/raid1: factor out helpers to add rdev to conf
      md/raid1: record nonrot rdevs while adding/removing rdevs to conf
      md/raid1: fix choose next idle in read_balance()
      md/raid1-10: add a helper raid1_check_read_range()
      md/raid1-10: factor out a new helper raid1_should_read_first()
      md/raid1: factor out read_first_rdev() from read_balance()
      md/raid1: factor out choose_slow_rdev() from read_balance()
      md/raid1: factor out choose_bb_rdev() from read_balance()
      md/raid1: factor out the code to manage sequential IO
      md/raid1: factor out helpers to choose the best rdev from read_balance()
      md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume
      md: export helpers to stop sync_thread
      md: export helper md_is_rdwr()
      md: add a new helper reshape_interrupted()
      dm-raid: really frozen sync_thread during suspend
      md/dm-raid: don't call md_reap_sync_thread() directly
      dm-raid: add a new helper prepare_suspend() in md_personality
      dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io concurrent with reshape
      dm-raid: fix lockdep waring in "pers->hot_add_disk"

 arch/m68k/emu/nfblock.c                |  10 +-
 arch/um/drivers/ubd_kern.c             | 135 +++-----
 arch/xtensa/platforms/iss/simdisk.c    |   8 +-
 block/bdev.c                           |   2 +-
 block/bfq-cgroup.c                     |  14 +-
 block/bfq-iosched.c                    |  28 +-
 block/bio-integrity.c                  |   1 +
 block/bio.c                            |  45 ++-
 block/blk-cgroup.c                     |   2 +-
 block/blk-cgroup.h                     |   1 +
 block/blk-core.c                       |  33 +-
 block/blk-flush.c                      |   2 +-
 block/blk-integrity.c                  |   1 +
 block/blk-iocost.c                     |   8 +-
 block/blk-iolatency.c                  |   6 +-
 block/blk-lib.c                        |  70 +++-
 block/blk-mq.c                         | 186 +++++-----
 block/blk-settings.c                   | 329 ++++++++++++++----
 block/blk-stat.c                       |   2 +-
 block/blk-sysfs.c                      |  59 ++--
 block/blk-throttle.c                   |  10 +-
 block/blk-wbt.c                        |   6 +-
 block/blk-zoned.c                      |  20 +-
 block/blk.h                            |  84 ++++-
 block/bsg-lib.c                        |   2 +-
 block/genhd.c                          |  14 +-
 block/holder.c                         |  12 +-
 block/ioctl.c                          |   9 +-
 block/partitions/core.c                |  11 -
 block/partitions/mac.c                 |   2 +
 block/sed-opal.c                       |  16 +-
 block/t10-pi.c                         |  72 ++--
 drivers/base/base.h                    |   2 +-
 drivers/block/amiflop.c                |   2 +-
 drivers/block/aoe/aoeblk.c             |  15 +-
 drivers/block/aoe/aoecmd.c             |  12 +-
 drivers/block/aoe/aoenet.c             |   1 +
 drivers/block/ataflop.c                |   2 +-
 drivers/block/brd.c                    |  26 +-
 drivers/block/drbd/drbd_main.c         |  17 +-
 drivers/block/drbd/drbd_nl.c           | 210 ++++++------
 drivers/block/drbd/drbd_state.c        |  24 +-
 drivers/block/drbd/drbd_state_change.h |   8 +-
 drivers/block/floppy.c                 |  17 +-
 drivers/block/loop.c                   |  75 ++--
 drivers/block/mtip32xx/mtip32xx.c      |  13 +-
 drivers/block/n64cart.c                |  12 +-
 drivers/block/nbd.c                    |  49 ++-
 drivers/block/null_blk/main.c          | 535 ++++++++---------------------
 drivers/block/null_blk/null_blk.h      |  24 +-
 drivers/block/null_blk/trace.h         |   5 +-
 drivers/block/null_blk/zoned.c         |  25 +-
 drivers/block/pktcdvd.c                |  41 +--
 drivers/block/ps3disk.c                |  17 +-
 drivers/block/ps3vram.c                |   6 +-
 drivers/block/rbd.c                    |  31 +-
 drivers/block/rnbd/rnbd-clt.c          |  64 ++--
 drivers/block/sunvdc.c                 |  18 +-
 drivers/block/swim.c                   |   8 +-
 drivers/block/swim3.c                  |   2 +-
 drivers/block/ublk_drv.c               | 111 +++---
 drivers/block/virtio_blk.c             | 303 +++++++++--------
 drivers/block/xen-blkfront.c           |  53 +--
 drivers/block/z2ram.c                  |   2 +-
 drivers/block/zram/zram_drv.c          |  51 ++-
 drivers/cdrom/gdrom.c                  |  20 +-
 drivers/md/bcache/super.c              |  59 ++--
 drivers/md/dm-raid.c                   |  93 +++--
 drivers/md/dm-table.c                  |  27 +-
 drivers/md/dm-zoned-metadata.c         |   5 +-
 drivers/md/dm.c                        |   4 +-
 drivers/md/md-bitmap.c                 |  18 +-
 drivers/md/md-linear.h                 |  17 -
 drivers/md/md-multipath.h              |  32 --
 drivers/md/md.c                        | 400 +++++++++++++---------
 drivers/md/md.h                        |  77 ++++-
 drivers/md/raid0.c                     |  42 +--
 drivers/md/raid1-10.c                  |  69 ++++
 drivers/md/raid1.c                     | 601 ++++++++++++++++++++-------------
 drivers/md/raid1.h                     |   1 +
 drivers/md/raid10.c                    | 143 ++++----
 drivers/md/raid5-ppl.c                 |   3 +-
 drivers/md/raid5.c                     | 273 ++++++++-------
 drivers/memstick/core/ms_block.c       |  14 +-
 drivers/memstick/core/mspro_block.c    |  15 +-
 drivers/mmc/core/queue.c               |  97 +++---
 drivers/mtd/mtd_blkdevs.c              |  12 +-
 drivers/mtd/ubi/block.c                |   6 +-
 drivers/nvdimm/btt.c                   |  14 +-
 drivers/nvdimm/pmem.c                  |  14 +-
 drivers/nvme/host/apple.c              |   2 +-
 drivers/nvme/host/core.c               | 458 +++++++++++++------------
 drivers/nvme/host/fabrics.c            |  22 +-
 drivers/nvme/host/multipath.c          |  17 +-
 drivers/nvme/host/nvme.h               |  12 +-
 drivers/nvme/host/rdma.c               |  14 +-
 drivers/nvme/host/sysfs.c              |   7 +-
 drivers/nvme/host/zns.c                |  24 +-
 drivers/nvme/target/admin-cmd.c        |   2 +-
 drivers/nvme/target/configfs.c         |  28 ++
 drivers/nvme/target/core.c             |  18 +-
 drivers/nvme/target/discovery.c        |   2 +-
 drivers/nvme/target/fabrics-cmd.c      |   5 +-
 drivers/nvme/target/fcloop.c           |  17 +-
 drivers/nvme/target/nvmet.h            |   6 +-
 drivers/nvme/target/passthru.c         |   2 +-
 drivers/nvme/target/rdma.c             |  10 +
 drivers/nvme/target/zns.c              |   5 +-
 drivers/s390/block/dasd.c              | 180 +++++-----
 drivers/s390/block/dasd_3990_erp.c     |  80 ++---
 drivers/s390/block/dasd_alias.c        |   8 -
 drivers/s390/block/dasd_devmap.c       |  34 +-
 drivers/s390/block/dasd_diag.c         |  26 +-
 drivers/s390/block/dasd_eckd.c         | 186 ++++------
 drivers/s390/block/dasd_eer.c          |   7 -
 drivers/s390/block/dasd_erp.c          |   9 +-
 drivers/s390/block/dasd_fba.c          |  88 ++---
 drivers/s390/block/dasd_genhd.c        |  18 +-
 drivers/s390/block/dasd_int.h          |  35 +-
 drivers/s390/block/dasd_ioctl.c        |   6 -
 drivers/s390/block/dasd_proc.c         |   5 -
 drivers/s390/block/dcssblk.c           |  10 +-
 drivers/s390/block/scm_blk.c           |  17 +-
 drivers/scsi/scsi_scan.c               |   2 +-
 drivers/ufs/core/ufshcd.c              |   2 +-
 fs/btrfs/zoned.c                       |  35 +-
 fs/f2fs/segment.c                      |  15 +-
 fs/zonefs/super.c                      |   2 +-
 include/linux/blk-integrity.h          |   1 +
 include/linux/blk-mq.h                 |  10 +-
 include/linux/blk_types.h              |  42 ---
 include/linux/blkdev.h                 |  73 +++-
 include/linux/nvme-rdma.h              |   6 +-
 include/linux/nvme.h                   |   2 -
 include/linux/sched.h                  |   2 +-
 include/linux/sched/topology.h         |   6 +
 include/uapi/linux/ublk_cmd.h          |   2 +
 kernel/sched/core.c                    |  17 +-
 138 files changed, 3443 insertions(+), 3171 deletions(-)
 delete mode 100644 drivers/md/md-linear.h
 delete mode 100644 drivers/md/md-multipath.h

-- 
Jens Axboe


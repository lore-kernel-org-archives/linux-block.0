Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267533468E
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764605559; cv=none; b=p0IABU2tSi929vhDBi6ES/tJPyf4ZijFxSK/hhDE+saVH034hqmiYtMmlC6Fu4W3tYR7inmPHGqovdO8kut7CnKt9kGqggoAfiErk85qoV7rhSDcWwX7dPnTel8+IbJXLpeCZUlQKHxSU4arj6SGV6R+Z7NoIvV9gwDKbbX/YFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764605559; c=relaxed/simple;
	bh=HJZt2Qvs4KDLq0qzr433oR6pGg85FKM1nEUPgL+WZPg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XrZo9pQFZGOARlevvMEaE+0TNftlY3WCIhqHOuDuZmyAl3NnGQrw9m+iX7kvA/Mt6p8Pvxk0wqZ2hSyZ/rGKqYC5YBN0T9G6TuAqkyEkaRm2KTS4Gv7aoXOgEGrk6scgNEv3YQ8JdpWsDSk6JKVoJ4rePo3dQ6cxqZXpd7bJZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W9Z1lpm4; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W9Z1lpm4"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c6ce4f65f7so3053202a34.0
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764605554; x=1765210354; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7lYGpL7w7K5nFOSn9/JoSott/fha9l0eYrpqxp3HVQ=;
        b=W9Z1lpm4vXlPepBlkNjJua8hjN1iMZKpRom8BHskJlmRFC4ebUw3dV0b3gbKtfga1Z
         Deyz+s+YUPhJZkcXpVq8WS9wvN9OMsvIGWNqCGnSCBOm5/oSs3GtbuQZ5pn+p4FmmXI/
         ymDhTQd6nmb1DH4/uWTOjGm5l6HRt6URE1x62I0IxYF+EcMLWTbsRAPWu56mO68jrzrI
         Jj94oiqEFJOWPBs3fYlzF7sSuSRz+/JMAmBq4/mFPXKqsGvDyXbn3emcU9vcVL+wvTNd
         3cOieVcRVcnmsUuRxau9MCFFok/KKVxipTbuLjBhenNMob2UAV2HnpXs6AQkOdayUqI6
         /muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764605554; x=1765210354;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7lYGpL7w7K5nFOSn9/JoSott/fha9l0eYrpqxp3HVQ=;
        b=UOtOcaZ48RkOy/ojXqxbE5gd/G9lcgAiRC52wosYM6XKQC1tXs/EvgHIfB19hITa2j
         VsA7SOjdclodhc4clqHv7lBKioHUDd/IgaaOo/EyZFFOi+GeevlRn9BrwaLRhMzNlqnu
         i+Hy8451Wrio+pPposuiCsvWdtOWyx1xj3Y42s0aJQQF7LQQAktCi1tUlxJvSXTTUViU
         S8j1rum2JlSlfjDixR3e346dH6xfEQRC6ZNfymRW9fAmrwZ6LpXGb3UYiKp6Icb8KTZg
         ettcwZix/z2RzBHXRlV/l0T3cmHy2S02WbqNEH30l69MhqbqFzugyRtMyqFUpDx/qMOL
         pg3A==
X-Gm-Message-State: AOJu0Yzl16QBe+uajxuZ9kTc038C4Md0L3F7DNeacS6ONUf4NoNneM05
	RceXG/w6LmkkZwaUS6RxlxVJvR0ef0wEjSr2YbgWO10btijUOdZlRSeBiyuAPtQwGb9+JwoinFy
	7SJ31O+A=
X-Gm-Gg: ASbGncsXi7wLIywq8nSET+1TlIyQ8N47JPCYapVttNuSRYaYYxPPvArOfmWfp07kszY
	WgV0Vsuii7VLBP+iOX0U/s+5luuOXDJ8DLrlSFVMzrruwwqXYD1JKQ0fE0KMrAkmDMyz7t9BYOi
	lShYaXeIht+11YoY6VK1DfvCqmBp/W0eUy6gOWuH+duV2BuZkdASXeR0qmUPbr0Zlh/9CUQbDqV
	xC4vkHkToauSvaSkxLKJIMU5lEcnVGsjEfLKprQ5atU6sEVqKEExcXycUryzM3DQxAd3fyj9JIU
	nrD5fg4oyYnF1J+x8Jl03g77+efn4A+epm2ZkDW855tMI3ajJsbo7nrgdvIb4DIR0oj77g/qkA0
	SLA3oFEGvi/8NrqEqGQXZr7fq9/fkHtbdSWt97xxZe+9Sen5jORUcJK1XZvpkdgV8FVqGPcUlR4
	jG6PhSZ54Da4xXXRNG
X-Google-Smtp-Source: AGHT+IEWR/cTpJ/2b3COyANhdKG1jIIKVdIg8mXmdZt0w8rNpX19fXO9jH3SMFq7BWhhuMQQuX5Q2Q==
X-Received: by 2002:a05:6830:368b:b0:7c7:1f5:28a with SMTP id 46e09a7af769-7c7c412b81dmr15986739a34.12.1764605554176;
        Mon, 01 Dec 2025 08:12:34 -0800 (PST)
Received: from [192.168.1.99] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fe0f65bsm4700596a34.24.2025.12.01.08.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 08:12:33 -0800 (PST)
Message-ID: <e62f9ce3-00ae-4453-8047-1f938a5d51a3@kernel.dk>
Date: Mon, 1 Dec 2025 09:12:32 -0700
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
Subject: [GIT PULL] Block updates for 6.19-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here are the block changes queued for 6.19-rc1. This pull request
contains:

- Fix head insertion for mq-deadline, a regression from when priority
  support was added.

- Series simplifying and improving the ublk user copy code.

- Various ublk related cleanups.

- Fixup REQ_NOWAIT handling in loop/zloop, clearing NOWAIT when the
  request is punted to a thread for handling.

- Merge and then later revert loop dio nowait support, as it ended up
  causing excessive stack usage for when the inline issue code needs to
  dip back into the full file system code.

- Improve auto integrity code, making it less deadlock prone.

- Speedup polled IO handling, but manually managing the hctx lookups.

- Fixes for blk-throttle for SSD devices.

- Small series with fixes for the S390 dasd driver.

- Add support for caching zones, avoiding unnecessary report zone
  queries.

- MD pull requests via Yu
	- fix null-ptr-dereference regression for dm-raid0
	- fix IO hang for raid5 when array is broken with IO inflight
	- remove legacy 1s delay to speed up system shutdown
	- Change maintainer's email address
	- Data can be lost if array is created with different lbs
	  devices, fix this problem and record lbs of the array in
	  metadata
	- Fix rcu protection for md_thread
	- Fix mddev kobject lifetime regression
	- Enable atomic writes for md-linear
	- Some cleanups

- bcache updates via Coly
	- Remove useless discard and cache device code
	- Improve usage of per-cpu workqueues

- Reorganize the IO scheduler switching code, fixing some lockdep
  reports as well.

- Improve the block layer P2P DMA support.

- Add support to the block tracing code for zoned devices.

- Segment calculation improves, and memory alignment flexibility
  improvements.

- Set of prep and cleanups patches for ublk batching support. The actual
  batching hasn't been added yet, but helps shrink down the workload of
  getting that patchset ready for 6.20.

- Fix for how the ps3 block driver handles segments offsets.

- Improve how block plugging handles batch tag allocations.

- nbd fixes for use-after-free of the configuration on device clear/put.

- Set of improvements and fixes for zloop.

- Add Damien as maintainer of the block zoned device code handling.

- Various other fixes and cleanups.

This will throw a merge conflict in null_blk main.c, where the
resolution is to just keep the dma_alignment = 1 part of it. It will
also throw a conflict in blk-settings.c, where the resolution is to just
keep both of the checks.

Please pull!


The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-6.19/block-20251201

for you to fetch changes up to d211a2803551c8ffdf0b97d129388f7d9cc129b5:

  block/rnbd: correct all kernel-doc complaints (2025-12-01 07:19:50 -0700)

----------------------------------------------------------------
for-6.19/block-20251201

----------------------------------------------------------------
Bart Van Assche (7):
      block/mq-deadline: Introduce dd_start_request()
      block/mq-deadline: Switch back to a single dispatch list
      blk-zoned: Fix a typo in a source code comment
      blk-zoned: Document disk_zone_wplug_schedule_bio_work() locking
      blk-zoned: Move code from disk_zone_wplug_add_bio() into its caller
      fs: Add the __data_racy annotation to backing_dev_info.ra_pages
      block: Remove queue freezing from several sysfs store callbacks

Caleb Sander Mateos (5):
      ublk: use copy_{to,from}_iter() for user copy
      ublk: use rq_for_each_segment() for user copy
      block: clean up indentation in blk_rq_map_iter_init()
      ublk: remove unnecessary checks in ublk_check_and_get_req()
      ublk: return unsigned from ublk_{,un}map_io()

Chaitanya Kulkarni (7):
      blktrace: use debug print to report dropped events
      blktrace: for ftrace use correct trace format ver
      blktrace: add support for REQ_OP_WRITE_ZEROES tracing
      block: add lockdep to queue_limits_commit_update()
      loop: clear nowait flag in workqueue context
      zloop: clear nowait flag in workqueue context
      block: ignore __blkdev_issue_discard() return value

Chen Ni (1):
      md/md-llbitmap: Remove unneeded semicolon

Chengkaitao (1):
      block: remove the declaration of elevator_init_mq function

Christoph Hellwig (5):
      block: blocking mempool_alloc doesn't fail
      block: make bio auto-integrity deadlock safe
      block: don't leak disk->zones_cond for !disk_need_zone_resources
      block: fix cached zone reporting after zone append was used
      block: don't return 1 for the fallback case in blkdev_get_zone_info

Coly Li (5):
      bcache: get rid of discard code from journal
      bcache: remove discard code from alloc.c
      bcache: drop discard sysfs interface
      bcache: remove discard sysfs interface document
      bcache: reduce gc latency by processing less nodes and sleep less time

Cong Zhang (1):
      virtio_blk: NULL out vqs to avoid double free on failed resume

Damien Le Moal (30):
      block: handle zone management operations completions
      block: freeze queue when updating zone resources
      block: cleanup blkdev_report_zones()
      block: introduce disk_report_zone()
      block: reorganize struct blk_zone_wplug
      block: use zone condition to determine conventional zones
      block: track zone conditions
      block: refactor blkdev_report_zones() code
      block: introduce blkdev_get_zone_info()
      block: introduce blkdev_report_zones_cached()
      block: introduce BLKREPORTZONESV2 ioctl
      block: improve zone_wplugs debugfs attribute output
      block: add zone write plug condition to debugfs zone_wplugs
      btrfs: use blkdev_report_zones_cached()
      xfs: use blkdev_report_zones_cached()
      block: improve blk_zone_wp_offset()
      block: refactor disk_zone_wplug_sync_wp_offset()
      block: introduce bdev_zone_start()
      block: fix NULL pointer dereference in blk_zone_reset_all_bio_endio()
      block: fix NULL pointer dereference in disk_report_zones()
      dm: fix zone reset all operation processing
      zloop: make the write pointer of full zones invalid
      zloop: fail zone append operations that are targeting full zones
      zloop: simplify checks for writes to sequential zones
      zloop: introduce the zone_append configuration parameter
      zloop: introduce the ordered_zone_append configuration parameter
      Documentation: admin-guide: blockdev: update zloop parameters
      MAINTAINERS: add missing block layer user API header files
      MAINTAINERS: add a maintainer for zoned block device support
      zloop: fix zone append check in zloop_rw()

David Laight (1):
      block: use min() instead of min_t()

Fengnan Chang (3):
      blk-mq: use array manage hctx map instead of xarray
      blk-mq: fix potential uaf for 'queue_hw_ctx'
      blk-mq: use queue_hctx in blk_mq_map_queue_type

Guenter Roeck (3):
      block/blk-throttle: Fix throttle slice time for SSDs
      block/blk-throttle: drop unneeded blk_stat_enable_accounting
      block/blk-throttle: Remove throtl_slice from struct throtl_data

Gustavo A. R. Silva (1):
      bcache: Avoid -Wflex-array-member-not-at-end warning

Huiwen He (1):
      md/raid5: remove redundant __GFP_NOWARN

Jan Höppner (2):
      s390/dasd: Move device name formatting into separate function
      s390/dasd: Use scnprintf() instead of sprintf()

Jens Axboe (10):
      Merge branch 'autopi-deadlock' into for-6.19/block
      Merge branch 'cached-zones' into for-6.19/block
      Merge tag 'md-6.19-20251111' of gitolite.kernel.org:pub/scm/linux/kernel/git/mdraid/linux into for-6.19/block
      Merge branch 'bcache-updates-6.19' into for-6.19/block
      Merge branch 'elevator-switch-6.19' into for-6.19/block
      Merge branch 'p2pdma-mmio-6.19.v5' into for-6.19/block
      Merge branch 'loop-aio-nowait' into for-6.19/block
      Revert "block: consider discard merge last"
      Revert "Merge branch 'loop-aio-nowait' into for-6.19/block"
      Merge tag 'md-6.19-20251130' of gitolite.kernel.org:pub/scm/linux/kernel/git/mdraid/linux into for-6.19/block

Johannes Thumshirn (16):
      blktrace: only calculate trace length once
      blktrace: factor out recording a blktrace event
      blktrace: split out relaying a blktrace event
      blktrace: untangle if/else sequence in __blk_add_trace
      blktrace: change the internal action to 64bit
      blktrace: split do_blk_trace_setup into two functions
      blktrace: add definitions for blk_user_trace_setup2
      blktrace: pass blk_user_trace2 to setup functions
      blktrace: add definitions for struct blk_io_trace2
      blktrace: differentiate between blk_io_trace versions
      blktrace: move trace_note to blk_io_trace2
      blktrace: move ftrace blk_io_tracer to blk_io_trace2
      blktrace: add block trace commands for zone operations
      blktrace: expose ZONE APPEND completions to blktrace
      blktrace: trace zone write plugging operations
      blktrace: handle BLKTRACESETUP2 ioctl

John Garry (2):
      md/md-linear: Enable atomic writes
      block: Remove references to __device_add_disk()

Keith Busch (10):
      block: rename min_segment_size
      null_blk: simplify copy_from_nullb
      null_blk: consistently use blk_status_t
      null_blk: single kmap per bio segment
      null_blk: allow byte aligned memory offsets
      block: accumulate memory segment gaps per bio
      nvme: remove virtual boundary for sgl capable devices
      block: fix merging data-less bios
      null_blk: fix zone read length beyond write pointer
      block: consider discard merge last

Kevin Brodsky (1):
      ublk: prevent invalid access with DEBUG

Kriish Sharma (1):
      blk-mq-dma: fix kernel-doc function name for integrity DMA iterator

Leon Romanovsky (2):
      nvme-pci: migrate to dma_map_phys instead of map_page
      block-dma: properly take MMIO path

Li Chen (1):
      block: rate-limit capacity change info log

Li Nan (6):
      md: prevent adding disks with larger logical_block_size to active arrays
      md: delete md_redundancy_group when array is becoming inactive
      md: init bioset in mddev_init
      md/raid0: Move queue limit setup before r0conf initialization
      md: add check_new_feature module parameter
      md: allow configuring logical block size

Marco Crivellari (2):
      bcache: replace use of system_wq with system_percpu_wq
      bcache: WQ_PERCPU added to alloc_workqueue users

Mehdi Ben Hadj Khelifa (1):
      blk-mq: use struct_size() in kmalloc()

Ming Lei (17):
      ublk: reorder tag_set initialization before queue allocation
      ublk: implement NUMA-aware memory allocation
      ublk: use struct_size() for allocation
      selftests: ublk: set CPU affinity before thread initialization
      selftests: ublk: make ublk_thread thread-local variable
      loop: add helper lo_cmd_nr_bvec()
      loop: add helper lo_rw_aio_prep()
      loop: add lo_submit_rw_aio()
      loop: move command blkcg/memcg initialization into loop_queue_work
      loop: try to handle loop aio command via NOWAIT IO first
      loop: add hint for handling aio via IOCB_NOWAIT
      kfifo: add kfifo_alloc_node() helper for NUMA awareness
      ublk: add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg()
      ublk: add `union ublk_io_buf` with improved naming
      ublk: refactor auto buffer register in ublk_dispatch_req()
      ublk: pass const pointer to ublk_queue_is_zoned()
      ublk: add helper of __ublk_fetch()

Nilay Shroff (5):
      block: unify elevator tags and type xarrays into struct elv_change_ctx
      block: move elevator tags into struct elevator_resources
      block: introduce alloc_sched_data and free_sched_data elevator methods
      block: use {alloc|free}_sched data methods
      block: define alloc_sched_data and free_sched_data methods for kyber

Qianfeng Rong (1):
      bcache: remove redundant __GFP_NOWARN

Randy Dunlap (2):
      sbitmap: fix all kernel-doc warnings
      block/rnbd: correct all kernel-doc complaints

Rene Rebe (2):
      ps3disk: use memcpy_{from,to}_bvec index
      floppy: fix for PAGE_SIZE != 4KB

Shankari Anand (1):
      rust: block: update ARef and AlwaysRefCounted imports from sync::aref

Shi Hao (1):
      drbd: replace kmap() with kmap_local_page() in receiver path

Stefan Haberland (2):
      s390/dasd: Fix gendisk parent after copy pair swap
      s390/dasd: Remove unnecessary debugfs_create() return checks

Sukrut Heroorkar (1):
      drbd: turn bitmap I/O comments into regular block comments

Tarun Sahu (1):
      md: remove legacy 1s delay in md_notify_reboot

Wu Guanghao (1):
      Factor out code into md_should_do_recovery()

Xiao Ni (2):
      md: delete mddev kobj before deleting gendisk kobj
      md: avoid repeated calls to del_gendisk

Xue He (1):
      block: plug attempts to batch allocate tags multiple times

Yu Kuai (4):
      MAINTAINERS: Update Yu Kuai's E-mail address
      md/raid0: fix NULL pointer dereference in create_strip_zones() for dm-raid
      md: warn about updating super block failure
      md/raid5: fix IO hang when array is broken with IO inflight

Yun Zhou (1):
      md: fix rcu protection in md_wakeup_thread

Zheng Qixing (2):
      nbd: defer config put in recv_work
      nbd: defer config unlock in nbd_genl_connect

shechenglong (1):
      block: fix typos in comments and strings in blk-core

 Documentation/ABI/testing/sysfs-block-bcache      |   7 -
 Documentation/admin-guide/bcache.rst              |  13 +-
 Documentation/admin-guide/blockdev/zoned_loop.rst |  61 +-
 Documentation/admin-guide/md.rst                  |  10 +
 MAINTAINERS                                       |  13 +-
 block/bio-integrity-auto.c                        |  26 +-
 block/bio-integrity.c                             |  48 ++
 block/bio.c                                       |   1 +
 block/blk-core.c                                  |  12 +-
 block/blk-iocost.c                                |   6 +-
 block/blk-lib.c                                   |   6 +-
 block/blk-map.c                                   |   3 +
 block/blk-merge.c                                 |  44 +-
 block/blk-mq-dma.c                                |  29 +-
 block/blk-mq-sched.c                              | 120 ++-
 block/blk-mq-sched.h                              |  40 +-
 block/blk-mq-tag.c                                |   2 +-
 block/blk-mq.c                                    | 152 ++--
 block/blk-mq.h                                    |   2 +-
 block/blk-settings.c                              |  27 +-
 block/blk-sysfs.c                                 |  26 +-
 block/blk-throttle.c                              |  45 +-
 block/blk-zoned.c                                 | 928 ++++++++++++++++------
 block/blk.h                                       |  23 +-
 block/elevator.c                                  |  80 +-
 block/elevator.h                                  |  27 +-
 block/genhd.c                                     |   8 +-
 block/ioctl.c                                     |   2 +
 block/kyber-iosched.c                             |  30 +-
 block/mq-deadline.c                               | 129 ++-
 block/partitions/efi.c                            |   3 +-
 drivers/block/drbd/drbd_bitmap.c                  |  10 +-
 drivers/block/drbd/drbd_receiver.c                |   8 +-
 drivers/block/floppy.c                            |   2 +-
 drivers/block/loop.c                              |   4 +
 drivers/block/nbd.c                               |   5 +-
 drivers/block/null_blk/main.c                     |  81 +-
 drivers/block/null_blk/null_blk.h                 |   3 +-
 drivers/block/null_blk/zoned.c                    |   6 +-
 drivers/block/ps3disk.c                           |   4 +
 drivers/block/rnbd/rnbd-proto.h                   |  15 +-
 drivers/block/rnull/rnull.rs                      |   3 +-
 drivers/block/ublk_drv.c                          | 385 +++++----
 drivers/block/virtio_blk.c                        |  24 +-
 drivers/block/zloop.c                             | 160 +++-
 drivers/md/bcache/alloc.c                         |  25 +-
 drivers/md/bcache/bcache.h                        |   6 +-
 drivers/md/bcache/bset.h                          |   8 +-
 drivers/md/bcache/btree.c                         |  53 +-
 drivers/md/bcache/journal.c                       |  93 +--
 drivers/md/bcache/journal.h                       |  13 -
 drivers/md/bcache/super.c                         |  33 +-
 drivers/md/bcache/sysfs.c                         |  15 -
 drivers/md/bcache/writeback.c                     |   5 +-
 drivers/md/dm-zone.c                              |  63 +-
 drivers/md/dm.h                                   |   3 +-
 drivers/md/md-linear.c                            |   2 +
 drivers/md/md-llbitmap.c                          |   2 +-
 drivers/md/md.c                                   | 259 ++++--
 drivers/md/md.h                                   |  10 +-
 drivers/md/raid0.c                                |  20 +-
 drivers/md/raid1.c                                |   1 +
 drivers/md/raid10.c                               |   1 +
 drivers/md/raid5-cache.c                          |   2 +-
 drivers/md/raid5.c                                |   7 +-
 drivers/nvme/host/apple.c                         |   1 +
 drivers/nvme/host/core.c                          |  15 +-
 drivers/nvme/host/fabrics.h                       |   6 +
 drivers/nvme/host/fc.c                            |   1 +
 drivers/nvme/host/multipath.c                     |   4 +-
 drivers/nvme/host/nvme.h                          |   9 +-
 drivers/nvme/host/pci.c                           | 118 ++-
 drivers/nvme/host/rdma.c                          |   1 +
 drivers/nvme/host/tcp.c                           |   1 +
 drivers/nvme/host/zns.c                           |  10 +-
 drivers/nvme/target/loop.c                        |   1 +
 drivers/s390/block/dasd.c                         |  64 +-
 drivers/s390/block/dasd_devmap.c                  |   3 +-
 drivers/s390/block/dasd_eckd.c                    |   8 +
 drivers/s390/block/dasd_genhd.c                   |  80 +-
 drivers/scsi/sd.h                                 |   2 +-
 drivers/scsi/sd_zbc.c                             |  20 +-
 fs/btrfs/zoned.c                                  |  11 +-
 fs/xfs/libxfs/xfs_zones.c                         |   1 +
 fs/xfs/xfs_zone_alloc.c                           |   2 +-
 include/linux/backing-dev-defs.h                  |   4 +-
 include/linux/bio-integrity.h                     |   7 +-
 include/linux/bio.h                               |   2 +
 include/linux/blk-integrity.h                     |  19 +-
 include/linux/blk-mq-dma.h                        |  28 +-
 include/linux/blk-mq.h                            |  30 +-
 include/linux/blk_types.h                         |  14 +-
 include/linux/blkdev.h                            |  62 +-
 include/linux/blktrace_api.h                      |   3 +-
 include/linux/device-mapper.h                     |  10 +-
 include/linux/kfifo.h                             |  34 +-
 include/linux/sbitmap.h                           |   6 +-
 include/uapi/linux/blktrace_api.h                 |  55 +-
 include/uapi/linux/blkzoned.h                     |  46 +-
 include/uapi/linux/fs.h                           |   3 +-
 include/uapi/linux/raid/md_p.h                    |   3 +-
 kernel/trace/blktrace.c                           | 533 ++++++++++---
 lib/kfifo.c                                       |   8 +-
 rust/kernel/block/mq.rs                           |   5 +-
 rust/kernel/block/mq/operations.rs                |   4 +-
 rust/kernel/block/mq/request.rs                   |   8 +-
 tools/testing/selftests/ublk/kublk.c              |  70 +-
 tools/testing/selftests/ublk/kublk.h              |   9 +-
 108 files changed, 3019 insertions(+), 1556 deletions(-)

-- 
Jens Axboe


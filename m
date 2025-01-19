Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681BD531
	for <linux-block@vger.kernel.org>; Sun, 19 Jan 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737302225; cv=none; b=LNFWxVYYqcOnFxCnVZvCt7Gd6whN2iWRHqPq4zAuBFpJBil/AvcB/bB+XB3aR7sV4ScCC2UUiI4f+y9KxNX6EkQwkUaG4Hbjazljj/L0WNK5HF06UveOKj2+fpte4avwUTfzvxyJb77jl4WbUuFtwjdFl6m+omOD0K/32xoi4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737302225; c=relaxed/simple;
	bh=GTdxyPMCtGyYcC0zw6gPrv0UsFDHgo4Cv8vxRLw1BGE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jYnSaUTiKmZEQg5vVdDapo1kZystZul8ew+DzUhLOiUI1qApjBDEFUGI7+mENwAMFjmsafvzfF4Qx1NwNAAYT4kbftKXi95seuMsL30mIa3t1ON8B4vNN3LUMXAFK4e3rjUWoLN75EwFQF/Fq3+K058h9WTQUvD/OT6yzUaKuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=osgymPDd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="osgymPDd"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166022c5caso59656865ad.2
        for <linux-block@vger.kernel.org>; Sun, 19 Jan 2025 07:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737302220; x=1737907020; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00dmyVvr/1u7gcMXktt2g3mWJ/sU5zj+b/liZMlC194=;
        b=osgymPDd+6+iermiPHxAWO9Vjq92ELP2LB+5YI/fT+OnzPgRyAnMyzN9xOGaisKyMV
         p5Q/v5byXQe9xuVAbCha7RHVO49w+q5J2BX/EhH+Q7CMwkAcQWhXJlbY1z5BwX1ZvQmc
         A3nHt3tOs3cYPF3IW8ibE//nm3bCtiwoCYPNpVyYFgMWpsxEUx2kPuV1T21iFkU+k171
         O8XsnQ63UNedGhodxsT3AYYESBRybPCQ/CR1SV8RiDUHTxSTwDCzZu83V+iACTiirBYG
         RYbiVbed6FzPU4A49IPuDiuKI/qZrbLu94abuD8W3dfNlbbpZW2TmSHS13aUB5R9hUK5
         EKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737302220; x=1737907020;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00dmyVvr/1u7gcMXktt2g3mWJ/sU5zj+b/liZMlC194=;
        b=fV9uTLwouSy2qgm77FVm0v01fqecfp+a0WSbIxmRd83CYLW+UFVctfbmBSK5pJertU
         yvyjxigFp7rACugd+wWd6I1USlZ3+n15XmX6zAMh94pjJzXP7/qWmLNXZBishAFAg52M
         jST8vgHuCzDBz6lx9GK5rCjY9Ovwr35KqMbvijBuyJ3bE6O0MAms0WlU321tSCxe47Q1
         4sMWs8u0ELUWkVRwdBIM7VWVtiFmlQ2dmJSfrzp99gSStO5DrUIT6rgw10UeQ3H8se+/
         +nZuBBLUeAmUjvReDF7YMfw1Qd/ipGnPJfFW66wsTSAzBHRkJ31CzFx7Y9PxbHDb3cdq
         Bkpw==
X-Gm-Message-State: AOJu0Yyz/8T7FAL8h5p0hbMtKGCHBvf3mdSkSUbHPuzaZAN/0x5JoCOd
	HxerhTnk6npyv2l9J4ulbghndpGdKE7HBMxcjEjWzlxQCIUTcpPkWA1oJezGbEdzpB7GmAGwzyF
	k
X-Gm-Gg: ASbGncsqKGxV+/Hu2VaTU/17uu6QVZAjtzJsMaTk2jnwd+I24tmIanmG2fm6mtH9oBI
	PBe7IPDQ+W+gXu7FEkSOWH89AvLiNITddUduowJIdIfOs+n1hwzX6GEa8TA/LtczO3BoFIDBCu+
	NGf6NN05ln4RNHxZ8QUCJFZTvHPkwQUcsJLYJvFBlHnJO7/uwCtdmGYVVH9w5MBz9KGm7qNXcD4
	nfeNYBcpzbFu6c7dJLscmOfIf/1bee7pFuYSOIsUqpMbfn8rmLTA5ZUrZHatMkyF6Q=
X-Google-Smtp-Source: AGHT+IGOIk1yHI6f3Yne7D/TiQ+BY6e8/PcJ07/iDysRCABXLxLdGpGn+V+oiwXrtuXSwFDJR8jQyw==
X-Received: by 2002:a17:903:120a:b0:215:9f5a:a236 with SMTP id d9443c01a7336-21c351cfb3dmr109862505ad.6.1737302220467;
        Sun, 19 Jan 2025 07:57:00 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3aca04sm46135385ad.135.2025.01.19.07.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 07:56:59 -0800 (PST)
Message-ID: <488c1331-386f-4eba-a2d8-33f81a21e3c8@kernel.dk>
Date: Sun, 19 Jan 2025 08:56:58 -0700
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
Subject: [GIT PULL] Block updates for 6.14-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here are the block related updates for the 6.14 merge window. This pull
request contains:

- NVMe pull requests via Keith
	- Target support for PCI-Endpoint transport (Damien)
	- TCP IO queue spreading fixes (Sagi, Chaitanya)
	- Target handling for "limited retry" flags (Guixen)
	- Poll type fix (Yongsoo)
	- Xarray storage error handling (Keisuke)
	- Host memory buffer free size fix on error (Francis)

- MD pull requests via Song
	- Reintroduce md-linear, by Yu Kuai
	- md-bitmap refactor and fix, by Yu Kuai
	- Replace kmap_atomic with kmap_local_page, by David Reaver

- Quite a few queue freeze and debugfs deadlock fixes. Ming introduced
  lockdep support for this in the 6.13 kernel, and it's (unsurprisingly)
  uncovered quite a few issues

- Use const attributes for IO schedulers

- Remove bio ioprio wrappers

- Fixes for stacked device atomic write support

- Refactor queue affinity helpers, in preparation for better supporting
  isolated CPUs

- Cleanups of loop O_DIRECT handling

- Cleanup of BLK_MQ_F_* flags

- Add rotational support for null_blk

- Various fixes and cleanups

This will throw a trivial conflict in drivers/md/dm-verity-fec.c due to
the bio ioprio wrapper removal. The merge is simple, just replace
bio_prio(bio) with bio->bi_ioprio in both cases.

Please pull!


The following changes since commit 4bbf9020becbfd8fc2c3da790855b7042fad455b:

  Linux 6.13-rc4 (2024-12-22 13:22:21 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.14/block-20250118

for you to fetch changes up to 554b22864cc79e28cd65e3a6e1d0d1dfa8581c68:

  block: Don't trim an atomic write (2025-01-17 13:13:55 -0700)

----------------------------------------------------------------
for-6.14/block-20250118

----------------------------------------------------------------
Andreas Hindborg (1):
      rust: block: fix use of BLK_MQ_F_SHOULD_MERGE

Bart Van Assche (6):
      blk-zoned: Minimize #include directives
      blk-zoned: Document locking assumptions
      blk-zoned: Improve the queue reference count strategy documentation
      blk-zoned: Split queue_zone_wplugs_show()
      block: Reorder the request allocation code in blk_mq_submit_bio()
      blk-mq: Move more error handling into blk_mq_submit_bio()

Baruch Siach (1):
      nvme-pci: fix comment typo

Benoît du Garreau (1):
      block: rnull: Initialize the module in place

Christoph Hellwig (28):
      block: remove BLK_MQ_F_SHOULD_MERGE
      block: remove bio_add_pc_page
      block: remove blk_rq_bio_prep
      block: use page_to_phys in bvec_phys
      block: add a dma mapping iterator
      block: better split mq vs non-mq code in add_disk_fwnode
      block: remove blk_mq_init_bitmaps
      block: remove BLK_MQ_F_NO_SCHED
      block: simplify tag allocation policy selection
      block: fix docs for freezing of queue limits updates
      block: add a queue_limits_commit_update_frozen helper
      block: check BLK_FEAT_POLL under q_usage_count
      block: don't update BLK_FEAT_POLL in __blk_mq_update_nr_hw_queues
      block: add a store_limit operations for sysfs entries
      block: fix queue freeze vs limits lock order in sysfs store methods
      nvme: fix queue freeze vs limits lock order
      nbd: fix queue freeze vs limits lock order
      usb-storage: fix queue freeze vs limits lock order
      loop: refactor queue limits updates
      loop: fix queue freeze vs limits lock order
      loop: move updating lo_flags out of loop_set_status_from_info
      loop: update commands in loop_set_status still referring to transfers
      loop: create a lo_can_use_dio helper
      loop: only write back pagecache when starting to to use direct I/O
      loop: open code the direct I/O flag update in loop_set_dio
      loop: allow loop_set_status to re-enable direct I/O
      loop: don't freeze the queue in loop_update_dio
      loop: remove the use_dio field in struct loop_device

Colin Ian King (1):
      blktrace: remove redundant return at end of function

Damien Le Moal (19):
      null_blk: Add rotational feature support
      nvme: Move opcode string helper functions declarations
      nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
      nvmet: Export nvmet_update_cc() and nvmet_cc_xxx() helpers
      nvmet: Introduce nvmet_get_cmd_effects_admin()
      nvmet: Add drvdata field to struct nvmet_ctrl
      nvme: Add PCI transport type
      nvmet: Improve nvmet_alloc_ctrl() interface and implementation
      nvmet: Introduce nvmet_req_transfer_len()
      nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()
      nvmet: Add support for I/O queue management admin commands
      nvmet: Do not require SGL for PCI target controller commands
      nvmet: Introduce get/set_feature controller operations
      nvmet: Implement host identifier set feature support
      nvmet: Implement interrupt coalescing feature support
      nvmet: Implement interrupt config feature support
      nvmet: Implement arbitration feature support
      nvmet: New NVMe PCI endpoint function target driver
      Documentation: Document the NVMe PCI endpoint target driver

Dan Carpenter (1):
      md/md-linear: Fix a NULL vs IS_ERR() bug in linear_add()

Daniel Wagner (8):
      driver core: bus: add irq_get_affinity callback to bus_type
      PCI: hookup irq_get_affinity callback
      virtio: hookup irq_get_affinity callback
      blk-mq: introduce blk_mq_map_hw_queues
      scsi: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues
      nvme: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues
      virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_map_hw_queues
      blk-mq: remove unused queue mapping helpers

David Reaver (1):
      md: Replace deprecated kmap_atomic() with kmap_local_page()

Francis Pravin (1):
      nvme-pci: use correct size to free the hmb buffer

Geert Uytterhoeven (1):
      ps3disk: Do not use dev->bounce_size before it is set

Guixin Liu (1):
      nvmet: handle rw's limited retry flag

Jens Axboe (4):
      Merge tag 'nvme-6.14-2025-01-12' of git://git.infradead.org/nvme into for-6.14/block
      nvme: fix bogus kzalloc() return check in nvme_init_effects_log()
      Merge tag 'md-6.14-20250113' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.14/block
      Merge tag 'md-6.14-20250116' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.14/block

John Garry (6):
      block: Delete bio_prio()
      block: Delete bio_set_prio()
      block: Ensure start sector is aligned for stacking atomic writes
      block: Change blk_stack_atomic_writes_limits() unit_min check
      block: Add common atomic writes enable flag
      block: Don't trim an atomic write

Keisuke Nishimura (2):
      nvme: Add error check for xa_store in nvme_get_effects_log
      nvme: Add error path for xa_store in nvme_init_effects

Matthew Wilcox (Oracle) (1):
      null_blk: Remove accesses to page->index

Ming Lei (9):
      block: remove unnecessary check in blk_unfreeze_check_owner()
      block: track disk DEAD state automatically for modeling queue freeze lockdep
      block: don't verify queue freeze manually in elevator_init_mq()
      block: track queue dying state automatically for modeling queue freeze lockdep
      blktrace: don't centralize grabbing q->debugfs_mutex in blk_trace_ioctl
      blktrace: move copy_[to|from]_user() out of ->debugfs_lock
      block: mark GFP_NOIO around sysfs ->store()
      nbd: fix partial sending
      block: limit disk max sectors to (LLONG_MAX >> 9)

Randy Dunlap (3):
      blk-cgroup: fix kernel-doc warnings in header file
      blk-cgroup: rwstat: fix kernel-doc warnings in header file
      partitions: ldm: remove the initial kernel-doc notation

Sagi Grimberg (1):
      nvme-tcp: Fix I/O queue cpu spreading for multiple controllers

Song Liu (1):
      Merge branch 'md-6.14-bitmap' into md-6.14

Thomas Weißschuh (4):
      elevator: Enable const sysfs attributes
      block: mq-deadline: Constify sysfs attributes
      block, bfq: constify sysfs attributes
      kyber: constify sysfs attributes

Yang Erkun (1):
      block: retry call probe after request_module in blk_request_module

Yongsoo Joo (1):
      nvme: change return type of nvme_poll_cq() to bool

Yu Kuai (7):
      nbd: don't allow reconnect after disconnect
      md: reintroduce md-linear
      md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
      md/md-bitmap: remove the last parameter for bimtap_ops->endwrite()
      md: add a new callback pers->bitmap_sector()
      md/raid5: implement pers->bitmap_sector()
      md/md-bitmap: move bitmap_{start, end}write to md upper layer

 Documentation/PCI/endpoint/index.rst             |    1 +
 Documentation/PCI/endpoint/pci-nvme-function.rst |   13 +
 Documentation/nvme/index.rst                     |   12 +
 Documentation/nvme/nvme-pci-endpoint-target.rst  |  368 +++
 Documentation/subsystem-apis.rst                 |    1 +
 arch/um/drivers/ubd_kern.c                       |    1 -
 block/Makefile                                   |    2 -
 block/bfq-iosched.c                              |    2 +-
 block/bio.c                                      |  111 +-
 block/blk-cgroup-rwstat.h                        |    5 +-
 block/blk-cgroup.h                               |   10 +-
 block/blk-core.c                                 |   21 +-
 block/blk-integrity.c                            |    4 +-
 block/blk-map.c                                  |  128 +-
 block/blk-merge.c                                |  177 +-
 block/blk-mq-cpumap.c                            |   37 +
 block/blk-mq-debugfs.c                           |   27 +-
 block/blk-mq-pci.c                               |   46 -
 block/blk-mq-sched.c                             |    3 +-
 block/blk-mq-tag.c                               |   41 +-
 block/blk-mq-virtio.c                            |   46 -
 block/blk-mq.c                                   |   71 +-
 block/blk-mq.h                                   |   11 +-
 block/blk-settings.c                             |   42 +-
 block/blk-sysfs.c                                |  140 +-
 block/blk-zoned.c                                |   65 +-
 block/blk.h                                      |   33 +-
 block/bsg-lib.c                                  |    2 +-
 block/elevator.c                                 |   35 +-
 block/elevator.h                                 |    2 +-
 block/genhd.c                                    |   63 +-
 block/kyber-iosched.c                            |    2 +-
 block/mq-deadline.c                              |    2 +-
 block/partitions/ldm.h                           |    2 +-
 drivers/ata/ahci.h                               |    2 +-
 drivers/ata/pata_macio.c                         |    2 +-
 drivers/ata/sata_mv.c                            |    2 +-
 drivers/ata/sata_nv.c                            |    4 +-
 drivers/ata/sata_sil24.c                         |    1 -
 drivers/block/amiflop.c                          |    1 -
 drivers/block/aoe/aoeblk.c                       |    1 -
 drivers/block/ataflop.c                          |    1 -
 drivers/block/floppy.c                           |    1 -
 drivers/block/loop.c                             |  178 +-
 drivers/block/mtip32xx/mtip32xx.c                |    1 -
 drivers/block/nbd.c                              |  116 +-
 drivers/block/null_blk/main.c                    |   31 +-
 drivers/block/null_blk/null_blk.h                |    1 +
 drivers/block/ps3disk.c                          |    7 +-
 drivers/block/rbd.c                              |    1 -
 drivers/block/rnbd/rnbd-clt.c                    |    3 +-
 drivers/block/rnbd/rnbd-srv.c                    |    2 +-
 drivers/block/rnull.rs                           |   30 +-
 drivers/block/sunvdc.c                           |    2 +-
 drivers/block/swim.c                             |    2 +-
 drivers/block/swim3.c                            |    3 +-
 drivers/block/ublk_drv.c                         |    1 -
 drivers/block/virtio_blk.c                       |    9 +-
 drivers/block/xen-blkfront.c                     |    1 -
 drivers/block/z2ram.c                            |    1 -
 drivers/cdrom/gdrom.c                            |    2 +-
 drivers/md/Kconfig                               |   13 +
 drivers/md/Makefile                              |    2 +
 drivers/md/bcache/movinggc.c                     |    2 +-
 drivers/md/bcache/writeback.c                    |    2 +-
 drivers/md/dm-rq.c                               |    2 +-
 drivers/md/dm-verity-fec.c                       |    6 +-
 drivers/md/dm-verity-target.c                    |    4 +-
 drivers/md/md-autodetect.c                       |    8 +-
 drivers/md/md-bitmap.c                           |  116 +-
 drivers/md/md-bitmap.h                           |    7 +-
 drivers/md/md-linear.c                           |  354 +++
 drivers/md/md.c                                  |   31 +-
 drivers/md/md.h                                  |    5 +
 drivers/md/raid0.c                               |    2 +-
 drivers/md/raid1.c                               |   36 +-
 drivers/md/raid1.h                               |    1 -
 drivers/md/raid10.c                              |   28 +-
 drivers/md/raid10.h                              |    1 -
 drivers/md/raid5-cache.c                         |   20 +-
 drivers/md/raid5.c                               |  111 +-
 drivers/md/raid5.h                               |    4 -
 drivers/memstick/core/ms_block.c                 |    3 +-
 drivers/memstick/core/mspro_block.c              |    3 +-
 drivers/mmc/core/queue.c                         |    2 +-
 drivers/mtd/mtd_blkdevs.c                        |    2 +-
 drivers/mtd/ubi/block.c                          |    2 +-
 drivers/nvme/host/apple.c                        |    2 -
 drivers/nvme/host/core.c                         |   46 +-
 drivers/nvme/host/fc.c                           |    1 -
 drivers/nvme/host/nvme.h                         |   39 -
 drivers/nvme/host/pci.c                          |   17 +-
 drivers/nvme/host/tcp.c                          |   70 +-
 drivers/nvme/target/Kconfig                      |   11 +
 drivers/nvme/target/Makefile                     |    2 +
 drivers/nvme/target/admin-cmd.c                  |  388 +++-
 drivers/nvme/target/configfs.c                   |   49 +
 drivers/nvme/target/core.c                       |  266 ++-
 drivers/nvme/target/discovery.c                  |   17 +
 drivers/nvme/target/fabrics-cmd-auth.c           |   14 +-
 drivers/nvme/target/fabrics-cmd.c                |  101 +-
 drivers/nvme/target/io-cmd-bdev.c                |    3 +
 drivers/nvme/target/nvmet.h                      |  110 +-
 drivers/nvme/target/passthru.c                   |   18 +-
 drivers/nvme/target/pci-epf.c                    | 2591 ++++++++++++++++++++++
 drivers/nvme/target/zns.c                        |    3 +-
 drivers/pci/pci-driver.c                         |   14 +
 drivers/s390/block/dasd_genhd.c                  |    1 -
 drivers/s390/block/scm_blk.c                     |    1 -
 drivers/scsi/fnic/fnic_main.c                    |    3 +-
 drivers/scsi/hisi_sas/hisi_sas.h                 |    1 -
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c           |    6 +-
 drivers/scsi/megaraid/megaraid_sas_base.c        |    3 +-
 drivers/scsi/mpi3mr/mpi3mr.h                     |    1 -
 drivers/scsi/mpi3mr/mpi3mr_os.c                  |    2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c             |    3 +-
 drivers/scsi/pm8001/pm8001_init.c                |    2 +-
 drivers/scsi/pm8001/pm8001_sas.h                 |    1 -
 drivers/scsi/qla2xxx/qla_nvme.c                  |    3 +-
 drivers/scsi/qla2xxx/qla_os.c                    |    4 +-
 drivers/scsi/scsi_lib.c                          |    5 +-
 drivers/scsi/sd.c                                |   18 +-
 drivers/scsi/smartpqi/smartpqi_init.c            |    7 +-
 drivers/scsi/sr.c                                |    5 +-
 drivers/scsi/virtio_scsi.c                       |    3 +-
 drivers/target/target_core_pscsi.c               |    6 +-
 drivers/ufs/core/ufshcd.c                        |    1 -
 drivers/usb/storage/scsiglue.c                   |    5 +-
 drivers/virtio/virtio.c                          |   19 +
 fs/bcachefs/move.c                               |    6 +-
 include/linux/bio.h                              |    5 -
 include/linux/blk-mq-pci.h                       |   11 -
 include/linux/blk-mq-virtio.h                    |   11 -
 include/linux/blk-mq.h                           |   35 +-
 include/linux/blkdev.h                           |   36 +-
 include/linux/bvec.h                             |    7 +-
 include/linux/device/bus.h                       |    3 +
 include/linux/libata.h                           |    4 +-
 include/linux/nvme.h                             |   42 +
 include/scsi/scsi_host.h                         |    6 +-
 include/uapi/linux/raid/md_p.h                   |    2 +-
 include/uapi/linux/raid/md_u.h                   |    2 +
 kernel/trace/blktrace.c                          |   36 +-
 rust/kernel/block/mq/tag_set.rs                  |    2 +-
 144 files changed, 5354 insertions(+), 1415 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
 create mode 100644 Documentation/nvme/index.rst
 create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
 delete mode 100644 block/blk-mq-pci.c
 delete mode 100644 block/blk-mq-virtio.c
 create mode 100644 drivers/md/md-linear.c
 create mode 100644 drivers/nvme/target/pci-epf.c
 delete mode 100644 include/linux/blk-mq-pci.h
 delete mode 100644 include/linux/blk-mq-virtio.h

-- 
Jens Axboe


Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F0143C69
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033129; cv=none; b=DStZ0PJCAD751hLQuZNTJv6xc1D7089L26t+qEkZF5DY90hvKxAzyxrIbguVdDZxDrB5OU0p+BojFlIM7/WRY6EhWXMB//WOMFtme0AaVg052QqgdvaTSk2xMWlcciCqtxDTOjW2YcCUiwAqWv3MwagHp4ttrTabEEWViTUTW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033129; c=relaxed/simple;
	bh=ZiDkJG17w+oo52oeuo2GYI0cMUIpFR8dPN7BErGB9ao=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=haqUX1Wz3mqqFUGtaoQO5UqmR9ebOqCpo7qLl01pVPgQQXdPHJuGtaTxMOJv27lTZsFgReteB0JGTLRVZNAD9o37pmGoUXydO9bdZ5U87L5HMu/09sqNlnohd5lc0DMg5SWykZG50r8HpdO88LYv63QFZUOdz5cUJNwKIzrJrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oT6gM4Jn; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oT6gM4Jn"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dc7c19a4c6so892395ab.0
        for <linux-block@vger.kernel.org>; Fri, 23 May 2025 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748033124; x=1748637924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oI8IQLGqaduAGIpBxkpfJ2rbhYMA1K/nHZfKwDBlr0=;
        b=oT6gM4JnkIUaqh4TmtlgI0uSvGktBIasG5X+6mw9/vwmB3R1cSbnVHmiicNYVCsyX2
         XlY8fTBavRz2OYcD0HJgO28PKA/mRfbJqT/izArSa/3ugdqicnShkUD7eS2liMohTIFJ
         RNN/HhC10fSiqV6PAGDOQkRfNqT731qqXvfJyhlYtMI5atDXoCbXdSpbXyCizldFQt9U
         Wc9r9y3bQ4VSwwDiG1uWFVANSRrO94MQr87rHWftxEBYSKeRs7UZguWJEMyvIek9erdj
         F6ixaYG0xO2+IAv5F9H1dpflPU0Bxd9glQiILItqB/Rtp0qlLDN1hO8LkErbAOTb9q5I
         2V6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748033124; x=1748637924;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2oI8IQLGqaduAGIpBxkpfJ2rbhYMA1K/nHZfKwDBlr0=;
        b=TfPk4buWmD0s+hy4LXDtk7tS54k7iidjzdp+6E6CbFHF0gQwbsm/PkUnT5gai2+b3T
         09Gdr6iHgoNWqLG3Qjga+UIK4d4BBbdNO9tIPFiXac/17NX5GajSsCwGfMerpMAS1ZcO
         4oAcoxswGZZ+TqiDQFtDq0TI2q4ft+SH/Mge9EPzQWTWYdQRU/RB5egskOJwIuDlyE1d
         kTTkmhndTEZoV3x3Tin7GzJP4JrZ4icy0/h0x2fhzBinsaVP8VqJz7rlP2aittYqiLDx
         CuHh/svZNQEbHpL0xRNIUzUzFnCbDvdpMaZmM9mfljBIlJ+jsD3ElUD+m6ldlHMsgv4p
         0fkw==
X-Gm-Message-State: AOJu0YyprDOOGUabvbcVQ0faFilEqC1CJMjF1cA4ugzLVcHwjWxFs+KW
	EvTm3y2O7rflyf+w4JiE9coE7jZJ8xWQlwFuNwCgn8p5173bEG0VFaQy98uFdGZg9ulBj7NKYus
	x+NSz
X-Gm-Gg: ASbGnctWXNCBcD6Ts1miw9i5YJMbms/D3Lj8EbsX9qYuNdfHHgBsefttj9A+76XI0gp
	fuuu6ylyIo2N7ENNmMzgVd2y2cGi3s19NaWXbUQR7+BTeldyCtvyVvcrAuWn1iC+/F39STDFUo5
	054fPsMlN5af+cZcwV6JdlnO3YKzN0w0v5BYVVTfbSDUNVa6GAPLwnXCi6TbzqZTniHuIODgjqD
	cqEuo8tCsrREhOEgkLd/dELSMgtjh7IQT16pMckhCjoBRM9qv3OdvTQOOBD/+rMbbHes34HnkNt
	xKJLaUT0tJ00PCaSCNEt7SP3p7n2NmvvzXaMOLWksap+YSNJ
X-Google-Smtp-Source: AGHT+IEHN6BPj4rcuhk0ZsnLrMpYlzT0oxCer4KjTMvJ0oeRS5L+5JyTJZKB77KJJOPh2IMOqDpBEA==
X-Received: by 2002:a05:6e02:180a:b0:3dc:854a:ef3e with SMTP id e9e14a558f8ab-3dc9b686aedmr5260795ab.8.1748033123612;
        Fri, 23 May 2025 13:45:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc85440323sm15147565ab.50.2025.05.23.13.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 13:45:22 -0700 (PDT)
Message-ID: <13d889a9-d907-4838-bc26-9fc91ace425f@kernel.dk>
Date: Fri, 23 May 2025 14:45:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 6.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are the block changes scheduled for the 6.16-rc1 kernel release.
This pull request contains:

- ublk updates
	- Add support for updating the size of a ublk instance
	- Zero-copy improvements
	- Auto-registering of buffers for zero-copy
	- Series simplifying and improving GET_DATA and request lookup
	- Series adding quiesce support
	- Lots of selftests additions
	- Various cleanups

- NVMe updates via Christoph
	- add per-node DMA pools and use them for PRP/SGL allocations
          (Caleb Sander Mateos, Keith Busch)
	- nvme-fcloop refcounting fixes (Daniel Wagner)
	- support delayed removal of the multipath node and optionally
	  support the multipath node for private namespaces (Nilay
	  Shroff)
	- support shared CQs in the PCI endpoint target code (Wilfred
	  Mallawa)
	- support admin-queue only authentication (Hannes Reinecke)
	- use the crc32c library instead of the crypto API (Eric
	  Biggers)
	- misc cleanups (Christoph Hellwig, Marcelo Moreira,
	  Hannes Reinecke, Leon Romanovsky, Gustavo A. R. Silva)

- MD updates via Yu
	- Fix that normal IO can be starved by sync IO, found by mkfs on
	  newly created large raid5, with some clean up patches for bdev
	  inflight counters.

- Series cleaning up brd, getting rid of atomic kmaps and bvec poking.

- Add loop driver specifically for zoned IO testing.

- Eliminate blk-rq-qos calls with a static key, if not enabled.

- Series improving hctx locking for when a plug has IO for multiple
  queues pending.

- Series removing block layer bouncing support, which in turn means we
  can remove the per-node bounce stat as well.

- Series improving blk-throttle support.

- Series improving delay support for blk-throttle.

- Series improving brd discard support.

- Series unifying IO scheduler switching. This should also fix a bunch
  of lockdep warnings we've been seeing, after enabling lockdep support
  for queue freezing/unfreezeing.

- Add support for block write streams via FDP (flexible data placement)
  on NVMe.

- Series adding a bunch of block helpers, facilitating the removal of a
  bunch of boilerplate code that's duplicated.

- Remove obsolete BLK_MQ pci and virtio Kconfig options.

- Add atomic/untorn write support to blktrace.

- Various little cleanups and fixes.

Please pull!


The following changes since commit 6d732e8d1e6ddc27bbdebbee48fa5825203fb4a9:

  Merge tag 'nvme-6.15-2025-05-01' of git://git.infradead.org/nvme into block-6.15 (2025-05-01 07:56:02 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.16/block-20250523

for you to fetch changes up to 533c87e2ed742454957f14d7bef9f48d5a72e72d:

  selftests: ublk: add test for UBLK_F_QUIESCE (2025-05-23 09:42:12 -0600)

----------------------------------------------------------------
for-6.16/block-20250523

----------------------------------------------------------------
Bart Van Assche (1):
      block: Simplify blk_mq_dispatch_rq_list() and its callers

Caleb Sander Mateos (17):
      ublk: remove unnecessary ubq checks
      block: take rq_list instead of plug in dispatch functions
      block: factor out blk_mq_dispatch_queue_requests() helper
      block: avoid hctx spinlock for plug with multiple queues
      ublk: fix "immepdately" typo in comment
      ublk: remove misleading "ubq" in "ubq_complete_io_cmd()"
      ublk: take const ubq pointer in ublk_get_iod()
      ublk: don't log uring_cmd cmd_op in ublk_dispatch_req()
      ublk: factor out ublk_start_io() helper
      ublk: don't call ublk_dispatch_req() for NEED_GET_DATA
      ublk: check UBLK_IO_FLAG_OWNED_BY_SRV in ublk_abort_queue()
      ublk: store request pointer in ublk_io
      ublk: consolidate UBLK_IO_FLAG_OWNED_BY_SRV checks
      nvme: fix write_stream_granularity initialization
      nvme-pci: factor out a nvme_init_hctx_common() helper
      nvme-pci: make PRP list DMA pools per-NUMA-node
      ublk: remove io argument from ublk_auto_buf_reg_fallback()

Chen Ni (1):
      cdrom: Remove unnecessary NULL check before unregister_sysctl_table()

Christoph Hellwig (51):
      brd: pass a bvec pointer to brd_do_bvec
      brd: remove the sector variable in brd_submit_bio
      brd: use bvec_kmap_local in brd_do_bvec
      brd: split I/O at page boundaries
      brd: use memcpy_{to,from]_page in brd_rw_bvec
      block: use writeback_iter
      scsi: make aha152x depend on !HIGHMEM
      scsi: make imm depend on !HIGHMEM
      scsi: make ppa depend on !HIGHMEM
      usb-storage: reject probe of device one non-DMA HCDs when using highmem
      scsi: remove the no_highmem flag in the host
      block: remove bounce buffering support
      mm: remove NR_BOUNCE zone stat
      block: look up the elevator type in elevator_switch
      block: fold elevator_disable into elevator_switch
      fs: add a write stream field to the kiocb
      block: add a bi_write_stream field
      block: introduce a write_stream_granularity queue limit
      block: expose write streams for block device nodes
      nvme: add a nvme_get_log_lsi helper
      nvme: pass a void pointer to nvme_get/set_features for the result
      nvme: add FDP definitions
      block: add a bio_add_virt_nofail helper
      block: add a bdev_rw_virt helper
      block: add a bio_add_max_vecs helper
      block: add a bio_add_vmalloc helpers
      block: remove the q argument from blk_rq_map_kern
      block: pass the operation to bio_{map,copy}_kern
      block: simplify bio_map_kern
      bcache: use bio_add_virt_nofail
      rnbd-srv: use bio_add_virt_nofail
      gfs2: use bdev_rw_virt in gfs2_read_super
      zonefs: use bdev_rw_virt in zonefs_read_super
      PM: hibernate: split and simplify hib_submit_io
      dm-bufio: use bio_add_virt_nofail
      dm-integrity: use bio_add_virt_nofail
      xfs: simplify xfs_buf_submit_bio
      xfs: simplify xfs_rw_bdev
      xfs: simplify building the bio in xlog_write_iclog
      btrfs: use bdev_rw_virt in scrub_one_super
      hfsplus: use bdev_rw_virt in hfsplus_submit_bio
      block: remove the same_page output argument to bvec_try_merge_page
      brd: avoid extra xarray lookups on first write
      blk-mq: move the DMA mapping code to a separate file
      blk-mq: add a copyright notice to blk-mq-dma.c
      nvme-pci: don't try to use SGLs for metadata on the admin queue
      nvme-pci: remove struct nvme_descriptor
      nvme-pci: rename the descriptor pools
      nvme-pci: use a better encoding for small prp pool allocations
      nvme-pci: use struct_size for allocation struct nvme_dev
      nvme-pci: derive and better document max segments limits

Damien Le Moal (2):
      block: new zoned loop block device driver
      Documentation: Document the new zoned loop block device driver

Daniel Wagner (14):
      nvmet-fcloop: track ref counts for nports
      nvmet-fcloop: remove nport from list on last user
      nvmet-fcloop: refactor fcloop_nport_alloc and track lport
      nvmet-fcloop: refactor fcloop_delete_local_port
      nvmet-fcloop: update refs on tfcp_req
      nvmet-fcloop: access fcpreq only when holding reqlock
      nvmet-fcloop: prevent double port deletion
      nvmet-fcloop: allocate/free fcloop_lsreq directly
      nvmet-fcloop: drop response if targetport is gone
      nvmet-fc: free pending reqs on tgtport unregister
      nvmet-fc: take tgtport refs for portentry
      nvmet-fcloop: add missing fcloop_callback_host_done
      nvmet-fcloop: don't wait for lport cleanup
      nvme-fc: do not reference lsrsp after failure

Eric Biggers (1):
      nvmet-tcp: switch to using the crc32c library

Gustavo A. R. Silva (1):
      nvme-loop: avoid -Wflex-array-member-not-at-end warning

Hannes Reinecke (6):
      nvme-tcp: remove redundant check to ctrl->opts
      nvme-tcp: open-code nvme_tcp_queue_request() for R2T
      nvme-auth: do not re-authenticate queues with no prior authentication
      nvmet-auth: authenticate on admin queue only
      nvme-auth: use SHASH_DESC_ON_STACK
      nvmet-auth: use SHASH_DESC_ON_STACK

Jens Axboe (7):
      block: ensure that struct blk_mq_alloc_data is fully initialized
      block: blk-rq-qos: guard rq-qos helpers by static key
      Merge branch 'block-6.15' into for-6.16/block
      Merge branch 'block-6.15' into for-6.16/block
      Merge tag 'md-6.16-20250513' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.16/block
      block/blk-throttle: silence !BLK_DEV_IO_TRACE variable warnings
      Merge tag 'nvme-6.16-2025-05-20' of git://git.infradead.org/nvme into for-6.16/block

Johannes Thumshirn (1):
      block: only update request sector if needed

Kanchan Joshi (1):
      nvme: fix incorrect sizeof

Keith Busch (5):
      block: introduce max_write_streams queue limit
      io_uring: enable per-io write streams
      nvme: register fdp parameters with the block layer
      nvme: use fdp streams if write stream is provided
      dmapool: add NUMA affinity support

Leon Romanovsky (2):
      nvme-pci: store aborted state in flags variable
      nvme-pci: add a symolic name for the small pool size

Lukas Bulwahn (1):
      block: Remove obsolete configs BLK_MQ_{PCI,VIRTIO}

Marcelo Moreira (1):
      nvmet: replace strncpy with strscpy

Ming Lei (40):
      block: move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue()
      block: move ELEVATOR_FLAG_DISABLE_WBT a request queue flag
      block: don't call freeze queue in elevator_switch() and elevator_disable()
      block: use q->elevator with ->elevator_lock held in elv_iosched_show()
      block: add two helpers for registering/un-registering sched debugfs
      block: move sched debugfs register into elvevator_register_queue
      block: add helper add_disk_final()
      block: prevent adding/deleting disk during updating nr_hw_queues
      block: don't allow to switch elevator if updating nr_hw_queues is in-progress
      block: move blk_queue_registered() check into elv_iosched_store()
      block: simplify elevator reattachment for updating nr_hw_queues
      block: move queue freezing & elevator_lock into elevator_change()
      block: add `struct elv_change_ctx` for unifying elevator change
      block: unifying elevator change
      block: pass elevator_queue to elv_register_queue & unregister_queue
      block: remove elevator queue's type check in elv_attr_show/store()
      block: fail to show/store elevator sysfs attribute if elevator is dying
      block: add new helper for disabling elevator switch when deleting disk
      block: move elv_register[unregister]_queue out of elevator_lock
      block: move hctx debugfs/sysfs registering out of freezing queue
      block: don't acquire ->elevator_lock in blk_mq_map_swqueue and blk_mq_realloc_hw_ctxs
      block: move hctx cpuhp add/del out of queue freezing
      block: move wbt_enable_default() out of queue freezing from sched ->exit()
      block: fix warning on 'make htmldocs'
      fs: aio: initialize .ki_write_stream of read-write request
      block: don't quiesce queue for calling elevator_set_none()
      block: move removing elevator after deleting disk->queue_kobj
      selftests: ublk: make IO & device removal test more stressful
      ublk: convert to refcount_t
      ublk: prepare for supporting to register request buffer automatically
      ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG
      ublk: support UBLK_AUTO_BUF_REG_FALLBACK
      selftests: ublk: support UBLK_F_AUTO_BUF_REG
      selftests: ublk: add test for covering UBLK_AUTO_BUF_REG_FALLBACK
      ublk: handle ublk_set_auto_buf_reg() failure correctly in ublk_fetch()
      io_uring: add helper io_uring_cmd_ctx_handle()
      ublk: run auto buf unregisgering in same io_ring_ctx with registering
      selftests: ublk: add test case for UBLK_U_CMD_UPDATE_SIZE
      ublk: add feature UBLK_F_QUIESCE
      selftests: ublk: add test for UBLK_F_QUIESCE

Nilay Shroff (5):
      block: unfreeze queue if realloc tag set fails during nr_hw_queues update
      block: fix elv_update_nr_hw_queues() to reattach elevator
      nvme-multipath: introduce delayed removal of the multipath head node
      nvme: introduce multipath_always_on module param
      nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk

Omri Mann (1):
      ublk: Add UBLK_U_CMD_UPDATE_SIZE

Ritesh Harjani (IBM) (1):
      traceevent/block: Add REQ_ATOMIC flag to block trace events

Uday Shankar (4):
      ublk: factor out ublk_commit_and_fetch
      selftests: ublk: kublk: build with -Werror iff WERROR!=0
      selftests: ublk: make test_generic_06 silent on success
      selftests: ublk: kublk: fix include path

Wilfred Mallawa (5):
      nvmet: add a helper function for cqid checking
      nvmet: cq: prepare for completion queue sharing
      nvmet: fabrics: add CQ init and destroy
      nvmet: support completion queue sharing
      nvmet: simplify the nvmet_req_init() interface

Yu Kuai (12):
      brd: protect page with rcu
      brd: fix aligned_sector from brd_do_discard()
      brd: fix discard end sector
      blk-mq: remove blk_mq_in_flight()
      block: reuse part_in_flight_rw for part_in_flight
      block: WARN if bdev inflight counter is negative
      block: clean up blk_mq_in_flight_rw()
      block: export API to get the number of bdev inflight IO
      md: record dm-raid gendisk in mddev
      md: add a new api sync_io_depth
      md: fix is_mddev_idle()
      md: clean up accounting for issued sync IO

Zizhi Wo (10):
      blk-throttle: Fix wrong tg->[bytes/io]_disp update in __tg_update_carryover()
      blk-throttle: Delete unnecessary carryover-related fields from throtl_grp
      blk-throttle: Add an additional overflow check to the call calculate_bytes/io_allowed
      blk-throttle: Rename tg_may_dispatch() to tg_dispatch_time()
      blk-throttle: Refactor tg_dispatch_time by extracting tg_dispatch_bps/iops_time
      blk-throttle: Split throtl_charge_bio() into bps and iops functions
      blk-throttle: Introduce flag "BIO_TG_BPS_THROTTLED"
      blk-throttle: Split the blkthrotl queue
      blk-throttle: Split the service queue
      blk-throttle: Prevents the bps restricted io from entering the bps queue again

 Documentation/ABI/stable/sysfs-block          |   15 +
 Documentation/admin-guide/blockdev/index.rst  |    1 +
 .../admin-guide/blockdev/zoned_loop.rst       |  169 ++
 MAINTAINERS                                   |    8 +
 arch/mips/configs/gcw0_defconfig              |    1 -
 block/Kconfig                                 |    8 -
 block/Makefile                                |    5 +-
 block/bfq-iosched.c                           |    6 +-
 block/bio-integrity.c                         |    4 +-
 block/bio.c                                   |  158 +-
 block/blk-core.c                              |    2 +-
 block/blk-crypto-fallback.c                   |    1 +
 block/blk-map.c                               |   93 +-
 block/blk-merge.c                             |  137 +-
 block/blk-mq-debugfs.c                        |   13 +-
 block/blk-mq-dma.c                            |  116 ++
 block/blk-mq-sched.c                          |   53 +-
 block/blk-mq.c                                |  309 ++--
 block/blk-mq.h                                |    7 +-
 block/blk-rq-qos.c                            |    4 +
 block/blk-rq-qos.h                            |   21 +-
 block/blk-settings.c                          |    5 -
 block/blk-sysfs.c                             |   34 +-
 block/blk-throttle.c                          |  411 +++--
 block/blk-throttle.h                          |   36 +-
 block/blk-wbt.c                               |    9 +-
 block/blk.h                                   |   50 +-
 block/bounce.c                                |  267 ----
 block/elevator.c                              |  329 ++--
 block/elevator.h                              |    6 +-
 block/fops.c                                  |   28 +-
 block/genhd.c                                 |  266 ++--
 block/mq-deadline.c                           |    2 +-
 drivers/base/node.c                           |    2 +-
 drivers/block/Kconfig                         |   19 +
 drivers/block/Makefile                        |    1 +
 drivers/block/brd.c                           |  225 +--
 drivers/block/pktcdvd.c                       |    2 +-
 drivers/block/rnbd/rnbd-srv.c                 |    7 +-
 drivers/block/ublk_drv.c                      |  569 +++++--
 drivers/block/virtio_blk.c                    |    4 +-
 drivers/block/zloop.c                         | 1385 +++++++++++++++++
 drivers/cdrom/cdrom.c                         |    3 +-
 drivers/md/bcache/super.c                     |    3 +-
 drivers/md/dm-bufio.c                         |    2 +-
 drivers/md/dm-integrity.c                     |   16 +-
 drivers/md/dm-raid.c                          |    3 +
 drivers/md/md.c                               |  190 ++-
 drivers/md/md.h                               |   18 +-
 drivers/md/raid1.c                            |    3 -
 drivers/md/raid10.c                           |    9 -
 drivers/md/raid5.c                            |    8 -
 drivers/nvme/common/auth.c                    |   15 +-
 drivers/nvme/host/auth.c                      |   30 +-
 drivers/nvme/host/core.c                      |  205 ++-
 drivers/nvme/host/fc.c                        |   13 +-
 drivers/nvme/host/multipath.c                 |  206 ++-
 drivers/nvme/host/nvme.h                      |   31 +-
 drivers/nvme/host/pci.c                       |  300 ++--
 drivers/nvme/host/sysfs.c                     |    7 +
 drivers/nvme/host/tcp.c                       |   14 +-
 drivers/nvme/target/admin-cmd.c               |   31 +-
 drivers/nvme/target/auth.c                    |   21 +-
 drivers/nvme/target/core.c                    |   94 +-
 drivers/nvme/target/discovery.c               |    2 +-
 drivers/nvme/target/fabrics-cmd.c             |   12 +-
 drivers/nvme/target/fc.c                      |   96 +-
 drivers/nvme/target/fcloop.c                  |  439 ++++--
 drivers/nvme/target/loop.c                    |   29 +-
 drivers/nvme/target/nvmet.h                   |   24 +-
 drivers/nvme/target/pci-epf.c                 |   14 +-
 drivers/nvme/target/rdma.c                    |    8 +-
 drivers/nvme/target/tcp.c                     |  100 +-
 drivers/scsi/Kconfig                          |    3 +
 drivers/scsi/aha152x.c                        |    1 -
 drivers/scsi/imm.c                            |    1 -
 drivers/scsi/ppa.c                            |    1 -
 drivers/scsi/scsi_ioctl.c                     |    2 +-
 drivers/scsi/scsi_lib.c                       |    6 +-
 drivers/usb/storage/usb.c                     |   20 +-
 fs/aio.c                                      |    1 +
 fs/btrfs/scrub.c                              |   10 +-
 fs/gfs2/ops_fstype.c                          |   24 +-
 fs/hfsplus/wrapper.c                          |   46 +-
 fs/proc/meminfo.c                             |    3 +-
 fs/xfs/xfs_bio_io.c                           |   30 +-
 fs/xfs/xfs_buf.c                              |   43 +-
 fs/xfs/xfs_log.c                              |   32 +-
 fs/zonefs/super.c                             |   34 +-
 include/linux/bio.h                           |   25 +-
 include/linux/blk-mq.h                        |   10 +-
 include/linux/blk_types.h                     |   10 +-
 include/linux/blkdev.h                        |   24 +-
 include/linux/dmapool.h                       |   21 +-
 include/linux/fs.h                            |    1 +
 include/linux/io_uring/cmd.h                  |    9 +
 include/linux/mmzone.h                        |    1 -
 include/linux/nvme.h                          |   77 +
 include/linux/part_stat.h                     |    2 +
 include/scsi/scsi_host.h                      |    2 -
 include/trace/events/block.h                  |   17 +-
 include/uapi/linux/blktrace_api.h             |    2 +-
 include/uapi/linux/io_uring.h                 |    4 +
 include/uapi/linux/ublk_cmd.h                 |  128 ++
 io_uring/io_uring.c                           |    2 +
 io_uring/rw.c                                 |    1 +
 kernel/power/swap.c                           |  103 +-
 kernel/trace/blktrace.c                       |   11 +-
 mm/dmapool.c                                  |   15 +-
 mm/show_mem.c                                 |    4 +-
 tools/testing/selftests/ublk/Makefile         |   11 +-
 tools/testing/selftests/ublk/fault_inject.c   |    5 +
 tools/testing/selftests/ublk/file_backed.c    |   17 +-
 tools/testing/selftests/ublk/kublk.c          |  153 +-
 tools/testing/selftests/ublk/kublk.h          |   22 +-
 tools/testing/selftests/ublk/null.c           |   55 +-
 tools/testing/selftests/ublk/stripe.c         |   26 +-
 tools/testing/selftests/ublk/test_common.sh   |   39 +-
 .../testing/selftests/ublk/test_generic_04.sh |    2 +-
 .../testing/selftests/ublk/test_generic_05.sh |    2 +-
 .../testing/selftests/ublk/test_generic_06.sh |    2 +-
 .../testing/selftests/ublk/test_generic_08.sh |   32 +
 .../testing/selftests/ublk/test_generic_09.sh |   28 +
 .../testing/selftests/ublk/test_generic_10.sh |   30 +
 .../testing/selftests/ublk/test_generic_11.sh |   44 +
 .../testing/selftests/ublk/test_stress_02.sh  |   10 +-
 .../testing/selftests/ublk/test_stress_03.sh  |    7 +
 .../testing/selftests/ublk/test_stress_04.sh  |    7 +
 .../testing/selftests/ublk/test_stress_05.sh  |    9 +
 129 files changed, 5491 insertions(+), 2470 deletions(-)
 create mode 100644 Documentation/admin-guide/blockdev/zoned_loop.rst
 create mode 100644 block/blk-mq-dma.c
 delete mode 100644 block/bounce.c
 create mode 100644 drivers/block/zloop.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_09.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_10.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_11.sh

-- 
Jens Axboe


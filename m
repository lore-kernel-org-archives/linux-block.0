Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34B1DE4E0
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171445; cv=none; b=mEeojLXjj2ngq7xU0QXsjcOASAt7b1TlA2tBJZaKeY9M0AWwVrqsp6H1OTab70CZJglwMtJzUR5dtCdxzRiR6RubVdD9P4b3IWL7aBYmnXPc7kmiZ3tOZQpNUbSULdHEIKGMzGZzhq47zbSmH0JUY+Wcqu4C15ujzMG/DgwE56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171445; c=relaxed/simple;
	bh=gKXM/eg82d7SUJ+ZOsVp3kyPA7YvRiQD1f2HfNSEVtQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uf/++ncZMK7Egt6Fg1aP3U9gY11CWPA3ErvbaGoi31TWmzVo+pXnsWU8OZqvhCTP+9jOyOZwZvWvJhEp0odKMT4kDMWlQwBX0Qzu1loqSGrg7zs2IT2PG4ZQhc9gVeHGrVAtwQwO+5QaYk4ZyRn/aPrnXDur24wjMxxjfd9468Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=l24qy8nI; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="l24qy8nI"
Received: by mail-oi2-f10.google.com with SMTP id 006d021491bc7-6b13752e134so382398eaf.1
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1787171440; x=1787776240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5xGoX4CAJ3uvAErXhTtvd+LKH4h4KjalQXryLTj36L8=;
        b=l24qy8nIS6MBvHxXkte595NfBw+yPeKeD94L8Xzp6Lws+k4IIXrJyvPtE1sbq2oPMj
         60uQiAk3OZubanFlpxklGeICHTXFQqBcbtSnNNbu0aQfqZ2GMwZ7O3aoRIKfXzGepj3T
         eOx2oERwbnxxHGnm3P/cBY9udX/qr9DFwWbDy/MuGXaAR6Al+mbL8jMZNlSYx+Fa8ZB6
         JR2EfFC2TtfUWtuReCnsRKDKr8VTWEJpeJeqbA+dQImExsLp7BeDOcsvK9zuxK2ahzff
         1pkkx9xUeTsTGapZYwAj5rgKygcGFnxUYFJ6YkKbQa+ty2k8MfRaemwqlA/AdkT06cty
         Cdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787171440; x=1787776240;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xGoX4CAJ3uvAErXhTtvd+LKH4h4KjalQXryLTj36L8=;
        b=DqpDUsVA5DXeCV2b82grv5K11uVCjt4ZCdS/u6KLsKc3AzYcA2WJmOJdBALPQSkwm0
         jxTjaqCinz4F62Y9BKoxThPzlmvEtgHuBILgT+F0rdiPNMSXeBoMrGFBPu8jyYkv1Z2j
         O1MpJIeBOElH7neTN7Q70kAduaiA5EnKvlRkNp2C37N/1ECa6jZM8QOroIUhKdyHBVwc
         kHPL0oJK2rdcn4Dp/IUoKb2uM3d+mxyq/6sVOmig3QA3kflACXYA9jtc9GOqZcsUkho7
         kZYlGLMyK4UsTtOlPTwusn9ytpcr/Gre78G9RKgH1FwcG9qJlohbg4ETjy7xxRT9jBYD
         figA==
X-Gm-Message-State: AOJu0YwusLRn6ATb49uoQfQzAxrX70QYc09/lgMfV74jQON1TsTGRme7
	yX7PvcI42MKrLX99zyUvBl5WzSHaJp2F0i8CWAtOaQG838u9/x9phClSq4mlVMr9+uyBcHnVQwK
	fJCe+yVqneL5Z
X-Gm-Gg: AR+sD13Zmc5TDUg/eP7DSgiQvrJ7QHCUeivAvG9L/NL1/jH5wrqvC06ixrjFRi3E3zT
	bifM8HG2rsey8B/VU33MCciCjCROeXqSUUqOZl72wN18pKNyWVqV0G/HDYsNoxt5d3dDdQGNCzJ
	nSno4vXFlDEXNq3wmRz6K/3OcorsXjkHgiiMDqlkT0pHYcJ8LRmfrcei7w/Dx8v4eRMR5RB2I2x
	h83XQhvd3hLxDtmvEWkZ6Xc62D70QfQSQENp/2Jh2FTyrvYQlYz9+3DwXFgtGOKvq9dy3mHDoQX
	ZoBfDA149QRGV+BasYhK6SvPLWiBSu9ji0CgS5hCgdrv9ntpfWPGSK/0d3xlzTUTWUwk/nlMfq2
	cBoUAqEJC6JcjQOHgTH/lpd+PPD625gLpsMb/uSNPy0Ui0oM5t/Wj4ERL6FKKLj1e90RSYgpWqV
	+VBQRgfQoX2+HzqbeS9vTSNOJeI/LHeUelD6u/3zvFsi3mw4ZWrbXMAvJwIAdCEPbEZatCfMA3y
	RT7z652NfNazdNEI8qcJxpFxRbwH2L/TiTR+mv0B6t2/bIGwO8xrKh9
X-Received: by 2002:a05:6820:150b:b0:6aa:1633:7af9 with SMTP id 006d021491bc7-6b13c6a0becmr6945646eaf.35.1787171440311;
        Wed, 19 Aug 2026 13:30:40 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f440023019sm2706247a34.15.2026.08.19.13.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 13:30:38 -0700 (PDT)
Message-ID: <8787a176-6f4b-47fc-a309-867acf9fbdff@kernel.dk>
Date: Wed, 19 Aug 2026 14:30:37 -0600
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
Subject: [GIT PULL] Block updates for 7.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The bulk of this is NVMe and MD, both via merges, but the core block
changes are the more interesting part. In detail:

- NVMe updates via Keith:
       - Enable Clang context analysis for the nvme host driver, adding
         context annotations across core, fabrics, rdma, tcp and pci
       - nvmet reservation state exposed through a new namespace-level
         debugfs directory, plus ABI documentation for the host sysfs
         and target configfs interfaces
       - nvme-tcp host memory disclosure fixes on the read path: reject a
         read that transferred too few bytes, don't accept C2HData based
         on blk_rq_payload_bytes() alone, and fix the R2T case for a read
         command
       - Parallelize nvme-rdma I/O queue allocation and startup (Surabhi)
       - Apple nvme fixes and quirks: page aligned admin queue buffers,
         destroy the admin queue on removal, and various DMA/NVMMU
         correctness fixes
       - A large pile of nvmet and host fixes for out-of-bounds reads,
         refcount/resource leaks, and NULL derefs across auth, zns,
         passthru, pci-epf, rdma and configfs
       - Various other fixes and cleanups

- MD updates via Yu Kuai:
       - llbitmap reshape support, the large series wiring exact bitmap
         mapping and reshape lifecycle through raid5 and raid10, growing
         the page cache in place, and remapping checkpointed bits as
         reshape progresses
       - raid5 fixes for lockless max_nr_stripes and recovery_offset
         accesses, a reshape deadlock with more failed devices than max
         degraded, and bitmap batch counter consistency
       - Atomic write handling for raid1/raid10, and removal of the
         REQ_NOWAIT support from raid1/10/456
       - raid5-ppl use-after-free fix in ppl_do_flush()
       - A batch of smaller fixes across md core and the bitmap code

- s390/dasd ESE full-track write support and the surrounding
  infrastructure, plus enabling CONTEXT_ANALYSIS for s390/block

- RWF_DONTCACHE support for block devices, built on new task-context
  bio completion infrastructure, and wiring it up for the iomap and
  buffer dropbehind writeback paths

- Async io_uring zone reset all, plus zone management command cleanups
  allowing REQ_NOWAIT and tightening conventional zone rejection

- Block integrity refactoring: lift BIP_CHECK_FLAGS to the shared
  header, handle nogenerate/noverify properly in fs-integrity, and
  drop the blk-integrity.h include from bdev.c

- Split out a new blk_plug.h header

- ublk improvements: add UBLK_F_IO_DESC_SIZE, split request validation
  from io_desc init, reject non-power-of-2 zone sizes in SET_PARAMS,
  and a series of hardening fixes around map/unmap and auto buf reg

- null_blk cleanups and configfs serialization fixes

- nbd queue freeze removal on the setup paths, and a new
  pre_defined_connections module parameter for pre-created devices

- blk-cgroup fixes for the race between policy activation and blkg
  destruction, and accounting per-cpu stats over possible CPUs across
  blk-stat, iolatency, iocost and kyber

- Various dio fixes: leak on metadata mapping error, validate user
  space vectors during extraction, and set dma_alignment from the
  backing file for loop and zloop direct I/O

- bio cleanups

- Various other fixes and cleanups all over

Note: it'll merge cleanly to current master, but due to changes in the
XFS tree, fs/iomap/direct-io.c will fail to build. See:

https://lore.kernel.org/all/anDHU9Wc-EGV1KYL@sirena.org.uk/

for the one-liner required.

Please pull!


The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.3/block-20260819

for you to fetch changes up to 326d49039c10b65522ac7277b19b9b5c42ed1aeb:

  nbd: add pre_defined_connections module parameter for pre-created devices (2026-08-15 20:01:20 -0600)

----------------------------------------------------------------
for-7.3/block-20260819

----------------------------------------------------------------
Abd-Alrhman Masalkhi (5):
      md: remove REQ_NOWAIT support from raid1/10/456
      md: recheck spare changes before starting sync
      md/raid1: restrict atomic write limits and handle runtime constraints
      md/raid10: consistently fail atomic writes that require splitting
      md/raid10: remove unnecessary barrier around bio_submit_split_bioset()

Bart Van Assche (1):
      loop: Fix recently introduced lock inversion

Bruce Johnston (1):
      md/raid1: don't set array_frozen in raid1_takeover()

Bryam Vargas (1):
      nvmet-auth: zero the AUTH_RECEIVE response buffer

Caleb Sander Mateos (11):
      ublk: check import_ubuf() return value
      ublk: check for ublk_unmap_io() returning 0
      ublk: remove WARN_ON_ONCE() in ublk_unmap_io()
      ublk: consistently use u16 for queue and tag numbers
      ublk: remove struct ublk_zoned_report_desc's operation field
      ublk: split request validation from io_desc init
      ublk: initialize io_desc on daemon task
      ublk: add UBLK_F_IO_DESC_SIZE
      selftests: ublk: add support for --io_desc_size
      selftests: ublk: add UBLK_F_IO_DESC_SIZE test
      ublk: lift checks out of ublk_{,un}map_io()

Chao Shi (2):
      nvme: reject passthrough of driver-managed Set Features
      nvme: ratelimit the completion-path messages driven by device data

Chen Cheng (10):
      md/raid5: protect bitmap batch counters aka seq_flush/seq_write consistency
      md/raid1: protect sequential read hints for read balance
      md/raid5: fix lockless max_nr_stripes reads
      md/raid5: fix reshape deadlock while failed devices more than max degraded
      md/raid5: protect lockless recovery_offset accesses during reshape
      md: suspend array when sync_action=reshape
      md/raid10: resize r10bio_pool for reshape
      md/raid10: free r10bio before ending master_bio in raid_end_bio_io() and raid_end_discard_bio()
      md/bitmap: resume array on backlog_store() error path
      md: scope memalloc_noio to allocation critical sections

Christoph Hellwig (11):
      block: remove a dead return statement in blk_zone_plug_bio
      block: allow REQ_NOWAIT zone management commands
      block: remove blk_zone_wplug_handle_zone_mgmt
      block: also reject zone open / close on conventional zones
      block: remove most blkdev_cmd_discard arguments
      block: implement async io_uring zone reset all
      block: split out a new blk_plug.h header
      block: remove bip_should_check
      block: lift BIP_CHECK_FLAGS to include/linux/bio-integrity.h
      block: handle nogenerate/noverify properly in fs-integrity
      block: don't include blk-integrity.h in bdev.c

Coly Li (1):
      md: do overflow check for sb->bblog_shift in super_1_load()

Dmitry Bogdanov (1):
      nvme-tcp: fix usage of page_frag_cache

Eric Biggers (1):
      nvme-auth: Avoid C=1 warning in nvme_auth_derive_tls_psk()

Ewan D. Milne (1):
      nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue deletion in error path

Geliang Tang (1):
      nvme-tcp: look up host_iface in the current netns

Genjian Zhang (1):
      md/raid5: complete discard bios while reshape is active

Greg Kroah-Hartman (1):
      nvmet-tcp: Do not WARN on remotely-controlled oversized SGL allocations

Gui-Dong Han (1):
      nvme-apple: Use acquire/release for queue enabled state

Guixin Liu (16):
      nvme: fix typos in reservation related constants
      nvmet: add namespace-level debugfs directory
      nvmet: expose reservation state through debugfs
      nvme: add ABI documentation for host sysfs interfaces
      nvmet: add ABI documentation for target configfs interfaces
      MAINTAINERS: add missing NVMe documentation files
      nvmet: fix return status of RMI log page on allocation failure
      nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure in init_request
      nvme-pci: return error when parsing a quirk string fails
      nvmet: reject out-of-range mdts values in configfs store
      nvmet: fix NULL pointer dereference in nvmet_execute_identify_nslist()
      nvmet: propagate percpu_ref_init() failure in nvmet_ns_enable()
      nvme-pci: release descriptor pools on probe failure
      nvme: raise FDP placement handle cap to U8_MAX and warn on overflow
      nvmet: fix heap out-of-bounds read in nvmet_auth_negotiate()
      nvmet: fix NULL pointer dereference in nvmet_execute_identify_ns_zns()

Hari Mishal (3):
      nvme: bound ns descriptor header and body to identify buffer
      nvme: clamp FDP nruhsd to allocated RUH status descriptor count
      nvmet: passthru: fix OOB reads when parsing ns id descriptor list

Heiko Carstens (2):
      s390/dasd: Add __context_unsafe() attribute to various functions
      s390/block: Enable CONTEXT_ANALYSIS

Hiroshi Nishida (1):
      md: widen badblock sectors param from int to sector_t

Hongfu Li (1):
      block/mq-deadline: Drop unused dd parameters

Hongyan Xu (1):
      block: mtip32xx: synchronize ioctls with device removal

Ibrahim Hashimov (1):
      nvmet-tcp: bound SGL data length before allocating command buffers

Jens Axboe (2):
      Merge tag 'nvme-7.3-2026-08-13' of git://git.infradead.org/nvme into for-7.3/block
      Merge tag 'md-7.3-20260809' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-7.3/block

Jiang HongHui (1):
      nvmet-fc: fix invalid free in LS IOD error path

John Garry (5):
      nvme: handle positive error codes in nuse_show()
      nvme: swap synchronization ordering in nvme_remove_head()
      nvme: don't reference NS after unlocking in nvme_ns_head_ctrl_ioctl()
      nvme: add nvme_get_ns_head()
      nvme: fix cdev lifetime

Keith Busch (5):
      block: use blkdev_iov_iter_get_pages status for errors
      block: fix dio leak on metadata mapping error
      loop: set dma_alignment from the backing file for direct I/O
      zloop: set dma_alignment from the backing files for direct I/O
      block: validate user space vectors during extraction

Long Li (1):
      nbd: simplify find_fallback() by removing redundant logic

Marco Elver (1):
      list: Permit context-unguarded access with list_empty_careful()

Marek Szyprowski (1):
      blk-mq: add missing call to srcu_barrier() in blk_mq_free_tag_set()

Martin Wilck (1):
      md/raid1: create serial pool adding rdev to array with serialize_policy=1

Maurizio Lombardi (1):
      nvmet: fix max_qid race between configfs and controller allocation

Myeonghun Pak (1):
      nvme-pci: disable controller on admin queue IRQ setup failure

Nathan Chancellor (1):
      swim3: Add missing MODULE_DESCRIPTION

Niklas Cassel (1):
      null_blk: serialize configfs attribute updates with device setup

Nilay Shroff (19):
      list: introduce LIST_HEAD_GUARDED
      nvme: update nvme_passthru_end() signature
      nvme: add context annotations for nvme_passthru_{start|stop}
      nvme: add context annotations for nvme_ns_head::srcu
      nvme: remove redundant initialization of nvme_ns_head::requeue_list
      nvme: add context annotations for nvme_ns_head::requeue_list
      nvme: add context annotations for nvme_ns_head::current_path
      nvme: add context annotations for nvme_dev::shutdown_lock
      nvme: remove redundant initialization of delayed_removal_secs
      nvme: add context annotations for nvme_subsystem::lock
      nvme: add context annotations for nvme_ctrl::ana_lock
      nvme: add context annotations for nvme_subsystems_lock
      nvme: add context annotations in fabric.c
      nvme: add context annotations for nvme_queue::sq_lock
      nvme: add context annotations in rdma.c
      nvme: fix context analysis warning in rdma.c
      nvme: add context annotations in tcp.c
      nvme: fix context analysis warning in tcp.c
      nvme: enable context analysis support for nvme host driver

Pan Chuang (1):
      nvme-apple: Remove redundant dev_err_probe()

Pavel Begunkov (3):
      block: rename bi_bvec_done
      block: move bvec init into __bio_clone
      block: introduce bio_iov_iter_set()

Rik van Riel (1):
      null_blk: fix UBSAN shift-out-of-bounds when zone_size is 0 or overflows

Sajal Gupta (1):
      md/raid5-ppl: fix use-after-free in ppl_do_flush()

Shin'ichiro Kawasaki (3):
      nvmet-rdma: factor out response resource cleanup
      nvmet-rdma: fix response resource leak on queue teardown
      nvmet: pci-epf: fix use-after-free in nvmet_pci_epf_exec_iod_work()

Stefan Haberland (19):
      s390/dasd: Do not complete a failed ESE read as successful
      s390/dasd: Propagate partial completion length across ERP recovery
      s390/dasd: Guard sysfs discipline callbacks against unallocated private data
      s390/dasd: Snapshot intrc before freeing the request block
      s390/dasd: Optimize max blocks per request for track alignment
      s390/dasd: Use GFP_KERNEL in dasd_alloc_device()
      s390/dasd: Add defines for the Extended Address Volume track address
      s390/dasd: Add infrastructure for ESE full-track write
      s390/dasd: Add range-based format-track collision detection
      s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
      s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()
      s390/dasd: Use WRITE_FULL_TRACK in ESE format handler
      s390/dasd: Add full_track_bias to control fulltrack write mode
      s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias
      s390/dasd: Stamp a format label into newly formatted volumes
      s390/dasd: Detect ESE volumes from the on-disk format label
      s390/dasd: Report ESE capability and format mode at device online
      s390/dasd: Re-enable discard support for ESE volumes
      s390/dasd: Read cached unit address and LSS in the CCW build path

Surabhi Gogte (2):
      nvme-rdma: refactor nvme_rdma_alloc_queue() to take a queue pointer
      nvme-rdma: parallelize I/O queue allocation and startup

Sven Peter (6):
      nvme-apple: Destroy the admin queue on removal
      nvme-apple: Don't set a DMA direction for commands without a data transfer
      nvme-apple: Never set the opcode in the NVMMU TCB
      nvme: Add a quirk for page aligned admin queue buffers
      nvme-apple: Require page aligned buffers on the admin queue
      nvme-apple: Drop the PRP null check chicken bit

Tal Zussman (6):
      block: introduce bio_in_atomic()
      block: add task-context bio completion infrastructure
      iomap: use BIO_COMPLETE_IN_TASK for dropbehind writeback
      buffer: set BIO_COMPLETE_IN_TASK for dropbehind writeback
      block: enable RWF_DONTCACHE for block devices
      xfs: avoid double deferrals for RWF_DONTCACHE writes

Tao Cui (8):
      block/blk-cgroup-rwstat: use data_race() for online test
      block/blk-stat: drain per-cpu callback stats over possible CPUs
      block/blk-iolatency: account per-cpu latency stats over possible CPUs
      block/blk-iocost: collect per-cpu latency stats over possible CPUs
      block/kyber-iosched: flush per-cpu latency buckets over possible CPUs
      blk-throttle: remove dead field last_check_time from throtl_grp
      block/bfq-cgroup: use data_race() for online test
      block/blk-iocost: annotate ioc_pd_stat reads with data_race()

Usama Arif (3):
      blk-iolatency: clear delay state when freeing policy data
      blk-iocost: clear delay state when freeing policy data
      block: skip blkcg walk in blk_cgroup_congested() when nothing throttled

Wale Zhang (1):
      md: skip discard on unsupported member devices

Xixin Liu (4):
      nvme: zns: cap zone report nr_zones by DMA buffer size
      nvme: zns: include zone index in invalid zone type error
      nvme-auth: use crypto_memneq for DH-HMAC-CHAP response comparison
      nvmet: zns: reject full zone report when buffer is too small

Xu Rao (2):
      zloop: truncate finished zones to zone capacity
      Documentation: block: zloop: clarify capacity alignment

Yang Erkun (7):
      nbd: disallow NBD_SET_SOCK on an active device
      nbd: clear queue limits on disconnect
      nbd: remove queue freeze in nbd_add_socket
      nbd: skip queue freeze when setting size at device startup
      nbd: factor out a nbd_genl_foreach_sock
      nbd: remove queue freeze for newly created nbd from netlink path
      nbd: add pre_defined_connections module parameter for pre-created devices

Yang Xiuwei (4):
      nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()
      ublk: validate auto buf reg before taking uring_cmd
      selftests: ublk: add rotating auto_buf index regression test
      ublk: clear auto buf reg before updating io->buf in batch commit

Yao Sang (5):
      nvme-multipath: revalidate zones for namespace heads
      ublk: reject non-power-of-2 zone sizes in SET_PARAMS
      selftests: ublk: add helper for SET_PARAMS
      selftests: ublk: add SET_PARAMS validation test
      ublk: avoid teardown retry loop on xarray allocation failure

Yehyeong Lee (4):
      nvme: zero the discard fallback page
      nvme-tcp: reject a read that transferred too few bytes
      nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
      nvme-tcp: fix host memory disclosure on R2T for a read command

Yifei Gao (1):
      nvmet: pci-epf: put CQ ref on create_cq mapping failure

Yu Kuai (30):
      blk-cgroup: protect q->blkg_list iteration in blkg_destroy_all() with blkcg_mutex
      md/md-llbitmap: clear flush state after daemon flush
      md/md-llbitmap: use GFP_NOIO for cache allocations
      md/md-llbitmap: only end fully synced chunks
      md/raid5: reject zero-sector reshape chunks
      md/raid5: round bitmap stripes with sector division
      md: wait for behind writes before destroying bitmap
      md: avoid stale clone I/O accounting timestamps
      md/md-llbitmap: prevent create failure bitmap UAF
      md/md-llbitmap: stop daemon timer rearm on destroy
      md: skip bitmap accounting for empty write ranges
      md: add helper to split bios at reshape offset
      md: add exact bitmap mapping and reshape hooks
      md/md-llbitmap: track bitmap sync_size explicitly
      md/md-llbitmap: allocate page controls independently
      md/md-llbitmap: grow the page cache in place for reshape
      md/md-llbitmap: track target reshape geometry fields
      md/md-llbitmap: finish reshape geometry
      md/md-llbitmap: refuse reshape while llbitmap still needs sync
      md/md-llbitmap: add reshape range mapping helpers
      md/md-llbitmap: don't skip reshape ranges from bitmap state
      md/md-llbitmap: remap checkpointed bits as reshape progresses
      md/md-llbitmap: clamp state-machine walks to tracked bits
      md/raid10: reject llbitmap reshape when md chunk shrinks
      md/raid10: wire llbitmap reshape lifecycle
      md/raid10: split reshape bios before bitmap accounting
      md/raid5: add exact old and new llbitmap mapping helpers
      md/raid5: reject llbitmap reshape when md chunk shrinks
      md/raid5: wire llbitmap reshape lifecycle
      md/raid5: split reshape bios before bitmap accounting

Yunye Zhao (2):
      md/raid10: fix still_degraded being inverted in raid10_sync_request()
      md: add cond_resched() to md_do_sync()'s skip path

Zheng Qixing (3):
      blk-cgroup: fix race between policy activation and blkg destruction
      blk-cgroup: skip dying blkg in blkcg_activate_policy()
      blk-cgroup: factor policy pd teardown loop into helper

Zhengrong Li (1):
      nvmet: fix Reservation Register Replace for unregistered host with IEKEY

Zizhi Wo (10):
      null_blk: use DEFINE_MUTEX for the file-scope mutex
      null_blk: register configfs subsystem after creating default devices
      null_blk: move unregister_blkdev() after destroying dev in null_exit()
      null_blk: free global tag_set on init error path
      null_blk: free zones array on device power-off
      null_blk: clean up null_del_dev() to use cached dev pointer
      null_blk: reject per-device queue resize for shared tag set
      null_blk: convert file-scope mutex users to guard(mutex)
      null_blk: serialize configfs attribute stores with the lock
      null_blk: serialize configfs attribute shows with the lock

胡连勤 (1):
      block: set QUEUE_FLAG_DYING unconditionally in blk_mark_disk_dead()
 Documentation/ABI/stable/configfs-nvmet           |  352 ++++++
 Documentation/ABI/stable/sysfs-nvme               |  453 ++++++++
 Documentation/ABI/testing/sysfs-nvme              |   13 -
 Documentation/admin-guide/blockdev/zoned_loop.rst |   15 +-
 Documentation/block/biovecs.rst                   |    8 +-
 MAINTAINERS                                       |    4 +
 block/bdev.c                                      |    1 -
 block/bfq-cgroup.c                                |    4 +-
 block/bio-integrity-auto.c                        |   10 +-
 block/bio-integrity-fs.c                          |    6 +-
 block/bio.c                                       |  206 +++-
 block/blk-cgroup-rwstat.c                         |    5 +-
 block/blk-cgroup.c                                |   80 +-
 block/blk-cgroup.h                                |   25 +-
 block/blk-core.c                                  |    6 +-
 block/blk-iocost.c                                |   21 +-
 block/blk-iolatency.c                             |   13 +-
 block/blk-map.c                                   |    4 +-
 block/blk-merge.c                                 |    8 +-
 block/blk-mq-dma.c                                |    2 +-
 block/blk-mq.c                                    |    1 +
 block/blk-stat.c                                  |    2 +-
 block/blk-throttle.h                              |    2 -
 block/blk-zoned.c                                 |   30 -
 block/blk.h                                       |    2 +-
 block/fops.c                                      |   28 +-
 block/genhd.c                                     |    1 +
 block/ioctl.c                                     |   60 +-
 block/kyber-iosched.c                             |    2 +-
 block/mq-deadline.c                               |   25 +-
 drivers/block/loop.c                              |   48 +-
 drivers/block/mtip32xx/mtip32xx.c                 |    7 +
 drivers/block/mtip32xx/mtip32xx.h                 |    2 +
 drivers/block/nbd.c                               |  257 +++--
 drivers/block/null_blk/main.c                     |  106 +-
 drivers/block/null_blk/zoned.c                    |   10 +-
 drivers/block/swim3.c                             |    1 +
 drivers/block/ublk_drv.c                          |  374 +++---
 drivers/block/zloop.c                             |   40 +-
 drivers/md/dm-io-rewind.c                         |   10 +-
 drivers/md/dm-pcache/segment.c                    |    4 +-
 drivers/md/md-bitmap.c                            |   22 +-
 drivers/md/md-bitmap.h                            |   12 +-
 drivers/md/md-linear.c                            |    1 +
 drivers/md/md-llbitmap.c                          |  752 ++++++++++--
 drivers/md/md.c                                   |  178 ++-
 drivers/md/md.h                                   |   15 +-
 drivers/md/raid0.c                                |    1 +
 drivers/md/raid1-10.c                             |    8 +-
 drivers/md/raid1.c                                |  139 +--
 drivers/md/raid10.c                               |  227 ++--
 drivers/md/raid10.h                               |    2 +-
 drivers/md/raid5-ppl.c                            |    4 +-
 drivers/md/raid5.c                                |  318 ++++--
 drivers/nvdimm/btt.c                              |    2 +-
 drivers/nvme/common/auth.c                        |   13 +-
 drivers/nvme/host/Makefile                        |    1 +
 drivers/nvme/host/apple.c                         |   66 +-
 drivers/nvme/host/auth.c                          |    3 +-
 drivers/nvme/host/core.c                          |   52 +-
 drivers/nvme/host/fabrics.c                       |    4 +-
 drivers/nvme/host/fc.c                            |    8 +-
 drivers/nvme/host/ioctl.c                         |  121 +-
 drivers/nvme/host/multipath.c                     |   64 +-
 drivers/nvme/host/nvme.h                          |   67 +-
 drivers/nvme/host/pci.c                           |   31 +-
 drivers/nvme/host/rdma.c                          |  160 ++-
 drivers/nvme/host/sysfs.c                         |    4 +-
 drivers/nvme/host/tcp.c                           |   73 +-
 drivers/nvme/host/zns.c                           |   11 +-
 drivers/nvme/target/admin-cmd.c                   |   14 +-
 drivers/nvme/target/configfs.c                    |   10 +-
 drivers/nvme/target/core.c                        |   54 +-
 drivers/nvme/target/debugfs.c                     |  103 ++
 drivers/nvme/target/debugfs.h                     |    5 +
 drivers/nvme/target/fabrics-cmd-auth.c            |   17 +-
 drivers/nvme/target/fabrics-cmd.c                 |    2 +-
 drivers/nvme/target/fc.c                          |    2 +-
 drivers/nvme/target/nvmet.h                       |    9 +
 drivers/nvme/target/passthru.c                    |    9 +
 drivers/nvme/target/pci-epf.c                     |   12 +-
 drivers/nvme/target/pr.c                          |   37 +-
 drivers/nvme/target/rdma.c                        |   31 +-
 drivers/nvme/target/tcp.c                         |   19 +-
 drivers/nvme/target/zns.c                         |   15 +-
 drivers/s390/block/Makefile                       |    2 +
 drivers/s390/block/dasd.c                         |  242 +++-
 drivers/s390/block/dasd_3990_erp.c                |    1 +
 drivers/s390/block/dasd_devmap.c                  |   90 +-
 drivers/s390/block/dasd_eckd.c                    | 1270 ++++++++++++++++++---
 drivers/s390/block/dasd_eckd.h                    |   68 +-
 drivers/s390/block/dasd_erp.c                     |   11 +-
 drivers/s390/block/dasd_int.h                     |  149 ++-
 fs/aio.c                                          |    2 +-
 fs/btrfs/misc.h                                   |    2 +-
 fs/buffer.c                                       |    3 +
 fs/erofs/zdata.c                                  |   11 +-
 fs/fs-writeback.c                                 |    2 +-
 fs/iomap/direct-io.c                              |    1 +
 fs/iomap/ioend.c                                  |    5 +-
 fs/xfs/xfs_aops.c                                 |   19 +-
 include/linux/bio-integrity.h                     |    3 +
 include/linux/bio.h                               |   43 +-
 include/linux/blk-cgroup.h                        |   23 +-
 include/linux/blk_plug.h                          |   95 ++
 include/linux/blk_types.h                         |    1 +
 include/linux/blkdev.h                            |   86 +-
 include/linux/bvec.h                              |   14 +-
 include/linux/io_uring_types.h                    |    2 +-
 include/linux/iomap.h                             |    5 +-
 include/linux/list.h                              |    9 +
 include/linux/nvme.h                              |    4 +-
 include/linux/uio.h                               |   10 +-
 include/uapi/linux/blkdev.h                       |    1 +
 include/uapi/linux/ublk_cmd.h                     |    5 +-
 io_uring/io_uring.h                               |    1 +
 io_uring/kbuf.c                                   |    1 +
 io_uring/net.c                                    |    4 +-
 io_uring/rsrc.h                                   |    2 +
 io_uring/rw.h                                     |    1 +
 kernel/exit.c                                     |    1 -
 kernel/sched/core.c                               |    1 -
 lib/iov_iter.c                                    |   11 +-
 mm/madvise.c                                      |    2 +-
 mm/page-writeback.c                               |    1 -
 mm/readahead.c                                    |    2 +-
 mm/swap_state.c                                   |    2 +-
 mm/vmscan.c                                       |    2 +-
 net/ceph/messenger.c                              |    4 +-
 tools/testing/selftests/ublk/Makefile             |    4 +
 tools/testing/selftests/ublk/batch.c              |    2 +-
 tools/testing/selftests/ublk/kublk.c              |  210 +++-
 tools/testing/selftests/ublk/kublk.h              |   43 +-
 tools/testing/selftests/ublk/test_batch_04.sh     |   44 +
 tools/testing/selftests/ublk/test_loop_08.sh      |   25 +
 tools/testing/selftests/ublk/test_params_01.sh    |  114 ++
 136 files changed, 6012 insertions(+), 1590 deletions(-)
 create mode 100644 Documentation/ABI/stable/configfs-nvmet
 create mode 100644 Documentation/ABI/stable/sysfs-nvme
 delete mode 100644 Documentation/ABI/testing/sysfs-nvme
 create mode 100644 include/linux/blk_plug.h
 create mode 100755 tools/testing/selftests/ublk/test_batch_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_params_01.sh

-- 
Jens Axboe


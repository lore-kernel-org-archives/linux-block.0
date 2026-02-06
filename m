Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB6428489
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404298; cv=none; b=Q/d/MArYdn36C2uvtmQX2U8ej+Q6r/3g0P8q000esFTyyDSyipNfRnaoS++LbKLLYWmvVLsQZKgx9YqZkN5vS6Dj3XBxQMp7acy/lUVUKRW2QUloscxQSZeAY0I7gVfJ7u/FMLmoZa99l6wFrKErZICVCCafLmxkiSC8u6uVGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404298; c=relaxed/simple;
	bh=kUyyMdsp+TSkQxyQPwpcpGzsaURKP4NonVxFfad8+ek=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Q7Uoj0AwoAkANn26kkKWhusb/IRu7zH6ZPuu/LNFXmrV1gIObIBvTfy2Je32n2y7ycuLE4qMna3dzxyQC4Fbu3xznclQ9cocr/QXLF3Oecto7lcgAZtmw62kkMxT44scUYymMNiKniuyzUObE/UQb1HuVNLAiaVkTcFxCTigyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RCaD3Zzn; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RCaD3Zzn"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45eabce608dso1716253b6e.2
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770404297; x=1771009097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HcO5LxH1Lp9lmvP2RYBXDytz/ExjNcBLLsQBarEru8=;
        b=RCaD3Zznyzg34Q1WmTUSH6WEPQKh74JdnTOkIjzKLPDe8oojyG5f/yOT/TDxZgMrcn
         ONPe4R+K8S0jy97Vl1DOKu1oWf2++d9fafS7VvE0BfYynt+oP0JL8x452arS4DD/1tKa
         ZEEIAQfjdo9T4YGlhjQXP4BeS09s9OffzUyYwckAWZNQbWEzDUGrf8tByEtTaMlE6U9j
         ZDJTzhzLN6XD7xd+ykQUCtetnkSR4FNFu+hBR1UdekThmOrg939qHKAEZMz12JhBp0nO
         HR0qfIm8buLEwGfuwfFH5ZZepAqj+2uDNZDSuOSbb+9fGsfN+2lg24ePV4qQaOr1x/PR
         1lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770404297; x=1771009097;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HcO5LxH1Lp9lmvP2RYBXDytz/ExjNcBLLsQBarEru8=;
        b=hTFnzIxfDzqzhmTo4rkXmthsZ+YebpqNRXzJxixDLYqvXLG7X0zKWtrxHbLpjoISu/
         T+hzUYu8sCIvXbWFrJP+MYiGW7ss8uSiPfXpXRcPluXPalVk+WG0OYbSk9EgQvYpKGal
         sTgZv752xF/OGqVkkrntozjOm/cWBfa5Ylv2JWzpM88pFTry76g7McrLW66mQHMPrRj4
         rx/tBtBslSMLHUKP7t87SRkqrYaS591w5ya32cPDyCduOKp5rX6cupkOkpN2/ptiYqX4
         vNXDDWgC5KXX21i5Ulcfn9BNIKLVhoVYFtw1Hpvf312NjT5ETtMQN19tWeAWE2jdyr7s
         myIw==
X-Gm-Message-State: AOJu0YwxASLPaDe0awi4l1jw3/orPmNS1NHhc0FeRydfCUoBix6Aavgg
	tg8IVy6RM9QXg8sunqVX7215Y86Zf6FuC8IFmnislV4RRSgOF/obCVv8Bg2zy6uaSNSKxD9nCIG
	Afhq6WP0=
X-Gm-Gg: AZuq6aLtg52//D7MAI7G7EahaaBon1OMoxAEolFJ/dK1WFLRMDy1z2VOXDB3i34eVqT
	aW4rpdE19xvzpaG9TI2UPPdNcfASgGA5qczWcj8Uz/Tk6s7UqREejjwCrP27LKUjGse19VmPDG1
	C/Zhp0zwi4hgf9cMtQDq+G+kZANXNcWQ/Mx6WzGJ/7XbcbccDSdyRfega5lDLe3jGf2+1GjovG1
	XXAFhU3cveYjzMegp32D3omKSYBFUjZ5UOlJKvBQ6voIiqXv2LntZH6iuxGDbbjHMJ8whshM/qB
	eDDalIZ5pnORTs3+EcGaKW201q0ZTj/D+91mUu5Xwpzc7634g5vCeIh87A9I3Am3LQnzBGUV126
	m11/H0CgZoBnuQw0FGOYIILHIfSTdECRkCZBig8VRw8PraIu5d0O5+1I5yCtUH5Ope7rzDe9s/Y
	u00ji03HDD48cBlNef8WhgO9LR+Ps1rNNzcHgkycbpCn1GghnKHq+EGXY32fVOa8YrOwsu
X-Received: by 2002:a05:6808:6505:b0:43f:76b4:816e with SMTP id 5614622812f47-462fca2057dmr2198924b6e.4.1770404297225;
        Fri, 06 Feb 2026 10:58:17 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462feb5455dsm1772663b6e.17.2026.02.06.10.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 10:58:16 -0800 (PST)
Message-ID: <ae61b996-c874-4afd-b8e4-4ff3f90dd3e5@kernel.dk>
Date: Fri, 6 Feb 2026 11:58:15 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 7.0-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are the block changes queued up for the 7.0 kernel merge window.
I'll do a later followup pull request later in this merge window as
well, both for the usual followup fixes, but also because NVMe is once
again lagging. This pull request contains:

- Support for batch request processing for ublk, improving the
  efficiency of the kernel/ublk server communication. This can yield
  nice 7-12% performance improvements.

- Support for integrity data for ublk.

- Various other ublk improvements and additions, including a ton of
  selftests additions and updated.

- Move the handling of blk-crypto software fallback from below the block
  layer to above it. This reduces the complexity of dealing with bio
  splitting.

- Series fixing a number of potential deadlocks in blk-mq related to
  the queue usage counter and writeback throttling and rq-qos debugfs
  handling.

- Add an async_depth queue attribute, to resolve a performance
  regression that's been around for a qhilw related to the scheduler
  depth handling.

- Only use task_work for IOPOLL completions on NVMe, if it is necessary
  to do so. An earlier fix for an issue resulted in all these
  completions being punted to task_work, to guarantee that completions
  were only run for a given io_uring ring when it was local to that
  ring. With the new changes, we can detect if it's necessary to use
  task_work or not, and avoid it if possible.

- rnbd fixes
	- Fix refcount underflow in device unmap path
	- Handle PREFLUSH and NOUNMAP flags properly in protocol
	- Fix server-side bi_size for special IOs
	- Zero response buffer before use
	- Fix trace format for flags
	- Add .release to rnbd_dev_ktype

- MD pull requests via Yu Kuai
	- Fix raid5_run() to return error when log_init() fails
	- Fix IO hang with degraded array with llbitmap
	- Fix percpu_ref not resurrected on suspend timeout in llbitmap
	- Fix GPF in write_page caused by resize race
	- Fix NULL pointer dereference in process_metadata_update
	- Fix hang when stopping arrays with metadata through dm-raid
	- Fix any_working flag handling in raid10_sync_request
	- Refactor sync/recovery code path, improve error handling for
	  badblocks, and remove unused recovery_disabled field
	- Consolidate mddev boolean fields into mddev_flags
	- Use mempool to allocate stripe_request_ctx and make sure
	  max_sectors is not less than io_opt in raid5
	- Fix return value of mddev_trylock
	- Fix memory leak in raid1_run()
	- Add Li Nan as mdraid reviewer

- Move phys_vec definitions to the kernel types, mostly in preparation
  for some VFIO and RDMA changes.

- Improve the speed for secure erase for some devices.

- Various little rust updates.

- Various other minor fixes, improvements, and cleanups.

Note that I generated the diffstat manually due to the block-6.19 merge
messing up the usual git request-pull output. Should be accurate in
terms of what you see, I just can't get it to explicitly show new file
creations.

Please pull!

The following changes since commit ca22c566b89164f6e670af56ecc45f47ef3df819:

  block: zero non-PI portion of auto integrity buffer (2026-01-10 10:22:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.0/block-20260206

for you to fetch changes up to 72f4d6fca699a1e35b39c5e5dacac2926d254135:

  blk-mq: ABI/sysfs-block: fix docs build warnings (2026-02-05 06:57:03 -0700)

----------------------------------------------------------------
for-7.0/block-20260206

----------------------------------------------------------------
Alexander Atanasov (3):
      selftests: ublk: add missing gitignore for metadata_size binary
      selftests: ublk: mark each test start and end time in dmesg
      selftests: ublk: move test temp files into a sub directory

Caleb Sander Mateos (21):
      block: use pi_tuple_size in bi_offload_capable()
      blk-integrity: take const pointer in blk_integrity_rq()
      ublk: move ublk flag check functions earlier
      ublk: set UBLK_IO_F_INTEGRITY in ublksrv_io_desc
      ublk: split out ublk_copy_user_bvec() helper
      ublk: split out ublk_user_copy() helper
      ublk: inline ublk_check_and_get_req() into ublk_user_copy()
      ublk: move offset check out of __ublk_check_and_get_req()
      ublk: optimize ublk_user_copy() on daemon task
      selftests: ublk: display UBLK_F_INTEGRITY support
      selftests: ublk: add utility to get block device metadata size
      selftests: ublk: add kublk support for integrity params
      selftests: ublk: implement integrity user copy in kublk
      selftests: ublk: support non-O_DIRECT backing files
      selftests: ublk: add integrity data support to loop target
      selftests: ublk: add integrity params test
      selftests: ublk: add end-to-end integrity test
      ublk: restore auto buf unregister refcount optimization
      ublk: use READ_ONCE() to read struct ublksrv_ctrl_cmd
      ublk: drop ublk_ctrl_start_recovery() header argument
      ublk: remove "can't touch 'ublk_io' any more" comments

Chaitanya Kulkarni (1):
      rnbd-clt: fix refcount underflow in device unmap path

Christoph Hellwig (9):
      fscrypt: pass a real sector_t to fscrypt_zeroout_range_inline_crypt
      fscrypt: keep multiple bios in flight in fscrypt_zeroout_range_inline_crypt
      blk-crypto: add a bio_crypt_ctx() helper
      blk-crypto: submit the encrypted bio in blk_crypto_fallback_bio_prep
      blk-crypto: optimize bio splitting in blk_crypto_fallback_encrypt_bio
      blk-crypto: use on-stack skcipher requests for fallback en/decryption
      blk-crypto: use mempool_alloc_bulk for encrypted bio page allocation
      blk-crypto: optimize data unit alignment checking
      blk-crypto: handle the fallback above the block layer

Christophe JAILLET (1):
      null_blk: Constify struct configfs_item_operations and configfs_group_operations

Damien Le Moal (5):
      block: fix blk_zone_cond_str() comment
      block: improve blk_op_str() comment
      block: cleanup queue limit features definition
      block: introduce blk_queue_rot()
      block: introduce bdev_rot()

Florian-Ewald Mueller (1):
      rnbd-srv: Fix server side setting of bi_size for special IOs

Gary Guo (1):
      block: rnull: remove imports available via prelude

Govindarajulu Varadarajan (1):
      ublk: Validate SQE128 flag before accessing the cmd

Heinz Mauelshagen (1):
      md raid: fix hang when stopping arrays with metadata through dm-raid

Jack Wang (2):
      rnbd-srv: fix the trace format for flags
      md/bitmap: fix GPF in write_page caused by resize race

Jens Axboe (4):
      Merge branch 'block-6.19' into for-7.0/block
      Merge branch 'for-7.0/blk-pvec' into for-7.0/block
      Merge tag 'md-7.0-20260127' of git://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-7.0/block
      Merge tag 'md-7.0-20260202' of git://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-7.0/block

Jiasheng Jiang (1):
      md-cluster: fix NULL pointer dereference in process_metadata_update

Johannes Thumshirn (1):
      block: don't use strcpy to copy blockdev name

Ke Sun (2):
      rust: block: mq: use pin_init::zeroed() for queue_limits
      rust: block: mq: use pin_init::zeroed() for tag_set

Keith Busch (1):
      block: remove bio_last_bvec_all

Leon Romanovsky (2):
      nvme-pci: Use size_t for length fields to handle larger sizes
      types: move phys_vec definition to common header

Li Nan (13):
      md/raid1: simplify uptodate handling in end_sync_write
      md: factor error handling out of md_done_sync into helper
      md/raid1,raid10: support narrow_write_error when badblocks is disabled
      md: break remaining operations on badblocks set failure in narrow_write_error
      md: mark rdev Faulty when badblocks setting fails
      md: update curr_resync_completed even when MD_RECOVERY_INTR is set
      md: remove MD_RECOVERY_ERROR handling and simplify resync_offset update
      md: factor out sync completion update into helper
      md: move finish_reshape to md_finish_sync()
      md/raid10: fix any_working flag handling in raid10_sync_request
      md/raid10: cleanup skip handling in raid10_sync_request
      md: remove recovery_disabled
      MAINTAINERS: Add Li Nan as md/raid reviewer

Luke Wang (1):
      block: decouple secure erase size limit from discard size limit

Md Haris Iqbal (3):
      block/rnbd-proto: Handle PREFLUSH flag properly for IOs
      block/rnbd-proto: Check and retain the NOUNMAP flag for requests
      rnbd-srv: Zero the rsp buffer before using it

Ming Lei (53):
      block: use bvec iterator helper for bio_may_need_split()
      block: don't initialize bi_vcnt for cloned bio in bio_iov_bvec_set()
      io_uring: remove nr_segs recalculation in io_import_kbuf()
      block: account for bi_bvec_done in bio_may_need_split()
      selftests: ublk: add stop command with --safe option
      block: pass io_comp_batch to rq_end_io_fn callback
      nvme/io_uring: optimize IOPOLL completions for local ring context
      ublk: define ublk_ch_batch_io_fops for the coming feature F_BATCH_IO
      ublk: prepare for not tracking task context for command batch
      ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS & UBLK_U_IO_COMMIT_IO_CMDS
      ublk: handle UBLK_U_IO_PREP_IO_CMDS
      ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
      ublk: add io events fifo structure
      ublk: add batch I/O dispatch infrastructure
      ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
      ublk: refactor ublk_queue_rq() and add ublk_batch_queue_rq()
      ublk: abort requests filled in event kfifo
      ublk: add new feature UBLK_F_BATCH_IO
      ublk: document feature UBLK_F_BATCH_IO
      ublk: implement batch request completion via blk_mq_end_request_batch()
      ublk: fix batch I/O recovery -ENODEV error
      selftests: ublk: fix user_data truncation for tgt_data >= 256
      selftests: ublk: replace assert() with ublk_assert()
      selftests: ublk: add ublk_io_buf_idx() for returning io buffer index
      selftests: ublk: add batch buffer management infrastructure
      selftests: ublk: handle UBLK_U_IO_PREP_IO_CMDS
      selftests: ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
      selftests: ublk: handle UBLK_U_IO_FETCH_IO_CMDS
      selftests: ublk: increase timeout to 150 seconds
      selftests: ublk: add --batch/-b for enabling F_BATCH_IO
      selftests: ublk: support arbitrary threads/queues combination
      ublk: move ublk_mark_io_ready() out of __ublk_fetch()
      ublk: fix canceling flag handling in batch I/O recovery
      selftests: ublk: fix test name
      ublk: rename auto buffer registration helpers
      ublk: document IO reference counting design
      ublk: check list membership before cancelling batch fetch command
      ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
      selftests: ublk: derive TID automatically from script name
      selftests: ublk: add selftest for UBLK_F_NO_AUTO_PART_SCAN
      selftests: ublk: rename test_generic_15 to test_part_02
      selftests: ublk: refactor test_null_04 into separate functions
      selftests: ublk: disable partition scan for integrity tests
      selftests: ublk: simplify UBLK_TEST_DIR handling
      selftests: ublk: refactor test_loop_08 into separate functions
      selftests: ublk: add _ublk_del_dev helper function
      selftests: ublk: track created devices for per-test cleanup
      selftests: ublk: add group-based test targets
      selftests: ublk: add _ublk_sleep helper for parallel execution
      selftests: ublk: increase timeouts for parallel test execution
      selftests: ublk: reorganize tests into integrity and recover groups
      selftests: ublk: improve I/O ordering test with bpftrace
      selftests: ublk: organize test directories by test ID

Nitesh Shetty (1):
      block, nvme: remove unused dma_iova_state function parameter

Ondrej Kozina (1):
      sed-opal: ignore locking ranges array when not enabling SUM.

Randy Dunlap (1):
      blk-mq: ABI/sysfs-block: fix docs build warnings

Stanley Zhang (3):
      ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
      ublk: implement integrity user copy
      ublk: support UBLK_F_INTEGRITY

Tamir Duberstein (1):
      rnull: replace `kernel::c_str!` with C-Strings

Thorsten Blum (2):
      brd: replace simple_strtol with kstrtoul in ramdisk_size
      block: Replace snprintf with strscpy in check_partition

Xiao Ni (1):
      md: fix return value of mddev_trylock

Yang Xiuwei (1):
      block: remove redundant kill_bdev() call in set_blocksize()

Yoav Cohen (2):
      ublk: make ublk_ctrl_stop_dev return void
      ublk: add UBLK_CMD_TRY_STOP_DEV command

Yu Kuai (24):
      md/raid5: fix raid5_run() to return error when log_init() fails
      md: merge mddev has_superblock into mddev_flags
      md: merge mddev faillast_dev into mddev_flags
      md: merge mddev serialize_policy into mddev_flags
      md/raid5: use mempool to allocate stripe_request_ctx
      md/raid5: make sure max_sectors is not less than io_opt
      md/raid5: fix IO hang with degraded array with llbitmap
      md/md-llbitmap: fix percpu_ref not resurrected on suspend timeout
      blk-wbt: factor out a helper wbt_set_lat()
      blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter
      blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
      blk-rq-qos: fix possible debugfs_mutex deadlock
      blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
      blk-mq-debugfs: remove blk_mq_debugfs_unregister_rqos()
      blk-mq-debugfs: add missing debugfs_mutex in blk_mq_debugfs_register_hctxs()
      blk-mq-debugfs: warn about possible deadlock
      block: convert nr_requests to unsigned int
      blk-mq-sched: unify elevators checking for async requests
      blk-mq: factor out a helper blk_mq_limit_depth()
      blk-mq: add a new queue sysfs attribute async_depth
      kyber: covert to use request_queue->async_depth
      mq-deadline: covert to use request_queue->async_depth
      block, bfq: convert to use request_queue->async_depth
      blk-mq: add documentation for new queue attribute async_dpeth

Zhu Yanjun (1):
      block: rnbd: add .release to rnbd_dev_ktype

Zilin Guan (1):
      md/raid1: fix memory leak in raid1_run()


 Documentation/ABI/stable/sysfs-block               |   45 +
 Documentation/block/biovecs.rst                    |    1 -
 Documentation/block/inline-encryption.rst          |    6 +
 Documentation/block/ublk.rst                       |   64 +-
 MAINTAINERS                                        |    1 +
 block/bdev.c                                       |    1 -
 block/bfq-iosched.c                                |   65 +-
 block/bio-integrity-auto.c                         |   14 +-
 block/bio.c                                        |    5 +-
 block/blk-core.c                                   |   21 +-
 block/blk-crypto-fallback.c                        |  447 +++--
 block/blk-crypto-internal.h                        |   30 +-
 block/blk-crypto.c                                 |   78 +-
 block/blk-flush.c                                  |    6 +-
 block/blk-iocost.c                                 |    2 +-
 block/blk-iolatency.c                              |    5 +-
 block/blk-merge.c                                  |   30 +-
 block/blk-mq-debugfs.c                             |   68 +-
 block/blk-mq-debugfs.h                             |    8 +-
 block/blk-mq-dma.c                                 |   14 +-
 block/blk-mq-sched.h                               |    5 +
 block/blk-mq.c                                     |   77 +-
 block/blk-rq-qos.c                                 |   11 -
 block/blk-sysfs.c                                  |   81 +-
 block/blk-wbt.c                                    |  154 +-
 block/blk-wbt.h                                    |    7 +-
 block/blk-zoned.c                                  |   10 +-
 block/blk.h                                        |   18 +-
 block/elevator.c                                   |    1 +
 block/ioctl.c                                      |    2 +-
 block/kyber-iosched.c                              |   33 +-
 block/mq-deadline.c                                |   39 +-
 block/partitions/core.c                            |    3 +-
 block/sed-opal.c                                   |    3 +-
 drivers/block/brd.c                                |    3 +-
 drivers/block/loop.c                               |    2 +-
 drivers/block/null_blk/main.c                      |    4 +-
 drivers/block/rnbd/rnbd-clt-sysfs.c                |    8 +
 drivers/block/rnbd/rnbd-clt.c                      |   19 +-
 drivers/block/rnbd/rnbd-proto.h                    |   18 +-
 drivers/block/rnbd/rnbd-srv-trace.h                |   22 +-
 drivers/block/rnbd/rnbd-srv.c                      |   36 +-
 drivers/block/rnull/configfs.rs                    |    3 +-
 drivers/block/rnull/rnull.rs                       |    3 -
 drivers/block/ublk_drv.c                           | 2113 +++++++++++++++++---
 drivers/md/dm-rq.c                                 |    3 +-
 drivers/md/md-bitmap.c                             |    7 +-
 drivers/md/md-cluster.c                            |    7 +-
 drivers/md/md-llbitmap.c                           |    4 +-
 drivers/md/md.c                                    |  188 +-
 drivers/md/md.h                                    |   29 +-
 drivers/md/raid0.c                                 |    4 +-
 drivers/md/raid1-10.c                              |    5 -
 drivers/md/raid1.c                                 |   89 +-
 drivers/md/raid1.h                                 |    5 -
 drivers/md/raid10.c                                |  178 +-
 drivers/md/raid10.h                                |    5 -
 drivers/md/raid5.c                                 |  143 +-
 drivers/md/raid5.h                                 |    4 +-
 drivers/nvme/host/core.c                           |    3 +-
 drivers/nvme/host/ioctl.c                          |   23 +-
 drivers/nvme/host/pci.c                            |   20 +-
 drivers/nvme/target/admin-cmd.c                    |    4 +-
 drivers/nvme/target/passthru.c                     |    3 +-
 drivers/scsi/scsi_error.c                          |    3 +-
 drivers/scsi/sg.c                                  |    6 +-
 drivers/scsi/st.c                                  |    3 +-
 drivers/target/target_core_pscsi.c                 |    6 +-
 fs/buffer.c                                        |    3 +-
 fs/crypto/bio.c                                    |   91 +-
 fs/ext4/page-io.c                                  |    3 +-
 fs/ext4/readpage.c                                 |    9 +-
 fs/f2fs/data.c                                     |    4 +-
 fs/f2fs/file.c                                     |    3 +-
 fs/iomap/direct-io.c                               |    3 +-
 include/linux/bio.h                                |    6 -
 include/linux/blk-crypto.h                         |   32 +
 include/linux/blk-integrity.h                      |    6 +-
 include/linux/blk-mq-dma.h                         |    2 +-
 include/linux/blk-mq.h                             |    4 +-
 include/linux/blk_types.h                          |    4 +-
 include/linux/blkdev.h                             |   24 +-
 include/linux/types.h                              |    5 +
 include/uapi/linux/ublk_cmd.h                      |  121 +-
 io_uring/rsrc.c                                    |   11 -
 io_uring/rw.c                                      |    6 +
 kernel/trace/blktrace.c                            |    2 +-
 rust/kernel/block/mq/gen_disk.rs                   |    3 +-
 rust/kernel/block/mq/tag_set.rs                    |    4 +-
 tools/testing/selftests/ublk/.gitignore            |    6 +-
 tools/testing/selftests/ublk/Makefile              |   70 +-
 tools/testing/selftests/ublk/batch.c               |  607 ++++++
 tools/testing/selftests/ublk/common.c              |    6 +-
 tools/testing/selftests/ublk/fault_inject.c        |    1 +
 tools/testing/selftests/ublk/file_backed.c         |  101 +-
 tools/testing/selftests/ublk/kublk.c               |  293 ++-
 tools/testing/selftests/ublk/kublk.h               |  234 ++-
 tools/testing/selftests/ublk/metadata_size.c       |   36 +
 tools/testing/selftests/ublk/null.c                |   19 +-
 tools/testing/selftests/ublk/settings              |    1 +
 tools/testing/selftests/ublk/stripe.c              |   23 +-
 .../ublk/{test_generic_08.sh => test_batch_01.sh}  |    9 +-
 tools/testing/selftests/ublk/test_batch_02.sh      |   29 +
 tools/testing/selftests/ublk/test_batch_03.sh      |   29 +
 tools/testing/selftests/ublk/test_common.sh        |   73 +-
 .../{test_generic_01.sh => test_generic_02.sh}     |   25 +-
 tools/testing/selftests/ublk/test_generic_03.sh    |    1 -
 tools/testing/selftests/ublk/test_generic_06.sh    |    1 -
 tools/testing/selftests/ublk/test_generic_07.sh    |    1 -
 tools/testing/selftests/ublk/test_generic_08.sh    |    1 -
 tools/testing/selftests/ublk/test_generic_09.sh    |    1 -
 tools/testing/selftests/ublk/test_generic_10.sh    |    1 -
 tools/testing/selftests/ublk/test_generic_12.sh    |    1 -
 tools/testing/selftests/ublk/test_generic_13.sh    |    1 -
 tools/testing/selftests/ublk/test_generic_16.sh    |   56 +
 tools/testing/selftests/ublk/test_integrity_01.sh  |  105 +
 tools/testing/selftests/ublk/test_integrity_02.sh  |  141 ++
 tools/testing/selftests/ublk/test_loop_01.sh       |    1 -
 tools/testing/selftests/ublk/test_loop_02.sh       |    1 -
 tools/testing/selftests/ublk/test_loop_03.sh       |    1 -
 tools/testing/selftests/ublk/test_loop_04.sh       |    1 -
 tools/testing/selftests/ublk/test_loop_05.sh       |    1 -
 tools/testing/selftests/ublk/test_loop_06.sh       |    1 -
 tools/testing/selftests/ublk/test_loop_07.sh       |    1 -
 tools/testing/selftests/ublk/test_null_01.sh       |    1 -
 tools/testing/selftests/ublk/test_null_02.sh       |    1 -
 tools/testing/selftests/ublk/test_null_03.sh       |    1 -
 tools/testing/selftests/ublk/test_part_01.sh       |  104 +
 .../ublk/{test_generic_15.sh => test_part_02.sh}   |    7 +-
 .../{test_generic_04.sh => test_recover_01.sh}     |    6 +-
 .../{test_generic_05.sh => test_recover_02.sh}     |    6 +-
 .../{test_generic_11.sh => test_recover_03.sh}     |    1 -
 .../{test_generic_14.sh => test_recover_04.sh}     |    1 -
 tools/testing/selftests/ublk/test_stress_01.sh     |    1 -
 tools/testing/selftests/ublk/test_stress_02.sh     |    1 -
 tools/testing/selftests/ublk/test_stress_03.sh     |    1 -
 tools/testing/selftests/ublk/test_stress_04.sh     |    1 -
 tools/testing/selftests/ublk/test_stress_05.sh     |    1 -
 tools/testing/selftests/ublk/test_stress_06.sh     |    1 -
 tools/testing/selftests/ublk/test_stress_07.sh     |    1 -
 tools/testing/selftests/ublk/test_stress_08.sh     |   44 +
 tools/testing/selftests/ublk/test_stress_09.sh     |   43 +
 tools/testing/selftests/ublk/test_stripe_01.sh     |    1 -
 tools/testing/selftests/ublk/test_stripe_02.sh     |    1 -
 tools/testing/selftests/ublk/test_stripe_03.sh     |    1 -
 tools/testing/selftests/ublk/test_stripe_04.sh     |    1 -
 tools/testing/selftests/ublk/test_stripe_05.sh     |    1 -
 tools/testing/selftests/ublk/test_stripe_06.sh     |    1 -
 tools/testing/selftests/ublk/trace/seq_io.bt       |   77 +-
 tools/testing/selftests/ublk/utils.h               |   64 +
 150 files changed, 5287 insertions(+), 1635 deletions(-)

-- 
Jens Axboe



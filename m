Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE112EC090
	for <linux-block@vger.kernel.org>; Sat, 11 Apr 2026 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775950829; cv=none; b=IuQzSUbGksB7zmOXXi9IEqT9zVxr2+1FcJCwHsrvLZHRD+3CSu2RXjPti4k3SleOpd3auKqaTuP6GR5TS2eRgteCo+i8N3KblA4c6DhQkkxGvc2A7kV0JYA8b50qqMDLHY0fBgVJxXmns4rYGhUWZANmhIwz+velJ2EnC2agDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775950829; c=relaxed/simple;
	bh=Ghynzt67QWf/hbyBsEe/qMZCd08f/wyxrGlPOw1tfnQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=H9/aYMV1HnH4C285CUAVzEHuHxOtO9HtkY29P38ysAP5EbboeURC7d5lBZe9lfnkga5JIHVXN0uh5/DXvmMeIKYvDW7m2BJJfQ01RsBX0x3MiK1/SFpLutENKXmEo5y5esH1ugyAayQFTuIAVeJPAJyPC4d/ZQmtUzExncV1jiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BKTtiqcf; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BKTtiqcf"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d73f41b4f2so1259250eec.1
        for <linux-block@vger.kernel.org>; Sat, 11 Apr 2026 16:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775950826; x=1776555626; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdH3iQgbzzyyhN/TOQAOh8/+q+PdGckmY6SiYZ6yqZM=;
        b=BKTtiqcfnw6bsAqCJJWjZX2Eh2XtTBHNL+kkvR0T6E/1vmkljrhah/8k1Tl/woFh1r
         cUsB1es5AxPPg2QEKQDw+LDrt/P2/CbdQ5QN4V4ogXcLckPzWwg2F8Fo3KZP0VMbpVvH
         Ylqt0IXVa7t4nedadcRAYxneesF2iQtUUX5Euf7Z4KcdH7tjAsekvQlLjW4V+KvQnKkx
         ekvPGIXLVGd58Jcc8eoGR+0ZXiNvy+NWN8QW5eOKp3lJJu6MF7zMOfB3AeMGIJ/2vRXA
         G5CJYNJM59HNztfLd94W7PloFov8TYVW24ulQ1jDZtqUIFmt2wLnLFLb2QKYytcVoi8l
         OMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775950826; x=1776555626;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdH3iQgbzzyyhN/TOQAOh8/+q+PdGckmY6SiYZ6yqZM=;
        b=MTUTqLl+HYBTJC73fqD+kjf2uHT0PKLEwAUHfAlf32kKRSdjn6z4HHBc/Hxrh/1opY
         0i8SYNseLRP74b51K1vetULn1YPjwKWNyI0vfMM6EeFCxu/m/G5hGRZh3NP/m0pikNok
         1YdGDWMkF4ult2y3pX/I9coTNLST7YEMMMYWrVSw+M4IdAcCxHeSoSHRDl0uZHewLJG3
         T+EzGUs9iPGXr+ajvXm9RiwsJib5I2pcHZkiowt0fmzf9kwzEkOvnXp+3VjwmMPbKVGl
         CPToW7uLjgnievGhKwhoq2cT3a1rMGbkFbOIAnZlAS2EtfetXfElUXUzCJAk263ImA53
         rvUg==
X-Gm-Message-State: AOJu0Yy/vAuUKKfmI9RQNULh4NgiXGRzIrLzI/oj/KVINsp4eknIdt/g
	5iMilZiqzNdh8TbqHwipdX5+qK8QAvNFZpSnQZS1OOoRZLoMHISVnuOBWF+rrw8rmdA/tM8HG7x
	J04IK
X-Gm-Gg: AeBDies2zuzaZ4ynfS5kkMtlD1PNWZMNjEhglEcFO0o45f0v4jUDSUYtGe6esFiflTh
	G/f2wIbUfrDRRpcNawyYt3xMeAK0YYaTGfdI6L2eUqGuPoZuUbp8SZoxhq4suRhAQQNRQhewSS0
	f2PobxlqmMF20+DykUL364FA/eotN2wkJsa3c11fQnaFSmURy1GvG+SXHV7sL1HbvNzqK1av9LO
	jALZ+6uPTHpdew/u1xEODg083OMgMErj+TU1C345QkheVpz8e+qjjVqMTFoU6pqvyYP1Bm6627u
	klK/rbXh2c5np0+2SDhta0nEGMxN9ImNdvn1BN4qhhS4VacfnGcEHmNKR3+MejP3IJEDVl1k7BI
	xReESMmxavbODVkCS683cyhWpO66N+0tksxA19J4nMROBET43nmtVe/uU0TYDbxagJGBOSLehMR
	6NpcPdQ/ELbjb9s3m+Sk+ck0ZbVZ4fBoyY6YpxzvGFywQS9vi5h6Qz/dlts8tngZGBgDy51gZ76
	e+a286j2GOaTpNpV6k+kEiieZLf02NWNIgiuK7Fiw==
X-Received: by 2002:a05:7301:1f10:b0:2c5:a6ce:e534 with SMTP id 5a478bee46e88-2d587b840fbmr5509887eec.8.1775950825681;
        Sat, 11 Apr 2026 16:40:25 -0700 (PDT)
Received: from [192.168.68.67] (239.sub-75-226-114.myvzw.com. [75.226.114.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faab010sm10677248eec.12.2026.04.11.16.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 16:40:25 -0700 (PDT)
Message-ID: <d59c7b0e-1cc8-43ae-89aa-ca37e08387f9@kernel.dk>
Date: Sat, 11 Apr 2026 17:40:24 -0600
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
Subject: [GIT PULL] Block changes for the 7.1 merge window
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Same as the io_uring one, coming a bit early due to already stated
reasons. These are the changes queued up for the 7.1 merge window in the
block subsystem:

- Add shared memory zero-copy I/O support for ublk, bypassing per-I/O
  copies between kernel and userspace by matching registered buffer
  PFNs at I/O time. Includes selftests.

- Refactor bio integrity to support filesystem initiated integrity
  operations and arbitrary buffer alignment.

- Clean up bio allocation, splitting bio_alloc_bioset() into clear
  fast and slow paths. Add bio_await() and bio_submit_or_kill()
  helpers, unify synchronous bi_end_io callbacks.

- Fix zone write plug refcount handling and plug removal races. Add
  support for serializing zone writes at QD=1 for rotational zoned
  devices, yielding significant throughput improvements.

- Add SED-OPAL ioctls for Single User Mode management and a
  STACK_RESET command.

- Add io_uring passthrough (uring_cmd) support to the BSG layer.

- Replace pp_buf in partition scanning with struct seq_buf.

- zloop improvements and cleanups.

- drbd genl cleanup, switching to pre_doit/post_doit.

- NVMe pull request via Keith:
     - Fabrics authentication updates
     - Enhanced block queue limits support
     - Workqueue usage updates
     - A new write zeroes device quirk
     - Tagset cleanup fix for loop device

- MD pull requests via Yu Kuai:
     - Fix raid5 soft lockup in retry_aligned_read()
     - Fix raid10 deadlock with check operation and nowait requests
     - Fix raid1 overlapping writes on writemostly disks
     - Fix sysfs deadlock on array_state=clear
     - Proactive RAID-5 parity building with llbitmap, with
       write_zeroes_unmap optimization for initial sync
     - Fix llbitmap barrier ordering, rdev skipping, and bitmap_ops
       version mismatch fallback
     - Fix bcache use-after-free and uninitialized closure
     - Validate raid5 journal metadata payload size
     - Various cleanups

- Various other fixes, improvements, and cleanups

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.1/block-20260411

for you to fetch changes up to 36446de0c30c62b9d89502fd36c4904996d86ecd:

  ublk: fix tautological comparison warning in ublk_ctrl_reg_buf (2026-04-10 07:02:37 -0600)

----------------------------------------------------------------
for-7.1/block-20260411

----------------------------------------------------------------
Abd-Alrhman Masalkhi (1):
      md: remove unused static md_wq workqueue

Alistair Francis (6):
      nvmet-tcp: Don't error if TLS is enabed on a reset
      nvmet-tcp: Don't free SQ on authentication success
      nvme: Expose the tls_configured sysfs for secure concat connections
      nvme: Allow reauth from sysfs
      nvme: Add the DHCHAP maximum HD IDs
      nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with SC_C

Bart Van Assche (1):
      drbd: Balance RCU calls in drbd_adm_dump_devices()

Bill Wendling (1):
      block: annotate struct request_queue with __counted_by_ptr

Caleb Sander Mateos (10):
      ublk: report BLK_SPLIT_INTERVAL_CAPABLE
      nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
      nvme: fold nvme_config_discard() into nvme_update_disk_info()
      nvme: update nvme_id_ns OPTPERF constants
      nvme: always issue I/O Command Set specific Identify Namespace
      nvme: add from0based() helper
      nvme: set discard_granularity from NPDG/NPDA
      nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
      nvmet: report NPDGL and NPDAL
      block: remove unused BVEC_ITER_ALL_INIT

Chaitanya Kulkarni (2):
      block: move bio queue-transition flag fixups into blk_steal_bios()
      block: clear BIO_QOS flags in blk_steal_bios()

Chen Cheng (4):
      md: suppress spurious superblock update error message for dm-raid
      md/raid5: remove stale md_raid5_kick_device() declaration
      md/raid5: move handle_stripe() comment to correct location
      md: remove unused mddev argument from export_rdev

Chia-Ming Chang (1):
      md/raid5: fix soft lockup in retry_aligned_read()

Christoph Böhmwalder (2):
      drbd: use genl pre_doit/post_doit
      drbd: remove DRBD_GENLA_F_MANDATORY flag handling

Christoph Hellwig (19):
      block: factor out a bio_integrity_action helper
      block: factor out a bio_integrity_setup_default helper
      block: add a bdev_has_integrity_csum helper
      block: prepare generation / verification helpers for fs usage
      block: make max_integrity_io_size public
      block: add fs_bio_integrity helpers
      block: pass a maxlen argument to bio_iov_iter_bounce
      block: mark bvec_{alloc,free} static
      block: split bio_alloc_bioset more clearly into a fast and slowpath
      block: remove bvec_free
      zloop: refactor zloop_rw
      zloop: forget write cache on force removal
      blk-crypto: fix name of the bio completion callback
      xfs: fix number of GC bvecs
      block: unify the synchronous bi_end_io callbacks
      block: factor out a bio_await helper
      block: add a bio_submit_or_kill helper
      xfs: use bio_await in xfs_zone_gc_reset_sync
      block: refactor blkdev_zone_mgmt_ioctl

Daan De Meyer (1):
      loop: fix partition scan race between udev and loop_reread_partitions()

Damien Le Moal (10):
      block: fix zone write plug removal
      block: fix zone write plugs refcount handling in disk_zone_wplug_schedule_bio_work()
      block: rename and simplify disk_get_and_lock_zone_wplug()
      block: remove disk_zone_is_full()
      block: rename struct gendisk zone_wplugs_lock field
      block: allow submitting all zone writes from a single context
      block: default to QD=1 writes for blk-mq rotational zoned devices
      Documentation: ABI: stable: document the zoned_qd1_writes attribute
      block: remove bdev_nonrot()
      zloop: add max_open_zones option

Dan Carpenter (1):
      scsi: bsg: fix buffer overflow in scsi_bsg_uring_cmd()

David Carlier (1):
      drbd: use get_random_u64() where appropriate

Eric Biggers (21):
      nvme-auth: add NVME_AUTH_MAX_DIGEST_SIZE constant
      nvme-auth: common: constify static data
      nvme-auth: use proper argument types
      nvme-auth: common: add KUnit tests for TLS key derivation
      nvme-auth: rename nvme_auth_generate_key() to nvme_auth_parse_key()
      nvme-auth: common: explicitly verify psk_len == hash_len
      nvme-auth: common: add HMAC helper functions
      nvme-auth: common: use crypto library in nvme_auth_transform_key()
      nvme-auth: common: use crypto library in nvme_auth_augmented_challenge()
      nvme-auth: common: use crypto library in nvme_auth_generate_psk()
      nvme-auth: common: use crypto library in nvme_auth_generate_digest()
      nvme-auth: common: use crypto library in nvme_auth_derive_tls_psk()
      nvme-auth: host: use crypto library in nvme_auth_dhchap_setup_host_response()
      nvme-auth: host: use crypto library in nvme_auth_dhchap_setup_ctrl_response()
      nvme-auth: host: remove allocation of crypto_shash
      nvme-auth: target: remove obsolete crypto_has_shash() checks
      nvme-auth: target: use crypto library in nvmet_auth_host_hash()
      nvme-auth: target: use crypto library in nvmet_auth_ctrl_hash()
      nvme-auth: common: remove nvme_auth_digest_name()
      nvme-auth: common: remove selections of no-longer used crypto modules
      crypto: remove HKDF library

FengWei Shih (1):
      md/raid5: skip 2-failure compute when other disk is R5_LOCKED

Gregory Price (1):
      md/raid0: use kvzalloc/kvfree for strip_zone and devlist allocations

Jackie Liu (2):
      block: fix zones_cond memory leak on zone revalidation error paths
      blk-cgroup: fix disk reference leak in blkcg_maybe_throttle_current()

Jens Axboe (4):
      Merge branch 'for-7.1/block-integrity' into for-7.1/block
      Merge tag 'md-7.1-20260323' of git://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-7.1/block
      Merge tag 'nvme-7.1-2026-03-27' of git://git.infradead.org/nvme into for-7.1/block
      Merge tag 'md-7.1-20260407' of git://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-7.1/block

Jialin Wang (1):
      blk-iocost: fix busy_level reset when no IOs complete

John Garry (1):
      block: Correct comments on bio_alloc_clone() and bio_init_clone()

Josh Hunt (1):
      md/raid10: fix deadlock with check operation and nowait requests

Junrui Luo (1):
      md/raid5: validate payload size before accessing journal metadata

Kees Cook (1):
      block: partitions: Replace pp_buf with struct seq_buf

Keith Busch (1):
      blk-integrity: support arbitrary buffer alignment

Marco Crivellari (3):
      nvmet: replace use of system_wq with system_percpu_wq
      nvmet-fc: add WQ_PERCPU to alloc_workqueue users
      nvme: add WQ_PERCPU to alloc_workqueue users

Milan Broz (1):
      sed-opal: Add STACK_RESET command

Ming Lei (21):
      blk-cgroup: wait for blkcg cleanup before initializing new disk
      ublk: move cold paths out of __ublk_batch_dispatch() for icache efficiency
      bio: fix kmemleak false positives from percpu bio alloc cache
      ublk: add UBLK_U_CMD_REG_BUF/UNREG_BUF control commands
      ublk: add PFN-based buffer matching in I/O path
      ublk: enable UBLK_F_SHMEM_ZC feature flag
      ublk: eliminate permanent pages[] array from struct ublk_buf
      selftests/ublk: add shared memory zero-copy support in kublk
      selftests/ublk: add UBLK_F_SHMEM_ZC support for loop target
      selftests/ublk: add shared memory zero-copy test
      selftests/ublk: add hugetlbfs shmem_zc test for loop target
      selftests/ublk: add filesystem fio verify test for shmem_zc
      selftests/ublk: add read-only buffer registration test
      ublk: widen ublk_shmem_buf_reg.len to __u64 for 4GB buffer support
      ublk: verify all pages in multi-page bvec fall within registered range
      ublk: simplify PFN range loop in __ublk_ctrl_reg_buf
      ublk: replace xarray with IDA for shmem buffer index allocation
      ublk: allow buffer registration before device is started
      Documentation: ublk: address review comments for SHMEM_ZC docs
      MAINTAINERS: update ublk driver maintainer email
      ublk: fix tautological comparison warning in ublk_ctrl_reg_buf

Mingzhe Zou (2):
      bcache: fix cached_dev.sb_bio use-after-free and crash
      bcache: fix uninitialized closure object

Nilay Shroff (1):
      nvme-loop: do not cancel I/O and admin tagset during ctrl reset/shutdown

Ondrej Kozina (9):
      sed-opal: add UID of Locking Table.
      sed-opal: add RangeStartRangeLengthPolicy parameter.
      sed-opal: add Admin1PIN parameter.
      sed-opal: add IOC_OPAL_REACTIVATE_LSP.
      sed-opal: refactor (split) IOC_OPAL_LR_SETUP internals.
      sed-opal: add IOC_OPAL_LR_SET_START_LEN ioctl.
      sed-opal: add IOC_OPAL_ENABLE_DISABLE_LR.
      sed-opal: increase column attribute type size to 64 bits.
      sed-opal: add IOC_OPAL_GET_SUM_STATUS ioctl.

Qu Wenruo (1):
      block: reject zero length in bio_add_page()

Robert Beckett (2):
      nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when wzsl is set
      nvme-pci: add NVME_QUIRK_DISABLE_WRITE_ZEROES for Kingston OM3SGP4

Thomas Weißschuh (4):
      block: make queue_sysfs_entry instances const
      block: ia-ranges: make blk_ia_range_sysfs_entry instances const
      blk-crypto: make blk_crypto_attr instances const
      blk-mq: make blk_mq_hw_ctx_sysfs_entry instances const

Thorsten Blum (1):
      block: use sysfs_emit in sysfs show functions

Uday Shankar (2):
      ublk: reset per-IO canceled flag on each fetch
      selftests: ublk: test that teardown after incomplete recovery completes

Vasily Gorbik (1):
      block: fix bio_alloc_bioset slowpath GFP handling

Xiao Ni (2):
      md/raid1: fix the comparing region of interval tree
      md/raid1: serialize overlap io for writemostly disk

Yang Xiuwei (3):
      bsg: add bsg_uring_cmd uapi structure
      bsg: add io_uring command support to generic layer
      scsi: bsg: add io_uring passthrough handler

Yu Kuai (8):
      md/raid5: set chunk_sectors to enable full stripe I/O splitting
      md/md-llbitmap: skip reading rdevs that are not in_sync
      md/md-llbitmap: raise barrier before state machine transition
      md: fix array_state=clear sysfs deadlock
      md: add fallback to correct bitmap_ops on version mismatch
      md/md-llbitmap: add CleanUnwritten state for RAID-5 proactive parity building
      md/md-llbitmap: optimize initial sync with write_zeroes_unmap support
      md: wake raid456 reshape waiters before suspend

Yuto Ohnuki (1):
      blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()

 Documentation/ABI/stable/sysfs-block              |  15 +
 Documentation/ABI/testing/sysfs-nvme              |  13 +
 Documentation/admin-guide/blockdev/zoned_loop.rst |  10 +-
 Documentation/block/inline-encryption.rst         |   2 +-
 Documentation/block/ublk.rst                      | 119 ++++
 MAINTAINERS                                       |   2 +-
 block/Makefile                                    |   2 +-
 block/bio-integrity-auto.c                        |  80 +--
 block/bio-integrity-fs.c                          |  81 +++
 block/bio-integrity.c                             |  64 ++
 block/bio.c                                       | 326 ++++-----
 block/blk-cgroup.c                                |  16 +
 block/blk-crypto-sysfs.c                          |  40 +-
 block/blk-ia-ranges.c                             |   6 +-
 block/blk-iocost.c                                |  23 +-
 block/blk-lib.c                                   |  16 +-
 block/blk-mq-debugfs.c                            |   1 +
 block/blk-mq-sysfs.c                              |  10 +-
 block/blk-mq.c                                    |  25 +-
 block/blk-settings.c                              |  25 +-
 block/blk-sysfs.c                                 |  89 ++-
 block/blk-wbt.c                                   |   5 +-
 block/blk-zoned.c                                 | 469 ++++++++-----
 block/blk.h                                       |  13 +-
 block/bsg-lib.c                                   |   2 +-
 block/bsg.c                                       |  33 +-
 block/disk-events.c                               |   3 +-
 block/ioctl.c                                     |  11 +-
 block/opal_proto.h                                |  24 +
 block/partitions/acorn.c                          |  32 +-
 block/partitions/aix.c                            |  21 +-
 block/partitions/amiga.c                          |  35 +-
 block/partitions/atari.c                          |  12 +-
 block/partitions/check.h                          |   8 +-
 block/partitions/cmdline.c                        |   6 +-
 block/partitions/core.c                           |  31 +-
 block/partitions/efi.c                            |   2 +-
 block/partitions/ibm.c                            |  27 +-
 block/partitions/karma.c                          |   2 +-
 block/partitions/ldm.c                            |   4 +-
 block/partitions/mac.c                            |   4 +-
 block/partitions/msdos.c                          |  67 +-
 block/partitions/of.c                             |   6 +-
 block/partitions/osf.c                            |   2 +-
 block/partitions/sgi.c                            |   2 +-
 block/partitions/sun.c                            |   2 +-
 block/partitions/sysv68.c                         |   9 +-
 block/partitions/ultrix.c                         |   2 +-
 block/sed-opal.c                                  | 434 +++++++++++-
 block/t10-pi.c                                    | 818 ++++++++++++----------
 crypto/Kconfig                                    |   6 -
 crypto/Makefile                                   |   1 -
 crypto/hkdf.c                                     | 573 ---------------
 drivers/block/drbd/Makefile                       |   1 -
 drivers/block/drbd/drbd_main.c                    |   4 +-
 drivers/block/drbd/drbd_nl.c                      | 602 +++++++++-------
 drivers/block/drbd/drbd_nla.c                     |  56 --
 drivers/block/drbd/drbd_nla.h                     |   9 -
 drivers/block/ublk_drv.c                          | 477 +++++++++++--
 drivers/block/zloop.c                             | 511 ++++++++++----
 drivers/md/bcache/super.c                         |   8 +
 drivers/md/md-llbitmap.c                          | 213 +++++-
 drivers/md/md.c                                   | 171 ++++-
 drivers/md/md.h                                   |   5 +-
 drivers/md/raid0.c                                |  18 +-
 drivers/md/raid1.c                                |  53 +-
 drivers/md/raid10.c                               |   6 +-
 drivers/md/raid5-cache.c                          |  48 +-
 drivers/md/raid5.c                                |  39 +-
 drivers/md/raid5.h                                |   1 -
 drivers/nvdimm/btt.c                              |   6 +-
 drivers/nvme/common/.kunitconfig                  |   6 +
 drivers/nvme/common/Kconfig                       |  14 +-
 drivers/nvme/common/Makefile                      |   2 +
 drivers/nvme/common/auth.c                        | 587 +++++++---------
 drivers/nvme/common/tests/auth_kunit.c            | 175 +++++
 drivers/nvme/host/auth.c                          | 187 ++---
 drivers/nvme/host/core.c                          |  89 ++-
 drivers/nvme/host/multipath.c                     |  15 +-
 drivers/nvme/host/nvme.h                          |   6 +
 drivers/nvme/host/pci.c                           |   2 +
 drivers/nvme/host/sysfs.c                         |  50 +-
 drivers/nvme/target/admin-cmd.c                   |   4 +-
 drivers/nvme/target/auth.c                        | 202 ++----
 drivers/nvme/target/configfs.c                    |   3 -
 drivers/nvme/target/core.c                        |   7 +-
 drivers/nvme/target/fabrics-cmd-auth.c            |  18 +-
 drivers/nvme/target/fc.c                          |   6 +-
 drivers/nvme/target/io-cmd-bdev.c                 |  19 +-
 drivers/nvme/target/loop.c                        |   2 -
 drivers/nvme/target/nvmet.h                       |   8 +-
 drivers/nvme/target/tcp.c                         |   2 +-
 drivers/scsi/scsi_bsg.c                           | 176 ++++-
 drivers/target/target_core_file.c                 |   2 +-
 drivers/target/target_core_iblock.c               |   2 +-
 fs/btrfs/volumes.c                                |   4 +-
 fs/ext4/mballoc-test.c                            |   2 +-
 fs/ext4/mballoc.c                                 |   2 +-
 fs/iomap/direct-io.c                              |   2 +-
 fs/xfs/xfs_zone_gc.c                              |  38 +-
 include/crypto/hkdf.h                             |  20 -
 include/linux/bio-integrity.h                     |  12 +-
 include/linux/bio.h                               |   7 +-
 include/linux/blk-integrity.h                     |  29 +-
 include/linux/blkdev.h                            |  49 +-
 include/linux/bsg.h                               |   6 +-
 include/linux/bvec.h                              |   9 -
 include/linux/drbd_genl.h                         | 208 +++---
 include/linux/genl_magic_func.h                   |   7 +-
 include/linux/genl_magic_struct.h                 |  15 +-
 include/linux/nvme-auth.h                         |  41 +-
 include/linux/nvme.h                              |  24 +-
 include/linux/sed-opal.h                          |   5 +
 include/uapi/linux/bsg.h                          |  75 ++
 include/uapi/linux/sed-opal.h                     |  30 +
 include/uapi/linux/ublk_cmd.h                     |  80 +++
 mm/swapfile.c                                     |   2 +-
 tools/testing/selftests/ublk/Makefile             |   6 +
 tools/testing/selftests/ublk/fault_inject.c       |  52 +-
 tools/testing/selftests/ublk/file_backed.c        |  38 +
 tools/testing/selftests/ublk/kublk.c              | 354 +++++++++-
 tools/testing/selftests/ublk/kublk.h              |  18 +
 tools/testing/selftests/ublk/test_common.sh       |  15 +-
 tools/testing/selftests/ublk/test_generic_17.sh   |  35 +
 tools/testing/selftests/ublk/test_shmemzc_01.sh   |  72 ++
 tools/testing/selftests/ublk/test_shmemzc_02.sh   |  68 ++
 tools/testing/selftests/ublk/test_shmemzc_03.sh   |  69 ++
 tools/testing/selftests/ublk/test_shmemzc_04.sh   |  72 ++
 128 files changed, 5709 insertions(+), 3200 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvme
 create mode 100644 block/bio-integrity-fs.c
 delete mode 100644 crypto/hkdf.c
 delete mode 100644 drivers/block/drbd/drbd_nla.c
 delete mode 100644 drivers/block/drbd/drbd_nla.h
 create mode 100644 drivers/nvme/common/.kunitconfig
 create mode 100644 drivers/nvme/common/tests/auth_kunit.c
 delete mode 100644 include/crypto/hkdf.h
 create mode 100755 tools/testing/selftests/ublk/test_generic_17.sh
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_04.sh

-- 
Jens Axboe


Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FC1F55EB
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742665071; cv=none; b=UQrn2/Xt8hoxRWblgeKwX0lO8hWKLBP3KwvqBgq4HeZaTixHBQOnkGTpbLOVZZ8XG5t2z0IGFVXkA+IbbdInUS1m3g51SoeOe8omXGNRe0j3dxM7Ah6Esr4V5fKdJ5wCFFepy23Ifg3Cqni79xjHzJaHYKnxWF6Uz7yeoi2OxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742665071; c=relaxed/simple;
	bh=birOHJmVBtZ/+KksxQzWjRGClRxbBqIouKpZA68RYNc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pwkomVahpTs7SZFrKZfsx8wGw3uzfiks/4JVFZ+wWoOPO8sBhHgawJi16/N6DVfIE+L1J0/HaTduT3jDiWF4SbJhZvAFviAOkwB4M0LEUUZk14mdEQ66scYlHWS2gXa9+u9NCFGHjs/sCaGYSt3faSrtPPuhAKf4YIpx7xYtvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XRdaandh; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XRdaandh"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85b4277d03fso113789739f.1
        for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742665066; x=1743269866; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG45DWeSKFi+7jDKVrfW1VX05RkvGLMuw4fBKpKuaJE=;
        b=XRdaandh427Njd0OW0uFXTGjC85M2y1TrEdi1CpisYbriTvkvuW0S8p1eCobVg3yuY
         zr75Ee/8fpj6BBa9FRgCniqKBomtRyFAMh8n4oEHak71M79E0nS7JfoUp3UHqO/TH8XC
         wXSfTUcGqUm0ThTrysNySA/cu8p4f7B+VJu6xeR2SaR3nu5J8aEObYXZ7QoVuz+1ZWKG
         Cu9bQ+1/71c1M/lsTT/KGDpwgmXTB6uQHQpvffA3PPkVONeqqqVY1Si2q/BHUemz39xz
         Oyn9r6x4LYCXjcDyQzWJ3CibtE8/1629Bc9ykxRLRKu8bOEu421U4zL/fb4BDDYCzFD7
         q/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742665066; x=1743269866;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LG45DWeSKFi+7jDKVrfW1VX05RkvGLMuw4fBKpKuaJE=;
        b=hFR8NyajexqGZjP3fkAR5X6+xWPbZvbQvNMbvsWB2eEp6WWC/mXtrNFwYNoC/Wpe2D
         fN8rDTgI0nHERQQaj/Jho5Pdgj6aXTTrtP4d5uDNbdsgJ8hx1LGmaOEdf2IwTj8NYuv5
         pAz6UL6RQadnJggHSPbdm7PI04nF7+eeTJPCQnCFDlLwgb8gKE+0XDezUUdgC1WAAB66
         rxIgUaQu6z+nHWYSMWW+YEXsF9oqWL2KDnuN5cVd2+2YvSqgTjm2tfUmaS8sKqQ6g06l
         NEP2KI6+SGrH29baQnWMDNMKBjr8z719lGfLBBGqSaNYbqdFW/+ahYzjSlu49HwmNTZv
         Ixqg==
X-Gm-Message-State: AOJu0Yyt8Ug8LmfaCnbmiA5LaoSpX9UbWMXdoXHDiEyYZj6rqKDPgfOS
	I0FhzXqx4WnflnBs2ejdwjEsjeSQ8DsVerPpWrcfnUfrLb6pptgoLoE+w2YpcYzPXBA8nDzdata
	Y
X-Gm-Gg: ASbGncvhZX9T03LJzoJkwY1MCg+t8Dbn1qh9AvFcaYuv9K+8XFIeSAiA4IxuznUAEGk
	+AsIOY1iSFnZpJaLAL1SOfNgpcW5z6zBe2Mc2xDktiDIDwztYja4GXAIBA3pFtWPC00/0mm3MeN
	heo+p8LhNQU67TVPlsnAAWiS6xLdVpeultD+5yuugT6NfzRArGtbY4xw5SPQFTp7csC/zNPYTC+
	tu7391KMHV67Yhv0x4MfxUd8C/8cC6HUdIaFGwZbA663/z+bhZoqbe6ara78QZVLRB/eOifUyW/
	YIa+k1CHCqFsK1a2QR4S76MrtPWqkV2qyEJs2tRoBQ==
X-Google-Smtp-Source: AGHT+IEDyZpSCmcv4dIqZoTGgJa0EtpYwqvy4IwkzSXoPej03vRS97yd5BlM5fw+YCQ/xf1iTs+/vA==
X-Received: by 2002:a05:6602:3607:b0:85d:f74b:f8a8 with SMTP id ca18e2360f4ac-85e2ca19fa0mr700574439f.2.1742665065390;
        Sat, 22 Mar 2025 10:37:45 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdd0a66sm991440173.36.2025.03.22.10.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 10:37:44 -0700 (PDT)
Message-ID: <aa7f515f-0db9-49f5-999e-eb75c9512e65@kernel.dk>
Date: Sat, 22 Mar 2025 11:37:43 -0600
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
Subject: [GIT PULL] Block updates for 6.15-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here are the block related updates for the 6.15-rc1 merge window. This
pull request contains:

- Fixes for integrity handling.

- NVMe pull request via Keith
	- Secure concatenation for TCP transport (Hannes)
	- Multipath sysfs visibility (Nilay)
	- Various cleanups (Qasim, Baruch, Wang, Chen, Mike, Damien, Li)
	- Correct use of 64-bit BARs for pci-epf target (Niklas)
	- Socket fix for selinux when used in containers (Peijie)

- MD pull request via Yu:
	- fix recovery can preempt resync (Li Nan)
	- fix md-bitmap IO limit (Su Yue)
	- fix raid10 discard with REQ_NOWAIT (Xiao Ni)
	- fix raid1 memory leak (Zheng Qixing)
	- fix mddev uaf (Yu Kuai)
	- fix raid1,raid10 IO flags (Yu Kuai)
	- some refactor and cleanup (Yu Kuai)

- Series cleaning up and fixing bugs in the bad block handling code.

- Improve support for write failure simulation in null_blk.

- Various lock ordering fixes.

- Fixes for locking for debugfs attributes.

- Various ublk related fixes and improvements.

- Cleanups for blk-rq-qos wait handling.

- blk-throttle fixes.

- Fixes for loop dio and sync handling.

- Fixes and cleanups for the auto-PI code.

- Block side support for hardware encryption keys in blk-crypto.

- Various cleanups and fixes.

Please pull!


The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.15/block-20250322

for you to fetch changes up to 3c9f0c9326b625bf008962d58996f89a3bba1e12:

  Merge tag 'nvme-6.15-2025-03-20' of git://git.infradead.org/nvme into for-6.15/block (2025-03-20 18:39:22 -0600)

----------------------------------------------------------------
for-6.15/block-20250322

----------------------------------------------------------------
Anuj Gupta (3):
      block: ensure correct integrity capability propagation in stacked devices
      block: Correctly initialize BLK_INTEGRITY_NOGENERATE and BLK_INTEGRITY_NOVERIFY
      block: remove unused parameter 'q' parameter in __blk_rq_map_sg()

Baruch Siach (1):
      nvme-pci: remove stale comment

Caleb Sander Mateos (1):
      ublk: complete command synchronously on error

Chen Linxuan (1):
      blk-cgroup: improve policy registration error handling

Chen Ni (1):
      nvmet: pci-epf: Remove redundant 'flush_workqueue()' calls

Christoph Hellwig (8):
      loop: factor out a loop_assign_backing_file helper
      loop: set LO_FLAGS_DIRECT_IO in loop_assign_backing_file
      loop: check in LO_FLAGS_DIRECT_IO in loop_default_blocksize
      loop: take the file system minimum dio alignment into account
      block: mark bounce buffering as incompatible with integrity
      block: move the block layer auto-integrity code into a new file
      block: split struct bio_integrity_payload
      block: fix a comment in the queue_attrs[] array

Coly Li (1):
      badblocks: Fix a nonsense WARN_ON() which checks whether a u64 variable < 0

Damien Le Moal (1):
      nvme: zns: Simplify nvme_zone_parse_entry()

Eric Biggers (3):
      blk-crypto: add basic hardware-wrapped key support
      blk-crypto: show supported key types in sysfs
      blk-crypto: add ioctls to create and prepare hardware-wrapped keys

Guixin Liu (1):
      block: remove unused parameter

Hannes Reinecke (10):
      crypto,fs: Separate out hkdf_extract() and hkdf_expand()
      nvme: add nvme_auth_generate_psk()
      nvme: add nvme_auth_generate_digest()
      nvme: add nvme_auth_derive_tls_psk()
      nvme-keyring: add nvme_tls_psk_refresh()
      nvme-tcp: request secure channel concatenation
      nvme-fabrics: reset admin connection for secure concatenation
      nvmet: Add 'sq' argument to alloc_ctrl_args
      nvmet-tcp: support secure channel concatenation
      nvmet: add tls_concat and tls_key debugfs entries

Jens Axboe (3):
      Merge tag 'md-6.15-20250312' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.15/block
      block/blk-iocost: ensure 'ret' is set on error
      Merge tag 'nvme-6.15-2025-03-20' of git://git.infradead.org/nvme into for-6.15/block

Li Haoran (1):
      nvmet: replace max(a, min(b, c)) by clamp(val, lo, hi)

Li Nan (9):
      md: ensure resync is prioritized over recovery
      badblocks: Fix error shitf ops
      badblocks: factor out a helper try_adjacent_combine
      badblocks: attempt to merge adjacent badblocks during ack_all_badblocks
      badblocks: return error directly when setting badblocks exceeds 512
      badblocks: return error if any badblock set fails
      badblocks: fix the using of MAX_BADBLOCKS
      badblocks: try can_merge_front before overlap_front
      badblocks: fix merge issue when new badblocks align with pre+1

Mike Christie (1):
      nvmet: Remove duplicate uuid_copy

Milan Broz (1):
      docs: sysfs-block: Clarify integrity sysfs attributes

Ming Lei (7):
      ublk: add DMA alignment limit
      blk-throttle: remove last_bytes_disp and last_ios_disp
      blk-throttle: don't take carryover for prioritized processing of metadata
      blk-throttle: carry over directly
      block: make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone
      block: fix adding folio to bio
      loop: move vfs_fsync() out of loop_update_dio()

Muchun Song (2):
      block: introduce init_wait_func()
      block: refactor rq_qos_wait()

Niklas Cassel (1):
      nvmet: pci-epf: Always configure BAR0 as 64-bit

Nilay Shroff (16):
      block: acquire q->limits_lock while reading sysfs attributes
      block: move q->sysfs_lock and queue-freeze under show/store method
      block: remove q->sysfs_lock for attributes which don't need it
      block: introduce a dedicated lock for protecting queue elevator updates
      block: protect nr_requests update using q->elevator_lock
      block: protect wbt_lat_usec using q->elevator_lock
      block: protect read_ahead_kb using q->limits_lock
      block: protect hctx attributes/params using q->elevator_lock
      block: protect debugfs attrs using elevator_lock instead of sysfs_lock
      block: remove unnecessary goto labels in debugfs attribute read methods
      block: protect debugfs attribute method hctx_busy_show
      block: release q->elevator_lock in ioc_qos_write
      block: correct locking order for protecting blk-wbt parameters
      nvme-multipath: Add visibility for round-robin io-policy
      nvme-multipath: Add visibility for numa io-policy
      nvme-multipath: Add visibility for queue-depth io-policy

Peijie Shao (1):
      nvme-tcp: fix selinux denied when calling sock_sendmsg

Qasim Ijaz (1):
      nvme-fc: Utilise min3() to simplify queue count calculation

Shin'ichiro Kawasaki (5):
      null_blk: generate null_blk configfs features string
      null_blk: introduce badblocks_once parameter
      null_blk: replace null_process_cmd() call in null_zone_write()
      null_blk: pass transfer size to null_handle_rq()
      null_blk: do partial IO for bad blocks

Su Yue (1):
      md/md-bitmap: fix wrong bitmap_limit for clustermd when write sb

Tang Yizhou (2):
      blk-wbt: Fix some comments
      blk-wbt: Cleanup a comment in wb_timer_fn

Thomas Hellström (1):
      block: Make request_queue lockdep splats show up earlier

Thorsten Blum (1):
      block: Remove commented out code

Uday Shankar (2):
      ublk: enforce ublks_max only for unprivileged devices
      ublk: remove io_cmds list in ublk_queue

WangYuli (1):
      nvmet-fc: Remove unused functions

Xiao Ni (1):
      md/raid10: wait barrier before returning discard request with REQ_NOWAIT

Yu Kuai (11):
      md: merge common code into find_pers()
      md: only include md-cluster.h if necessary
      md: introduce struct md_submodule_head and APIs
      md: switch personalities to use md_submodule_head
      md/md-cluster: cleanup md_cluster_ops reference
      md: don't export md_cluster_ops
      md: switch md-cluster to use md_submodle_head
      md: fix mddev uaf while iterating all_mddevs list
      md/raid5: merge reshape_progress checking inside get_reshape_loc()
      md/raid1,raid10: don't ignore IO flags
      blk-throttle: fix lower bps rate by throtl_trim_slice()

Zhaoyang Huang (2):
      loop: release the lo_work_lock before queue_work
      Revert "driver: block: release the lo_work_lock before queue_work"

Zheng Qixing (5):
      md/raid1: fix memory leak in raid1_run() if no active rdev
      badblocks: fix missing bad blocks on retry in _badblocks_check()
      badblocks: return boolean from badblocks_set() and badblocks_clear()
      md: improve return types of badblocks handling functions
      badblocks: use sector_t instead of int to avoid truncation of badblocks length

Zhu Yanjun (1):
      loop: Remove struct loop_func_table

 Documentation/ABI/stable/sysfs-block               |  43 +-
 Documentation/block/inline-encryption.rst          | 255 ++++++++-
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 block/Makefile                                     |   3 +-
 block/badblocks.c                                  | 327 +++++-------
 block/bio-integrity-auto.c                         | 191 +++++++
 block/bio-integrity.c                              | 266 +---------
 block/bio.c                                        |  17 +-
 block/blk-cgroup.c                                 |  73 ++-
 block/blk-cgroup.h                                 |   2 +
 block/blk-core.c                                   |   7 +
 block/blk-crypto-fallback.c                        |   7 +-
 block/blk-crypto-internal.h                        |  10 +
 block/blk-crypto-profile.c                         | 101 ++++
 block/blk-crypto-sysfs.c                           |  35 ++
 block/blk-crypto.c                                 | 204 +++++++-
 block/blk-flush.c                                  |  10 +-
 block/blk-iocost.c                                 |  20 +-
 block/blk-merge.c                                  |   4 +-
 block/blk-mq-debugfs.c                             |  41 +-
 block/blk-mq-sched.c                               |   2 +-
 block/blk-mq-sysfs.c                               |   4 +-
 block/blk-mq-tag.c                                 |   3 +-
 block/blk-mq.c                                     |  22 +-
 block/blk-mq.h                                     |   4 +-
 block/blk-rq-qos.c                                 |  82 ++-
 block/blk-settings.c                               |  58 +--
 block/blk-sysfs.c                                  | 304 +++++++----
 block/blk-throttle.c                               |  82 ++-
 block/blk-throttle.h                               |   7 +-
 block/blk-wbt.c                                    |  17 +-
 block/blk.h                                        |   2 +-
 block/bounce.c                                     |   2 -
 block/bsg-lib.c                                    |   2 +-
 block/elevator.c                                   |  43 +-
 block/elevator.h                                   |   2 -
 block/genhd.c                                      |   9 +-
 block/ioctl.c                                      |   5 +
 block/kyber-iosched.c                              |   2 +-
 block/partitions/sgi.c                             |   2 -
 block/partitions/sun.c                             |   2 -
 block/t10-pi.c                                     |   6 +-
 crypto/Kconfig                                     |   6 +
 crypto/Makefile                                    |   1 +
 crypto/hkdf.c                                      | 573 +++++++++++++++++++++
 drivers/block/loop.c                               | 106 ++--
 drivers/block/mtip32xx/mtip32xx.c                  |   2 +-
 drivers/block/null_blk/main.c                      | 177 ++++---
 drivers/block/null_blk/null_blk.h                  |   6 +
 drivers/block/null_blk/zoned.c                     |  20 +-
 drivers/block/rnbd/rnbd-clt.c                      |   2 +-
 drivers/block/sunvdc.c                             |   2 +-
 drivers/block/ublk_drv.c                           | 115 +++--
 drivers/block/virtio_blk.c                         |   2 +-
 drivers/block/xen-blkfront.c                       |   2 +-
 drivers/md/dm-integrity.c                          |  12 -
 drivers/md/dm-table.c                              |   7 +-
 drivers/md/md-bitmap.c                             |  14 +-
 drivers/md/md-cluster.c                            |  18 +-
 drivers/md/md-cluster.h                            |   6 +
 drivers/md/md-linear.c                             |  15 +-
 drivers/md/md.c                                    | 356 ++++++-------
 drivers/md/md.h                                    |  62 ++-
 drivers/md/raid0.c                                 |  18 +-
 drivers/md/raid1-10.c                              |   6 +-
 drivers/md/raid1.c                                 |  56 +-
 drivers/md/raid10.c                                |  66 ++-
 drivers/md/raid5.c                                 |  91 ++--
 drivers/memstick/core/ms_block.c                   |   2 +-
 drivers/memstick/core/mspro_block.c                |   4 +-
 drivers/mmc/core/queue.c                           |   2 +-
 drivers/mmc/host/cqhci-crypto.c                    |   8 +-
 drivers/mmc/host/sdhci-msm.c                       |   3 +-
 drivers/mtd/ubi/block.c                            |   2 +-
 drivers/nvdimm/badrange.c                          |   2 +-
 drivers/nvdimm/nd.h                                |   2 +-
 drivers/nvdimm/pfn_devs.c                          |   7 +-
 drivers/nvdimm/pmem.c                              |   2 +-
 drivers/nvme/common/Kconfig                        |   1 +
 drivers/nvme/common/auth.c                         | 337 ++++++++++++
 drivers/nvme/common/keyring.c                      |  65 ++-
 drivers/nvme/host/Kconfig                          |   2 +-
 drivers/nvme/host/apple.c                          |   2 +-
 drivers/nvme/host/auth.c                           | 115 ++++-
 drivers/nvme/host/core.c                           |   3 +
 drivers/nvme/host/fabrics.c                        |  34 +-
 drivers/nvme/host/fabrics.h                        |   3 +
 drivers/nvme/host/fc.c                             |   6 +-
 drivers/nvme/host/multipath.c                      | 138 +++++
 drivers/nvme/host/nvme.h                           |  22 +-
 drivers/nvme/host/pci.c                            |   5 +-
 drivers/nvme/host/rdma.c                           |   3 +-
 drivers/nvme/host/sysfs.c                          |  24 +-
 drivers/nvme/host/tcp.c                            |  67 ++-
 drivers/nvme/host/zns.c                            |  10 +-
 drivers/nvme/target/auth.c                         |  72 ++-
 drivers/nvme/target/core.c                         |   9 +-
 drivers/nvme/target/debugfs.c                      |  27 +
 drivers/nvme/target/fabrics-cmd-auth.c             |  60 ++-
 drivers/nvme/target/fabrics-cmd.c                  |  25 +-
 drivers/nvme/target/fc.c                           |  14 -
 drivers/nvme/target/loop.c                         |   2 +-
 drivers/nvme/target/nvmet.h                        |  40 +-
 drivers/nvme/target/pci-epf.c                      |  12 +-
 drivers/nvme/target/tcp.c                          |  32 +-
 drivers/scsi/scsi_lib.c                            |   2 +-
 drivers/target/target_core_iblock.c                |  12 -
 drivers/ufs/core/ufshcd-crypto.c                   |   7 +-
 drivers/ufs/host/ufs-exynos.c                      |   3 +-
 drivers/ufs/host/ufs-qcom.c                        |   3 +-
 fs/crypto/Kconfig                                  |   1 +
 fs/crypto/hkdf.c                                   |  85 +--
 fs/crypto/inline_crypt.c                           |   4 +-
 include/crypto/hkdf.h                              |  20 +
 include/linux/badblocks.h                          |  10 +-
 include/linux/bio-integrity.h                      |  25 +-
 include/linux/bio.h                                |   4 -
 include/linux/blk-crypto-profile.h                 |  73 +++
 include/linux/blk-crypto.h                         |  73 ++-
 include/linux/blk-mq.h                             |   9 +-
 include/linux/blkdev.h                             |  15 +
 include/linux/nvme-auth.h                          |   7 +
 include/linux/nvme-keyring.h                       |  12 +-
 include/linux/nvme.h                               |   7 +
 include/linux/wait.h                               |   6 +-
 include/uapi/linux/blk-crypto.h                    |  44 ++
 include/uapi/linux/fs.h                            |   6 +-
 include/uapi/linux/ublk_cmd.h                      |   7 +
 128 files changed, 4059 insertions(+), 1561 deletions(-)
 create mode 100644 block/bio-integrity-auto.c
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h
 create mode 100644 include/uapi/linux/blk-crypto.h

-- 
Jens Axboe


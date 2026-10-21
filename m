Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593817;
	b=halwSBiSJFXykOVsqc4qrT3l0uf09mR7WX+puNEp2oJ4Epnl7mfHKUuPN9MnIDC1lW3M
	 i+QaVX02ULwzMv9vR4Oh3PEg2IbTYkrZuFgL9A7dF3DiQRozr48LE1g8MACEQZJ+QVpLd
	 UmAEZYJa3LBMV3+9SKXpjIZraAkXn1aND19Oh6fkKvZ+vc66fhliEBh4AIYJVNzVnysRJ
	 X8kZcCpFPjMJAT2F221Nnf55RLXIW+nOecp2Qc0JQ5G8Kk4I5WuDa0LCoVjlSymWUc5/+
	 PCehm0lWnWw7RAzpsvexFpxDTrn3u4nZDeLrrkc0mIY+dS6xNwnq0qB48DMhVdXUFrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=0JvTuEAfs3JoL1ehjJC7DQMIer6297rj3Wekcqe3CrI=;
	b=eJtc9iLEkV9QVu1EuehexQRZ45jAE5FMzKvmSXe1UCexevCs5aDvdNJKQTg9L1cYdhE1
	 S+6Sn+a0hv6T6U0QWVDnpJY+jvJS+or4BpjH6l+FpT/dXu/Ul0L5DWGIMWsoOpcA5RPCp
	 VtIe+EAsBQfFsqGBjlo8mltIccngdbVrCtwsm6vNzVYrllPlVZihKmB91Lo0vyN+glB1l
	 KmBSqZKK+HO0xm7fCHcVGVeWe21Au77EoEihbJpAuZs2i4n3WaHoHWElu+qQLI/5uR0hs
	 oN3AslLQHdaW83J+UMc+3S7vPzHs4TfZcf9H2bihprLipQj2fwATWHJqO7Wp5saHCcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=peVDPa3j;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA0606A31D
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 14:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5FA0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=peVDPa3j
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so995096c88.1
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792593815; x=1793198615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0JvTuEAfs3JoL1ehjJC7DQMIer6297rj3Wekcqe3CrI=;
        b=peVDPa3jmH9fRc2iS8wKZnm1N20t/l/9JVKaapTVpM0w/3gQKNoSbzdpSXLlzNBi70
         +C+/+QwNfcHmRCsaYmGT5YerOQM8nbUj+zPG0lXnYYxxOYjE1Ruxfwty0W5SXYrjNjrm
         FScoCS5dAN2aEX4b/ny8HH0hb+36NjB0eFVZNGvyrPDUeWrQTX8uorsssa0GtUCeAy3G
         LgRoBO52EnMnlglFvIt32L+Zz94z3vyYzDRJWx3kXNLYZD5qGn1uXa9LWgeWzrAmHjy7
         X3suVotzxaD0cnEaMWmHQtaaxNxBM7qRoSpyQspTlOqbj3bBND4CW0ybIqlDyKPMYhVa
         8ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792593815; x=1793198615;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JvTuEAfs3JoL1ehjJC7DQMIer6297rj3Wekcqe3CrI=;
        b=so/tZVKdngWwGwThUzoYBAvmkWwNd9Wq8SSpifGd+OGtxQ6owWZWIqZVZBljEb7r/Q
         agPVxCFPzrAHbqf0Zzxr6kEseVGO1oFBGHn+pUi24VMPsKtjb5ceTZh9urcZtEBbVh1S
         9d8frx4qAzA2qu59vzScJ3XWCOw5JqoMt8hF8JnGm7xjDWd6OiTNp+4vM8rYYVXOCcOP
         j8GWCyhqsQkACgJWYnp5se8hmCiP5itZT+LrobfuVHrfAiEL1AZdylTtNTHJhqlCHT8a
         0odsFCkZZ41L6W90BfPBeMxrdH1yEjRsArQLsfxY8T06TqYW4tY0Yspd0fGLNP4OLEvW
         v2qA==
X-Gm-Message-State: AFq9FYKUygIMq5mawa/imusUdAV0/6o11oAMNxg3kDlhZFZkYEiTdXLX
	WL75cYoXUiEGOoUrVLvVGLSv+eBkQXafa5DM+O6YIV40/+qccpZZ5dGyKcnHn8Zlj7eC4nx/I8l
	XGpcFhJ8=
X-Gm-Gg: AYBFou12oOX1LOZxbbF00OIp+n+LzRFaMKHu4WUKtR/wKDTED5LKAxB3bCtkCo1YQqN
	m7+Qo9Ykih5m0WHblDEdmt3//ujZsBmkCGM6/vGEEgQ8wBaZoF68nui/WEr/V2I90BCdDfho6SJ
	jecXnAU04Qx04WjkUG11eOR4ONQq+lLM7ke5dL/HdL5EzlRkaRXfAXMknSc2Jbk2ASZ762x+d+j
	evnO0vPwVXJpc/GQmw9lhNRymNZHgAdAXn+2LybysjnsPGjnSiA6hrvyPWcUp+ALd6xzBfSoz8e
	InvMtgrgD9oB4HaSAR7ppqpq3b/zCiDRBpA0KNYrEmJg4gJyLEqkeLVYRMi8Ug6cQ4sf9yoHSJ4
	y7L9fYOgo4HcOMCGMfws/9UiLonalVGBoIW8PlVvtEdkrD/UqJSHqZD5klqbz2RlVKP9z8lzboC
	bCsKuJB8YMNn7gZJcXxE6oZDYTRiMPqiHqaAmWVNVwI6CcNG/AnSAQj3ncmlXcAkHtJ8x1bevoV
	hmPZIM+nuzrU00I1WbxgTFy33oHsHwRPGKPcJYrlpQxVrotLqywNwf4FOvmO3Vo1WNTrX7jk8tk
	4RPWDip7VuwsrmU8nnQnWTWrZZHmgIkwxdueFgQ=
X-Received: by 2002:a05:7022:ebcb:b0:190:596:4071 with SMTP id a92af1059eb24-190a437bcdfmr3891605c88.11.1792593814501;
        Wed, 21 Oct 2026 07:43:34 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903b3d0530sm7168083c88.11.2026.10.21.07.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:43:33 -0700 (PDT)
Message-ID: <3b7e92f1-77a7-4bf7-a942-83de345bfd1a@kernel.dk>
Date: Wed, 21 Oct 2026 08:43:33 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 7.4-rc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here are the block updates and fixes queued up for the 7.4 merge
window. This pull request contains:

- NVMe updates via Keith:
  - Apple M4 (t8132) ANS2 NVMe support
  - nvme-multipath sysfs attributes for path_state, iopolicies, and
    fail_on_ctrl_loss, plus path state evaluation fixes
  - nvme-tcp parallelized I/O queue allocation and startup, and using
    the caller's network namespace
  - nvmet passthru UAF fix and rework, PR preempt use-after-free fixes,
    auth hardening, and traffic based keep alive support
  - DH-HMAC-CHAP secret attributes readable by root only
  - Various other fixes and cleanups

- swim driver overhaul and fixes, plus floppy fixes, via a pull from
  Denis

- Block device buffered and direct I/O rework from Tal: use
  iomap_dirty_folio, take i_rwsem for the write fallback and splice
  read, honor IOCB_NOWAIT in the buffered read path, and reject atomic
  write fallback to buffered I/O

- Large zone revalidation rework: serialize revalidation, handle
  capacity changes by dropping and retrying zone write plugs, propagate
  read-only and offline conditions, and treat offline and read-only
  zones as dead

- ublk robustness work around canceled FETCH rounds and going live over
  canceled io commands, dropping the default I/O scheduler, and a batch
  of selftest additions

- blk-iocost flush cost support and zone append accounting

- rust block fixes for Send/Sync bounds on GenDisk and TagSet, and
  import style cleanups

- Atomic write fixes capping size by the PI buffer constraints and
  failing short atomic pins

- Skip the redundant flush for O_DSYNC direct writes, and only use
  REQ_FUA when the device supports it

- Store GPT attributes as a raw value

- Remove support for swapping loop fds

- Various other fixes and cleanups all over

Please pull!


The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.4/block-20261021

for you to fetch changes up to 40d070cbb1906896d6fd65c39722d2411830ed9f:

  block: restore the iterator when rejecting a misaligned bio (2026-10-20 11:11:45 -0600)

----------------------------------------------------------------
for-7.4/block-20261021

----------------------------------------------------------------
Alvin Sun (4):
      rust: block: mq: use vertical import style
      rust: block: mq: remove redundant imports and format
      rust: block: rnull: use vertical import style
      rust: block: gen_disk: set fops.owner from driver module pointer

Andrea Parri (1):
      nvmet: zns: don't leak stale memory in zone management receive

Andreas Hindborg (3):
      rust: block: fix `Send` bound for `GenDisk`
      rust: block: require `Sync` for `Operations::QueueData`
      rust: block: implement `Send` and `Sync` for `TagSet`

Andrew Morton (1):
      block: restore the iterator when rejecting a misaligned bio

Cen Zhang (1):
      floppy: annotate data-races around command_status and floppy_work_fn

Christian Brauner (1):
      loop: remove support for swapping loop fds

Christoph Hellwig (5):
      block: avoid integer overflows in max_integrity_io_size
      block: cap atomic write size by PI buffer size constraints
      block: improve aligning down bios in bio_iov_iter_bounce_write
      zloop: explicitly mention zone condition when a write fails to it
      Revert "nvme-pci: clamp max_hw_sectors based on DMA optimized limitation"

Daejun Park (2):
      nvmet: fix use-after-free of the old registrant in nvmet_pr_preempt()
      nvmet: fix preempt of another registrant by the reservation holder

Damien Le Moal (16):
      block: remove disk_free_zone_resources()
      block: improve capacity handling during zone revalidation
      block: refactor disk_revalidate_zone_resources()
      block: refactor disk_update_zone_resources()
      block: remember a zone type regardless of its condition
      block: refactor bdev_zone_is_seq()
      block: improve blkdev_get_zone_info()
      block: introduce disk_for_all_zone_wplugs()
      block: serialize zone revalidation
      block: drop all zone write plugs on capacity changes
      block: retry zone revalidation on capacity change
      block: propagate readonly and offline conditions to zone write plugs
      block: always treat offline and read-only zones as dead
      block: fail zone management operations to read-only and offline zones
      block: allow read-only and offline conventional zones
      block: simplify disk_zone_set_cond()

Denis Efremov (Oracle) (2):
      floppy: don't store a stack buffer in timeout_message
      floppy: return the drive state flags from the 32-bit FDGETDRVSTAT

Finn Thain (36):
      swim: Assert strobe with stable outputs
      swim: Select appropriate drive once only
      swim: Enable the drive when probing
      swim: Don't disable drive after every sector
      swim: Perform ISM/IWM mode switching according to specs
      swim: Configure parameter memory
      swim: Refactor SWIM setup
      swim: Enable clock divider only where appropriate
      swim: Don't start motor until medium is present
      swim: Recalibrate when drive is probed
      swim: Add track zero recalibration delay
      swim: Handle FIFO timeout error
      swim: Simplify return value initialization
      swim: Check for CRC errors
      swim: Check error register during sector read
      swim: Don't use the mark register to read data
      swim: Fix buffer overflow
      swim: Convert to blocking queue
      swim: Remove redundant RELAX actions
      swim: Deduplicate polling loops
      swim: Check drive ready bit
      swim: Revisit delays
      swim: Remove pointless mode0 register write
      swim: Don't needlessly re-read sectors
      swim: Don't search beyond the first data mark
      swim: Remove pointless specifiers
      swim: Move swd initialization
      swim: Add some helpful references
      swim: Remove unused macro definitions
      swim: Clean up whitespace
      swim: Define macros for constants
      swim: Define symbols for constants
      swim: Unexport global symbols
      swim: Return -EROFS when opened with BLK_OPEN_WRITE flag
      swim: Fix FDEJECT ioctl for exclusive open
      swim3: Fix FDEJECT ioctl for exclusive open

Guangshuo Li (1):
      floppy: unregister platform device on add_disk failure

Guixin Liu (1):
      nvme-multipath: expose path_state via sysfs

Jens Axboe (2):
      Merge tag 'floppy-for-7.4' of https://github.com/evdenis/linux-floppy into for-7.4/block
      Merge tag 'nvme-7.4-2026-10-15' of git://git.infradead.org/nvme into for-7.4/block

Jesse Taube (1):
      nvmet: Add traffic based keep alive support to configfs

Johannes Thumshirn (1):
      zloop: print device that had errors

John Garry (1):
      block: cap atomic write size by PI buffer size constraints

Josef Bacik (2):
      aoe: pull in the headers each received packet type reads
      ublk: refuse to go live after an io command was canceled

Julian Sun (2):
      block: reject NOWAIT buffered write fallback
      block: take the inode lock for buffered write fallback

Jérémy Jean (2):
      nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF
      nvmet: free the bvec on file namespace range errors

Karl Mehltretter (2):
      block: Fix the thaw_bdev reference in bdev_freeze() kernel-doc
      floppy: flush pending work before releasing resources on init failure

Krishna Iyer (2):
      nvme-multipath: fix path state evaluation for failfast and ANA
      nvme-multipath: add fail_on_ctrl_loss sysfs attribute

Laurence Oberman (1):
      nvme-multipath: add iopolicies sysfs attribute

Li RongQing (2):
      ublk: use global index for reported zones
      block, bfq: initialize active lists for all actuators

Malte Wechter (1):
      rnull: configfs: add power to configfs features

Martin Belanger (1):
      nvme: make the DH-HMAC-CHAP secret attributes readable by root only

Martin George (1):
      nvme-multipath: report "none" iopolicy for discovery subsystems

Ming Lei (10):
      ublk: keep a canceled FETCH round canceling until the server is gone
      ublk: mark the io command cancelable before publishing it
      ublk: mark the batch fetch command cancelable before linking it
      ublk: reset the FETCH round in release also without a disk
      ublk: reset the FETCH round under ub->mutex
      ublk: allow a NULL io->cmd in the cancel callback
      ublk: let STOP_DEV cancel the server's commands before its release
      selftests: ublk: move the control command helpers into ctrl.c
      selftests: ublk: stop a batch thread when PREP_IO_CMDS fails
      selftests: ublk: add test for going live over canceled io commands

Nilay Shroff (2):
      nvmet: introduce struct nvmet_passthru
      nvmet: fix use-after-free in passthru I/O hotpath

Nirmoy Das (1):
      blk-mq: clear stale inactive flag on hctx reuse

Palla Raghunath (1):
      nvmet-fc: don't drop the last assoc reference in nvmet_fc_delete_ctrl()

Paolo Bertinetti (1):
      ublk: hold RCU read lock in ublk_try_buf_match()

Peng Fan (1):
      nvme: use assign_bit() where applicable

Qiliang Yuan (6):
      ublk: don't use an I/O scheduler by default
      ublk: drop the device reference outside ublk_ctl_mutex in DEL_DEV
      selftests: ublk: don't keep the fault_inject timespec on the stack
      selftests: ublk: make the fault_inject delay a pure timeout
      blk-mq: share one tags_srcu instance across all tag sets
      blk-mq: drop the tag_set argument from blk_mq_free_rq_map/tags

Qingxiao Xu (1):
      rnull: fix geometry store check-then-act across lock scopes

Runyu Xiao (1):
      block: amiflop: synchronize flush timer before track flush

Sophon Z (1):
      rust: block: Fix GenDiskBuilder block size documentation

Sung Byeongchan (2):
      nvmet: require authentication before property set
      nvmet-auth: reject undersized AUTH_SEND payloads

Surabhi Gogte (3):
      nvme-tcp: store and use the caller's network namespace
      nvme-tcp: refactor I/O queue setup path
      nvme-tcp: parallelize I/O queue allocation and startup

Tal Zussman (9):
      block: use iomap_dirty_folio for block devices
      block: take i_rwsem for the direct I/O write fallback
      block: take i_rwsem for the splice read path
      block: honor IOCB_NOWAIT in the block device buffered read path
      block: fail a short atomic pin in bio_iov_iter_get_pages()
      block: don't fall back to buffered I/O for atomic writes
      iomap: reject atomic writes in iomap_file_buffered_write()
      block: unpin all pages of a bvec in bio_iov_iter_align_down()
      block: remove dead metadata handling from the async direct I/O path

Tao Cui (4):
      blk-iocost: add flush cost support with the flushiops model parameter
      blk-iocost: charge zone appends as writes
      blk-iocost: account zone append completions in latency stats
      blk-iocost: fix stale comment in ioc_rqos_throttle()

Vasileios Almpanis (1):
      block: drop the cached plug time when blk_add_rq_to_plug() flushes

Vincent Mailhol (1):
      block: store GPT attributes as a raw value

Yang Xiuwei (1):
      floppy: avoid NULL deref in reset_interrupt when cont is cleared

Yao Sang (1):
      nvme: pass partition flags to passthrough checks

Yehyeong Lee (3):
      nvme-rdma: don't complete a request after a bogus remote invalidation
      nvme-auth: fail when the controller does not authenticate itself
      nvme: bound FDP config log reads to the received buffer

Yureka Lilian (2):
      dt-bindings: nvme: Add apple,t8132-nvme-ans2 compatible
      nvme: apple: add t8132 (M4) ANS2 NVMe support

Zhenxian Ma (2):
      block: skip redundant flush for O_DSYNC direct writes
      block: only use REQ_FUA for direct writes if the device supports it

sonotri (1):
      ublk: pin module while release work is pending

 Documentation/ABI/stable/sysfs-nvme                |  52 ++
 Documentation/admin-guide/cgroup-v2.rst            |   7 +
 Documentation/block/ublk.rst                       |  17 +-
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |   1 +
 arch/m68k/mac/config.c                             |  31 +-
 block/bdev.c                                       |   2 +-
 block/bfq-iosched.c                                |   4 +-
 block/bio.c                                        |  99 ++-
 block/blk-core.c                                   |   7 +-
 block/blk-iocost.c                                 |  39 +-
 block/blk-mq-tag.c                                 |  19 +-
 block/blk-mq.c                                     |  27 +-
 block/blk-mq.h                                     |   6 +-
 block/blk-settings.c                               |  12 +-
 block/blk-zoned.c                                  | 856 +++++++++++-------
 block/blk.h                                        |   6 +
 block/fops.c                                       | 141 ++-
 block/partitions/efi.h                             |   8 +-
 drivers/block/amiflop.c                            |  71 +-
 drivers/block/aoe/aoenet.c                         |  14 +-
 drivers/block/floppy.c                             |  56 +-
 drivers/block/loop.c                               | 112 +--
 drivers/block/rnull/configfs.rs                    |  44 +-
 drivers/block/rnull/rnull.rs                       |  15 +-
 drivers/block/swim.c                               | 457 +++++-----
 drivers/block/swim3.c                              |   8 +-
 drivers/block/swim_asm.S                           | 340 ++++----
 drivers/block/ublk_drv.c                           | 261 ++++--
 drivers/block/zloop.c                              |  38 +-
 drivers/nvme/host/apple.c                          |  39 +-
 drivers/nvme/host/auth.c                           |  15 +-
 drivers/nvme/host/core.c                           |  15 +-
 drivers/nvme/host/ioctl.c                          |   2 +-
 drivers/nvme/host/multipath.c                      | 155 +++-
 drivers/nvme/host/nvme.h                           |   4 +
 drivers/nvme/host/pci.c                            |   2 +-
 drivers/nvme/host/rdma.c                           |   1 +
 drivers/nvme/host/sysfs.c                          |  23 +-
 drivers/nvme/host/tcp.c                            | 139 ++-
 drivers/nvme/target/admin-cmd.c                    |   4 +-
 drivers/nvme/target/auth.c                         |   1 +
 drivers/nvme/target/configfs.c                     | 119 ++-
 drivers/nvme/target/core.c                         |  19 +-
 drivers/nvme/target/fabrics-cmd-auth.c             |  38 +-
 drivers/nvme/target/fabrics-cmd.c                  |   4 +
 drivers/nvme/target/fc.c                           |  15 +-
 drivers/nvme/target/io-cmd-file.c                  |   4 +-
 drivers/nvme/target/nvmet.h                        |  70 +-
 drivers/nvme/target/passthru.c                     | 103 ++-
 drivers/nvme/target/pr.c                           |   4 +-
 drivers/nvme/target/zns.c                          |  10 +
 fs/iomap/buffered-io.c                             |   4 +
 include/linux/blk-mq.h                             |   3 -
 include/linux/blkdev.h                             |  19 +-
 rust/kernel/block/mq/gen_disk.rs                   |  72 +-
 rust/kernel/block/mq/operations.rs                 |  16 +-
 rust/kernel/block/mq/request.rs                    |  16 +-
 rust/kernel/block/mq/tag_set.rs                    |  35 +-
 tools/testing/selftests/ublk/.gitignore            |   1 +
 tools/testing/selftests/ublk/Makefile              |   6 +-
 tools/testing/selftests/ublk/batch.c               |  13 +-
 tools/testing/selftests/ublk/ctrl.c                | 268 ++++++
 tools/testing/selftests/ublk/fault_inject.c        |  14 +-
 tools/testing/selftests/ublk/kublk.c               | 271 ------
 tools/testing/selftests/ublk/kublk.h               |  32 +
 tools/testing/selftests/ublk/test_generic_18.sh    |  69 ++
 tools/testing/selftests/ublk/ublk_cancel_ready.c   | 957 +++++++++++++++++++++
 67 files changed, 3789 insertions(+), 1543 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/ctrl.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_18.sh
 create mode 100644 tools/testing/selftests/ublk/ublk_cancel_ready.c

-- 
Jens Axboe


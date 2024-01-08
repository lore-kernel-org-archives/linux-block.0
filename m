Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AAA53E25
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qkByflE0"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso19430839f.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704733350; x=1705338150; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z76ej7ezgI0+24nGJKvNsZCzKoe3vlz3j8RyXEEq/LA=;
        b=qkByflE0GOKgeJkUdAyCXtFe8b0Xr9p0JFgG0rUCC0nJAxOqOQIb8bRi77hAXIVST7
         tR3R+/cPD/6X1gbavE7YB6B0AY5C31gdX6r3vqdI/vnpKosa/qqFvF8Gm7qP2zJPQfUp
         PtUvoKl9qT6Uv3iXeM60x+9aFhJwbm/JkaBa9y/dJtVX0VlU2dyIDFf3btnhN58IgGSw
         0Du+QVhq2FbwiGtwz0qjTBiq5uw28MLqWghN9qD731BYTBzh5EiOwUhyt9QuIggmv8gF
         R5FSytKiMrlqn9iFDKYQO1PlALhRRP7zYD1WNJaLCeLgbYcRPlNN2wZ0sUzkY3s58NTH
         SGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704733350; x=1705338150;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z76ej7ezgI0+24nGJKvNsZCzKoe3vlz3j8RyXEEq/LA=;
        b=TAc4O0A91ZnREzP+e5Jonm3f0FY/M6zApQS1NaeiQxDpYyRX1UwLrLjx5tKkKfaR71
         tudzqP0ueGxEqrEW2Pvqk0MLm/EdDUdY0sOP8DldAD+5k8WzNrP7kHtEJPyAZnZHIIa/
         TrzBfXyPRQ/FVMWo/XCGHZLmk11CdlpcLJWqRmBVcMpMVqIDSt/bsdazL2m4qEm7SNgY
         Lf0sj/HTtos+VRR7GdPI6cNdd2hpMKQEUfpZIvMVHrLh1/B4xdM6+r9YfPytT/8FGu2l
         rWldzZXizkF+j8HKyct3yC2ncJmhe0cKQCrMEQij0/m2Gf/HRhASPOLwR5lLrFNgeCsX
         gtyA==
X-Gm-Message-State: AOJu0YwSBYn6JrtmAAhg9Jl06Yg6gQwdWfo6GJNRaFSbKYgQS4bbCPmK
	dS35edMXCWwQvW+hwdU+SKyHE+WcHr+DGNK0hQIPFdTHHCbhJQ==
X-Google-Smtp-Source: AGHT+IHZsozHTBHoJKxKZ+zyEB632792G3dOfZOlIbXtoWZzOi67Am3IURMai1lV10V+wPUvqVMQWw==
X-Received: by 2002:a5d:804a:0:b0:7bc:207d:5178 with SMTP id b10-20020a5d804a000000b007bc207d5178mr6786279ior.2.1704733349620;
        Mon, 08 Jan 2024 09:02:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 12-20020a5ea50c000000b007bc3ebacf3esm22712iog.46.2024.01.08.09.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:02:29 -0800 (PST)
Message-ID: <2bc9c8de-b2a1-43f7-9aa0-a6ec425a1ce6@kernel.dk>
Date: Mon, 8 Jan 2024 10:02:28 -0700
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
Subject: [GIT PULL] Block changes for 6.8-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are the block changes for the 6.8 merge window. Pretty quiet round
this time around. This pull request contains:

- NVMe updates via Keith:
	- nvme fabrics spec updates (Guixin, Max)
	- nvme target udpates (Guixin, Evan)
	- nvme attribute refactoring (Daniel)
	- nvme-fc numa fix (Keith)

- MD updates via Song:
	- Fix/Cleanup RCU usage from conf->disks[i].rdev (Yu Kuai)
	- Fix raid5 hang issue (Junxiao Bi)
	- Add Yu Kuai as Reviewer of the md subsystem
	- Remove deprecated flavors (Song Liu)
	- raid1 read error check support (Li Nan)
	- Better handle events off-by-1 case (Alex Lyakas)

- Efficiency improvements for passthrough (Kundan)

- Support for mapping integrity data directly (Keith)

- Zoned write fix (Damien)

- rnbd fixes (Kees, Santosh, Supriti)

- Default to a sane discard size granularity (Christoph)

- Make the default max transfer size naming less confusing (Christoph)

- Remove support for deprecated host aware zoned model (Christoph)

- Misc fixes (me, Li, Matthew, Min, Ming, Randy, liyouhong, Daniel,
  Bart, Christoph)

This will throw a merge conflict in drivers/nvme/host/core.c due to some
later-than-rc3 fixes in your branch. The resolution is just to use the
HEAD part, but note that 'ns' is now called 'head'. I'm including my
resolution at the end of this email.

Please pull!


The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.8/block-2024-01-08

for you to fetch changes up to 587371ed783b046f22ba7a5e1cc9a19ae35123b4:

  block: Treat sequential write preferred zone type as invalid (2024-01-08 08:34:24 -0700)

----------------------------------------------------------------
for-6.8/block-2024-01-08

----------------------------------------------------------------
Alex Lyakas (1):
      md: Whenassemble the array, consult the superblock of the freshest device

Bart Van Assche (1):
      block: Use pr_info() instead of printk(KERN_INFO ...)

Christoph Hellwig (27):
      block: move a few definitions out of CONFIG_BLK_DEV_ZONED
      block: prevent an integer overflow in bvec_try_merge_hw_page
      block: support adding less than len in bio_add_hw_page
      virtio_blk: cleanup zoned device probing
      virtio_blk: remove the broken zone revalidation support
      block: remove support for the host aware zone model
      block: simplify disk_set_zoned
      sd: only call disk_clear_zoned when needed
      block: reject invalid operation in submit_bio_noacct
      blk-wbt: remove the separate write cache tracking
      loop: don't update discard limits from loop_set_status
      null_blk: don't cap max_hw_sectors to BLK_DEF_MAX_SECTORS
      aoe: don't abuse BLK_DEF_MAX_SECTORS
      loop: don't abuse BLK_DEF_MAX_SECTORS
      block: rename and document BLK_DEF_MAX_SECTORS
      block: remove two comments in bio_split_discard
      bcache: discard_granularity should not be smaller than a sector
      block: default the discard granularity to sector size
      ubd: use the default discard granularity
      nbd: use the default discard granularity
      null_blk: use the default discard granularity
      zram: use the default discard granularity
      bcache: use the default discard granularity
      mtd_blkdevs: use the default discard granularity
      block: floor the discard granularity to the physical block size
      sd: remove the !ZBC && blk_queue_is_zoned case in sd_read_block_characteristics
      block: remove disk_clear_zoned

Damien Le Moal (1):
      block: Treat sequential write preferred zone type as invalid

Daniel Vacek (1):
      blk-cgroup: don't use removal safe list iterators

Daniel Wagner (6):
      nvme: move ns id info to struct nvme_ns_head
      nvme: refactor ns info helpers
      nvme: refactor ns info setup function
      nvme: rename ns attribute group
      nvme: add csi, ms and nuse to sysfs
      nvme: repack struct nvme_ns_head

Evan Burgess (1):
      nvmet: configfs: use ctrl->instance to track passthru subsystems

Gou Hao (1):
      md/raid1: remove unnecessary null checking

Guixin Liu (4):
      nvme: introduce nvme_check_ctrl_fabric_info helper
      nvme-fabrics: check ioccsz and iorcsz
      nvmet: allow identical cntlid_min and cntlid_max settings
      nvmet: remove cntlid_min and cntlid_max check in nvmet_alloc_ctrl

Jens Axboe (5):
      Merge tag 'md-next-20231208' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.8/block
      block: improve struct request_queue layout
      Merge tag 'md-next-20231219' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.8/block
      block: export disk_clear_zoned()
      Merge tag 'nvme-6.8-2023-12-21' of git://git.infradead.org/nvme into for-6.8/block

Junxiao Bi (2):
      md: bypass block throttle for superblock update
      Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Kees Cook (1):
      block/rnbd-srv: Check for unlikely string overflow

Keith Busch (5):
      block: bio-integrity: directly map user buffers
      nvme: use bio_integrity_map_user
      iouring: remove IORING_URING_CMD_POLLED
      io_uring: remove uring_cmd cookie
      nvme-fc: set numa_node after nvme_init_ctrl

Kundan Kumar (3):
      block: skip QUEUE_FLAG_STATS and rq-qos for passthrough io
      block: skip cgroups for passthrough io
      block: skip start/end time stamping for passthrough IO

Li Nan (4):
      block: Set memalloc_noio to false on device_add_disk() error path
      md: factor out a helper exceed_read_errors() to check read_errors
      md/raid1: support read error check
      block: add check of 'minors' and 'first_minor' in device_add_disk()

Matthew Wilcox (Oracle) (1):
      block: Remove special-casing of compound pages

Max Gurtovoy (1):
      nvme-fabrics: don't check discovery ioccsz/iorcsz

Min Li (1):
      block: add check that partition length needs to be aligned with block size

Ming Lei (1):
      blk-cgroup: fix rcu lockdep warning in blkg_lookup()

Randy Dunlap (1):
      drbd: actlog: fix kernel-doc warnings and spelling

Santosh Pradhan (1):
      block/rnbd: add support for REQ_OP_WRITE_ZEROES

Song Liu (5):
      Merge branch 'md-next-rcu-cleanup' into md-next
      MAINTAINERS: SOFTWARE RAID: Add Yu Kuai as Reviewer
      md: Remove deprecated CONFIG_MD_LINEAR
      md: Remove deprecated CONFIG_MD_MULTIPATH
      md: Remove deprecated CONFIG_MD_FAULTY

Supriti Singh (1):
      block/rnbd: use %pe to print errors

Yu Kuai (6):
      md: remove flag RemoveSynchronized
      md/raid10: remove rcu protection to access rdev from conf
      md/raid1: remove rcu protection to access rdev from conf
      md/raid5: remove rcu protection to access rdev from conf
      md/md-multipath: remove rcu protection to access rdev from conf
      md: synchronize flush io with array reconfiguration

liyouhong (1):
      drivers/block/xen-blkback/common.h: Fix spelling typo in comment

 MAINTAINERS                        |   1 +
 arch/um/drivers/ubd_kern.c         |   1 -
 block/bio-integrity.c              | 218 ++++++++++++++++-
 block/bio.c                        |  53 +++--
 block/blk-cgroup.c                 |   7 +-
 block/blk-cgroup.h                 |   3 +-
 block/blk-core.c                   |  26 +-
 block/blk-merge.c                  |   6 +-
 block/blk-mq.c                     |   3 +-
 block/blk-rq-qos.h                 |   2 +-
 block/blk-settings.c               | 107 ++-------
 block/blk-sysfs.c                  |  11 +-
 block/blk-wbt.c                    |  13 +-
 block/blk-wbt.h                    |   5 -
 block/blk-zoned.c                  |  21 +-
 block/blk.h                        |   2 -
 block/genhd.c                      |   5 +-
 block/ioctl.c                      |  11 +-
 block/partitions/core.c            |  12 +-
 drivers/block/aoe/aoeblk.c         |   3 +-
 drivers/block/drbd/drbd_actlog.c   |  16 +-
 drivers/block/loop.c               |   5 +-
 drivers/block/nbd.c                |   6 +-
 drivers/block/null_blk/main.c      |  13 +-
 drivers/block/null_blk/zoned.c     |   2 +-
 drivers/block/rnbd/rnbd-clt.c      |  13 +-
 drivers/block/rnbd/rnbd-proto.h    |  14 +-
 drivers/block/rnbd/rnbd-srv.c      |  44 ++--
 drivers/block/ublk_drv.c           |   2 +-
 drivers/block/virtio_blk.c         |  78 ++----
 drivers/block/xen-blkback/common.h |   2 +-
 drivers/block/zram/zram_drv.c      |   1 -
 drivers/md/Kconfig                 |  34 ---
 drivers/md/Makefile                |  10 +-
 drivers/md/bcache/super.c          |   1 -
 drivers/md/dm-kcopyd.c             |   2 +-
 drivers/md/dm-table.c              |  45 ++--
 drivers/md/dm-zoned-metadata.c     |   7 +-
 drivers/md/dm-zoned-target.c       |   4 +-
 drivers/md/md-autodetect.c         |   8 +-
 drivers/md/md-faulty.c             | 365 ----------------------------
 drivers/md/md-linear.c             | 318 -------------------------
 drivers/md/md-multipath.c          | 471 -------------------------------------
 drivers/md/md.c                    | 305 ++++++++++++------------
 drivers/md/md.h                    |   5 -
 drivers/md/raid1-10.c              |  54 +++++
 drivers/md/raid1.c                 |  91 +++----
 drivers/md/raid10.c                | 271 +++++----------------
 drivers/md/raid5-cache.c           |  11 +-
 drivers/md/raid5-ppl.c             |  16 +-
 drivers/md/raid5.c                 | 203 +++++-----------
 drivers/md/raid5.h                 |   4 +-
 drivers/mtd/mtd_blkdevs.c          |   4 +-
 drivers/nvme/host/core.c           | 224 ++++++++++--------
 drivers/nvme/host/fc.c             |   6 +-
 drivers/nvme/host/ioctl.c          | 205 +++-------------
 drivers/nvme/host/multipath.c      |   2 +-
 drivers/nvme/host/nvme.h           |  44 ++--
 drivers/nvme/host/rdma.c           |   4 +-
 drivers/nvme/host/sysfs.c          |  99 +++++++-
 drivers/nvme/host/zns.c            |  37 +--
 drivers/nvme/target/configfs.c     |   4 +-
 drivers/nvme/target/core.c         |   3 -
 drivers/nvme/target/passthru.c     |   4 +-
 drivers/scsi/scsi_debug.c          |  27 +--
 drivers/scsi/sd.c                  |  49 ++--
 drivers/scsi/sd_zbc.c              |  16 +-
 fs/btrfs/zoned.c                   |  23 +-
 fs/btrfs/zoned.h                   |   2 +-
 fs/f2fs/data.c                     |   2 +-
 fs/f2fs/super.c                    |  17 +-
 include/linux/bio.h                |   9 +
 include/linux/blk-mq.h             |   6 +
 include/linux/blk_types.h          |   8 +-
 include/linux/blkdev.h             | 159 ++++++-------
 include/linux/io_uring.h           |   9 +-
 include/uapi/linux/raid/md_p.h     |   8 +-
 include/uapi/linux/raid/md_u.h     |  11 +-
 io_uring/uring_cmd.c               |   1 -
 79 files changed, 1254 insertions(+), 2660 deletions(-)
 delete mode 100644 drivers/md/md-faulty.c
 delete mode 100644 drivers/md/md-linear.c
 delete mode 100644 drivers/md/md-multipath.c


commit e91cbc6ff26c06c9d3eb261f8ba5b66fff92f74f
Merge: 0dd3ee311255 587371ed783b
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Jan 8 09:20:02 2024 -0700

    Merge branch 'for-6.8/block' into linus-merge-6.8
    
    * for-6.8/block: (78 commits)
      block: Treat sequential write preferred zone type as invalid
      block: remove disk_clear_zoned
      sd: remove the !ZBC && blk_queue_is_zoned case in sd_read_block_characteristics
      drivers/block/xen-blkback/common.h: Fix spelling typo in comment
      blk-cgroup: fix rcu lockdep warning in blkg_lookup()
      blk-cgroup: don't use removal safe list iterators
      block: floor the discard granularity to the physical block size
      mtd_blkdevs: use the default discard granularity
      bcache: use the default discard granularity
      zram: use the default discard granularity
      null_blk: use the default discard granularity
      nbd: use the default discard granularity
      ubd: use the default discard granularity
      block: default the discard granularity to sector size
      bcache: discard_granularity should not be smaller than a sector
      block: remove two comments in bio_split_discard
      block: rename and document BLK_DEF_MAX_SECTORS
      loop: don't abuse BLK_DEF_MAX_SECTORS
      aoe: don't abuse BLK_DEF_MAX_SECTORS
      null_blk: don't cap max_hw_sectors to BLK_DEF_MAX_SECTORS
      ...
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --cc drivers/nvme/host/core.c
index 60f14019f981,d144d1acb09a..0af612387083
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@@ -1903,10 -1899,9 +1912,10 @@@ static void nvme_update_disk_info(struc
  
  	/*
  	 * The block layer can't support LBA sizes larger than the page size
 -	 * yet, so catch this early and don't allow block I/O.
 +	 * or smaller than a sector size yet, so catch this early and don't
 +	 * allow block I/O.
  	 */
- 	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
 -	if (head->lba_shift > PAGE_SHIFT) {
++	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
  		capacity = 0;
  		bs = (1 << 9);
  	}
@@@ -2043,19 -2038,13 +2052,20 @@@ static int nvme_update_ns_info_block(st
  	if (ret)
  		return ret;
  
 +	if (id->ncap == 0) {
 +		/* namespace not allocated or attached */
 +		info->is_removed = true;
 +		ret = -ENODEV;
 +		goto error;
 +	}
 +
  	blk_mq_freeze_queue(ns->disk->queue);
  	lbaf = nvme_lbaf_index(id->flbas);
- 	ns->lba_shift = id->lbaf[lbaf].ds;
+ 	ns->head->lba_shift = id->lbaf[lbaf].ds;
+ 	ns->head->nuse = le64_to_cpu(id->nuse);
  	nvme_set_queue_limits(ns->ctrl, ns->queue);
  
- 	ret = nvme_configure_metadata(ns, id);
+ 	ret = nvme_configure_metadata(ns->ctrl, ns->head, id);
  	if (ret < 0) {
  		blk_mq_unfreeze_queue(ns->disk->queue);
  		goto out;

-- 
Jens Axboe


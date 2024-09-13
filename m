Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FC6BB4B
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246943; cv=none; b=VImyS7krHCcFm+djHQfiotrQ3YtAwrIHTy7XkZtBQseq0IS8ljhi5tsOVMXTcfVY8pYximKVczXM6AYxakNJLkP2yNFk3IebIc66KDBi7OdC4C9+dabmEhPEjzZ0Lx3mZaQHpWtC4oXKw0kYrF7HOvyOCb24FtygJ/dqUKxxyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246943; c=relaxed/simple;
	bh=AhBYkocxarin10r+7q5uIJ29sGKxmKrz2Rz1cl1xHbQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=LHCwKBVsmI6GeVFQlokuj66VJEv7UAGBs3U5aWtSgtQuB9c5FfY4LKKvmYPQgzYvOKGZyWXFib2ebrTXh9dhZghq6yEv+XFBLSmEk+2LVkbmr2fc+Mq4YiRRR3OudC39NX1gLocMNAyiKelsiKz8Igqet+ybYew7ksMI08TuRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jlOFLbSn; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jlOFLbSn"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso2015342a91.0
        for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 10:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726246940; x=1726851740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUZFrIxA2bgHdAM159bvuL3dI/0nNOc76s2vLuvZt+4=;
        b=jlOFLbSnpbjiuPNl0Uec5FbNw4W9WTM0f8fioI4t/w8YFwjXQpHJJ/lrno1OdECQry
         qbEn+LjdVFZnFnPk+7Ir6c7irWIVpg8mje1MMEA4I+PE9ItYFwuZ5WYz8ljm6xFvFAqx
         cQlRmnQA6GBs4St3sPEiXXWeJgGCjSZqXRyQJ+Hx6qXK8uE/dgrLn0frCfORcS+mx4ff
         buIOBjV8IDbf1upRL+0mZWvJLSvBVCWyraNRQ76Hk7moYUJ5Cg70lBhaQiAfLwS1+joU
         E592sUixWVbepGDDovGTvhffkeLQP/M710BpD5X6j3YYFMZzQE9ot6PXBAf3acPL3wCs
         FqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726246940; x=1726851740;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUZFrIxA2bgHdAM159bvuL3dI/0nNOc76s2vLuvZt+4=;
        b=bpauFWl+SjaSZyMIokyw1EMkg+SxXld3Qj4Z6Uf2qzBSsZ70PFQ9rIX09A3h+W0cNF
         1u40zWZErtrgqF0AtR1TX26J3hDuHAnzf9zDlO5lboYQzJYfy2EDPGncEn6jtCn246aC
         BfMshtVaaT0nvcJDw/4NZpZWxZsRsVq3phay1ilrKtGFU2BlytG3VdoMdOhRWiA7JUSz
         WprRCe70vg6V1aYgnVUsI5O/fC1z7o1Xlaqd2IyzXAl/YPsKyfKLdbaW0EOozvPfiLnu
         Il3dFb/3Svt1RhvDZsM1xerl842sAeuWtC1LFROebhaTZCzIRbTE+qnhISz0qKqV8h3p
         2iFw==
X-Gm-Message-State: AOJu0YxHK0aVNI7q0I+GKhphxlYxMyzc5HJef9qmoB1kYOQOyJujTooq
	7PoxwrqIXAv8x4sy/0gzIailzVHP6v+Rf2wikXSwuxXrWvmW2Chu+3clzkB5Fw5Gq7yDaE8wsPH
	i
X-Google-Smtp-Source: AGHT+IFvoVfdaeVj1csUAJoSxVZROoSz3+P7qjKaL6RmunAxyUP+ol9Iq0qVU4nHknMGXN/fPI4kMw==
X-Received: by 2002:a17:90a:d903:b0:2d8:840b:9654 with SMTP id 98e67ed59e1d1-2dba007e059mr7762780a91.34.1726246939355;
        Fri, 13 Sep 2024 10:02:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c7c7b4sm2031208a91.17.2024.09.13.10.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 10:02:18 -0700 (PDT)
Message-ID: <00feaa2a-c4b0-445f-ae13-a23c5435c47b@kernel.dk>
Date: Fri, 13 Sep 2024 11:02:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 6.12-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are the block changes queued up for the 6.12 merge window. Pretty
quiet round, mostly driver side fixes and cleanups. This pull request
contains:

- MD changes via Song:
	- md-bitmap refactoring (Yu Kuai)
	- raid5 performance optimization (Artur Paszkiewicz)
	- Other small fixes (Yu Kuai, Chen Ni)
	- Add a sysfs entry 'new_level' (Xiao Ni)
	- Improve information reported in /proc/mdstat (Mateusz Kusiak)

- NVMe changes via Keith:
	- Asynchronous namespace scanning (Stuart)
	- TCP TLS updates (Hannes)
	- RDMA queue controller validation (Niklas)
	- Align field names to the spec (Anuj)
	- Metadata support validation (Puranjay)
	- A syntax cleanup (Shen)
	- Fix a Kconfig linking error (Arnd)
	- New queue-depth quirk (Keith)

- Add missing unplug trace event (Keith)

- blk-iocost fixes (Colin, Konstantin)

- t10-pi modular removal and fixes (Alexey)

- Fix for potential BLKSECDISCARD overflow (Alexey)

- bio splitting cleanups and fixes (Christoph)

- Deal with folios rather than rather than pages, speeding up how the
  block layer handles bigger IOs (Kundan)

- Use spinlocks rather than bit spinlocks in zram (Sebastian, Mike)

- Reduce zoned device overhead in ublk (Ming)

- Add and use sendpages_ok() for drbd and nvme-tcp (Ofir)

- Fix regression in partition error pointer checking (Riyan)

- Add support for write zeroes and rotational status in nbd (Wouter)

- Add Yu Kuai as new BFQ maintainer. The scheduler has been unmaintained
  for quite a while.

- Various sets of fixes for BFQ (Yu Kuai)

- Misc fixes and cleanups (Alvaro, Christophe, Li, Md Haris, Mikhail,
  Yang)

Please pull!


The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.12/block-20240913

for you to fetch changes up to d4d7c03f7ee1d7f16b7b6e885b1e00968f72b93c:

  Merge tag 'nvme-6.12-2024-09-13' of git://git.infradead.org/nvme into for-6.12/block (2024-09-13 08:39:09 -0600)

----------------------------------------------------------------
for-6.12/block-20240913

----------------------------------------------------------------
Alexey Dobriyan (3):
      block: delete module stuff from t10-pi
      block: constify ext_pi_ref_escape()
      block: fix integer overflow in BLKSECDISCARD

Alvaro Parker (1):
      block: fix comment to use set_current_state

Anuj Gupta (1):
      nvme: rename apptag and appmask to lbat and lbatm

Arnd Bergmann (1):
      nvme-tcp: fix link failure for TCP auth

Artur Paszkiewicz (3):
      md/raid5: use wait_on_bit() for R5_Overlap
      md/raid5: only add to wq if reshape is in progress
      md/raid5: rename wait_for_overlap to wait_for_reshape

Chen Ni (1):
      md: convert comma to semicolon

Christoph Hellwig (4):
      block: rework bio splitting
      block: constify the lim argument to queue_limits_max_zone_append_sectors
      block: properly handle REQ_OP_ZONE_APPEND in __bio_split_to_limits
      block: don't use bio_split_rw on misc operations

Christophe JAILLET (1):
      drbd: Remove an unused field in struct drbd_device

Colin Ian King (1):
      blk_iocost: make read-only static array vrate_adj_pct const

Hannes Reinecke (9):
      nvme-keyring: restrict match length for version '1' identifiers
      nvme-tcp: sanitize TLS key handling
      nvme-tcp: check for invalidated or revoked key
      nvme: add a newline to the 'tls_key' sysfs attribute
      nvme: split off TLS sysfs attributes into a separate group
      nvme-sysfs: add 'tls_configured_key' sysfs attribute
      nvme-sysfs: add 'tls_keyring' attribute
      nvmet-auth: allow to clear DH-HMAC-CHAP keys
      nvme-target: do not check authentication status for admin commands twice

Jens Axboe (6):
      Merge tag 'md-6.12-20240829' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.12/block
      MAINTAINERS: move the BFQ io scheduler to orphan state
      Merge tag 'md-6.12-20240905' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.12/block
      Merge tag 'nvme-6.12-2024-09-06' of git://git.infradead.org/nvme into for-6.12/block
      Merge tag 'md-6.12-20240906' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.12/block
      Merge tag 'nvme-6.12-2024-09-13' of git://git.infradead.org/nvme into for-6.12/block

Keith Busch (2):
      blk-mq: add missing unplug trace event
      nvme-pci: qdepth 1 quirk

Konstantin Ovsepian (1):
      blk_iocost: fix more out of bound shifts

Kundan Kumar (4):
      block: Added folio-ized version of bio_add_hw_page()
      block: introduce folio awareness and add a bigger size from folio
      mm: release number of pages of a folio
      block: unpin user pages belonging to a folio at once

Li Zetao (1):
      mtip32xx: Remove redundant null pointer checks in mtip_hw_debugfs_init()

Mateusz Kusiak (1):
      md: Report failed arrays as broken in mdstat

Md Haris Iqbal (1):
      block/rnbd-srv: Add sanity check and remove redundant assignment

Mike Galbraith (1):
      zram: Replace bit spinlocks with a spinlock_t.

Mikhail Lobanov (1):
      drbd: Add NULL check for net_conf to prevent dereference in state validation

Ming Lei (2):
      ublk: move zone report data out of request pdu
      nbd: fix race between timeout and normal completion

Niklas Cassel (1):
      nvme-rdma: send cntlid in the RDMA_CM_REQUEST Private Data

Ofir Gal (3):
      net: introduce helper sendpages_ok()
      nvme-tcp: use sendpages_ok() instead of sendpage_ok()
      drbd: use sendpages_ok() instead of sendpage_ok()

Puranjay Mohan (1):
      nvme: fix metadata handling in nvme-passthrough

Riyan Dhiman (1):
      block: fix potential invalid pointer dereference in blk_add_partition

Sebastian Andrzej Siewior (2):
      zram: Remove ZRAM_LOCK
      zram: Shrink zram_table_entry::flags.

Shen Lichuan (1):
      nvme: Convert comma to semicolon

Song Liu (2):
      Merge branch 'md-6.12-bitmap' into md-6.12
      Merge branch 'md-6.12-raid5-opt' into md-6.12

Stuart Hayes (1):
      nvme_core: scan namespaces asynchronously

Wouter Verhelst (4):
      nbd: add support for rotational devices
      nbd: implement the WRITE_ZEROES command
      nbd: nbd_bg_flags_show: add NBD_FLAG_ROTATIONAL
      nbd: correct the maximum value for discard sectors

Xiao Ni (1):
      md: Add new_level sysfs interface

Yang Ruibin (1):
      pktcdvd: remove unnecessary debugfs_create_dir() error check

Yu Kuai (62):
      blk-cgroup: check for pd_(alloc|free)_fn in blkcg_activate_policy()
      blk-ioprio: remove ioprio_blkcg_from_bio()
      blk-ioprio: remove per-disk structure
      md: Don't flush sync_work in md_write_start()
      md/raid1: Clean up local variable 'b' from raid1_read_request()
      md/raid1: use md_bitmap_wait_behind_writes() in raid1_read_request()
      md/md-bitmap: replace md_bitmap_status() with a new helper md_bitmap_get_stats()
      md: use new helper md_bitmap_get_stats() in update_array_info()
      md/md-bitmap: add 'events_cleared' into struct md_bitmap_stats
      md/md-cluster: fix spares warnings for __le64
      md/md-bitmap: add 'sync_size' into struct md_bitmap_stats
      md/md-bitmap: add 'file_pages' into struct md_bitmap_stats
      md/md-bitmap: add 'behind_writes' and 'behind_wait' into struct md_bitmap_stats
      md/md-cluster: use helper md_bitmap_get_stats() to get pages in resize_bitmaps()
      md/md-bitmap: add a new helper md_bitmap_set_pages()
      md/md-bitmap: introduce struct bitmap_operations
      md/md-bitmap: simplify md_bitmap_create() + md_bitmap_load()
      md/md-bitmap: merge md_bitmap_create() into bitmap_operations
      md/md-bitmap: merge md_bitmap_load() into bitmap_operations
      md/md-bitmap: merge md_bitmap_destroy() into bitmap_operations
      md/md-bitmap: merge md_bitmap_flush() into bitmap_operations
      md/md-bitmap: make md_bitmap_print_sb() internal
      md/md-bitmap: merge md_bitmap_update_sb() into bitmap_operations
      md/md-bitmap: merge md_bitmap_status() into bitmap_operations
      md/md-bitmap: remove md_bitmap_setallbits()
      md/md-bitmap: merge bitmap_write_all() into bitmap_operations
      md/md-bitmap: merge md_bitmap_dirty_bits() into bitmap_operations
      md/md-bitmap: merge md_bitmap_startwrite() into bitmap_operations
      md/md-bitmap: merge md_bitmap_endwrite() into bitmap_operations
      md/md-bitmap: merge md_bitmap_start_sync() into bitmap_operations
      md/md-bitmap: remove the parameter 'aborted' for md_bitmap_end_sync()
      md/md-bitmap: merge md_bitmap_end_sync() into bitmap_operations
      md/md-bitmap: merge md_bitmap_close_sync() into bitmap_operations
      md/md-bitmap: merge md_bitmap_cond_end_sync() into bitmap_operations
      md/md-bitmap: merge md_bitmap_sync_with_cluster() into bitmap_operations
      md/md-bitmap: merge md_bitmap_unplug_async() into md_bitmap_unplug()
      md/md-bitmap: merge bitmap_unplug() into bitmap_operations
      md/md-bitmap: merge md_bitmap_daemon_work() into bitmap_operations
      md/md-bitmap: pass in mddev directly for md_bitmap_resize()
      md/md-bitmap: merge md_bitmap_resize() into bitmap_operations
      md/md-bitmap: merge get_bitmap_from_slot() into bitmap_operations
      md/md-bitmap: merge md_bitmap_copy_from_slot() into struct bitmap_operation.
      md/md-bitmap: merge md_bitmap_set_pages() into struct bitmap_operations
      md/md-bitmap: merge md_bitmap_free() into bitmap_operations
      md/md-bitmap: merge md_bitmap_wait_behind_writes() into bitmap_operations
      md/md-bitmap: merge md_bitmap_enabled() into bitmap_operations
      md/md-bitmap: make in memory structure internal
      md: Remove flush handling
      block, bfq: fix possible UAF for bfqq->bic with merge chain
      block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()
      block, bfq: don't break merge chain in bfq_split_bfqq()
      block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
      MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
      blk-throttle: remove last_low_overflow_time
      blk-throttle: support prioritized processing of metadata
      block, bfq: fix uaf for accessing waker_bfqq after splitting
      block, bfq: fix procress reference leakage for bfqq in merge chain
      block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()
      block, bfq: remove bfq_log_bfqg()
      block, bfq: remove local variable 'split' in bfq_init_rq()
      block, bfq: remove local variable 'bfqq_already_existing' in bfq_init_rq()
      block, bfq: factor out a helper to split bfqq in bfq_init_rq()

Yue Haibing (1):
      blk-cgroup: Remove unused declaration blkg_path()

YueHaibing (1):
      drbd: Remove unused extern declarations

 MAINTAINERS                       |   5 +-
 block/bfq-cgroup.c                |   8 +-
 block/bfq-iosched.c               | 206 +++++++-------
 block/bfq-iosched.h               |   8 +-
 block/bio.c                       | 112 ++++++--
 block/blk-cgroup.c                |  23 +-
 block/blk-cgroup.h                |   1 -
 block/blk-iocost.c                |  10 +-
 block/blk-ioprio.c                |  57 +---
 block/blk-ioprio.h                |   9 -
 block/blk-merge.c                 | 162 +++++------
 block/blk-mq.c                    |  14 +-
 block/blk-rq-qos.c                |   2 +-
 block/blk-throttle.c              |  69 +++--
 block/blk-throttle.h              |   2 -
 block/blk.h                       |  74 +++--
 block/ioctl.c                     |   9 +-
 block/partitions/core.c           |   8 +-
 block/t10-pi.c                    |   8 +-
 drivers/block/drbd/drbd_int.h     |  11 -
 drivers/block/drbd/drbd_main.c    |   2 +-
 drivers/block/drbd/drbd_state.c   |   2 +-
 drivers/block/mtip32xx/mtip32xx.c |  19 +-
 drivers/block/nbd.c               |  28 +-
 drivers/block/pktcdvd.c           |   2 -
 drivers/block/rnbd/rnbd-srv.c     |  11 +-
 drivers/block/ublk_drv.c          |  62 +++--
 drivers/block/zram/zram_drv.c     |  16 +-
 drivers/block/zram/zram_drv.h     |   7 +-
 drivers/md/dm-raid.c              |   7 +-
 drivers/md/md-bitmap.c            | 568 +++++++++++++++++++++++++++++---------
 drivers/md/md-bitmap.h            | 268 ++++--------------
 drivers/md/md-cluster.c           |  91 +++---
 drivers/md/md.c                   | 332 ++++++++++------------
 drivers/md/md.h                   |  13 +-
 drivers/md/raid1-10.c             |   9 +-
 drivers/md/raid1.c                |  99 +++----
 drivers/md/raid10.c               |  75 ++---
 drivers/md/raid5-cache.c          |  14 +-
 drivers/md/raid5.c                | 157 ++++++-----
 drivers/md/raid5.h                |   2 +-
 drivers/nvme/common/keyring.c     |  58 +++-
 drivers/nvme/host/Kconfig         |   3 +-
 drivers/nvme/host/core.c          |  47 +++-
 drivers/nvme/host/fabrics.c       |   2 +-
 drivers/nvme/host/ioctl.c         |  26 +-
 drivers/nvme/host/nvme.h          |   7 +-
 drivers/nvme/host/pci.c           |  18 +-
 drivers/nvme/host/rdma.c          |   6 +-
 drivers/nvme/host/sysfs.c         |  90 ++++--
 drivers/nvme/host/tcp.c           |  57 +++-
 drivers/nvme/target/admin-cmd.c   |   2 -
 drivers/nvme/target/auth.c        |  12 +
 drivers/nvme/target/rdma.c        |   4 +-
 fs/btrfs/bio.c                    |  30 +-
 include/linux/bio.h               |   4 +-
 include/linux/blkdev.h            |   3 +-
 include/linux/mm.h                |   1 +
 include/linux/net.h               |  19 ++
 include/linux/nvme-keyring.h      |   6 +-
 include/linux/nvme-rdma.h         |   6 +-
 include/linux/nvme.h              |   8 +-
 include/uapi/linux/nbd.h          |   8 +-
 mm/gup.c                          |  13 +
 64 files changed, 1711 insertions(+), 1301 deletions(-)

-- 
Jens Axboe


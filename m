Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0D5380F
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715437430; cv=none; b=OerlL2JD+6A3EL+u2m8u9XxkoHMHkWBHMRR8UvbG/oOva91q5A4wm9ay+h/AX0ZcwpwzHUk69yfA8yaMhmwEQ6pbPrMGN+H+Oz/Acv8q3Fj3e1qNAWhMoLAlGb5Nq4cC4CN4NM8en0aFi/kPZ4mM+BRDYqS8uClxAPuMAWwnZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715437430; c=relaxed/simple;
	bh=ISQcMTSNLpna39sMAWic+aZOGw826B+nTJq2ypourUM=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=tfd3jV82aUV2Kqh1ycyFAfZxTyEJxRh4ALrkKv1uaVERHtJMhC1A7mxiTZT9ImqdKLZ8DIk1GuUhjX64JqgmeWcBLhFtHgxsl+bVOGj4TZWQu+qGO5QJRApOsQ4mU10jWqw14Fjq3ku6+32jBNLqBCTWP0h+lVssU68j0rczL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gDSBUgnm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gDSBUgnm"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b370e63d96so800329a91.3
        for <linux-block@vger.kernel.org>; Sat, 11 May 2024 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715437426; x=1716042226; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ij9QXghq5sT27AeIfJmkIvMJjsUJrqQk+pfwrsxkzdg=;
        b=gDSBUgnmhjd58mKwjm/3EIu2qRHOAF9kESgpiVKy/rH8ZEVCSZjbwUmKgsGQfNBD9G
         IuCHSdjYL1u+D1QNgKEzovnyMepHRESzlS4Yykb+9DjN6pVZ2HBSFY08XrHR0l48K0NT
         ZoW5hQMAd6R1wlz2twBOty3B00VZ8tAATgdIWc6ql1FcetbBh1hYNp5aPCqCzO/CMTPb
         0jA9r1i3zuEmJdMoB5go/LbKupKc6Sd/ZFv+UYQPOfBTB3jtx1r+WtUVzA4MYe1dIRPg
         8PuOsqx402u1yvuIKxoYpjCXbE9xvZvYKhoLpC3I44lZaez1KGOJ8weKjFxACpqC9vHv
         EQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715437426; x=1716042226;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ij9QXghq5sT27AeIfJmkIvMJjsUJrqQk+pfwrsxkzdg=;
        b=L1d1HlHQrBX2CgslEIaGR/oxhYvFuJm2vK6+Lwbkoo0J+jPjI9/32kef5oAs37QaBQ
         JcDGojW/946btHnBKwIU1FjP7L2BCXPXFs/JPaJYuOt+2Ogzd2MoocsseScDeNaejdwt
         BQWl5aXFWgNzc0SsEwyB75FGhttyvsi7W1SffJgvUllaxKlRtZ/YCcCI1hLkWBu9NT/5
         vuojVUqcTY1+e9jnVOuDcNDYnZiUFrPmJCosnMt1+r8fqi2WP8+1FEivOaHBd1ziw7SB
         5QZAOZWN+gKhzGdJbvNvfZyVt6U9Qab4ieORm/JUD/Xxj/mwurylFMg/kfwlyJ1Zp/ni
         Gsrw==
X-Gm-Message-State: AOJu0YzXG1RHnBVOEw/Or7KYrtEVGeQwqgxWR6tMP+CtPws4GguIBSJu
	jB0xAayCADNx9nFxRdwgBBNV1s+oDJe/JuEximqEzFMJ0bHu6onXcUh49hZHo4puqW2RO4g6Rkk
	H
X-Google-Smtp-Source: AGHT+IGDNG5WEuQP/IgpX5Iy7SwBeNBI/cpS4mT0KBzVCmEL/31wt1mp5zI1piVohwQ+2lkSzPIhfA==
X-Received: by 2002:a17:903:246:b0:1eb:50eb:c07d with SMTP id d9443c01a7336-1ef441aa0a2mr62186585ad.4.1715437425627;
        Sat, 11 May 2024 07:23:45 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30c09sm49396245ad.130.2024.05.11.07.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 07:23:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------s9OXSGZCNf0UTgCVqJ23M9Zz"
Message-ID: <93e54ea2-01c7-413b-a13d-2e731193acd7@kernel.dk>
Date: Sat, 11 May 2024 08:23:44 -0600
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
Subject: [GIT PULL] Block updates for 6.10-rc1

This is a multi-part message in MIME format.
--------------s9OXSGZCNf0UTgCVqJ23M9Zz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are the block updates for the 6.10 merge window. A pretty quiet
round on the block front this time. Notably absent are the nvme changes
for this series, as they have not been sent in yet. They will come in a
followup pull request before -rc1.

This pull request contains:

- Add a partscan attribute in sysfs, fixing an issue with systemd
  relying on an internal interface that went away.

- Attempt #2 at making long running discards interruptible. The previous
  attempt went into 6.9, but we ended up mostly reverting it as it had
  issues.

- Remove old ida_simple API in bcache

- Support for zoned write plugging, greatly improving the performance on
  zoned devices.

- Remove the old throttle low interface, which has been experimental
  since 2017 and never made it beyond that and isn't being used.

- Remove page->index debugging checks in brd, as it hasn't caught
  anything and prepares us for removing in struct page.

- MD pull request from Song

- Don't schedule block workers on isolated CPUs

This will throw a merge conflict in block/ioctl.c due to a fix that went
into 6.9 post -rc2, I'm attaching my resolution of it.

Outside of that, there are various conflicts with pending changes in the
other trees, I'll link them below. They are all pretty trivial. This is
mostly an issue with the VFS tree, something we really need to
coordinate better going forward.

https://lore.kernel.org/all/20240402112137.1ee85957@canb.auug.org.au/
https://lore.kernel.org/all/20240402112746.3864d8a6@canb.auug.org.au/
https://lore.kernel.org/all/20240416124426.624cfaf9@canb.auug.org.au/
https://lore.kernel.org/all/20240508130207.3d83702f@canb.auug.org.au/
https://lore.kernel.org/all/20240510123419.42f727c1@canb.auug.org.au/

Please pull!


The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.10/block-20240511

for you to fetch changes up to a3166c51702bb00b8f8b84022090cbab8f37be1a:

  blk-throttle: delay initialization until configuration (2024-05-09 09:44:56 -0600)

----------------------------------------------------------------
for-6.10/block-20240511

----------------------------------------------------------------
Christoph Hellwig (12):
      block: add a bio_list_merge_init helper
      blk-cgroup: use bio_list_merge_init
      dm: use bio_list_merge_init
      btrfs use bio_list_merge_init
      block: add a disk_has_partscan helper
      block: add a partscan sysfs attribute for disks
      block: refine the EOF check in blkdev_iomap_begin
      block: remove the discard_granularity check in __blkdev_issue_discard
      block: move discard checks into the ioctl handler
      block: add a bio_chain_and_submit helper
      block: add a blk_alloc_discard_bio helper
      blk-lib: check for kill signal in ioctl BLKDISCARD

Christophe JAILLET (1):
      bcache: Remove usage of the deprecated ida_simple_xx() API

Damien Le Moal (46):
      block: Restore sector of flush requests
      block: Remove req_bio_endio()
      block: Introduce blk_zone_update_request_bio()
      block: Introduce bio_straddles_zones() and bio_offset_from_zone_start()
      block: Allow using bio_attempt_back_merge() internally
      block: Remember zone capacity when revalidating zones
      block: Introduce zone write plugging
      block: Fake max open zones limit when there is no limit
      block: Allow zero value of max_zone_append_sectors queue limit
      block: Implement zone append emulation
      block: Allow BIO-based drivers to use blk_revalidate_disk_zones()
      dm: Use the block layer zone append emulation
      scsi: sd: Use the block layer zone append emulation
      ublk_drv: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
      null_blk: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
      null_blk: Introduce zone_append_max_sectors attribute
      null_blk: Introduce fua attribute
      nvmet: zns: Do not reference the gendisk conv_zones_bitmap
      block: Remove BLK_STS_ZONE_RESOURCE
      block: Simplify blk_revalidate_disk_zones() interface
      block: mq-deadline: Remove support for zone write locking
      block: Remove elevator required features
      block: Do not check zone type in blk_check_zone_append()
      block: Move zone related debugfs attribute to blk-zoned.c
      block: Replace zone_wlock debugfs entry with zone_wplugs entry
      block: Remove zone write locking
      block: Do not force select mq-deadline with CONFIG_BLK_DEV_ZONED
      block: Do not special-case plugging of zone write operations
      null_blk: Have all null_handle_xxx() return a blk_status_t
      null_blk: Do zone resource management only if necessary
      null_blk: Simplify null_zone_write()
      block: use a per disk workqueue for zone write plugging
      dm: Check that a zoned table leads to a valid mapped device
      block: Exclude conventional zones when faking max open limit
      block: Fix zone write plug initialization from blk_revalidate_zone_cb()
      block: Fix reference counting for zone write plugs in error state
      block: Hold a reference on zone write plugs to schedule submission
      block: Unhash a zone write plug only if needed
      block: Do not remove zone write plugs still in use
      block: Fix flush request sector restore
      block: Fix handling of non-empty flush write requests to zones
      block: Improve blk_zone_write_plug_bio_merged()
      block: Improve zone write request completion handling
      block: Simplify blk_zone_write_plug_bio_endio()
      block: Simplify zone write plug BIO abort
      block: Cleanup blk_revalidate_zone_cb()

Florian-Ewald Mueller (1):
      md: add check for sleepers in md_wakeup_thread()

INAGAKI Hiroshi (1):
      block: fix and simplify blkdevparts= cmdline parsing

Jens Axboe (2):
      Merge tag 'md-6.10-20240425' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.10/block
      Merge tag 'md-6.10-20240502' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.10/block

Jiapeng Chong (1):
      block/mq-deadline: Remove some unused functions

Johannes Thumshirn (1):
      block: check if zone_wplugs_hash exists in queue_zone_wplugs_show

John Garry (2):
      blk-throttle: Only use seq_printf() in tg_prfill_limit()
      block: Call blkdev_dio_unaligned() from blkdev_direct_IO()

Justin Stitt (1):
      block/ioctl: prefer different overflow check

Kefeng Wang (1):
      blk-cgroup: use group allocation/free of per-cpu counters API

Keith Busch (1):
      block: add a bio_await_chain helper

Li Nan (3):
      md: Fix overflow in is_mddev_idle
      md: don't account sync_io if iostats of the disk is disabled
      md: Revert "md: Fix overflow in is_mddev_idle"

Matthew Mirvish (1):
      bcache: fix variable length array abuse in btree_iter

Matthew Wilcox (Oracle) (1):
      brd: Remove use of page->index

Ming Lei (1):
      blk-mq: don't schedule block kworker on isolated CPUs

Yu Kuai (7):
      md/raid5: fix deadlock that raid5d() wait for itself to clear MD_SB_CHANGE_PENDING
      md: fix resync softlockup when bitmap size is less than array size
      block: add plug while submitting IO
      block: support to account io_ticks precisely
      block: fix that util can be greater than 100%
      blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW
      blk-throttle: delay initialization until configuration

Zhu Yanjun (2):
      null_blk: Fix missing mutex_destroy() at module removal
      null_blk: Fix the WARNING: modpost: missing MODULE_DESCRIPTION()

linke li (1):
      sbitmap: use READ_ONCE to access map->word

 Documentation/ABI/stable/sysfs-block       |   22 +-
 arch/loongarch/configs/loongson3_defconfig |    1 -
 block/Kconfig                              |   16 -
 block/Makefile                             |    1 -
 block/bio.c                                |   50 +-
 block/blk-cgroup-rwstat.c                  |   18 +-
 block/blk-cgroup.c                         |    9 +-
 block/blk-core.c                           |   26 +-
 block/blk-flush.c                          |    2 +
 block/blk-lib.c                            |   68 +-
 block/blk-merge.c                          |   25 +-
 block/blk-mq-debugfs-zoned.c               |   22 -
 block/blk-mq-debugfs.c                     |    3 +-
 block/blk-mq-debugfs.h                     |    6 +-
 block/blk-mq.c                             |  184 +--
 block/blk-mq.h                             |   31 -
 block/blk-settings.c                       |   46 +-
 block/blk-stat.c                           |    3 -
 block/blk-sysfs.c                          |   10 +-
 block/blk-throttle.c                       | 1019 ++---------------
 block/blk-throttle.h                       |   46 +-
 block/blk-zoned.c                          | 1690 ++++++++++++++++++++++++----
 block/blk.h                                |   97 +-
 block/elevator.c                           |   46 +-
 block/elevator.h                           |    1 -
 block/fops.c                               |   31 +-
 block/genhd.c                              |   32 +-
 block/ioctl.c                              |   42 +-
 block/mq-deadline.c                        |  204 +---
 block/partitions/cmdline.c                 |   49 +-
 block/partitions/core.c                    |    5 +-
 drivers/block/brd.c                        |   40 +-
 drivers/block/null_blk/main.c              |   43 +-
 drivers/block/null_blk/null_blk.h          |    2 +
 drivers/block/null_blk/zoned.c             |  358 +++---
 drivers/block/ublk_drv.c                   |    5 +-
 drivers/block/virtio_blk.c                 |    2 +-
 drivers/md/bcache/bset.c                   |   44 +-
 drivers/md/bcache/bset.h                   |   28 +-
 drivers/md/bcache/btree.c                  |   40 +-
 drivers/md/bcache/super.c                  |   15 +-
 drivers/md/bcache/sysfs.c                  |    2 +-
 drivers/md/bcache/writeback.c              |   10 +-
 drivers/md/dm-bio-prison-v2.c              |    3 +-
 drivers/md/dm-cache-target.c               |   12 +-
 drivers/md/dm-clone-target.c               |   14 +-
 drivers/md/dm-core.h                       |    2 +-
 drivers/md/dm-era-target.c                 |    3 +-
 drivers/md/dm-mpath.c                      |    3 +-
 drivers/md/dm-table.c                      |    3 +-
 drivers/md/dm-thin.c                       |   12 +-
 drivers/md/dm-vdo/data-vio.c               |    3 +-
 drivers/md/dm-vdo/flush.c                  |    3 +-
 drivers/md/dm-zone.c                       |  501 ++-------
 drivers/md/dm.c                            |   72 +-
 drivers/md/dm.h                            |    2 -
 drivers/md/md-bitmap.c                     |    6 +-
 drivers/md/md.c                            |    7 +-
 drivers/md/md.h                            |    3 +-
 drivers/md/raid5.c                         |   15 +-
 drivers/nvme/host/core.c                   |    2 +-
 drivers/nvme/target/zns.c                  |   10 +-
 drivers/scsi/scsi_lib.c                    |    1 -
 drivers/scsi/sd.c                          |    8 -
 drivers/scsi/sd.h                          |   19 -
 drivers/scsi/sd_zbc.c                      |  335 +-----
 fs/btrfs/raid56.c                          |    3 +-
 include/linux/bio.h                        |   11 +
 include/linux/blk-mq.h                     |   85 +-
 include/linux/blk_types.h                  |   30 +-
 include/linux/blkdev.h                     |  116 +-
 lib/sbitmap.c                              |    8 +-
 72 files changed, 2646 insertions(+), 3040 deletions(-)
 delete mode 100644 block/blk-mq-debugfs-zoned.c

-- 
Jens Axboe

--------------s9OXSGZCNf0UTgCVqJ23M9Zz
Content-Type: text/plain; charset=UTF-8; name="block-merge.txt"
Content-Disposition: attachment; filename="block-merge.txt"
Content-Transfer-Encoding: base64

Y29tbWl0IDg2MWYwNjMzYzkwZTQwNGU3MWJkNGExMmYzMDRhMWM2NzhkN2IwZmMKTWVyZ2U6
IDU1MjFjY2I3YzY5ZiBhMzE2NmM1MTcwMmIKQXV0aG9yOiBKZW5zIEF4Ym9lIDxheGJvZUBr
ZXJuZWwuZGs+CkRhdGU6ICAgU2F0IE1heSAxMSAwODowOTowMSAyMDI0IC0wNjAwCgogICAg
TWVyZ2UgYnJhbmNoICdmb3ItNi4xMC9ibG9jaycgaW50byB0ZXN0CiAgICAKICAgICogZm9y
LTYuMTAvYmxvY2s6ICg4NCBjb21taXRzKQogICAgICBibGstdGhyb3R0bGU6IGRlbGF5IGlu
aXRpYWxpemF0aW9uIHVudGlsIGNvbmZpZ3VyYXRpb24KICAgICAgYmxrLXRocm90dGxlOiBy
ZW1vdmUgQ09ORklHX0JMS19ERVZfVEhST1RUTElOR19MT1cKICAgICAgYmxvY2s6IGZpeCB0
aGF0IHV0aWwgY2FuIGJlIGdyZWF0ZXIgdGhhbiAxMDAlCiAgICAgIGJsb2NrOiBzdXBwb3J0
IHRvIGFjY291bnQgaW9fdGlja3MgcHJlY2lzZWx5CiAgICAgIGJsb2NrOiBhZGQgcGx1ZyB3
aGlsZSBzdWJtaXR0aW5nIElPCiAgICAgIGJjYWNoZTogZml4IHZhcmlhYmxlIGxlbmd0aCBh
cnJheSBhYnVzZSBpbiBidHJlZV9pdGVyCiAgICAgIGJjYWNoZTogUmVtb3ZlIHVzYWdlIG9m
IHRoZSBkZXByZWNhdGVkIGlkYV9zaW1wbGVfeHgoKSBBUEkKICAgICAgbWQ6IFJldmVydCAi
bWQ6IEZpeCBvdmVyZmxvdyBpbiBpc19tZGRldl9pZGxlIgogICAgICBibGstbGliOiBjaGVj
ayBmb3Iga2lsbCBzaWduYWwgaW4gaW9jdGwgQkxLRElTQ0FSRAogICAgICBibG9jazogYWRk
IGEgYmlvX2F3YWl0X2NoYWluIGhlbHBlcgogICAgICBibG9jazogYWRkIGEgYmxrX2FsbG9j
X2Rpc2NhcmRfYmlvIGhlbHBlcgogICAgICBibG9jazogYWRkIGEgYmlvX2NoYWluX2FuZF9z
dWJtaXQgaGVscGVyCiAgICAgIGJsb2NrOiBtb3ZlIGRpc2NhcmQgY2hlY2tzIGludG8gdGhl
IGlvY3RsIGhhbmRsZXIKICAgICAgYmxvY2s6IHJlbW92ZSB0aGUgZGlzY2FyZF9ncmFudWxh
cml0eSBjaGVjayBpbiBfX2Jsa2Rldl9pc3N1ZV9kaXNjYXJkCiAgICAgIGJsb2NrL2lvY3Rs
OiBwcmVmZXIgZGlmZmVyZW50IG92ZXJmbG93IGNoZWNrCiAgICAgIG51bGxfYmxrOiBGaXgg
dGhlIFdBUk5JTkc6IG1vZHBvc3Q6IG1pc3NpbmcgTU9EVUxFX0RFU0NSSVBUSU9OKCkKICAg
ICAgYmxvY2s6IGZpeCBhbmQgc2ltcGxpZnkgYmxrZGV2cGFydHM9IGNtZGxpbmUgcGFyc2lu
ZwogICAgICBibG9jazogcmVmaW5lIHRoZSBFT0YgY2hlY2sgaW4gYmxrZGV2X2lvbWFwX2Jl
Z2luCiAgICAgIGJsb2NrOiBhZGQgYSBwYXJ0c2NhbiBzeXNmcyBhdHRyaWJ1dGUgZm9yIGRp
c2tzCiAgICAgIGJsb2NrOiBhZGQgYSBkaXNrX2hhc19wYXJ0c2NhbiBoZWxwZXIKICAgICAg
Li4uCiAgICAKICAgIFNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4KCmRpZmYgLS1jYyBibG9jay9pb2N0bC5jCmluZGV4IGY1MDVmOWMzNDFlYixkN2E2YzY5
MzFhMWUuLmM3ZGIzYmQyZDY1MwotLS0gYS9ibG9jay9pb2N0bC5jCisrKyBiL2Jsb2NrL2lv
Y3RsLmMKQEBAIC05NSw5IC05NSwxMiArOTUsMTIgQEBAIHN0YXRpYyBpbnQgY29tcGF0X2Js
a3BnX2lvY3RsKHN0cnVjdCBibAogIHN0YXRpYyBpbnQgYmxrX2lvY3RsX2Rpc2NhcmQoc3Ry
dWN0IGJsb2NrX2RldmljZSAqYmRldiwgYmxrX21vZGVfdCBtb2RlLAogIAkJdW5zaWduZWQg
bG9uZyBhcmcpCiAgewotIAl1aW50NjRfdCByYW5nZVsyXTsKLSAJdWludDY0X3Qgc3RhcnQs
IGxlbiwgZW5kOworIAl1bnNpZ25lZCBpbnQgYnNfbWFzayA9IGJkZXZfbG9naWNhbF9ibG9j
a19zaXplKGJkZXYpIC0gMTsKICAJc3RydWN0IGlub2RlICppbm9kZSA9IGJkZXYtPmJkX2lu
b2RlOwogLQl1aW50NjRfdCByYW5nZVsyXSwgc3RhcnQsIGxlbjsKKysJdWludDY0X3QgcmFu
Z2VbMl0sIHN0YXJ0LCBsZW4sIGVuZDsKKyAJc3RydWN0IGJpbyAqcHJldiA9IE5VTEwsICpi
aW87CisgCXNlY3Rvcl90IHNlY3RvciwgbnJfc2VjdHM7CisgCXN0cnVjdCBibGtfcGx1ZyBw
bHVnOwogIAlpbnQgZXJyOwogIAogIAlpZiAoIShtb2RlICYgQkxLX09QRU5fV1JJVEUpKQpA
QEAgLTExMiwxMyAtMTE3LDEyICsxMTcsMTMgQEBACiAgCXN0YXJ0ID0gcmFuZ2VbMF07CiAg
CWxlbiA9IHJhbmdlWzFdOwogIAotIAlpZiAoc3RhcnQgJiA1MTEpCisgCWlmICghbGVuKQog
IAkJcmV0dXJuIC1FSU5WQUw7Ci0gCWlmIChsZW4gJiA1MTEpCisgCWlmICgoc3RhcnQgfCBs
ZW4pICYgYnNfbWFzaykKICAJCXJldHVybiAtRUlOVkFMOwogIAogLQlpZiAoc3RhcnQgKyBs
ZW4gPiBiZGV2X25yX2J5dGVzKGJkZXYpKQogKwlpZiAoY2hlY2tfYWRkX292ZXJmbG93KHN0
YXJ0LCBsZW4sICZlbmQpIHx8CiArCSAgICBlbmQgPiBiZGV2X25yX2J5dGVzKGJkZXYpKQog
IAkJcmV0dXJuIC1FSU5WQUw7CiAgCiAgCWZpbGVtYXBfaW52YWxpZGF0ZV9sb2NrKGlub2Rl
LT5pX21hcHBpbmcpOwo=

--------------s9OXSGZCNf0UTgCVqJ23M9Zz--

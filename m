Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA857C433EF
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F65960F46
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhJaToR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhJaToR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Oct 2021 15:44:17 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F6AC061714
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:41:45 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id w10so16364225ilc.13
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nGuuxj2YErdU2iJHaduqgdcrDwim27dEwG2QbG4m9d8=;
        b=HPUMJ2CbLYMhVGTwuPV9+JAstOrzcK9XFuOQZtqGlfCzS2AkUjkVo0XUzejjwzgEBB
         eAxp8ckJgtbUtFEB4SA51vYqdviqgmKIkIN2WKlOv5A4y7v/7yCH0c3ze/Ri4xd3dKPW
         q5TC5dGG5NqjHd82eGMOZRRUHmZWI0jFSjveJn/pQ9CZ0N+/600OjnblBnvmrAuTKO9Z
         nHZ3JnSYwrRQuM+tIo96PcapqfA9hGgEQiaWW+s58NI/32kUcxHB4YaDzR9jm57RhHdt
         e7wjn3fcngf+H6w1wKZFU/qfhi6f4ql4vd6MssD+UysfE+vwb4E6m0UK5ziA8I+v9toP
         d7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nGuuxj2YErdU2iJHaduqgdcrDwim27dEwG2QbG4m9d8=;
        b=kcYWuVHiQufFKcubF5XpCeT8uBhbZjg087DpmGFr44N3UjIZO5oWaTJvhwBCXGuuZ1
         n6q3zLEUU6clVbMFvdNWq+OiBwNcKlXtrrw4vndqBRHIO+ls+N/2ZVQ5dj8V7pveov1W
         adiJWt9yjVy6Ba6X+zhohOnPpz+FzWMNMCATNFiINxVg+tIlm4+CNG82QYAzrX1vD8Dr
         78eRB7TXoPm/xNfBSeVW7lZqtuFwPUCOJtT9QI4S/K9twSWnahwaBQawQEK5bGvOz3/V
         juCvHxqdqBhtIlS1QpiltezmQrTAO4vUOnmtfPhUvjkruxtr89PrRsSTpRK6Y2Hul29x
         A5pg==
X-Gm-Message-State: AOAM5334iQzzgdOqpTLjoo68u5u5fKDHc7smPVyxzWK0/eFjkZ1I+HAD
        xKMkbRm+Lsk8RLSae2V/aYqECDl5CMuFhw==
X-Google-Smtp-Source: ABdhPJxnaE1GVnRbC6ZD2cHkQgrJ61RfxQ9COdwBgnCcrDeCvaOl8bb967QMMGct6ZgaYPImoQVTHA==
X-Received: by 2002:a05:6e02:1ca6:: with SMTP id x6mr6362319ill.225.1635709304362;
        Sun, 31 Oct 2021 12:41:44 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u4sm6897006ilv.39.2021.10.31.12.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:41:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver updates for 5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <36d0a261-bd28-123d-5eb8-4003eac7fad7@kernel.dk>
Date:   Sun, 31 Oct 2021 13:41:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core block branch, here are the drivers updates for the
5.16-rc1 merge window:

- paride driver cleanups (Christoph)

- Remove cryptoloop support (Christoph)

- null_blk poll support (me)

- Now that add_disk() supports proper error handling, add it to various
  drivers (Luis)

- Make ataflop actually work again (Michael)

- s390 dasd fixes (Stefan, Heiko)

- nbd fixes (Yu, Ye)

- Remove redundant wq flush in mtip32xx (Christophe)

- NVMe updates
	- fix a multipath partition scanning deadlock
	  (Hannes Reinecke)
	- generate uevent once a multipath namespace is operational
	  again (Hannes Reinecke)
	- support unique discovery controller NQNs (Hannes Reinecke)
	- fix use-after-free when a port is removed (Israel Rukshin)
	- clear shadow doorbell memory on resets (Keith Busch)
	- use struct_size (Len Baker)
	- add error handling support for add_disk (Luis Chamberlain)
	- limit the maximal queue size for RDMA controllers
	  (Max Gurtovoy)
	- use a few more symbolic names (Max Gurtovoy)
	- fix error code in nvme_rdma_setup_ctrl (Max Gurtovoy)
	- add support for ->map_queues on FC (Saurav Kashyap)
	- support the current discovery subsystem entry
	  (Hannes Reinecke)
	- use flex_array_size and struct_size (Len Baker)

- bcache fixes (Christoph, Coly, Chao, Lin, Qing)

- MD updates (Christoph, Guoqing, Xiao)

- Misc fixes (Dan, Ding, Jiapeng, Shin'ichiro, Ye)

Please pull!


The following changes since commit 4f5022453acd0f7b28012e20b7d048470f129894:

  nvme: wire up completion batching for the IRQ path (2021-10-18 14:40:47 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/drivers-2021-10-29

for you to fetch changes up to 15dfc662ef31a20b59097d59b0792b06770255fa:

  null_blk: Fix handling of submit_queues and poll_queues attributes (2021-10-29 06:55:39 -0600)

----------------------------------------------------------------
for-5.16/drivers-2021-10-29

----------------------------------------------------------------
Chao Yu (1):
      bcache: fix error info in register_bcache()

Christoph Hellwig (12):
      pcd: move the identify buffer into pcd_identify
      pcd: cleanup initialization
      pf: cleanup initialization
      pd: cleanup initialization
      md: add the bitmap group to the default groups for the md kobject
      md: extend disks_mutex coverage
      md: properly unwind when failing to add the kobject in md_alloc
      bcache: remove the cache_dev_name field from struct cache
      bcache: remove the backing_dev_name field from struct cached_dev
      bcache: use bvec_kmap_local in bch_data_verify
      bcache: remove bch_crc64_update
      block: remove support for cryptoloop and the xor transfer

Christophe JAILLET (1):
      mtip32xx: Remove redundant 'flush_workqueue()' calls

Coly Li (2):
      bcache: reserve never used bits from bkey.high
      bcache: move uapi header bcache.h to bcache code directory

Dan Carpenter (3):
      pcd: fix error codes in pcd_init_unit()
      pf: fix error codes in pf_init_unit()
      sx8: fix an error code in carm_init_one()

Ding Senjie (1):
      md: bcache: Fix spelling of 'acquire'

Guoqing Jiang (4):
      md/raid1: only allocate write behind bio for WriteMostly device
      md/raid1: use rdev in raid1_write_request directly
      md/raid5: call roundup_pow_of_two in raid5_run
      md: remove unused argument from md_new_event

Hannes Reinecke (12):
      nvme: generate uevent once a multipath namespace is operational again
      nvmet: make discovery NQN configurable
      nvme: add CNTRLTYPE definitions for 'identify controller'
      nvmet: add nvmet_is_disc_subsys() helper
      nvmet: set 'CNTRLTYPE' in the identify controller data
      nvme: expose subsystem type in sysfs attribute 'subsystype'
      nvme: Add connect option 'discovery'
      nvme: display correct subsystem NQN
      nvme: drop scan_lock and always kick requeue list when removing namespaces
      nvme: add new discovery log page entry definitions
      nvmet: switch check for subsystem type
      nvmet: register discovery subsystem as 'current'

Heiko Carstens (2):
      s390/dasd: handle request magic consistently as unsigned int
      s390/dasd: fix kernel doc comment

Israel Rukshin (3):
      nvmet: fix use-after-free when a port is removed
      nvmet-rdma: fix use-after-free when a port is removed
      nvmet-tcp: fix use-after-free when a port is removed

Jens Axboe (6):
      null_blk: poll queue support
      swim3: add missing major.h include
      nvme: move command clear into the various setup helpers
      nvme: don't memset() the normal read/write command
      Merge tag 'nvme-5.16-2021-10-21' of git://git.infradead.org/nvme into for-5.16/drivers
      Merge tag 'nvme-5.16-2021-10-28' of git://git.infradead.org/nvme into for-5.16/drivers

Jiapeng Chong (1):
      block: ataflop: Fix warning comparing pointer to 0

Keith Busch (1):
      nvme-pci: clear shadow doorbell memory on resets

Len Baker (2):
      nvmet: use struct_size over open coded arithmetic
      nvmet: use flex_array_size and struct_size

Lin Feng (1):
      bcache: move calc_cached_dev_sectors to proper place on backing device detach

Luis Chamberlain (40):
      loop: add error handling support for add_disk()
      nbd: add error handling support for add_disk()
      aoe: add error handling support for add_disk()
      drbd: add error handling support for add_disk()
      n64cart: add error handling support for add_disk()
      pcd: add error handling support for add_disk()
      pcd: fix ordering of unregister_cdrom()
      pcd: capture errors on cdrom_register()
      pd: add error handling support for add_disk()
      mtip32xx: add error handling support for add_disk()
      pktcdvd: add error handling support for add_disk()
      block/rsxx: add error handling support for add_disk()
      block/sx8: add error handling support for add_disk()
      pf: add error handling support for add_disk()
      cdrom/gdrom: add error handling support for add_disk()
      rbd: add add_disk() error handling
      block/swim3: add error handling support for add_disk()
      floppy: fix add_disk() assumption on exit due to new developments
      floppy: use blk_cleanup_disk()
      floppy: fix calling platform_device_unregister() on invalid drives
      floppy: add error handling support for add_disk()
      amiflop: add error handling support for add_disk()
      swim: simplify using blk_cleanup_disk() on swim_remove()
      swim: add helper for disk cleanup
      swim: add a floppy registration bool which triggers del_gendisk()
      swim: add error handling support for add_disk()
      block/ataflop: use the blk_cleanup_disk() helper
      block/ataflop: add registration bool before calling del_gendisk()
      block/ataflop: provide a helper for cleanup up an atari disk
      block/ataflop: add error handling support for add_disk()
      xtensa/platforms/iss/simdisk: add error handling support for add_disk()
      md: add error handling support for add_disk()
      nvme-multipath: add error handling support for add_disk()
      dm: add add_disk() error handling
      bcache: add error handling support for add_disk()
      xen-blkfront: add error handling support for add_disk()
      m68k/emu/nfblock: add error handling support for add_disk()
      um/drivers/ubd_kern: add error handling support for add_disk()
      rnbd: add error handling support for add_disk()
      mtd: add add_disk() error handling

Max Gurtovoy (6):
      nvme-rdma: limit the maximal queue size for RDMA controllers
      nvmet: add get_max_queue_size op for controllers
      nvmet-rdma: implement get_max_queue_size controller op
      nvmet: use macro definition for setting nmic value
      nvmet: use macro definitions for setting cmic value
      nvme-rdma: fix error code in nvme_rdma_setup_ctrl

Michael Schmitz (2):
      block: ataflop: fix breakage introduced at blk-mq refactoring
      block: ataflop: more blk-mq refactoring fixes

Qing Wang (1):
      bcache: replace snprintf in show functions with sysfs_emit

Saurav Kashyap (2):
      nvme-fc: add support for ->map_queues
      qla2xxx: add ->map_queues support for nvme

Shin'ichiro Kawasaki (1):
      null_blk: Fix handling of submit_queues and poll_queues attributes

Stefan Haberland (5):
      s390/dasd: split up dasd_eckd_read_conf
      s390/dasd: move dasd_eckd_read_fc_security
      s390/dasd: summarize dasd configuration data in a separate structure
      s390/dasd: fix missing path conf_data after failed allocation
      s390/dasd: fix possibly missed path verification

Xiao Ni (1):
      md: update superblock after changing rdev flags in state_store

Ye Bin (1):
      nbd: Fix use-after-free in pid_show

Ye Guojin (1):
      block: aoe: fixup coccinelle warnings

Yu Kuai (7):
      nbd: don't handle response without a corresponding request message
      nbd: make sure request completion won't concurrent
      nbd: check sock index in nbd_read_stat()
      nbd: don't start request if nbd_queue_rq() failed
      nbd: clean up return value checking of sock_xmit()
      nbd: partition nbd_read_stat() into nbd_read_reply() and nbd_handle_reply()
      nbd: fix uaf in nbd_handle_reply()

 arch/m68k/emu/nfblock.c                            |   9 +-
 arch/um/drivers/ubd_kern.c                         |  13 +-
 arch/xtensa/platforms/iss/simdisk.c                |  13 +-
 drivers/block/Kconfig                              |  23 --
 drivers/block/Makefile                             |   1 -
 drivers/block/amiflop.c                            |   7 +-
 drivers/block/aoe/aoeblk.c                         |  19 +-
 drivers/block/ataflop.c                            | 109 +++---
 drivers/block/cryptoloop.c                         | 206 -----------
 drivers/block/drbd/drbd_main.c                     |   6 +-
 drivers/block/floppy.c                             |  34 +-
 drivers/block/loop.c                               | 384 ++-------------------
 drivers/block/loop.h                               |  30 --
 drivers/block/mtip32xx/mtip32xx.c                  |   6 +-
 drivers/block/n64cart.c                            |  12 +-
 drivers/block/nbd.c                                | 161 ++++++---
 drivers/block/null_blk/main.c                      | 192 ++++++++++-
 drivers/block/null_blk/null_blk.h                  |   6 +
 drivers/block/paride/pcd.c                         | 312 ++++++++---------
 drivers/block/paride/pd.c                          | 144 ++++----
 drivers/block/paride/pf.c                          | 236 ++++++-------
 drivers/block/pktcdvd.c                            |   4 +-
 drivers/block/rbd.c                                |   6 +-
 drivers/block/rnbd/rnbd-clt.c                      |  13 +-
 drivers/block/rsxx/core.c                          |   4 +-
 drivers/block/rsxx/dev.c                           |  12 +-
 drivers/block/swim.c                               |  35 +-
 drivers/block/swim3.c                              |   5 +-
 drivers/block/sx8.c                                |  15 +-
 drivers/block/xen-blkfront.c                       |   8 +-
 drivers/cdrom/gdrom.c                              |   7 +-
 drivers/md/bcache/bcache.h                         |   6 +-
 .../bcache.h => drivers/md/bcache/bcache_ondisk.h  |   4 +-
 drivers/md/bcache/bset.h                           |   2 +-
 drivers/md/bcache/btree.c                          |   2 +-
 drivers/md/bcache/debug.c                          |  15 +-
 drivers/md/bcache/features.c                       |   2 +-
 drivers/md/bcache/features.h                       |   3 +-
 drivers/md/bcache/io.c                             |  16 +-
 drivers/md/bcache/request.c                        |   6 +-
 drivers/md/bcache/super.c                          |  89 ++---
 drivers/md/bcache/sysfs.c                          |   2 +-
 drivers/md/bcache/sysfs.h                          |  18 +-
 drivers/md/bcache/util.h                           |  25 --
 drivers/md/dm.c                                    |   4 +-
 drivers/md/md.c                                    |  92 +++--
 drivers/md/md.h                                    |   2 +-
 drivers/md/raid1.c                                 |  13 +-
 drivers/md/raid10.c                                |   2 +-
 drivers/md/raid5.c                                 |   7 +-
 drivers/mtd/mtd_blkdevs.c                          |   6 +-
 drivers/nvme/host/core.c                           |  50 ++-
 drivers/nvme/host/fabrics.c                        |   6 +-
 drivers/nvme/host/fabrics.h                        |   8 +
 drivers/nvme/host/fc.c                             |  26 +-
 drivers/nvme/host/multipath.c                      |  32 +-
 drivers/nvme/host/nvme.h                           |   1 +
 drivers/nvme/host/pci.c                            |   9 +-
 drivers/nvme/host/rdma.c                           |  11 +-
 drivers/nvme/host/tcp.c                            |   2 +-
 drivers/nvme/host/zns.c                            |   2 +
 drivers/nvme/target/admin-cmd.c                    |  18 +-
 drivers/nvme/target/configfs.c                     |  41 +++
 drivers/nvme/target/core.c                         |  18 +-
 drivers/nvme/target/discovery.c                    |  19 +-
 drivers/nvme/target/fabrics-cmd.c                  |   3 +-
 drivers/nvme/target/nvmet.h                        |   6 +
 drivers/nvme/target/rdma.c                         |  30 ++
 drivers/nvme/target/tcp.c                          |  16 +
 drivers/s390/block/dasd.c                          |   9 +-
 drivers/s390/block/dasd_3990_erp.c                 |   6 +-
 drivers/s390/block/dasd_eckd.c                     | 294 ++++++++--------
 drivers/s390/block/dasd_eckd.h                     |  13 +-
 drivers/s390/block/dasd_erp.c                      |   8 +-
 drivers/s390/block/dasd_int.h                      |  11 +-
 drivers/s390/block/dasd_ioctl.c                    |   4 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |  15 +
 include/linux/nvme-fc-driver.h                     |   7 +
 include/linux/nvme-rdma.h                          |   2 +
 include/linux/nvme.h                               |  30 +-
 80 files changed, 1521 insertions(+), 1524 deletions(-)
 delete mode 100644 drivers/block/cryptoloop.c
 rename include/uapi/linux/bcache.h => drivers/md/bcache/bcache_ondisk.h (99%)

-- 
Jens Axboe


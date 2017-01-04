Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.10-rc2
Message-ID: <240a23f7-a730-2ce4-a4e9-f541771858cb@kernel.dk>
Date: Wed, 4 Jan 2017 09:46:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A set of fixes for the current series, one fixing a regression with
block size < page cache size in the alias series from Jan. Outside of
that, two small cleanups for wbt from Bart, a nvme pull request from
Christoph, and a few small fixes of documentation updates.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Andy Lutomirski (1):
      nvme/scsi: Remove START STOP emulation

Bart Van Assche (2):
      block: Make wbt_wait() definition consistent with declaration
      block: Avoid that sparse complains about context imbalance in __wbt_wait()

Chandan Rajendra (1):
      clean_bdev_aliases: Prevent cleaning blocks that are not in block range

Christoph Hellwig (2):
      nvme: update maintainers information
      block: add back plugging in __blkdev_direct_IO

Colin Ian King (1):
      nvmet/fcloop: remove some logically dead code performing redundant ret checks

Daniel Verkamp (1):
      nvmet: fix KATO offset in Set Features

James Smart (1):
      nvme/fc: correct some printk information

Jeff Moyer (1):
      block: fix up io_poll documentation

Jens Axboe (1):
      Merge branch 'nvme-4.10' of git://git.infradead.org/nvme into for-linus

Johannes Thumshirn (1):
      nvme/fc: simplify error handling of nvme_fc_create_hw_io_queues

Jon Derrick (1):
      genhd: remove dead and duplicated scsi code

Keith Busch (2):
      nvme: simplify stripe quirk
      nvme/pci: Delete misleading queue-wrap comment

Max Gurtovoy (1):
      nvme/pci: Fix whitespace problem

 Documentation/block/queue-sysfs.txt |  6 +++---
 MAINTAINERS                         |  9 +++++++--
 block/blk-wbt.c                     | 13 +++++++------
 drivers/nvme/host/core.c            | 17 ++---------------
 drivers/nvme/host/fc.c              | 19 ++++++++++---------
 drivers/nvme/host/nvme.h            |  1 -
 drivers/nvme/host/pci.c             | 13 +++----------
 drivers/nvme/host/scsi.c            | 27 ---------------------------
 drivers/nvme/target/admin-cmd.c     |  4 +---
 drivers/nvme/target/fcloop.c        |  4 ++--
 fs/block_dev.c                      |  3 +++
 fs/buffer.c                         |  2 +-
 include/linux/genhd.h               |  9 ---------
 13 files changed, 39 insertions(+), 88 deletions(-)

-- 
Jens Axboe

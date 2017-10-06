Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.14-rc4
Message-ID: <c15e011d-868c-d49c-73ea-dfbf6390202c@kernel.dk>
Date: Fri, 6 Oct 2017 13:00:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A collection of fixes for this series. This pull request contains:

- NVMe pull request from Christoph, one uuid attribute fix, and one fix
  for the controller memory buffer address for remapped BARs.

- use-after-free fix for bsg, from Benjamin Block.

- bcache race/use-after-free fix for a list traversal, fixing a
  regression in this merge window. From Coly Li.

- null_blk change configfs dependency change from a 'depends' to a
  'select'. This is a change from this merge window as well. From me.

- nbd signal fix from Josef, fixing a regression introduced with the
  status code changes.

- nbd MAINTAINERS mailing list entry update.

- blk-throttle stall fix from Joseph Qi.

- blk-mq-debugfs fix from Omar, fixing an issue where we don't register
  the IO scheduler debugfs directory, if the driver is loaded with it.
  Only shows up if you switch through the sysfs interface.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Benjamin Block (1):
      bsg-lib: fix use-after-free under memory-pressure

Christoph Hellwig (1):
      nvme-pci: Use PCI bus address for data/queues in CMB

Coly Li (1):
      bcache: use llist_for_each_entry_safe() in __closure_wake_up()

Jens Axboe (2):
      null_blk: change configfs dependency to select
      Merge branch 'nvme-4.14' of git://git.infradead.org/nvme into for-linus

Josef Bacik (1):
      nbd: fix -ERESTARTSYS handling

Joseph Qi (1):
      blk-throttle: fix possible io stall when upgrade to max

Martin Wilck (1):
      nvme: fix visibility of "uuid" ns attribute

Omar Sandoval (1):
      blk-mq-debugfs: fix device sched directory for default scheduler

Wouter Verhelst (1):
      MAINTAINERS: update list for NBD

 MAINTAINERS                 |  2 +-
 block/blk-mq-debugfs.c      |  6 +++++-
 block/blk-throttle.c        |  4 ++--
 block/bsg-lib.c             | 27 +++++++++++++++++++++------
 drivers/block/Kconfig       |  2 +-
 drivers/block/nbd.c         |  6 +++++-
 drivers/md/bcache/closure.c |  4 ++--
 drivers/nvme/host/core.c    |  2 +-
 drivers/nvme/host/pci.c     | 14 +++++++-------
 9 files changed, 45 insertions(+), 22 deletions(-)

-- 
Jens Axboe

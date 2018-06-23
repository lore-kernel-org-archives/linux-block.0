Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.18-rc2
Message-ID: <4860d1d6-db7e-75b8-1e6d-abcb53ffc287@kernel.dk>
Date: Sat, 23 Jun 2018 10:30:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A set of fixes that should go into this merge window. Note that I just
dropped a patch from the series, so the top most commit will look like
it just went in minutes ago.

This pull request contains:

- Further timeout fixes. We aren't quite there yet, so expect another
  round of fixes for that to completely close some of the IRQ vs
  completion races. (Christoph/Bart).

- Set of NVMe fixes from the usual suspects, mostly error handling.

- Two off-by-one fixes (Dan).

- Another bdi race fix (Jan).

- Fix nbd reconfigure with NBD_DISCONNECT_ON_CLOSE (Doron).

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180623


----------------------------------------------------------------
Bart Van Assche (2):
      Revert "block: Add warning for bi_next not NULL in bio_endio()"
      blk-mq: Fix timeout handling in case the timeout handler returns BLK_EH_DONE

Christoph Hellwig (1):
      block: fix timeout changes for legacy request drivers

Dan Carpenter (2):
      blk-mq-debugfs: Off by one in blk_mq_rq_state_name()
      block: sed-opal: Fix a couple off by one bugs

Doron Roberts-Kedes (1):
      nbd: Add the nbd NBD_DISCONNECT_ON_CLOSE config flag.

Geert Uytterhoeven (1):
      lightnvm: Remove depends on HAS_DMA in case of platform dependency

Israel Rukshin (1):
      nvme-rdma: Fix command completion race at error recovery

James Smart (1):
      nvme-fc: release io queues to allow fast fail

Jan Kara (1):
      bdi: Fix another oops in wb_workfn()

Jens Axboe (2):
      nvme-pci: limit max IO size and segments to avoid high order allocations
      Merge branch 'nvme-4.18' of git://git.infradead.org/nvme into for-linus

Jianchao Wang (1):
      nvme-pci: move nvme_kill_queues to nvme_remove_dead_ctrl

Max Gurtuvoy (1):
      nvmet: reset keep alive timer in controller enable

Sagi Grimberg (3):
      nvme-rdma: fix possible double free condition when failing to create a controller
      nvme-rdma: fix possible free of a non-allocated async event buffer
      nvme-rdma: don't override opts->queue_size

 block/bio.c                      |  3 --
 block/blk-core.c                 |  8 +----
 block/blk-mq-debugfs.c           |  2 +-
 block/blk-mq.c                   |  1 -
 block/blk-softirq.c              |  1 +
 block/blk-timeout.c              |  1 +
 block/sed-opal.c                 |  4 +--
 drivers/block/nbd.c              | 42 ++++++++++++++++++-----
 drivers/block/null_blk.c         |  2 +-
 drivers/lightnvm/Kconfig         |  2 +-
 drivers/nvme/host/core.c         |  1 +
 drivers/nvme/host/fc.c           |  6 ++--
 drivers/nvme/host/nvme.h         |  1 +
 drivers/nvme/host/pci.c          | 44 ++++++++++++++++++++----
 drivers/nvme/host/rdma.c         | 73 ++++++++++++++++++++--------------------
 drivers/nvme/target/core.c       |  8 +++++
 drivers/scsi/scsi_transport_fc.c |  2 +-
 include/linux/backing-dev-defs.h |  2 +-
 include/uapi/linux/nbd.h         |  3 ++
 mm/backing-dev.c                 | 20 ++++-------
 20 files changed, 142 insertions(+), 84 deletions(-)

-- 
Jens Axboe

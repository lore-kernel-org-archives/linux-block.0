Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.18-rc
Message-ID: <0ce6bcef-56f4-c953-1308-760f3670e653@kernel.dk>
Date: Fri, 8 Jun 2018 14:17:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A few fixes for this merge window, where some of them should go in
sooner rather than later, hence a new pull this week. This pull request
contains:

- Set of NVMe fixes, mostly follow up cleanups/fixes to the queue
  changes, but also teardown/removal and misc changes
  (Christop/Dan/Johannes/Sagi/Steve).

- Two lightnvm fixes for issues that showed up in this window
  (Colin/Wei).

- Failfast/driver flags inheritance for flush requests (Hannes).

- The md device put sanitization and fix (Kent).

- dm bio_set inheritance fix (me).

- nbd discard granularity fix (Josef).

- nbd consistency in command printing (Kevin).

- Loop recursion validation fix (Ted).

- Partition overlap check (Wang).

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180608


----------------------------------------------------------------
Christoph Hellwig (1):
      nvmet: return all zeroed buffer when we can't find an active namespace

Colin Ian King (1):
      lightnvm: pblk: fix resource leak of invalid_bitmap

Dan Carpenter (1):
      nvme: cleanup double shift issue

Hannes Reinecke (2):
      block: pass failfast and driver-specific flags to flush requests
      block: always set partition number to '0' in blk_partition_remap()

Jens Axboe (2):
      block: add bioset_init_from_src() helper
      dm: use bioset_init_from_src() to copy bio_set

Johannes Thumshirn (1):
      nvme: don't hold nvmf_transports_rwsem for more than transport lookups

Josef Bacik (1):
      nbd: set discard_alignment to the granularity

Keith Busch (6):
      nvme-pci: remove unnecessary nested locking
      nvme-pci: remove unnecessary completion doorbell check
      nvme-pci: queue creation fixes
      nvme-pci: remove HMB teardown on reset
      nvme-pci: unquiesce dead controller queues
      nvme-pci: make CMB SQ mod-param read-only

Kent Overstreet (1):
      md: Unify mddev destruction paths

Kevin Vigor (1):
      nbd: Consistently use request pointer in debug messages.

Sagi Grimberg (1):
      nvmet: filter newlines from user input

Steve Wise (1):
      nvme-rdma: correctly check for target keyed sgl support

Theodore Ts'o (1):
      loop: add recursion validation to LOOP_CHANGE_FD

Wang YanQing (1):
      block: add verifier for cmdline partition

Wei Yongjun (1):
      lightnvm: pblk: make symbol write_buffer_size static

 block/bio.c                     | 18 +++++++++++
 block/blk-core.c                |  2 +-
 block/blk-flush.c               |  9 ++++--
 block/partitions/cmdline.c      | 57 ++++++++++++++++++++++++++++++++++
 drivers/block/loop.c            | 68 +++++++++++++++++++++++------------------
 drivers/block/nbd.c             | 13 +++++---
 drivers/lightnvm/pblk-gc.c      |  3 +-
 drivers/lightnvm/pblk-init.c    |  2 +-
 drivers/md/dm.c                 | 22 +++++++++----
 drivers/md/md.c                 | 53 +++++++++++---------------------
 drivers/nvme/host/core.c        |  4 +--
 drivers/nvme/host/fabrics.c     |  3 +-
 drivers/nvme/host/fabrics.h     |  3 ++
 drivers/nvme/host/nvme.h        |  1 -
 drivers/nvme/host/pci.c         | 35 ++++++---------------
 drivers/nvme/host/rdma.c        |  5 +--
 drivers/nvme/target/admin-cmd.c | 15 +++++----
 drivers/nvme/target/configfs.c  | 14 ++++++---
 include/linux/bio.h             |  1 +
 19 files changed, 204 insertions(+), 124 deletions(-)

-- 
Jens Axboe

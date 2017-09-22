Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.14-rc2
Message-ID: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
Date: Fri, 22 Sep 2017 13:32:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A round of fixes for this series. This pull request contains:

- Two sets of NVMe pull requests from Christoph:

	- Fixes for the Fibre Channel host/target to fix spec
	  compliance
	- Allow a zero keep alive timeout
	- Make the debug printk for broken SGLs work better
	- Fix queue zeroing during initialization
	- Set of RDMA and FC fixes
	- Target div-by-zero fix

- bsg double-free fix.

- Series fixing a production softlockup for repeated flusher thread
  wakeups. This is larger than it looks, each patch is trivial.

- ndb unknown ioctl fix from Josef.

- Buffered vs O_DIRECT page cache inconsistency fix. Has been floating
  around for a long time, well reviewed. From Lukas.

- brd overflow fix from Mikulas.

- Fix for a loop regression in this merge window, where using a union
  for two members of the loop_cmd turned out to be a really bad idea.
  From Omar.

- Fix for an iostat regression fix in this series, using the wrong API
  to get at the block queue. From Shaohua.

- Fix for a potential blktrace delection deadlock. From Waiman.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (1):
      bsg-lib: don't free job in bsg_prepare_job

Guilherme G. Piccoli (1):
      nvme-fabrics: Allow 0 as KATO value

James Smart (17):
      nvme-fc: remove use of FC-specific error codes
      nvmet-fc: remove use of FC-specific error codes
      nvmet-fcloop: remove use of FC-specific error codes
      lpfc: remove use of FC-specific error codes
      qla2xxx: remove use of FC-specific error codes
      nvme.h: remove FC transport-specific error values
      nvme: add transport SGL definitions
      nvme-fc: use transport-specific sgl format
      nvmet-fc: fix failing max io queue connections
      nvme: stop aer posting if controller state not live
      nvme: allow timed-out ios to retry
      nvmet: implement valid sqhd values in completions
      nvme: fix sqhd reference when admin queue connect fails
      nvmet-fc: on port remove call put outside lock
      nvmet-fc: ensure target queue id within range.
      nvmet-fc: sync header templates with comments
      nvme-fcloop: fix port deletes and callbacks

Jens Axboe (9):
      buffer: cleanup free_more_memory() flusher wakeup
      fs: kill 'nr_pages' argument from wakeup_flusher_threads()
      fs-writeback: provide a wakeup_flusher_threads_bdi()
      page-writeback: pass in '0' for nr_pages writeback in laptop mode
      fs-writeback: make wb_start_writeback() static
      fs-writeback: move nr_pages == 0 logic to one location
      fs-writeback: only allow one inflight and pending full flush
      Merge branch 'wb-start-all' into for-linus
      Merge branch 'nvme-4.14' of git://git.infradead.org/nvme into for-linus

Josef Bacik (1):
      nbd: ignore non-nbd ioctl's

Keith Busch (2):
      nvme-pci: initialize queue memory before interrupts
      nvme-pci: Print invalid SGL only once

Lukas Czerner (1):
      fs: Fix page cache inconsistency when mixing buffered and AIO DIO

Mikulas Patocka (1):
      brd: fix overflow in __brd_direct_access

Omar Sandoval (1):
      loop: remove union of use_aio and ref in struct loop_cmd

Sagi Grimberg (3):
      nvme-core: Use nvme_wq to queue async events and fw activation
      nvme-rdma: give up reconnect if state change fails
      nvme-rdma: don't fully stop the controller in error recovery

Shaohua Li (1):
      block: fix a crash caused by wrong API

Waiman Long (1):
      blktrace: Fix potential deadlock between delete & sysfs ops

 block/blk-core.c                  |   3 ++
 block/bsg-lib.c                   |   1 -
 block/partition-generic.c         |   2 +-
 drivers/block/brd.c               |   2 +-
 drivers/block/loop.h              |   6 +--
 drivers/block/nbd.c               |   6 +++
 drivers/nvme/host/core.c          |   9 ++--
 drivers/nvme/host/fabrics.c       |  18 +++----
 drivers/nvme/host/fc.c            |  21 ++++----
 drivers/nvme/host/pci.c           |  34 ++++++++-----
 drivers/nvme/host/rdma.c          |   9 +++-
 drivers/nvme/target/core.c        |   9 ++--
 drivers/nvme/target/fabrics-cmd.c |   9 +++-
 drivers/nvme/target/fc.c          |  24 +++++----
 drivers/nvme/target/fcloop.c      | 104 ++++++++++++++------------------------
 drivers/nvme/target/nvmet.h       |   1 +
 drivers/scsi/lpfc/lpfc_nvme.c     |   2 +-
 drivers/scsi/qla2xxx/qla_nvme.c   |   2 +-
 fs/buffer.c                       |   2 +-
 fs/direct-io.c                    |  49 +++++++++++++++---
 fs/fs-writeback.c                 |  96 ++++++++++++++++++++++++-----------
 fs/iomap.c                        |  29 ++++++-----
 fs/sync.c                         |   2 +-
 include/linux/backing-dev-defs.h  |   1 +
 include/linux/backing-dev.h       |   2 -
 include/linux/blkdev.h            |   1 +
 include/linux/nvme-fc-driver.h    |  13 +++--
 include/linux/nvme.h              |  19 +++----
 include/linux/writeback.h         |   4 +-
 kernel/trace/blktrace.c           |  18 ++++---
 mm/filemap.c                      |  10 +++-
 mm/page-writeback.c               |  17 +------
 mm/vmscan.c                       |   2 +-
 33 files changed, 300 insertions(+), 227 deletions(-)

-- 
Jens Axboe

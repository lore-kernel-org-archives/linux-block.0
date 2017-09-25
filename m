Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.14-rc3
Message-ID: <299fd2d3-1cc6-f08e-88d3-b2976ff6a3dd@kernel.dk>
Date: Mon, 25 Sep 2017 09:31:39 -0600
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

This is a reworked pull request, without the writeback series. The
only oddball in here is the older buffered vs DIO bug fix, which
isn't a strict regression, but something that arguably should have
gone in a long time ago.

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
 fs/direct-io.c                    |  49 +++++++++++++++---
 fs/iomap.c                        |  29 ++++++-----
 include/linux/blkdev.h            |   1 +
 include/linux/nvme-fc-driver.h    |  13 +++--
 include/linux/nvme.h              |  19 +++----
 kernel/trace/blktrace.c           |  18 ++++---
 mm/filemap.c                      |  10 +++-
 25 files changed, 226 insertions(+), 175 deletions(-)
	
-- 
Jens Axboe

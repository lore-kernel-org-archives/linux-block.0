Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.13-rc3
Message-ID: <033841b1-91be-c747-a4f5-64b1217b2118@kernel.dk>
Date: Fri, 28 Jul 2017 09:31:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A small collection of fixes that should go into this series. This pull
request contains:

- NVMe pull request from Christoph, with various fixes for nvme proper
  and nvme-fc.

- Disabling runtime PM for blk-mq for now. With scsi now defaulting to
  using blk-mq, this reared it's head as an issue. Longer term we'll fix
  up runtime PM for blk-mq, for now just disable it to prevent a hang on
  laptop resume for some folks.

- blk-mq CPU <-> hw queue map fix from Christoph.

- xen/blkfront pull request from Konrad, with two small fixes for the
  blkfront driver.

- A few fixups for nbd from Joseph.

- A stable fix for pblk from Javier.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (1):
      xen-blkfront: Fix handling of non-supported operations

Christoph Hellwig (3):
      block: disable runtime-pm for blk-mq
      blk-mq: map queues to all present CPUs
      nvme-pci: fix HMB size calculation

Dongli Zhang (1):
      xen/blkfront: always allocate grants first from per-queue persistent grants

James Smart (2):
      nvme-fc: address target disconnect race conditions in fcp io submit
      nvme-fc: revise TRADDR parsing

Javier González (1):
      lightnvm: pblk: advance bio according to lba index

Jens Axboe (2):
      Merge branch 'stable/for-jens-4.13' of git://git.kernel.org/.../konrad/xen into for-linus
      Merge branch 'nvme-4.13' of git://git.infradead.org/nvme into for-linus

Johannes Thumshirn (1):
      nvme: also provide a UUID in the WWID sysfs attribute

Jon Derrick (1):
      nvme: fabrics commands should use the fctype field for data direction

Josef Bacik (4):
      nbd: allow multiple disconnects to be sent
      nbd: take tx_lock before disconnecting
      nbd: only set sndtimeo if we have a timeout set
      nbd: clear disconnected on reconnect

Junxiao Bi (1):
      xen-blkfront: fix mq start/stop race

Scott Bauer (1):
      nvme: validate admin queue before unquiesce

 block/blk-core.c             |   4 ++
 block/blk-mq-cpumap.c        |   4 +-
 drivers/block/nbd.c          |  18 +++++--
 drivers/block/xen-blkfront.c |  25 +++++----
 drivers/lightnvm/pblk-rb.c   |   4 +-
 drivers/lightnvm/pblk-read.c |  23 +++++---
 drivers/lightnvm/pblk.h      |   2 +-
 drivers/nvme/host/core.c     |   6 ++-
 drivers/nvme/host/fc.c       | 121 +++++++++++++++++++++++--------------------
 drivers/nvme/host/pci.c      |   6 +--
 drivers/nvme/target/fc.c     | 101 +++++++++++++++++++-----------------
 include/linux/nvme-fc.h      |  19 +++++++
 include/linux/nvme.h         |   2 +-
 13 files changed, 197 insertions(+), 138 deletions(-)

-- 
Jens Axboe

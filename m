Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.12-rc
Message-ID: <2abeeb1f-7ed5-3c8f-2df5-24fd2bc056aa@kernel.dk>
Date: Fri, 9 Jun 2017 08:16:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A set of fixes in the area of block IO, that should go into the next -rc
release. This pull request contains:

- An OOPS fix from Dmitry, fixing a regression with the bio integrity
  code in this series.

- Fix truncation of elevator io context cache name, from Eric Biggers.

- NVMe pull from Christoph includes FC fixes from James, APST
  fixes/tweaks from Kai-Heng, removal fix from Rakesh, and an RDMA fix
  from Sagi.

- Two tweaks for the block throttling code. One from Joseph Qi, fixing
  an oops from the timer code, and one from Shaohua, improving the
  behavior on rotatonal storage.

- Two blk-mq fixes from Ming, fixing corner cases with the direct issue
  code.

- Locking fix for bfq cgroups from Paolo.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Dmitry Monakhov (1):
      bio-integrity: Do not allocate integrity context for bio w/o data

Eric Biggers (1):
      elevator: fix truncation of icq_cache_name

James Smart (2):
      nvme-fc: on lldd/transport io error, terminate association
      nvme-fc: fix missing put reference on controller create failure

James Wang (1):
      Fix loop device flush before configure v3

Jens Axboe (1):
      Merge branch 'nvme-4.12' of git://git.infradead.org/nvme into for-linus

Joseph Qi (1):
      blk-throttle: fix NULL pointer dereference in throtl_schedule_pending_timer

Kai-Heng Feng (2):
      nvme: only consider exit latency when choosing useful non-op power states
      nvme: relax APST default max latency to 100ms

Ming Lei (3):
      blk-mq: pass correct hctx to blk_mq_try_issue_directly
      blk-mq: fix direct issue
      nvme: fix hang in remove path

Paolo Valente (1):
      block, bfq: access and cache blkg data only when safe

Rakesh Pandit (1):
      nvme-pci: fix multiple ctrl removal scheduling

Sagi Grimberg (1):
      nvme-rdma: fast fail incoming requests while we reconnect

Shaohua Li (1):
      blk-throttle: set default latency baseline for harddisk

 block/bfq-cgroup.c       | 116 +++++++++++++++++++++++++++++++++++++----------
 block/bfq-iosched.c      |   2 +-
 block/bfq-iosched.h      |  23 +++++-----
 block/bio-integrity.c    |   3 ++
 block/blk-mq.c           |  25 ++++++----
 block/blk-throttle.c     |  22 +++++++--
 drivers/block/loop.c     |   3 ++
 drivers/nvme/host/core.c |  21 ++++++---
 drivers/nvme/host/fc.c   |  20 +++++++-
 drivers/nvme/host/pci.c  |  13 +++---
 drivers/nvme/host/rdma.c |  44 ++++++++++++------
 include/linux/elevator.h |   2 +-
 12 files changed, 214 insertions(+), 80 deletions(-)

-- 
Jens Axboe

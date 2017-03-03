Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <8fcf6068-2a97-214e-b745-b57078233fb5@kernel.dk>
Date: Thu, 2 Mar 2017 21:07:33 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A collection of fixes for this merge window, either fixes for existing
issues, or parts that were waiting for acks to come in. This pull
request contains:

- Allocation of nvme queues on the right node from Shaohua. This was
  ready long before the merge window, but waiting on an ack from Bjorn
  on the PCI bit. Now that we have that, the three patches can go in.

- Two fixes for blk-mq-sched with nvmeof, which uses hctx specific
  request allocations. This caused an oops. One part from Sagi, one part
  from Omar.

- A loop partition scan deadlock fix from Omar, fixing a regression in
  this merge window.

- A 3 patch series from Keith, closing up a hole on clearing out
  requests on shutdown/resume.

- A stable fix for nbd from Josef, fixing a leak of sockets.

- Two fixes for a regression in this window from Jan, fixing a problem
  with one of his earlier patches dealing with queue vs bdi life times.

- A fix for a regression with virtio-blk, causing an IO stall if
  scheduling is used. From me.

- A fix for an io context lock ordering problem. From me.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jan Kara (2):
      block: Initialize bd_bdi on inode initialization
      block: Move bdi_unregister() to del_gendisk()

Jens Axboe (2):
      block: don't call ioc_exit_icq() with the queue lock held for blk-mq
      blk-mq: ensure that bd->last is always set correctly

Josef Bacik (1):
      nbd: stop leaking sockets

Keith Busch (3):
      blk-mq: Export blk_mq_freeze_queue_wait
      blk-mq: Provide freeze queue timeout
      nvme: Complete all stuck requests

Omar Sandoval (4):
      blk-mq: make blk_mq_alloc_request_hctx() allocate a scheduler request
      blk-mq: kill blk_mq_set_alloc_data()
      blk-mq: move update of tags->rqs to __blk_mq_alloc_request()
      loop: fix LO_FLAGS_PARTSCAN hang

Sagi Grimberg (1):
      blk-mq-sched: Allocate sched reserved tags as specified in the original queue tagset

Shaohua Li (3):
      blk-mq: allocate blk_mq_tags and requests in correct node
      PCI: add an API to get node from vector
      nvme: allocate nvme_queue in correct node

 block/blk-core.c         |   1 -
 block/blk-ioc.c          |  44 ++++++++++++-----
 block/blk-mq-sched.c     |  16 +++----
 block/blk-mq-tag.c       |   2 +-
 block/blk-mq-tag.h       |   6 +++
 block/blk-mq.c           | 120 ++++++++++++++++++++++++++++++++++-------------
 block/blk-mq.h           |  10 ----
 block/blk-sysfs.c        |   2 -
 block/elevator.c         |   2 -
 block/genhd.c            |   5 ++
 drivers/block/loop.c     |  15 +++---
 drivers/block/nbd.c      |   4 +-
 drivers/nvme/host/core.c |  47 +++++++++++++++++++
 drivers/nvme/host/nvme.h |   4 ++
 drivers/nvme/host/pci.c  |  45 ++++++++++++++----
 drivers/pci/msi.c        |  16 +++++++
 fs/block_dev.c           |   6 ++-
 include/linux/blk-mq.h   |   3 ++
 include/linux/pci.h      |   6 +++
 19 files changed, 265 insertions(+), 89 deletions(-)

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.13-rc
Message-ID: <a8845bba-c6d2-ec54-89db-cfd752d88130@kernel.dk>
Date: Fri, 18 Aug 2017 13:23:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A small set of fixes that should go into this release. This pull request
contains:

- An NVMe pull request from Christoph, with a few select fixes. One of
  them fix a polling regression in this series, in which it's trivial to
  cause the kernel to disable most of the hardware queue interrupts.

- Fixup for a blk-mq queue usage imbalance on request allocation, from
  Keith.

- A xen block pull request from Konrad, fixing two issues with
  xen/xen-blkfront.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (2):
      nvme-fabrics: fix reporting of unrecognized options
      blk-mq-pci: add a fallback when pci_irq_get_affinity returns NULL

James Smart (2):
      nvmet-fc: correct use after free on list teardown
      nvmet-fc: eliminate incorrect static markers on local variables

Jens Axboe (2):
      Merge branch 'stable/for-jens-4.13' of git://git.kernel.org/.../konrad/xen into for-linus
      Merge branch 'nvme-4.13' of git://git.infradead.org/nvme into for-linus

Keith Busch (2):
      blk-mq: Fix queue usage on failed request allocation
      nvme-pci: set cqe_seen on polled completions

Martin Wilck (1):
      nvmet: don't overwrite identify sn/fr with 0-bytes

Munehisa Kamata (1):
      xen-blkfront: use a right index when checking requests

Roger Pau Monne (1):
      xen: fix bio vec merging

 block/blk-mq-pci.c              | 8 +++++++-
 block/blk-mq.c                  | 5 ++---
 drivers/block/xen-blkfront.c    | 6 +++---
 drivers/nvme/host/fabrics.c     | 3 ++-
 drivers/nvme/host/pci.c         | 5 ++---
 drivers/nvme/target/admin-cmd.c | 6 ------
 drivers/nvme/target/fc.c        | 9 +++++----
 drivers/xen/biomerge.c          | 3 +--
 8 files changed, 22 insertions(+), 23 deletions(-)

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.20-rc2
Message-ID: <08927d57-4155-b97e-0229-77b65b9eeb32@kernel.dk>
Date: Fri, 9 Nov 2018 12:29:38 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A select set of fixes that should go into this release. This pull
request contains:

- Two fixes for an ubd regression, one for missing locking, and one for
  a missing initialization of a field. The latter was an old latent bug,
  but it's now visible and triggers (Me, Anton Ivanov)

- Set of NVMe fixes via Christoph, but applied manually due to a git
  tree mixup (Christoph, Sagi)

- Fix for a discard split regression, in three patches (Ming)

- Update libata git trees (Geert)

- SPDX identifier for sata_rcar (Kuninori Morimoto)

- Virtual boundary merge fix (Johannes)

- Preemptively clear memory we are going to pass to userspace, in case
  the driver does a short read (Keith)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181109


----------------------------------------------------------------
Anton Ivanov (1):
      ubd: fix missing initialization of io_req

Christoph Hellwig (1):
      Revert "nvmet-rdma: use a private workqueue for delete"

Geert Uytterhoeven (1):
      MAINTAINERS: Fix remaining pointers to obsolete libata.git

Jens Axboe (1):
      ubd: fix missing lock around request issue

Johannes Thumshirn (1):
      block: respect virtual boundary mask in bvecs

Keith Busch (1):
      block: Clear kernel memory before copying to user

Kuninori Morimoto (1):
      sata_rcar: convert to SPDX identifiers

Ming Lei (3):
      block: make sure discard bio is aligned with logical block size
      block: cleanup __blkdev_issue_discard()
      block: make sure writesame bio is aligned with logical block size

Sagi Grimberg (2):
      nvmet: don't try to add ns to p2p map unless it actually uses it
      nvme: make sure ns head inherits underlying device limits

 MAINTAINERS                   |  6 +++---
 arch/um/drivers/ubd_kern.c    | 12 ++++++++----
 block/bio.c                   |  1 +
 block/blk-lib.c               | 26 +++++++-------------------
 block/blk-merge.c             |  5 +++--
 block/blk.h                   | 12 +++++++++++-
 drivers/ata/sata_rcar.c       |  6 +-----
 drivers/nvme/host/core.c      |  4 +++-
 drivers/nvme/host/multipath.c |  1 +
 drivers/nvme/target/core.c    |  2 +-
 drivers/nvme/target/rdma.c    | 19 ++++---------------
 11 files changed, 43 insertions(+), 51 deletions(-)

-- 
Jens Axboe

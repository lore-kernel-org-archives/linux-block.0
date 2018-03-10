Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block IO bits for 4.16-rc5
Message-ID: <e839cc6b-72d3-6606-a062-1261ac502669@kernel.dk>
Date: Fri, 9 Mar 2018 22:21:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Here are a set of fixes for the current release. This pull request
contains:

- Pull request from Konrad, with a single xen-blkfront fix from Bhavesh
  with a multiqueue fix when detaching/re-attaching.

- Pull request from Keith for NVMe, with a few important fixes,
  including a revert for a sysfs fix that caused some user space
  confusion.

- Two bcache fixes by way of Michael Lyle.

- A loop regression fix, fixing an issue with lost writes on DAX.


Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180309


----------------------------------------------------------------
Bhavesh Davda (1):
      xen-blkfront: move negotiate_mq to cover all cases of new VBDs

Christoph Hellwig (1):
      Revert "nvme: create 'slaves' and 'holders' entries for hidden controllers"

James Smart (1):
      nvme_fc: rework sqsize handling

Jens Axboe (2):
      Merge branch 'stable/for-jens-4.15' of git://git.kernel.org/.../konrad/xen into for-linus
      Merge branch 'nvme-4.16-rc5' of git://git.infradead.org/nvme into for-linus

Michael Lyle (1):
      bcache: don't attach backing with duplicate UUID

Ming Lei (1):
      nvme: pci: pass max vectors as num_possible_cpus() to pci_alloc_irq_vectors

Roland Dreier (1):
      nvme-fabrics: Ignore nr_io_queues option for discovery controllers

Ross Zwisler (1):
      loop: Fix lost writes caused by missing flag

Tang Junhui (1):
      bcache: fix crashes in duplicate cache device register

Wen Xiong (1):
      nvme-pci: Fix EEH failure on ppc

 drivers/block/loop.c          |  2 +-
 drivers/block/xen-blkfront.c  | 17 ++++++++---------
 drivers/md/bcache/super.c     | 27 +++++++++++++++++++++------
 drivers/nvme/host/core.c      |  2 --
 drivers/nvme/host/fabrics.c   |  5 +++++
 drivers/nvme/host/fc.c        | 27 +++++++++++++++++----------
 drivers/nvme/host/multipath.c | 30 ------------------------------
 drivers/nvme/host/nvme.h      |  8 --------
 drivers/nvme/host/pci.c       | 15 ++++++++-------
 9 files changed, 60 insertions(+), 73 deletions(-)

-- 
Jens Axboe

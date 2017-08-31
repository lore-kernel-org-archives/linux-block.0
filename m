Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.13-final
Message-ID: <cff8b71a-cebb-0269-ea62-06d328505941@kernel.dk>
Date: Thu, 31 Aug 2017 15:28:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Unfortunately a few issues that warrant sending another pull request,
even if I had hoped to avoid it. This pull request contains:

- A fix for multiqueue xen-blkback, on tear down / disconnect.

- A few fixups for NVMe, including a wrong bit definition, fix for host
  memory buffers, and an nvme rdma page size fix.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Annie Li (1):
      xen-blkback: stop blkback thread of every queue in xen_blkif_disconnect

Changpeng Liu (1):
      nvme: fix the definition of the doorbell buffer config support bit

Christoph Hellwig (1):
      nvme-pci: use dma memory for the host memory buffer descriptors

Jens Axboe (2):
      Merge branch 'stable/for-jens-4.13' of git://git.kernel.org/.../konrad/xen into for-linus
      Merge branch 'nvme-4.13' of git://git.infradead.org/nvme into for-linus

Max Gurtovoy (1):
      nvme-rdma: default MR page size to 4k

 drivers/block/xen-blkback/xenbus.c | 10 ++++++++--
 drivers/nvme/host/pci.c            | 22 +++++++++++-----------
 drivers/nvme/host/rdma.c           |  8 ++++++--
 include/linux/nvme.h               |  2 +-
 4 files changed, 26 insertions(+), 16 deletions(-)

-- 
Jens Axboe

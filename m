To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] Block fixes for 4.8-rc
Message-ID: <f8f3d0fd-23e7-0ac5-fb67-2abc48708a32@fb.com>
Date: Fri, 2 Sep 2016 20:12:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Collection of fixes for the nvme over fabrics code. The shortlog is
below, probably no need to further detail it.

Please pull, thanks!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (2):
       nvme-fabrics: get a reference when reusing a nvme_host structure
       nvme: fabrics drivers don't need the nvme-pci driver

Colin Ian King (1):
       nvme-rdma: initialize ret to zero to avoid returning garbage

Daniel Verkamp (1):
       nvme-fabrics: change NQN UUID to big-endian format

Jay Freyensee (4):
       nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
       fabrics: define admin sqsize min default, per spec
       nvme-rdma: fix sqsize/hsqsize per spec
       nvme-loop: set sqsize to 0-based value, per spec

Jens Axboe (1):
       Merge branch 'nvmf-4.8-rc' of 
git://git.infradead.org/nvme-fabrics into for-linus

Sagi Grimberg (2):
       nvme-rdma: Get rid of duplicate variable
       nvme-rdma: Get rid of redundant defines

Vincent Stehlé (1):
       nvmet-rdma: Fix use after free

  drivers/nvme/host/Kconfig   |  2 +-
  drivers/nvme/host/fabrics.c | 23 ++++++++++++++++-------
  drivers/nvme/host/fabrics.h |  2 +-
  drivers/nvme/host/rdma.c    | 46 
+++++++++++++++++++++++++++------------------
  drivers/nvme/target/Kconfig |  2 +-
  drivers/nvme/target/loop.c  |  4 ++--
  drivers/nvme/target/rdma.c  |  7 ++++---
  include/linux/nvme.h        |  2 +-
  8 files changed, 54 insertions(+), 34 deletions(-)

-- 
Jens Axboe

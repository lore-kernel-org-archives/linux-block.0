Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Two block fixes for 4.12 final
Message-ID: <c75d37a6-8174-4780-5622-b3cb98f2e179@kernel.dk>
Date: Thu, 29 Jun 2017 09:16:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Two fixes that should go into this release. One is an nvme regression
fix from Keith, fixing a missing queue freeze if the controller is being
reset. This causes the reset to hang. The other is a fix for a leak of
the bio protection info, if smaller sized O_DIRECT is used. This fix
should be more involved as we have other problematic paths in the
kernel, but given as this isn't a regression in this series, we'll
tackle those for 4.13.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jens Axboe (1):
      block: provide bio_uninit() free freeing integrity/task associations

Keith Busch (1):
      nvme/pci: Fix stuck nvme reset

 block/bio.c             | 12 +++++++++---
 drivers/nvme/host/pci.c |  3 ++-
 fs/block_dev.c          |  5 ++++-
 include/linux/bio.h     |  1 +
 4 files changed, 16 insertions(+), 5 deletions(-)

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block IO fixes for 4.10-rc1
Message-ID: <18af05db-4f43-a3e8-d40a-5244ef85eb5a@kernel.dk>
Date: Wed, 14 Dec 2016 15:56:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A few fixes that I collected as post-merge. I was going to wait a bit
with sending this out, but the O_DIRECT fix should really go in sooner
rather than later.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Andy Lutomirski (1):
      nvme/pci: Log PCI_STATUS when the controller dies

Gabriel Krisman Bertazi (2):
      blk-mq: Avoid memory reclaim when remapping queues
      blk-mq: Fix failed allocation path when mapping queues

NeilBrown (1):
      block_dev: don't test bdev->bd_contains when it is not stable

Shaohua Li (1):
      block_dev: don't update file access position for sync direct IO

 block/blk-mq.c          | 32 ++++++++++++++++++++++++--------
 drivers/nvme/host/pci.c | 22 +++++++++++++++++++---
 fs/block_dev.c          |  7 ++-----
 3 files changed, 45 insertions(+), 16 deletions(-)

-- 
Jens Axboe

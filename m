Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.9-rc
Message-ID: <f072dd2e-8a79-e768-1525-470cbd4e9da4@kernel.dk>
Date: Thu, 17 Nov 2016 14:36:12 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A set of fixes, one for NVMe from Keith, and a set for nvme-{rdma,t,f}
from the usual suspects, fixing actual problems that would be a shame to
release 4.9 with.

Please pull!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (1):
       nvmet-rdma: Fix possible NULL deref when handling rdma cm events

Christoph Hellwig (1):
       nvme-rdma: reject non-connect commands before the queue is live

Jens Axboe (1):
       Merge branch 'nvmf-4.9-rc' of 
git://git.infradead.org/nvme-fabrics into for-linus

Keith Busch (1):
       nvme/pci: Don't free queues on error

Sagi Grimberg (3):
       nvmet: Don't queue fatal error work if csts.cfs is set
       nvmet-rdma: don't forget to delete a queue from the list of 
connection failed
       nvmet-rdma: drain the queue-pair just before freeing it

Steve Wise (1):
       nvme-rdma: stop and free io queues on connect failure

  drivers/nvme/host/pci.c    | 18 ++++--------------
  drivers/nvme/host/rdma.c   | 42 +++++++++++++++++++++++++++++++++++++++---
  drivers/nvme/target/core.c | 10 +++++++---
  drivers/nvme/target/rdma.c | 18 +++++++++++++++---
  4 files changed, 65 insertions(+), 23 deletions(-)

-- 
Jens Axboe

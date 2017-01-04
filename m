Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Merlin <marc@merlins.org>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/6] NVMe related fixes
Date: Wed,  4 Jan 2017 17:41:05 -0500
Message-Id: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

I've been looking into an old regression origianlly reported here:

  http://lists.infradead.org/pipermail/linux-nvme/2016-August/005699.html

The root cause is blk-mq's hot cpu notifier is stuck indefinitely during
suspend on requests that entered a stopped hardware context, and that
hardware context will not be restarted until suspend completes.

I originally set out to unwind the requests and block on reentry,
but blk-mq doesn't support doing that: once a request enters a hardware
context, it needs to complete on that context. Since the context won't be
starting again, we need to do _something_ with those entered requests,
and unfortunately ending them in error is the simplest way to resolve
the deadlock.

Alternatively, it might have been nice if we didn't need to freeze at
all if we could leverage the new blk_mq_quiesce_queue, but that wouldn't
work when the queue map needs to be redone...

Any feedback appreciated. Thanks!

Keith Busch (6):
  irq/affinity: Assign all online CPUs to vectors
  irq/affinity: Assign offline CPUs a vector
  nvme/pci: Start queues after tagset is updated
  blk-mq: Update queue map when changing queue count
  blk-mq: Fix freeze deadlock
  blk-mq: Remove unused variable

 block/blk-mq.c          | 86 +++++++++++++++++++++++++++++++++++++++++--------
 drivers/nvme/host/pci.c |  2 +-
 kernel/irq/affinity.c   | 17 ++++++++--
 3 files changed, 87 insertions(+), 18 deletions(-)

-- 
2.5.5

Return-Path: <tglx@linutronix.de>
Message-Id: <20160920152020.777561324@linutronix.de>
Date: Tue, 20 Sep 2016 15:21:54 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwing <hch@lst.de>, Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch V2 0/2] block/mq: Convert to new hotplug state machine
List-ID: <linux-block@vger.kernel.org>

The following series converts block/mq to the new hotplug state
machine. The series is against block.git/for-next and depends on

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/for-block

This branch contains the necessary infrastructure for multi-instance
callbacks which allows us to remove blk-mq-cpu.c completely. It can be
pulled into the block tree.

Changes vs. V1:

  Use the multi instance callbacks and remove the private notifier handling
  in the block code.

Thanks,

	tglx
---
 a/block/blk-mq-cpu.c     |   67 -------------------------
 b/include/linux/blk-mq.h |    8 ---
 block/Makefile           |    2 
 block/blk-mq.c           |  123 +++++++++++++++++++++--------------------------
 block/blk-mq.h           |    7 --
 5 files changed, 58 insertions(+), 149 deletions(-)

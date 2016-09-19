Return-Path: <tglx@linutronix.de>
Message-Id: <20160919212207.161583394@linutronix.de>
Date: Mon, 19 Sep 2016 21:28:16 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwing <hch@lst.de>, Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch 0/3] block/mq: Convert to the new hotplug state machine
List-ID: <linux-block@vger.kernel.org>

The following series converts block/mq to the new hotplug state
machine. Patch 1/3 reserves the states for the block layer and is already applied to

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/for-block

to avoid merge conflicts. This branch can be pulled into the block layer
instead of applying patch 1/3 manually,

Thanks,

	tglx
---
 include/linux/blk-mq.h     |    2 
 block/blk-mq-cpu.c         |   15 ++----
 block/blk-mq.c             |  108 ++++++++++++++++++++-------------------------
 block/blk-mq.h             |    2 
 include/linux/cpuhotplug.h |    2 
 5 files changed, 59 insertions(+), 70 deletions(-)

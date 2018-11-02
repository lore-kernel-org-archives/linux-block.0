Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/4] irq: fix support for allocating sets of IRQs
Date: Fri,  2 Nov 2018 22:59:47 +0800
Message-Id: <20181102145951.31979-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

As I mentioned, there are at least two issues in the patch of '
irq: add support for allocating (and affinitizing) sets of IRQs':

1) it is wrong to pass 'mask + usedvec' to irq_build_affinity_masks()

2) we should spread all possible CPUs in 2-stage way on each set of IRQs

The fix isn't trivial, and I introduce two extra patches as preparation,
then the implementation can be more clean.

The patchset is against mq-maps branch of block tree, feel free to
integrate into the whole patchset of multiple queue maps.

Thanks,
Ming


Jens Axboe (1):
  irq: add support for allocating (and affinitizing) sets of IRQs

Ming Lei (3):
  Revert "irq: add support for allocating (and affinitizing) sets of
    IRQs"
  irq: move 2-stage irq spread into one helper
  irq: pass first vector to __irq_build_affinity_masks

 kernel/irq/affinity.c | 119 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 44 deletions(-)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>

-- 
2.9.5

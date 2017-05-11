Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4-12-rc1
Message-ID: <0742772b-1685-6c1f-cb5c-f5583a7a9390@kernel.dk>
Date: Thu, 11 May 2017 09:42:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A smaller collection of fixes that should go into -rc1. This pull
request contains:

- A fix from Christoph, fixing a regression with the WRITE_SAME
  and partial completions. Caused a BUG() on ppc.

- Fixup for __blk_mq_stop_hw_queues(), it should be static. From Colin.

- Removal of dmesg error messages on elevator switching, when invoked
  from sysfs. From me.

- Fix for blk-stat, using this_cpu_ptr() in a section only protected by
  rcu_read_lock(). This breaks when PREEMPT_RCU is enabled. From me.

- Two fixes for BFQ from Paolo, one fixing a crash and one updating the
  documentation.

- An error handling lightnvm memory leak, from Rakesh.

- The previous blk-mq hot unplug lock reversal depends on the CPU
  hotplug rework that isn't in mainline yet. This caused a lockdep splat
  when people unplugged CPUs with blk-mq devices. From Wanpeng.

- A regression fix for DIF/DIX on blk-mq. From Wen.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (1):
      block: handle partial completions for special payload requests

Colin Ian King (1):
      blk-mq: make __blk_mq_stop_hw_queues static

Geert Uytterhoeven (1):
      lightnvm: remove unused rq parameter of nvme_nvm_rqtocmd() to kill warning

Jens Axboe (2):
      elevator: remove redundant warnings on IO scheduler switch
      blk-stat: don't use this_cpu_ptr() in a preemptable section

Paolo Valente (2):
      block, bfq: use pointer entity->sched_data only if set
      block, bfq: stress that low_latency must be off to get max throughput

Rakesh Pandit (1):
      nvme: lightnvm: fix memory leak

Wanpeng Li (1):
      block/mq: fix potential deadlock during cpu hotplug

Wen Xiong (1):
      blk-mq: NVMe 512B/4K+T10 DIF/DIX format returns I/O error on dd with split op

 Documentation/block/bfq-iosched.txt | 17 ++++++++++++++++-
 block/bfq-iosched.c                 |  5 +++++
 block/bfq-wf2q.c                    | 13 +++++++++++--
 block/blk-core.c                    | 24 ++++++++++++------------
 block/blk-mq.c                      | 10 +++++-----
 block/blk-stat.c                    | 17 ++++++++++-------
 block/elevator.c                    |  5 +----
 drivers/nvme/host/lightnvm.c        |  9 +++++----
 8 files changed, 65 insertions(+), 35 deletions(-)

-- 
Jens Axboe

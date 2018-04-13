Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup pull request for block
Message-ID: <ef01fe9b-a54b-23c6-49ab-525eec1c31f0@kernel.dk>
Date: Fri, 13 Apr 2018 13:48:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Followup fixes for this merge window. This pull request contains:

- Series from Ming, fixing corner cases in our CPU <-> queue mapping.
  This triggered repeated warnings on especially s390, but I also hit it
  in cpu hot plug/unplug testing while doing IO on NVMe on x86-64.

- Another fix from Ming, ensuring that we always order budget and driver
  tag identically, avoiding a deadlock on QD=1 devices.

- Loop locking regression fix from this merge window, from Omar.

- Another loop locking fix, this time missing an unlock, from Tetsuo
  Handa.

- Fix for racing IO submission with device removal from Bart.

- sr reference fix from me, fixing a case where disk change or getevents
  can race with device removal.

- Set of nvme fixes by way of Keith, from various contributors.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180413


----------------------------------------------------------------
Arnd Bergmann (1):
      nvme: target: fix buffer overflow

Bart Van Assche (1):
      blk-mq: Avoid that submitting a bio concurrently with device removal triggers a crash

Daniel Verkamp (1):
      nvmet: fix space padding in serial number

James Smart (1):
      nvme: expand nvmf_check_if_ready checks

Jens Axboe (1):
      sr: get/drop reference to device in revalidate and check_events

Johannes Thumshirn (2):
      nvme: unexport nvme_start_keep_alive
      nvme: don't send keep-alives to the discovery controller

Keith Busch (4):
      nvme-pci: Skip queue deletion if there are no queues
      nvme-pci: Remove unused queue parameter
      nvme-pci: Separate IO and admin queue IRQ vectors
      nvme: Use admin command effects for admin commands

Mathieu Malaterre (1):
      backing: silence compiler warning using __printf

Matias Bjørling (1):
      nvme: enforce 64bit offset for nvme_get_log_ext fn

Max Gurtovoy (1):
      nvme: check return value of init_srcu_struct function

Ming Lei (11):
      blk-mq: order getting budget and driver tag
      blk-mq: make sure that correct hctx->next_cpu is set
      blk-mq: don't keep offline CPUs mapped to hctx 0
      blk-mq: avoid to write intermediate result to hctx->next_cpu
      blk-mq: introduce blk_mq_hw_queue_first_cpu() to figure out first cpu
      blk-mq: remove blk_mq_delay_queue()
      blk-mq: don't check queue mapped in __blk_mq_delay_run_hw_queue()
      blk-mq: reimplement blk_mq_hw_queue_mapped
      blk-mq: remove code for dealing with remapping queue
      blk-mq: Revert "blk-mq: reimplement blk_mq_hw_queue_mapped"
      nvme-loop: fix kernel oops in case of unhandled command

Omar Sandoval (1):
      loop: fix LOOP_GET_STATUS lock imbalance

Rodrigo R. Galvao (1):
      nvmet: Fix nvmet_execute_write_zeroes sector count

Tetsuo Handa (1):
      block/loop: fix deadlock after loop_set_status

 block/blk-core.c                |  35 ++++++++++--
 block/blk-mq-cpumap.c           |   5 --
 block/blk-mq-debugfs.c          |   1 -
 block/blk-mq.c                  | 122 +++++++++++-----------------------------
 drivers/block/loop.c            |  45 ++++++++-------
 drivers/nvme/host/core.c        |  33 +++++++----
 drivers/nvme/host/fabrics.c     |  83 ++++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.h     |  33 +----------
 drivers/nvme/host/fc.c          |  12 +---
 drivers/nvme/host/nvme.h        |   4 +-
 drivers/nvme/host/pci.c         |  35 +++++++-----
 drivers/nvme/host/rdma.c        |  14 +----
 drivers/nvme/target/admin-cmd.c |   1 +
 drivers/nvme/target/discovery.c |   2 +-
 drivers/nvme/target/io-cmd.c    |   4 +-
 drivers/nvme/target/loop.c      |  20 ++-----
 drivers/scsi/sr.c               |  19 +++++--
 include/linux/backing-dev.h     |   1 +
 include/linux/blk-mq.h          |   2 -
 19 files changed, 245 insertions(+), 226 deletions(-)

-- 
Jens Axboe

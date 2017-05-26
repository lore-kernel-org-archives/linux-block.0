Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.12-rc3
Message-ID: <c687e9f0-3d0b-db76-6c5d-56a5dc9f8792@kernel.dk>
Date: Fri, 26 May 2017 12:03:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A collection of fixes that should go into this series. This pull request
contains:

- A set of NVMe fixes, pulled from Christoph. This includes a set of
  fixes for the fiber channel bits from James Smart, rdma queue depth
  fix from Marta, controller removal fixes from Ming, and some more APST
  quirk updates from Andy.

- A blk-mq debugfs fix from Bart, fixing a problem with the untangling
  of the sysfs and debugfs blk-mq bits that was added in this series.

- Error code fix in add_partition() from Dan.

- A small series of fixes for the new blk-throttle code from Shaohua.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Andy Lutomirski (1):
      nvme: Quirk APST on Intel 600P/P3100 devices

Bart Van Assche (1):
      blk-mq: Only register debugfs attributes for blk-mq queues

Christoph Hellwig (3):
      nvme-pci: consistencly use ctrl->device for logging
      nvme: replace is_flags field in nvme_ctrl_ops with a flags field
      nvme: only setup block integrity if supported by the driver

Dan Carpenter (1):
      block: fix an error code in add_partition()

James Smart (6):
      nvme_fc: get rid of local reconnect_delay
      nvme_fc: Support ctrl_loss_tmo
      nvme_fc: revise comment on teardown
      nvme_fc: set logging level on resets/deletes
      nvme_fc: correct nvme status set on abort
      nvme_fc: remove extra controller reference taken on reconnect

Jens Axboe (1):
      Merge branch 'nvme-4.12' of git://git.infradead.org/nvme into for-linus

Marta Rybczynska (1):
      nvme-rdma: support devices with queue size < 32

Ming Lei (3):
      nvme: use blk_mq_start_hw_queues() in nvme_kill_queues()
      nvme: avoid to use blk_mq_abort_requeue_list()
      blk-mq: remove blk_mq_abort_requeue_list()

Richard (1):
      partitions/msdos: FreeBSD UFS2 file systems are not recognized

Shaohua Li (4):
      blk-throttle: add hierarchy support for latency target and idle time
      blk-throttle: output some debug info in trace
      blk-throttle: respect 0 bps/iops settings for io.low
      blk-throttle: force user to configure all settings for io.low

 block/blk-mq.c             |  19 -----
 block/blk-sysfs.c          |   6 +-
 block/blk-throttle.c       | 172 ++++++++++++++++++++++++++++-----------------
 block/partition-generic.c  |   4 +-
 block/partitions/msdos.c   |   2 +
 drivers/nvme/host/core.c   |  65 +++++++++++------
 drivers/nvme/host/fc.c     | 147 ++++++++++++++++----------------------
 drivers/nvme/host/nvme.h   |   4 +-
 drivers/nvme/host/pci.c    |  15 ++--
 drivers/nvme/host/rdma.c   |  20 ++++--
 drivers/nvme/target/loop.c |   2 +-
 include/linux/blk-mq.h     |   1 -
 12 files changed, 247 insertions(+), 210 deletions(-)

-- 
Jens Axboe

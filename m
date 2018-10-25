Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCHSET 0/14] Add support for multiple queue maps
Date: Thu, 25 Oct 2018 15:16:12 -0600
Message-Id: <20181025211626.12692-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

This series adds support for multiple queue maps for blk-mq.
Since blk-mq was introduced, it's only support a single queue
map. This means you can have 1 set of queues, and the mapping
purely depends on what CPU an IO originated from. With this
patch set, drivers can implement mappings that depend on both
CPU and request type - and they can have multiple sets of mappings.

NVMe is used as a proof of concept. It adds support for a separate
write queue set. One way to use this would be to limit the number
of write queues to favor reads, since NVMe does round-robin service
of queues. An easy extension of this would be to add multiple
sets of queues, for prioritized IO.

NVMe also uses this feature to finally make the polling work
efficiently, without triggering interrupts. This both increases
performance (and decreases latency), at a lower system load. At
the same time it's more flexible, as you don't have to worry about
IRQ coalescing and redirection to avoid interrupts disturbing the
workload. This is how polling should have worked from day 1.

This is on top of the mq-conversions branch and series just
posted. It can also be bound in my mq-maps branch.

 block/blk-flush.c                     |   7 +-
 block/blk-mq-cpumap.c                 |  19 +--
 block/blk-mq-debugfs.c                |   4 +-
 block/blk-mq-pci.c                    |  10 +-
 block/blk-mq-rdma.c                   |   4 +-
 block/blk-mq-sched.c                  |  18 ++-
 block/blk-mq-sysfs.c                  |  10 ++
 block/blk-mq-tag.c                    |   5 +-
 block/blk-mq-virtio.c                 |   8 +-
 block/blk-mq.c                        | 213 ++++++++++++++++++++----------
 block/blk-mq.h                        |  29 ++++-
 block/blk.h                           |   6 +-
 block/kyber-iosched.c                 |   6 +-
 drivers/block/virtio_blk.c            |   2 +-
 drivers/nvme/host/pci.c               | 238 ++++++++++++++++++++++++++++++----
 drivers/scsi/qla2xxx/qla_os.c         |   5 +-
 drivers/scsi/scsi_lib.c               |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c |   3 +-
 drivers/scsi/virtio_scsi.c            |   3 +-
 fs/block_dev.c                        |   2 +
 fs/direct-io.c                        |   2 +
 fs/iomap.c                            |   9 +-
 include/linux/blk-mq-pci.h            |   4 +-
 include/linux/blk-mq-virtio.h         |   4 +-
 include/linux/blk-mq.h                |  24 +++-
 include/linux/blk_types.h             |   4 +-
 include/linux/blkdev.h                |   2 -
 include/linux/interrupt.h             |   4 +
 kernel/irq/affinity.c                 |  31 ++++-
 29 files changed, 520 insertions(+), 158 deletions(-)

-- 
Jens Axboe

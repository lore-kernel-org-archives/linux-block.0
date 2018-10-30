Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 0/16] blk-mq: Add support for multiple queue maps
Date: Tue, 30 Oct 2018 12:32:36 -0600
Message-Id: <20181030183252.17857-1-axboe@kernel.dk>
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

This is on top of my mq-conversions branch. It can also be bound
in my mq-maps branch.

Changes since v2:

- Address review comments (mostly code comments)
- Add rq->mq_hctx cache
- Cleanup/improve blk_mq_sched_insert_requests()
- Harden the IRQ affinity sets feature
- Fix assignment of hardware queue type if already mapped
- Improve plug sorting for multiple maps

Changes since v1:

- Ensure irq_calc_affinity_vectors() doesn't return more than 'maxvec'
- Rebase on top of current mq-conversions series


 block/blk-flush.c                     |  11 +-
 block/blk-mq-cpumap.c                 |  19 +--
 block/blk-mq-debugfs.c                |   2 +-
 block/blk-mq-pci.c                    |  10 +-
 block/blk-mq-rdma.c                   |   4 +-
 block/blk-mq-sched.c                  |  12 +-
 block/blk-mq-sched.h                  |   2 +-
 block/blk-mq-sysfs.c                  |  10 ++
 block/blk-mq-tag.c                    |  12 +-
 block/blk-mq-virtio.c                 |   8 +-
 block/blk-mq.c                        | 237 +++++++++++++++++++-----------
 block/blk-mq.h                        |  45 ++++--
 block/blk.h                           |   6 +-
 block/kyber-iosched.c                 |   6 +-
 drivers/block/virtio_blk.c            |   2 +-
 drivers/nvme/host/pci.c               | 263 ++++++++++++++++++++++++++++++----
 drivers/pci/msi.c                     |  14 ++
 drivers/scsi/qla2xxx/qla_os.c         |   5 +-
 drivers/scsi/scsi_lib.c               |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c |   3 +-
 drivers/scsi/virtio_scsi.c            |   3 +-
 fs/block_dev.c                        |   2 +
 fs/direct-io.c                        |   2 +
 fs/iomap.c                            |   9 +-
 include/linux/blk-mq-pci.h            |   4 +-
 include/linux/blk-mq-virtio.h         |   4 +-
 include/linux/blk-mq.h                |  33 ++++-
 include/linux/blk_types.h             |   4 +-
 include/linux/blkdev.h                |   3 +-
 include/linux/interrupt.h             |   4 +
 kernel/irq/affinity.c                 |  40 ++++--
 31 files changed, 582 insertions(+), 199 deletions(-)

-- 
Jens Axboe

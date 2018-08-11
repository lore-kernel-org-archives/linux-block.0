Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [RFC PATCH V2 00/17] SCSI: introduce per-host admin queue & enable runtime PM
Date: Sat, 11 Aug 2018 15:12:03 +0800
Message-Id: <20180811071220.357-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

This patchset introduces per-host admin request queue for submitting
admin request only, and uses this approach to implement both SCSI
quiesce and runtime PM in one very simply way. Also runtime PM deadlock
can be avoided in case that request pool is used up, such as when too
many IO requests are allocated before resuming device.

The idea is borrowed from NVMe.

In this patchset, admin request(all requests submitted via __scsi_execute) will
be submitted via one per-host admin queue, and the request is still
associated with the same scsi_device as before, and respects this
scsi_device's all kinds of limits too. Admin queue shares host tags with
other IO queues.

One core idea is that for any admin request submitted from this admin queue,
this request won't be called back to block layer via the associated IO
queue(scsi_device). And this is done in the 3rd patch. So once IO queue
is frozen, it can be observed as really frozen from block layer view.

SCSI quiesce is implemented by admin queue in very simple way, see patch
15.

Also runtime PM for legacy path is simplified too, see patch 16, and device
resume is moved to blk_queue_enter().

blk-mq simply follows legacy's approach for supporting runtime PM.

Also the fast IO path is simplified much, see blk_queue_enter().


gitweb:
	https://github.com/ming1/linux/commits/v4.18-rc-next-scsi_admin_queue_v2

Both runtime PM and system suspend on both legacy & blk-mq have been verified,
and not see regression when running blktests.

Any comments are welcome!

Thanks,
Ming

V1->V2:
	- convert NO_SCHED to ADMIN flag, don't allocate driver tag budget
	for admin queue, as pointed by Jianchao(4/17)
	- fix one issue in run scsi queue: admin queue shares IO queue depth
	when sending one command to this scsi_device(10/17)
	- fix one race between runtime PM and system suspend(16/17)
	- iterate over scheduler tags instead of driver tags for counting
	allocated requests(17/17)

Ming Lei (17):
  blk-mq: allow to pass default queue flags for creating & initializing
    queue
  blk-mq: convert BLK_MQ_F_NO_SCHED into per-queue flag
  block: rename QUEUE_FLAG_NO_SCHED as QUEUE_FLAG_ADMIN
  blk-mq: don't reserve tags for admin queue
  SCSI: try to retrieve request_queue via 'scsi_cmnd' if possible
  SCSI: pass 'scsi_device' instance from 'scsi_request'
  SCSI: prepare for introducing admin queue for legacy path
  SCSI: pass scsi_device to scsi_mq_prep_fn
  SCSI: don't set .queuedata in scsi_mq_alloc_queue()
  SCSI: deal with admin queue busy
  SCSI: track pending admin commands
  SCSI: create admin queue for each host
  SCSI: use the dedicated admin queue to send admin commands
  SCSI: transport_spi: resume a quiesced device
  SCSI: use admin queue to implement queue QUIESCE
  block: simplify runtime PM support
  block: enable runtime PM for blk-mq

 block/blk-core.c                    | 179 ++++++++++++-----------
 block/blk-mq-debugfs.c              |   3 +-
 block/blk-mq-tag.c                  |  27 +++-
 block/blk-mq-tag.h                  |   2 +
 block/blk-mq.c                      |  44 ++++--
 block/elevator.c                    |  28 +---
 drivers/ata/libata-eh.c             |   2 +-
 drivers/block/null_blk_main.c       |   7 +-
 drivers/nvme/host/fc.c              |   4 +-
 drivers/nvme/host/pci.c             |   4 +-
 drivers/nvme/host/rdma.c            |   4 +-
 drivers/nvme/target/loop.c          |   4 +-
 drivers/scsi/hosts.c                |   9 ++
 drivers/scsi/libsas/sas_ata.c       |   2 +-
 drivers/scsi/libsas/sas_scsi_host.c |   2 +-
 drivers/scsi/scsi_error.c           |   2 +-
 drivers/scsi/scsi_lib.c             | 278 ++++++++++++++++++++++++++----------
 drivers/scsi/scsi_priv.h            |   1 +
 drivers/scsi/scsi_scan.c            |   1 +
 drivers/scsi/scsi_sysfs.c           |   1 +
 drivers/scsi/scsi_transport_spi.c   |   3 +
 include/linux/blk-mq.h              |  22 ++-
 include/linux/blkdev.h              |  14 +-
 include/scsi/scsi_device.h          |   5 +-
 include/scsi/scsi_host.h            |   2 +
 include/scsi/scsi_request.h         |   5 +-
 26 files changed, 423 insertions(+), 232 deletions(-)

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org


-- 
2.9.5

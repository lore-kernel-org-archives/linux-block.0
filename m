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
Subject: [RFC PATCH 00/14] SCSI: introduce per-host admin queue & enable runtime PM
Date: Wed,  8 Aug 2018 01:44:19 +0800
Message-Id: <20180807174433.8374-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

This patchset introduces per-host admin request queue for submitting
admin request only, and uses this approach to implement both SCSI
quiesce and runtime PM in one very simply way. Also runtime PM deadlock
can be avoided in case that request pool is used up.

The idea is borrowed from NVMe.

Admin request is submitted via per-host admin queue, and it is still
associated with the same scsi_device as before, and respects this
scsi_device's all kinds of limits. Admin queue shares host tags with
other IO queues.

One core idea is that for admin request submitted from this admin queue,
this request won't be called back to block layer via the associated IO
queue(scsi_device). And this is done in the 3rd patch. So once IO queue
is frozen, it can be observed as really frozen from block layer view.

SCSI quiesce is implemented by admin queue in very simple way, see patch
12.

Also runtime PM for legacy path can be simplified too, see patch 13.

Finally blk-mq simply follows legacy's approach for supporting runtime PM.

Any comments are welcome!

Thanks,

Ming Lei (14):
  blk-mq: allow to pass default queue flags for creating & initializing
    queue
  blk-mq: convert BLK_MQ_F_NO_SCHED into per-queue flag
  SCSI: try to retrieve request_queue via 'scsi_cmnd' if possible
  SCSI: pass 'scsi_device' instance from 'scsi_request'
  SCSI: prepare for introducing admin queue for legacy path
  SCSI: pass scsi_device to scsi_mq_prep_fn
  SCSI: don't set .queuedata in scsi_mq_alloc_queue()
  SCSI: deal with admin queue busy
  SCSI: create admin queue for each host
  SCSI: use the dedicated admin queue to send admin commands
  SCSI: transport_spi: resume a quiesced device
  SCSI: use admin queue to implement queue QUIESCE
  block: simplify runtime PM support
  block: enable runtime PM for blk-mq

 block/blk-core.c                    | 122 ++++++------------
 block/blk-mq-debugfs.c              |   3 +-
 block/blk-mq.c                      |  22 ++--
 block/elevator.c                    |  10 +-
 drivers/block/null_blk_main.c       |   7 +-
 drivers/nvme/host/fc.c              |   4 +-
 drivers/nvme/host/pci.c             |   4 +-
 drivers/nvme/host/rdma.c            |   4 +-
 drivers/nvme/target/loop.c          |   4 +-
 drivers/scsi/hosts.c                |   9 ++
 drivers/scsi/libsas/sas_ata.c       |   2 +-
 drivers/scsi/libsas/sas_scsi_host.c |   2 +-
 drivers/scsi/scsi_error.c           |   2 +-
 drivers/scsi/scsi_lib.c             | 250 ++++++++++++++++++++++++++----------
 drivers/scsi/scsi_priv.h            |   1 +
 drivers/scsi/scsi_scan.c            |   1 +
 drivers/scsi/scsi_sysfs.c           |   1 +
 drivers/scsi/scsi_transport_spi.c   |   3 +
 include/linux/blk-mq.h              |  20 ++-
 include/linux/blkdev.h              |  13 +-
 include/scsi/scsi_device.h          |   5 +-
 include/scsi/scsi_host.h            |   2 +
 include/scsi/scsi_request.h         |   5 +-
 23 files changed, 306 insertions(+), 190 deletions(-)

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

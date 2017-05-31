Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>
Subject: [PATCH v2 0/6] Split scsi passthrough fields out of struct request sequel
Date: Wed, 31 May 2017 14:43:44 -0700
Message-ID: <20170531214350.31157-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The patches in this series are a sequel of Christoph's "Split scsi passthrough
fields out of struct request" patch series. The changes compared to v1 of this
patch series are:
- Renamed QUEUE_FLAG_SCSI_PDU into QUEUE_FLAG_SCSI_PASSTHROUGH and
  blk_queue_scsi_pdu() into blk_queue_scsi_passthrough().
- In the cdrom driver, moved the SCSI passthrough support test from
  register_cdrom() to cdrom_read_cdda_bpc().

Please consider these patches for kernel v4.13.

Thanks,

Bart.

Bart Van Assche (6):
  block: Avoid that blk_exit_rl() triggers a use-after-free
  block: Introduce queue flag QUEUE_FLAG_SCSI_PASSTHROUGH
  bsg: Check queue type before attaching to a queue
  pktcdvd: Check queue type before attaching to a queue
  cdrom: Check SCSI passthrough support before reading audio
  nfsd: Check queue type before submitting a SCSI request

 block/blk-cgroup.c                |  2 +-
 block/blk-core.c                  | 10 ++++++++--
 block/blk-sysfs.c                 |  2 +-
 block/blk.h                       |  2 +-
 block/bsg-lib.c                   |  1 +
 block/bsg.c                       |  6 ++++++
 drivers/block/cciss.c             |  1 +
 drivers/block/pktcdvd.c           |  5 +++++
 drivers/cdrom/cdrom.c             |  6 ++++++
 drivers/ide/ide-probe.c           |  1 +
 drivers/scsi/scsi_lib.c           |  2 ++
 drivers/scsi/scsi_transport_sas.c |  1 +
 fs/nfsd/blocklayout.c             |  3 +++
 include/linux/blkdev.h            |  3 +++
 14 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.12.2

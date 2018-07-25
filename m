Return-Path: <gedwards@ddn.com>
From: Greg Edwards <gedwards@ddn.com>
To: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Greg Edwards <gedwards@ddn.com>
Subject: [PATCH 0/2] virtio_scsi pi_bytes{out,in} miscalculated on 4 KiB devices
Date: Wed, 25 Jul 2018 10:22:57 -0400
Message-ID: <20180725142259.20562-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: gedwards@ddn.com
List-ID: <linux-block@vger.kernel.org>

When the VIRTIO_SCSI_F_T10_PI feature bit is enabled, the virtio_scsi driver
does not correctly calculate pi_bytes{out,in} when the underlying device has a
4 KiB logical block size.  The current code assumes a 512 byte logical block
size and protection interval exponent of 0 (512 bytes + 8 bytes PI).

The first patch moves bio_integrity_intervals() and bio_integrity_bytes() into
blkdev.h so drivers can make use of them.  The second patch modifies
virtio_scsi to call bio_integrity_bytes() to get the values for
pi_bytes{out,in}.

Greg Edwards (2):
  block: move bio_integrity_{intervals,bytes} into blkdev.h
  scsi: virtio_scsi: fix pi_bytes{out,in} on 4 KiB block size devices

 block/bio-integrity.c      | 22 ----------------------
 drivers/scsi/virtio_scsi.c |  8 ++++----
 include/linux/blkdev.h     | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 26 deletions(-)

-- 
2.17.1

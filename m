Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart van Assche <bart.vanassche@sandisk.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCH 0/2] block,scsi: support host-wide tagset
Date: Tue,  4 Apr 2017 14:07:43 +0200
Message-Id: <1491307665-47656-1-git-send-email-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

as discussed recently most existing HBAs have a host-wide tagset which
does not map easily onto the per-queue tagset model of block mq.
This patchset implements a flag BLK_MQ_F_GLOBAL_TAGS for block-mq, which
enables the use of a shared tagset for all hardware queues.
The second patch adds a flag 'host_tagset' to the SCSI host template,
which allows drivers to enable the use of the global tagset.

This patchset probably has some performance implications as
there is a quite high probability of cache-bouncing when allocating
tags. Also I'm not quite sure if the implemented tagset sharing
is the correct way to handle things.
So this can be considered an RFC.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  block: Implement global tagset
  scsi: Add template flag 'host_tagset'

 block/blk-mq-tag.c       | 12 ++++++++----
 block/blk-mq.c           | 10 ++++++++--
 drivers/scsi/scsi_lib.c  |  2 ++
 include/linux/blk-mq.h   |  1 +
 include/scsi/scsi_host.h |  5 +++++
 5 files changed, 24 insertions(+), 6 deletions(-)

-- 
1.8.5.6

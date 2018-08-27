Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Don Brace <don.brace@microsemi.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Laurence Oberman <loberman@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/2] scsi: revert two commits for avoiding host-wide host_busy counter for scsi_mq
Date: Mon, 27 Aug 2018 15:24:41 +0800
Message-Id: <20180827072443.26920-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

There is fundamental issue in commit 328728630d9f2bf1 (scsi: core: avoid
host-wide host_busy counter for scsi_mq) because SCSI's host busy counter
may not be same with counter of blk-mq's inflight tags, especially in case
of none io scheduler.

So please revert the two commits.

Ming Lei (2):
  Revert "scsi: core: fix scsi_host_queue_ready"
  Revert "scsi: core: avoid host-wide host_busy counter for scsi_mq"

 drivers/scsi/hosts.c    | 24 +-----------------------
 drivers/scsi/scsi_lib.c | 21 +++++----------------
 2 files changed, 6 insertions(+), 39 deletions(-)

Cc: Omar Sandoval <osandov@fb.com>,
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: Don Brace <don.brace@microsemi.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>

-- 
2.9.5

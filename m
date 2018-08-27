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
	Guenter Roeck <linux@roeck-us.net>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] Revert "scsi: core: fix scsi_host_queue_ready"
Date: Mon, 27 Aug 2018 15:24:42 +0800
Message-Id: <20180827072443.26920-2-ming.lei@redhat.com>
In-Reply-To: <20180827072443.26920-1-ming.lei@redhat.com>
References: <20180827072443.26920-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This reverts commit 265d59aacbce7e50bdc1f5d25033c38dd70b3767.

There is fundamental issue in commit 328728630d9f2bf1 (scsi: core: avoid
host-wide host_busy counter for scsi_mq) because SCSI's host busy counter
may not be same with counter of blk-mq's inflight tags, especially in case
of none io scheduler.

So revert this commit first.

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
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jens Axboe <axboe@kernel.dk>
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0adfb3bce0fd..1046679f5473 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1611,7 +1611,7 @@ static inline int scsi_host_queue_ready(struct request_queue *q,
 	else
 		busy = 0;
 	if (atomic_read(&shost->host_blocked) > 0) {
-		if (busy)
+		if (busy || scsi_host_busy(shost))
 			goto starved;
 
 		/*
-- 
2.9.5

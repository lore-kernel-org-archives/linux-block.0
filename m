Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932784AbeF3B1p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 21:27:45 -0400
From: Ming Lei <ming.lei@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] scsi: fix scsi_host_queue_ready
Date: Sat, 30 Jun 2018 09:27:24 +0800
Message-Id: <20180630012724.24178-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

328728630d9f2bf1 ("scsi: avoid to hold host-wide counter of host_busy
for scsi_mq") adds one extra check on scsi_host_busy(shost) in
scsi_host_queue_ready(), which is wrong and not necessary, can causes
booting stall on LSI53c895A.

So remove the check.

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
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 328728630d9f2bf1 ("scsi: avoid to hold host-wide counter of host_busy for scsi_mq")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1c79c86184b1..cc97818cb29c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1561,7 +1561,7 @@ static inline int scsi_host_queue_ready(struct request_queue *q,
 	else
 		busy = 0;
 	if (atomic_read(&shost->host_blocked) > 0) {
-		if (busy || scsi_host_busy(shost))
+		if (busy)
 			goto starved;
 
 		/*
-- 
2.9.5

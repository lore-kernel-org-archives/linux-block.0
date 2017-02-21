Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32945 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbdBUSEe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2017 13:04:34 -0500
Received: by mail-pg0-f46.google.com with SMTP id z128so1750395pgb.0
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2017 10:04:33 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, kernel-team@fb.com
Subject: [PATCH] scsi_transport_sas: fix BSG ioctl memory corruption
Date: Tue, 21 Feb 2017 10:03:50 -0800
Message-Id: <e33a218846e718a310fd8bd92acbafd0b6252aca.1487700062.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The end_device and sas_host devices support BSG ioctls, but the
request_queue allocated for them isn't set up to allocate the struct
scsi_request payload. This leads to memory corruption in the call to
scsi_req_init() in bsg_map_hdr(), since it will memset past the end of
the allocated request. Fix it by setting ->cmd_size on the allocated
request_queue.

Fixes: 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
I don't know what sg ioctls these devices actually support, but I tested
this with sg_inq, which previously caused KASAN splats.

 drivers/scsi/scsi_transport_sas.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 126a5ee00987..f94535130a34 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -227,27 +227,31 @@ static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
 		return 0;
 	}
 
+	q = blk_alloc_queue(GFP_KERNEL);
+	if (!q)
+		return -ENOMEM;
+	q->cmd_size = sizeof(struct scsi_request);
+
 	if (rphy) {
-		q = blk_init_queue(sas_non_host_smp_request, NULL);
+		q->request_fn = sas_non_host_smp_request;
 		dev = &rphy->dev;
 		name = dev_name(dev);
 		release = NULL;
 	} else {
-		q = blk_init_queue(sas_host_smp_request, NULL);
+		q->request_fn = sas_host_smp_request;
 		dev = &shost->shost_gendev;
 		snprintf(namebuf, sizeof(namebuf),
 			 "sas_host%d", shost->host_no);
 		name = namebuf;
 		release = sas_host_release;
 	}
-	if (!q)
-		return -ENOMEM;
+	error = blk_init_allocated_queue(q);
+	if (error)
+		goto out_cleanup_queue;
 
 	error = bsg_register_queue(q, dev, name, release);
-	if (error) {
-		blk_cleanup_queue(q);
-		return -ENOMEM;
-	}
+	if (error)
+		goto out_cleanup_queue;
 
 	if (rphy)
 		rphy->q = q;
@@ -261,6 +265,10 @@ static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
 
 	queue_flag_set_unlocked(QUEUE_FLAG_BIDI, q);
 	return 0;
+
+out_cleanup_queue:
+	blk_cleanup_queue(q);
+	return error;
 }
 
 static void sas_bsg_remove(struct Scsi_Host *shost, struct sas_rphy *rphy)
-- 
2.11.1

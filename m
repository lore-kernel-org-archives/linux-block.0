Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>, <linux-block@vger.kernel.org>
Subject: [PATCH 04/18] cdrom: Check private request size before attaching to a queue
Date: Fri, 19 May 2017 11:30:02 -0700
Message-ID: <20170519183016.12646-5-bart.vanassche@sandisk.com>
In-Reply-To: <20170519183016.12646-1-bart.vanassche@sandisk.com>
References: <20170519183016.12646-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Since the cdrom driver only supports request queues for which
struct scsi_request is the first member of their private request
data, refuse to register block layer queues for which the private
data is smaller than struct scsi_request.

References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: linux-block@vger.kernel.org
---
 drivers/cdrom/cdrom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 76c952fd9ab9..dc20e4368136 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -594,6 +594,11 @@ int register_cdrom(struct cdrom_device_info *cdi)
 
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -EINVAL;
+	if (blk_queue_cmd_size(cdi->disk->queue) <
+	    sizeof(struct scsi_request)) {
+		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
+		return -EINVAL;
+	}
 	if (!banner_printed) {
 		pr_info("Uniform CD-ROM driver " REVISION "\n");
 		banner_printed = 1;
-- 
2.12.2

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63671 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763373AbdEXAec (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 20:34:32 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>, "Christoph Hellwig" <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 14/31] cdrom: Check private request size before attaching to a queue
Date: Tue, 23 May 2017 17:34:03 -0700
Message-ID: <20170524003420.5381-15-bart.vanassche@sandisk.com>
In-Reply-To: <20170524003420.5381-1-bart.vanassche@sandisk.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since the cdrom driver only supports request queues for which
struct scsi_request is the first member of their private request
data, refuse to register block layer queues for which this is
not the case.

References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: linux-block@vger.kernel.org
---
 drivers/cdrom/cdrom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 76c952fd9ab9..070568d496dc 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -594,6 +594,10 @@ int register_cdrom(struct cdrom_device_info *cdi)
 
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -EINVAL;
+	if (!blk_queue_scsi_sup(cdi->disk->queue)) {
+		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
+		return -EINVAL;
+	}
 	if (!banner_printed) {
 		pr_info("Uniform CD-ROM driver " REVISION "\n");
 		banner_printed = 1;
-- 
2.12.2

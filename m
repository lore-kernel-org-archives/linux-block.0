Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11374 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760620AbdEXAfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 20:35:02 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>, "Christoph Hellwig" <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 13/31] pktcdvd: Check queue type before attaching to a queue
Date: Tue, 23 May 2017 17:34:02 -0700
Message-ID: <20170524003420.5381-14-bart.vanassche@sandisk.com>
In-Reply-To: <20170524003420.5381-1-bart.vanassche@sandisk.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since the pktcdvd driver only supports request queues for which
struct scsi_request is the first member of their private request
data, refuse to register block layer queues for which struct
scsi_request is not the first member of the private data.

References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: linux-block@vger.kernel.org
---
 drivers/block/pktcdvd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 205b865ebeb9..b8ce55d7911d 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2583,6 +2583,11 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	bdev = bdget(dev);
 	if (!bdev)
 		return -ENOMEM;
+	if (!blk_queue_scsi_sup(bdev_get_queue(bdev))) {
+		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
+		bdput(bdev);
+		return -EINVAL;
+	}
 	ret = blkdev_get(bdev, FMODE_READ | FMODE_NDELAY, NULL);
 	if (ret)
 		return ret;
-- 
2.12.2

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60868 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756054AbdESSa1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2017 14:30:27 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>, <linux-block@vger.kernel.org>
Subject: [PATCH 03/18] pktcdvd: Check private request size before attaching to a queue
Date: Fri, 19 May 2017 11:30:01 -0700
Message-ID: <20170519183016.12646-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170519183016.12646-1-bart.vanassche@sandisk.com>
References: <20170519183016.12646-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since the pktcdvd driver only supports request queues for which
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
 drivers/block/pktcdvd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 205b865ebeb9..4134bb54f6ad 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2583,6 +2583,12 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	bdev = bdget(dev);
 	if (!bdev)
 		return -ENOMEM;
+	if (blk_queue_cmd_size(bdev_get_queue(bdev)) <
+	    sizeof(struct scsi_request)) {
+		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
+		bdput(bdev);
+		return -EINVAL;
+	}
 	ret = blkdev_get(bdev, FMODE_READ | FMODE_NDELAY, NULL);
 	if (ret)
 		return ret;
-- 
2.12.2

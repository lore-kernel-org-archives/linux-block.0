Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4701 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036478AbdEYSnh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 14:43:37 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH 03/19] bsg: Check queue type before attaching to a queue
Date: Thu, 25 May 2017 11:43:11 -0700
Message-ID: <20170525184327.23570-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170525184327.23570-1-bart.vanassche@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since BSG only supports request queues for which struct scsi_request
is the first member of their private request data, refuse to register
block layer queues for which struct scsi_request is not the first
member of their private data.

References: commit bd1599d931ca ("scsi_transport_sas: fix BSG ioctl memory corruption")
References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org
---
 block/bsg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/bsg.c b/block/bsg.c
index 6fd08544d77e..5871bbe70ccd 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -750,6 +750,12 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 #ifdef BSG_DEBUG
 	unsigned char buf[32];
 #endif
+
+	if (!blk_queue_scsi_pdu(rq)) {
+		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (!blk_get_queue(rq))
 		return ERR_PTR(-ENXIO);
 
-- 
2.12.2

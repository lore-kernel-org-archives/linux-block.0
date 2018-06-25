Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5235 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754204AbeFYWvb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jun 2018 18:51:31 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH] drbd: Fix drbd_request_prepare() discard handling
Date: Mon, 25 Jun 2018 15:51:30 -0700
Message-Id: <20180625225130.4447-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fix the test that verifies whether bio_op(bio) represents a discard
or write zeroes operation. Compile-tested only.

Fixes: 7435e9018f91 ("drbd: zero-out partial unaligned discards on local backend")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 24f0884ec01f..a8e7d7318e37 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1244,8 +1244,8 @@ drbd_request_prepare(struct drbd_device *device, struct bio *bio, unsigned long
 	_drbd_start_io_acct(device, req);
 
 	/* process discards always from our submitter thread */
-	if ((bio_op(bio) & REQ_OP_WRITE_ZEROES) ||
-	    (bio_op(bio) & REQ_OP_DISCARD))
+	if (bio_op(bio) == REQ_OP_WRITE_ZEROES ||
+	    bio_op(bio) == REQ_OP_DISCARD)
 		goto queue_for_submitter_thread;
 
 	if (rw == WRITE && req->private_bio && req->i.size
-- 
2.17.1

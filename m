Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26342 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbdHWLVG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 07:21:06 -0400
Date: Wed, 23 Aug 2017 14:20:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] skd: error pointer dereference in skd_cons_disk()
Message-ID: <20170823065122.pqju3ks5rxpymllz@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

My initial impulse was to check for IS_ERR_OR_NULL() but when I looked
at this code a bit more closely, we should only need to check for
IS_ERR().

The blk_mq_alloc_tag_set() returns negative error codes and zero on
success so we can just do an "if (rc) goto err_out;".  It's better to
preserve the error code anyhow.  The blk_mq_init_queue() returns error
pointers on failure, it never returns NULL.  We can also remove the
"q = NULL;" at the start because that's no longer needed.

Fixes: ca33dd92968b ("skd: Convert to blk-mq")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 9b99081a623c..8579eef80ef1 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2862,7 +2862,6 @@ static int skd_cons_disk(struct skd_device *skdev)
 	disk->fops = &skd_blockdev_ops;
 	disk->private_data = skdev;
 
-	q = NULL;
 	memset(&skdev->tag_set, 0, sizeof(skdev->tag_set));
 	skdev->tag_set.ops = &skd_mq_ops;
 	skdev->tag_set.nr_hw_queues = 1;
@@ -2874,13 +2873,13 @@ static int skd_cons_disk(struct skd_device *skdev)
 		BLK_MQ_F_SG_MERGE |
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(BLK_TAG_ALLOC_FIFO);
 	skdev->tag_set.driver_data = skdev;
-	if (blk_mq_alloc_tag_set(&skdev->tag_set) >= 0) {
-		q = blk_mq_init_queue(&skdev->tag_set);
-		if (!q)
-			blk_mq_free_tag_set(&skdev->tag_set);
-	}
-	if (!q) {
-		rc = -ENOMEM;
+	rc = blk_mq_alloc_tag_set(&skdev->tag_set);
+	if (rc)
+		goto err_out;
+	q = blk_mq_init_queue(&skdev->tag_set);
+	if (IS_ERR(q)) {
+		blk_mq_free_tag_set(&skdev->tag_set);
+		rc = PTR_ERR(q);
 		goto err_out;
 	}
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186C0C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 09:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7AA72389E
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 09:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgLQI7e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 03:59:34 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:55559 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgLQI7e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 03:59:34 -0500
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7B417240010;
        Thu, 17 Dec 2020 08:58:49 +0000 (UTC)
Date:   Thu, 17 Dec 2020 00:58:47 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: Respect max_part for all partition scans
Message-ID: <86d03378210ddac44eb07ebb78c9b0f32c56fe96.1608195087.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The creation path of the NBD device respects max_part and only scans for
partitions if max_part is not 0. However, some other code paths ignore
max_part, and unconditionally scan for partitions. Add a check for
max_part on each partition scan.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

Caught this when reading recent NBD patches, which tweaked the
nbd_set_size path.

It doesn't seem worth factoring these two lines into a function,
especially since the callers obtain the disk structure in different
ways.

 drivers/block/nbd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 92f84ed0ba9e..6727358e147d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -318,7 +318,8 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	blk_queue_logical_block_size(nbd->disk->queue, blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, blksize);
 
-	set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
+	if (max_part)
+		set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
 	if (!set_capacity_and_notify(nbd->disk, bytesize >> 9))
 		kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 	return 0;
@@ -1476,9 +1477,11 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 		refcount_set(&nbd->config_refs, 1);
 		refcount_inc(&nbd->refs);
 		mutex_unlock(&nbd->config_lock);
-		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
+		if (max_part)
+			set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 	} else if (nbd_disconnected(nbd->config)) {
-		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
+		if (max_part)
+			set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 	}
 out:
 	mutex_unlock(&nbd_index_mutex);
-- 
2.29.2

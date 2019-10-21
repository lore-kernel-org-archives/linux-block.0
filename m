Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE22CA9EB7
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 08:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2212B21924
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 08:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfJUIiK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:38:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbfJUIiK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 04:38:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D18F7B15B;
        Mon, 21 Oct 2019 08:38:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 680741E4AA3; Mon, 21 Oct 2019 10:38:08 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] bdev: Refresh bdev size for disks without partitioning
Date:   Mon, 21 Oct 2019 10:38:00 +0200
Message-Id: <20191021083808.19335-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021083132.5351-1-jack@suse.cz>
References: <20191021083132.5351-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, block device size in not updated on second and further open
for block devices where partition scan is disabled. This is particularly
annoying for example for DVD drives as that means block device size does
not get updated once the media is inserted into a drive if the device is
already open when inserting the media. This is actually always the case
for example when pktcdvd is in use.

Fix the problem by revalidating block device size on every open even for
devices with partition scan disabled.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 88c6d35ec71d..d612468ee66b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1403,11 +1403,7 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
 		       "resized disk %s\n",
 		       bdev->bd_disk ? bdev->bd_disk->disk_name : "");
 	}
-
-	if (!bdev->bd_disk)
-		return;
-	if (disk_part_scan_enabled(bdev->bd_disk))
-		bdev->bd_invalidated = 1;
+	bdev->bd_invalidated = 1;
 }
 
 /**
@@ -1514,10 +1510,15 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
 static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
 {
-	if (invalidate)
-		invalidate_partitions(bdev->bd_disk, bdev);
-	else
-		rescan_partitions(bdev->bd_disk, bdev);
+	if (disk_part_scan_enabled(bdev->bd_disk)) {
+		if (invalidate)
+			invalidate_partitions(bdev->bd_disk, bdev);
+		else
+			rescan_partitions(bdev->bd_disk, bdev);
+	} else {
+		check_disk_size_change(bdev->bd_disk, bdev, !invalidate);
+		bdev->bd_invalidated = 0;
+	}
 }
 
 /*
-- 
2.16.4


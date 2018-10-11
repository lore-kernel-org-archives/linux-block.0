Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f181.google.com ([209.85.215.181]:41178 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbeJLB7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Oct 2018 21:59:02 -0400
Received: by mail-pg1-f181.google.com with SMTP id 23-v6so4566037pgc.8
        for <linux-block@vger.kernel.org>; Thu, 11 Oct 2018 11:30:38 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 01/13] swim: fix cleanup on setup error
Date: Thu, 11 Oct 2018 11:30:11 -0700
Message-Id: <6fc80069461e094f5d018c948873f11b8d4331de.1539282366.git.osandov@fb.com>
In-Reply-To: <cover.1539282366.git.osandov@fb.com>
References: <cover.1539282366.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

If we fail to allocate the request queue for a disk, we still need to
free that disk, not just the previous ones. Additionally, we need to
cleanup the previous request queues.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/swim.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 0e31884a9519..cbe909c51847 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -887,8 +887,17 @@ static int swim_floppy_init(struct swim_priv *swd)
 
 exit_put_disks:
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
-	while (drive--)
-		put_disk(swd->unit[drive].disk);
+	do {
+		struct gendisk *disk = swd->unit[drive].disk;
+
+		if (disk) {
+			if (disk->queue) {
+				blk_cleanup_queue(disk->queue);
+				disk->queue = NULL;
+			}
+			put_disk(disk);
+		}
+	} while (drive--);
 	return err;
 }
 
-- 
2.19.1

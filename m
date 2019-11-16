Return-Path: <SRS0=wO3m=ZI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28424C432C3
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 16:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A1F214DE
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920834;
	bh=4qWikL+dgIycA9R60kt5tym208RHB/8vxf181e199fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xluW401mUYnS5oIayfxSkCEnha38XXw1i6FHZMPMiTW3bTilYeeRNfj6WH3sh9P0z
	 3IiQF9tl1nKplBZperR8wZ8Cc1fe923+nQBD0FDDpYl5uu8tp+benAtCXLEu7U+nL8
	 vjYoLOsg5F5fYsRWrqjvkEV7BG1+XCekvk1ldAuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfKPQNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:13:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbfKPPr5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Nov 2019 10:47:57 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D77FE20815;
        Sat, 16 Nov 2019 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919276;
        bh=4qWikL+dgIycA9R60kt5tym208RHB/8vxf181e199fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xgn+DCzR2RRJ4hqAzplcfMN9VkhWFdnGyHnCyFGzLafCV+g6z/GG/HVjqu7JCUdRu
         puu48j/0k42P6jjwAqPxdDTUnE/i0SBD5Oc5Xc29ckuPz6eV9pWhUH8+H4QUfUAcD+
         sDE97Xmp9yqTG13GT1YuVFWtN4Vf01CuesPtSHAc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 025/150] amiflop: clean up on errors during setup
Date:   Sat, 16 Nov 2019 10:45:23 -0500
Message-Id: <20191116154729.9573-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

[ Upstream commit 53d0f8dbde89cf6c862c7a62e00c6123e02cba41 ]

The error handling in fd_probe_drives() doesn't clean up at all. Fix it
up in preparation for converting to blk-mq. While we're here, get rid of
the commented out amiga_floppy_remove().

Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/amiflop.c | 84 ++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 49908c74bfcb0..b0e8d8364876b 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1699,11 +1699,41 @@ static const struct block_device_operations floppy_fops = {
 	.check_events	= amiga_check_events,
 };
 
+static struct gendisk *fd_alloc_disk(int drive)
+{
+	struct gendisk *disk;
+
+	disk = alloc_disk(1);
+	if (!disk)
+		goto out;
+
+	disk->queue = blk_init_queue(do_fd_request, &amiflop_lock);
+	if (IS_ERR(disk->queue)) {
+		disk->queue = NULL;
+		goto out_put_disk;
+	}
+
+	unit[drive].trackbuf = kmalloc(FLOPPY_MAX_SECTORS * 512, GFP_KERNEL);
+	if (!unit[drive].trackbuf)
+		goto out_cleanup_queue;
+
+	return disk;
+
+out_cleanup_queue:
+	blk_cleanup_queue(disk->queue);
+	disk->queue = NULL;
+out_put_disk:
+	put_disk(disk);
+out:
+	unit[drive].type->code = FD_NODRIVE;
+	return NULL;
+}
+
 static int __init fd_probe_drives(void)
 {
 	int drive,drives,nomem;
 
-	printk(KERN_INFO "FD: probing units\nfound ");
+	pr_info("FD: probing units\nfound");
 	drives=0;
 	nomem=0;
 	for(drive=0;drive<FD_MAX_UNITS;drive++) {
@@ -1711,27 +1741,17 @@ static int __init fd_probe_drives(void)
 		fd_probe(drive);
 		if (unit[drive].type->code == FD_NODRIVE)
 			continue;
-		disk = alloc_disk(1);
+
+		disk = fd_alloc_disk(drive);
 		if (!disk) {
-			unit[drive].type->code = FD_NODRIVE;
+			pr_cont(" no mem for fd%d", drive);
+			nomem = 1;
 			continue;
 		}
 		unit[drive].gendisk = disk;
-
-		disk->queue = blk_init_queue(do_fd_request, &amiflop_lock);
-		if (!disk->queue) {
-			unit[drive].type->code = FD_NODRIVE;
-			continue;
-		}
-
 		drives++;
-		if ((unit[drive].trackbuf = kmalloc(FLOPPY_MAX_SECTORS * 512, GFP_KERNEL)) == NULL) {
-			printk("no mem for ");
-			unit[drive].type = &drive_types[num_dr_types - 1]; /* FD_NODRIVE */
-			drives--;
-			nomem = 1;
-		}
-		printk("fd%d ",drive);
+
+		pr_cont(" fd%d",drive);
 		disk->major = FLOPPY_MAJOR;
 		disk->first_minor = drive;
 		disk->fops = &floppy_fops;
@@ -1742,11 +1762,11 @@ static int __init fd_probe_drives(void)
 	}
 	if ((drives > 0) || (nomem == 0)) {
 		if (drives == 0)
-			printk("no drives");
-		printk("\n");
+			pr_cont(" no drives");
+		pr_cont("\n");
 		return drives;
 	}
-	printk("\n");
+	pr_cont("\n");
 	return -ENOMEM;
 }
  
@@ -1837,30 +1857,6 @@ static int __init amiga_floppy_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#if 0 /* not safe to unload */
-static int __exit amiga_floppy_remove(struct platform_device *pdev)
-{
-	int i;
-
-	for( i = 0; i < FD_MAX_UNITS; i++) {
-		if (unit[i].type->code != FD_NODRIVE) {
-			struct request_queue *q = unit[i].gendisk->queue;
-			del_gendisk(unit[i].gendisk);
-			put_disk(unit[i].gendisk);
-			kfree(unit[i].trackbuf);
-			if (q)
-				blk_cleanup_queue(q);
-		}
-	}
-	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
-	free_irq(IRQ_AMIGA_CIAA_TB, NULL);
-	free_irq(IRQ_AMIGA_DSKBLK, NULL);
-	custom.dmacon = DMAF_DISK; /* disable DMA */
-	amiga_chip_free(raw_buf);
-	unregister_blkdev(FLOPPY_MAJOR, "fd");
-}
-#endif
-
 static struct platform_driver amiga_floppy_driver = {
 	.driver   = {
 		.name	= "amiga-floppy",
-- 
2.20.1


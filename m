Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753027AbdCHOeO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Mar 2017 09:34:14 -0500
From: Jan Kara <jack@suse.cz>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] axonram: Fix gendisk handling
Date: Wed,  8 Mar 2017 14:56:05 +0100
Message-Id: <20170308135605.4250-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It is invalid to call del_gendisk() when disk->queue is NULL. Fix error
handling in axon_ram_probe() to avoid doing that.

Also del_gendisk() does not drop a reference to gendisk allocated by
alloc_disk(). That has to be done by put_disk(). Add that call where
needed.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 arch/powerpc/sysdev/axonram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Warning: The patch is not tested in any way. I just based the fix on Smatch
warning and how things should be...

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index ada29eaed6e2..f523ac883150 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -274,7 +274,9 @@ static int axon_ram_probe(struct platform_device *device)
 			if (bank->disk->major > 0)
 				unregister_blkdev(bank->disk->major,
 						bank->disk->disk_name);
-			del_gendisk(bank->disk);
+			if (bank->disk->flags & GENHD_FL_UP)
+				del_gendisk(bank->disk);
+			put_disk(bank->disk);
 		}
 		device->dev.platform_data = NULL;
 		if (bank->io_addr != 0)
@@ -299,6 +301,7 @@ axon_ram_remove(struct platform_device *device)
 	device_remove_file(&device->dev, &dev_attr_ecc);
 	free_irq(bank->irq_id, device);
 	del_gendisk(bank->disk);
+	put_disk(bank->disk);
 	iounmap((void __iomem *) bank->io_addr);
 	kfree(bank);
 
-- 
2.10.2

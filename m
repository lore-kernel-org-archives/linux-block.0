Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21502 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbcF0Tav (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 27 Jun 2016 15:30:51 -0400
Subject: [PATCH v5 3/5] um: track 'parent' device in a local variable
From: Dan Williams <dan.j.williams@intel.com>
To: axboe@fb.com
Cc: linux-nvdimm@lists.01.org, Richard Weinberger <richard@nod.at>,
	Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>, hch@lst.de
Date: Mon, 27 Jun 2016 12:30:08 -0700
Message-ID: <146705580842.39775.16180359577535598750.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In preparation for the removal of 'driverfs_dev' from 'struct gendisk'
use a local variable to track the parented vs un-parented case in
ubd_disk_register().

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/um/drivers/ubd_kern.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index ef6b4d960bad..f3540270d096 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -801,6 +801,7 @@ static void ubd_device_release(struct device *dev)
 static int ubd_disk_register(int major, u64 size, int unit,
 			     struct gendisk **disk_out)
 {
+	struct device *parent = NULL;
 	struct gendisk *disk;
 
 	disk = alloc_disk(1 << UBD_SHIFT);
@@ -823,12 +824,12 @@ static int ubd_disk_register(int major, u64 size, int unit,
 		ubd_devs[unit].pdev.dev.release = ubd_device_release;
 		dev_set_drvdata(&ubd_devs[unit].pdev.dev, &ubd_devs[unit]);
 		platform_device_register(&ubd_devs[unit].pdev);
-		disk->driverfs_dev = &ubd_devs[unit].pdev.dev;
+		parent = &ubd_devs[unit].pdev.dev;
 	}
 
 	disk->private_data = &ubd_devs[unit];
 	disk->queue = ubd_devs[unit].queue;
-	add_disk(disk);
+	device_add_disk(parent, disk);
 
 	*disk_out = disk;
 	return 0;


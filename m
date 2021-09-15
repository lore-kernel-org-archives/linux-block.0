Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5DBC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762D861108
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhIOGy4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbhIOGyz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:54:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073B4C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YbeZICAAM8lxxV7BX9xMNPzlMaue/p38Pno8WnpHlUM=; b=T5wNp9SeMjdsYmbjeexIg5tyLi
        GTf9g6B1a2IHzTa1QqfmN0ot7LGeyRojGFbpp4mDNYrp2xt0dbY+Z9SeXEMassE+daJfkkx6g4OBx
        pJ1lNWwyvE8q9DKWFF5mX564bdhoSZ4wZ3X/4JmV/czqE0kdiBELJh3e9cmqbNOp3rF8IsEJJCFEt
        kmbMFLc4jfpC2jfHs4WB3kTo6H6cQb8AXMIp/Q+q/ZVzxQhIZY0sEFxkTNqz5TbnjekoGLVqSieXL
        ZavSV5+wbWodG+0imtkOIvxFCDxN5bGs+w1zh+cZPCaWHxW4h5qPnBnj56UpvSChknpvdYHoEz59u
        bjAQRo5A==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOmh-00FRA2-Cq; Wed, 15 Sep 2021 06:52:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 14/17] block: drop unused includes in <linux/genhd.h>
Date:   Wed, 15 Sep 2021 08:40:41 +0200
Message-Id: <20210915064044.950534-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915064044.950534-1-hch@lst.de>
References: <20210915064044.950534-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop various include not actually used in genhd.h itself, and
move the remaning includes closer together.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c      |  1 +
 block/genhd.c                   |  1 +
 block/holder.c                  |  1 +
 block/partitions/core.c         |  1 +
 drivers/block/amiflop.c         |  1 +
 drivers/block/ataflop.c         |  1 +
 drivers/block/floppy.c          |  1 +
 drivers/block/swim.c            |  1 +
 drivers/block/xen-blkfront.c    |  1 +
 drivers/md/md.c                 |  1 +
 drivers/s390/block/dasd_genhd.c |  1 +
 drivers/scsi/sd.c               |  1 +
 drivers/scsi/sg.c               |  1 +
 drivers/scsi/sr.c               |  1 +
 drivers/scsi/st.c               |  1 +
 include/linux/genhd.h           | 14 ++------------
 include/linux/part_stat.h       |  1 +
 17 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index cd9dc0556e913..4352ef3ea7e04 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -27,6 +27,7 @@
 #include <linux/blk-mq.h>
 #include <linux/ata.h>
 #include <linux/hdreg.h>
+#include <linux/kernel.h>
 #include <linux/cdrom.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
diff --git a/block/genhd.c b/block/genhd.c
index 7b6e5e1cf9564..5e8aa0ab66c2a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
+#include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/idr.h>
 #include <linux/log2.h>
diff --git a/block/holder.c b/block/holder.c
index 9dc084182337f..27cddce1b4461 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/genhd.h>
+#include <linux/slab.h>
 
 struct bd_holder_disk {
 	struct list_head	list;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 58c4c362c94f9..3a4898433c434 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2020 Christoph Hellwig
  */
 #include <linux/fs.h>
+#include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/genhd.h>
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index b892e5185d6fa..2909fd9e72fb8 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -61,6 +61,7 @@
 #include <linux/hdreg.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/fs.h>
 #include <linux/blk-mq.h>
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a093644ac39fb..58e921ab57298 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -68,6 +68,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/blk-mq.h>
+#include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/completion.h>
 #include <linux/wait.h>
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index fef79ea52e3ed..6288ce8884147 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -184,6 +184,7 @@ static int print_unex = 1;
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/major.h>
 #include <linux/platform_device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 7ccc8d2a41bc6..3911d0833e1b9 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -16,6 +16,7 @@
 #include <linux/fd.h>
 #include <linux/slab.h>
 #include <linux/blk-mq.h>
+#include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/hdreg.h>
 #include <linux/kernel.h>
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 72902104f1112..df0deb9277601 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -42,6 +42,7 @@
 #include <linux/cdrom.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/bitmap.h>
diff --git a/drivers/md/md.c b/drivers/md/md.c
index ae8fe54ea3581..0c7018462eaee 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -51,6 +51,7 @@
 #include <linux/hdreg.h>
 #include <linux/proc_fs.h>
 #include <linux/random.h>
+#include <linux/major.h>
 #include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/file.h>
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index fa966e0db6ca9..3a6f3af240fa7 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -14,6 +14,7 @@
 #define KMSG_COMPONENT "dasd"
 
 #include <linux/interrupt.h>
+#include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/blkpg.h>
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cbd9999f93a6b..a18ae0950c491 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -48,6 +48,7 @@
 #include <linux/blkpg.h>
 #include <linux/blk-pm.h>
 #include <linux/delay.h>
+#include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/string_helpers.h>
 #include <linux/async.h>
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 8f05248920e8e..3c98f08dc25d9 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -31,6 +31,7 @@ static int sg_version_num = 30536;	/* 2 digits for each component */
 #include <linux/errno.h>
 #include <linux/mtio.h>
 #include <linux/ioctl.h>
+#include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 8b17b35283aa5..115f7ef7a5def 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -44,6 +44,7 @@
 #include <linux/cdrom.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/blk-pm.h>
 #include <linux/mutex.h>
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 9d04929f03a10..8cc02f5264ba7 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -32,6 +32,7 @@ static const char *verstr = "20160209";
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/mtio.h>
+#include <linux/major.h>
 #include <linux/cdrom.h>
 #include <linux/ioctl.h>
 #include <linux/fcntl.h>
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c68d83c87f83f..c1639c16b74c3 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -12,12 +12,10 @@
 
 #include <linux/types.h>
 #include <linux/kdev_t.h>
-#include <linux/rcupdate.h>
-#include <linux/slab.h>
-#include <linux/percpu-refcount.h>
 #include <linux/uuid.h>
 #include <linux/blk_types.h>
-#include <asm/local.h>
+#include <linux/device.h>
+#include <linux/xarray.h>
 
 extern const struct device_type disk_type;
 extern struct device_type part_type;
@@ -26,14 +24,6 @@ extern struct class block_class;
 #define DISK_MAX_PARTS			256
 #define DISK_NAME_LEN			32
 
-#include <linux/major.h>
-#include <linux/device.h>
-#include <linux/smp.h>
-#include <linux/string.h>
-#include <linux/fs.h>
-#include <linux/workqueue.h>
-#include <linux/xarray.h>
-
 #define PARTITION_META_INFO_VOLNAMELTH	64
 /*
  * Enough for the string representation of any kind of UUID plus NULL.
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index d2558121d48c0..6f7949b2fd8dc 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -3,6 +3,7 @@
 #define _LINUX_PART_STAT_H
 
 #include <linux/genhd.h>
+#include <asm/local.h>
 
 struct disk_stats {
 	u64 nsecs[NR_STAT_GROUPS];
-- 
2.30.2


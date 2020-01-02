Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945F3C2D0DC
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E40E2072C
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 14:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgABO6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:58:47 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:38545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgABO6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 09:58:46 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Ml6Zo-1jRu2Z2XTo-00lSv9; Thu, 02 Jan 2020 15:58:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Stefan Haberland <sth@linux.ibm.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/22] compat_ioctl: block: add blkdev_compat_ptr_ioctl
Date:   Thu,  2 Jan 2020 15:55:22 +0100
Message-Id: <20200102145552.1853992-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KgLrTmywy3bbbvY0LZm/M628mSRoY/VIMuh4eTLrKVmXyt1GW9D
 qTf9qNpJ/r7gpch3KaMQdHvbCSK6zQjXj0kj1ywg/xU9Uk5+nwu+opKHMwpA36qU04BTioD
 HZfur8uZF/wduzz3V8sIdThEty5+pSYqtRa3D1yKuuaZuP45I5oMWpH2mNA4ppQZRbEO6K4
 /U0HiGQxN0B3xuc4JwpPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:owynCMj6ZB0=:dY43jbnMOLA/sdXkY9YXDt
 3D3kgMLQNVE2RgFfOx7xc8a7esy4Fk42QCIElbKmzyZNWvodqHLKFx4ctaNvzwEx4QdbIlD/7
 U5mBSqAfU0IFPgM0KznBV/Kt+5Dijw+iAR3saaWatbQwFh+KPONxqJwf9A/eCYD53+xYhcCPT
 eSF/ObWp06DdewxPFGVOSUZfnrkGWfFhXHLQl7vOeakoA59y8TU88Ksfl6GK+Qo90B0KGEmgy
 ejpLEkyNilqUY2xWsdhuxjdzaV6ghqW1GGNgUp1GKxtnsdAumOut2g5zTQNI+C5TPpzDQpNa0
 vX4rtkdN2cAopgwRuCAE1CQY7JylXi1gUQ/QPZoKlerMe+Lv0V9O7/7Ra6e0wqehoXCEJXWTc
 N/7ojAA696jwWZv3Lygju4MbQysj87aBctHELqawOETtkZAB9bTuXZFwXIcj+bQ3kvgN9GSiG
 F16dgsTmc37bPg7XScURB2edDngbgkVdD6p0ZszQrtrhTsCxb1RTDDytfTwnKiaduP1UYIrKK
 HAhMXOup7KC+tUg3R/qdZsdLBlVr3HJoQ0MIW7M4h//vlOfRooJJ3TJRhd9iRVIfG2tSmHIRb
 z+RoSGIhvAtLLVsQCbO7lYabm919yTgWAg/+pYkBXR3d1fFIU+hqWFCKFd5nd8h0CUfnatQJv
 LBTi7IJGa43pxCfytY17FC34U2Iplp9vXiRImIwrNjUlDAWQpOHZZhp8DeJQf3Z/XE23m2Pg5
 KGFberihYSRc8vkKrTyUIoONZ5V8R6DPUdRGmnhITcSq0q3zpcfLEtSbrUWpY7pWUmODhPKA8
 1v0yzafUNyvPRH8jvHtL2i/QY5R4ZUJfUdT5s6J4DzukGwp1iEu4On0wPmyq+6HpMmpGNIeVW
 GZS+P8C4HMsApTc0z9lQ==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A lot of block drivers need only a trivial .compat_ioctl callback.

Add a helper function that can be set as the callback pointer
to only convert the argument using the compat_ptr() conversion
and otherwise assume all input and output data is compatible,
or handled using in_compat_syscall() checks.

This mirrors the compat_ptr_ioctl() helper function used in
character devices.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/ioctl.c          | 21 +++++++++++++++++++++
 include/linux/blkdev.h |  7 +++++++
 2 files changed, 28 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 5de98b97af2a..e728331d1a5b 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/capability.h>
+#include <linux/compat.h>
 #include <linux/blkdev.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
@@ -285,6 +286,26 @@ int __blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
  */
 EXPORT_SYMBOL_GPL(__blkdev_driver_ioctl);
 
+#ifdef CONFIG_COMPAT
+/*
+ * This is the equivalent of compat_ptr_ioctl(), to be used by block
+ * drivers that implement only commands that are completely compatible
+ * between 32-bit and 64-bit user space
+ */
+int blkdev_compat_ptr_ioctl(struct block_device *bdev, fmode_t mode,
+			unsigned cmd, unsigned long arg)
+{
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (disk->fops->ioctl)
+		return disk->fops->ioctl(bdev, mode, cmd,
+					 (unsigned long)compat_ptr(arg));
+
+	return -ENOIOCTLCMD;
+}
+EXPORT_SYMBOL(blkdev_compat_ptr_ioctl);
+#endif
+
 static int blkdev_pr_register(struct block_device *bdev,
 		struct pr_registration __user *arg)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 47eb22a3b7f9..3e0408618da7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1711,6 +1711,13 @@ struct block_device_operations {
 	const struct pr_ops *pr_ops;
 };
 
+#ifdef CONFIG_COMPAT
+extern int blkdev_compat_ptr_ioctl(struct block_device *, fmode_t,
+				      unsigned int, unsigned long);
+#else
+#define blkdev_compat_ptr_ioctl NULL
+#endif
+
 extern int __blkdev_driver_ioctl(struct block_device *, fmode_t, unsigned int,
 				 unsigned long);
 extern int bdev_read_page(struct block_device *, sector_t, struct page *);
-- 
2.20.0


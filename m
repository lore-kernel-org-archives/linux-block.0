Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B96C433E2
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 08:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A1820791
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 08:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgIDIsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:48:08 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:15300 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgIDIsH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Sep 2020 04:48:07 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 4E262E4E919A776F1020;
        Fri,  4 Sep 2020 16:48:04 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 0848m3UC023235;
        Fri, 4 Sep 2020 16:48:03 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020090416483927-4846041 ;
          Fri, 4 Sep 2020 16:48:39 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     minchan@kernel.org
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        zhanglin <zhang.lin16@zte.com.cn>
Subject: [PATCH v2] zram: add restriction on dynamic zram device creation
Date:   Fri, 4 Sep 2020 16:52:10 +0800
Message-Id: <1599209530-41015-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-09-04 16:48:39,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-09-04 16:48:12,
        Serialize complete at 2020-09-04 16:48:12
X-MAIL: mse-fl2.zte.com.cn 0848m3UC023235
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: zhanglin <zhang.lin16@zte.com.cn>

Add max_num_devices to limit dynamic zram device creation to prevent
 potential OOM

Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
v1->v2:
change hard-coded initial max_num_devices into configurable way.

 drivers/block/zram/Kconfig    |  7 +++++++
 drivers/block/zram/zram_drv.c | 28 +++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..54a369932417 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -37,3 +37,10 @@ config ZRAM_MEMORY_TRACKING
 	  /sys/kernel/debug/zram/zramX/block_state.
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
+
+config ZRAM_DEV_MAX_COUNT
+	int "Number of zram devices to be created"
+	depends on ZRAM
+	default 256
+	help
+	  This option specifies the maximum number of zram devices.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 36d49159140f..d1022f3c04c4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -43,8 +43,9 @@ static DEFINE_MUTEX(zram_index_mutex);
 static int zram_major;
 static const char *default_compressor = "lzo-rle";
 
-/* Module params (documentation at end) */
 static unsigned int num_devices = 1;
+/* Module params (documentation at end) */
+static unsigned int max_num_devices = CONFIG_ZRAM_DEV_MAX_COUNT;
 /*
  * Pages that compress to sizes equals or greater than this are stored
  * uncompressed in memory.
@@ -2013,10 +2014,16 @@ static ssize_t hot_add_show(struct class *class,
 			struct class_attribute *attr,
 			char *buf)
 {
-	int ret;
+	int ret = -ENOSPC;
 
 	mutex_lock(&zram_index_mutex);
+	if (num_devices >= max_num_devices) {
+		mutex_unlock(&zram_index_mutex);
+		return ret;
+	}
 	ret = zram_add();
+	if (ret >= 0)
+		num_devices += 1;
 	mutex_unlock(&zram_index_mutex);
 
 	if (ret < 0)
@@ -2046,8 +2053,10 @@ static ssize_t hot_remove_store(struct class *class,
 	zram = idr_find(&zram_index_idr, dev_id);
 	if (zram) {
 		ret = zram_remove(zram);
-		if (!ret)
+		if (!ret) {
 			idr_remove(&zram_index_idr, dev_id);
+			num_devices -= 1;
+		}
 	} else {
 		ret = -ENODEV;
 	}
@@ -2089,6 +2098,7 @@ static void destroy_devices(void)
 static int __init zram_init(void)
 {
 	int ret;
+	unsigned int i;
 
 	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
 				      zcomp_cpu_up_prepare, zcomp_cpu_dead);
@@ -2111,13 +2121,17 @@ static int __init zram_init(void)
 		return -EBUSY;
 	}
 
-	while (num_devices != 0) {
+	if (num_devices > max_num_devices) {
+		pr_err("Number of pre-created zram devices over limit\n");
+		goto out_error;
+	}
+
+	for (i = 0; i < num_devices; i++) {
 		mutex_lock(&zram_index_mutex);
 		ret = zram_add();
 		mutex_unlock(&zram_index_mutex);
 		if (ret < 0)
 			goto out_error;
-		num_devices--;
 	}
 
 	return 0;
@@ -2135,8 +2149,8 @@ static void __exit zram_exit(void)
 module_init(zram_init);
 module_exit(zram_exit);
 
-module_param(num_devices, uint, 0);
-MODULE_PARM_DESC(num_devices, "Number of pre-created zram devices");
+module_param(max_num_devices, uint, 0);
+MODULE_PARM_DESC(max_num_devices, "Max number of created zram devices");
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Nitin Gupta <ngupta@vflare.org>");
-- 
2.17.1


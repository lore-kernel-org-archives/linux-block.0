Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB607C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 06:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3AC2087D
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 06:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAGzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:55:13 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:30360 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAGzN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 02:55:13 -0400
X-Greylist: delayed 968 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 02:55:10 EDT
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id EA52283F3CB19F970398;
        Tue,  1 Sep 2020 14:38:51 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 0816cWoY026407;
        Tue, 1 Sep 2020 14:38:32 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020090114384412-4808023 ;
          Tue, 1 Sep 2020 14:38:44 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     minchan@kernel.org
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        zhanglin <zhang.lin16@zte.com.cn>
Subject: [PATCH] zram: add restriction on dynamic zram device creation
Date:   Tue, 1 Sep 2020 14:42:47 +0800
Message-Id: <1598942567-33440-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-09-01 14:38:44,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-09-01 14:38:39,
        Serialize complete at 2020-09-01 14:38:39
X-MAIL: mse-fl1.zte.com.cn 0816cWoY026407
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: zhanglin <zhang.lin16@zte.com.cn>

Add max_num_devices to limit dynamic zram device creation to prevent
 potential OOM

Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
---
 drivers/block/zram/zram_drv.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 36d49159140f..4f2c4eef5051 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -43,8 +43,9 @@ static DEFINE_MUTEX(zram_index_mutex);
 static int zram_major;
 static const char *default_compressor = "lzo-rle";
 
-/* Module params (documentation at end) */
 static unsigned int num_devices = 1;
+/* Module params (documentation at end) */
+static unsigned int max_num_devices = 8;
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
@@ -2111,13 +2121,15 @@ static int __init zram_init(void)
 		return -EBUSY;
 	}
 
-	while (num_devices != 0) {
+	if (num_devices > max_num_devices)
+		num_devices = max_num_devices;
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
@@ -2135,8 +2147,8 @@ static void __exit zram_exit(void)
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


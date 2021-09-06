Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E1C433FE
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F30161027
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 12:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbhIFMtY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 08:49:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52009 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242088AbhIFMtJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 08:49:09 -0400
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 186CluMO020304;
        Mon, 6 Sep 2021 21:47:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Mon, 06 Sep 2021 21:47:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 186CltHc020301
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Sep 2021 21:47:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] brd: reduce the brd_devices_mutex scope
Message-ID: <65b57a74-34db-d466-df67-c7a7bb529ae3@i-love.sakura.ne.jp>
Date:   Mon, 6 Sep 2021 21:47:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As with commit 8b52d8be86d72308 ("loop: reorder loop_exit"),
unregister_blkdev() needs to be called first in order to avoid calling
brd_alloc() from brd_probe() after brd_del_one() from brd_exit(). Then,
we can avoid holding global mutex during add_disk()/del_gendisk() as with
commit 1c500ad706383f1a ("loop: reduce the loop_ctl_mutex scope").

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
I thought that this patch can fix similar circular locking problem at __loop_clr_fd()
(e.g. https://syzkaller.appspot.com/text?tag=CrashReport&x=1026e92e300000 ) in
https://syzkaller.appspot.com/bug?id=7bb10e8b62f83e4d445cdf4c13d69e407e629558 , but
it turned out that breaking major_names_lock => brd_devices_mutex => disk->open_mutex
chain is not sufficient (it might be "block: support delayed holder registration"
that is causing major_names_lock => &disk->open_mutex => &lo->lo_mutex chain).
Thus, submitting as a normal patch.

 drivers/block/brd.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 58ec167aa018..fceeff796e07 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -373,10 +373,22 @@ static int brd_alloc(int i)
 	struct gendisk *disk;
 	char buf[DISK_NAME_LEN];
 
+	mutex_lock(&brd_devices_mutex);
+	list_for_each_entry(brd, &brd_devices, brd_list) {
+		if (brd->brd_number != i)
+			continue;
+		mutex_unlock(&brd_devices_mutex);
+		return -EEXIST;
+	}
 	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
-	if (!brd)
+	if (!brd) {
+		mutex_unlock(&brd_devices_mutex);
 		return -ENOMEM;
+	}
 	brd->brd_number		= i;
+	list_add_tail(&brd->brd_list, &brd_devices);
+	mutex_unlock(&brd_devices_mutex);
+
 	spin_lock_init(&brd->brd_lock);
 	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
 
@@ -411,37 +423,30 @@ static int brd_alloc(int i)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
 	add_disk(disk);
-	list_add_tail(&brd->brd_list, &brd_devices);
 
 	return 0;
 
 out_free_dev:
+	mutex_lock(&brd_devices_mutex);
+	list_del(&brd->brd_list);
+	mutex_unlock(&brd_devices_mutex);
 	kfree(brd);
 	return -ENOMEM;
 }
 
 static void brd_probe(dev_t dev)
 {
-	int i = MINOR(dev) / max_part;
-	struct brd_device *brd;
-
-	mutex_lock(&brd_devices_mutex);
-	list_for_each_entry(brd, &brd_devices, brd_list) {
-		if (brd->brd_number == i)
-			goto out_unlock;
-	}
-
-	brd_alloc(i);
-out_unlock:
-	mutex_unlock(&brd_devices_mutex);
+	brd_alloc(MINOR(dev) / max_part);
 }
 
 static void brd_del_one(struct brd_device *brd)
 {
-	list_del(&brd->brd_list);
 	del_gendisk(brd->brd_disk);
 	blk_cleanup_disk(brd->brd_disk);
 	brd_free_pages(brd);
+	mutex_lock(&brd_devices_mutex);
+	list_del(&brd->brd_list);
+	mutex_unlock(&brd_devices_mutex);
 	kfree(brd);
 }
 
@@ -491,25 +496,21 @@ static int __init brd_init(void)
 
 	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
 
-	mutex_lock(&brd_devices_mutex);
 	for (i = 0; i < rd_nr; i++) {
 		err = brd_alloc(i);
 		if (err)
 			goto out_free;
 	}
 
-	mutex_unlock(&brd_devices_mutex);
-
 	pr_info("brd: module loaded\n");
 	return 0;
 
 out_free:
+	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
 	debugfs_remove_recursive(brd_debugfs_dir);
 
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list)
 		brd_del_one(brd);
-	mutex_unlock(&brd_devices_mutex);
-	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
 
 	pr_info("brd: module NOT loaded !!!\n");
 	return err;
@@ -519,13 +520,12 @@ static void __exit brd_exit(void)
 {
 	struct brd_device *brd, *next;
 
+	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
 	debugfs_remove_recursive(brd_debugfs_dir);
 
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list)
 		brd_del_one(brd);
 
-	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
-
 	pr_info("brd: module unloaded\n");
 }
 
-- 
2.30.2


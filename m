Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1B3C433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 16:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983AA61151
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 16:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242510AbhJQQU1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 12:20:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64174 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242328AbhJQQU0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 12:20:26 -0400
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 19HGI9bE070901;
        Mon, 18 Oct 2021 01:18:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 18 Oct 2021 01:18:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 19HGI98x070898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Oct 2021 01:18:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] brd: remove brd_devices_mutex mutex
Message-ID: <554f57b8-8c18-0293-f76c-0626a5e0184f@i-love.sakura.ne.jp>
Date:   Mon, 18 Oct 2021 01:18:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If brd_alloc() from brd_probe() is called before brd_alloc() from
brd_init() is called, module loading will fail with -EEXIST error.
To close this race, call __register_blkdev() just before leaving
brd_init().

Then, we can remove brd_devices_mutex mutex, for brd_device list
will no longer be accessed concurrently.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/brd.c | 73 +++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index aa0472718dce..028c2c593fc8 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -362,7 +362,6 @@ __setup("ramdisk_size=", ramdisk_size);
  * (should share code eventually).
  */
 static LIST_HEAD(brd_devices);
-static DEFINE_MUTEX(brd_devices_mutex);
 static struct dentry *brd_debugfs_dir;
 
 static int brd_alloc(int i)
@@ -371,21 +370,14 @@ static int brd_alloc(int i)
 	struct gendisk *disk;
 	char buf[DISK_NAME_LEN];
 
-	mutex_lock(&brd_devices_mutex);
-	list_for_each_entry(brd, &brd_devices, brd_list) {
-		if (brd->brd_number == i) {
-			mutex_unlock(&brd_devices_mutex);
+	list_for_each_entry(brd, &brd_devices, brd_list)
+		if (brd->brd_number == i)
 			return -EEXIST;
-		}
-	}
 	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
-	if (!brd) {
-		mutex_unlock(&brd_devices_mutex);
+	if (!brd)
 		return -ENOMEM;
-	}
 	brd->brd_number		= i;
 	list_add_tail(&brd->brd_list, &brd_devices);
-	mutex_unlock(&brd_devices_mutex);
 
 	spin_lock_init(&brd->brd_lock);
 	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
@@ -425,9 +417,7 @@ static int brd_alloc(int i)
 	return 0;
 
 out_free_dev:
-	mutex_lock(&brd_devices_mutex);
 	list_del(&brd->brd_list);
-	mutex_unlock(&brd_devices_mutex);
 	kfree(brd);
 	return -ENOMEM;
 }
@@ -437,15 +427,19 @@ static void brd_probe(dev_t dev)
 	brd_alloc(MINOR(dev) / max_part);
 }
 
-static void brd_del_one(struct brd_device *brd)
+static void brd_cleanup(void)
 {
-	del_gendisk(brd->brd_disk);
-	blk_cleanup_disk(brd->brd_disk);
-	brd_free_pages(brd);
-	mutex_lock(&brd_devices_mutex);
-	list_del(&brd->brd_list);
-	mutex_unlock(&brd_devices_mutex);
-	kfree(brd);
+	struct brd_device *brd, *next;
+
+	debugfs_remove_recursive(brd_debugfs_dir);
+
+	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
+		del_gendisk(brd->brd_disk);
+		blk_cleanup_disk(brd->brd_disk);
+		brd_free_pages(brd);
+		list_del(&brd->brd_list);
+		kfree(brd);
+	}
 }
 
 static inline void brd_check_and_reset_par(void)
@@ -469,9 +463,18 @@ static inline void brd_check_and_reset_par(void)
 
 static int __init brd_init(void)
 {
-	struct brd_device *brd, *next;
 	int err, i;
 
+	brd_check_and_reset_par();
+
+	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
+
+	for (i = 0; i < rd_nr; i++) {
+		err = brd_alloc(i);
+		if (err)
+			goto out_free;
+	}
+
 	/*
 	 * brd module now has a feature to instantiate underlying device
 	 * structure on-demand, provided that there is an access dev node.
@@ -487,28 +490,16 @@ static int __init brd_init(void)
 	 *	dynamically.
 	 */
 
-	if (__register_blkdev(RAMDISK_MAJOR, "ramdisk", brd_probe))
-		return -EIO;
-
-	brd_check_and_reset_par();
-
-	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
-
-	for (i = 0; i < rd_nr; i++) {
-		err = brd_alloc(i);
-		if (err)
-			goto out_free;
+	if (__register_blkdev(RAMDISK_MAJOR, "ramdisk", brd_probe)) {
+		err = -EIO;
+		goto out_free;
 	}
 
 	pr_info("brd: module loaded\n");
 	return 0;
 
 out_free:
-	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
-	debugfs_remove_recursive(brd_debugfs_dir);
-
-	list_for_each_entry_safe(brd, next, &brd_devices, brd_list)
-		brd_del_one(brd);
+	brd_cleanup();
 
 	pr_info("brd: module NOT loaded !!!\n");
 	return err;
@@ -516,13 +507,9 @@ static int __init brd_init(void)
 
 static void __exit brd_exit(void)
 {
-	struct brd_device *brd, *next;
 
 	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
-	debugfs_remove_recursive(brd_debugfs_dir);
-
-	list_for_each_entry_safe(brd, next, &brd_devices, brd_list)
-		brd_del_one(brd);
+	brd_cleanup();
 
 	pr_info("brd: module unloaded\n");
 }
-- 
2.18.4


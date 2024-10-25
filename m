Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751BE67A0D
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840091; cv=none; b=jin0fdoWXg5xSv7+H3rTguoEVGsRhJx+VfMdC3mmMmWtDYYmPiYXKpyFVR5VwenXvPylGzNoZg0b+tWvvQzvZ2wKZLy9mCDaYeg4ZwXk0Ra5kurn1pabm0NhmbGhw4dld5HdJoQW1kU+ZgNQIZriqEUHrknSSJch7wrDVEUBDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840091; c=relaxed/simple;
	bh=OCt2JXDwQcahD201JmN8JzcHxOMa0mpP4bfT4+/gq/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WxMxPFeHCllhoMxZCDS13sIRlofINRmPagaudTw5PC/dnHUzpBpjSgk/Qgiqkz/wX8qpXWNDVcAEHatKZuvZqyNHXziO/SlXMO9q8aoK0DS3ji2qPRfVWaPKvF0SBS903f1NtPuIkFVVVfEl8xI2piKcARJEJtRqQAFZGfZfrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZYl50m96z4f3jXg
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 15:07:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 98B871A018D
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 15:08:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAnXMjLQxtniG9BFA--.60018S4;
	Fri, 25 Oct 2024 15:08:02 +0800 (CST)
From: Yang Erkun <yangerkun@huaweicloud.com>
To: axboe@kernel.dk,
	ulf.hansson@linaro.org,
	hch@lst.de,
	yukuai3@huawei.com,
	houtao1@huawei.com,
	penguin-kernel@i-love.sakura.ne.jp
Cc: linux-block@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH] brd: fix null pointer when modprobe brd
Date: Fri, 25 Oct 2024 15:05:11 +0800
Message-Id: <20241025070511.932879-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnXMjLQxtniG9BFA--.60018S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1xWF13GryUCw47Ary8uFg_yoW7Xw13pa
	13KrWxtrWrCrs3K3yUXw1UuF1rJa1v93yxZ3WxCr1S9r4rArySv3WFyFyjvryrGrWkAF15
	ZFZ8tF18WF1rC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUU
	UUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Yang Erkun <yangerkun@huawei.com>

My colleague Wupeng found the following problems during fault injection:

BUG: unable to handle page fault for address: fffffbfff809d073
PGD 6e648067 P4D 123ec8067 PUD 123ec4067 PMD 100e38067 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 5 UID: 0 PID: 755 Comm: modprobe Not tainted 6.12.0-rc3+ #17
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
RIP: 0010:__asan_load8+0x4c/0xa0
...
Call Trace:
 <TASK>
 blkdev_put_whole+0x41/0x70
 bdev_release+0x1a3/0x250
 blkdev_release+0x11/0x20
 __fput+0x1d7/0x4a0
 task_work_run+0xfc/0x180
 syscall_exit_to_user_mode+0x1de/0x1f0
 do_syscall_64+0x6b/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The error path of modprobe will ignores the refcnt for the module, and
directly releases everything about this all associated resources. For
the brd module, it can be brd_fops. The brd_init function attempts to
create 16 ramdisks; each time add_disk is called, a file for the block
device is created to help do partition scanning and remains alive util
we return to userspace(Also we can open it with another user thread).
Let's say brd_init has successfully create the first ramdisk, but fail
to create the second, the error handling path will release code segment.
Consequently, bdev_release for file of first ramdisk will trigger null
pointer since brd_fops has been removed.

To resolve issue, implement a solution similar to loop_init, and
reintroduce brd_devices_mutex to help serialize modifications to
brd_list.

Fixes: 7f9b348cb5e9 ("brd: convert to blk_alloc_disk/blk_cleanup_disk")
Reported-by: Wupeng Ma <mawupeng1@huawei.com>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/brd.c | 70 ++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 2fd1ed101748..f86dd0795d3c 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -316,6 +316,7 @@ __setup("ramdisk_size=", ramdisk_size);
  * (should share code eventually).
  */
 static LIST_HEAD(brd_devices);
+static DEFINE_MUTEX(brd_devices_mutex);
 static struct dentry *brd_debugfs_dir;
 
 static int brd_alloc(int i)
@@ -340,14 +341,21 @@ static int brd_alloc(int i)
 					  BLK_FEAT_NOWAIT,
 	};
 
-	list_for_each_entry(brd, &brd_devices, brd_list)
-		if (brd->brd_number == i)
+	mutex_lock(&brd_devices_mutex);
+	list_for_each_entry(brd, &brd_devices, brd_list) {
+		if (brd->brd_number == i) {
+			mutex_unlock(&brd_devices_mutex);
 			return -EEXIST;
+		}
+	}
 	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
-	if (!brd)
+	if (!brd) {
+		mutex_unlock(&brd_devices_mutex);
 		return -ENOMEM;
+	}
 	brd->brd_number		= i;
 	list_add_tail(&brd->brd_list, &brd_devices);
+	mutex_unlock(&brd_devices_mutex);
 
 	xa_init(&brd->brd_pages);
 
@@ -378,7 +386,9 @@ static int brd_alloc(int i)
 out_cleanup_disk:
 	put_disk(disk);
 out_free_dev:
+	mutex_lock(&brd_devices_mutex);
 	list_del(&brd->brd_list);
+	mutex_unlock(&brd_devices_mutex);
 	kfree(brd);
 	return err;
 }
@@ -388,21 +398,6 @@ static void brd_probe(dev_t dev)
 	brd_alloc(MINOR(dev) / max_part);
 }
 
-static void brd_cleanup(void)
-{
-	struct brd_device *brd, *next;
-
-	debugfs_remove_recursive(brd_debugfs_dir);
-
-	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
-		del_gendisk(brd->brd_disk);
-		put_disk(brd->brd_disk);
-		brd_free_pages(brd);
-		list_del(&brd->brd_list);
-		kfree(brd);
-	}
-}
-
 static inline void brd_check_and_reset_par(void)
 {
 	if (unlikely(!max_part))
@@ -424,17 +419,7 @@ static inline void brd_check_and_reset_par(void)
 
 static int __init brd_init(void)
 {
-	int err, i;
-
-	brd_check_and_reset_par();
-
-	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
-
-	for (i = 0; i < rd_nr; i++) {
-		err = brd_alloc(i);
-		if (err)
-			goto out_free;
-	}
+	int i;
 
 	/*
 	 * brd module now has a feature to instantiate underlying device
@@ -450,28 +435,35 @@ static int __init brd_init(void)
 	 *	If (X / max_part) was not already created it will be created
 	 *	dynamically.
 	 */
+	brd_check_and_reset_par();
+	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
 
 	if (__register_blkdev(RAMDISK_MAJOR, "ramdisk", brd_probe)) {
-		err = -EIO;
-		goto out_free;
+		pr_info("brd: module NOT loaded !!!\n");
+		debugfs_remove_recursive(brd_debugfs_dir);
+		return -EIO;
 	}
 
+	for (i = 0; i < rd_nr; i++)
+		brd_alloc(i);
+
 	pr_info("brd: module loaded\n");
 	return 0;
-
-out_free:
-	brd_cleanup();
-
-	pr_info("brd: module NOT loaded !!!\n");
-	return err;
 }
 
 static void __exit brd_exit(void)
 {
+	struct brd_device *brd, *next;
 
 	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
-	brd_cleanup();
-
+	debugfs_remove_recursive(brd_debugfs_dir);
+	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
+		del_gendisk(brd->brd_disk);
+		put_disk(brd->brd_disk);
+		brd_free_pages(brd);
+		list_del(&brd->brd_list);
+		kfree(brd);
+	}
 	pr_info("brd: module unloaded\n");
 }
 
-- 
2.39.2


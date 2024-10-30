Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65228F7
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730260351; cv=none; b=Hspf9FAcLlJRkk3fnpKXzv8vlaFvJ7SKgToVC27tO2fl/HyErcWoVQD6OVBnuRQAu94VTQnyn+j25WFM5d/lYfFjcNXhr5MiUrz6ttHHpa4r5hGM0tMT0IL9ayVh91LQQaGTBRuPXjgTCn7BTU6YicO622l8Y9tOK5gmfAP9s8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730260351; c=relaxed/simple;
	bh=uT8oxjYgqQQLCOiXAOgePDDXIZJCEvwqmMML3TW4XhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMpAXaqTT4sgLhvMSMzq7zlejoXQoixhnDa9mW+uAR0hQQxMiQZF8JHMmhJQOFPjBE3peEtKKxRaftniVyUnUK46+wMXoxiDA+Z5EmL+ay2iXd/hWBnubv7vwZ1Pdq0pyN5JhCceMy8OR4dNG+79e6txdv+EnD3qoUh9+xGZGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XdY8y1rnwz4f3lVp
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 11:52:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BEED41A0196
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 11:52:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCngYVurSFn5fNXAQ--.10778S4;
	Wed, 30 Oct 2024 11:52:20 +0800 (CST)
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
Subject: [PATCH v2] brd: defer automatic disk creation until module initialization succeeds
Date: Wed, 30 Oct 2024 11:49:14 +0800
Message-Id: <20241030034914.907829-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYVurSFn5fNXAQ--.10778S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1xWF47tr4DKry7Wry8Xwb_yoW7Xw43pF
	W3KFW8trW5Gr1fGw4UX3W7uFyrGa109w4rXa4xuw1S9r45Ar9aqayIy34jqrZ5GrWkAF4U
	ZrZ8KF48Wr4F93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

loop_init() is calling loop_add() after __register_blkdev() succeeds and
is ignoring disk_add() failure from loop_add(), for loop_add() failure
is not fatal and successfully created disks are already visible to
bdev_open().

brd_init() is currently calling brd_alloc() before __register_blkdev()
succeeds and is releasing successfully created disks when brd_init()
returns an error. This can cause UAF for the latter two case:

case 1:
    T1:
modprobe brd
  brd_init
    brd_alloc(0) // success
      add_disk
        disk_scan_partitions
          bdev_file_open_by_dev // alloc file
          fput // won't free until back to userspace
    brd_alloc(1) // failed since mem alloc error inject
  // error path for modprobe will release code segment
  // back to userspace
  __fput
    blkdev_release
      bdev_release
        blkdev_put_whole
          bdev->bd_disk->fops->release // fops is freed now, UAF!

case 2:
    T1:                            T2:
modprobe brd
  brd_init
    brd_alloc(0) // success
                                   open(/dev/ram0)
    brd_alloc(1) // fail
  // error path for modprobe

                                   close(/dev/ram0)
                                   ...
                                   /* UAF! */
                                   bdev->bd_disk->fops->release

Fix this problem by following what loop_init() does. Besides,
reintroduce brd_devices_mutex to help serialize modifications to
brd_list.

Fixes: 7f9b348cb5e9 ("brd: convert to blk_alloc_disk/blk_cleanup_disk")
Reported-by: Wupeng Ma <mawupeng1@huawei.com>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/brd.c | 66 ++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 22 deletions(-)

v1->v2:
1. add brd_find_or_alloc_device and brd_free_device
2. remove pr_info in brd_alloc

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 2fd1ed101748..5a95671d8151 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -316,8 +316,40 @@ __setup("ramdisk_size=", ramdisk_size);
  * (should share code eventually).
  */
 static LIST_HEAD(brd_devices);
+static DEFINE_MUTEX(brd_devices_mutex);
 static struct dentry *brd_debugfs_dir;
 
+static struct brd_device *brd_find_or_alloc_device(int i)
+{
+	struct brd_device *brd;
+
+	mutex_lock(&brd_devices_mutex);
+	list_for_each_entry(brd, &brd_devices, brd_list) {
+		if (brd->brd_number == i) {
+			mutex_unlock(&brd_devices_mutex);
+			return ERR_PTR(-EEXIST);
+		}
+	}
+
+	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
+	if (!brd) {
+		mutex_unlock(&brd_devices_mutex);
+		return ERR_PTR(-ENOMEM);
+	}
+	brd->brd_number	= i;
+	list_add_tail(&brd->brd_list, &brd_devices);
+	mutex_unlock(&brd_devices_mutex);
+	return brd;
+}
+
+static void brd_free_device(struct brd_device *brd)
+{
+	mutex_lock(&brd_devices_mutex);
+	list_del(&brd->brd_list);
+	mutex_unlock(&brd_devices_mutex);
+	kfree(brd);
+}
+
 static int brd_alloc(int i)
 {
 	struct brd_device *brd;
@@ -340,14 +372,9 @@ static int brd_alloc(int i)
 					  BLK_FEAT_NOWAIT,
 	};
 
-	list_for_each_entry(brd, &brd_devices, brd_list)
-		if (brd->brd_number == i)
-			return -EEXIST;
-	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
-	if (!brd)
-		return -ENOMEM;
-	brd->brd_number		= i;
-	list_add_tail(&brd->brd_list, &brd_devices);
+	brd = brd_find_or_alloc_device(i);
+	if (IS_ERR(brd))
+		return PTR_ERR(brd);
 
 	xa_init(&brd->brd_pages);
 
@@ -378,8 +405,7 @@ static int brd_alloc(int i)
 out_cleanup_disk:
 	put_disk(disk);
 out_free_dev:
-	list_del(&brd->brd_list);
-	kfree(brd);
+	brd_free_device(brd);
 	return err;
 }
 
@@ -398,8 +424,7 @@ static void brd_cleanup(void)
 		del_gendisk(brd->brd_disk);
 		put_disk(brd->brd_disk);
 		brd_free_pages(brd);
-		list_del(&brd->brd_list);
-		kfree(brd);
+		brd_free_device(brd);
 	}
 }
 
@@ -426,16 +451,6 @@ static int __init brd_init(void)
 {
 	int err, i;
 
-	brd_check_and_reset_par();
-
-	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
-
-	for (i = 0; i < rd_nr; i++) {
-		err = brd_alloc(i);
-		if (err)
-			goto out_free;
-	}
-
 	/*
 	 * brd module now has a feature to instantiate underlying device
 	 * structure on-demand, provided that there is an access dev node.
@@ -451,11 +466,18 @@ static int __init brd_init(void)
 	 *	dynamically.
 	 */
 
+	brd_check_and_reset_par();
+
+	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
+
 	if (__register_blkdev(RAMDISK_MAJOR, "ramdisk", brd_probe)) {
 		err = -EIO;
 		goto out_free;
 	}
 
+	for (i = 0; i < rd_nr; i++)
+		brd_alloc(i);
+
 	pr_info("brd: module loaded\n");
 	return 0;
 
-- 
2.39.2


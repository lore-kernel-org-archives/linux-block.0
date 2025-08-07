Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A33D239E6C;
	Thu,  7 Aug 2025 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551709; cv=none; b=EhfR0/gzVLx/E7kOQhcp8NGJeR0kryWgs+JGXXeJiU90sy/c7nzYPSK6rXbl1TrzlSFHn4u48fv17sHlt22oqSwcQ9nu0PpmXEeJEg3kiqWAwY1NWolEQUYsHTdXN475+tpGm/JdxMBJeKoD+rJQo6mp5OKEzq5m/Vqy4Vp8MvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551709; c=relaxed/simple;
	bh=4o64GynvUBkTN2hnD4IwDeP6ZqqO+WhuuYItKP1ph/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FAR/37/J4RetWlj09sOqa0Jr9oD+iJT0rfMtIv3EXcOjDoNvdLOQFuYX9YmERhEXBFuzxw44egsWe7geh6Tr4oaOoHNa5lf9DUDISW7WEgTTfGSmsZeySjdXuUMhI477GhXYx8c41yvKcAlisjl93y+OBJB0oIoD/SEeOgMLaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4byJfv0CWmzKHMXF;
	Thu,  7 Aug 2025 15:28:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1E73A1A0A91;
	Thu,  7 Aug 2025 15:28:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3QBGPVZRoWahvCw--.53347S4;
	Thu, 07 Aug 2025 15:28:20 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH] block: fix kobject double initialization in add_disk
Date: Thu,  7 Aug 2025 15:20:56 +0800
Message-Id: <20250807072056.2627592-1-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3QBGPVZRoWahvCw--.53347S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4DZw48Kw13Xw47AF48Xrb_yoWrJrW3pr
	W5Jw47G3y0gr4xW39rA3W7JF1xWwn5Gr4xAws3KrySvFZIvrnFgF4UKFWxZF4xArs3GF4I
	qF4UtFZxKr1kCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUotCzDUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Zheng Qixing <zhengqixing@huawei.com>

Device-mapper can call add_disk() multiple times for the same gendisk
due to its two-phase creation process (dm create + dm load). This leads
to kobject double initialization errors when the underlying iSCSI devices
become temporarily unavailable and then reappear.

However, if the first add_disk() call fails and is retried, the queue_kobj
gets initialized twice, causing:

kobject: kobject (ffff88810c27bb90): tried to init an initialized object,
something is seriously wrong.
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5b/0x80
  kobject_init.cold+0x43/0x51
  blk_register_queue+0x46/0x280
  add_disk_fwnode+0xb5/0x280
  dm_setup_md_queue+0x194/0x1c0
  table_load+0x297/0x2d0
  ctl_ioctl+0x2a2/0x480
  dm_ctl_ioctl+0xe/0x20
  __x64_sys_ioctl+0xc7/0x110
  do_syscall_64+0x72/0x390
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix this by separating kobject initialization from sysfs registration:
 - Initialize queue_kobj early during gendisk allocation
 - add_disk() only adds the already-initialized kobject to sysfs
 - del_gendisk() removes from sysfs but doesn't destroy the kobject
 - Final cleanup happens when the disk is released

Fixes: 2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Closes: https://lore.kernel.org/all/83591d0b-2467-433c-bce0-5581298eb161@huawei.com/
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
---
 block/blk-sysfs.c | 4 +---
 block/blk.h       | 1 +
 block/genhd.c     | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 396cded255ea..37d8654faff9 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -847,7 +847,7 @@ static void blk_queue_release(struct kobject *kobj)
 	/* nothing to do here, all data is associated with the parent gendisk */
 }
 
-static const struct kobj_type blk_queue_ktype = {
+const struct kobj_type blk_queue_ktype = {
 	.default_groups = blk_queue_attr_groups,
 	.sysfs_ops	= &queue_sysfs_ops,
 	.release	= blk_queue_release,
@@ -875,7 +875,6 @@ int blk_register_queue(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	int ret;
 
-	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
 	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
 	if (ret < 0)
 		goto out_put_queue_kobj;
@@ -986,5 +985,4 @@ void blk_unregister_queue(struct gendisk *disk)
 		elevator_set_none(q);
 
 	blk_debugfs_remove(disk);
-	kobject_put(&disk->queue_kobj);
 }
diff --git a/block/blk.h b/block/blk.h
index 0a2eccf28ca4..46f566f9b126 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -29,6 +29,7 @@ struct elevator_tags;
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
+extern const struct kobj_type blk_queue_ktype;
 extern struct dentry *blk_debugfs_root;
 
 struct blk_flush_queue {
diff --git a/block/genhd.c b/block/genhd.c
index c26733f6324b..9bbc38d12792 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1303,6 +1303,7 @@ static void disk_release(struct device *dev)
 	disk_free_zone_resources(disk);
 	xa_destroy(&disk->part_tbl);
 
+	kobject_put(&disk->queue_kobj);
 	disk->queue->disk = NULL;
 	blk_put_queue(disk->queue);
 
@@ -1486,6 +1487,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	INIT_LIST_HEAD(&disk->slave_bdevs);
 #endif
 	mutex_init(&disk->rqos_state_mutex);
+	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
 	return disk;
 
 out_erase_part0:
-- 
2.39.2


Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C52931F1
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 02:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784946843; cv=none; b=mnm6wL/AgUImWHRoeKG0NcEjKXcFc4UpTTI8ZBTRFeJbJDkiVi/BE6XkTLeqr++GcqEGbjiDilJyIHawxynpsJhQcQKD7iSKBDaTkdXCK/YrktmvIVa70aS4M+pfs+nJYAW2h+OVZGIAabRF5VIwbMm5nU8gPsVlLiNlANvXH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784946843; c=relaxed/simple;
	bh=R3I6gVd+APqzfeC+W+pgCe8DnbwqbUbl4E5EOcivFNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUOmwCeyM+t/9IOtOm6gsfGn3WQude5OTR2pU8KF90tmcl/4Y872cfUGv++oOSIfW4jnXXgt8sv42UyKcINia3WzxVQz6iYYgCVpwhPooyfV50crgYLSAZrnhZDrXEma11vG9jqN3MnzqUo8RxV7HR71B2f1oaNnls4ORpiq+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h6TRm12BLzKHMXR
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0834D4056F
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHSSIGRqCkPTCQ--.40042S6;
	Sat, 25 Jul 2026 10:33:55 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	yukuai@fygo.io,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V6 02/10] null_blk: register configfs subsystem after creating default devices
Date: Sat, 25 Jul 2026 10:25:01 +0800
Message-ID: <20260725022509.714271-3-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260725022509.714271-1-wozizhi@huaweicloud.com>
References: <20260725022509.714271-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHSSIGRqCkPTCQ--.40042S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGrykGry8Ar17ur45ZFyrJFb_yoW5tFWfpF
	yUWw17Kry8tF1Uur4jva109FyfGan293yxu3yxCF1rZanxAry5AF9IvayrGF4UG3yxCF4f
	Xas0va1rGa48Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

In null_init(), configfs_register_subsystem() currently runs before
register_blkdev(), so when null_blk is built as a module, a racing mkdir()
+ poweron from userspace can reach null_add_dev() while null_major is still
0. __add_disk() then hits WARN_ON(disk->minors) (major=0 with minors!=0)
and fails:

[root@fedora ~]# [ 2366.521436] WARNING: block/genhd.c:476 at __add_disk+0x8a7/0xde0,
[ 2366.523552] Modules linked in: null_blk(+) nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
[ 2366.529081] CPU: 26 UID: 0 PID: 1600 Comm: sh Not tainted 7.2.0-rc1+ #66 PREEMPT(full)
......
[ 2366.547251] Call Trace:
[ 2366.547575]  <TASK>
[ 2366.547831]  ? _raw_spin_lock+0x84/0xe0
[ 2366.548260]  add_disk_fwnode+0x114/0x560
[ 2366.548739]  null_add_dev+0x102d/0x1b80 [null_blk]
[ 2366.549310]  ? __pfx_null_add_dev+0x10/0x10 [null_blk]
[ 2366.549906]  ? mutex_lock+0xde/0x1c0
[ 2366.550361]  ? __pfx_mutex_lock+0x10/0x10
[ 2366.550827]  nullb_device_power_store+0x1e7/0x280 [null_blk]
[ 2366.551499]  ? __pfx_nullb_device_power_store+0x10/0x10 [null_blk]
[ 2366.552177]  ? __kmalloc_cache_noprof+0x1f5/0x470
[ 2366.552748]  ? configfs_write_iter+0x35c/0x4e0
[ 2366.553242]  configfs_write_iter+0x286/0x4e0
[ 2366.553787]  vfs_write+0x52d/0xd00
[ 2366.554169]  ? __pfx_vfs_write+0x10/0x10
[ 2366.554679]  ? __pfx___css_rstat_updated+0x10/0x10
[ 2366.555196]  ? fdget_pos+0x1cf/0x4c0
[ 2366.555649]  ksys_write+0xfc/0x1d0
......

Additionally, the err_dev path destroys all devices on nullb_list while
configfs is still registered. If a racing mkdir() + poweron puts a user
device on the list, null_destroy_dev()->null_free_dev() kfrees the user
device's nullb_device but /sys/kernel/config/nullb/<name> is still
reachable. Any userspace access to the item will trigger a UAF.

For simplicity, move configfs_register_subsystem() to the end to solve
the problems above.

Fixes: 3bf2bd20734e ("nullb: add configfs interface")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/block/null_blk/main.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eba204b27785..4613035222cd 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2162,15 +2162,9 @@ static int __init null_init(void)
 	config_group_init(&nullb_subsys.su_group);
 	mutex_init(&nullb_subsys.su_mutex);
 
-	ret = configfs_register_subsystem(&nullb_subsys);
-	if (ret)
-		return ret;
-
 	null_major = register_blkdev(0, "nullb");
-	if (null_major < 0) {
-		ret = null_major;
-		goto err_conf;
-	}
+	if (null_major < 0)
+		return null_major;
 
 	for (i = 0; i < nr_devices; i++) {
 		ret = null_create_dev();
@@ -2178,6 +2172,10 @@ static int __init null_init(void)
 			goto err_dev;
 	}
 
+	ret = configfs_register_subsystem(&nullb_subsys);
+	if (ret)
+		goto err_dev;
+
 	pr_info("module loaded\n");
 	return 0;
 
@@ -2187,8 +2185,6 @@ static int __init null_init(void)
 		null_destroy_dev(nullb);
 	}
 	unregister_blkdev(null_major, "nullb");
-err_conf:
-	configfs_unregister_subsystem(&nullb_subsys);
 	return ret;
 }
 
-- 
2.52.0


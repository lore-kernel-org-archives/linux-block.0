Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015744431;
	Fri,  8 Nov 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060235; cv=none; b=rwn7zNub7DbVy2k+D+TsCXgDovoUqQC7rrew1wcoysOS+DBeTtRh8ojRMODFilUBV+Zc7p9kbY+DMVEM1fEnlpTXZyo7n1Db9G6eV7EcjgY7X8hdT6jcw3nqJoDPiM3vIdewsVD6vKnIjLFAadTQsaLEM7TzutstDzb6O2gT+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060235; c=relaxed/simple;
	bh=l5DnvzL4sy5C2lpQdy/WOoP4Io2r2vU4GWYByRNWdbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tw8SaDTVc9oztkLMYQGr44KSW0PUonNvQC2TbbfdcK/5YG0E3U3CHmosGOj4l+9KRSbR0RmB5OSVvbAxLZBnLN46AenB+ISoqMUcKnPzPbye8Vt+IjyPkEcTEYTXZ4B4pMEFqrR4DMEtiWk06xDnVsQZ7MDTskLH20a7rMbh9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XlDx23Xptz1T9vC;
	Fri,  8 Nov 2024 18:01:26 +0800 (CST)
Received: from kwepemg200013.china.huawei.com (unknown [7.202.181.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AC6A1400DC;
	Fri,  8 Nov 2024 18:03:49 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemg200013.china.huawei.com
 (7.202.181.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 8 Nov
 2024 18:03:48 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>, Liu Shixin
	<liushixin2@huawei.com>
Subject: [PATCH] zram: fix NULL pointer in comp_algorithm_show()
Date: Fri, 8 Nov 2024 18:01:47 +0800
Message-ID: <20241108100147.3776123-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200013.china.huawei.com (7.202.181.64)

LTP reported a NULL pointer dereference as followed:

 CPU: 7 UID: 0 PID: 5995 Comm: cat Kdump: loaded Not tainted 6.12.0-rc6+ #3
 Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
 pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __pi_strcmp+0x24/0x140
 lr : zcomp_available_show+0x60/0x100 [zram]
 sp : ffff800088b93b90
 x29: ffff800088b93b90 x28: 0000000000000001 x27: 0000000000400cc0
 x26: 0000000000000ffe x25: ffff80007b3e2388 x24: 0000000000000000
 x23: ffff80007b3e2390 x22: ffff0004041a9000 x21: ffff80007b3e2900
 x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
 x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
 x11: 0000000000000000 x10: ffff80007b3e2900 x9 : ffff80007b3cb280
 x8 : 0101010101010101 x7 : 0000000000000000 x6 : 0000000000000000
 x5 : 0000000000000040 x4 : 0000000000000000 x3 : 00656c722d6f7a6c
 x2 : 0000000000000000 x1 : ffff80007b3e2900 x0 : 0000000000000000
 Call trace:
  __pi_strcmp+0x24/0x140
  comp_algorithm_show+0x40/0x70 [zram]
  dev_attr_show+0x28/0x80
  sysfs_kf_seq_show+0x90/0x140
  kernfs_seq_show+0x34/0x48
  seq_read_iter+0x1d4/0x4e8
  kernfs_fop_read_iter+0x40/0x58
  new_sync_read+0x9c/0x168
  vfs_read+0x1a8/0x1f8
  ksys_read+0x74/0x108
  __arm64_sys_read+0x24/0x38
  invoke_syscall+0x50/0x120
  el0_svc_common.constprop.0+0xc8/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x38/0x138
  el0t_64_sync_handler+0xc0/0xc8
  el0t_64_sync+0x188/0x190

The zram->comp_algs[ZRAM_PRIMARY_COMP] can be NULL in zram_add() if
comp_algorithm_set() has not been called. User can access the zram device
by sysfs after device_add_disk(), so there is a time window to trigger
the NULL pointer dereference. Move it ahead device_add_disk() to make sure
when user can access the zram device, it is ready. comp_algorithm_set() is
protected by zram->init_lock in other places and no such problem.

Fixes: 7ac07a26dea7 ("zram: preparation for multi-zcomp support")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/block/zram/zram_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ad9c9bc3ccfc..5223a03cb10e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2381,6 +2381,8 @@ static int zram_add(void)
 	zram->disk->fops = &zram_devops;
 	zram->disk->private_data = zram;
 	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
+	zram_comp_params_reset(zram);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 
 	/* Actual capacity set using sysfs (/sys/block/zram<id>/disksize */
 	set_capacity(zram->disk, 0);
@@ -2388,9 +2390,6 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
-	zram_comp_params_reset(zram);
-	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
-
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
-- 
2.34.1


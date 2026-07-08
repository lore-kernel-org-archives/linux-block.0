Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B73ECBD7;
	Wed,  8 Jul 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496843; cv=none; b=YBejc182saoPWp0ibvB2P4Qj10AAhp3kf3O3zfTRqX7sYD5+OXKV0kbWgFPSTA7gRoUnZVr3uRFZ7DQxtfQoxHDac2KbOAnsw7VT8QsmQjBrFLsRZnc6EuyXVhtc9memjVmv0AtWzjCW1UL7T2H7bQiR2NfsmlOBJry3shZcnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496843; c=relaxed/simple;
	bh=KyBY0Wx24UXazHxvesDSqKgtWXTVcscQrz4YeAOpNeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6g7ANZKFjgALU2EKVSgWu3qjCN168pWrx8TZb7vOFXH023WFsUXZ4e9Xw0qZEYH++LWv8dM2di8ofu/v4Sx3GZZlmiRVtCm/Qa7PQO/HPnTxT2kV2TN3TW3R3Ok77CK1K+ffSyeUVLejA8BGipPATyoj0aYw+fMWhpoCw/oU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gw9CT0W9RzKHLtD;
	Wed,  8 Jul 2026 15:46:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B1B444058D;
	Wed,  8 Jul 2026 15:47:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCnt3N4AE5qQOTkAQ--.19577S5;
	Wed, 08 Jul 2026 15:47:05 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	bvanassche@acm.org,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V3 1/6] null_blk: use DEFINE_MUTEX for the file-scope mutex
Date: Wed,  8 Jul 2026 15:39:12 +0800
Message-ID: <20260708073917.2172392-2-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
References: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnt3N4AE5qQOTkAQ--.19577S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4rAr18Kr4xtFyfGFy3urg_yoW5Jr1DpF
	WUW34j9r10g3W7ZFsxta4xuFy5Aan2gFW8Gry7CF4F9FsxArn8ZFnrCFWYgF45K3yxA3y3
	XFnayryxAayUCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnpnQU
	UUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

In null_init(), mutex_init(&lock) currently happens after
configfs_register_subsystem(), which exposes the nullb subsystem to
userspace. A racing mkdir() into /sys/kernel/config/nullb/ can reach
null_find_dev_by_name() -> mutex_lock(&lock) before the mutex is
initialized, trigger warning:

[  123.137788] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[  123.137796] WARNING: kernel/locking/mutex.c:159 at mutex_lock+0x171/0x1c0, CPU#13: mkdir/1301
[  123.140090] Modules linked in: null_blk(+) nft_fib_inet nft_fib_ipv4
......
[  123.154926] Call Trace:
[  123.155172]  <TASK>
[  123.155419]  ? __pfx_mutex_lock+0x10/0x10
[  123.156181]  ? __pfx__raw_spin_lock+0x10/0x10
[  123.156571]  nullb_group_make_group+0x20/0x100 [null_blk]
[  123.157011]  configfs_mkdir+0x47b/0xc70
[  123.157337]  ? __pfx_configfs_mkdir+0x10/0x10
[  123.157719]  ? may_create_dentry+0x242/0x2e0
[  123.158061]  vfs_mkdir+0x2a9/0x6c0
[  123.158352]  filename_mkdirat+0x3dc/0x500
[  123.158710]  ? __pfx_filename_mkdirat+0x10/0x10
[  123.159070]  ? strncpy_from_user+0x3a/0x1d0
[  123.159413]  __x64_sys_mkdir+0x6b/0x90
[  123.159760]  do_syscall_64+0xea/0x600

Replace the runtime mutex_init(&lock) with a static DEFINE_MUTEX(lock)
declaration to fix this issue.

Fixes: 49c3b9266a71 ("block: null_blk: Improve device creation with configfs")
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f8c0fd57e041..eba204b27785 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -66,7 +66,7 @@ struct nullb_page {
 #define NULLB_PAGE_FREE (MAP_SZ - 2)
 
 static LIST_HEAD(nullb_list);
-static struct mutex lock;
+static DEFINE_MUTEX(lock);
 static int null_major;
 static DEFINE_IDA(nullb_indexes);
 static struct blk_mq_tag_set tag_set;
@@ -2166,8 +2166,6 @@ static int __init null_init(void)
 	if (ret)
 		return ret;
 
-	mutex_init(&lock);
-
 	null_major = register_blkdev(0, "nullb");
 	if (null_major < 0) {
 		ret = null_major;
-- 
2.52.0


Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9474403B1B;
	Thu,  9 Jul 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591975; cv=none; b=DBmDfuAlqBTLEPqIuIDXIN4GbV3IJx/qU/9Ec9lAdeIPnuv2BVGVX8UmfuPlxGiwqrerHY7fhQ7Dn6a5ITO9INXuFdCi++ndRt82Ha2vxv7XXrzbHVt0HsS0xBhIneafmHpK5K1TL3Z7gVNYqw/jXiKSfE1Nbuu3+LAGyAtoqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591975; c=relaxed/simple;
	bh=KNs7gluhh6T0Ax4ZeD42JP4XJ6xondfxz2FvhfuNJOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tx9vzTEgHGt1YqUm4eF+tUhjAnU5cu0BVc7fGljB7D10JkHWOfb5OkFnRkt4bSPqryK19TsWGPTyeHHe1w5IuScsqe+kRFJI4dFv+992mf+EZF7OattOKkjiZPakOsnqPul7n5XTSPQI3tP47TbE1dV37rvK3eK604OOBrWwLUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwrPK31mHzYQtyB;
	Thu,  9 Jul 2026 18:12:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F2EC340977;
	Thu,  9 Jul 2026 18:12:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHV3MadE9qn4RpAg--.38318S5;
	Thu, 09 Jul 2026 18:12:43 +0800 (CST)
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
Subject: [PATCH V4 1/9] null_blk: use DEFINE_MUTEX for the file-scope mutex
Date: Thu,  9 Jul 2026 18:04:43 +0800
Message-ID: <20260709100452.3520482-2-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHV3MadE9qn4RpAg--.38318S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWUAr4fZr4rWr18CF15Arb_yoW5Gr45pF
	WUW3409r10qF17ZFZ8ta4xuFy3Aan2gFW8Gry7CF1F9FsxArn8ArnrCFWYgF45K3yxC3y3
	XFnYyrWxAayUCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
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
@@ -64,11 +64,11 @@ struct nullb_page {
 };
 #define NULLB_PAGE_LOCK (MAP_SZ - 1)
 #define NULLB_PAGE_FREE (MAP_SZ - 2)
 
 static LIST_HEAD(nullb_list);
-static struct mutex lock;
+static DEFINE_MUTEX(lock);
 static int null_major;
 static DEFINE_IDA(nullb_indexes);
 static struct blk_mq_tag_set tag_set;
 
 enum {
@@ -2164,12 +2164,10 @@ static int __init null_init(void)
 
 	ret = configfs_register_subsystem(&nullb_subsys);
 	if (ret)
 		return ret;
 
-	mutex_init(&lock);
-
 	null_major = register_blkdev(0, "nullb");
 	if (null_major < 0) {
 		ret = null_major;
 		goto err_conf;
 	}
-- 
2.52.0


Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052A35AC24
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 02:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784946842; cv=none; b=aYIHBO8t/+aC0PeZT54Xbim6A8QqhQM+L5JUMGnOtnnd0oJmXfJFWIKp6YdRKhaRPjzLVc2dcxX0sPRUd7k0FaqqOwMuy2jQCGwzU4+a4MBn+IaGdeFqq03xjHSojF1v2v1+KXOWQ+SfI+vi3n+uXz+pbnvtl65cE40wJbRr2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784946842; c=relaxed/simple;
	bh=EcGqDsMlsaeRjagooE+hAHiA91B4aUYygjltS/lh91k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrUcxXZX8cWVYfgUxHpyzmAr5ZH+mD1b+doBq5IzplcjaTPG5NdD6m5RirUKndxol4m+50e4sw89her5qJ4e+Iqz1fPT7/RCek+H8GZHiIK4Ac7+Uz1KB6Stlxqogl4HeN11+BFEUMGhUurFp2cw8IIYXhBX+wFreE2Hf9bHCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6TS26dZMzYQtww
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 60D2D4056D
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHSSIGRqCkPTCQ--.40042S11;
	Sat, 25 Jul 2026 10:33:56 +0800 (CST)
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
Subject: [PATCH V6 07/10] null_blk: reject per-device queue resize for shared tag set
Date: Sat, 25 Jul 2026 10:25:06 +0800
Message-ID: <20260725022509.714271-8-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3SHSSIGRqCkPTCQ--.40042S11
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1xtF1xCryfAFW5AFyDAwb_yoW5KF43pF
	WrKa40kr1kG3WUX3yj9w12gF43AFs7ZFWfJryfJFy5uw1qvr95Z34kAa1UWFW8J3ykC3yS
	q3ZrZw4kKa4UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU1aLvJUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

When shared_tags is enabled, null_setup_tagset() makes the device use the
global tag_set, whose driver_data stays NULL. null_map_queues() therefore
falls back to the module-wide g_submit_queues/g_poll_queues instead of any
per-device value.

Resizing submit_queues or poll_queues via configfs on such a device calls
blk_mq_update_nr_hw_queues() on the shared set, shrinking
set->nr_hw_queues.  __blk_mq_realloc_hw_ctxs() only grows the
q->queue_hw_ctx[] allocation, so on shrink it merely exits and NULLs the
now-excess hctx slots. null_map_queues(), however, keeps mapping CPUs with
the unchanged g_submit_queues/g_poll_queues, so mq_map[] ends up pointing
at those NULLed hctx slots. blk_mq_map_swqueue() then dereferences the NULL
hctx (hctx->cpumask), crashing the kernel:

[  460.218374] KASAN: null-ptr-deref in range [0x0000000000000098-0x000000000000009f]
[  460.219003] CPU: 24 UID: 0 PID: 1492 Comm: sh Not tainted 7.2.0-rc2+ #67 PREEMPT(full)
[  460.219792] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
[  460.220452] RIP: 0010:blk_mq_map_swqueue+0x4db/0x1430
......
[  460.228977] Call Trace:
[  460.229175]  <TASK>
[  460.229354]  blk_mq_update_nr_hw_queues+0xd49/0x11c0
[  460.229779]  ? __pfx_blk_mq_update_nr_hw_queues+0x10/0x10
[  460.230200]  nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
[  460.230694]  nullb_device_submit_queues_store+0xd9/0x170 [null_blk]
[  460.231190]  ? __pfx_nullb_device_submit_queues_store+0x10/0x10 [null_blk]
[  460.231776]  ? configfs_write_iter+0x35c/0x4e0
[  460.232122]  configfs_write_iter+0x286/0x4e0
[  460.232460]  vfs_write+0x52d/0xd00
[  460.232779]  ? __x64_sys_openat+0x108/0x1d0
[  460.233106]  ? __pfx_vfs_write+0x10/0x10
[  460.233413]  ? fdget_pos+0x1cf/0x4c0
[  460.233745]  ? fput_close+0x133/0x190
[  460.234038]  ? __pfx_expand_files+0x10/0x10
[  460.234368]  ksys_write+0xfc/0x1d0

Reproducer:
modprobe null_blk shared_tags=1 submit_queues=64 poll_queues=1
mkdir /sys/kernel/config/nullb/dev
echo 1 > /sys/kernel/config/nullb/dev/power
echo 1 > /sys/kernel/config/nullb/dev/submit_queues

A per-device resize of a shared tag set is meaningless anyway, so reject it
with -EINVAL in nullb_update_nr_hw_queues() when the device is bound to the
global tag_set.

Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Assisted-by: Claude-Code:GLM-5.2
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 249caaf6ce89..ad6dfed12464 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -382,6 +382,15 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 	if (!dev->nullb)
 		return 0;
 
+	/*
+	 * A shared tag_set is mapped via the module-wide queue counts, so a
+	 * per-device resize is meaningless. On shrink it would also leave
+	 * mq_map[] pointing at NULLed hctx slots, causing a NULL deref in
+	 * blk_mq_map_swqueue(). Reject it.
+	 */
+	if (dev->shared_tags)
+		return -EINVAL;
+
 	/*
 	 * Make sure at least one submit queue exists.
 	 */
-- 
2.52.0


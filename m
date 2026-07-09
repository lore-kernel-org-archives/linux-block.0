Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA683BC685;
	Thu,  9 Jul 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591970; cv=none; b=MDHM+IOvgSel3Aa66NEu93VCDdQTlaKklxQyg2zMYeNeMTYdu1CXXVIsbewX/7pMkU3Ay/Hf3G5prTklGYcf64XOsnakLgm5agmvUKfcSICoymXideR+32mHjrMMPi13i/dhFNsHDyFZ1IQDPPhkRq03q4Vp91vpfqxJGf6cEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591970; c=relaxed/simple;
	bh=dZIf1D2j6QCm7fdNmbsX+UQCnShqpos4lrl4Yu8YCBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjmVBjDb/PGb6kEwNVMtwjgY6YZaFXZ5CV/8Ufi4TOfq+PWwQLMgRTCQlmoBEtB9JR5yZmR9QBP2gu+TNvFTonmjDArtZYN85O4a6C5yuSJpHrDE1a/EXDpZ+B8jEglHn8FfQ/Di1NgFlbZkYOfyFRBQ2n7NJlkVVfU+GXTa8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gwrP204DXzKHMcB;
	Thu,  9 Jul 2026 18:12:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6CAD14056D;
	Thu,  9 Jul 2026 18:12:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHV3MadE9qn4RpAg--.38318S11;
	Thu, 09 Jul 2026 18:12:44 +0800 (CST)
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
Subject: [PATCH V4 7/9] null_blk: reject per-device queue resize for shared tag set
Date: Thu,  9 Jul 2026 18:04:49 +0800
Message-ID: <20260709100452.3520482-8-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHV3MadE9qn4RpAg--.38318S11
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1xtF1xCryfAFW5AFyDAwb_yoW5tF4fpF
	W5GayUKr1kGa18X3yjgwsrKF43AF1kZFWfJryfJFy5u3W2vr95Z34kAa1UWay8J3ykC3yS
	q3ZrZw4kKFyUJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
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
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 drivers/block/null_blk/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 6d30591abb28..340ecc0a331e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -380,10 +380,19 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 	int ret, nr_hw_queues;
 
 	if (!dev->nullb)
 		return 0;
 
+	/*
+	 * A shared tag_set is mapped via the module-wide queue counts, so a
+	 * per-device resize is meaningless. On shrink it would also leave
+	 * mq_map[] pointing at NULLed hctx slots, causing a NULL deref in
+	 * blk_mq_map_swqueue(). Reject it.
+	 */
+	if (dev->nullb->tag_set == &tag_set)
+		return -EINVAL;
+
 	/*
 	 * Make sure at least one submit queue exists.
 	 */
 	if (!submit_queues)
 		return -EINVAL;
-- 
2.52.0


Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0B3E1CF4
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913699; cv=none; b=fgv1C2ahwngLP8kO9qL4as4gOQsi2VQDbB0vLdU2CbSD9FsLfjJoM4YmaoE12OdEk7FgMeCfOarotwhdALFHTDq1EIT4EbGaqlrFMd3tFGmuMQjPQ5WI0BSqho162O713EDySO+yFt+v5VgYooWFVY4giM4BirrXc02jCSk48Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913699; c=relaxed/simple;
	bh=AArPs64idnEo+b/1kOnyUN3mKnlAIzi1h+sQ64vk7ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naqzsfE7/OojKCM+9H9wQwPmRdazBmKv4oLbmXH8KzuJRbo875tpDaYYuByaZ/HZ6RSi/nCHborFpfyFz+2abYrT/ae6a6tC+dX54U/E3Jr/G5iL1ViSdDyxaM/dARwr+eoBHZnQd1sx+gnwABXTGmFQAWcJzt+axWLOAEU0zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hFM1x3t0hzKHNWh
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 15:08:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6908040572
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 15:08:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgBXR0ZW4XJqGly6BA--.6211S9;
	Wed, 05 Aug 2026 15:08:11 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk,
	hch@lst.de,
	yukuai@kernel.org
Cc: yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	echo.chenlin@huawei.com,
	leo.lilong@huaweicloud.com,
	wangkefeng.wang@huawei.com,
	huawei.libin@huawei.com,
	leijitang@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v7 5/8] nbd: skip queue freeze when setting size at device startup
Date: Wed,  5 Aug 2026 14:58:40 +0800
Message-ID: <20260805065843.3332859-6-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260805065843.3332859-1-yangerkun@huawei.com>
References: <20260805065843.3332859-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXR0ZW4XJqGly6BA--.6211S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4UuF1fZw1ktry8CF1fCrg_yoW8Xr47pr
	Wq9ayDK3y0gF43ZF97Xr47Za4rJayDCry2gF17J3sI9FZxAF1IgrZxZFyfWFZ7Xr97Jw4a
	kF4DKaykA3W8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFPETDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Commit 242a49e5c878 ("nbd: freeze the queue for queue limits updates")
added the freeze to keep in-flight commands from seeing
torn queue_limits.  But at startup the capacity is still 0
(invalidate_disk cleared it) and the write cache is off (the previous
patch cleared it on disconnect, and nbd_set_size sets it back only after
the commit), so submit_bio_noacct() rejects any bio before it reaches
the driver and no I/O is in flight.  Drop the freeze by checking
capacity and write cache state in nbd_set_size.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index cb7c1f8502f4..cb662ae4b91d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -375,7 +375,11 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
 	nbd_apply_limits(&lim, nbd->config->flags);
 	lim.logical_block_size = blksize;
 	lim.physical_block_size = blksize;
-	error = queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
+	/* No need freeze with 0 capacity and write cache disabled */
+	if (!get_capacity(nbd->disk) && !blk_queue_write_cache(nbd->disk->queue))
+		error = queue_limits_commit_update(nbd->disk->queue, &lim);
+	else
+		error = queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
 	if (error)
 		return error;
 
-- 
2.52.0


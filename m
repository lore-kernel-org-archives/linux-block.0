Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D13BAD9A
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400200; cv=none; b=UXS8O8+1Jg1+yXBMchPIkCnrn3f6Q8XkPNzBYoqdZa6zdjtOlkzrxZcwiCoygw1u2+QWqERpP761wQAthzqy6S7WwZKb7wHwi9NyR1qaye47kneZLICkvaAdkP3nugV37XWnqME4M3ZONNbA2ek5l8QT/FTcWK5EGpHRVEvnHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400200; c=relaxed/simple;
	bh=RVOqXHXRd/0r0tbX1V9Rzj//6557VlhHTtHybOkUtdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpBZ1/J68twFfXCN/DSwiIGXCliIds7oAL4eYYXc8jD0MAx4YdOARgm3KD0cbSIGTtbzcfOjG9uj0qhejVheWidbFkMjyGweJ463B/y6NYD2aiE5w1AwyYfy/T5i3RL6jrKHD3nPP+cRVTVtunhKhOKGEJotGkSKS1mfXoL6AMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h9j6J2mDpzYQv4h
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:29:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CED6B40539
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:29:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgCnlkV9C2tqwObjAQ--.20420S9;
	Thu, 30 Jul 2026 16:29:54 +0800 (CST)
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
Subject: [PATCH v5 5/8] nbd: skip queue freeze when setting size at device startup
Date: Thu, 30 Jul 2026 16:20:43 +0800
Message-ID: <20260730082046.3459239-6-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260730082046.3459239-1-yangerkun@huawei.com>
References: <20260730082046.3459239-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnlkV9C2tqwObjAQ--.20420S9
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1fZFWfZr1kAw4rJF4DCFg_yoW5tFWfpF
	W2va98GrW8KF4xur4DZFs5Wa15t3ZrC3sFg347G34F9F1qkrZ2yry0kryaqa4UXrykWFsx
	G398KF4Iyw1UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4U
	JVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1-zstUUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Commit 242a49e5c878 ("nbd: freeze the queue for queue limits updates")
added the freeze to keep in-flight commands from seeing torn
queue_limits.  But at startup the capacity is still 0
(invalidate_disk cleared it) and the write cache is off (the previous
patch cleared it on disconnect, and nbd_set_size sets it back only after
the commit), so submit_bio_noacct() rejects any bio before it reaches
the driver and no I/O is in flight.  Drop the freeze there.

Split nbd_set_size() with a bool: nbd_start_device() passes false, the
runtime resize/reconfigure paths (ioctls and nbd_genl_size_set) keep
passing true.  nbd->pid is still 0 when nbd_genl_connect calls
nbd_genl_size_set, so the early return in nbd_set_size keeps that path
from applying limits before startup; the true covers the reconnect path
on a live device.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ce25c254e5fb..3b7363b11d0b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -331,7 +331,8 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 	nsock->sent = 0;
 }
 
-static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
+static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize,
+			bool freeze)
 {
 	struct queue_limits lim;
 	int error;
@@ -371,7 +372,13 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
 
 	lim.logical_block_size = blksize;
 	lim.physical_block_size = blksize;
-	error = queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
+
+	if (freeze)
+		error = queue_limits_commit_update_frozen(nbd->disk->queue,
+				&lim);
+	else
+		error = queue_limits_commit_update(nbd->disk->queue, &lim);
+
 	if (error)
 		return error;
 
@@ -1568,7 +1575,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
 	}
-	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
+	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config), false);
 }
 
 static int nbd_start_device_ioctl(struct nbd_device *nbd)
@@ -1636,13 +1643,13 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_SET_SOCK:
 		return nbd_add_socket(nbd, arg, false);
 	case NBD_SET_BLKSIZE:
-		return nbd_set_size(nbd, config->bytesize, arg);
+		return nbd_set_size(nbd, config->bytesize, arg, true);
 	case NBD_SET_SIZE:
-		return nbd_set_size(nbd, arg, nbd_blksize(config));
+		return nbd_set_size(nbd, arg, nbd_blksize(config), true);
 	case NBD_SET_SIZE_BLOCKS:
 		if (check_shl_overflow(arg, config->blksize_bits, &bytesize))
 			return -EINVAL;
-		return nbd_set_size(nbd, bytesize, nbd_blksize(config));
+		return nbd_set_size(nbd, bytesize, nbd_blksize(config), true);
 	case NBD_SET_TIMEOUT:
 		nbd_set_cmd_timeout(nbd, arg);
 		return 0;
@@ -2097,7 +2104,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
 
 	if (bytes != config->bytesize || bsize != nbd_blksize(config))
-		return nbd_set_size(nbd, bytes, bsize);
+		return nbd_set_size(nbd, bytes, bsize, true);
 	return 0;
 }
 
-- 
2.52.0


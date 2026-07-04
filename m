Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF984039;
	Sat,  4 Jul 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783151254; cv=none; b=Fs+AQo17+jOcIPAP2eTxUTWr1q+bpcvv+aD/pLlr8uskCtaCEgpeZZteasJzQ/D3+GQCFKK4Xzp3QQFeCy7at4D8yPQ7p6NPckEZjEINcor2plv74g2t+oOX3UXtZkDfoKD/Z25JLJHVYAyDXVtobM9cchFM1T5ceTM7ZQ8G/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783151254; c=relaxed/simple;
	bh=Wv4iFC8xJcmjtlcFYASLzGktH+aCb0Q4KQR/cqsiMtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aS5L2MMCNAaIzky/pbXo7u6YqhQHT1jJxmDIyvWjJ5gAsd/3GaVpcpKjmdM29Y21CyVFergldRaow+Nusq4QEWcw8Tr9jxrZV61d9vao0i89RdFPivJtSLYi/EP47YdPT2TNCrxCZjTFjfQItlWETu/MtVVu7QKYHS38xzc7zDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gsjNn42X7zYQthl;
	Sat,  4 Jul 2026 15:46:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CFA2C4058C;
	Sat,  4 Jul 2026 15:47:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHSDukhqyykDAA--.534S4;
	Sat, 04 Jul 2026 15:47:16 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH] block: fix BLKSECDISCARD zero-length range causing page cache invalidation
Date: Sat,  4 Jul 2026 15:39:42 +0800
Message-ID: <20260704073942.3760597-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHSDukhqyykDAA--.534S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw47Zr13CF13GFWrtFW5ZFb_yoW8ZF1Upr
	y7GFy5Gr4DWr9rWF48Jan7uryDK3W8KF4xCw13trn3Z3yqyrnruFyrCrySgFW0qr97JayY
	vF4Yva4xCFy29FDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUI5fHUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Commit 697ba0b6ec4a ("block: fix integer overflow in BLKSECDISCARD") fixed
the start+len overflow via check_add_overflow() but did not handle the
start=0, len=0 case. There, start + len = 0, so end = 0 passes all checks,
and truncate_bdev_range()->truncate_inode_pages_range() is then called with
lend=UINT64_MAX, whitch is the "truncate to the end of file" sentinel, so
the entire page cache is invalidated.

Fix this by replacing the validation with blk_validate_byte_range(), which
already rejects a zero-length range and is what BLKDISCARD uses. This also
switches the alignment check from a hardcoded 512 to
bdev_logical_block_size().

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/ioctl.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 3d4ea1537457..3b7d33a737e8 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -176,8 +176,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 		void __user *argp)
 {
-	uint64_t start, len, end;
-	uint64_t range[2];
+	uint64_t range[2], start, len;
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -189,15 +188,13 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 
 	start = range[0];
 	len = range[1];
-	if ((start & 511) || (len & 511))
-		return -EINVAL;
-	if (check_add_overflow(start, len, &end) ||
-	    end > bdev_nr_bytes(bdev))
-		return -EINVAL;
+	err = blk_validate_byte_range(bdev, start, len);
+	if (err)
+		return err;
 
 	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
-	err = truncate_bdev_range(bdev, mode, start, end - 1);
+	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
-- 
2.52.0


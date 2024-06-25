Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3057F1494A0;
	Tue, 25 Jun 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316597; cv=none; b=VyOxnpSzO5ATu/E99jpI8sFg3q1UvYRpG9GXBYK7kQ4CcPxMu0AsgusYebdqW7Idtan7mEb/Nsb67IM1Gr/8YroRj+hyRF98m2nZ4AHgawIIdNuitnIt1c+sge1CXpeQPn2870WYaibNg6x6nieOzKSNYGk2Oukh+EMe/DzFdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316597; c=relaxed/simple;
	bh=f8WF5zjNVgsVkKEc6ibnTirDFsPTFIcp6L9plG4rb3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cd0u1eBVA55tkwlsCCYQa/JaDG96pias5x9g5wZCOcv7090ijaxb7W4xdgxwTOXMbGk3YXUgZ1h8zev6cXKVr4pzmgP2DL5YldDSAoyxM0JvWo0ILxFNsX/ppvg1cZ/6bDZkkmNpUOuRZMkIS02u9bOntuvfKrNojuEAG9L99zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W7jwS2MSjz4f3jkc;
	Tue, 25 Jun 2024 19:56:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 651EF1A0199;
	Tue, 25 Jun 2024 19:56:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCnD4VtsHpmFiU2AQ--.8225S4;
	Tue, 25 Jun 2024 19:56:31 +0800 (CST)
From: linan666@huaweicloud.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH] block: clean up the check in blkdev_iomap_begin()
Date: Tue, 25 Jun 2024 19:55:17 +0800
Message-Id: <20240625115517.1472120-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnD4VtsHpmFiU2AQ--.8225S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW3Xw45Zr1xXw4fAr1UWrg_yoWDJrg_Z3
	4DZryvgF4rZF4fCFs0q3y3ZrZFkw1kKF4aqr97ur98ZFsrJF1kAFZavF9Iqrs8tF47Gry5
	Gwn8JFySqF4xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjfUYuc_UUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

It is odd to check the offset amidst a series of assignments. Moving this
check to the beginning of the function makes the code look better.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/fops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 376265935714..bc5ad3e6197f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -383,10 +383,11 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	struct block_device *bdev = I_BDEV(inode);
 	loff_t isize = i_size_read(inode);
 
-	iomap->bdev = bdev;
-	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
 	if (offset >= isize)
 		return -EIO;
+
+	iomap->bdev = bdev;
+	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
 	iomap->type = IOMAP_MAPPED;
 	iomap->addr = iomap->offset;
 	iomap->length = isize - iomap->offset;
-- 
2.39.2


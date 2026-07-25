Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D04A23AE62
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939568; cv=none; b=YMXcrPXd2cAYz6d8c1qsEF4268/FbruT+v1UU5m3iQl8aFU/tRnnWwLR0qjQkcPZDnwqNlLyGNoqnsTuPiLQmtjuoqDW4lGYFxi/lgRMBf8l1b/ctbiIjxhD7gqmQcXCwbxkopmiClLHe1reuB52AfNwFrbKIB4psfVlu5hRNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939568; c=relaxed/simple;
	bh=mxGrIo1C5hjEx8HE1OX+a3qQyeIMcQfCv/IA81Tn5Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcN0QtxhzMQ5UchFjdkyfk5f05ng8O79ILf8gEAGzIyWJngRhLeUF22l8BlZdQ6tjKY74l9u4AyHQxdxkl9RBwfCNV9yRRdTyUoDbA0RMvxr+gEqqDQe/8BtSC4Nk6ZCy/FU2v0pW9HhU/z1M8h6IF8ptO9w3iHL3BMqiBfWZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6Qm76sHczYQtxn
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 08:32:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 44C9C40A79
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 08:32:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCXpnInBGRqTv_ICQ--.38434S4;
	Sat, 25 Jul 2026 08:32:41 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	yukuai@fygo.io,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V2] block: fix BLKSECDISCARD zero-length range causing page cache invalidation
Date: Sat, 25 Jul 2026 08:23:55 +0800
Message-ID: <20260725002355.347485-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXpnInBGRqTv_ICQ--.38434S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWrykAw4xAr1xWr4ruF43GFg_yoW5GrWfpr
	y3GFy5Gr4UWr9rWF40k3ZrurWqk3WUKa1xA345trn3ZrWqvrnIgFyfGrySgFWvqr97Jaya
	vF4jva4IkFW7ua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
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

Fixes: 0bd1ed4860d0 ("block: pass inclusive 'lend' parameter to truncate_inode_pages_range")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai@fygo.io>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
v2:
Add the fixtag.

v1: https://lore.kernel.org/all/20260704073942.3760597-1-wozizhi@huaweicloud.com/
---
 block/ioctl.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 3d4ea1537457..3b7d33a737e8 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -174,12 +174,11 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 }
 
 static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 		void __user *argp)
 {
-	uint64_t start, len, end;
-	uint64_t range[2];
+	uint64_t range[2], start, len;
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
 		return -EBADF;
 	if (!bdev_max_secure_erase_sectors(bdev))
@@ -187,19 +186,17 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	if (copy_from_user(range, argp, sizeof(range)))
 		return -EFAULT;
 
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
 	filemap_invalidate_unlock(bdev->bd_mapping);
 	inode_unlock(bdev->bd_mapping->host);
-- 
2.52.0


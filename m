Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D2223DC6
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037805; cv=none; b=ueaZr6rvR7CNdp8A9JQXUqSw72eQh2dtX74hrtZ9jeLUWk1l+oGQrUr0RaA7XRtV00YHrj+RlT3+Go9fTB40s2R/mHJZLiXGSl72C0pcLg5w4LsmwGGhHAm2Qh3fMime9cd+znybfrLAIDoGV5dsMu5DyecvDHEMd/gu9ira/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037805; c=relaxed/simple;
	bh=XDvjyy/zqTMWciW0CF3bkDmXbPsPWIbt3u8fmTE4S5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7C1bUyPxwp6GxiE0irKLjYMOCcoLfXMoAoA8q1gHVRDo7sSGtfZ8xPZOgIGgH04eIIG+0IDRyzNj8n0R1YAphBLxtiQfjPnuGTMEOfv3FICZCrOogPmy5Gqei0lRDDrvOWmlM8et4a42XkA0mVwbuqavMiiddEG46qBZxCZVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JjXWk4ze; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JjXWk4ze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jd
	fixqxOTyOD7lBk1IPpyn50zgK6ZTDsbe0j1dqBlvI=; b=JjXWk4ze4bD567JT0d
	WeCLCCTJqab/pmapWCOV2D0mPVP/M5OHmuX19FpOCcj8XNeUop6ls82BxOuFXHvf
	2t0hzx/CyaAQ6gwYiXsUDd/VIpstZx5wWW7/WzMW0beIkL4rOkvzP7vC2O28cUov
	P6o31GAkfZHZat1Q8C/boTfgo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3l1OVOBlqiin2AA--.36997S2;
	Fri, 29 May 2026 14:56:23 +0800 (CST)
From: dayou5941@163.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	liyouhong@kylinos.cn
Subject: [PATCH] block: use blk_validate_byte_range() for BLKZEROOUT and BLKSECDISCARD
Date: Fri, 29 May 2026 14:56:18 +0800
Message-Id: <20260529065618.3091286-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3l1OVOBlqiin2AA--.36997S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFW8Ww13AFy8CrWktF15CFg_yoW5XrWfpr
	W7WFy5trW5WFZ7XF48uanrAryqgw17KFWxC343twn3A3yIyr9FgFy8CrWI934IqFyrJay5
	JF4YvayIkFy7uFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8Cz_UUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+RcUwmoZOJdmlQAA3X

From: liyouhong <liyouhong@kylinos.cn>

blk_validate_byte_range() was extracted from BLKDISCARD in 2024 but
BLKZEROOUT and BLKSECDISCARD still used legacy 512-byte alignment
checks.  On 4K logical block devices this allows misaligned requests
to pass ioctl validation, invalidate the page cache, and then fail in
blkdev_issue_zeroout() or blkdev_issue_secure_erase().

Use blk_validate_byte_range() for both ioctls so range validation
matches BLKDISCARD, fallocate, and the blk-lib helpers.

Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
 block/ioctl.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index ab2c9ed79946..e2bec9acc3b7 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -176,7 +176,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 		void __user *argp)
 {
-	uint64_t start, len, end;
+	uint64_t start, len;
 	uint64_t range[2];
 	int err;
 
@@ -189,15 +189,13 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 
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
@@ -211,7 +209,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
 	uint64_t range[2];
-	uint64_t start, end, len;
+	uint64_t start, len;
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -222,21 +220,14 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 
 	start = range[0];
 	len = range[1];
-	end = start + len - 1;
-
-	if (start & 511)
-		return -EINVAL;
-	if (len & 511)
-		return -EINVAL;
-	if (end >= (uint64_t)bdev_nr_bytes(bdev))
-		return -EINVAL;
-	if (end < start)
-		return -EINVAL;
+	err = blk_validate_byte_range(bdev, start, len);
+	if (err)
+		return err;
 
 	/* Invalidate the page cache, including dirty pages */
 	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
-	err = truncate_bdev_range(bdev, mode, start, end);
+	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
 		goto fail;
 
-- 
2.25.1


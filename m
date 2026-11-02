Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607148;
	b=ptubI4QMsl+AGIMwGEQU6SWO/mkWfLwUwUn459PbsMnVdNMH7OLKAZpBQLR4RJuuXRFR
	 rP9a551kqDBplX8Zaqb1Geil9nXnRlZZN1IJez2nvF9iSt9ysYODbdCSp6z+8c5x2zjS6
	 zg3M3k8uyRTbelslCt3M2uytnQOP/nFGXq0hOI0YtPCnwPn1JM61btTYQv06rAYRadgY7
	 HPQEtpNcln6KMxYQYqDTq2foX8o1qBUBqula/4D+vB1dG5GO1ygQyWv9Ml56Hil8H26Ir
	 1+LSx+xQTGITNwLZapwFqs2FTf53y+wB7iARLWpDW2awwBZYfzI7bQzsR2vc7Bd0Jpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607148;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=IMhoSo95gjCjerFnh8p/muOlEhctt3FoP0/R1vEJRHo=;
	b=taw5Ll7BCdV0y4jsg8PH1+HG82HVzhRKWnBchmZYDJlv2gmnXHHrlupS2N4HE3AojTsM
	 NYflcxanKhKkuE6V/On08kqSAgokcKOjVL1k2tqCPvmKXKXlAvSoQTOCWCpeVZzl9dc2Z
	 RQbxKEWQHxUp6SGn6hJRzr6gzZgMHWc9/LuQaY+DZCRlPociAUyJswXslN15Zz5X8rbSv
	 A4otpSABuVFISW4yDmIQORJxqS1BkMIH63r27APUj1+oxppodLbaLqk+EpzFyvqWBTFcM
	 OXQ9xKiss08GJcuAvThd3O14gF4sVrgOm5WjX14sMaEXhMb4090WeEE/x9axZwGa2hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F702606A327;
	Mon,  2 Nov 2026 08:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F702606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jJ4DZ22Zvz1c0TF;
	Mon,  2 Nov 2026 16:11:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EB97C40574;
	Mon,  2 Nov 2026 16:12:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgAXTu3kRehqCK4cCw--.15917S4;
	Mon, 02 Nov 2026 16:12:21 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	yukuai@fygo.io,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH RESEND V2] block: fix BLKSECDISCARD zero-length range causing page cache invalidation
Date: Mon,  2 Nov 2026 16:04:20 +0800
Message-ID: <20261102080420.3774409-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTu3kRehqCK4cCw--.15917S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWUCry3AF4xXr17Xw4xZwb_yoW5GrWfpr
	y3KFy5Jr4UWr9rWF40k3ZruFWUK3W7Ka1xA345twn3ZrWqvrnFgFyfCrySgFWvqr97Jaya
	vF4Yva4xKFy7ua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
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

v1:
https://lore.kernel.org/all/20260704073942.3760597-1-wozizhi@huaweicloud.com/
---
 block/ioctl.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 64b4e6c0f696..53558963d9d7 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -175,12 +175,11 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
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
@@ -188,19 +187,17 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
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


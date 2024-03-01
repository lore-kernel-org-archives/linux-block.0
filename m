Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FAA2B9B9
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256256; cv=none; b=Lp5J24ucrIT6YqhkC4rB5t4FiolEpJQAHSrzX1FkmjVpwBeDSyy7z2heFE8r9YUhkJj2eGTGRCg+j09biCNo3djsm1T5V7LTLfY6gFf8TQl1pBR3jIu5hJp/ZxB7ROl2nSpOECIw54tONwyRkCOyFKJ96LPVULQ60Pad4FtPgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256256; c=relaxed/simple;
	bh=QWpCBUxGIwvUgnTYWNJI8geGzf6bM31MwNgicX8H3Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiXaYDrsvkMOqPYI25B8nRbodBLoRk5/PIbi4qY5NKhzfIY0YaGOTo51EOkINeSANnrHniEsShc61TYUFXEq9ucI5wRHVoo0e+6eWz8TH2rBnPlnsv6xGglkkgZ7hlii0ddUZrbbH0nDhXwE60GM/JyGNDCO62fwbK9AwhCQv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Pfc7fD4K; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Pfc7fD4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=ybwauVZPrNHMvNzZYCxzA4shFMPOKAQSqwZ1heSYrjU=;
	b=Pfc7fD4KgqrASGiCQG492KHzjJri8nhIGxv369vCueZfe9Ny0BtIlvBCEthjwv
	FGFRhmTchMkEhmr1HAs9jED+NjRnHFDWB7boBaFSS4DwzyZIm/Ap8ostAN6xLTWQ
	ZZ3PFeDdf0r50wwtf1jKXnAbA86hB1CdES/1Tv5IKQnkg=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDHr7+NLeFlC0ffBA--.60409S10;
	Fri, 01 Mar 2024 09:22:11 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: 1192843200@qq.com
Cc: =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= <holger.hoffstaette@googlemail.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	holger@applied-asynchrony.com,
	Gwendal Grignou <gwendal@chromium.org>,
	Benjamin Gordon <bmgordon@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH 4.19.y 6/9] loop: properly observe rotational flag of underlying device
Date: Fri,  1 Mar 2024 09:19:41 +0800
Message-Id: <20240301011944.2197153-7-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301011944.2197153-1-zhanggenjian@126.com>
References: <20240301011944.2197153-1-zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHr7+NLeFlC0ffBA--.60409S10
X-Coremail-Antispam: 1Uf129KBjvJXoWxCryUKFy8Xr4UWr4rZr4fKrg_yoW5XryDpF
	W3JFy0kay8KFWxWF4Iqa17ZFyak3Wvk343W3srCwn09w13Jr9aqa4fJFyUXFW8trZ5GF4Y
	qFWYgFyvkr4UCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07briihUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiyAeUfmWWf0l6XwAAsF

From: Holger Hoffstätte <holger.hoffstaette@googlemail.com>

[ Upstream commit 56a85fd8376ef32458efb6ea97a820754e12f6bb ]

The loop driver always declares the rotational flag of its device as
rotational, even when the device of the mapped file is nonrotational,
as is the case with SSDs or on tmpfs. This can confuse filesystem tools
which are SSD-aware; in my case I frequently forget to tell mkfs.btrfs
that my loop device on tmpfs is nonrotational, and that I really don't
need any automatic metadata redundancy.

The attached patch fixes this by introspecting the rotational flag of the
mapped file's underlying block device, if it exists. If the mapped file's
filesystem has no associated block device - as is the case on e.g. tmpfs -
we assume nonrotational storage. If there is a better way to identify such
non-devices I'd love to hear them.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: holger@applied-asynchrony.com
Signed-off-by: Holger Hoffstätte <holger.hoffstaette@googlemail.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Benjamin Gordon <bmgordon@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1a6805642ed2..7a0461a6160b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -940,6 +940,24 @@ static int loop_prepare_queue(struct loop_device *lo)
 	return 0;
 }
 
+static void loop_update_rotational(struct loop_device *lo)
+{
+	struct file *file = lo->lo_backing_file;
+	struct inode *file_inode = file->f_mapping->host;
+	struct block_device *file_bdev = file_inode->i_sb->s_bdev;
+	struct request_queue *q = lo->lo_queue;
+	bool nonrot = true;
+
+	/* not all filesystems (e.g. tmpfs) have a sb->s_bdev */
+	if (file_bdev)
+		nonrot = blk_queue_nonrot(bdev_get_queue(file_bdev));
+
+	if (nonrot)
+		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+}
+
 static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		       struct block_device *bdev, unsigned int arg)
 {
@@ -1001,6 +1019,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
+	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 	loop_set_size(lo, size);
-- 
2.25.1


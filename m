Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51E345EC0
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786795375; cv=none; b=tcboze5qGt92xBwBHjyHvI3yVYE8Lo4ETdvrsEmYIu6A78W2AXMxORRWGVQBR3wUNKqhCO2Yb7ullkZn4m8Mg8+iYJPqRnac6M+wJAg/QNpANSHSWLmd3n4xsTQ00+06Id1L7fIQNW6KRF4N6E/dM2LLuuWCLcVoo6yz1/VEYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786795375; c=relaxed/simple;
	bh=RfHRwQZLqwJ90kIuGEvF5N/zUeiP30r907Q/K1hMcsw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cwR/VtwG+/3afsDpwZrHp61SYOS/lkLaTqS7R9BBLzKsIvKBXC5KsaxX14QC8vw3zVHA66/tK9yIbirsD8H/qm27PrheEFakYW5J86yYsGEP8GYY4w60NRQDbPqZdSCzZvLyvXB5vKin4dBpzuiS6FwPhtnojJHAHQ94NoT3FM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gjbM5FlD; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gjbM5FlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786795364; bh=PcU6mn/YGpVHiyyMdPHEPe7SkXg2aCZBrwtnhwUUHtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gjbM5FlDbxdalb631agE3aZafKAIiYvszD1yp0mqbKskkqp40W3eClCo9UegR4Ebr
	 gzQ0fZsxhmn9Hx3BqIAWtIJG/9Z6zww43x+oLhxWMf3ZUuq5khQHbD8vo4VsWTNsxW
	 OCVvL3Gb1DpCW3eDtXAYUi4ufG7MrFnKwd0tOrVc=
Received: from localhost.localdomain ([112.10.243.116])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 9190033; Sat, 15 Aug 2026 20:02:17 +0800
X-QQ-mid: xmsmtpt1786795337tg26gy0rk
Message-ID: <tencent_A41247F29AC0971AE96B52964BE4491B440A@qq.com>
X-QQ-XMAILINFO: NgI0eZuFF6LS8+WCbqeBXDDKQKyH/hOkgeNfkFRxfUfdFD0qW6CpY97gvFN2oZ
	 hvyVXBcjTrhzuMyDhoN8NpudpxcHhJlgjXZKVYSZqDZtSWMJ+2OpVf56Sp5AdxcJQ/ZAxbZqLHff
	 47eZaI41BwdTVzyqruhYMHOEd4daN7FeeexJgcC1y8f98ALxDiSxJiGallZLycAqqgm/T4ZXZCH5
	 q1xvG4fmbvd88wcqjVQuWvobc3nVXlOnD6HXRcQY+UFP2eICCKIHyjzHEcmIg+CrJg2cyzQnvLL4
	 4P1Uj5guNUkhBrjXzFQtunvN3GJp9+AnHiVpauM4Sxy+cQmYLvvvW3wMJ+L+10jEz/+8LXD9/ubF
	 gVsNHgj/qUI6qKwd3O9gumQHLOFoSvZ+Su1SugVZxCkI9WIpNScDLrQpGUuATfsa+OMZR3vCkI6R
	 4WDbwFUWSTt3NgJXEu6y2Y9BcQGfUJbA2BJ3c6T1y3XmKTK5GnCEGw/mxunHXYjt1FEUVnaJu5CX
	 zB1mSd9z85MEQOegwOaT77YKJ8ugzMZOBC/A1vgf8WIlBrzbuiYxfxaPkrRFvQA5fYgeLu9wJ4mW
	 gqZrNaj2Th/XtnfQcdK4iJdxAgcX4umR5/QGd+bbMONR2YSINnNQt31PnBySatMgocdxN8lxs79d
	 RpdXBPUGvGEquBhAivkTgRr1jmaWulCx+JWi0PcBLL74aQXkO8N3tI3XH3oVrGN81cyu3KOow3vs
	 Ph38nkrdJ8MRML3FtBbocPQVeDB3WNtNjAZudleaWvkZ7EaRO2dkXG0XZctCuizkIDxoLuXZIVXu
	 Af7LNSoKNCktEMl7YMlG6p/zuqCYkVc5ZksdL592NoUGJagbiYxFxUB+tKLliyOzZ4nbg2i527l8
	 36n/79TgoWb+epNC6FynlbMYtLfQz8DwsosNPf2B0RNiLJjQMrRWmGJcL+TEVWttaJuWnOO4DFsl
	 EXe6EMrGEceY3WfTDBDdUhMzFuJhpsj3eSYdeERhjoQ9uD+qgtPjeT4syNcX6PC/lB7EoEIYBNz7
	 +33NixrA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Zhenxian Ma <1604099876@qq.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	mzx199711@gmail.com,
	Zhenxian Ma <mazhenxian@xiaohongshu.com>
Subject: [PATCH v2 2/2] block: only use REQ_FUA for direct writes if the device supports it
Date: Sat, 15 Aug 2026 20:02:15 +0800
X-OQ-MSGID: <02f2d527459d00a1576749505d3a0b679318c66d.1786782832.git.mzx199711@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1786782832.git.mzx199711@gmail.com>
References: <20260812130335.60354-1-mzx199711@gmail.com> <cover.1786782832.git.mzx199711@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenxian Ma <mzx199711@gmail.com>

When a block device does not support FUA natively, the block layer
emulates it by adding a cache flush to every write bio.  An O_DSYNC
direct write that spans N bios then costs N flushes, rather than the
single generic_write_sync() issued after the write completes.

Introduce blkdev_dio_fua() to decide when REQ_FUA is set.  A synchronous
write can rely on generic_write_sync() when the device lacks FUA, so it
sets REQ_FUA only when bdev_fua() is true.  An asynchronous write
completes in blkdev_bio_end_io() and cannot call the blocking
generic_write_sync(), so it keeps REQ_FUA (emulated when needed) to stay
durable.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Zhenxian Ma <mzx199711@gmail.com>
Signed-off-by: Zhenxian Ma <mazhenxian@xiaohongshu.com>
---
 block/fops.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index a2c3af38106b..e7d073620271 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -26,12 +26,26 @@ static inline struct inode *bdev_file_inode(struct file *file)
 	return file->f_mapping->host;
 }
 
-static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
+static bool blkdev_dio_fua(struct kiocb *iocb, struct block_device *bdev)
+{
+	if (!iocb_is_dsync(iocb))
+		return false;
+	/*
+	 * Async writes cannot fall back to generic_write_sync(), so they must
+	 * use FUA (emulated if needed); sync writes only need it when the
+	 * device supports FUA natively.
+	 */
+	if (!is_sync_kiocb(iocb))
+		return true;
+	return bdev_fua(bdev);
+}
+
+static blk_opf_t dio_bio_write_op(struct kiocb *iocb, struct block_device *bdev)
 {
 	blk_opf_t opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 
 	/* avoid the need for a I/O completion work item */
-	if (iocb_is_dsync(iocb))
+	if (blkdev_dio_fua(iocb, bdev))
 		opf |= REQ_FUA;
 	return opf;
 }
@@ -75,7 +89,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		if (user_backed_iter(iter))
 			should_dirty = true;
 	} else {
-		bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
+		bio_init(&bio, bdev, vecs, nr_pages,
+			 dio_bio_write_op(iocb, bdev));
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio.bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
@@ -179,7 +194,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
-	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb, bdev);
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
@@ -323,7 +338,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 					unsigned int nr_pages)
 {
 	bool is_read = iov_iter_rw(iter) == READ;
-	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb, bdev);
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	loff_t pos = iocb->ki_pos;
@@ -768,6 +783,13 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 			need_sync = true;
+		} else if (ret > 0 && !blkdev_dio_fua(iocb, bdev)) {
+			/*
+			 * The device does not support FUA, so REQ_FUA was not
+			 * set and the O_DSYNC direct write still needs a flush
+			 * to be made durable.
+			 */
+			need_sync = true;
 		}
 	} else {
 		/*
-- 
2.43.5


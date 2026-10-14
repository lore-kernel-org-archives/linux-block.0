Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06064F93A1
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975760; cv=none; b=qqhAjMN2FurM+f+upaIPI1aCdDYfnK11WbQepjG92A6T8LMCzKp9PkakmW9tfc5iCby3IAMfHRZrwrcVfpm0/2Yy0o20e8KmweIyR9C65q3nzp4LhahEFEN4UO202GjhIe5mcQOw+hFE8PlcTb3OzSPaJc2NOvCrZRhFsQJqJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975760; c=relaxed/simple;
	bh=poMU3IMk+s1i+OL6PspfjWv+5wjZjdnLVtCEDY3Hn+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUtUqnIqpR+ASulOHgtUOwwQkPJdqxO45MYMxKJRk942337d9xYj2mFKFxpVi6NJ7dUsNQL/vy1rxF5R4shDs9u/aXaxbmXg4Sgyd/BTgD7/1RBHSd4WQKZSZvVpV7J8rwhVP2BhgtPK1qFZPh2jTXiKeSd6EZfAhTqcwNeeKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgNO+bZQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgNO+bZQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso7255155e9.3
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975748; x=1792580548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
        b=lgNO+bZQ/hnx2yCAL1IbW7Iij3HMfcE7QFPPFXXIrHszCMDgkl/yukvU2NsT0LuA8k
         XTYrAF3J7+KZ0mLr0dyTtvudv3W8K26zyQSPyCr+Gl0xk+zlTDr5MBDbiaFF48RmlAZz
         G6liAnDuYEL/AowlsBFYqbYiVjwVhPygUXqs/cVM22qW03HxCWxgizK6LJsvuuhl6iAh
         wfuzAaoNxC1STbH744wcuWm88gHQl91TjBIK3JCJQipocLiR/mh+CuAg8aw3+QxLDujS
         3Pkne/qKlxAPAsIfCOlBTxlVI9+VKvE9PhcJ4PziH9BhgLsbVjblTnzNLLkEySovYlse
         KAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975748; x=1792580548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
        b=M97lzSBGn40JYVFk9wA+KgnoM7V4x0A6+DB2VgvYKJYHuz6GjiZ8a4TbcYN72/bt4c
         JUIz9syame/eEV8WVbdShvF/a50Wl5w9gwNKOoNGvOg23UzyKW4mPX2FbbAxPoEyu8lh
         p+XQis52+b3rWD5SqpItnsIAIrcHgrS5HQ7itwJnxJeizex0eqlAtEuFbVM8VxtcQWJa
         E+6HbbB5iMwMfVwCXQSBh3bTqcEW8HQBK2GkA/y+2ZbiOWZ3+VRTDwqodkyCK564dxuf
         bMZjmiASL8PBU7zB26DYoBOSKxhQQhZrnPjf/ORvN2Jvs98hrrQFrHn0AmEtpmiEeEiz
         m45A==
X-Gm-Message-State: AFq9FYKU5i1qMtUnbd6wcm9o9/wOUVn5riCIFLg9smr8Sx0XMmJYsCBV
	XMqjJd6+fBZPz1l7dcnPbBMNwuqv65v4ySMsj4BCJGBdLALNAMDNgFRF/8jMSQ==
X-Gm-Gg: AYBFou0g6r0JbE77Rznqrrh/chvB05vsM6vFWFMirZ5b4t4TbOq/inlEFChj5sL5SF1
	g/jZynR2jqv1VoRaIQ1+qaSRwFqaYdMn5WXCHZaTF8ezLR26/Tj2fqaNfk5xjWtJqeR7LtqSHw4
	e4M8ANFUmMcLCDAWjxDWcj2h4M8yLtcmGaf5jwJSFcYTd3NzhNcCtsl2+2c8ZXR8Upj0UX1whdh
	AhLpExPVAya75wL96NoDw+L/iG8xFwLBZXrqwkLnqycZIFnYYRG2RbekdyMPxMaHu7j2GCwrFiQ
	1ZE0ReURZzj8DHnOJ3lqBbQA5tvvXDqmr49u3OwCo4LW9E34BFEIHI8RfXKw6Br53LTAV43TtE3
	tAm+0SGPWZoTHSg23Vpony2PwNdaO4MPj4ROs57ZXKV7oTxpig3SZPHrdsXOnMySrdqaqi4X/nJ
	bVvLHwrr10IBqDvMm7+D7WjGBX9cABMvukrkzuY4BCL62CN6l5ekezKr6RnafQqL6s4bwCGdujH
	UQ3b5ugjxPBqtiprVxknPW7oqkkm+/DZmdRbA3XFooLpJ4xL83Ob9EPmFnm8S2aG8dQYXggkXOe
X-Received: by 2002:a05:600c:8716:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a18e44885dmr316691205e9.2.1791975747413;
        Wed, 14 Oct 2026 04:02:27 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:26 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v11 05/13] block: add dma-buf support for raw bdev
Date: Wed, 14 Oct 2026 12:02:03 +0100
Message-ID: <c01c4709dc55a12fb0f2fe1ec847b5f1f0c92789.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation. Also reject
dma-buf backed iterators for buffered IO.

Reviewed-by: Christoph Hellwig <hch@lst.de>
[pavel: reject dma-buf without O_DIRECT]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 827dc9eecba7..6c6700df943c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -730,6 +730,9 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	if (unlikely(iov_iter_is_dmabuf_map(from)))
+		return -EOPNOTSUPP;
+
 	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
 			NULL);
 }
@@ -855,6 +858,11 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to))) {
+		if (!ret)
+			ret = -EOPNOTSUPP;
+		goto reexpand;
+	}
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -958,6 +966,21 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
+static int blkdev_init_dma_buf_io_ctx(struct file *file,
+				      struct dma_buf_io_ctx *ctx)
+{
+	struct block_device *bdev = file_bdev(file);
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (!(file->f_flags & O_DIRECT))
+		return -EINVAL;
+	if (!disk->fops->init_dma_buf_io_ctx)
+		return -EOPNOTSUPP;
+	if (bdev_has_integrity_csum(bdev))
+		return -EOPNOTSUPP;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -976,6 +999,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
+	.init_dma_buf_io_ctx = blkdev_init_dma_buf_io_ctx,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d003a9d2d1f6..2d5c30823aab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1599,6 +1599,8 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	int (*init_dma_buf_io_ctx)(struct block_device *,
+				   struct dma_buf_io_ctx *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.54.0


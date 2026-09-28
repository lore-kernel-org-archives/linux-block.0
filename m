Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CE4CC610
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602378; cv=none; b=FcSY09yA6SCGyxwusoeAILGNeUOO7BwjnVG4LpKJjFc01XUxJU7jQhzYXjvLg8KepK+OWQdppx4u/MSWku6GL0+xS7KnwpekNaBvHBzN+jwldDVutpAngQS2SVp86zPhGPcdBXTnchF60Ad6D9zaFv0eK/AHQ3aTcR4WKiF61MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602378; c=relaxed/simple;
	bh=s/pMlWhML39X7WPnWJGpXvJM/zWMeJLTmEHcD+dWxB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNISrphlzi+bQCqTYaoJa49d5pPRxmWZOMwGxLAoh3tGgVTDebQP7B8dc31fl5aJYj1Vjtl9v4XiI3Qlrd9VDiwlNoV9WF3hVupqXELhfH8bJJJG15K1d/Kc45SQyuxyxs5BtXiCjPj46+XItb477RXx175vW5hO8ibEFg8oSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfkaR0Pm; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfkaR0Pm"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso2436925f8f.0
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602372; x=1791207172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNN8LK2yF6e2Er4Otjr5e2ZaUKzvWbebPH7D4oJybmc=;
        b=RfkaR0PmmRqpWxFhMtgRZdKnj7xeumGmGfDTxzfQ6oWWJsLbke7bhO4MBPzg+BSoLo
         4hggbNPW70ddSMca21lxO/l0oyAi2RycEF0NAV5bQm80Z3aBiU7Vb8WA0ccxK5dE8Z6L
         ZXjzu6TBl38tpDGG0EQy5wyV/7F+kmOce+ZVUtW/gl5o+ZsDXVzrTSk2hNKcDR9jDeG+
         HwgOkSN3yzuJ956pHO9pqRl7KZ77zPaGcoNzWgtpX6FZ+oiyCqVBYWn1mmGyUKi4bKr4
         U5O3ppeWrwrCB2Z+3wRCBpCsGZTy4Mk1L1AiK4C8w4XRdpi4avlhnDngcWkm3ypM3gJR
         JFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602372; x=1791207172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNN8LK2yF6e2Er4Otjr5e2ZaUKzvWbebPH7D4oJybmc=;
        b=SZIUBbxzglmT8gIV7Kw8gUyI1Sa0dLkUTouC8UXzd1FtZjkYh4oS8i5bYsCSHTnE1q
         j8a9LWQM2hLJ5Xnjk5/8SudnFsaISwUX0BjPAzxD40GjRfeUEueulOoCVZKXD5rNPG1+
         ppK2nR2SmgkEYJ28JiUnJZ6Z/vYZK4QREIWlC/o44Svd9cLiK44lbwFA6ZHQLmQgE5yb
         K4jvMeEypBNMau3lEvenNr39Xg/rPEiYXPkyMOxglhqtLZtFfeBJyYEC6uFJm9ufAyZc
         32JzF7C+e39kA8TaxFtAaoviNF74rLnrvVmGex4kS+XWJTr0m4Z1zea8apCFiWYnhhQj
         +29A==
X-Gm-Message-State: AFq9FYJBSVBXiawdxZy2+24ECwvwZJHBzloYLuab/voahd+ceYxmikjU
	GC8Jc2tbaZPMuM2RKpomsj3GjCIygpFsyx0R1HTEbcKb9IhLhpKB1ZxqpuocNCDL
X-Gm-Gg: AYBFou1ZBxJjE7dqBD2evV8irDunDWfjQoZqqiUloVq157hcUYYlyVRA5zu9AGXt3m8
	rC6l1swxaYKbI6wK7UEB2vSp/hANQrpCn4MFuzIf9FPYOwksQzpTODGI9ZXXpMgR3822322srfx
	7glIovR6RvW9bReLqIqKQACmw3tneesTT3B7A4BEa9R2Qav+X4RD0BGmNtxgruDlTGWGkGv7fJP
	7SN6NiGzBECp1rxu8cWCWyMspjVwSmM+PM261HojegpmRRFOCEJ30UkSWthpMBWJpI2P770ERwh
	JykpzlVGcqO+7c96EzCStXZjw3uLWzpKgV1mTSSkW33782dnETRr95KE8eojTQHxi1gxNErObG0
	m76YgzeIiX3cGOSMxghjL2WCi5B+oFE2B7Mvnfhjqrufv4p2ZcMW+JC0FSRbmABWY2ARnsh8Jpr
	SJYYRv/PRUoQDv+JqPNVxDE6Pp6gsVM6raL5pPQj4AJZCOEDP5sM/4fqEBHa6dQDjtGHsNM3vDc
	MI5gOYup/iYNXOR9N7nwFJya697uQwtH4fVy6S+IGbPcdQV7k3o8fEunnD6iUvyZIzNsKzSpaNx
X-Received: by 2002:a05:6000:4911:b0:486:f99f:8236 with SMTP id ffacd0b85a97d-48872ac74e0mr24072487f8f.44.1790602371877;
        Mon, 28 Sep 2026 06:32:51 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:50 -0700 (PDT)
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
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v7 05/13] block: add dma-buf support for raw bdev
Date: Mon, 28 Sep 2026 14:32:21 +0100
Message-ID: <a6b81e65b1f09b6ed1f71f294e5a94896ea1ead7.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
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
 block/fops.c           | 25 ++++++++++++++++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 641621db700f..d05a78d0919a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -783,7 +783,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from)) {
+		if (ret >= 0 && iov_iter_count(from) &&
+		    !iov_iter_is_dmabuf_map(from)) {
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 			need_sync = true;
@@ -796,6 +797,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			need_sync = true;
 		}
 	} else {
+		if (unlikely(iov_iter_is_dmabuf_map(from)))
+			return -EOPNOTSUPP;
+
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
 		 * set_blocksize changing i_blkbits/folio order and punching
@@ -851,6 +855,11 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -954,6 +963,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -972,6 +994,7 @@ const struct file_operations def_blk_fops = {
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


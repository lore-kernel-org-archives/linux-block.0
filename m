Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DE48423D
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146914; cv=none; b=U+Dy+wDcfQ0dm7hZqlxfYlbga6+ERI/rXftWWOGi48ur8fPJDFuy6ZX51ZljBLTWK16L20YZWuvC8TGVPwPh+yFV+TNs7edrp6+BHevzva5ZbcTxmJIFEq1HIEi+tz017xEOvth0nqaAySbtpYaC7JEX6mHrgk627YDHPR/hPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146914; c=relaxed/simple;
	bh=u2qQQenzoB1TJlQZF26AH9M2PqhoVAabw/YYenRQgXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njBHgZeyxg6x8pSM9Yq6kdeR6fP9Tq+lFN/FC+5IRttS1hZq9v0NjhCMeW5+/Btr1tJtdDu6D/VDJBV2raXCV9yVJIhs0r3hQblehOLgIwsf7ClWeZozkCxeQ3GZ21wjizEis0piVx/2R1L+6zQGLe19KqcbNNseGcLNjpx0LRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjU8aqCD; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjU8aqCD"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4799250eec.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792146905; x=1792751705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HtjzVVsA6JArz1B6fu2Ta+i9SWusgx63z4Tf4QofPAI=;
        b=BjU8aqCDbJ1xGzjyxGGDs9wDWDodgs+HpG3uSxdZGRX0VwnskBTphA2wgM+3O40JQX
         xR1qH+DyoxJfVPwqCO4E+81fMhmMRvwuz0fP9PkOr12Tu8alZ+n3WFQ6ouOJ9r4Wqy6g
         1E2iC4R3f1VkzjDSIC9hbfmFRp8U7jDN+LynQhdLOlVOYTSqaW1sWeGnbvDGV0f7pLX/
         mvSaud7F7mJK2h/817Kf3fx24Ja9xGrR7oWF9OhMW8Czial3EFGDdeefDqVXHGn8GtAw
         /VAqdGs8ZekK7IZ8k11K9u6RZAenTsxVdZ2QZCErTR7q1VqfilonulAekJLhkCv9rzcW
         DsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792146905; x=1792751705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HtjzVVsA6JArz1B6fu2Ta+i9SWusgx63z4Tf4QofPAI=;
        b=sF4039fSSFv+R27hPSLX8Lap4bsA3I4FvkJ/sN0JkwmGmUQ8fXhIEJqFZ656TtW/yx
         7Fw1mfAZ9UrqlKKpmLnbDJR9FcaNI1Acj7cBcr/xyPLrCSSRdvfFfm2yFXp1Zx2fJdCy
         2gwu+8wU0xUixTMm3sJQAa01G3K8wGHFfXzc6VlpJUsw+jpk8sjA7Z42tF5yLvoICN3J
         iOxKIcLKDiKzEu6EeiZ1p1A19gWo39q06Y3udYyhP5qWpjQBW6cDJq21y0tCA7o2BvF/
         DW/nQdPPAlcZfcJD7SPEVXQFmZs5QaoW2sTQTLw2D5GdlMjNmD0rdMdnEq6E3avAnxYw
         K6hw==
X-Forwarded-Encrypted: i=1; AKwUvBweoxV0Wsysy6A+aA3nKY34m6MPstA6v+yw4AH0Jt7pIvOVnbXDvdCvKtxlVxgjq/I4NdWLtQ+w2OytSg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLIlxt7GlYCglAEpdXbxdOcG5gfu9daWCeLh7xtiFGLOwVreNqd
	jNlebzcpwxcZQFUtlJo5eu/Sr9id4DVK1OK0/I/8z/9v6z7R+fHJUwg=
X-Gm-Gg: AYBFou2AjJhuG3TCASOx7KqLN7ctlaBn+r1DRpK9PDo/P2S4z+bVYar/wWXKBnCqQ9W
	MJPO7WGmHafuYPcJgcrDXIaSUYI5xOszhx59+yj1iUyPVgjl1tfsAY1q5BcGovGXyognNnHVsJU
	5DsRTUJVBZbfDrQvroENkzMVRSWLYzCaAz7Yp77lbPl5ehsxbS7wwg7zFTAk78gwD1kfz5nFQQk
	InhpmNJntg8u3aRzyVOHVmwiYK3VmBRRi3gIPcz2PtwX9cpfVQrremzjDpHbXRF3SN02o1Zg4k5
	Co+OT/Q/ahFb712c+aDeDK4ti78+LqT8xvDndkVf2zDFg/u8qQR2KPHgBI6zE0NbkQrRpjA1Jqt
	301FlSlNIRqNiuEXj2M1Supf3HA2dXIKyJ8i4219R9mlHHGX3wUMJY/WTKz7nretQ2FxUaaSEiW
	E5MKs7DvQVzRBKVQbDsL5A0OKZBBo6+nBQzgKPMdoXcDmeJQFE7j/f4U8DH8O0kqlcYCVnLSuCY
	TbI2ZnKANrUVSXFWF3V5QBlfqCMKzHLjnZxCQ/nUYP8Af3pUuk=
X-Received: by 2002:a05:7300:d209:b0:35a:47ed:c39a with SMTP id 5a478bee46e88-35a47edc590mr19750851eec.37.1792146904412;
        Fri, 16 Oct 2026 03:35:04 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:7bfc:fc3a:e718:89f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm6213192eec.7.2026.10.16.03.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:35:03 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: asml.silence@gmail.com,
	joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH] nvme/io_uring: enable dma-buf backed passthrough I/O
Date: Fri, 16 Oct 2026 16:04:20 +0530
Message-ID: <20261016103453.1129150-1-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anuj Gupta <anuj20.g@samsung.com>

Allow registering a dma-buf against an NVMe namespace character device
and using it as the data buffer of fixed uring_cmd passthrough I/O.

io_uring_cmd_import_fixed() now accepts dma-buf buffers and attaches
the current map. blk_rq_map_user_iov() maps dma-buf iterators directly,
since they cannot fall back to a bounce copy.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-map.c              |  9 ++++++++-
 drivers/nvme/host/core.c     | 13 +++++++++++++
 drivers/nvme/host/ioctl.c    |  1 +
 include/linux/io_uring/cmd.h |  6 ++++++
 io_uring/uring_cmd.c         | 16 +++++++++++++++-
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9cb9605d1f62..8f03e21fd5fe 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -459,7 +459,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 }
 EXPORT_SYMBOL(blk_rq_append_bio);
 
-/* Prepare bio for passthrough IO given ITER_BVEC iter */
+/* Prepare a bio for passthrough I/O from a directly mapped iterator. */
 static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 {
 	unsigned int max_bytes = rq->q->limits.max_hw_sectors << SECTOR_SHIFT;
@@ -506,6 +506,13 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	struct iov_iter i;
 	int ret = -EINVAL;
 
+	if (iov_iter_is_dmabuf_map(iter)) {
+		if (map_data || (iov_iter_alignment(iter) & align))
+			return -EINVAL;
+		ret = blk_rq_map_user_bvec(rq, iter);
+		return ret == -EREMOTEIO ? -EINVAL : ret;
+	}
+
 	if (map_data)
 		copy = true;
 	else if (iov_iter_alignment(iter) & align)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d81462e864a4..29c29dad06b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3982,6 +3982,18 @@ static int nvme_ns_chr_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int nvme_ns_chr_init_dma_buf_io_ctx(struct file *file,
+					   struct dma_buf_io_ctx *ctx)
+{
+	struct nvme_ns *ns = container_of(file_inode(file)->i_cdev,
+					  struct nvme_ns, cdev);
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	if (!ctrl->ops->init_dma_buf_io_ctx)
+		return -EINVAL;
+	return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
+}
+
 static const struct file_operations nvme_ns_chr_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_ns_chr_open,
@@ -3990,6 +4002,7 @@ static const struct file_operations nvme_ns_chr_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_ns_chr_uring_cmd,
 	.uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
+	.init_dma_buf_io_ctx = nvme_ns_chr_init_dma_buf_io_ctx,
 };
 
 static void nvme_add_ns_cdev(struct nvme_ns *ns)
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3aa5d2f2dfbb..6343da1f6c05 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -458,6 +458,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 			status = blk_status_to_errno(err);
 	}
 	io_uring_cmd_set_res32(ioucmd, status, result);
+	io_uring_cmd_detach_dmabuf(ioucmd);
 
 	/*
 	 * For IOPOLL, check if this completion is happening in the context
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index e18d4af62e1a..33e0ebeea5a0 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -70,6 +70,7 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  size_t uvec_segs,
 				  int ddir, struct iov_iter *iter,
 				  unsigned issue_flags);
+void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
@@ -136,6 +137,11 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd)
+{
+}
+
 static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd,
 				       unsigned issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 73b606899833..0e0509edec6f 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -10,6 +10,7 @@
 
 #include "io_uring.h"
 #include "alloc_cache.h"
+#include "dma-buf.h"
 #include "rsrc.h"
 #include "kbuf.h"
 #include "uring_cmd.h"
@@ -28,6 +29,7 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct io_async_cmd *ac = req->async_data;
 
+	io_detach_dmabuf_map(req);
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return;
 
@@ -48,6 +50,12 @@ void io_uring_cmd_cleanup(struct io_kiocb *req)
 	io_req_uring_cleanup(req, 0);
 }
 
+void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd)
+{
+	io_detach_dmabuf_map(cmd_to_io_kiocb(ioucmd));
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_detach_dmabuf);
+
 bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
 				   struct io_uring_task *tctx)
 {
@@ -257,6 +265,7 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 
 	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
 	if (ret == -EAGAIN) {
+		io_detach_dmabuf_map(req);
 		ioucmd->flags |= IORING_URING_CMD_REISSUE;
 		return ret;
 	}
@@ -275,11 +284,16 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      unsigned int issue_flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	int ret;
 
 	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
 		return -EINVAL;
 
-	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
+	ret = __io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags,
+				  IO_REGBUF_IMPORT_ALLOW_DMABUF);
+	if (ret)
+		return ret;
+	return io_attach_dmabuf_map(req, iter, issue_flags);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
-- 
2.43.0


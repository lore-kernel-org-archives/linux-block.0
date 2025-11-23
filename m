Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6829D29F
	for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938327; cv=none; b=gSq2Phs3kB5EaEIA07vldfUXnhmgkPVaeSaLj7xQXs/tcH+a8olqJlR/7hQztAs0NkOQEXrdDW7+tlHObcSjmbU/+qZK+f8UNswL5g0xtV1AQDSt0Z3cpPRlTyr6Scwp0rXZXGcGl3/sDy+85td5jkHYS7I6Bm2JmAHD0NlQEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938327; c=relaxed/simple;
	bh=3Yw5gnORHPUkwdVq0k9YaTZDeI1SsW0ivfxZGTZP3Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0DP+/Zwc7DEsznaBMt6PoQnY+XNHHC6OFX2CPPFcrU8BJeVUPt4dfT9Ju9VgsxRGdykuRvxItNZYvGDpKbOLSyk4hhjTEQaaKhJHjZ+QZHYZLfwfdiqKJJSaWMQLVZYpZ8i075HvcimuS026Ox5hHt4zf5zohdCWeK/CgCAcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7doDkH8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7doDkH8"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3108f41fso2154210f8f.3
        for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 14:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938323; x=1764543123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7U8WjZVUJLujU3iF7ZJF1k1wei+IEPh96Vfasq7vRA=;
        b=g7doDkH8grU2riP18oRUs8e7YFeVqVJgtvrGYpXTDCrFt7l5LfFbbFQV7UU8gCdyGp
         MR6NYn3HA3mxPoK15qLVKYWUrVqa2sfDDOUxXfAGmwHbFMC18bSE8YvzGj5tDWtryPks
         8UjKawvGHRUpM86YqWkTWDXnmohwApBm1LnKVh3jC1QLu2SO9zJQF3JDzKeLlqccltMn
         yxQ8bnOZ3aomzXJKG1yB8F/V0ziKDadgldKdoc8BkUl0YoTBEp6N1E1oUQC4rlfmCYD2
         uEJYUbT5DBWpVja9JCdof68MIXMc9ZEXqxDvtxe2FrU50U4bMf6S5XVfC7o8b74QdMq6
         LbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938323; x=1764543123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7U8WjZVUJLujU3iF7ZJF1k1wei+IEPh96Vfasq7vRA=;
        b=wGWwUro0d5dBuIJjLdAKPfdo8aEmKXEF6+J1h5CGp1xs3yYnHTDy2UX/MymQT10IjM
         sT19DQVcTHsDMQ7OIh5DcLNi+pY/09R6OeRHYx5Eu6iQciLq/Hl/dGopFo3QEyJlwFUc
         VTX95yZM5NHkugzhwKwuVS+l9tZ5M2CPnieGgGNnD79AvWmCWLxFectLiHUFcebkRG8e
         v9XjBjMhBBYbTfgxSbPVDxua5+VW0k9PDb4IwpVK1j9yBSYcReGncawuUHbulw1eRyxd
         J2sEXjR0Q/7c8PXerEDDK9Wu+TWwXF9yNeB7q1hsQOVocndGUd1eYZO9eNj6u0YEaI6g
         GgsQ==
X-Gm-Message-State: AOJu0YyMFoOSGppE7CkWkL92GjK5c4oe0YGCj/22VdorX0KPxIPJtuLM
	zPYXUGyFHvSm8JOu8tUNx5H7g9gYyiAhjP5aIIVuwi2nj7IeLaGEJyZjim8JmA==
X-Gm-Gg: ASbGncsCnDY5PkCnupGjOUSui7I7r8sdWT6hn71INwPXR/fPJNdg1TL/6hYgpbhflpL
	mXgFoEbv6gsjuanGxfrAHL2QiR+gZFBjteR+wdi6hVGMB9nu1yQc/OYXI/wMXSTF00xD3tCmdKo
	ClMWh53U2h8YcgtBGsPm5xZ5EwIJ1AtuxW/yyqOz+dgucgVn3s1DS+lFp+PN7k34J+dSwN5yras
	lBMM+f6felfT7Dzw/aSGrjqLNCxoBhipNbc3Lm8XvjWL6WmAZmbUY9WjrQZk835uZiErMsYZDZo
	qkpz+/Qo1oc3e9rX6cfBVBHqv93dEclvCRvyArV+SDbaRKXFllnQu9ztGPRmIBJC9xqz4vcIYNG
	ahdLwGYWUDjuTjCL+JMBf/BB26wnwzGV32p6QoHUQIkdyGqXjEVYxRgm7sqWhWMIectiOYzc+Md
	25JJZZiuVhNa445A==
X-Google-Smtp-Source: AGHT+IHP6prALX51tQ6Iw6dY96wePGFkgrZhEc+sNQdx04+GPwBJksTSC7+04SaYBCnud+M1CKHhfg==
X-Received: by 2002:a05:6000:430e:b0:42b:2e94:5a94 with SMTP id ffacd0b85a97d-42cc1cf4540mr9370759f8f.29.1763938323162;
        Sun, 23 Nov 2025 14:52:03 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:52:01 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	David Wei <dw@davidwei.uk>
Subject: [RFC v2 10/11] io_uring/rsrc: add dmabuf-backed buffer registeration
Date: Sun, 23 Nov 2025 22:51:30 +0000
Message-ID: <b38f2c3af8c03ee4fc5f67f97b4412ecd8588924.1763725388.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an ability to register a dmabuf backed io_uring buffer. It also
needs know which device to use for attachment, for that it takes
target_fd and extracts the device through the new file op. Unlike normal
buffers, it also retains the target file so that any imports from
ineligible requests can be rejected in next patches.

Suggested-by: Vishal Verma <vishal1.verma@intel.com>
Suggested-by: David Wei <dw@davidwei.uk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++-
 io_uring/rsrc.h |   1 +
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 691f9645d04c..7dfebf459dd0 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -10,6 +10,8 @@
 #include <linux/compat.h>
 #include <linux/io_uring.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/dma-buf.h>
+#include <linux/dma_token.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -802,6 +804,106 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 	return true;
 }
 
+struct io_regbuf_dma {
+	struct dma_token		*token;
+	struct file			*target_file;
+	struct dma_buf			*dmabuf;
+};
+
+static void io_release_reg_dmabuf(void *priv)
+{
+	struct io_regbuf_dma *db = priv;
+
+	dma_token_release(db->token);
+	dma_buf_put(db->dmabuf);
+	fput(db->target_file);
+	kfree(db);
+}
+
+static struct io_rsrc_node *io_register_dmabuf(struct io_ring_ctx *ctx,
+						struct io_uring_reg_buffer *rb,
+						struct iovec *iov)
+{
+	struct dma_token_params params = {};
+	struct io_rsrc_node *node = NULL;
+	struct io_mapped_ubuf *imu = NULL;
+	struct io_regbuf_dma *regbuf = NULL;
+	struct file *target_file = NULL;
+	struct dma_buf *dmabuf = NULL;
+	struct dma_token *token;
+	int ret;
+
+	if (iov->iov_base || iov->iov_len)
+		return ERR_PTR(-EFAULT);
+
+	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
+	if (!node) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	imu = io_alloc_imu(ctx, 0);
+	if (!imu) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	regbuf = kzalloc(sizeof(*regbuf), GFP_KERNEL);
+	if (!regbuf) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	target_file = fget(rb->target_fd);
+	if (!target_file) {
+		ret = -EBADF;
+		goto err;
+	}
+
+	dmabuf = dma_buf_get(rb->dmabuf_fd);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		dmabuf = NULL;
+		goto err;
+	}
+
+	params.dmabuf = dmabuf;
+	params.dir = DMA_BIDIRECTIONAL;
+	token = dma_token_create(target_file, &params);
+	if (IS_ERR(token)) {
+		ret = PTR_ERR(token);
+		goto err;
+	}
+
+	regbuf->target_file = target_file;
+	regbuf->token = token;
+	regbuf->dmabuf = dmabuf;
+
+	imu->nr_bvecs = 1;
+	imu->ubuf = 0;
+	imu->len = dmabuf->size;
+	imu->folio_shift = 0;
+	imu->release = io_release_reg_dmabuf;
+	imu->priv = regbuf;
+	imu->flags = IO_IMU_F_DMA;
+	imu->dir = IO_IMU_DEST | IO_IMU_SOURCE;
+	refcount_set(&imu->refs, 1);
+	node->buf = imu;
+	return node;
+err:
+	if (regbuf)
+		kfree(regbuf);
+	if (imu)
+		io_free_imu(ctx, imu);
+	if (node)
+		io_cache_free(&ctx->node_cache, node);
+	if (target_file)
+		fput(target_file);
+	if (dmabuf)
+		dma_buf_put(dmabuf);
+	return ERR_PTR(ret);
+}
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 						   struct io_uring_reg_buffer *rb,
 						   struct iovec *iov,
@@ -817,7 +919,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	bool coalesced = false;
 
 	if (rb->dmabuf_fd != -1 || rb->target_fd != -1)
-		return NULL;
+		return io_register_dmabuf(ctx, rb, iov);
 
 	if (!iov->iov_base)
 		return NULL;
@@ -1117,6 +1219,8 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 
 	offset = buf_addr - imu->ubuf;
 
+	if (imu->flags & IO_IMU_F_DMA)
+		return -EOPNOTSUPP;
 	if (imu->flags & IO_IMU_F_KBUF)
 		return io_import_kbuf(ddir, iter, imu, len, offset);
 
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 7c1128a856ec..280d3988abf3 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -30,6 +30,7 @@ enum {
 
 enum {
 	IO_IMU_F_KBUF			= 1,
+	IO_IMU_F_DMA			= 2,
 };
 
 struct io_mapped_ubuf {
-- 
2.52.0


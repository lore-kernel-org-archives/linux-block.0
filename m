Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360BA4A5EB4
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997996; cv=none; b=DllZSq+QstEYBYYFyCCqNnOZXIs9Miur6L03qYM2VSmB3TAfwpoWvDgDwazfqA2vqVNHsikcMXIc7n36a4ExfrSOtkcUMkqK0a0aDu8NkskI6msjjGrIRVatvkvRg5KKXyl1Z3wGrxuczb7FAaONiuSFnO/yj1pD8xIhbqC5evs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997996; c=relaxed/simple;
	bh=Z4vOxks9qTIFK+TCf+DcsECaWrDahRJWHvnK/Oy0YsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ou+1wQ6DNvpNzSBoMkDJOWxmYj+BwiBS9K193x7qcFAbKOwzXfUbAgO2OQzrO1Lj1m0BL+Tx5ewVot/bLxNignfRNHIpLgfmqPhStODPDRCxioY7XLQGP6xNEkNkJJTkz8GiVJuFK6Q/mTf4GSpk6lJ6MYmUcwemUzRio9CFLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcYiafm8; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcYiafm8"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso26283465e9.3
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997991; x=1790602791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RT09IM6iAPFk2VI7P8d4NpW1v04uxG67FoGdSGxGhI=;
        b=fcYiafm8WU+PsHRjH0kBI4wrr69zkXEz7/dHrIMdS1Z/IFxyLYqxbvjL/7VyDJi8Ld
         Jpa6Vc6CfYPjuicYz74Ga+Dh7Vw+gpR24aYwywaCtE3A+VObPrOoZ569w6NQghrXi81l
         hCzCS9HVe9HBEa1PYdxPSP2GcnXEYJYpB9W1KeLKNW2IqMxw25mx5mD1Negm+gU82j6P
         Bwr1NPRIt5MNZn/ynUqrtU0IVtWykr8mO1MM++j+r/IQGxxuUGg+vYgADzl6XI4GjeZ2
         bU0fPWvVUZ+5faGWAp2h219j1GTQ518m4kyuyFj3qUdctv2uFuJsniJ676LO29k4Vvr6
         8wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997991; x=1790602791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/RT09IM6iAPFk2VI7P8d4NpW1v04uxG67FoGdSGxGhI=;
        b=wWkSqucHMNDE9957f/uswBlrOKhXL0XMkh8ydndEbaN2daUXzp3xiDwvO7zE1WUGRc
         HgcPKOba4gMdIjTObLrQZUnJvCakZuM6i00ZQsCPfZy1Z8+lSzZ2hVhgSQkqQutywrus
         3ds6/MHZnJ5kgHbV/pg307o0QkjoffQ7NGH0kDhWLwFhZzRBL7Yikat06+Ng0Rs8z+Qz
         EsDRfqKJX81KnyNFq5uCwyWtXslpW5SgEixytjGhYkMdrpPD8wJzYhx7nYhTd+OQsXrC
         6TALqkg+4EzZ2qEcFn2qugmhOniE5nSlM+IJcFFfrufiASReX7APJyP/sC/D+XXmcT3G
         RioA==
X-Gm-Message-State: AFuF++kkqEcdIy7XrR1wb+HeivacGUfdgAo6wMMsYeSyHlZvbAnIpUx6
	1aTu0VaTOhY/d4e6mkVVYmj0botQJCIrTSUxUlQzHE2xD00YqlfdnD0A5/k9nQ==
X-Gm-Gg: AYBFou394nmLI3XdrR9NO9T8rNmjc58edLAmrzTwW1UiuUG4ch2uAal+zLEtq1FyDmS
	Dfz8z/4IR8H0zz0D0XhpLMtq1RY2KQF3ViGo/dplK0FV4jKsSVThiOOZ8Cpfy2eiYDAhx302JjM
	vPvoOwvKKoHlV2sH3pZth4cCzDvJ1Px10Wab0OYgPFdZRldEnsMPpl8Eekg1J/VxcNZIkRFv9al
	bJoZEJKwWUgFaILXpqtb3r0uUhQsmImbmsyd51ZLttp6o9N6g7tiscCIADDlBkV57LkyY+Ph6a5
	DEU4kJVw4rgdd+ND6lNJTzDfAMWNh2vgMcnx6MY0PEp8950NezNgrfXGKdCP9MX2FHoAZtE+ZcN
	BkHO7EvN7+2KAxVZDmYrFy009W3bZWbSNZpYq+v/uIBZ5bxVZf8Nf619nSnWksfvuq6+QG1B1Wn
	OKJtfG0LEOYcIZ8PuN0nYPPxN0MoWv0eezTg4PRjTxJJVKgBaOqv70wWjayIJDQiFifug6nV+k/
	4Y9ux8qPtnO7RG9T+2baazx2RGOZD2P6E8E739Q5MjODjFeyy6M4x9pfIQ55Y2FcWwpRvQbex8l
	PfFulDmJD7D+W/zy6AUvZO4OVJY6cg==
X-Received: by 2002:a05:600c:e558:20b0:49f:ce73:5e97 with SMTP id 5b1f17b1804b1-49fce735f5bmr54726715e9.35.1789997991415;
        Mon, 21 Sep 2026 06:39:51 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:49 -0700 (PDT)
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
Subject: [PATCH v6 09/13] io_uring/rsrc: introduce buf registration structure
Date: Mon, 21 Sep 2026 14:38:53 +0100
Message-ID: <13677c50b853ec0518528ad03ba06012342f1316.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to following changes, instead of passing an iovec for
buffer registration introduce a new structure. It'll be moved to uapi
later, but for now it's initialised early from a user provided iovec.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 51b46e624ddd..da767b34eb55 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -27,8 +27,13 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
+struct io_uring_regbuf_desc {
+	__u64 uaddr;
+	__u64 size;
+};
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov);
+						   struct io_uring_regbuf_desc *desc);
 
 static int hpage_acct_ref(struct io_ring_ctx *ctx, struct page *hpage,
 			  bool *acct_new)
@@ -81,6 +86,15 @@ static bool hpage_acct_unref(struct io_ring_ctx *ctx, struct page *hpage)
 
 #define IO_CACHED_BVECS_SEGS	32
 
+static void io_iov_to_regbuf_desc(const struct iovec *iov,
+				  struct io_uring_regbuf_desc *desc)
+{
+	*desc = (struct io_uring_regbuf_desc) {
+		.uaddr = (u64)(uintptr_t)iov->iov_base,
+		.size = iov->iov_len,
+	};
+}
+
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
 {
 	unsigned long page_limit, cur_pages, new_pages;
@@ -381,6 +395,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -394,7 +409,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 			err = -EFAULT;
 			break;
 		}
-		node = io_sqe_buffer_register(ctx, iov);
+
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
@@ -853,26 +870,26 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 }
 
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov)
+						   struct io_uring_regbuf_desc *desc)
 {
+	unsigned long uaddr = (unsigned long)desc->uaddr;
+	size_t size = desc->size;
 	struct io_mapped_ubuf *imu = NULL;
 	struct page **pages = NULL;
 	struct io_rsrc_node *node;
 	unsigned long off;
-	size_t size;
 	int ret, nr_pages, i;
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
-	if (!iov->iov_base) {
-		if (iov->iov_len)
+	if (!uaddr) {
+		if (size)
 			return ERR_PTR(-EFAULT);
 		/* remove the buffer without installing a new one */
 		return NULL;
 	}
 
-	ret = io_validate_user_buf_range((unsigned long)iov->iov_base,
-					 iov->iov_len);
+	ret = io_validate_user_buf_range(uaddr, size);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -881,8 +898,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -904,10 +920,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	if (ret)
 		goto done;
 
-	size = iov->iov_len;
 	/* store original address for later verification */
-	imu->ubuf = (unsigned long) iov->iov_base;
-	imu->len = iov->iov_len;
+	imu->ubuf = uaddr;
+	imu->len = size;
 	imu->folio_shift = PAGE_SHIFT;
 	imu->release = io_release_ubuf;
 	imu->priv = imu;
@@ -917,7 +932,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -969,6 +984,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -992,7 +1008,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 		}
 
-		node = io_sqe_buffer_register(ctx, iov);
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			break;
-- 
2.54.0


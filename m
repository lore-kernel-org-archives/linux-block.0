Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F424C9DFC
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602386; cv=none; b=IMig+drSh0OGv8+P7EKmx6Kyy/GcELvjiUOzO8odNXbJa6csynRfhNJ6tEfjGBVH8ZSQecP5iiCiq3Pd7gURN9ssRsj5J7Wx0zlD3I2OaEVOekRIS2v9a0ICrmlwNyxMmRp3eLMpe/m35aTfBqbTv0iPrVSCMlZ8JQYfTQMjjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602386; c=relaxed/simple;
	bh=Z4vOxks9qTIFK+TCf+DcsECaWrDahRJWHvnK/Oy0YsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqoeoVsCipl4NYIN4UhNM4wZfTj4Vp3BP0az5tiE4C8BmBHxJMhdQIw9tP0Y20WXZICe6naRkyeXcF6mgZtEQ8GQv01q5TOFcKcswnfmvuMrLvJmcN4JVxh067zJ/MhZOhD3P4Wr3vdh7wqt6NcO7fYLVN8t3l9XxiOXqWZyy6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UY3RrCwh; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY3RrCwh"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885d4825adso1839477f8f.0
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602379; x=1791207179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RT09IM6iAPFk2VI7P8d4NpW1v04uxG67FoGdSGxGhI=;
        b=UY3RrCwhYnPhXr8AkzcnPeNEkbrBMyA04UBKWmnTDBNGELNHpkWH7w5fS5Txp1Huc8
         hC1amO1hXCloFTtcV/9kThFy3Bah+Qxa+4sLYJxvNT912FKfzrPTDu2CsboIvPFtheT6
         XTMjl+eaf1MgkmjSuG01yKrsGrVGSpCEQvbjClfptMxRdTrYa+me8F24MROwh0iMp8QJ
         cbBfbnKppGaxfMKLM67XEjEjnwUjshA35fxgjnfoDMIzSi+OejtxQ1xTgEOL42yMhm6G
         z37g0kLzqiJ59alYwznS+6643oEu1CyPgllnqMcNN5uzzh30t3+1QVR4upyxq6tlX/3J
         d5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602379; x=1791207179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/RT09IM6iAPFk2VI7P8d4NpW1v04uxG67FoGdSGxGhI=;
        b=yGBS03Jy1ChATTrhq+czXC1kGCCNlCWhQbI7z8nGRjerwIYgguCsR7nZLNNoLCCRv/
         iUxWVrHBDmbg8jVkSGjcGhCQLs1KziJrKhg0Ts0cPsLhNMSXCTqb6wn8maw1bDeEbp5E
         Kb6WdXv0MfP6xsnijB8K8MDxznAdGB8VQoPX8R10BUz2mw58g04kGnWgyeSyNH54Aw6G
         dSHXjdFue2CLJ9GvpBNNIcC1AZB/JJ9oWO8tM+T5GpIJCv/fmeYH5fOxUP9bIT3p0TBH
         cc006nzJmlhXE7pkf82GttuFUPnICsGCU3l1PJxKFKceJEfJu+MkMUn1OchX5q9JF6ia
         c6/A==
X-Gm-Message-State: AFq9FYJLgGnwG43qX58AIXHvss3i8j+tUnfnlLUijdp4orI48XmvwOiy
	OKPjD6WG0bXFsmkxHMewdQrH24Sbzv1cmsheAGppFZXOhRfqt9hEopF8CvjgLrY0
X-Gm-Gg: AYBFou3pyMkoJB7lZ+4NxODFAuxZUZwDJjr4vmb1EPWy/Ab+5bEFZYDR/Uh3SaxR543
	vTBn0P6qO7x6d2UiopmoV8j+Egcr4frDwDn4vMh68+lucneQeAAKpJ2oyg5oCuQeILUpWG0T3jh
	6V/+qisRtqnWqmLmgOYiVl0M1l3vEOrXxyJi25yl+ZtgT4tFlcAvNznIKPiLwnCuXI2AWRzofmn
	GAzvtD3h24iMAG862DkPHLl195BgP81pa6MM0EmSWQUqsTHS2NB1cIOtby9YQpa6Ml4QWRClGL8
	I/iaNyuZA608qe9B8B61/xhB5bnOlrdfUdg6QiDCFu3BIT9TS5k9ux/5cuOQ8yj6j8k1KR6eboD
	KWtYovhW6Vj+Ruh2u3+cSpUbNRFm/PjPMxgPAbzen3p9kz2+6H2XhOqWsqnz6+GFSD+Bgn7wY5c
	sHO1t6edk/eardRnrIWq2CML7fhMZwa8u56YYmsS7t9Cttx/s8OgMNwm5nlf6k+C0WMqFG8SRjk
	pRYc8X2isC21+kZar03MHG82rBsFLJ80K8itlmzyRuYkV0hZnuEazGwX9Sti5R+Xp6yG6d6LeEq
X-Received: by 2002:a05:6000:1887:b0:486:f4ae:72a2 with SMTP id ffacd0b85a97d-4887170dd0dmr23900440f8f.1.1790602378210;
        Mon, 28 Sep 2026 06:32:58 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:57 -0700 (PDT)
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
Subject: [PATCH v7 09/13] io_uring/rsrc: introduce buf registration structure
Date: Mon, 28 Sep 2026 14:32:25 +0100
Message-ID: <f0305198380997a88a3ed020fd6e69246992220d.1790602223.git.asml.silence@gmail.com>
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


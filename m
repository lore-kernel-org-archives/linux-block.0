Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9CE1E1C36
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977351; cv=none; b=suREZiwry6I8WdNFaZ3FEAP6TAIzTug5xygHvNUVCeUP3OGDH1W64u/GjKfSbiULWdEcQkR1pgry6Gt6xxYpap+6tIRYbBk1Y9a4eY+bss6b5d0HyP2mGbGOdKPdYhk3Q02TWF60mDUjwndTGzBEOlrXmRD9Vn8KtM7og/+As5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977351; c=relaxed/simple;
	bh=WXyPckGAHkAnJ3xaf8ENEQVhhom5E7uOP7ig1RDadls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvwCP6ii0i5yQtZ8gw0Oyq5fIDRnoqp2EA0OENseQtxCTb14z8un9Vk41rjedCcN7FkPHzMjewtIHROuErv8aJ7l9wb6yU9SLz7VuVEr6Yx3tidSf+BtEALQlEWRpoiFsAdtWAoZBSZ0XdsMf3awFkRUu9x/Rax3M1ISoOaS1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYATICEI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYATICEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730977348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1h9L5DweKmrJ102XwCrOvCHCpyndeFnMm0NdLnQwyk=;
	b=EYATICEIzVSI6kZWM0mi2RHs1jOljQVDeHpHLAjWWQaoGafxdb8o+BguFefp7pg5rFL9aJ
	uoWdfhlCUY9GtmuCWEM8JA8eGNO0bhY62x3d/TTmwADYmBpSUaZk1nkYvF+U//eUzxMpaA
	nk+BYAWz56S5f6fJnh8aO03p8WsNfn4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-pyHs6U3fNxOsnqkLWOG_3A-1; Thu,
 07 Nov 2024 06:02:22 -0500
X-MC-Unique: pyHs6U3fNxOsnqkLWOG_3A-1
X-Mimecast-MFC-AGG-ID: pyHs6U3fNxOsnqkLWOG_3A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8A82194510C;
	Thu,  7 Nov 2024 11:02:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.54])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D462A196BC05;
	Thu,  7 Nov 2024 11:02:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V10 05/12] io_uring: rename io_mapped_ubuf as io_mapped_buf
Date: Thu,  7 Nov 2024 19:01:38 +0800
Message-ID: <20241107110149.890530-6-ming.lei@redhat.com>
In-Reply-To: <20241107110149.890530-1-ming.lei@redhat.com>
References: <20241107110149.890530-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Rename io_mapped_ubuf so that the same structure can be used for
describing kernel buffer.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/fdinfo.c |  2 +-
 io_uring/rsrc.c   | 10 +++++-----
 io_uring/rsrc.h   |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index b214e5a407b5..9ca95f877312 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -218,7 +218,7 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *file)
 	}
 	seq_printf(m, "UserBufs:\t%u\n", ctx->buf_table.nr);
 	for (i = 0; has_lock && i < ctx->buf_table.nr; i++) {
-		struct io_mapped_ubuf *buf = NULL;
+		struct io_mapped_buf *buf = NULL;
 
 		if (ctx->buf_table.nodes[i])
 			buf = ctx->buf_table.nodes[i]->buf;
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index db5d917081b1..a4a553bbbbfa 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -106,7 +106,7 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
 	unsigned int i;
 
 	if (node->buf) {
-		struct io_mapped_ubuf *imu = node->buf;
+		struct io_mapped_buf *imu = node->buf;
 
 		if (!refcount_dec_and_test(&imu->refs))
 			return;
@@ -580,7 +580,7 @@ static bool headpage_already_acct(struct io_ring_ctx *ctx, struct page **pages,
 	/* check previously registered pages */
 	for (i = 0; i < ctx->buf_table.nr; i++) {
 		struct io_rsrc_node *node = ctx->buf_table.nodes[i];
-		struct io_mapped_ubuf *imu;
+		struct io_mapped_buf *imu;
 
 		if (!node)
 			continue;
@@ -597,7 +597,7 @@ static bool headpage_already_acct(struct io_ring_ctx *ctx, struct page **pages,
 }
 
 static int io_buffer_account_pin(struct io_ring_ctx *ctx, struct page **pages,
-				 int nr_pages, struct io_mapped_ubuf *imu,
+				 int nr_pages, struct io_mapped_buf *imu,
 				 struct page **last_hpage)
 {
 	int i, ret;
@@ -724,7 +724,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 						   struct iovec *iov,
 						   struct page **last_hpage)
 {
-	struct io_mapped_ubuf *imu = NULL;
+	struct io_mapped_buf *imu = NULL;
 	struct page **pages = NULL;
 	struct io_rsrc_node *node;
 	unsigned long off;
@@ -866,7 +866,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 }
 
 int io_import_fixed(int ddir, struct iov_iter *iter,
-			   struct io_mapped_ubuf *imu,
+			   struct io_mapped_buf *imu,
 			   u64 buf_addr, size_t len)
 {
 	u64 buf_end;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 582a69adfdc9..0867dc304f4f 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -24,11 +24,11 @@ struct io_rsrc_node {
 	u64 tag;
 	union {
 		unsigned long file_ptr;
-		struct io_mapped_ubuf *buf;
+		struct io_mapped_buf *buf;
 	};
 };
 
-struct io_mapped_ubuf {
+struct io_mapped_buf {
 	u64		ubuf;
 	unsigned int	len;
 	unsigned int	nr_bvecs;
@@ -52,7 +52,7 @@ void io_rsrc_data_free(struct io_ring_ctx *ctx, struct io_rsrc_data *data);
 int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 int io_import_fixed(int ddir, struct iov_iter *iter,
-			   struct io_mapped_ubuf *imu,
+			   struct io_mapped_buf *imu,
 			   u64 buf_addr, size_t len);
 
 int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg);
-- 
2.47.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88E156655
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012603; cv=none; b=a/rWMWZdHGSw5lYg+yK750/Zp4oz6AVjbKWA5fN3qBUNa7RI0UhFd8ldEz2PKW8r6GlQvdkngx/hqOCsyNYKvWWt5vuS10yKalyxzt6zlsZCF/z1vombcLvGFU+FdJXsJR2MEIEFMu6+JHr+zXvqx5q3u8geL1NHE+6P7+I+Y8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012603; c=relaxed/simple;
	bh=bFWZqxIQMgIYLnjpkFhEn0FXhB8ZlMUZkxurUoUHNIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHkcyPyGe0kna41g3TY2GpF5WSbA4NEEIvSqR8nTvvbEuSAi9WKbAP5O8LVmjwR9ifxm2Cgv0Odk7Lc82hOQmko9tm2IXlPqv3Yqz3GOMiBRbEaIGJVIfRXtUyVisOaEmmkGZoHmCCil4neERHIQjrnf2YBA2GnmNQH06T6FPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwVhZF0x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwVhZF0x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715012600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eTNtub9ELAAZvKgGnBgdeqt9mXHphePzZSGVMxIZSg=;
	b=DwVhZF0xhLPtmZSMXd6mpJs0f22Tt+aSLEgWC4CuhvMctYCzy4I2WZm0+obbmDjpSnUWfk
	yuRMEYfkdBNQxAtGe1BKFqB28eKQeQkdFEOU5hXMYEi37p6S6HkjkgpprcFaYhYC6w0YIm
	VI70kvq5JsO4H28lfPJNsghThsbyw+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-O0R_bJujOGSq9ypCeqIFDg-1; Mon, 06 May 2024 12:23:19 -0400
X-MC-Unique: O0R_bJujOGSq9ypCeqIFDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B00B800935;
	Mon,  6 May 2024 16:23:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 639158C4;
	Mon,  6 May 2024 16:23:17 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH V2 1/9] io_uring: add io_link_req() helper
Date: Tue,  7 May 2024 00:22:37 +0800
Message-ID: <20240506162251.3853781-2-ming.lei@redhat.com>
In-Reply-To: <20240506162251.3853781-1-ming.lei@redhat.com>
References: <20240506162251.3853781-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Add io_link_req() helper, so that io_submit_sqe() becomes more readable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/io_uring.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 2675cffbd9a4..c02c9291a2df 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2172,19 +2172,11 @@ static __cold int io_submit_fail_init(const struct io_uring_sqe *sqe,
 	return 0;
 }
 
-static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			 const struct io_uring_sqe *sqe)
-	__must_hold(&ctx->uring_lock)
+/*
+ * Return NULL if nothing to be queued, otherwise return request for queueing */
+static struct io_kiocb *io_link_sqe(struct io_submit_link *link,
+				    struct io_kiocb *req)
 {
-	struct io_submit_link *link = &ctx->submit_state.link;
-	int ret;
-
-	ret = io_init_req(ctx, req, sqe);
-	if (unlikely(ret))
-		return io_submit_fail_init(sqe, req, ret);
-
-	trace_io_uring_submit_req(req);
-
 	/*
 	 * If we already have a head request, queue this one for async
 	 * submittal once the head completes. If we don't have a head but
@@ -2198,7 +2190,7 @@ static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		link->last = req;
 
 		if (req->flags & IO_REQ_LINK_FLAGS)
-			return 0;
+			return NULL;
 		/* last request of the link, flush it */
 		req = link->head;
 		link->head = NULL;
@@ -2214,9 +2206,30 @@ static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 fallback:
 			io_queue_sqe_fallback(req);
 		}
-		return 0;
+		return NULL;
 	}
+	return req;
+}
+
+static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			 const struct io_uring_sqe *sqe)
+	__must_hold(&ctx->uring_lock)
+{
+	struct io_submit_link *link = &ctx->submit_state.link;
+	int ret;
 
+	ret = io_init_req(ctx, req, sqe);
+	if (unlikely(ret))
+		return io_submit_fail_init(sqe, req, ret);
+
+	trace_io_uring_submit_req(req);
+
+	if (unlikely(link->head || (req->flags & (IO_REQ_LINK_FLAGS |
+				    REQ_F_FORCE_ASYNC | REQ_F_FAIL)))) {
+		req = io_link_sqe(link, req);
+		if (!req)
+			return 0;
+	}
 	io_queue_sqe(req);
 	return 0;
 }
-- 
2.42.0


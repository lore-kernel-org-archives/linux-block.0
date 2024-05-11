Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5215B7
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386353; cv=none; b=tguUYabns8jvSWiMz5QyqlLE9dRfL4fyrdxYvWhijj4u8/COgWnlz+ePy67uUlT9PLIGPeVOVtvUB0taiIWXOrtkNwMrNfesBKxTUzeIQ6Fs7ToV4qHLjaKoaV64aO0BW/lvwPUEe+Lp69bNkgYr9F9mNBN7a51irAqHChrHjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386353; c=relaxed/simple;
	bh=bFWZqxIQMgIYLnjpkFhEn0FXhB8ZlMUZkxurUoUHNIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWzrhD1ignFrb2OC66I3aH5d9FGoTK9encW9nKB5MPewP+QuxyB5OGhfad8C4n0atWpuvUqLx/Ze4Y0Q5+GJ/wI5Bu2DSnaxMDBUJiQb2fswge5KsIxJ6HMYQLeUEQy6zSXz5UmuWYTfwIaazqI9+R7gsaxXRPex+gGkk4zMonw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAnxTRsL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAnxTRsL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715386351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eTNtub9ELAAZvKgGnBgdeqt9mXHphePzZSGVMxIZSg=;
	b=jAnxTRsLyXoKsdZmnEcNYhC/hA8sh1MzPbMsqQhZPLj5mnZwGWbmSo4lHgvv4rajUBc3IL
	GMcXM1pYa8ZLIIGtTOak9m1kd9hN1GDo1xYZEibkfpFT1TNXokWFiWYksdS3zqvH+vj+7/
	pKHOgETua/Qfhk/AKmadawZtIDVXEtY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-XgCGAShXPZm_AcuhOa2AYQ-1; Fri, 10 May 2024 20:12:26 -0400
X-MC-Unique: XgCGAShXPZm_AcuhOa2AYQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64235101A525;
	Sat, 11 May 2024 00:12:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.30])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F62C40004D;
	Sat, 11 May 2024 00:12:25 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/9] io_uring: add io_link_req() helper
Date: Sat, 11 May 2024 08:12:04 +0800
Message-ID: <20240511001214.173711-2-ming.lei@redhat.com>
In-Reply-To: <20240511001214.173711-1-ming.lei@redhat.com>
References: <20240511001214.173711-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

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


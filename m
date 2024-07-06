Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF85C156
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235420; cv=none; b=UN6lVLGyyH6nh6H2QHLcErMsNZlSgamGb0pMcf3AQpaQqejRGR73x6trmCx1e2Zl0B1WfBJ1YhndbbrubSrAzEWdrMEBJAwezTaRpLMUQo0EoQVfKqzpe3xYuACPsceO5MLQrKgkjKJ9FnDl2YZCKDkgAK4ho3Ui64zeSQEi3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235420; c=relaxed/simple;
	bh=uTi3/z2BHNRPrXN8Dbb13duV6s2DatQ1N9xUctj9OlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQ3Ss/o9h6ml6MQiqeCalpW3dwqCVRzLgdawRRs319Y7VAjQU6eSND1YtDcchFFCpb47ymTY3L8Szldxzcy3+uHM9Xxc2ARJP72q0ohMypZ1aSwvKbir+IB/elQ6eTe7Gma575gvJg6MD9qteJd9u2bPJkaO3Z3RmvI0u8ZZ4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsCIgQ3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsCIgQ3T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720235417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIXre7On7g2Tm645troByhnNPQTP7fj7TZtTOkbNwQA=;
	b=IsCIgQ3Trj5r0/lK0oS/tCmJOi9sPkJOteIMDv+QcOnttDihFqz4wmsn5/DhKpUV9pBVps
	HXERTeDQtqU30yT53G47WDqbQcHH/dYpdJeOPjCI0mRRBNQj3jLwxeN5shvKQtnRUicRsc
	YjdjZKQn6EIGmX8SzzWxayFeO+wOb0s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-Ixyj4Pv1MryKhnKW8DbfBg-1; Fri,
 05 Jul 2024 23:10:16 -0400
X-MC-Unique: Ixyj4Pv1MryKhnKW8DbfBg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEC7D19560B3;
	Sat,  6 Jul 2024 03:10:14 +0000 (UTC)
Received: from localhost (unknown [10.72.112.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 379F01955E70;
	Sat,  6 Jul 2024 03:10:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 1/8] io_uring: add io_link_req() helper
Date: Sat,  6 Jul 2024 11:09:51 +0800
Message-ID: <20240706031000.310430-2-ming.lei@redhat.com>
In-Reply-To: <20240706031000.310430-1-ming.lei@redhat.com>
References: <20240706031000.310430-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add io_link_req() helper, so that io_submit_sqe() becomes more readable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/io_uring.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 42139bb85fff..617ee97bb3f2 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2132,19 +2132,11 @@ static __cold int io_submit_fail_init(const struct io_uring_sqe *sqe,
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
@@ -2158,7 +2150,7 @@ static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		link->last = req;
 
 		if (req->flags & IO_REQ_LINK_FLAGS)
-			return 0;
+			return NULL;
 		/* last request of the link, flush it */
 		req = link->head;
 		link->head = NULL;
@@ -2174,9 +2166,30 @@ static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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


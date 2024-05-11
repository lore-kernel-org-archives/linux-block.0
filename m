Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CE320E
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386362; cv=none; b=ut9yKL+hHNz+RpIOBIRHn0vLE3CJrbPCNbH70WXdLXILqaQRNG0p5v82tOR2dwG50ErKoy70WA0tlZODoI40/q8XPuUIGxiRxWrIdMAg4tFMIvKY5WhfHS9EcLbPIZBfHLOBqjpH5PfUWbgCAkJCWK5hM6WTujV+cRLhunQm9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386362; c=relaxed/simple;
	bh=RUOhxvOtwKxi8yL0/dOuRGEplMbd+DYC0ZTrMyC7qtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGwkpFLs87nkki1X9hy0yUPz1JR1/TDBaE2TptFVPOWON4LnlTcaCKQUskLPgv9wD1MBUhPexaB+ZE1VswaOTg6/dC8NU96Jtmubkhi5q2kOdb4FDNBuhxuwHtN6J3S8WiK+fulEaV7aiFVRLlyR2IfEzZ5qA7kb9lBBs8ROfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bh8bkNJi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bh8bkNJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715386359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwBph75tjF3+qUTs7CgZePkK74u79ZtRZYo09Hj5YWg=;
	b=bh8bkNJilRQH3tjVCbgVtz7M3jD4ugDHPiIwChWmknjodNbfSY5VvwMnV+uQQ/aeh++kUj
	HK29/5AlmQ7fp0vT+3jMgxC9hxwK9yofeS5gF9HYzkIAgo5J0lxAqw/ffa4Nvm1FkShXeF
	OZ/klg7rd2TJgJgFKKQ8ZwLlERgMl+0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-tnghkLJWONiuzHLRsxdhow-1; Fri,
 10 May 2024 20:12:33 -0400
X-MC-Unique: tnghkLJWONiuzHLRsxdhow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAC4F1C05144;
	Sat, 11 May 2024 00:12:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.30])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD3951C043EB;
	Sat, 11 May 2024 00:12:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/9] io_uring: add helper of io_req_commit_cqe()
Date: Sat, 11 May 2024 08:12:06 +0800
Message-ID: <20240511001214.173711-4-ming.lei@redhat.com>
In-Reply-To: <20240511001214.173711-1-ming.lei@redhat.com>
References: <20240511001214.173711-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Add helper of io_req_commit_cqe() which can be used in posting CQE
from both __io_submit_flush_completions() and io_req_complete_post().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/io_uring.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d3b9988cdae4..e4be930e0f1e 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -910,6 +910,22 @@ bool io_req_post_cqe(struct io_kiocb *req, s32 res, u32 cflags)
 	return posted;
 }
 
+static __always_inline void io_req_commit_cqe(struct io_kiocb *req,
+		bool lockless_cq)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+
+	if (unlikely(!io_fill_cqe_req(ctx, req))) {
+		if (lockless_cq) {
+			spin_lock(&ctx->completion_lock);
+			io_req_cqe_overflow(req);
+			spin_unlock(&ctx->completion_lock);
+		} else {
+			io_req_cqe_overflow(req);
+		}
+	}
+}
+
 static void io_req_complete_post(struct io_kiocb *req, unsigned issue_flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -932,10 +948,8 @@ static void io_req_complete_post(struct io_kiocb *req, unsigned issue_flags)
 	}
 
 	io_cq_lock(ctx);
-	if (!(req->flags & REQ_F_CQE_SKIP)) {
-		if (!io_fill_cqe_req(ctx, req))
-			io_req_cqe_overflow(req);
-	}
+	if (!(req->flags & REQ_F_CQE_SKIP))
+		io_req_commit_cqe(req, false);
 	io_cq_unlock_post(ctx);
 
 	/*
@@ -1454,16 +1468,8 @@ void __io_submit_flush_completions(struct io_ring_ctx *ctx)
 		struct io_kiocb *req = container_of(node, struct io_kiocb,
 					    comp_list);
 
-		if (!(req->flags & REQ_F_CQE_SKIP) &&
-		    unlikely(!io_fill_cqe_req(ctx, req))) {
-			if (ctx->lockless_cq) {
-				spin_lock(&ctx->completion_lock);
-				io_req_cqe_overflow(req);
-				spin_unlock(&ctx->completion_lock);
-			} else {
-				io_req_cqe_overflow(req);
-			}
-		}
+		if (!(req->flags & REQ_F_CQE_SKIP))
+			io_req_commit_cqe(req, ctx->lockless_cq);
 	}
 	__io_cq_unlock_post(ctx);
 
-- 
2.42.0


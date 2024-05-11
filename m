Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F00E10FD
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386371; cv=none; b=IE69HVA+Js3MWBV3TJYUNNG0R7qDDCtoKJLGvC2q/PQom7WUfI8gA9pExMQaxrGeCJvv6G4YfRpFDxLgVF0bIi0yBgcnmL02uC3BC1HMcaaem2r74+A6zFIE2+USvvJa29n7QMWDbOIUexThT+i2BD87VJz6kTmdLX54O44DKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386371; c=relaxed/simple;
	bh=MKegbj/sSG6GrSO39MvSbwAdhEM0ymmBOZm1pzPMUtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/t3llvZ9b9YLUikJoYWEjNRR995qAgQepOsZNBX6WOI3atrWnsOq0/Norq0vOv2rytfJ23izbjUiN99KaSUQ4Frw3OIacMYM1JXKKORPaHhO4Cktqd9BhFucsoCLvtwltibfUJ65usTuv/hIPXaz16mMKjWtaaJVjKis4HatpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ed+FzDQL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ed+FzDQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715386368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKTTtY1y7k7AmfzI2jF98Rd0+0s+DQV8PWG07tTxXmY=;
	b=ed+FzDQLRu5Z5jQhOwouniqksD/a4/B7K3id+bH9xowvt8hEZG9iBWWuvYeSKgSi5cLD+f
	YNwjIUGpXjsjLO203ogjwgdDzNC1xOr/1maqgNV2YiPlHBRsPvG4K8AwiB7P/XXecaODqz
	AG1GcNOAEboSwtswNlQbYQIgSR7erp8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-CmKsSaIfNuu7FDFw8nCyNA-1; Fri,
 10 May 2024 20:12:30 -0400
X-MC-Unique: CmKsSaIfNuu7FDFw8nCyNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDA691C01718;
	Sat, 11 May 2024 00:12:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.30])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C8F572079B08;
	Sat, 11 May 2024 00:12:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/9] io_uring: add io_submit_fail_link() helper
Date: Sat, 11 May 2024 08:12:05 +0800
Message-ID: <20240511001214.173711-3-ming.lei@redhat.com>
In-Reply-To: <20240511001214.173711-1-ming.lei@redhat.com>
References: <20240511001214.173711-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Add io_submit_fail_link() helper and put linking fail logic into this
helper.

This way simplifies io_submit_fail_init(), and becomes easier to add
sqe group failing logic.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/io_uring.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c02c9291a2df..d3b9988cdae4 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2135,22 +2135,17 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	return def->prep(req, sqe);
 }
 
-static __cold int io_submit_fail_init(const struct io_uring_sqe *sqe,
+static __cold int io_submit_fail_link(struct io_submit_link *link,
 				      struct io_kiocb *req, int ret)
 {
-	struct io_ring_ctx *ctx = req->ctx;
-	struct io_submit_link *link = &ctx->submit_state.link;
 	struct io_kiocb *head = link->head;
 
-	trace_io_uring_req_failed(sqe, req, ret);
-
 	/*
 	 * Avoid breaking links in the middle as it renders links with SQPOLL
 	 * unusable. Instead of failing eagerly, continue assembling the link if
 	 * applicable and mark the head with REQ_F_FAIL. The link flushing code
 	 * should find the flag and handle the rest.
 	 */
-	req_fail_link_node(req, ret);
 	if (head && !(head->flags & REQ_F_FAIL))
 		req_fail_link_node(head, -ECANCELED);
 
@@ -2169,9 +2164,24 @@ static __cold int io_submit_fail_init(const struct io_uring_sqe *sqe,
 	else
 		link->head = req;
 	link->last = req;
+
 	return 0;
 }
 
+static __cold int io_submit_fail_init(const struct io_uring_sqe *sqe,
+				      struct io_kiocb *req, int ret)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_submit_link *link = &ctx->submit_state.link;
+
+	trace_io_uring_req_failed(sqe, req, ret);
+
+	req_fail_link_node(req, ret);
+
+	/* cover both linked and non-linked request */
+	return io_submit_fail_link(link, req, ret);
+}
+
 /*
  * Return NULL if nothing to be queued, otherwise return request for queueing */
 static struct io_kiocb *io_link_sqe(struct io_submit_link *link,
-- 
2.42.0


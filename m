Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3D10E9
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538255; cv=none; b=r8yrM7U7AogUL9OYlh0fgOeZW8HZh1w9BaHmGFTIYgq0WOCyCdHP4+Q0bjGDXt/3lb/W5ksiOXdd9+5gfk1OIOXb4FIZww1GJtx9MA1nK5L3RNIsAvfymDyGBAiWd6+3NG9hHIfQTYfqh+yAg/ncHel2wlkCFiTeWOOWkUIs57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538255; c=relaxed/simple;
	bh=A0m9RFVAWRdlX79tNuHAOT77nPe+Jqk1pLUJTU7vgzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy0VIH9RNqVY8BQ8dIhc7CNhEWD2lkRw7zb8qQwJPPixGqycWCrzkip645hLXl6mgQGAXE3tNJ0uvDJ9rlQlNuyO3+ivnrWY5Ee1UJ2CYJ4cJc5ws6Q4PSNbnGgU15IulOGt8c+sb2TDFabWuhUsw809pwTjDSFbJq95R3LReO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+GKbx9y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+GKbx9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712538253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McDk3PqX7U+JoL3gMgs97ctrnawJhamozIBAtYPTYWc=;
	b=G+GKbx9yor4vwfmTBYfP4cmblt/W72krgfCRhy/W4ZeZWAfmIq91qaIRRaSKsiIWsuY4IN
	XGHglJZvd7UJaWYqS3UGaerwmZmn1FPaPU6Bi9YMiwF02c0ZWYKs0rHYCZsdFKMruhbxI7
	T/gQapdLCS1FH5pnD6MBLyIRHN/B1vI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-rmwUIfAwMY-jOdCs2OWGAQ-1; Sun, 07 Apr 2024 21:04:11 -0400
X-MC-Unique: rmwUIfAwMY-jOdCs2OWGAQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A03F1927A6B;
	Mon,  8 Apr 2024 01:04:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4C31444585;
	Mon,  8 Apr 2024 01:04:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/9] io_uring: add one output argument to io_submit_sqe
Date: Mon,  8 Apr 2024 09:03:17 +0800
Message-ID: <20240408010322.4104395-5-ming.lei@redhat.com>
In-Reply-To: <20240408010322.4104395-1-ming.lei@redhat.com>
References: <20240408010322.4104395-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Add one output argument to io_submit_sqe() for returning how many SQEs
handled in this function.

Prepare for supporting SQE group, which can include multiple member SQEs
to handle in io_submit_sqe().

No functional change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/io_uring.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c73819c04c0b..4969d21ea2f8 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2204,12 +2204,13 @@ static __cold int io_submit_fail_init(const struct io_uring_sqe *sqe,
 }
 
 static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			 const struct io_uring_sqe *sqe)
+			 const struct io_uring_sqe *sqe, unsigned int *nr)
 	__must_hold(&ctx->uring_lock)
 {
 	struct io_submit_link *link = &ctx->submit_state.link;
 	int ret;
 
+	*nr = 1;
 	ret = io_init_req(ctx, req, sqe);
 	if (unlikely(ret))
 		return io_submit_fail_init(sqe, req, ret);
@@ -2351,6 +2352,7 @@ int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
 	do {
 		const struct io_uring_sqe *sqe;
 		struct io_kiocb *req;
+		unsigned int done;
 
 		if (unlikely(!io_alloc_req(ctx, &req)))
 			break;
@@ -2363,12 +2365,13 @@ int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
 		 * Continue submitting even for sqe failure if the
 		 * ring was setup with IORING_SETUP_SUBMIT_ALL
 		 */
-		if (unlikely(io_submit_sqe(ctx, req, sqe)) &&
+		if (unlikely(io_submit_sqe(ctx, req, sqe, &done)) &&
 		    !(ctx->flags & IORING_SETUP_SUBMIT_ALL)) {
-			left--;
+			left -= done;
 			break;
 		}
-	} while (--left);
+		left -= done;
+	} while (left);
 
 	if (unlikely(left)) {
 		ret -= left;
-- 
2.42.0


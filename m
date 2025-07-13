Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3608836
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417332; cv=none; b=BG2deN6km8t6UyLmIjtIysUWempnRMoMfbrA5r4nNwfv2d0DJOgqX1rxEUxW7pyn4u5UBTrlOOxXQ3AEWF1uuV6clRR7FCme+u3yzkVxLPW1Bkr0HMKAXjv29zfmp5ShYSGCTTm5AxUosLSX3X6uZqr4HVn5FikfVP1Uwez24BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417332; c=relaxed/simple;
	bh=HmXxlDO5YYi6sjQiyMtqATKiKXys+N3hqXNFk4ldjUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px/72YRAEpKoVL63YU3wZbjIj+r3UIzNkgTSmB0p+E75KhpeKaDXJCwkq9PxxahzvDsxXNOjTNqdtXq5HBmV2SR5Tuc52bnYXHWDLxbbyOaK6hTO6aqddWOIrpTUbE0K+OP3mVGqgYOEoF5g9T6BU3Cl8Tj0zBB0FnjHUWJiRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzwIdyFS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzwIdyFS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGYjyZD0trjEzKBmYpBpRWlxfGLDJ5UAtcdW3zaJXNY=;
	b=AzwIdyFS6NFxbkRJ8IK4wkgxrBMVW0C3vj1lWdsv+OnBcBxiSsZCw4z//Npmd8LwvEcG4a
	+PW4NKZNZVu1B3ruKPKye7x69frAHNVg36a/h/Pr9hnTJ7wmJ9vge7KifIpReTkfrWIheN
	EYVamIfmcS0tF6Or2CF9Nk3nqwnhuGk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-ZbH5A6AmNOaeI42SPm1Jkg-1; Sun,
 13 Jul 2025 10:35:24 -0400
X-MC-Unique: ZbH5A6AmNOaeI42SPm1Jkg-1
X-Mimecast-MFC-AGG-ID: ZbH5A6AmNOaeI42SPm1Jkg_1752417323
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91AE81956080;
	Sun, 13 Jul 2025 14:35:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B9DB19560A7;
	Sun, 13 Jul 2025 14:35:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 11/17] selftests: ublk: remove `tag` parameter of ->tgt_io_done()
Date: Sun, 13 Jul 2025 22:34:06 +0800
Message-ID: <20250713143415.2857561-12-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The `tag` parameter can be figured out from cqe->user_data, and that is
also the only way to get the info, so remove `tag` parameter, and
let target code retrieve it from cqe->user_data.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/fault_inject.c | 3 ++-
 tools/testing/selftests/ublk/file_backed.c  | 3 ++-
 tools/testing/selftests/ublk/kublk.c        | 4 +---
 tools/testing/selftests/ublk/kublk.h        | 3 +--
 tools/testing/selftests/ublk/null.c         | 3 ++-
 tools/testing/selftests/ublk/stripe.c       | 3 ++-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index 6e60f7d97125..c980958ec045 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -55,9 +55,10 @@ static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
 	return 0;
 }
 
-static void ublk_fault_inject_tgt_io_done(struct ublk_queue *q, int tag,
+static void ublk_fault_inject_tgt_io_done(struct ublk_queue *q,
 					  const struct io_uring_cqe *cqe)
 {
+	unsigned tag = user_data_to_tag(cqe->user_data);
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 
 	if (cqe->res != -ETIME)
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index cfa59b631693..02fb8a411d3b 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -108,9 +108,10 @@ static int ublk_loop_queue_io(struct ublk_queue *q, int tag)
 	return 0;
 }
 
-static void ublk_loop_io_done(struct ublk_queue *q, int tag,
+static void ublk_loop_io_done(struct ublk_queue *q,
 		const struct io_uring_cqe *cqe)
 {
+	unsigned tag = user_data_to_tag(cqe->user_data);
 	unsigned op = user_data_to_op(cqe->user_data);
 	struct ublk_io *io = ublk_get_io(q, tag);
 
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index e2d2042810d4..fba4e80e9bab 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -717,8 +717,6 @@ static int ublk_thread_is_done(struct ublk_thread *t)
 static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
 		struct io_uring_cqe *cqe)
 {
-	unsigned tag = user_data_to_tag(cqe->user_data);
-
 	if (cqe->res < 0 && cqe->res != -EAGAIN)
 		ublk_err("%s: failed tgt io: res %d qid %u tag %u, cmd_op %u\n",
 			__func__, cqe->res, q->q_id,
@@ -726,7 +724,7 @@ static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
 			user_data_to_op(cqe->user_data));
 
 	if (q->tgt_ops->tgt_io_done)
-		q->tgt_ops->tgt_io_done(q, tag, cqe);
+		q->tgt_ops->tgt_io_done(q, cqe);
 }
 
 static void ublk_handle_cqe(struct ublk_thread *t,
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 6be601536b3d..d7b711e63822 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -145,8 +145,7 @@ struct ublk_tgt_ops {
 	void (*deinit_tgt)(struct ublk_dev *);
 
 	int (*queue_io)(struct ublk_queue *, int tag);
-	void (*tgt_io_done)(struct ublk_queue *,
-			int tag, const struct io_uring_cqe *);
+	void (*tgt_io_done)(struct ublk_queue *, const struct io_uring_cqe *);
 
 	/*
 	 * Target specific command line handling
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index afe0b99d77ee..ea3da53437e9 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -87,9 +87,10 @@ static int null_queue_auto_zc_io(struct ublk_queue *q, int tag)
 	return 1;
 }
 
-static void ublk_null_io_done(struct ublk_queue *q, int tag,
+static void ublk_null_io_done(struct ublk_queue *q,
 		const struct io_uring_cqe *cqe)
 {
+	unsigned tag = user_data_to_tag(cqe->user_data);
 	unsigned op = user_data_to_op(cqe->user_data);
 	struct ublk_io *io = ublk_get_io(q, tag);
 
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 37d50bbf5f5e..53cefffaf32e 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -226,9 +226,10 @@ static int ublk_stripe_queue_io(struct ublk_queue *q, int tag)
 	return 0;
 }
 
-static void ublk_stripe_io_done(struct ublk_queue *q, int tag,
+static void ublk_stripe_io_done(struct ublk_queue *q,
 		const struct io_uring_cqe *cqe)
 {
+	unsigned tag = user_data_to_tag(cqe->user_data);
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	unsigned op = user_data_to_op(cqe->user_data);
 	struct ublk_io *io = ublk_get_io(q, tag);
-- 
2.47.0


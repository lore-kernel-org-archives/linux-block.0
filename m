Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD024D8CE
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937518; cv=none; b=GwuU8zOCGa554Y/GBwizV9hndO1rCLBrPhDbDWp2t+DQQEhtrL/LqGTW+PV+j0/UjsU89MQ6DlLKtRwrYc+iJ+p5ntkEpjMCcZl/cRONvFYCpV8GAa1mfowGV5rAQsHgQyxwHG7BHecSi/EgaeXdGHkr7o9Zep7C2JZGnjnqzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937518; c=relaxed/simple;
	bh=HmXxlDO5YYi6sjQiyMtqATKiKXys+N3hqXNFk4ldjUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOI/C3f5uc/yrC4EKct4YaPlfey5pMXZb7lZacYb8jaeA2cbBIAS8ZJ7nFW/K/SKnKOWhe3BAaO9ToCf2aK7nhLiEv1/oT+45OzUxEGgHc7RaDepIWBQ0oXkH0rrLZyUMRj0JPwI28X/BnXr+H100IGb5ogFLxcGFeuJ5ebWE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCLxuxgJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCLxuxgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGYjyZD0trjEzKBmYpBpRWlxfGLDJ5UAtcdW3zaJXNY=;
	b=PCLxuxgJiVoUUqKyp0XzAoj01doeVC+ztV4hGufoBQFRFQMoRJalFWb9LhHTCsSXYOu/3i
	m1fwcmphphjWvM92CP79eCsVwcnq3aCa/u45pei6l/u/riQx9Qdb5uLU7xVJ0zrhZ9EOoI
	6IrmP9pxcsyLdFedgZLZ/EmYQqW3ek0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-XGppWKLmMaitpB_iF99E0g-1; Mon,
 07 Jul 2025 21:18:32 -0400
X-MC-Unique: XGppWKLmMaitpB_iF99E0g-1
X-Mimecast-MFC-AGG-ID: XGppWKLmMaitpB_iF99E0g_1751937511
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A4221978F63;
	Tue,  8 Jul 2025 01:18:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 785F5180035C;
	Tue,  8 Jul 2025 01:18:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 10/16] selftests: ublk: remove `tag` parameter of ->tgt_io_done()
Date: Tue,  8 Jul 2025 09:17:37 +0800
Message-ID: <20250708011746.2193389-11-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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


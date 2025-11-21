Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB72D5946
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690431; cv=none; b=Gf9TKttnsjb3gkcbsqiXmiRNJRL4yYbXuahZOOJzaPX1XP9DN54a4Ltk+YZcb7rfRPxivNNpQLgIhaNdPsXPISIqbXqjPxpMooXyNk9I6BJ17QruQpRFq0k0u66PJn/w3sQw8YUZ/FYECiesh6a9/H1xDkKrtW/toKytTXcCAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690431; c=relaxed/simple;
	bh=h9nrZ+QTxjgEiuVLrumkTmK0/N8Hb7R1dqKgbtHQgyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omj0Ga/mXIngNo/qUrksP1bSLJqkDYhHiBh+kNZN1BAX9levAOwE2b9f7Fqd3bT+lxqFobQYXEKZHR+w9GD6rOrk03MSBezCmbgkX7Gqw0YYO25XDI8Bo8NlwGNzceQ9MrxbvFm3aARZQEB3srpw7SIHhR8tjZ7ibYM85fXC8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6ma3b6d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6ma3b6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VR5tYn7j4Lr6a5nnEyeVlgZjWK8/HDDfWoqimxA5mSI=;
	b=G6ma3b6de7g7H7Yu+5nnuaWOzBka4yVGQfFrSelLd5Um1JqqRr+LXWZmDooyTwE9CBLSrK
	9XtxOxDB5GOBB1jMwhvNSo65ajIsuTRYl6okaoIUyOGfXaTkBZYXkNs+yS+fgUL7GAsrET
	upTUFjljy58/L8aepbi2nrrmTQj1Y7c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-JNff8O66MxyvcJdtrKbsuA-1; Thu,
 20 Nov 2025 21:00:26 -0500
X-MC-Unique: JNff8O66MxyvcJdtrKbsuA-1
X-Mimecast-MFC-AGG-ID: JNff8O66MxyvcJdtrKbsuA_1763690425
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09EAE1800447;
	Fri, 21 Nov 2025 02:00:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 372ED1800451;
	Fri, 21 Nov 2025 02:00:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 20/27] selftests: ublk: replace assert() with ublk_assert()
Date: Fri, 21 Nov 2025 09:58:42 +0800
Message-ID: <20251121015851.3672073-21-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Replace assert() with ublk_assert() since it is often triggered in daemon,
and we may get nothing shown in terminal.

Add ublk_assert(), so we can log something to syslog when assert() is
triggered.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/common.c      |  2 +-
 tools/testing/selftests/ublk/file_backed.c |  2 +-
 tools/testing/selftests/ublk/kublk.c       |  2 +-
 tools/testing/selftests/ublk/kublk.h       |  2 +-
 tools/testing/selftests/ublk/stripe.c      | 10 +++++-----
 tools/testing/selftests/ublk/utils.h       | 10 ++++++++++
 6 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/ublk/common.c b/tools/testing/selftests/ublk/common.c
index 01580a6f8519..4c07bc37eb6d 100644
--- a/tools/testing/selftests/ublk/common.c
+++ b/tools/testing/selftests/ublk/common.c
@@ -16,7 +16,7 @@ int backing_file_tgt_init(struct ublk_dev *dev)
 {
 	int fd, i;
 
-	assert(dev->nr_fds == 1);
+	ublk_assert(dev->nr_fds == 1);
 
 	for (i = 0; i < dev->tgt.nr_backing_files; i++) {
 		char *file = dev->tgt.backing_file[i];
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index cd9fe69ecce2..9e7dd3859ea9 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -10,7 +10,7 @@ static enum io_uring_op ublk_to_uring_op(const struct ublksrv_io_desc *iod, int
 		return zc ? IORING_OP_READ_FIXED : IORING_OP_READ;
 	else if (ublk_op == UBLK_IO_OP_WRITE)
 		return zc ? IORING_OP_WRITE_FIXED : IORING_OP_WRITE;
-	assert(0);
+	ublk_assert(0);
 }
 
 static int loop_queue_flush_io(struct ublk_thread *t, struct ublk_queue *q,
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index f8fa102a627f..bb8da9ff247d 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -750,7 +750,7 @@ static void ublk_handle_uring_cmd(struct ublk_thread *t,
 	}
 
 	if (cqe->res == UBLK_IO_RES_OK) {
-		assert(tag < q->q_depth);
+		ublk_assert(tag < q->q_depth);
 		if (q->tgt_ops->queue_io)
 			q->tgt_ops->queue_io(t, q, tag);
 	} else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 38d80e60e211..f5c0978f30c2 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -218,7 +218,7 @@ static inline __u64 build_user_data(unsigned tag, unsigned op,
 {
 	/* we only have 7 bits to encode q_id */
 	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
-	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
+	ublk_assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
 
 	return tag | ((__u64)op << 16) | ((__u64)tgt_data << 24) |
 		(__u64)q_id << 56 | (__u64)is_target_io << 63;
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 791fa8dc1651..50874858a829 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -96,12 +96,12 @@ static void calculate_stripe_array(const struct stripe_conf *conf,
 			this->seq = seq;
 			s->nr += 1;
 		} else {
-			assert(seq == this->seq);
-			assert(this->start + this->nr_sects == stripe_off);
+			ublk_assert(seq == this->seq);
+			ublk_assert(this->start + this->nr_sects == stripe_off);
 			this->nr_sects += nr_sects;
 		}
 
-		assert(this->nr_vec < this->cap);
+		ublk_assert(this->nr_vec < this->cap);
 		this->vec[this->nr_vec].iov_base = (void *)(base + done);
 		this->vec[this->nr_vec++].iov_len = nr_sects << 9;
 
@@ -120,7 +120,7 @@ static inline enum io_uring_op stripe_to_uring_op(
 		return zc ? IORING_OP_READV_FIXED : IORING_OP_READV;
 	else if (ublk_op == UBLK_IO_OP_WRITE)
 		return zc ? IORING_OP_WRITEV_FIXED : IORING_OP_WRITEV;
-	assert(0);
+	ublk_assert(0);
 }
 
 static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
@@ -318,7 +318,7 @@ static int ublk_stripe_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	if (!dev->tgt.nr_backing_files || dev->tgt.nr_backing_files > NR_STRIPE)
 		return -EINVAL;
 
-	assert(dev->nr_fds == dev->tgt.nr_backing_files + 1);
+	ublk_assert(dev->nr_fds == dev->tgt.nr_backing_files + 1);
 
 	for (i = 0; i < dev->tgt.nr_backing_files; i++)
 		dev->tgt.backing_file_size[i] &= ~((1 << chunk_shift) - 1);
diff --git a/tools/testing/selftests/ublk/utils.h b/tools/testing/selftests/ublk/utils.h
index a852e0b7153e..17eefed73690 100644
--- a/tools/testing/selftests/ublk/utils.h
+++ b/tools/testing/selftests/ublk/utils.h
@@ -43,6 +43,7 @@ static inline void ublk_err(const char *fmt, ...)
 
 	va_start(ap, fmt);
 	vfprintf(stderr, fmt, ap);
+	va_end(ap);
 }
 
 static inline void ublk_log(const char *fmt, ...)
@@ -52,6 +53,7 @@ static inline void ublk_log(const char *fmt, ...)
 
 		va_start(ap, fmt);
 		vfprintf(stdout, fmt, ap);
+		va_end(ap);
 	}
 }
 
@@ -62,7 +64,15 @@ static inline void ublk_dbg(int level, const char *fmt, ...)
 
 		va_start(ap, fmt);
 		vfprintf(stdout, fmt, ap);
+		va_end(ap);
 	}
 }
 
+#define ublk_assert(x)  do { \
+	if (!(x)) {     \
+		ublk_err("%s %d: assert!\n", __func__, __LINE__); \
+		assert(x);      \
+	}       \
+} while (0)
+
 #endif
-- 
2.47.0


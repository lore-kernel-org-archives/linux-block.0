Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52030E84E
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721040; cv=none; b=WE8i3G5f6mjYZkgvVqS8ydM7rKlX/0sopTo9IZ7U2D5Pi9cnEyyymU0XueQZis7SBvwSuuBhwd+i/BXjhsLTLv9gITrxbHQmGkMl3n89F3NeV7H7rgqANEM0RJSg22TVkrDDYW0hEGIuTxzmmPzDNBKnqOqo9O93hOZYwIHlQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721040; c=relaxed/simple;
	bh=3uD2A9AMah1r6YWK1XfoxBIYajStAAGvNw5fYA3nLvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrWelcyxCO/q2zb9qCw9QEt8PSozvESsHHmH6vMu8juNepVh3RBvztMaPlgXUHAhqp9hQAIbVwdJxV/5LmQquZVg36eKTHUPdiBULQ6imRCOxCkCBGa/pmAjwWAW6g0hIVi0QMmfPzK6O8EqYwHFyaaU8gW5pwcdyuPs58ZXQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVu8gNDI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVu8gNDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bt1e73QJBjTxDN0ZaxfkJzxdEd3YdXlx4PqJKUhEzw=;
	b=FVu8gNDIzc32nbvzs8CS0po9PQ8wEumwXvDMyeTACWbR3xwlYTuueyaAli6+hR56/br0VD
	fWMTFfqfiMfiCYs7A7QD3vSWaQMyXhpnt5KQscP2s28aPqbUpl+B7kycqwdS05vMYt/8Rj
	MWvzvYcjWE6lVxQ79/0J8FdvKc3+JqY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-pCjYieVIMp-NB2M13SMf-A-1; Mon,
 01 Sep 2025 06:03:56 -0400
X-MC-Unique: pCjYieVIMp-NB2M13SMf-A-1
X-Mimecast-MFC-AGG-ID: pCjYieVIMp-NB2M13SMf-A_1756721035
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B72E51800347;
	Mon,  1 Sep 2025 10:03:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B82001954B04;
	Mon,  1 Sep 2025 10:03:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 16/23] selftests: ublk: replace assert() with ublk_assert()
Date: Mon,  1 Sep 2025 18:02:33 +0800
Message-ID: <20250901100242.3231000-17-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index 2d93ac860bd5..99bde88b6ebd 100644
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
index 95188065b2e9..6b25c7e1e6a6 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -733,7 +733,7 @@ static void ublk_handle_uring_cmd(struct ublk_thread *t,
 	}
 
 	if (cqe->res == UBLK_IO_RES_OK) {
-		assert(tag < q->q_depth);
+		ublk_assert(tag < q->q_depth);
 		if (q->tgt_ops->queue_io)
 			q->tgt_ops->queue_io(t, q, tag);
 	} else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 219233f8a053..b54eef96948e 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -218,7 +218,7 @@ static inline __u64 build_user_data(unsigned tag, unsigned op,
 {
 	/* we only have 7 bits to encode q_id */
 	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
-	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
+	ublk_assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
 
 	return tag | (op << 16) | (tgt_data << 24) |
 		(__u64)q_id << 56 | (__u64)is_target_io << 63;
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 1fb9b7cc281b..81dd05214b3f 100644
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
index 36545d1567f1..47e44cccaf6a 100644
--- a/tools/testing/selftests/ublk/utils.h
+++ b/tools/testing/selftests/ublk/utils.h
@@ -45,6 +45,7 @@ static inline void ublk_err(const char *fmt, ...)
 
 	va_start(ap, fmt);
 	vfprintf(stderr, fmt, ap);
+	va_end(ap);
 }
 
 static inline void ublk_log(const char *fmt, ...)
@@ -54,6 +55,7 @@ static inline void ublk_log(const char *fmt, ...)
 
 		va_start(ap, fmt);
 		vfprintf(stdout, fmt, ap);
+		va_end(ap);
 	}
 }
 
@@ -64,7 +66,15 @@ static inline void ublk_dbg(int level, const char *fmt, ...)
 
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


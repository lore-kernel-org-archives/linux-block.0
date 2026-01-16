Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46445330B06
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573234; cv=none; b=V70D4tJDjbLp5ixmqja8t4ZUtFb9/xVfxk3uSIUSFQcBDb0G31C6zGpZeskLWha4EfHQbYkhyd/QWSEv4RVILFYVJXiWRfkiByGAT/RjQuR8FGUmVm72jnew5JEvROtJJzzEl9OC/G9SpkehKhQBv6jBNt4rY4NKwHjjtYVo4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573234; c=relaxed/simple;
	bh=b3T4sYd8YReIhizxWwC9hIfdXls4hIPiFdvGqYk5v8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOni0ptv00ZDPX4tpa5z9SDRXsIakYlK192ff+bYy01h8qPBj1sUSfhe5E3F7CnRow8XjdH1OpADT/AaWoCoS9w8k+qW2x03cTdW98Lhu8pz/9OLu1BHR9j4erk1QWs3ATwC+uEMqy+nxzIctA5N396XuZ3oBGswKaSkh1GPcmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POpAzroT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POpAzroT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBY63pGyaNJyjKSQR+Qz5/KdMXx7BEicskOXNL4/Iac=;
	b=POpAzroTKirqlKVnITxMmF6zbsoIqcBNIKxjpamMHMd971uhWUD15/sm+AUpyoBtDa1HDd
	umD7TbYZqdibsKLdJorNP6f8bhAbCHSWr+WcWWQC8nizduCS7Wch8iAbD5HGPpO2/LvCjk
	ZzEYnJaGqEpQXSBBWmYEZXCzDxLkrtM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-7L9-IFhSOemde-fW9MmLHg-1; Fri,
 16 Jan 2026 09:20:25 -0500
X-MC-Unique: 7L9-IFhSOemde-fW9MmLHg-1
X-Mimecast-MFC-AGG-ID: 7L9-IFhSOemde-fW9MmLHg_1768573224
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C8EA1955F34;
	Fri, 16 Jan 2026 14:20:24 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B0B9180049F;
	Fri, 16 Jan 2026 14:20:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 16/24] selftests: ublk: replace assert() with ublk_assert()
Date: Fri, 16 Jan 2026 22:18:49 +0800
Message-ID: <20260116141859.719929-17-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index d9873d4d50d0..530f9877c9dd 100644
--- a/tools/testing/selftests/ublk/common.c
+++ b/tools/testing/selftests/ublk/common.c
@@ -16,7 +16,7 @@ int backing_file_tgt_init(struct ublk_dev *dev, unsigned int nr_direct)
 {
 	int fd, i;
 
-	assert(dev->nr_fds == 1);
+	ublk_assert(dev->nr_fds == 1);
 
 	for (i = 0; i < dev->tgt.nr_backing_files; i++) {
 		char *file = dev->tgt.backing_file[i];
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index c3ce5ff72422..889047bd8fa3 100644
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
index cdd5434a6147..08ba094df64d 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -825,7 +825,7 @@ static void ublk_handle_uring_cmd(struct ublk_thread *t,
 	}
 
 	if (cqe->res == UBLK_IO_RES_OK) {
-		assert(tag < q->q_depth);
+		ublk_assert(tag < q->q_depth);
 
 		if (ublk_queue_use_user_copy(q))
 			ublk_user_copy(io, UBLK_IO_OP_WRITE);
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 69fd5794f300..48634d29c084 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -260,7 +260,7 @@ static inline __u64 build_user_data(unsigned tag, unsigned op,
 {
 	/* we only have 7 bits to encode q_id */
 	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
-	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
+	ublk_assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
 
 	return tag | ((__u64)op << 16) | ((__u64)tgt_data << 24) |
 		(__u64)q_id << 56 | (__u64)is_target_io << 63;
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 2be1c36438e7..b967447fe591 100644
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
@@ -322,7 +322,7 @@ static int ublk_stripe_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
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


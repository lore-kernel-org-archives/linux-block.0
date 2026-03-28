Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261B140DFA3
	for <linux-block@vger.kernel.org>; Sat, 28 Mar 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705796; cv=none; b=O6KH9QbVrbGAEbsEpjQIGlgBs/EYxtp1mrkWn3F7V2AmZI5AIvhgMmWNqSqBPgQjcz1wa1aTnZFcEnZyMNOPaYgvJAp/vPTCAkOxCmiSi4SYo6a5qjXvejJ0/PlW9UvHTaWeYqvRlx97C59TsilaovIgLZQWLhlyf7YGlFYJWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705796; c=relaxed/simple;
	bh=k1Vl+40mAdiZtNSilwUn86HiAsyc7sJc+uHQiBVAzrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5I0x4FpnhOBn28HBkonjmmED+Rjlc0NmtQqhdDZSCAdAhEdUnW06Og9q4Kx8d/DNcMHOzj/iitiZOilWCzOF/+xgLn27ZKD+iemHY2S0KD9vqXyBMK2kFVChQYV927C0Z9S6nHsBRr/dYG9BMD99au1LmHjAwibN/2gnCPd6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciu3GgKN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciu3GgKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774705794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXy5FHQ3tdWLg43w1qYNYdyjJSmNzPE5Qr9VQ6TCCDg=;
	b=ciu3GgKNmNcbl1NAUrRAlqTvjUY/mnDPpIVwdy1Md1rwwEG+08F8rWPQdr7sEVIBKGREPW
	YW7tK2JkoS14WIUfpzJ8lPHLjy5PeevwtU8GctvfVZflCr9TS3AGtPbsQsYAvfEGS8g9Ch
	beyTXL0sfW3HprrRhwy7aQyv3XYxOoM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-Pv5JMiRrNOis8QfewH0ofA-1; Sat,
 28 Mar 2026 09:49:50 -0400
X-MC-Unique: Pv5JMiRrNOis8QfewH0ofA-1
X-Mimecast-MFC-AGG-ID: Pv5JMiRrNOis8QfewH0ofA_1774705789
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85C3918005B0;
	Sat, 28 Mar 2026 13:49:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6D4030001A1;
	Sat, 28 Mar 2026 13:49:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/8] selftests/ublk: add UBLK_F_SHMEM_ZC support for loop target
Date: Sat, 28 Mar 2026 21:49:00 +0800
Message-ID: <20260328134909.3207377-6-ming.lei@redhat.com>
In-Reply-To: <20260328134909.3207377-1-ming.lei@redhat.com>
References: <20260328134909.3207377-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add loop_queue_shmem_zc_io() which handles I/O requests marked with
UBLK_IO_F_SHMEM_ZC. When the kernel sets this flag, the request data
lives in a registered shared memory buffer — decode index + offset
from iod->addr and use the server's mmap as the I/O buffer.

The dispatch check in loop_queue_tgt_rw_io() routes SHMEM_ZC requests
to this new function, bypassing the normal buffer registration path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/file_backed.c | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 228af2580ac6..d28da98f917a 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -27,6 +27,40 @@ static int loop_queue_flush_io(struct ublk_thread *t, struct ublk_queue *q,
 	return 1;
 }
 
+/*
+ * Shared memory zero-copy I/O: when UBLK_IO_F_SHMEM_ZC is set, the
+ * request's data lives in a registered shared memory buffer. Decode
+ * index + offset from iod->addr and use the server's mmap of that
+ * buffer as the I/O buffer for the backing file.
+ */
+static int loop_queue_shmem_zc_io(struct ublk_thread *t, struct ublk_queue *q,
+				  const struct ublksrv_io_desc *iod, int tag)
+{
+	unsigned ublk_op = ublksrv_get_op(iod);
+	enum io_uring_op op = ublk_to_uring_op(iod, 0);
+	__u64 file_offset = iod->start_sector << 9;
+	__u32 len = iod->nr_sectors << 9;
+	__u32 shmem_idx = ublk_shmem_zc_index(iod->addr);
+	__u32 shmem_off = ublk_shmem_zc_offset(iod->addr);
+	struct io_uring_sqe *sqe[1];
+	void *addr;
+
+	if (shmem_idx >= UBLK_BUF_MAX || !shmem_table[shmem_idx].mmap_base)
+		return -EINVAL;
+
+	addr = shmem_table[shmem_idx].mmap_base + shmem_off;
+
+	ublk_io_alloc_sqes(t, sqe, 1);
+	if (!sqe[0])
+		return -ENOMEM;
+
+	io_uring_prep_rw(op, sqe[0], ublk_get_registered_fd(q, 1),
+			 addr, len, file_offset);
+	io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
+	sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
+	return 1;
+}
+
 static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 				const struct ublksrv_io_desc *iod, int tag)
 {
@@ -41,6 +75,10 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	void *addr = io->buf_addr;
 	unsigned short buf_index = ublk_io_buf_idx(t, q, tag);
 
+	/* shared memory zero-copy path */
+	if (iod->op_flags & UBLK_IO_F_SHMEM_ZC)
+		return loop_queue_shmem_zc_io(t, q, iod, tag);
+
 	if (iod->op_flags & UBLK_IO_F_INTEGRITY) {
 		ublk_io_alloc_sqes(t, sqe, 1);
 		/* Use second backing file for integrity data */
-- 
2.53.0


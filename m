Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A323EA8A
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401142; cv=none; b=Sgi7c3OjwcmxKbjcKnSx3LVb248MLCvKflFLnVH3vcfb9IY/QtAe4RBXWgfy8D0efIdpQYJtHIwaeZcsPKNKfT8NnjJ6ui/7061jHkAd/SPBgaqDnN55sDQ/JeQ4cDh6pWgkSsR6NEC8uxP5pFrIxaXwuKUHo+ZRiH0QwiEoPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401142; c=relaxed/simple;
	bh=QxssRt2K7/arHhwAENIHPr/xs0l3C9sgNhJ+s1tkF+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kp/410+CyPgkZeN+/M9bkW/oPnGiL6gu/VInOeBoMBruIzuNCKs3oQLJYoyWb2Zh+0aQwWRsOc3+VYd03dnryqJfznzIrLfqJMdUKqsouxhpt2BTBR9nSCwMzR/ntq8xITBLRjdNueQAwfZrFUO9vVjQxTHv528W2Kx2P5KjzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Zj1owq0b; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Zj1owq0b"
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7ce2c1f423aso72179a34.2
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401135; x=1768005935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY6pKUQ5Qn3DxRwxGDGPj6r/MLXemuiieYvUhI1zlzM=;
        b=Zj1owq0bGskrbnSH51RVWb32S+ABTrOb9crYmb1Me//37C0M6PN06YUWz02qQl8UcE
         zom0vpXsQvj2ID+mloWR8xBIrH0ETzxePwKgrZkrbPSyX+9I2nFM/F7QDiK26gJOwUw5
         kuAM7en9rlJGa3HeA2uHKDS2BUru48ugUiuAf8bx8qmFaN81M3duW1i5h4TianGAPpT+
         +D2IZGM0YbwwwIe3zpSwG6ag9gktVIaGbB5RscICD3l4vU+yrp2Tmst9iYaK94RcKmoT
         owe1MC7Kn/MKGkjhCKR+iXsjoQSk1UbKkui25KGr5WUzHUO8S5g2Rs/LEUhMRlwxjEWM
         iCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401135; x=1768005935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tY6pKUQ5Qn3DxRwxGDGPj6r/MLXemuiieYvUhI1zlzM=;
        b=WZ0QQe/sAJrXhF6z8AwQCX04AF7nktqtKZl2w+KwHaC9lCpYOKATpdVrR2RsYpbjKm
         IyPLCXlZN4GbB2Q/SetbYp2aNHwNapdBSo7H+BBw2iOSJHyrcwVHbN6kMmbsy1G/t4UW
         byn5vLMK8EOUI5Ud7BnQNnOoZ1btdHGJmZSYkQYbJc2tF78l2yp9wR0HPezAy8xrKw5u
         p+rAbC4O2mUOrE3e3UB0a0OFEq+LGXeyyqgjI6nXZzEFtdcdTMXaQUyxsGMM7lfOzgf8
         VLuiqjFeYKmc7kZQWrUomfrtsDVFuOMakDGHBPbGZBQjqevbflnfCkLvL8e4dM6GSnSY
         fycg==
X-Gm-Message-State: AOJu0YzIu246OEBxiBdSRFUMGh1IhFCXqSqPY03BuIR5CGTCZuLaIC4k
	u1awMb/EsAkMbiMIKCSDJTEn1qcX7f0cOeYYflv0+qUMxdAMEXkWw4gbuO771uLtrSFmccpAuHC
	O/wQM3TuoQoxPJ9UMeCbdcwDysDbs0fmWRU1EPm43PycMDyzvtaNL
X-Gm-Gg: AY/fxX6t9dgiAr6NLYNcwPbZQ/OcbWr7zN9LF39t3T88ZRaozy8NpAi6hNqz8ERRmRl
	aGfA4W75P0a+J6V7SOtHBz3LeVJvWE9CQfRlejABrOR6rXLRW2ENvrG+kRF1mnBOl0aiB23L/PG
	x4CUWLprgPrH1b+Xq84n9hWQdfuuqtJtJmtWz8fpg+VXDiYdx+1X4vukuIuDBXfSf1qnFFXHuRj
	MU0w4qdLumo5FTeFm9uxt8Ox0zSPCWe6h/YQq0M07bKoBhjsoFQFybtWBCcgOkp0b75DSkw4bq5
	26Xh6ItulIk+u36Q4x+PcfhCDi0tXMtjyOwxEKf/ln4E6CIE8A10xduBEvL4QU2+zs1Ze0N6FPY
	PeZP/pjgXKnnRUS5K0RjCtohj7LE=
X-Google-Smtp-Source: AGHT+IFLwalgPrUnK/JshmelFKcHKKaza9UIJzmapQ5N39F9GOnFHGs1qG2AEw88mtSWG1HLbWTZUbhSO7Jr
X-Received: by 2002:a05:6830:314f:b0:7c7:66df:54df with SMTP id 46e09a7af769-7cc66a0b3b8mr17419979a34.5.1767401135279;
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7cc667ba104sm5572651a34.3.2026.01.02.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 756C2341FB6;
	Fri,  2 Jan 2026 17:45:34 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 734E8E4426F; Fri,  2 Jan 2026 17:45:34 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 15/19] selftests: ublk: implement integrity user copy in kublk
Date: Fri,  2 Jan 2026 17:45:25 -0700
Message-ID: <20260103004529.1582405-16-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If integrity data is enabled for kublk, allocate an integrity buffer for
each I/O. Extend ublk_user_copy() to copy the integrity data between the
ublk request and the integrity buffer if the ublksrv_io_desc indicates
that the request has integrity data.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 41 ++++++++++++++++++++++++----
 tools/testing/selftests/ublk/kublk.h | 14 ++++++++++
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 6ff110d0dcae..dfba808657b1 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -415,12 +415,14 @@ static void ublk_queue_deinit(struct ublk_queue *q)
 	int nr_ios = q->q_depth;
 
 	if (q->io_cmd_buf)
 		munmap(q->io_cmd_buf, ublk_queue_cmd_buf_sz(q));
 
-	for (i = 0; i < nr_ios; i++)
+	for (i = 0; i < nr_ios; i++) {
 		free(q->ios[i].buf_addr);
+		free(q->ios[i].integrity_buf);
+	}
 }
 
 static void ublk_thread_deinit(struct ublk_thread *t)
 {
 	io_uring_unregister_buffers(&t->ring);
@@ -432,23 +434,25 @@ static void ublk_thread_deinit(struct ublk_thread *t)
 		close(t->ring.ring_fd);
 		t->ring.ring_fd = -1;
 	}
 }
 
-static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags)
+static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags,
+			   __u8 metadata_size)
 {
 	struct ublk_dev *dev = q->dev;
 	int depth = dev->dev_info.queue_depth;
 	int i;
-	int cmd_buf_size, io_buf_size;
+	int cmd_buf_size, io_buf_size, integrity_size;
 	unsigned long off;
 
 	q->tgt_ops = dev->tgt.ops;
 	q->flags = 0;
 	q->q_depth = depth;
 	q->flags = dev->dev_info.flags;
 	q->flags |= extra_flags;
+	q->metadata_size = metadata_size;
 
 	/* Cache fd in queue for fast path access */
 	q->ublk_fd = dev->fds[0];
 
 	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
@@ -460,15 +464,27 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags)
 				q->dev->dev_info.dev_id, q->q_id);
 		goto fail;
 	}
 
 	io_buf_size = dev->dev_info.max_io_buf_bytes;
+	integrity_size = ublk_integrity_len(q, io_buf_size);
 	for (i = 0; i < q->q_depth; i++) {
 		q->ios[i].buf_addr = NULL;
 		q->ios[i].flags = UBLKS_IO_NEED_FETCH_RQ | UBLKS_IO_FREE;
 		q->ios[i].tag = i;
 
+		if (integrity_size) {
+			q->ios[i].integrity_buf = malloc(integrity_size);
+			if (!q->ios[i].integrity_buf) {
+				ublk_err("ublk dev %d queue %d io %d malloc(%d) failed: %m\n",
+					 dev->dev_info.dev_id, q->q_id, i,
+					 integrity_size);
+				goto fail;
+			}
+		}
+
+
 		if (ublk_queue_no_buf(q))
 			continue;
 
 		if (posix_memalign((void **)&q->ios[i].buf_addr,
 					getpagesize(), io_buf_size)) {
@@ -607,17 +623,17 @@ static void ublk_user_copy(const struct ublk_io *io, __u8 match_ublk_op)
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, io->tag);
 	__u64 off = ublk_user_copy_offset(q->q_id, io->tag);
 	__u8 ublk_op = ublksrv_get_op(iod);
 	__u32 len = iod->nr_sectors << 9;
 	void *addr = io->buf_addr;
+	ssize_t copied;
 
 	if (ublk_op != match_ublk_op)
 		return;
 
 	while (len) {
 		__u32 copy_len = min(len, UBLK_USER_COPY_LEN);
-		ssize_t copied;
 
 		if (ublk_op == UBLK_IO_OP_WRITE)
 			copied = pread(q->ublk_fd, addr, copy_len, off);
 		else if (ublk_op == UBLK_IO_OP_READ)
 			copied = pwrite(q->ublk_fd, addr, copy_len, off);
@@ -626,10 +642,24 @@ static void ublk_user_copy(const struct ublk_io *io, __u8 match_ublk_op)
 		assert(copied == (ssize_t)copy_len);
 		addr += copy_len;
 		off += copy_len;
 		len -= copy_len;
 	}
+
+	if (!(iod->op_flags & UBLK_IO_F_INTEGRITY))
+		return;
+
+	len = ublk_integrity_len(q, iod->nr_sectors << 9);
+	off = ublk_user_copy_offset(q->q_id, io->tag);
+	off += UBLKSRV_IO_INTEGRITY_FLAG;
+	if (ublk_op == UBLK_IO_OP_WRITE)
+		copied = pread(q->ublk_fd, io->integrity_buf, len, off);
+	else if (ublk_op == UBLK_IO_OP_READ)
+		copied = pwrite(q->ublk_fd, io->integrity_buf, len, off);
+	else
+		assert(0);
+	assert(copied == (ssize_t)len);
 }
 
 int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 {
 	struct ublk_queue *q = ublk_io_to_queue(io);
@@ -1012,11 +1042,12 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	for (i = 0; i < dinfo->nr_hw_queues; i++) {
 		dev->q[i].dev = dev;
 		dev->q[i].q_id = i;
 
-		ret = ublk_queue_init(&dev->q[i], extra_flags);
+		ret = ublk_queue_init(&dev->q[i], extra_flags,
+				      ctx->metadata_size);
 		if (ret) {
 			ublk_err("ublk dev %d queue %d init queue failed\n",
 				 dinfo->dev_id, i);
 			goto fail;
 		}
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index d00f2b465cdf..830b49a7716a 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -110,10 +110,11 @@ struct ublk_ctrl_cmd_data {
 	__u32 len;
 };
 
 struct ublk_io {
 	char *buf_addr;
+	void *integrity_buf;
 
 #define UBLKS_IO_NEED_FETCH_RQ		(1UL << 0)
 #define UBLKS_IO_NEED_COMMIT_RQ_COMP	(1UL << 1)
 #define UBLKS_IO_FREE			(1UL << 2)
 #define UBLKS_IO_NEED_GET_DATA           (1UL << 3)
@@ -173,10 +174,11 @@ struct ublk_queue {
 /* borrow one bit of ublk uapi flags, which may never be used */
 #define UBLKS_Q_AUTO_BUF_REG_FALLBACK	(1ULL << 63)
 #define UBLKS_Q_NO_UBLK_FIXED_FD	(1ULL << 62)
 	__u64 flags;
 	int ublk_fd;	/* cached ublk char device fd */
+	__u8 metadata_size;
 	struct ublk_io ios[UBLK_QUEUE_DEPTH];
 };
 
 struct ublk_thread {
 	struct ublk_dev *dev;
@@ -222,10 +224,22 @@ static inline void ublk_set_integrity_params(const struct dev_ctx *ctx,
 		.csum_type = ctx->csum_type,
 		.tag_size = ctx->tag_size,
 	};
 }
 
+static inline size_t ublk_integrity_len(const struct ublk_queue *q, size_t len)
+{
+	/* All targets currently use interval_exp = logical_bs_shift = 9 */
+	return (len >> 9) * q->metadata_size;
+}
+
+static inline size_t
+ublk_integrity_data_len(const struct ublk_queue *q, size_t integrity_len)
+{
+	return (integrity_len / q->metadata_size) << 9;
+}
+
 static inline int ublk_io_auto_zc_fallback(const struct ublksrv_io_desc *iod)
 {
 	return !!(iod->op_flags & UBLK_IO_F_NEED_REG_BUF);
 }
 
-- 
2.45.2


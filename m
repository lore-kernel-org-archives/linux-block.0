Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA422877C3
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949721; cv=none; b=DxOTsIYIi6pmrfURg5jeR7SBkEkc6F4WCXqsPfiu6onPIgSQVumNUYghHOa/0KQlG2VYZWWwqouxwzpE9/VVjXLN56BgyQuoLwLvGs2uXMCvmxuza0RyJaVxqWUol6fW2VQVK7sXvTWOaSfvio3slllcRyJEqPY0QOOwAgxTcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949721; c=relaxed/simple;
	bh=QYvJIqKQumt8IfNUlGMFrE3ehe8qSD246lkZ1mH3XeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs8mrwRo6rePa86FZKEjJa8obxou3L2XDwSPv2wKyRcNlC0ZIHAn/WMDdARGUudOYysvFV2E4OxS5LocwQIqPcYsvAtaw5Etv/BQUuJ3gRkwdYm1TZkz2hW2CZGurgTM0nppcOuyEoDTQ/NhpCdfUCYMU+fPBbDAZEp5nzbXMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IlgTXx2p; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IlgTXx2p"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-34c567db0a9so448952a91.1
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949714; x=1766554514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkZMs1mdCQoeDbmGUZO0BOuHaVJQ2pa1P9n9bwg3xLI=;
        b=IlgTXx2pT1nJrJBX0JuYDd0KfTQteJ7TP+NfSsy/ESars3P0SU4LLZkv1FO2Sa45D3
         T9UtIHkWxNL/0pI/TIqpqRczFgf9oSB3AEeUknNLGcvX5MxZnuB2Otwz3ZigaykA9zKg
         dFS+EEqJnlB3Vy8qsspzRK5Zl+e/H5ksTybY5d1WX7LsIfnBaKG1NRPdDc0lE56aUqbW
         iyhHL5vJGNxo6Tk7AwLDCMugCe9cIeRTCT6xBXH1TvbmP0zIr69kNdwDfoHlIgAEG3C5
         Dej92RsV1UA3cMdWzuDFfj+FSlhCHa3oVxmta0B5jK/KSPygTgHsao5BXjAT/upLpVqI
         c6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949714; x=1766554514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BkZMs1mdCQoeDbmGUZO0BOuHaVJQ2pa1P9n9bwg3xLI=;
        b=HOaMFW2+5zrWQMf7sfqbRzHzGg6NR0Ye13rpzU6QtYzXyy0m2P9THGZ+kG+H+DqhHV
         4Gk6aCwGCvcN0z3ScdbjtfucE0lvHDuVJhTCN9iSX4DqYiDSCbarPKcHuahHydK3cNQH
         PUM4f2T+OOH0JeC9XU08gzEXWXupXmgltfAOs2aGog4BIlLwcXLkbvGyEBHm8AxAKwNY
         SdzVonV4JbAjaXFaDu7i0oS1JilHWPXdyW+P87FhXwjnEEMJKyG95384W6r2i48sA+lw
         /HpALgp9c0WiPkYoTQFX+D5s53NGZAGutEFouV6SiAG/pDqcYVjXNNbDlHqTRDJ3gkSV
         8A3A==
X-Gm-Message-State: AOJu0Yy3ApSViWS7TNYMgDWCBOH1iBB5rkDPnX1xWvqSWT31JMsNCO1O
	tPOQGS16dLmv6XcUynLz7ifBD+3Fll+LghPa2rGkKaIXSJ1aQeoyywlgUGwRDq80L6q0rurKnOp
	B9eKU6HOl+7VuiOkI4IsoqRgIOSSGaRnB2C55
X-Gm-Gg: AY/fxX7D4eJkLjbB7hMpX891GCeHnaDY3zHcaQ3D1wFMfLuEl8XOMGYeUGPVmS32m8K
	5QYoJZ4Cz9MmsnRMLJxMhYNqAT91xAROQ+H7KZEJReJ/6cr05P63fw+oU5BQ9RxIxJ0r77M075+
	dC/L4NtWcTAaDdDH7prsAxG5rMeOz6hGYgvbKo6cEmJ5iwufzgsdlIYLQSQ1ZKEvNsVdHMjRTOU
	hDgN4aYy6UXjSX2BdQ4qMJG7OZesXLTguKeVwLuQ+VTtTBeLECWBi32N92RckQQ09A4J5Bmmm8L
	xwe4C43RubZeJDV//VkLFHQvRba2ynfbzDYrW8hFVSnXNgN4k9h+AhH03qKiMm74ikil+1G4BvT
	5cWIpG0zF/DKv4X1as2xVBTeMxRINGi2yWnxChvVUCQ==
X-Google-Smtp-Source: AGHT+IFf3eCE3H35adlG4cypwURDwiWp8Kq8fvpd2S11DVDwpXDLJOrhZXH633pkG1vE1diVe8wO4CztiHo0
X-Received: by 2002:a17:90b:3b50:b0:340:e0f3:8212 with SMTP id 98e67ed59e1d1-34abd90f7a1mr11451532a91.8.1765949713817;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34cfd70ed09sm240678a91.4.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4644F34222B;
	Tue, 16 Dec 2025 22:35:13 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 43F5AE41A08; Tue, 16 Dec 2025 22:35:13 -0700 (MST)
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
Subject: [PATCH 16/20] selftests: ublk: implement integrity user copy in kublk
Date: Tue, 16 Dec 2025 22:34:50 -0700
Message-ID: <20251217053455.281509-17-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
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
index cf58d3b60ace..a5c0e4ff9e2a 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -414,12 +414,14 @@ static void ublk_queue_deinit(struct ublk_queue *q)
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
@@ -431,23 +433,25 @@ static void ublk_thread_deinit(struct ublk_thread *t)
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
@@ -459,15 +463,27 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags)
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
@@ -606,17 +622,17 @@ static void ublk_user_copy(const struct ublk_io *io, __u8 match_ublk_op)
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
@@ -625,10 +641,24 @@ static void ublk_user_copy(const struct ublk_io *io, __u8 match_ublk_op)
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
@@ -1011,11 +1041,12 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
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


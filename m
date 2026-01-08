Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A742A138
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864018; cv=none; b=Er+jpT+WlJbxM4hosflS1K4rmy0Hsse7BhmHczROh8Icyv/Ht+yPhxOR+qvnVeqwg3V+oDS0hUuxHdImMzjEsF/Qr1MPwEcSoQE6DzmOQ9+Wzxzs2ABsgqJpi9zRR0u8fYJvK/48Qrsmyfzav5wQ+Csbzd0vC9EjuOf9y6xsTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864018; c=relaxed/simple;
	bh=PYR08W40/J30Uw4DWWLkIxEtDB9g/2yC7I4O3sJe70M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQ8W6Ge0GGRyN1yYb+Pno37wSjyqNtJw9mGhM8pOxjZrNO1j1f6kie+yXFoZGbjE3d30WHGVkc+hRjbbxbrCPuWgLDFJUZCjLYyF9KHuRUXno0fVm7JFjp/jAGaf8Jcwpe4NnfS1EMRfu8tzRAU+dEF1hkmRf4E6VcbxzABikI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=boc4zKjv; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="boc4zKjv"
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7cad1c329e1so340515a34.0
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4dNygcFsf69pYwDfjtmZx9c023kPrtza431gN8HzKY=;
        b=boc4zKjvkMHuta2U4EDiWeexDCwJIurp42RW00t1OWQZQer/wDfZiJcfP/3hCzbWqq
         pYZLfFpqPQSrZxaMS4YlM4/dm2QdCUuU14Ya6/EBNL3rbSA6HGRrBP+JWCWzeUPAaCSk
         Y4e8xzPj1KlcAH68x+VSAO2SM1NC0Np6bwJdfaZm59hLsFwavEQnzG2xb2i+L1VWabYL
         rSJpJKwuLy+YVV/NoBX7DPw8T5c49x2lk1EVB/zdJiwq65pwRHhMFmsgUZ5U+6/WxkTy
         P/P4JX+ycz8ENLxFFCmlB3IhisVXn0RcdL74U9q9gKrTk5JhJgbF+DujMOY2bzmg2yTY
         PFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4dNygcFsf69pYwDfjtmZx9c023kPrtza431gN8HzKY=;
        b=jfM3Rz72+FvqZX1JHQCuwtZG5EESUFZqETGK4lXsI3/3Sc4IffG8NAsFG3KZyI0Dx0
         xuqi056h7JzXafx9Vh6GDiYc2mHfbshTpcKsyaypYS2jtVJWRDIhfIRVoqBgftOjzYJt
         wRcPGdTMv+yXKyKFYW9+cUm46eo8dRV36QGG1afcEm0qKcZsO8ZHa4ggvST7lLjSwqd/
         OT4vUbWsKgvA0UaCV/5XJjYZp+/aJdTyp+iFpk/8vBNIk8V9bjxpMyO5mMmSWvL1qrog
         P/qCx9ylxIiehjbTWO1/4Nm5r/3qpAFXqbPyTZebDBcO+7e8wHrR4quyJbyggRBSAqGJ
         iL8g==
X-Gm-Message-State: AOJu0YzhW4LNouwpD5JV72T7IO2YtTZKvNZPuCscDRSbPsgNz/7hmeEJ
	9MiQ+TGjwQeY5i63wReO0X40PWNcETgyFk6Cjo1/5frLTZ//ooTdt1+grxjFLtJw5S3L9WphVX0
	6vw2LQLMT0Q9A5isXpZMHHdVrDkfowtrWa4khV/F+1QXAj/R8Pb6i
X-Gm-Gg: AY/fxX6SEtsu5oIk/HCGjgdrDnM84YNdn2xukuEybCQM+V8dhHOp+WJo/AlUEaJ0VaZ
	PcOt57+/ZJjW8jr0a/rtbgjX+DDBi1PLr6AmH7VdCitZWzGRWBKx/glcYQ3shAeagzQ66IUdRiY
	G7iIu/T1wLkCSXNxORML+BDQkIGrajoL17hD9GN/1MjgX4QJtV6zSxuql4Wnn3hQZQkvDO9FRs7
	XWxUgZwBNB1jM63ag5/zMiRnULwU9tGxpfdR562cOe8bWVKVINb7Nh6yFq1nRfQsPsCa5z41LWr
	NguegpjsPOziMVk3ubiVMQD+QjNK/LjzsN4bbYG6bYrFzvmNica9XoHXQnZsMHoq9Vb+XxuTj7r
	E8+T9dplTLXyDMlETYslx5mNmc1c=
X-Google-Smtp-Source: AGHT+IE8vzIcJ7b2EVI6xioVR0YDv6im/CUXaHmBC9ImARUa6pNYVRq+Ibdc4NVSlMwz8Zi3/BhKwfIjNala
X-Received: by 2002:a05:6830:4492:b0:7c7:6323:223d with SMTP id 46e09a7af769-7ce50bb15f2mr2379877a34.5.1767863997473;
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7ce47632961sm984933a34.0.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 563393400C1;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 50F93E42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 09/19] ublk: implement integrity user copy
Date: Thu,  8 Jan 2026 02:19:37 -0700
Message-ID: <20260108091948.1099139-10-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Zhang <stazhang@purestorage.com>

Add a function ublk_copy_user_integrity() to copy integrity information
between a request and a user iov_iter. This mirrors the existing
ublk_copy_user_pages() but operates on request integrity data instead of
regular data. Check UBLKSRV_IO_INTEGRITY_FLAG in iocb->ki_pos in
ublk_user_copy() to choose between copying data or integrity data.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: change offset units from data bytes to integrity data bytes,
 fix CONFIG_BLK_DEV_INTEGRITY=n build, rebase on user copy refactor]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c      | 53 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  4 +++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8eefb838b563..2a8a6a9c0281 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1052,10 +1052,37 @@ static size_t ublk_copy_user_pages(const struct request *req,
 			break;
 	}
 	return done;
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static size_t ublk_copy_user_integrity(const struct request *req,
+		unsigned offset, struct iov_iter *uiter, int dir)
+{
+	size_t done = 0;
+	struct bio *bio = req->bio;
+	struct bvec_iter iter;
+	struct bio_vec iv;
+
+	if (!blk_integrity_rq(req))
+		return 0;
+
+	bio_for_each_integrity_vec(iv, bio, iter) {
+		if (!ublk_copy_user_bvec(&iv, &offset, uiter, dir, &done))
+			break;
+	}
+
+	return done;
+}
+#else /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
+static size_t ublk_copy_user_integrity(const struct request *req,
+		unsigned offset, struct iov_iter *uiter, int dir)
+{
+	return 0;
+}
+#endif /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
+
 static inline bool ublk_need_map_req(const struct request *req)
 {
 	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
 }
 
@@ -2659,10 +2686,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 {
 	struct ublk_device *ub = iocb->ki_filp->private_data;
 	struct ublk_queue *ubq;
 	struct request *req;
 	struct ublk_io *io;
+	unsigned data_len;
+	bool is_integrity;
 	size_t buf_off;
 	u16 tag, q_id;
 	ssize_t ret;
 
 	if (!user_backed_iter(iter))
@@ -2672,10 +2701,14 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 		return -EACCES;
 
 	tag = ublk_pos_to_tag(iocb->ki_pos);
 	q_id = ublk_pos_to_hwq(iocb->ki_pos);
 	buf_off = ublk_pos_to_buf_off(iocb->ki_pos);
+	is_integrity = !!(iocb->ki_pos & UBLKSRV_IO_INTEGRITY_FLAG);
+
+	if (unlikely(!ublk_dev_support_integrity(ub) && is_integrity))
+		return -EINVAL;
 
 	if (q_id >= ub->dev_info.nr_hw_queues)
 		return -EINVAL;
 
 	ubq = ublk_get_queue(ub, q_id);
@@ -2688,21 +2721,31 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 	io = &ubq->ios[tag];
 	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
-	if (buf_off > blk_rq_bytes(req)) {
+	if (is_integrity) {
+		struct blk_integrity *bi = &req->q->limits.integrity;
+
+		data_len = bio_integrity_bytes(bi, blk_rq_sectors(req));
+	} else {
+		data_len = blk_rq_bytes(req);
+	}
+	if (buf_off > data_len) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (!ublk_check_ubuf_dir(req, dir)) {
 		ret = -EACCES;
 		goto out;
 	}
 
-	ret = ublk_copy_user_pages(req, buf_off, iter, dir);
+	if (is_integrity)
+		ret = ublk_copy_user_integrity(req, buf_off, iter, dir);
+	else
+		ret = ublk_copy_user_pages(req, buf_off, iter, dir);
 
 out:
 	ublk_put_req_ref(io, req);
 	return ret;
 }
@@ -3939,10 +3982,16 @@ static int __init ublk_init(void)
 {
 	int ret;
 
 	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
 			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
+	/*
+	 * Ensure UBLKSRV_IO_BUF_OFFSET + UBLKSRV_IO_BUF_TOTAL_SIZE
+	 * doesn't overflow into UBLKSRV_IO_INTEGRITY_FLAG
+	 */
+	BUILD_BUG_ON(UBLKSRV_IO_BUF_OFFSET + UBLKSRV_IO_BUF_TOTAL_SIZE >=
+		     UBLKSRV_IO_INTEGRITY_FLAG);
 	BUILD_BUG_ON(sizeof(struct ublk_auto_buf_reg) != 8);
 
 	init_waitqueue_head(&ublk_idr_wq);
 
 	ret = misc_register(&ublk_misc);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index dfde4aee39eb..61ac5d8e1078 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -132,10 +132,14 @@
 #define UBLK_MAX_NR_QUEUES	(1U << UBLK_QID_BITS)
 
 #define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_QID_OFF + UBLK_QID_BITS)
 #define UBLKSRV_IO_BUF_TOTAL_SIZE	(1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
 
+/* Copy to/from request integrity buffer instead of data buffer */
+#define UBLK_INTEGRITY_FLAG_OFF 62
+#define UBLKSRV_IO_INTEGRITY_FLAG (1ULL << UBLK_INTEGRITY_FLAG_OFF)
+
 /*
  * ublk server can register data buffers for incoming I/O requests with a sparse
  * io_uring buffer table. The request buffer can then be used as the data buffer
  * for io_uring operations via the fixed buffer index.
  * Note that the ublk server can never directly access the request data memory.
-- 
2.45.2


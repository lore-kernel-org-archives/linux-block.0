Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88D217723
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661094; cv=none; b=KreCAD9ZGTmPBrHaFPCDiR0z6vj3f8DDeL3VxIxj0fHI0UAtijTk8xmyhLCvGaYk3PZw7R669qIxrWegydJjPW1o3yGLeymen57JN6Y/sV0mw4ERQXsYg0kOJqD6Y4t88X8tQ0Du0F0SZ2yZD1qq074n3OiotF2NWmJRo6jpFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661094; c=relaxed/simple;
	bh=xI89Y0UESRzV7tCSwJWx+i0xjvdVKZSHY47DVEXvuc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGIBARwDyMD4N61AMzrirBT1sV95C03yY8e2Ip7WCGsjGA5y/KWYU/n87Wy4wkciSQH9bHpc3Mp/tPsNab8Qf7YcvbVPchbK+IkhqhQJ1KD+UEW0JGWrRcs5inSeB2SYjq4arIwXsu9lO/TBxCdIBG8ISdviEpPe6p9OCfLcs8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RA3s9FP4; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RA3s9FP4"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-34ce100aec4so47865a91.0
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661090; x=1768265890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5WtyN5MsAWspncV9EuzMpRvjHYlriGJC1AoztcB8GY=;
        b=RA3s9FP4qbQIUH78/O+VcKqm4a5bVrJ+5ItTGBeWMRnj32vtwzyC6XrmDcmutINaZK
         hcL5XZeFq7PVHbbt7rmXz7wQONlrdgR3DHkR8fn69yBYyEdxr0j5wsKSSCcSCatZSVZ8
         kFpdlB0nkj5oRWU8tLHR1lWcGMYr3Y/Z+VYXA+LKjDR3mk/ayDOu0IAhlGXMWNpZY8gB
         RZ8OdYYixjzaM7LGq/tetC8r9HwTByET/tDdQCp5JSMVQvy7OK413wDG7sTj4i4UcpWh
         XP2GyXWL8dxdTV+wMHlWcyMquzNtmUmsdU7k67337iceI8jUtqhUYp9laHelaaKAHCTf
         6/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661090; x=1768265890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5WtyN5MsAWspncV9EuzMpRvjHYlriGJC1AoztcB8GY=;
        b=d0CduYQXpZc1oOYjZM7XOox2ztcnDc6ZmZk3BCV2ZeaMn7c+qb8xy67cYJC9QnbGSq
         334bIfPoBfAPa3pQxqY1InaeX3D3/n/ZpdMdslC0MlsYOGeoBWXnpEgHPA4MRs+Q/5yB
         p2IPyMIstY9fFgqNRIDs/khDnJZqGJqZ3fOzrmgHvFgQYXeUm4FBJdvORpJ1Q81TQO+c
         9uhsKg7awbhyPkS+M/MBEQxs180H3a5WFSZCxFvpthSnl/XORPEMVMtNFjWpL/TXzv6s
         P1GF2xTexgBZOYrhEalYbDeTqI1H10hbVdbJUdWUSJ9xsivj8pNOkgRoVlVHViq9oL4k
         itNQ==
X-Gm-Message-State: AOJu0YzcOam1Q1XoycTcTBJRaj429Y7GmTrcvFW/9Hb9RiIsnJh01Gwf
	47/eoP18BC+9tJtfGV7uqLTszXA7ViktKazRFzM1yIyT87aQKplUZUPbnr5yu/wpJdeE3V3aRbB
	K4UD1277ZxGaZD5hF0S2WnDlxCu1CTqo2Oeu1
X-Gm-Gg: AY/fxX4b/wLHEtXHzcxkOXJYvP1/4W5RRfVFoWg7eEAgYJS/YLUnyGgkxGLorPbYzgL
	+KGdx1AV+93WILy3JUeus7fjGvhHGzkdBfNCa//F3mYhx4XPXpdlf2zBB9WjaRJDiZf6QgJsz1x
	iFqBzhNqfZY4993Hl/teThAzFOpOiLbjPRCraJoEiKgGIKNe+v17DLMqEWJhI9yG7JoF/JUl/SV
	fo+nYtLayAyTI71uKfTdZB5y8D+Fw5ifAYy0xyFBtY/KJo3PVTgugH6p4WuvH6pF11E9g186pkW
	BpZEsbRb47QJCeePYLX2PuWpUTxgYABJDh88BRPU5kQdDnd47lipzsoXZdV8mRvVUbO5WU0D0jd
	7Z9A4PVxY4rou3lJ5Ia8+lhrRS+1co4LW2DNg8r3yjA==
X-Google-Smtp-Source: AGHT+IG66CjSrePDUFm1N50wGyBn1nWaPV8X4h+eDeNSeDwLvhsLOR7VdKSvTury/IVn31U02aQEdn3dggnf
X-Received: by 2002:a17:90a:d00b:b0:340:29cd:dce with SMTP id 98e67ed59e1d1-34f5f367e4emr600795a91.8.1767661090076;
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5f836d18sm106529a91.2.2026.01.05.16.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 85E9A3421AE;
	Mon,  5 Jan 2026 17:58:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 77764E44554; Mon,  5 Jan 2026 17:58:09 -0700 (MST)
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
Subject: [PATCH v3 09/19] ublk: implement integrity user copy
Date: Mon,  5 Jan 2026 17:57:41 -0700
Message-ID: <20260106005752.3784925-10-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
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
 test UBLKSRV_IO_INTEGRITY_FLAG after subtracting UBLKSRV_IO_BUF_OFFSET,
 fix CONFIG_BLK_DEV_INTEGRITY=n build,
 rebase on ublk user copy refactor]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c      | 52 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  4 +++
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e44ab9981ef4..9694a4c1caa7 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -621,10 +621,15 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
 {
 	return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
 		UBLK_TAG_BITS_MASK;
 }
 
+static inline bool ublk_pos_is_integrity(loff_t pos)
+{
+	return !!((pos - UBLKSRV_IO_BUF_OFFSET) & UBLKSRV_IO_INTEGRITY_FLAG);
+}
+
 static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 {
 	const struct ublk_param_basic *p = &ub->params.basic;
 
 	if (p->attrs & UBLK_ATTR_READ_ONLY)
@@ -1047,10 +1052,37 @@ static size_t ublk_copy_user_pages(const struct request *req,
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
 
@@ -2654,10 +2686,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
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
@@ -2667,10 +2701,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 		return -EACCES;
 
 	tag = ublk_pos_to_tag(iocb->ki_pos);
 	q_id = ublk_pos_to_hwq(iocb->ki_pos);
 	buf_off = ublk_pos_to_buf_off(iocb->ki_pos);
+	is_integrity = ublk_pos_is_integrity(iocb->ki_pos);
 
 	if (q_id >= ub->dev_info.nr_hw_queues)
 		return -EINVAL;
 
 	ubq = ublk_get_queue(ub, q_id);
@@ -2683,21 +2718,31 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
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
@@ -3931,11 +3976,12 @@ static struct miscdevice ublk_misc = {
 static int __init ublk_init(void)
 {
 	int ret;
 
 	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
-			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
+			UBLKSRV_IO_BUF_TOTAL_SIZE +
+			UBLKSRV_IO_INTEGRITY_FLAG < UBLKSRV_IO_BUF_OFFSET);
 	BUILD_BUG_ON(sizeof(struct ublk_auto_buf_reg) != 8);
 
 	init_waitqueue_head(&ublk_idr_wq);
 
 	ret = misc_register(&ublk_misc);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index c1103ad5925b..3af7e3684834 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -132,10 +132,14 @@
 #define UBLK_MAX_NR_QUEUES	(1U << UBLK_QID_BITS)
 
 #define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_QID_OFF + UBLK_QID_BITS)
 #define UBLKSRV_IO_BUF_TOTAL_SIZE	(1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
 
+/* Copy to/from request integrity buffer instead of data buffer */
+#define UBLK_INTEGRITY_FLAG_OFF UBLKSRV_IO_BUF_TOTAL_BITS
+#define UBLKSRV_IO_INTEGRITY_FLAG (1ULL << UBLK_INTEGRITY_FLAG_OFF)
+
 /*
  * ublk server can register data buffers for incoming I/O requests with a sparse
  * io_uring buffer table. The request buffer can then be used as the data buffer
  * for io_uring operations via the fixed buffer index.
  * Note that the ublk server can never directly access the request data memory.
-- 
2.45.2


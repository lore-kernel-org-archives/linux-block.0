Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6861BFE00
	for <linux-block@vger.kernel.org>; Sat,  1 Mar 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740855804; cv=none; b=bmqdCig8DiUhPmtvmzXS7d8ifQcyVB/RksTqQN5VczR/MvpirE0mC7zSEkqWDz0WDbD6mteMUg1O/seNGCniz8vct9y8Kc6F0VaM16BasfnZnxrFG2d3hTf9tELD/i7hQfdhPmam0IHj1WrM9jb2s5IwrerUZpMIZSpqM68NclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740855804; c=relaxed/simple;
	bh=GRjsFbkbVxXqkass6qIGbhqNaI3PmF5zffUNEdoUW8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ISGCSkXFkyyO0gkGO1cs3i+brygLETZOZ4Z0A09udc/KmLg1ps3n10JuRHVrRgBAsTu9rK9Ehur7tvYS3YgdbP9UW7/XKfTW8rdlLF22RxSEYL3o42fXxXUdBLSkkBTYSpAyk1mDB+wPkzci96zBqR9bjl6JsmhrbJEEfYcDLWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aKfmjQ4t; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aKfmjQ4t"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-7c0e3688f92so48985385a.1
        for <linux-block@vger.kernel.org>; Sat, 01 Mar 2025 11:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740855800; x=1741460600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPtTyrhHo4Bp34ujcUzSOaIDxgVPVdiOF8KP+yd3nw8=;
        b=aKfmjQ4tqbwyYMQwDe7Hx3zxDJa0Yp2/H53VRGCAuCtCIgHCS+gX6K0lyL69kgyCt0
         3Vv7K7wN708YiheapACyMkcFfqTfxrtEyi+c0g7jlPUNXjY3Ap4hUOYGA/lqDOAvj8od
         RGQVPZz6Iizb+/KYYNIql95FgpmjXVPXq+gJ9i46oAbrqXkZff8KdkoHo51ZpRAjRlDX
         0yZYxn9EKycyIt/mzUWi1awqUbEQL5W0NTM5KBSQDqGv8Wj1oQer9MBAiJmG8KpLD10p
         wMQbxwEDcmxUUI0SMdpURCYVknme0qrhYNuerFNtCL6l1mfMRPyRVDrh6slJTEXAFpE3
         51pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740855800; x=1741460600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPtTyrhHo4Bp34ujcUzSOaIDxgVPVdiOF8KP+yd3nw8=;
        b=M1Wt/MPfoKceCkbWhOQJz3OgnvftpRe4jDqdAMyWmjSv7L5gzeX4rX0ph85nuYqLtp
         iyxRh0EepBMvUE1hYw6DXyqA0oJw47OK9yHNkfcA9tOhvj7ZgY9pZ6ISqbN3XkrSUExC
         N+B70vtD426auEaTqymhUlDrqX1YAc7nuxgLf8acDXaiw0bmU8S4qWrKIZPiaPAsryJX
         vqFAIgixhdOxGDLzSldJGD+pEgvMUmvHzNSHXY51JoeHkF+74MHYJOMlgEeFdkq/lEfZ
         FaQD4EuNK48zlCAgrwd+LPJ75eBxEuJf6tjbXhtVkIvPTpoK+JIAXRnrU+rDb+GXXfLx
         IyfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9eZblFafAgYwPBIyypT391/NUko6JNGtcumc9Gs154AoBqVD2HwJwedjvInG1ohmlr/2TjSObtOw/VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz24LbDulH58CF6A8yOvwx2p7esSvUNdrwn/sowicaCFtwel22M
	7pRa4yBwxabp1ZkvllqJAaQBRVdO8ZnFPY7tAircT2qgXplnKYhKSnqee5Vk/Vd3EsHEiHeZDam
	1BpaiyU3YzLhJutC0dgxgQycOjoT7siz7aulj2R4WwYflmOGj
X-Gm-Gg: ASbGncsnI+SYirbm88YY7ZzFIQo/t3NkTIDYeAEBCFmEntGjmOfzGtktt8x5hNz5qmy
	rKMiuRBFOiBjrz4MWzBNz3sIz9MzJfEMfrzXPgZ6w5GrpzrpSzVsqt4gfA3hqpNYkalcQx0O+9r
	xLNRxqZUhNvm9Z1dkbnb3fPXlqmglkcB/8KHxA5flBEweUUTKjpSj9liJeR3Zo6DMTiTurqyKVg
	jA3J5Xy11nuJtbZd960cuPWq6l4WSLbLgR+/DYpBPZZyeP6DyK22gcfQU7Xj3589SKQy46rvaI+
	pBr6FXUkzMx5Dw2GbgVqegtHGcYQ8bav8A==
X-Google-Smtp-Source: AGHT+IHT7qGAIK+FkEaSknbOU0OApb1ysNsvmSnrt6XPcK/Su4fAh06kTZ1i9H3Vw3B4+jE1gchSfRbEcxz6
X-Received: by 2002:a05:620a:410b:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7c39c4bebdcmr470979485a.6.1740855800384;
        Sat, 01 Mar 2025 11:03:20 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e8b0f85d4bsm812006d6.5.2025.03.01.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 11:03:20 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E2EBC340314;
	Sat,  1 Mar 2025 12:03:18 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DCDEAE4164A; Sat,  1 Mar 2025 12:03:18 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: don't cast registered buffer index to int
Date: Sat,  1 Mar 2025 12:03:16 -0700
Message-ID: <20250301190317.950208-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_buffer_register_bvec() takes index as an unsigned int argument, but
ublk_register_io_buf() casts ub_cmd->addr (a u64) to int. Remove the
misleading cast and instead pass index as an unsigned value to
ublk_register_io_buf() and ublk_unregister_io_buf().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 512cbd456817..af5a4ff4bd3d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1760,16 +1760,15 @@ static void ublk_io_release(void *priv)
 	ublk_put_req_ref(ubq, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				struct ublk_queue *ubq, unsigned int tag,
-				const struct ublksrv_io_cmd *ub_cmd,
-				unsigned int issue_flags)
+				unsigned int index, unsigned int issue_flags)
 {
 	struct ublk_device *ub = cmd->file->private_data;
-	int index = (int)ub_cmd->addr, ret;
 	struct request *req;
+	int ret;
 
 	req = __ublk_check_and_get_req(ub, ubq, tag, 0);
 	if (!req)
 		return -EINVAL;
 
@@ -1782,14 +1781,13 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 
 	return 0;
 }
 
 static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
-				  const struct ublksrv_io_cmd *ub_cmd,
-				  unsigned int issue_flags)
+				  unsigned int index, unsigned int issue_flags)
 {
-	return io_buffer_unregister_bvec(cmd, ub_cmd->addr, issue_flags);
+	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1840,13 +1838,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		goto out;
 
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
-		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd, issue_flags);
+		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
-		return ublk_unregister_io_buf(cmd, ub_cmd, issue_flags);
+		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 		if (ublk_queue_ready(ubq)) {
 			ret = -EBUSY;
 			goto out;
-- 
2.45.2


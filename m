Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C43603DD
	for <linux-block@vger.kernel.org>; Mon,  4 May 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905486; cv=none; b=pjybjj5//+BsBwyQ5PxTMfy8L+7DvfLyRtSNq4wVpJIBSmhkMhOZMPPl0w21EkCn/+MSt2HOb4vXDKYYpFzn6mnld4hox3VTNBlWBJ9f61mGwYUkFN38Z05M/OUb4PGdQFp6/Dz+yViekH+oFsdLTGdrmmV9ttTCF0aa+2Zd9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905486; c=relaxed/simple;
	bh=PUZEoNkKWf9JGLPAlCtTEqIbiatzBUd52e5P6IUZBLY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=sGHWiT+tzZwQNgkGHwUQok24pS6ZwHYHHgpVfn6Jjt7JNIOTh5EXUH0W/BLDSvWZ7TvfIcwjkDEFaGNteEoEPTpssan5kmOVcWVayxkW0gASZzDEebJG/SeEZvrsxOgLh7nT19GWf5Z58GcSWqqIjIeeGG1vaulRoePCDyyLQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=RobG8h9+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="RobG8h9+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso33283335e9.3
        for <linux-block@vger.kernel.org>; Mon, 04 May 2026 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777905482; x=1778510282; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm0hrublys8E1weVlmrNPjJ8bLK11GDL1xb4Hh3ZltM=;
        b=RobG8h9+hacs6D5nhipX2oafECXCC8cD9JjbUZp0VMb5KlT6ccWuhgq38qHUfVuzFS
         ttAdvoS9+a9KMNOPBwSUfqT0pDnv18GlW8nTHnxExIrTXMlO8ugKysPOqX1Izu3/HjuP
         RtX9dd9Gpm9y7gk8WIsecJZN5caLOOtcUNDQtiBaCZflhSHw3BBliW9oQuI6yZ1snDDn
         TBvU7F2OZKFOd/o6+yinwruz6tFE+b02a8h8YSnFxzE4jLEUD4zxx7LJ3TQQYGMRzUBB
         EBjFaI+Z68fp3VRt+fZM+AMeIlAm0Clj43MRMWlopaXe23MfG9WQJQPdQtgcKTx6ew7z
         UhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777905482; x=1778510282;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rm0hrublys8E1weVlmrNPjJ8bLK11GDL1xb4Hh3ZltM=;
        b=spxzcJYngQEBgBuMQKY/JZQmihZmrwL0sg3YxiJA4OR9AJAeQkau7v7XCPPMjPl1jq
         3NwX5Y3sALdBWXMLsEqBsQl8rIlsUBsQIVfEGrVCifft/ci+YACCSQcfj1jBijh6qfZI
         RJDWgBcbwDxkPAVsZlpnR75Y9Op9/AdGuqWMB3FcRXev+70FDKrV3mX6RUX+OJioZr/v
         jVY03EJjdnd6QaqSYRWnJxLUOZ3/xDoKC0CicModQCOGGlnMimqoDO8iu+jdBI+83uH4
         HcPKu/nci02CtAB7zoTavOEHVuIPx20QYbMV9k6FijsEvonS6J5+lKbGZ92S2tEy04vK
         e/lw==
X-Gm-Message-State: AOJu0YzavX+cGuXxYqziYlMWlmZJcgtGyfLPmf8L+Hlpg7tUPmmdnvbL
	auljQ1zqRBWrcjqKzz3s1+1w/yH+R3/Q0zGNoqFZg6GdBgdnS6xzNnV9sPFUnNUm1sVP9fo7Lno
	M4XbO7G8=
X-Gm-Gg: AeBDiev+/whhT4nS69H5gOxCK+wFUdKtrH39ssxvhsUuxn6I94mywSEn7eKwtZnd/sb
	eLz9YRclQZtOLLswZ35I8qad5GiwLkLpk24TnRegnfKQNbN85Tyh1srjBZFreXLSRBtEcNlukOc
	igvhExagwRhAm0JJJXX5OdJmFXCgek76bJLEN3JCUQ+Hb720DzjJMjpcsVtZYlfEMJ7gts9ETTK
	R8qeaGZ44pobfKtwOJlE+8Dwc3i9l0sxIw0sUtQwW5iUjBvSEzFlb/FfiqM62Sm+h0HxpjPPNLN
	mYsSKCPycjv8dwyAAbwqeTL5yfiqSPXBOT4y73EZQxexHQuHCxhY9oaemccLK9biNCNKleKfSBy
	U1aTie8MAgA6jFeirsYpJVT8Yj7IXBlhLJOF6AZu4911ipxaBRFxqY4T6bZX3p4hUcy4bU3ANwH
	P/eCcsVtedlRUoT5S6z7xX4zT54Zqm/KkRTQVcSi9uOXowo0HchPYRZWmTE4VXbYig8NozFktis
	apQ1lxczcm0CUH2PBkP
X-Received: by 2002:a05:600d:8453:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48a9852f5e7mr130533505e9.3.1777905482236;
        Mon, 04 May 2026 07:38:02 -0700 (PDT)
Received: from [10.211.9.173] ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fed8b8dsm113373115e9.4.2026.05.04.07.38.01
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 07:38:01 -0700 (PDT)
Message-ID: <14e454d3-8f27-459a-a515-8a2b70ac109d@kernel.dk>
Date: Mon, 4 May 2026 08:37:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: only read from sqe on initial invocation of
 blkdev_uring_cmd()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This passthrough helper currently only supports discards. Part of that
command is the start and length, which is read from the SQE. It does
so on every invocation, where it really should just make it stable
on the first invocation. This avoids needing to copy the SQE upfront,
as we only really need those two 8b values stored in our per-req
payload.

Cc: stable@vger.kernel.org # 6.17+
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/ioctl.c b/block/ioctl.c
index fc3be0549aa7..6aa02575e08d 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -857,6 +857,8 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 #endif
 
 struct blk_iou_cmd {
+	u64 start;
+	u64 len;
 	int res;
 	bool nowait;
 };
@@ -946,23 +948,27 @@ int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
 	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
-	const struct io_uring_sqe *sqe = cmd->sqe;
 	u32 cmd_op = cmd->cmd_op;
-	uint64_t start, len;
 
-	if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
-		     sqe->rw_flags || sqe->file_index))
-		return -EINVAL;
+	/* Read what we need from the SQE on the first issue */
+	if (issue_flags & IO_URING_F_INLINE) {
+		const struct io_uring_sqe *sqe = cmd->sqe;
+
+		if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
+			     sqe->rw_flags || sqe->file_index))
+			return -EINVAL;
+
+		bic->start = READ_ONCE(sqe->addr);
+		bic->len = READ_ONCE(sqe->addr3);
+	}
 
 	bic->res = 0;
 	bic->nowait = issue_flags & IO_URING_F_NONBLOCK;
 
-	start = READ_ONCE(sqe->addr);
-	len = READ_ONCE(sqe->addr3);
-
 	switch (cmd_op) {
 	case BLOCK_URING_CMD_DISCARD:
-		return blkdev_cmd_discard(cmd, bdev, start, len, bic->nowait);
+		return blkdev_cmd_discard(cmd, bdev, bic->start, bic->len,
+					  bic->nowait);
 	}
 	return -EINVAL;
 }

-- 
Jens Axboe


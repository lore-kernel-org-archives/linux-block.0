Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC353DDDA3
	for <linux-block@vger.kernel.org>; Tue,  5 May 2026 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966684; cv=none; b=lLMXvYNf0iQ6YuvoeKQ21tRQ06gdh15YjU13AK/dyL/dk59XZiYyEtnkiVPB7W7DpuLUl0DM/jDobx+g4Q8WdT/9SDFcnribsRdkYiXJgYfGxM8F3EXx6wAWjR61CS1WulbdouFqWMvAd4wnoHqZUoiiomezoDInuhnPOkD9xIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966684; c=relaxed/simple;
	bh=BxN1Gn/FIgxAzMeTOmHVGtRLiZYFilJ3rN57+/0egZg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=X6n45dnI5hz2nyKspJhJfJhy3jAOc2IDPtaN0g2pflLh08SRT3nz0HnsSXjfZXJV0M3Ogy4ZOdELhhQXA4eHHSEY/hoLiqjL/sMoJFogGYmgoKGLTfhEXVqpYMpRel2SrKLtCyFeTSx7zkZxu7a5o9vJEH67hVx5kF+isMkpMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=HSYI+6Vc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="HSYI+6Vc"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso46644895e9.2
        for <linux-block@vger.kernel.org>; Tue, 05 May 2026 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777966680; x=1778571480; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axiz+c/iGcRMeHdEbO+w9cKtBpUKE0nFMRMfqnYBXlg=;
        b=HSYI+6VcmRcFMbn1Zzoi/T/BV2LL9npmJIT2y+QI7le9jHUQBe/TZtOA7at1qDymdK
         wSJqhgCSTs4bg6eH0u/dlM0JR870i7KXSab+LzNwvrOor0dR837QUyEowyO0XBLJdXIT
         kAhepZydTNlRNDuvCE1lc8timLdC9/C+GNBRVTylW1lXnfSz2PTkddcHCIix9aS5amdF
         P+9lV1X4g5RsFF0VkYxPaNQwgOp1TEx+b/CTWbWEoiyBASXctfIDw06WNzS5gUNc6GOs
         tXXuAoh/tHW9ErNp1+GnX/f1URQk8tBv9gZtw0a9txIqTmMRvn91A/BjrIs/rOfQehzd
         Z+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777966680; x=1778571480;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axiz+c/iGcRMeHdEbO+w9cKtBpUKE0nFMRMfqnYBXlg=;
        b=WgijQRB4HJ2vixvyPR5gGmCtlmiOQMySJqzA+BT2dEJH6O3YPaw87uzQ8VY066hV7K
         8Kg0m4eJ06CtumhkHQ1d4VRoCWR9kB+VU1hbm7DVlFbUwPoFf/DogOu9STUjTN3eHL0f
         DR0ffEtT+kkPVBUBAzebyJHYZLGUJMMESCdk977d4k4eHc0YeTIv4sxkp4YN585lYCLC
         XFcvGJQSwuzWvZQbARczYqVBVNPwG3oPzQLDEeYltmTTAipnoJKkFPQYu9tefcP/kqSl
         JVKovbdydwG8cqurg3ydgB9BfV9fF4Zewjiw1Nj0LUlFC0Po/MecAcO/ZeQsl6gbRSZj
         rbGw==
X-Gm-Message-State: AOJu0YzpH1LvD5g93sZxTwXkXgzQNP5Px+SB699cMalFxtX1+b57vxcI
	2MVsurN+283+44LFLn5YldDjUKvlNELw355pANbFFgB47Z6GK3fRlyOMBlS2Brqt0D0IHZy17Pt
	2bKNAPig=
X-Gm-Gg: AeBDieuwJJZoJRtiUocX//l61qmjFI7F3ctIhASCyPoZNpxiEngHDT2WcHmMObmNfrF
	plqbkF7Mnadhjjgm+WmpFvUXXWO1njUHVNPzi8L5PvknE7QQjDON4+5ryh01SdgaIktKbZH5u1n
	idKq9BtkcA8rWON5ZaIrPFjIJN5GzsurcXodQvoXMhQZo5aB9WfLgA6oJaNy5z32Sw6ZE2HiIXj
	3t/+7/45DKA+PK8Gf2a2nl61zzSifyQLuJNFqFFkjyMTbiUeVhWALHN/hdZOlStjw0tU8SRup6N
	lGElg7AgoPfApoFdlyu8OqNK3EsDSx3Sepb0cC1vmWUdtd4G6oU7vl2/vRTf2s45GgegG+fgEHs
	UtvYL4TA/0H4OXqEPL47Ceohh9QNIOnAs1EJy6NjeXpQ5PWiODW2IpY9IQxNQjYPkhnJtPdmXKZ
	Lu+EV4s/7AuZfXIhD1fo0DOQUnlfRWrWgxHLrrMj3SqUq4y2MkZGHp/plCSKi3CLE7TmchsM39S
	PZr+Y1NR7jbI8+P18bv
X-Received: by 2002:a05:600c:3e0b:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-48d18bead75mr29669615e9.22.1777966679663;
        Tue, 05 May 2026 00:37:59 -0700 (PDT)
Received: from [10.211.9.173] ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17714dc8sm19150265e9.4.2026.05.05.00.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:37:59 -0700 (PDT)
Message-ID: <64e053e4-24aa-434d-9b35-794d3b292628@kernel.dk>
Date: Tue, 5 May 2026 01:37:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] block: only read from sqe on initial invocation of
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

Changes since v1:
- Use IORING_URING_CMD_REISSUE flag (Caleb)

diff --git a/block/ioctl.c b/block/ioctl.c
index fc3be0549aa7..ab2c9ed79946 100644
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
+	if (!(issue_flags & IORING_URING_CMD_REISSUE)) {
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


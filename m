Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC721D59C
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763261558; cv=none; b=YR3PSVaXzyEOGD4+NrzNJkUp2qF2UReQOSM7VzOc2ZM/iyJXWfi6zeoOHsTplslEk0CJB6C29DcKR6V6O6zQvCtb/GBaVEgKDqJ9C2Tqz7A/gnKvGpPVM2XZVDyUqiXvIymEthdbIWPRlT2drVwO4MFjphrk+RSLQH//iriCsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763261558; c=relaxed/simple;
	bh=BTSie0fB9Ay9BrPAvd0GqT7p5Oo1wpJzQjAq7za50jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQRcBVkiTBkwn33SXb/QyL7Cyl4+1F8S0MBcqBExtWSd3D0Gygl4Kj8yqE+gTZ/M49F8M2p1VxfkYHnT7wxpRYofR8SZO1cB9Pf1K0/yy/t0+Aa/qfxgstcA0xEZCFr9EDRdxqPHQJzU/1ZdjBHdCQzcFUYxIA1NRHBafXRCjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPfGiIYN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPfGiIYN"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso2723668b3a.3
        for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 18:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763261556; x=1763866356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUCELPem49SzoVU2tqOtceK1o51g0JLKiVNvQNE25sk=;
        b=BPfGiIYNpFW8J0kl7sao7xURTDChiuWeRyi31YxKlJQYO3gWUoY749FePSVYZZd9P7
         j8aTBmF9UTmmVQw734eFqiA35etY98LqayoTGeFbP4q8IPucnNgAz2PW79Xa2lT4GC4A
         ofjb8MOIKMsUHKOKJhn//bmOOMXQZHlPzAEu2tLEt4ZT14kCMDeGSORUVF/zd4/zCbVP
         qrdSq5pXcUy8sxHBTYg7TT4aTw7kl97nVi12Jw1PKB9abCVzuDU7JGcBVY4zbmu3Z3+B
         3QS6xeG7/sWTR4wYjhDkSp8yjhB/SNhxsRt5UXyazlR8/eG5AI9JyRzzn5gKi1Cn5YeZ
         2rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763261556; x=1763866356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUCELPem49SzoVU2tqOtceK1o51g0JLKiVNvQNE25sk=;
        b=kcDPPoUeWZsphyJmlB9k3o5ToWr0d5hjQJeya7AeVBYMYkTjuDxn7ZmupMR4kOox8t
         Am6U2RNv6K6CDDM5czzP9mWrWsKZB54eIUUvHgDkmA8zrY9EYY6HFCYtMLxionKVKtd1
         OdwnftGY5pcLgDJnxnH7ayR1nfoaiehGfz+SSyV0s9XR+PfAjcc44vb3ZZqh1BfGXkoK
         DXgFKxGaz+vAeS9p5jhyCUoLKiywToqiImI984+To7fWPhBOZXCqF7EJpavljU4ftndL
         oExH9xJNVb2UcydTUaIqheHolKGYCtUIuI9wLQaTjv7z734g4Wlb4fLsuhjL+dbSa2Vd
         v2cA==
X-Gm-Message-State: AOJu0YzTRz0M+mBg/mu/5wPNJRN7QmWEdGFVaLOTBnLMMkC+2sw8w6oA
	gXt03jIQz56EtFR0YkbCp5G5+dcEsuMfTajRkTahooHShxEJjIkAhk/VEp602g==
X-Gm-Gg: ASbGncuUivOR6O+ewF6hyI9ntysgVxb0++0Qg6RtHJ7/4ldBKU4tynyTr4OYSOzgLa3
	56val0UumzPB4j+uNZfsZUyBNXDO0FVtqYJvr0faf/HgCaOdIqi86zfBNF08+owNaiQFm64dwY0
	V8PvIIvac5OrAV6iQn16qZRbbhH/ovj3BGw1Yi7fN6tttyF6B7CG2udd2QsbMcqx82qc2jQBnQ/
	+OJ9yLQ9fYcKxS6v7XFGQHDlD49+9kRK9SgR9XENBUIFhVX1io1u/0svuCKU3QLrzH3Rm0Q7dgM
	DZYjO3m1HwtvR1dSZ8Er8lPmBZJwWgBEYyhk399IcvB+MNDKAH3UgpCr8X4eTg227KfCNsUVBxj
	MSvrEru8v3kCpmXOTaeNyE/A9My9ZPcyVkNPFc3agIbMN9WOKPyjE0MOsYu6D7pl8HNkyOZ/Whb
	V4H4EwbzvTjvkeShG3IkSC03xJGS9GwsWMpJt9eChaKoypiNAahGHaojBOTg==
X-Google-Smtp-Source: AGHT+IEcpP0w5CbQG8VxNozqyvT+PbwXdnOCRB84jUgK5Cm+59aAwss+Mbu9j01p7xMi00ZAvn/mzw==
X-Received: by 2002:a05:7022:f513:b0:11b:a514:b64f with SMTP id a92af1059eb24-11ba514bc89mr716002c88.13.1763261556202;
        Sat, 15 Nov 2025 18:52:36 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b86afe12esm18537574c88.6.2025.11.15.18.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 18:52:35 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	kch@nvidia.com,
	dlemoal@kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH 2/2] zloop: respect REQ_NOWAIT for memory allocation
Date: Sat, 15 Nov 2025 18:52:29 -0800
Message-Id: <20251116025229.29136-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
References: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zloop advertises REQ_NOWAIT support via BLK_FEAT_NOWAIT (set by
default for all blk-mq devices), but violates REQ_NOWAIT semantics
by using GFP_NOIO allocations which can block.

BLK_FEAT_NOWAIT is advertised through this call chain:
  zloop_add()
   blk_mq_alloc_disk(&lim, ...)
    __blk_mq_alloc_disk()
     blk_mq_alloc_queue()
      lim->features |= BLK_FEAT_NOWAIT <-- Set by default for blk-mq

However, the REQ_NOWAIT I/O path violates this contract. For io_uring
inline submissions, the call chain is:

  1. Userspace (io_uring setup):
   io_uring_setup(entries, &params)
   fd = io_uring_register(IORING_REGISTER_FILES, &zloop_fd, 1)

  2. Userspace (submit I/O with NOWAIT):
   sqe = io_uring_get_sqe(ring)
   io_uring_prep_write(sqe, zloop_fd, buf, len, offset)
   io_uring_submit(ring)  <-- inline submission

  3. io_uring core (inline path):
   io_submit_sqes()
    io_submit_sqe()
     io_queue_sqe()
      issue_flags = IO_URING_F_NONBLOCK <-- Sets inline/nowait mode
      io_issue_sqe()
       io_write()
        if (force_nonblock)  <-- true for inline submission
         kiocb->ki_flags |= IOCB_NOWAIT

  4. VFS layer:
   call_write_iter()
    blkdev_write_iter()
     -> propagates IOCB_NOWAIT to REQ_NOWAIT on bio
     __blkdev_direct_IO_simple() OR
     __blkdev_direct_IO()        OR
     __blkdev_direct_IO_async()

  5. Block layer:
   blk_mq_submit_bio()
    blk_mq_get_new_requests()
     __blk_mq_alloc_requests()
      blk_mq_rq_ctx_init()
       -> propagates REQ_NOWAIT to request->cmd_flags
    __blk_mq_try_issue_directly() OR blk_mq_sched_insert_request()
     blk_mq_run_hw_queue()
      __blk_mq_delay_run_hw_queue()
       __blk_mq_run_hw_queue()
        blk_mq_sched_dispatch_requests()

  6. Zloop driver:
   zloop_queue_rq()
    zloop_rw()
     kmalloc_array(..., GFP_NOIO) <-- BLOCKS (REQ_NOWAIT violation)
      -> Should use GFP_NOWAIT when rq->cmd_flags & REQ_NOWAIT

Fix by using GFP_NOWAIT when REQ_NOWAIT is set, and return -EAGAIN
instead of -ENOMEM when NOWAIT allocation fails, allowing io_uring
to retry the operation with blocking allowed.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/block/zloop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 92be9f0af00a..9295c4817bd4 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -372,6 +372,8 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	sector_t zone_end;
 	int nr_bvec = 0;
 	int ret;
+	bool nowait = rq->cmd_flags & REQ_NOWAIT;
+	gfp_t alloc_flags = nowait ? GFP_NOWAIT : GFP_NOIO;
 
 	atomic_set(&cmd->ref, 2);
 	cmd->sector = sector;
@@ -443,9 +445,9 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	if (rq->bio != rq->biotail) {
 		struct bio_vec *bvec;
 
-		cmd->bvec = kmalloc_array(nr_bvec, sizeof(*cmd->bvec), GFP_NOIO);
+		cmd->bvec = kmalloc_array(nr_bvec, sizeof(*cmd->bvec), alloc_flags);
 		if (!cmd->bvec) {
-			ret = -EIO;
+			ret = nowait ? -EAGAIN : -ENOMEM;
 			goto unlock;
 		}
 
-- 
2.40.0


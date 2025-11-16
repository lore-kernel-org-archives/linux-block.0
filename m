Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA786331
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763261556; cv=none; b=AoUU+C87nyl27W/cx4Z2VSP0Txdr2nJvqj5iXxCI54IUxyOCPVDIvjvYwvR0CrYvy+iWrjJNj/JEBJUf5AEUfEKhzg9SWMKRkEb0apNCX/4tQMpQ2KpsujLAEaYcAPMylF6WULYhe69b9PFbpyHPPEAUa29x/KE3EJVDeNhSYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763261556; c=relaxed/simple;
	bh=zSyuJQybiCCJq9vJXociC8iWz2WpqebRM2coqMQXreM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j2s9YjhxX4bmD6cYCAdAM2JVSnA2RejUUdC04SlJwtyY9R6rU6KBGd7ckbNTIZAQFvofYxteoeQgqti//iFoGPfKI41tfWAxQh+iX7ruHYzJ5pVUdI4SN65GZHduvNuR9D07pj5Y8wLvxceISjXUbrfk4wEIbN3KI4yzG9VT2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWypahLe; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWypahLe"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo3095078b3a.2
        for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 18:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763261554; x=1763866354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fynmkibx81oHPVZlsDjAwfjnWrDW9I9yhZr9t2s34D4=;
        b=bWypahLeqU8XVhY7WrJrGKNOq75mOh0EUcbARqiR7cp8IpJMWFXZM2bVN25O6CBXKG
         VepMX7Wcicankhc8rb1J3CiE0bVexHB6NlHVC3X3T1FGrDIx/rH4IGzGyKSdSKapjEEH
         QN9b0VLKOKH8idRgb7Z1cC3RQ7BjHGE5aF+QbS395WBmJVk9nTZFp26JPwaaRkXmO7+o
         cchfbYBcb3BI8OQCXCDB8wJSUx7TPq2D7dc4jmKiI/aCjqXLDOrgK1dT+khYowRHkcFk
         JeRTh5G/fWZyd4oPYwDqF2lfZl+wXiL7TxhXNQwmvkAddNQ6wtwSnG88+g1Kd0JeuYR8
         jZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763261554; x=1763866354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fynmkibx81oHPVZlsDjAwfjnWrDW9I9yhZr9t2s34D4=;
        b=Qet9QAC2v9how9HfAXxHhTrqAidK5Qwpp1/h3TvOfu9dA1QaySMW4pawBNfvSfzuZO
         k4z8wHKzaVIbL38lWG8oe04boEE2ZCKOrr3fS+9SPLCi9aS5CZLyZaz9qqOhYeIPYPYG
         MzPcStT6MOMWKQmcnl/9x5JH/30zKlb92jBy7nZwi6HW4TO7cTkZIlO2jI7o2t/a6Gt0
         lgS+C/lhNYUSxqW4SXjeqNhLBrsBmS3+RgHWjhvqyHFsmg4JpxfcnLqQF5Gi67bgeFTU
         Egl8DpmTGgD+aB05Ast474oQ0JqowCTknHNp4dGn2NYB7sKpWY59d3sGfdU8merJgyYb
         QU1g==
X-Gm-Message-State: AOJu0YxUYfBcPwk0drspd/1MgdvBcLJq+kFX+aNKEyvDbtMXOlc7pX/O
	Gye7qMnlt8Po4ntSnczx0iX4DC7VhTHYeBHZFkAuqXvsEObLaQ19s5NsI+xzhg==
X-Gm-Gg: ASbGncvhYNKeiGcDzzESSI3FIJOVSlXEb9NhFn0ZJUDbIktTdAihb1yzNdb3tZu1i70
	P0Uf2GiOgpG9SZpYlVFvwLsQAglpsxHWt7ZVICikLfoLHSc0zI7DdsrdRl5GV3cCJGur0GIf/9N
	mXiK0QOWHerlDpgsb5S7NOEYnD25Ox1LeBJAz0p6Kc3uzyY04FGPPrY2+5GaDPHgmrRU2eboze6
	iwXaPuxc8IcRLd3lsYZbx+hnBuWbp5u0R1ghWEIw6q7+8VRbYPR8RDzPIajM2hmIMFGuVMJ9uUM
	u94rMlmrlnztGJqYNk9cS79Rv2UzKVZ5TAFLr+2Wvt3/q6y2bbxrYGvZUkrU3ZY5hDga60QOac8
	WFWvmPkRgj2yj3fATmyKIsevMg9/CRNh6SYCb0zedemtcMSA8Wr0MaATo6Wb9Vd74kS1J6CXpwI
	5e88uXdx6/npQL1wmFNFXH6JAXCVmCUi0/XMnWNjWqHdvYXpvzfbwsDG16Tw==
X-Google-Smtp-Source: AGHT+IGuxCNPGqqDfinwkgjDYRdhsyZ3bAuSi+UqlLLpWa2IXW55TBZS0THPWyrGlc6chAtpNbV6Sw==
X-Received: by 2002:a05:7022:e0a:b0:11b:bf3f:5251 with SMTP id a92af1059eb24-11bbf3f5610mr1080629c88.16.1763261554225;
        Sat, 15 Nov 2025 18:52:34 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b86afe12esm18537183c88.6.2025.11.15.18.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 18:52:33 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	kch@nvidia.com,
	dlemoal@kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
Date: Sat, 15 Nov 2025 18:52:28 -0800
Message-Id: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

loop advertises REQ_NOWAIT support via BLK_FEAT_NOWAIT (set by
default for all blk-mq devices), but violates REQ_NOWAIT semantics
by using GFP_NOIO allocations which can block.

BLK_FEAT_NOWAIT is advertised through this call chain:
  loop_add()
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

  6. Loop driver:
   loop_queue_rq()
    lo_rw_aio()
     kmalloc_array(..., GFP_NOIO) <-- BLOCKS (REQ_NOWAIT violation)
      -> Should use GFP_NOWAIT when rq->cmd_flags & REQ_NOWAIT

Fix by using GFP_NOWAIT when REQ_NOWAIT is set, and return -EAGAIN
instead of -ENOMEM when NOWAIT allocation fails, allowing io_uring
to retry the operation with blocking allowed.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/block/loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 13ce229d450c..bad61f41df34 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -350,6 +350,8 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	unsigned int offset;
 	int nr_bvec = 0;
 	int ret;
+	bool nowait = rq->cmd_flags & REQ_NOWAIT;
+	gfp_t alloc_flags = nowait ? GFP_NOWAIT : GFP_NOIO;
 
 	rq_for_each_bvec(tmp, rq, rq_iter)
 		nr_bvec++;
@@ -357,9 +359,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	if (rq->bio != rq->biotail) {
 
 		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
-				     GFP_NOIO);
+				     alloc_flags);
 		if (!bvec)
-			return -EIO;
+			return nowait ? -EAGAIN : -ENOMEM;
 		cmd->bvec = bvec;
 
 		/*
-- 
2.40.0


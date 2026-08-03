Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9E3B71CF
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791690; cv=none; b=AFDSFd6+LDmaIBLRkm7vOTJasYcGB1Mzf5LaKKvwSbihJzXSHkvsCk/ibW/IHrOi4ewqgkMdue22/LvqoF++NfPKxyNbecbzF/cP5/gKItZ/GyuDNhUvNXvqi0AePG3CqwxrvMpz495xVVA6vbZcTxlwFT72ZTcTz0j3Hd4MJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791690; c=relaxed/simple;
	bh=UpmEnx3awHseJWWLI2g6v8qVQIy9TviUGqb9Opoaoo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tvsn38Q1G8Soz1Kwfc3cdGqdzn50AIIRS2XduxKqqhBP+VKLkXA6nu+gPxZAZhVRnQM4VMfAmq+trBRveF9rbbAN+1sVJ9sCqlN1XdPGjGwLxlVVWw1QyuzCXqJq5Kk60RDOVJ+95iJEhxqYMmM5/TGru4AHGRUnMZsvKbQICl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AiOY6D5Z; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AiOY6D5Z"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-ca5b707b78aso268176a12.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785791686; x=1786396486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aTIvj8Z/s40cHu4vpiMgFm0KJRfpdgU7PpP6Ih2zxbE=;
        b=AiOY6D5Z9rB4MRoPETkGxa7yeSC0O9KfWqdxj1WuCngzlLPBFHYuiwhMwH9ubujtdI
         DZguM8d0X34Wn0pTjzIaBHxlLzAKHgFihOKheyfpylAUDehGGZySl6/frA7a/g5gCPFU
         YuPqiciOlh7TYCKFJgUNgqqjznsqeMPmIqsa8JyS+TDgZ3nl4iy8tY70KZoYV1PXFEqS
         CgHiCjA3ge6PQycGOIC9GuU1xvuEr16IfGdCA72JZFC5ZpY5FCkbUlW4it6g1g+K6+NJ
         5R9CS0EWr/kmHxVrED6aItEson3z2AqjXr85Fx9nwN3i8oH1XamvExqcIsvlH5GZku6x
         cmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791686; x=1786396486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aTIvj8Z/s40cHu4vpiMgFm0KJRfpdgU7PpP6Ih2zxbE=;
        b=b8wlM7pyzOma5BYeX4f6i4wCKTTqN6KbQgXXGgpheDG4JnNgAgnix7kvDd0B7lj0QD
         fycpJTG+ULH96hMJvxVjwbUuDN4o5rWnNQM6hKQ8XVQDlq6rNBNAOBlb4iD98C3AbyMb
         +UjhlWvUQNc4bFFBnup4uGLq1D2rbE4hRZXhTsXZ5G4qFCl/6uDommqhcq4c0InvLetz
         HjzGuExlSEiSjvez0MNolI/5FIReot7NNqBfSS0RL68KoA1tx8QqKm5zWmj2wWOXx7TK
         FdES0FMgpaTxYfqWvDJ/x3obZUiUOXDCMWVPmMxD0FtEwC+ACYGyK49o1OvXbmx/gPig
         xCHw==
X-Gm-Message-State: AOJu0YzLsnnewUwjWjvvQpKAX2aYBZNWdyNVvVWVnfcI46QYe/XgpQaC
	TCwZr7q8sV5r/Iu84VJvG0bxoZrPpx51Ftmxg77fZRd6bqDkQUYl4N/DKvqnViCDxQxXznLVBpL
	xUAYmVY3uriHWPc04++9EoSI3o+YUT5BktOhnlGTURl1B6A1uu+U/
X-Gm-Gg: AR+sD11+szGPLBn3OEj6qSK4cDHO692wA0uccZgWyY0rIXqlsThvWLn0m1xVoUUaGfN
	43PjbYLfgoihqAdgrNJzv9zPVXSHHeQCnHbndt0OhMTsWydP1CUnqHlRJdEi6p+6gvDvFVz/Job
	KYr4gltUUP9Xx+MxzgUpS+btui2ihFLSs3uWV0C7xgAFWMuZ5hZj3YmH6o3lwu768dqLeCnmNLI
	wfYtn9nQQdcH1JTG/UILCqv9krnGkOgH3t3wZmxLl6lTbPPAXD37OWIAPlS0bCcqMtS/Xv11P7v
	a0ieCEAp3ZQ/BKii81CvQYjbD95bsKBg1LiNTHJF/u8ZB2VjF6AC5+R/x/MgLvWFK/PIc3jDCOw
	ZlHt2nW/lhgeMc/4P7g==
X-Received: by 2002:a05:6a21:501:b0:3bf:99ea:aeb2 with SMTP id adf61e73a8af0-3c92a900f91mr17076379637.4.1785791685907;
        Mon, 03 Aug 2026 14:14:45 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbe39643987sm856581a12.1.2026.08.03.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:14:45 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 3561A436B7;
	Mon,  3 Aug 2026 15:14:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3213DE4041D; Mon,  3 Aug 2026 15:14:45 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 4/8] ublk: initialize io_desc on daemon task
Date: Mon,  3 Aug 2026 15:14:36 -0600
Message-ID: <20260803211441.2538144-5-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803211441.2538144-1-csander@purestorage.com>
References: <20260803211441.2538144-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_setup_iod() is currently called to populate struct ublksrv_io_desc
on the thread submitting I/O to a ublk device. However, only the ublk
server threads read the io_descs. This basically guarantees a cache miss
on both threads for each ublk I/O. There's really no need to initialize
the io_descs on the submitting thread. Move the ublk_setup_iod() call to
ublk_dispatch_req() (for non-UBLK_F_BATCH_IO) and
__ublk_batch_prep_dispatch() (for UBLK_F_BATCH_IO), which runs on the
ublk server daemon thread before dispatching the I/O to userspace.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7f0549238d76..291461e1b236 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1798,10 +1798,11 @@ static void ublk_dispatch_req(struct ublk_queue *ubq, struct request *req)
 {
 	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 	u16 tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
 
+	ublk_setup_iod(ubq, req);
 	pr_devel("%s: complete: qid %d tag %d io_flags %x addr %llx\n",
 			__func__, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
 
 	/*
@@ -1851,10 +1852,11 @@ static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
 	struct ublk_io *io = &ubq->ios[tag];
 	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
 	enum auto_buf_reg_res res = AUTO_BUF_REG_FALLBACK;
 	struct io_uring_cmd *cmd = data->cmd;
 
+	ublk_setup_iod(ubq, req);
 	if (!ublk_start_io(ubq, req, io))
 		return false;
 
 	if (ublk_support_auto_buf_reg(ubq) && blk_rq_has_data(req)) {
 		res = ublk_auto_buf_register(ubq, req, io, cmd,
@@ -2187,11 +2189,10 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
 
 	/* fill iod to slot in io cmd buffer */
 	if (unlikely(!ublk_validate_req(ubq, rq)))
 		return BLK_STS_IOERR;
 
-	ublk_setup_iod(ubq, rq);
 	blk_mq_start_request(rq);
 	return BLK_STS_OK;
 }
 
 /*
-- 
2.54.0


Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B662690C4
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048710; cv=none; b=SNLvjiH8uGx6nMhZRz5RNMKmXLm5hwP6Hb+QuxeGbgrvvvSIwZSfGujZPZ3TRvXAKzxvMe3pifnnmx4ZFbnwe1rSSo32rnl0+LRfzEiZjRnwq8C64Sjp0mYDm5XeB/QxRtH7hnjTp79iX4OHDOXSfFIgS9kcfpM7BZzGKG0Td+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048710; c=relaxed/simple;
	bh=13Lb1ENEytkmOyjRQhWQw++cdiq7YvJSKwVsRLTVCmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7Qrz9iso1sjLuYRaaa0/Qvho3rkgC23CVnrL+7Odi1fxbstCDhIEajEZjCBUS1+okoFkxR+5JhNfA3n0ckTLQGL06gET0YKQ43G343KSYSiTfN029chf+4iNTa3VFKB+ABLnA2oF6EQm0G591S6YKiru2VEnVfCUqXRJIj9ZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FWHMJmhc; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FWHMJmhc"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2241c95619eso536525ad.0
        for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746048707; x=1746653507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AowIOLsR5bCOYMWlibArmMsMF726MWG71cvx56FgS1U=;
        b=FWHMJmhcv2aPsb86mFE6XVJ1dR8LPtZA50SOj/1jkZ2Z051yWCtO3mi1Pkqb7NUnhX
         ZNg6EJBwrEDqn0bB600jtZjPiy3CKGq3Jqg022e3ViAL8L7RHCloOMgDSu7mRdvT5uCZ
         BXCk2HRReTbccYWgfKXaDRdQA1HJt3XW7qij0Y4jnZ/gkTLR8+1NnjXVGn3LEyjO2K8b
         A4+4Jrut9rweF8dDpBeQwYrew9B4AIja8duHRzChx8SGdg3MxlDKWWxr2pcVXTDtKCqv
         vqrpnwpRiIg1O2PgotvAzKxGmSNdQiyCIdMuAOZ/vSsgj5FoSDrGM1sYk+4UHHX+C1rf
         9qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048707; x=1746653507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AowIOLsR5bCOYMWlibArmMsMF726MWG71cvx56FgS1U=;
        b=hJ1Dm1TBG82b7AMy+XNGH+CwAC4q5dEuRGCNnEiW0xSXnybWPEr8u60TmK88jWKHr5
         JiN+s0IyJkQPRXNI1+Q0V6f4PtvoFMyVYFnVT2K4AlVKYF0Sz75TGHoaGIYij+4vBNmv
         ofif4u+jVIr1uVpmKZfaJwPl4eVMYmNiuJCOtvVoTgzPq1D5WxUBhZ9/NQ/dD1o71FlW
         hD+ZgkdASdf+XF+sdUYSbV2+7DfOpfJdoWG0nYm+jFCokOIWApB6oH9+3T0LE/Kd7l3l
         dALmsaqohKt/zJ1rm3zd5hU9Af5PwaEb+qR1cO/4cwEbWMmJANxo9XDTwX11PfEzLoar
         MMPA==
X-Forwarded-Encrypted: i=1; AJvYcCVLqUoTWqtGigwWi4Bwhl2ieCldi7dx3W6bb5Z+WLYaDXDiq8rV/BRHEWKqO2M5t2KfKOug4SU0oZA7fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWqqCnMVZAYAXzWs0++9owv/7Nk5oagBHn0kugwONaSAeh9vs
	ynMs+Ma9kEBqRuGwVUhQH/cGXw1pOmIZTWFSqLu1Mz5FPTKLrresVKzVyXCWRVtZGv7e9vWn3ql
	1xsCHqYT+9zEeJAh0NACc+Hn5us3RjoXt8sj0ZHxJeVTxSANm
X-Gm-Gg: ASbGnct/+j2iIrCMbdhCH8+vr+QBgMqWoNpk5AI8B97FC7dhdncT91GWYO8av8hn2Q0
	C8tF6wrGy2rHiojqOkGYaz7OG/HZYaz3u7AZtasBSL8BUKg4l3OfTp3hCQJJV/YMOivRdK6DlFI
	BqX7VtgAcZK+YTHS4Qlv/oIb97O878GK8UcwpP3dUder9khif9kN+aLBGsDBny78MquRoNP2jxA
	p7B0jhGsY0oSyHiVgPkfRcbGY1FnD3rxFyHmwXf37XQczV/yIpEFlTyiXwbrsbJZaFaKOgTpIRs
	dy+g97y/CkZqv8FkVCMlyXKdS4ilaA==
X-Google-Smtp-Source: AGHT+IEMz8JKMg0IjBz2In3YtU1v2RE7FTghMie4XT2Fs6EgCtrCNUHUNw7hVYhLHl5Z9YvcSiYBYtpOoL4O
X-Received: by 2002:a17:902:d2cb:b0:224:88c:9253 with SMTP id d9443c01a7336-22df578c625mr24120655ad.6.1746048707346;
        Wed, 30 Apr 2025 14:31:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22db5216c1fsm14989235ad.106.2025.04.30.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:31:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9DA113400C9;
	Wed, 30 Apr 2025 15:31:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 97F8BE41981; Wed, 30 Apr 2025 15:31:46 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: consolidate UBLK_IO_FLAG_OWNED_BY_SRV checks
Date: Wed, 30 Apr 2025 15:31:43 -0600
Message-ID: <20250430213144.2625274-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every ublk I/O command except UBLK_IO_FETCH_REQ checks that the ublk_io
has UBLK_IO_FLAG_OWNED_BY_SRV set. Consolidate the separate checks into
a single one in __ublk_ch_uring_cmd(), analogous to those for
UBLK_IO_FLAG_ACTIVE and UBLK_IO_FLAG_NEED_GET_DATA.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
This is targeted at for-6.16/block, but depends on a recent commit that's only
on block-6.15.

 drivers/block/ublk_drv.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f9032076bc06..692590fcd967 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1951,20 +1951,16 @@ static void ublk_io_release(void *priv)
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				const struct ublk_queue *ubq, unsigned int tag,
 				unsigned int index, unsigned int issue_flags)
 {
 	struct ublk_device *ub = cmd->file->private_data;
-	const struct ublk_io *io = &ubq->ios[tag];
 	struct request *req;
 	int ret;
 
 	if (!ublk_support_zero_copy(ubq))
 		return -EINVAL;
 
-	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-		return -EINVAL;
-
 	req = __ublk_check_and_get_req(ub, ubq, tag, 0);
 	if (!req)
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
@@ -1976,21 +1972,16 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 
 	return 0;
 }
 
 static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
-				  const struct ublk_queue *ubq, unsigned int tag,
+				  const struct ublk_queue *ubq,
 				  unsigned int index, unsigned int issue_flags)
 {
-	const struct ublk_io *io = &ubq->ios[tag];
-
 	if (!ublk_support_zero_copy(ubq))
 		return -EINVAL;
 
-	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-		return -EINVAL;
-
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
 static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 		      struct ublk_io *io, __u64 buf_addr)
@@ -2072,10 +2063,15 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	/* there is pending io cmd, something must be wrong */
 	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
 		ret = -EBUSY;
 		goto out;
 	}
+ 
+	/* only UBLK_IO_FETCH_REQ is allowed if io is not OWNED_BY_SRV */
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV) &&
+	    _IOC_NR(cmd_op) != UBLK_IO_FETCH_REQ)
+		goto out;
 
 	/*
 	 * ensure that the user issues UBLK_IO_NEED_GET_DATA
 	 * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
 	 */
@@ -2090,22 +2086,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
-		return ublk_unregister_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
+		return ublk_unregister_io_buf(cmd, ubq, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
 		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
 		if (ret)
 			goto out;
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-			goto out;
-
 		if (ublk_need_map_io(ubq)) {
 			/*
 			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 			 * NEED GET DATA is not enabled or it is Read IO.
 			 */
@@ -2123,12 +2115,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-			goto out;
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
 		ublk_dispatch_req(ubq, req, issue_flags);
 		return -EIOCBQUEUED;
 	default:
-- 
2.45.2


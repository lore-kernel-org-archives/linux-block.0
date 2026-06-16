Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7586143D4F7
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625193; cv=none; b=WgUQhjOp9Ubzp5WJZ/7fEopx0xLLZym3f3yF9kwjaHu+CrNO4QQP3AKe9o1hQniUsdLj9tHSGb7/NmBvH2lfQGzi2ysuRK8tWE7yzxWT60KaJ3ya+RPnkPAr5Qn6zSk/Hu4SYsoJWcz5OmMvDLbTYxZxtuue9lwH0XKHJG8926s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625193; c=relaxed/simple;
	bh=Dix6XlZcRB1wc60+/mjZtYMI6ii9+QvvkJDqtEvS9D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XnZULugkG4LK+IgXmpGKnhhIsGI3v18TvH2ivDdX/vg2rnFBxUfcs0uzvDq/cwLdYPLvcFxCJaJFd2j8V4ov/Fn9PPT3m0p2PAFg7R4f3GURQckffRsrhP3LZQzmLwiVkSlSvQYrEStol1T1qVJ7hByhKXREXs409RnEgX6930U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0NsXgEK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0NsXgEK"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so1812606a91.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781625192; x=1782229992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh/KH8bV7E+QxBwe9DjJg5o96G0F2VO8jHzkev1UTe4=;
        b=o0NsXgEKtx7c37zf1cWf0zdaSIGyX6S3GCHff+tm2cLuUabW47lLwapBFBPXJEZJKi
         MxbxHnte+/tIgc/5rNU+iTAQpFNqRi161VrkrHgMMm1/cD2jSlEdCPg/JAAnY8xDWDAq
         nyA01AzIYe2WmruoI2fwbq/3vXH9OSfWQNlrxIORmgXtM6NlWb+96RUlUt4ip+0w9a1Z
         GENf4OtcjCsPHuYzzMCtTIoY/k/uK4AA2TH+oFoLjta+W7sZUKwZDn4c+7LOuzmJYwse
         mBuEyOUO3Mz5PokmURI5tgArWGWAhemKT74ata1qM88TfxczqIwnmN3xp0sfMMRnlgv3
         NYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625192; x=1782229992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh/KH8bV7E+QxBwe9DjJg5o96G0F2VO8jHzkev1UTe4=;
        b=riQEz4vfIUb0cKa9mIYmQjBgUZgmLltUhrqySi5wjFd0LXF13TFFqqetCyy/oyxJYr
         mu7zdnMIE/I/e4OOcp/YqEzzUqN7VyrBecV0kKeqCH7SwPb0inmuqAZxtUoc5qwS3xsg
         2CQ3hRO6p3BwZQzxYVaFtfg0rMoiOac++vunoiEGNeJsqfcsVbid64iu8/RYdDovB7oB
         BUYA2M2k0q7eI7jFVyywKEcA+ZOfN6oUZy6aR7+ZYwWRbyCCJYfHWS00hpmnyXRx8KGd
         ybJhDt4P3GOzQ3+MP1u8oTPiRQ4z29KRGBIpP6cejsS/QpnM3Ob9N36tQWddU/ZLRuBD
         6ugw==
X-Gm-Message-State: AOJu0YxtPsZcMTKTJvBSWDtCA7nuNItSA1fxjfk7FjxUtWs6IDE00ppv
	H4gP4d7rt9Za4AJnq8nzvCwsAgUnc7z02ewOQyErWdb7F7GBFKkwAjsX
X-Gm-Gg: Acq92OEvSuqFa4i+gwYHRXB/9+Wn/yFEn/INvYYmPdhcCg2fUjbg7ZaqlRyQL3WZU7U
	2DswbaxJZvi7fPPzT5dVgz7Tq5bQslSrUsnHNfqxmdU6tTMLhWTaRR1DTmG+vdjJjUPv6jsFvmU
	YAMtd0OBswPQcUpjt7ajvr1Yj5x/mPZo1xing98TK3hlFL0JP9zRe+NQtIXJFffVEnSN0hmJegB
	Dz8w6woTlBaqJTb4n/c2/0tWqv5+0qwMuTQnst4qiqPNuAO+QdiWG8ceWBJ8WpGljQYwj6NT4kl
	QcWdloBQqUikHVSuwpoNnfROXwvNUlXvn4W6npqQ6BI3tw2cMMdV7NY8aG+Yg08We4zlkXkhLcn
	u4lCKe7Pxy/dyxHCCgimwYluShAfsADjP1KyEh0Jr9hdc/jHMk9A+mgvtRKpUVI0Z50BeI2Zl8r
	ALw/kmQ84rbyMVfTzpQK2GS8F+Qfg=
X-Received: by 2002:a17:90b:538c:b0:36d:b662:708e with SMTP id 98e67ed59e1d1-37c9366d98emr44582a91.9.1781625191781;
        Tue, 16 Jun 2026 08:53:11 -0700 (PDT)
Received: from wokron-navi.. ([2001:250:20f:3:a591:e881:8bc8:acac])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c707b62f4sm638455a91.9.2026.06.16.08.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:53:11 -0700 (PDT)
From: Yitang Yang <yi1tang.yang@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Yitang Yang <yi1tang.yang@gmail.com>
Subject: [PATCH] block: fix IORING_URING_CMD_REISSUE flags check in blkdev_uring_cmd
Date: Tue, 16 Jun 2026 23:51:29 +0800
Message-ID: <20260616155129.406057-1-yi1tang.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blkdev_uring_cmd() checks IORING_URING_CMD_REISSUE to determine whether
this is the first issue. However, this flag lives in cmd->flags instead
of issue_flags.

Coincidentally, IO_URING_F_NONBLOCK shares bit 31 with
IORING_URING_CMD_REISSUE. As a result, the SQE read was never performed,
bic->len remained zero, and every BLOCK_URING_CMD_DISCARD failed with
-EINVAL.

Fix it by checking cmd->flags as intended.

Fixes: 212ec34e4e72 ("block: only read from sqe on initial invocation of blkdev_uring_cmd")
Signed-off-by: Yitang Yang <yi1tang.yang@gmail.com>
---
 block/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index ab2c9ed79946..3d4ea1537457 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -951,7 +951,7 @@ int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	u32 cmd_op = cmd->cmd_op;
 
 	/* Read what we need from the SQE on the first issue */
-	if (!(issue_flags & IORING_URING_CMD_REISSUE)) {
+	if (!(cmd->flags & IORING_URING_CMD_REISSUE)) {
 		const struct io_uring_sqe *sqe = cmd->sqe;
 
 		if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
-- 
2.43.0


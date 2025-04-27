Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3322A7F8
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745729900; cv=none; b=dXiOSSh0d+2/B3KlIsPM4jIY6Lile0bABEJmZRM4IafAqyyjEZklgfGnwWXtivFE1xfiWzQ3yqhpaquhJTqGRNlWLV4R50gGcfdgQ5L/UtY47r5RqZILs9fgLw7BHyzK28+gw/roDv4IfnPlew0ppmMcoNsPaEakJm5nrUHLchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745729900; c=relaxed/simple;
	bh=NUn9SVb+MfY5dmkHh3fBVg0g26DzHRJ0u156ZDbCEB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovCfoE7YQIrG9QdR2moTnJzAiTCzgumQX2V8mQEDp0fnrRtHzGDsmXR+NJdHk9yCKWS1oVYKvr4lBukPKwvQ/0jOBkFRgSi98hUAJfEcLXv2NzH6sP80IV+guElpkMd5LLUHuoKXzML5S/KGg0CSAs6AYouKfLVsQ214MryAHXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KRvV6mWF; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KRvV6mWF"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6ef0537741dso6131136d6.2
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745729894; x=1746334694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+5Yd+HilBazEXqtS76hks4RkYeuhgaTEWRoHSLa00A=;
        b=KRvV6mWF/aMmDXo/Y0LPTVWAJnsPDoD4OZFAAUqEc/SJrjJPP7CQOkC9Ng1qObsgC1
         IwV9mOeoml7qcjUX5G3TpjSeN/SxbjgKA0bSuJDrUN/oIB7/7UTTspkjiZUUPJo/ee5M
         1pT1SB6bV3jDk5OTGPL81AETyS9BYIQ1z+NZuY+Bf5AR89qtcIiceS4kPQSPD8HUfTRq
         9nZ+WuYNgNNqoTfHtKzHWYrX4sC4LrXslscJ3dQ2/JyKdXgabA+xgYZNef9XKKNefvyN
         rOxx4e8ArxkRAMwZYBt916dqt959GBbcKpSVxp/SrZoOAM9hZReQIiIp+MkuZ0C6WA2b
         Qoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745729894; x=1746334694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+5Yd+HilBazEXqtS76hks4RkYeuhgaTEWRoHSLa00A=;
        b=LRtVPtdFpwcuq/JKM1cj0P0p6SxeGdjd0wt3KbYPW5pjEfhDBY1Ou5Xm+358NI+gQ3
         1TaUnV0O1DKPi5VWznsO1BHAcYdLF9UWC2CLvR9frTDi8Hs0DoiPqVqQYyyHYDBgOtvC
         XeKZKofIaCwZYrJEJ81gIr41cE+5/erwIZCkXOK3ZSURu6VTSZ6RbNr+u3s9lTS4tqGh
         bsuKAJfZygWIHPwJJHGGtcfg3iTOuW0ugLwxPdeaB9UgvpRYoqVKE7pQNd6Py/qPfIr4
         u5UdE/xObc/BxnqALX+xMZX7J1mP2hELIQycbg+lCRdHXssOuPFRQHW2F8r9oLFljf/s
         eMCg==
X-Forwarded-Encrypted: i=1; AJvYcCUJwWbjWYpA1LZWsbeCNiqZku5UCgOc4hQnvOKF2QNqSLZzCG4jRadgo1yjSdB7Fm0uHwx1XPsHYAm58w==@vger.kernel.org
X-Gm-Message-State: AOJu0YySuWocDQm1kObAR49qeCpyGgBV1a5f/3fy5pdO0XZGj658xUTJ
	C0eqxiEt/sgNpjs9ekKwetgcH8d99YiSSsJLr779HCWhSkd2/h+AAzfkhJF4PBYQjRmu+R+TBTT
	TkRFx/PyQ9VBVSA4HFcVYhmQSdXthx5N+
X-Gm-Gg: ASbGncvIteHvNrQwrmL7Se2pyFjmUpTAR9jjO0WndiV4jcmDdMJIka+zBhX33PfCGrq
	gysWtZS/6oeDstK4NkKiZchlol1S9+jikC1vFszD00Zx6aGbbfZ7KGD3q5IgDGFT6g2iyEAfsGE
	XLkRsG+5hfUBMo4MGwDI7JILZG9QJWFyOcLzlEz1QteJBzfhipdrFw0tnO+V3B2GoU5TAo6dhv7
	GV6dtv8GJxXWPxSKICH5zcRfiNpXdDhkkNDniuD3kTWXHa3B+Tu43MKMBkIMDjeOTymi+w62YMb
	Xu9S18uKtV70l37OpP+Am138ovvuFrqN4m3KsK+HSPEH
X-Google-Smtp-Source: AGHT+IH0phaIAkFYXXMRFvPg6N27jqz6RX1/nP+p9VaX+8zHkdFDK5BtLmogDwAIYmOxVq8f5tI7lOYY1Vwq
X-Received: by 2002:a05:6214:2424:b0:6f2:af37:d877 with SMTP id 6a1803df08f44-6f4cb9d0096mr54637936d6.3.1745729894113;
        Sat, 26 Apr 2025 21:58:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f4c092c65csm6106456d6.24.2025.04.26.21.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 21:58:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7D9F434042F;
	Sat, 26 Apr 2025 22:58:13 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7B8B8E40C3E; Sat, 26 Apr 2025 22:58:13 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/8] ublk: don't log uring_cmd cmd_op in ublk_dispatch_req()
Date: Sat, 26 Apr 2025 22:57:59 -0600
Message-ID: <20250427045803.772972-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250427045803.772972-1-csander@purestorage.com>
References: <20250427045803.772972-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmd_op is either UBLK_U_IO_FETCH_REQ, UBLK_U_IO_COMMIT_AND_FETCH_REQ,
or UBLK_U_IO_NEED_GET_DATA. Which one isn't particularly interesting
is already recorded by the log line in __ublk_ch_uring_cmd().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4967a5d72029..01fc92051754 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1159,12 +1159,12 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 {
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
 	unsigned int mapped_bytes;
 
-	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
-			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
+	pr_devel("%s: complete: qid %d tag %d io_flags %x addr %llx\n",
+			__func__, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
 
 	/*
 	 * Task is exiting if either:
 	 *
@@ -1185,13 +1185,12 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 		 * so immediately pass UBLK_IO_RES_NEED_GET_DATA to ublksrv
 		 * and notify it.
 		 */
 		if (!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA)) {
 			io->flags |= UBLK_IO_FLAG_NEED_GET_DATA;
-			pr_devel("%s: need get data. op %d, qid %d tag %d io_flags %x\n",
-					__func__, io->cmd->cmd_op, ubq->q_id,
-					req->tag, io->flags);
+			pr_devel("%s: need get data. qid %d tag %d io_flags %x\n",
+					__func__, ubq->q_id, req->tag, io->flags);
 			ublk_complete_io_cmd(io, UBLK_IO_RES_NEED_GET_DATA,
 					     issue_flags);
 			return;
 		}
 		/*
@@ -1200,12 +1199,12 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 		 * do the copy work.
 		 */
 		io->flags &= ~UBLK_IO_FLAG_NEED_GET_DATA;
 		/* update iod->addr because ublksrv may have passed a new io buffer */
 		ublk_get_iod(ubq, req->tag)->addr = io->addr;
-		pr_devel("%s: update iod->addr: op %d, qid %d tag %d io_flags %x addr %llx\n",
-				__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
+		pr_devel("%s: update iod->addr: qid %d tag %d io_flags %x addr %llx\n",
+				__func__, ubq->q_id, req->tag, io->flags,
 				ublk_get_iod(ubq, req->tag)->addr);
 	}
 
 	mapped_bytes = ublk_map_io(ubq, req, io);
 
-- 
2.45.2


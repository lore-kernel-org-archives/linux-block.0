Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1070224B1F
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832781; cv=none; b=F+ikyK1sSBhUpCpeUR27nZ118voY6J/M/NK0yJZaQ+fawuUe6IC2GCGNWI7yRKQdrkRk+XMPFAgy9lUOoAOCV7NQKgdo5Ok02rRA9kV+Odi7XVfxg5CrCkGuR1s0JezvZnQsucCBiu060w4/Lwb783udEUr/N67PZvfP/s8gZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832781; c=relaxed/simple;
	bh=JGLutgZ75KHuHWrR2YnD7fo4yUfX4ANugcfm5HFDpUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+KY9XFBTW5V4FlafbaJQVqkjCt6Jn8VXYzu4HaU3Zdf8PKytk6mQqdX2ZmHUvgsDPW2XwaEJTvuBHFhzryoh2NcYgMdZuOF6ot9loNaUnjg4F7E5NtOQBibau42QFk8vE4IkqrevPkX8X1u+5sZlJlRjBIn5Yfp4yGOzRbEV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MxkWFXI+; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MxkWFXI+"
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-7054f0e933cso58105527b3.1
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744832777; x=1745437577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLmRu9G8uG9ADbZkf+KZnj2bBZ+uuBo+D+GI2ZjdHfs=;
        b=MxkWFXI+gm6vp+1VuUzcxacQhsvZEGfVd/awsC62+rSPsU1BeYC75nKRcROI6uN1zG
         6VhqIk/g1aSMUfj5T5tkprPfcsxWCJXW6ChB3l6JzA2Qq5eHaATyo4oljhwV2quBNAyu
         BXTvrSIpyEejnpmQZk4lc4Y+UU0POzCfVncn4bDin98XUpKebALNiKAFxexk7moEFf20
         cEeDyuXAonhdof0MZFhqrzCO1KwEAa1XlXSxOfj8+ezE68DKuiCfC4aG4gdzfnvV+2Hk
         aiRTmHPUq1p52rH4TxORjeFKTaoNQUeQBtT+f21x/XZsV2XiOWdz4xezvsFvRH7wNktv
         R7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744832777; x=1745437577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLmRu9G8uG9ADbZkf+KZnj2bBZ+uuBo+D+GI2ZjdHfs=;
        b=VvOnPrVTIxFkNYAB3r5rcsyQ0+x3qozPU+EWpUo8wAUGnJwyC93gjJG18q60xpTp+Y
         +QxB4LcswDqixVGVzdhsG1KSmO78mmVkdWNNghB1Fi2mPagyyQX90Fa/tehvXTEtrz1Q
         ZglsifR8Aee3RCYnt2TM7yROFE4JfKmAGx9fNJwGsjhUp8OHzUoXdKH+Bg9g5qfyQcjM
         OpIYHfNWSjsgOjK1MQQC/Fl/poF2D6JGD+rLDj0iJoX8pHFX6NkJAdAPLzqJPUfuOGwl
         0J1H6is44GkciV13mXTtF9kA7Lu02lOUcOKnQ244Pobao6MVlNSBgWjnTVeYGapOKGss
         qV5Q==
X-Gm-Message-State: AOJu0YzkG5PX39vCJkKnAv+T2+ImdpEuWEl9u7Vx/FAiN5uOFWhACd94
	/AxIa7gIk/uq3zTyYKWo2pKXLpLQRh1GLHKwHICIO0UABHKMgpgd4pM5vebR0hvvxQccRKZEaia
	Rvd9irAcOEA+QH+hh4pOmD7tiG55hvZ3u
X-Gm-Gg: ASbGncvv4w4Uy+vlohV0e0zFpXkwZit9UAKYZh5qz15Emp8Yd8uFLAwKWNbnTfJ/oq7
	UboF9mKlrbUvydQp0P04uxCb6mZZ16aMyVmMDIDkgppB46fYp9O8h3o/QK3r67KPjL9XV/hgqty
	xjos3kR8/Fg3PUnsVCsXs5kf3GVBEilYHIDuVp3HCq5FmyEucYmQ491ri0gJAMoBoh3HyxU9Ggc
	9108/jhEP4ry0FVbFaeqGs+x8X0nCiCZQ9KS88gCNIZ/MZBong7oZXyOmss0dmBK77m5W4RtBBl
	KwKJ8SEF5rkz6O5Q769ubr4xg22BdAhH9SnYBCNDFHRjEA==
X-Google-Smtp-Source: AGHT+IGi/8SRV0dhXq13NAA6SwhXdPei0dwUitF9GbZqgDA1TOyEtsaJOWONfQ3mtyQfIdcmABsU3yUJ2EB+
X-Received: by 2002:a05:690c:6e09:b0:702:52fb:4649 with SMTP id 00721157ae682-706b335cfa2mr49583987b3.27.1744832777538;
        Wed, 16 Apr 2025 12:46:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7053e0f393fsm7345227b3.2.2025.04.16.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:46:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9097934058D;
	Wed, 16 Apr 2025 13:46:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 87502E417E1; Wed, 16 Apr 2025 13:46:16 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 16 Apr 2025 13:46:06 -0600
Subject: [PATCH v5 2/4] ublk: mark ublk_queue as const for
 ublk_commit_and_fetch
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-ublk_task_per_io-v5-2-9261ad7bff20@purestorage.com>
References: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
In-Reply-To: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

We now allow multiple tasks to operate on I/Os belonging to the same
queue concurrently. This means that any writes to ublk_queue in the I/O
path are potential sources of data races. Try to prevent these by
marking ublk_queue pointers as const when handling COMMIT_AND_FETCH.
Move the logic for this command into its own function
ublk_commit_and_fetch. Also open code ublk_commit_completion in
ublk_commit_and_fetch to reduce the number of parameters/avoid a
redundant lookup.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 91 +++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 48 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4e4863d873e6593ad94c72cbf971f792df5795ae..b44cbcbcc9d1735c398dc9ac7e93f4c8736b9201 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1518,30 +1518,6 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
 
-static void ublk_commit_completion(struct ublk_device *ub,
-		const struct ublksrv_io_cmd *ub_cmd)
-{
-	u32 qid = ub_cmd->q_id, tag = ub_cmd->tag;
-	struct ublk_queue *ubq = ublk_get_queue(ub, qid);
-	struct ublk_io *io = &ubq->ios[tag];
-	struct request *req;
-
-	/* now this cmd slot is owned by nbd driver */
-	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
-	io->res = ub_cmd->result;
-
-	/* find the io request and complete */
-	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
-	if (WARN_ON_ONCE(unlikely(!req)))
-		return;
-
-	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = ub_cmd->zone_append_lba;
-
-	if (likely(!blk_should_fake_timeout(req->q)))
-		ublk_put_req_ref(ubq, req);
-}
-
 /*
  * Called from io task context via cancel fn, meantime quiesce ublk
  * blk-mq queue, so we are called exclusively with blk-mq and io task
@@ -1918,6 +1894,45 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
+static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
+				 struct ublk_io *io, struct io_uring_cmd *cmd,
+				 const struct ublksrv_io_cmd *ub_cmd,
+				 struct request *req)
+{
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
+		 * NEED GET DATA is not enabled or it is Read IO.
+		 */
+		if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
+					req_op(req) == REQ_OP_READ))
+			return -EINVAL;
+	} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
+		/*
+		 * User copy requires addr to be unset when command is
+		 * not zone append
+		 */
+		return -EINVAL;
+	}
+
+	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+
+	/* now this cmd slot is owned by ublk driver */
+	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
+	io->res = ub_cmd->result;
+
+	if (req_op(req) == REQ_OP_ZONE_APPEND)
+		req->__sector = ub_cmd->zone_append_lba;
+
+	if (likely(!blk_should_fake_timeout(req->q)))
+		ublk_put_req_ref(ubq, req);
+
+	return 0;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1929,7 +1944,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
 	int ret = -EINVAL;
-	struct request *req;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
@@ -2005,30 +2019,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-			goto out;
-
-		if (ublk_need_map_io(ubq)) {
-			/*
-			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
-			 * NEED GET DATA is not enabled or it is Read IO.
-			 */
-			if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
-						req_op(req) == REQ_OP_READ))
-				goto out;
-		} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
-			/*
-			 * User copy requires addr to be unset when command is
-			 * not zone append
-			 */
-			ret = -EINVAL;
+		ret = ublk_commit_and_fetch(
+			ubq, io, cmd, ub_cmd,
+			blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag));
+		if (ret)
 			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))

-- 
2.34.1


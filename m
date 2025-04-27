Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFB2153D0
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745729897; cv=none; b=POjGrGdwUI1H5sb6uqQNIpZ9Psb5TKuugi3Ts9GyG9qLzI2woCXcu13zgWsezX1v7mKDujxzRq+IhG+VevZSDRF+CXipwprCYUsFL3fEekf6zFecNMTYfRV53VlGAtiCIxc6lenIQZO1f9VXa3UQJiLSzpZdU6aRbdQG3HX2R58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745729897; c=relaxed/simple;
	bh=yUtEHoQ4xRUN+TbTy6hSjbTUHM3GxPcNU0fnKHjGl9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJajTtIkr2z5VVMuUL7uG0NNaIKqXohXr2m9MdXqyAHEqXBgCLaALNg9h7kDEuKUKUNSfY/w0rNzmv7X+RwQn1Hay6+Oh+lgL7Xe58a4THemgDMRLH7+LRUNvrLrCAusZHLlaq8onLRI4HySCeK7SPQnrrkjUn2aIZ5TuLt4xWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QAw7ZRxM; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QAw7ZRxM"
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-47745b4b9aaso7016041cf.0
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 21:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745729893; x=1746334693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXNvXWhGudyXXPiWCUtWfoACEHHbGSETRpmhgFO97Ds=;
        b=QAw7ZRxMto8QLhZcy34XFfWuYE0tUK1EPD86J8xQfITnTMd+rs++Sx/PqnC1DASHJ9
         ftQfwdisGpbT534WHmmnKAdaSr4n7jPOS9m5kk3rAKszdiZGV0ZO0/Ng/yAOb+y7JqOM
         BbC2eC7Ke2Cat/AXK8r2Hf/nSBGcq6tw1VfV10N2nx8YkyqPduY9dIRt70s6qAdnK/Ml
         a3XU5M1BpKXVFpmu59f9uQDIyvVdPm6/HhnssHTiJY+r2RVJBu+pFZ2Nt3ELZ7yeOzTb
         Bd8i9mRycho62iZxgmiyAKL7APPKdOmQC61dOMcPO8OlsFBMQRC9TMGKe9WwDNpIxszf
         krmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745729893; x=1746334693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXNvXWhGudyXXPiWCUtWfoACEHHbGSETRpmhgFO97Ds=;
        b=ucYcqRChqW+TrisS0cwyOJOlbh9OZ4XS4Wr7V3ZC0Peu2ajLmW/Z8QwJsOsH015UG3
         Qb1TSjdMrjq7WBSZnhNxYjpYxFvJbNUyDCJLGcKINi696uQW/au4UOOJFFlCSdJOTiGu
         uR08DRBX7RTfqAnqUlE2jpO+zq3SLhSxuqpbFIP+03TNb5QQClNwlFSGv9qvmshVOsQT
         fXchoQG9+1XCJitMNIe6/WBEXdYZOKjUdsi97N24/uX+hs6dRyJ3+9unCkkcpm5KzQlf
         sHNy6dMoj/eBHvr6WsFlFu8mU9ZpzwBe3vj3jClC97wesxQRXdtCFJNnZ52rrjmvL7YK
         bDuw==
X-Forwarded-Encrypted: i=1; AJvYcCVN9FMLkAQqVTCo7a7GY9Q4oKXidW6y+JirHCcs6MbwFDguSgVIglJqaqoVUzwO5D7/mfmJ0pLLgU1/Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcqt2pkgV2zj8cfqNxk1CMD2pYg057Z93U/5VFqn6bjCQSajr
	oeDS8apXpgNVzlqpNypubkMqloXo+7YydhkjicXkk1JjYhHHRaXVYYFSspWBohyh3M5IjLIYcma
	IUDayTFnJT/QCdGQi7AaBaXk0ebX/H058
X-Gm-Gg: ASbGncsukyX3cwllX00gr24Fofu32eiGVI4CxYP5m3AxvB5Lot4g505ZnEJjBekbjMs
	SoFhZloS1NwSFBG0/38ddeJD+VEcFOrmqim0QjEdC9IpxpVFOvdEsqvoLg89t04cPIVpWO21NR4
	QYHaPzulyyIeclD8Hq+2w2rgUU/VvZab1Uz9TKaUwD/mOOhVQyQFjyMt7TkWb7cRGyC0s1TcNHu
	JEcWURo5RluH7cndXxaMHu/RGFBaDBIG8pvV+0oaioGgX9hnQ0OvE9Y5WQIhdrfhSeUBM/frqIc
	FHb+nFZQ2h8MobHvwXiu0Tk+QnHDjUwIbNTEAuFwVw/I
X-Google-Smtp-Source: AGHT+IFbmU0+uYKdB0O+dXgph6PFFwqJaJkTzK96k5Yeul7ne50UIQWiSXieMDTnqjHk7Y9MBlqrMkQ7h6G4
X-Received: by 2002:a05:622a:d6:b0:476:add4:d2b6 with SMTP id d75a77b69052e-4801c0d6e1dmr37890251cf.1.1745729893167;
        Sat, 26 Apr 2025 21:58:13 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f4c092c65csm6106396d6.24.2025.04.26.21.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 21:58:13 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7FE6334042F;
	Sat, 26 Apr 2025 22:58:12 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7D4E1E40C3E; Sat, 26 Apr 2025 22:58:12 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/8] ublk: factor out ublk_commit_and_fetch
Date: Sat, 26 Apr 2025 22:57:56 -0600
Message-ID: <20250427045803.772972-2-csander@purestorage.com>
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

From: Uday Shankar <ushankar@purestorage.com>

Move the logic for the UBLK_IO_COMMIT_AND_FETCH_REQ opcode into its own
function. This also allows us to mark ublk_queue pointers as const for
that operation, which can help prevent data races since we may allow
concurrent operation on one ublk_queue in the future. Also open code
ublk_commit_completion in ublk_commit_and_fetch to reduce the number of
parameters/avoid a redundant lookup.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
[Restore __ublk_ch_uring_cmd() req variable used in commit d6aa0c178bf8
("ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA")]
---
 drivers/block/ublk_drv.c | 90 +++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 47 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a183aa7648c3..7809ed585e1c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1587,34 +1587,10 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	pfn = virt_to_phys(ublk_queue_cmd_buf(ub, q_id)) >> PAGE_SHIFT;
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
 static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 		struct request *req)
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
@@ -2019,10 +1995,51 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 out:
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
 
+static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
+				 struct ublk_io *io, struct io_uring_cmd *cmd,
+				 const struct ublksrv_io_cmd *ub_cmd)
+{
+	struct blk_mq_tags *tags = ubq->dev->tag_set.tags[ub_cmd->q_id];
+	struct request *req = blk_mq_tag_to_rq(tags, ub_cmd->tag);
+
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
 {
 	struct ublk_device *ub = cmd->file->private_data;
@@ -2077,34 +2094,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
 		if (ret)
 			goto out;
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
+		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd);
+		if (ret)
 			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-- 
2.45.2


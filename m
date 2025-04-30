Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C522ACCE
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053570; cv=none; b=Pea+NsJQhx/aaPD4Wmq4wiD/NbLWq0VpzgGiO3EYYXeb5EY6xSD8Lz3VbhS0xNPgSaZKFEHilcNX0pErBOfXaF56sr14LfSyd3HjIwl5jpaJDY7mHojsgW8wKZdkvR8q6qexSEQo8ACvhgToAkl37NbowDDIyxh8C50pofJuugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053570; c=relaxed/simple;
	bh=89WlQm8CBY5xlCR2ru9sVqkwi6VOCLX59mKkm7v5axI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pl7WdQRE9NiTmtEp7QvMVkEp/7dAEQqQu94pnvyW20rE9OcM3q82CiWXgE6tXnZka6FDAsnQ3BhaYRdOA7C5KGLiSa6gPPvxw8WqBPnqpwea7wcRzU9f6RrMiAFnMxfsTUqvhTN9AuAXiJj3P7DNNnYHjUu7cb1QPp6k6EPWpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=J7mWmOvK; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="J7mWmOvK"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-309e54e469cso51489a91.1
        for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 15:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746053567; x=1746658367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsYRyiMQyE+zkojGTj1LMa02/pZHUAhJh8dpMcIQRlI=;
        b=J7mWmOvKkNDb0kPcuNh5jhrMnWG1erYhSWEy91k3gt/1UXfy6XVayCKikTA9rzCdRY
         G3uuaxeZ9O/dFOOt4HfX3jlRpHAYnhS52a9krhTDVlCz0sVTwHUv3l7AV1f30ny7l5L/
         mZwaK54G7hmzfLjyZtV1egM+DRJoaGjq90mIZvuq/4PUhkqmiyKyhmGedegfwToSYRst
         ZWEK7uCi7oxBPBk8cXnGlCrzRs1+iC3pP40vWa/E2LRWYTJzAwIgmGq0fYNNFkadQiWS
         OeCFyUYsIYmXnwYH6VYizQ3vOxWOIWDf2aGngm/B50DzAgFNRLBKSs8c5z5dGsFy9rSt
         Zk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746053567; x=1746658367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsYRyiMQyE+zkojGTj1LMa02/pZHUAhJh8dpMcIQRlI=;
        b=piiJOeZn8DnXw/y0b6gxmFW4KCWuh3ShaC0OwHqGr8A0gjhmq98hmjjTSczi0KvdQn
         lNh5prKm+SP1PA5dlTTbU1Un7AmR2XGnrghe47yRT2orzf5YuIRIP+/2qM4VLr62eDlP
         vqDQQLTDcp7ulAEjB9CzW94q+dwknZ8P/6oZt6SrUmxB8I4MJTpsfV+da7BcwfZaw4nQ
         1mESNCjp+56jHlhvurq6Lx4KFmuC3LQVoFHwtIngdWFRUCA+XAkfgVB1j1KKSbWrjZ3k
         Ulub+XkRFdwuU6JNaZLPNTkYVX35w0trRFNEqa4m63EQV4Jl1QgCfvEUqArMK86HMyZN
         vY3w==
X-Forwarded-Encrypted: i=1; AJvYcCWwqJ3v51a7/dd4pKce8I18VW5iqFEeDcuNVSIm6GQjthTPTm4VePOBBjeE2VAnEsAvT65HNlerKjE8Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2rEmDzbfBrrthyFtk0Bv6eyxEaS5NXSxf1MjUOt9d0rcV/yx
	jOIirBIiwLLmo/YkanB8PJbQY4C11ywcxsLA4kFX6/12FOUtHmy5n59L3LwELwJz8em2zvOWl7S
	KZC7O/JWMGU+08C4FIJrs03ZpbqTRyfrC
X-Gm-Gg: ASbGncsX+kBXznMJDTzYV/BkuCnDwq2h0pmBklgXa/Y88OFt/wj+DDZOOe5MlhYgyDO
	QioHft815/yEjG0GfPZLObuwSJ8f52l3qP/1bUYiHE7MTFWBnV7HU3Wvqsso1gq/CFX6XJjaTMk
	s/KPUFeMXVPgF+Y1sfvX9hdYCDUzuQU6MROkN25IL4D61ac0zy8EeVJt+zj4NQBzDtk9ltJL1PZ
	LLwgWGwPXwcLoz1+1fEMsEIpQzAXuJTFmyOYQ3oLcwFSNeab7syEih14taqWPHQ5tNW69diAScg
	9GxnqBpb3R+hfobslm6yERLbJDigPBnlIl3YuYV3DI7B
X-Google-Smtp-Source: AGHT+IH6mXEsIKFrxSQZ9fMY0JedlzXNtlt4kDzO3Sr7mcYc121+09EUGSS0UhV936K/s6EW8s7EP3aQ3K0h
X-Received: by 2002:a17:90b:1b12:b0:2ff:7b41:c3cf with SMTP id 98e67ed59e1d1-30a34a77d45mr2329658a91.4.1746053567026;
        Wed, 30 Apr 2025 15:52:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-30a347b8603sm137430a91.13.2025.04.30.15.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 15:52:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 560E53404FD;
	Wed, 30 Apr 2025 16:52:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 543F2E41CC0; Wed, 30 Apr 2025 16:52:46 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 9/9] ublk: store request pointer in ublk_io
Date: Wed, 30 Apr 2025 16:52:34 -0600
Message-ID: <20250430225234.2676781-10-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250430225234.2676781-1-csander@purestorage.com>
References: <20250430225234.2676781-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A ublk_io is converted to a request in several places in the I/O path by
using blk_mq_tag_to_rq() to look up the (qid, tag) on the ublk device's
tagset. This involves a bunch of dereferences and a tag bounds check.

To make this conversion cheaper, store the request pointer in ublk_io.
Overlap this storage with the io_uring_cmd pointer. This is safe because
the io_uring_cmd pointer is only valid if UBLK_IO_FLAG_ACTIVE is set on
the ublk_io, the request pointer is valid if UBLK_IO_FLAG_OWNED_BY_SRV,
and these flags are mutually exclusive.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 43 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 97c61c0bf964..02e52b066318 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -140,11 +140,16 @@ struct ublk_io {
 	/* userspace buffer address from io cmd */
 	__u64	addr;
 	unsigned int flags;
 	int res;
 
-	struct io_uring_cmd *cmd;
+	union {
+		/* valid if UBLK_IO_FLAG_ACTIVE is set */
+		struct io_uring_cmd *cmd;
+		/* valid if UBLK_IO_FLAG_OWNED_BY_SRV is set */
+		struct request *req;
+	};
 };
 
 struct ublk_queue {
 	int q_id;
 	int q_depth;
@@ -1122,24 +1127,29 @@ static void ublk_complete_rq(struct kref *ref)
 	struct request *req = blk_mq_rq_from_pdu(data);
 
 	__ublk_complete_rq(req);
 }
 
-static void ublk_complete_io_cmd(struct ublk_io *io, int res,
-				 unsigned issue_flags)
+static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req,
+				 int res, unsigned issue_flags)
 {
+	/* read cmd first because req will overwrite it */
+	struct io_uring_cmd *cmd = io->cmd;
+
 	/* mark this cmd owned by ublksrv */
 	io->flags |= UBLK_IO_FLAG_OWNED_BY_SRV;
 
 	/*
 	 * clear ACTIVE since we are done with this sqe/cmd slot
 	 * We can only accept io cmd in case of being not active.
 	 */
 	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
 
+	io->req = req;
+
 	/* tell ublksrv one io request is coming */
-	io_uring_cmd_done(io->cmd, res, 0, issue_flags);
+	io_uring_cmd_done(cmd, res, 0, issue_flags);
 }
 
 #define UBLK_REQUEUE_DELAY_MS	3
 
 static inline void __ublk_abort_rq(struct ublk_queue *ubq,
@@ -1213,19 +1223,19 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 		 * and notify it.
 		 */
 		io->flags |= UBLK_IO_FLAG_NEED_GET_DATA;
 		pr_devel("%s: need get data. qid %d tag %d io_flags %x\n",
 				__func__, ubq->q_id, req->tag, io->flags);
-		ublk_complete_io_cmd(io, UBLK_IO_RES_NEED_GET_DATA,
+		ublk_complete_io_cmd(io, req, UBLK_IO_RES_NEED_GET_DATA,
 				     issue_flags);
 		return;
 	}
 
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	ublk_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
+	ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
 }
 
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
 			   unsigned int issue_flags)
 {
@@ -1609,16 +1619,12 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 	int i;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
-		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV) {
-			struct request *rq;
-
-			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
-			__ublk_fail_req(ubq, io, rq);
-		}
+		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
+			__ublk_fail_req(ubq, io, io->req);
 	}
 }
 
 /* Must be called when queue is frozen */
 static void ublk_mark_queue_canceling(struct ublk_queue *ubq)
@@ -1988,16 +1994,16 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 
 static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 				 struct ublk_io *io, struct io_uring_cmd *cmd,
 				 const struct ublksrv_io_cmd *ub_cmd)
 {
-	struct blk_mq_tags *tags = ubq->dev->tag_set.tags[ub_cmd->q_id];
-	struct request *req = blk_mq_tag_to_rq(tags, ub_cmd->tag);
+	struct request *req;
 
 	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 		return -EINVAL;
 
+	req = io->req;
 	if (ublk_need_map_io(ubq)) {
 		/*
 		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 		 * NEED GET DATA is not enabled or it is Read IO.
 		 */
@@ -2025,13 +2031,14 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		ublk_put_req_ref(ubq, req);
 
 	return 0;
 }
 
-static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
-			  struct request *req)
+static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
 {
+	struct request *req = io->req;
+
 	/*
 	 * We have handled UBLK_IO_NEED_GET_DATA command,
 	 * so clear UBLK_IO_FLAG_NEED_GET_DATA now and just
 	 * do the copy work.
 	 */
@@ -2053,11 +2060,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
 	int ret = -EINVAL;
-	struct request *req;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
 			ub_cmd->result);
 
@@ -2109,12 +2115,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 		io->addr = ub_cmd->addr;
-		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-		if (!ublk_get_data(ubq, io, req))
+		if (!ublk_get_data(ubq, io))
 			return -EIOCBQUEUED;
 
 		return UBLK_IO_RES_OK;
 	default:
 		goto out;
-- 
2.45.2


Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3144B128816
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321681; cv=none; b=M6kf1xCQnEZH/tY5G9vAa65dU29lJikjWDCErvPXdKDJ/2IGOfvl1iPxtbJOMJ086hi0mq3BpDfpsDDaINhmlAXbEn2lgqNjO8k+6oMPqhjDjMcUQVby4WNrsbeyrdFN5fVlwXNF2zFrYNtYV+NMPJ82Gi5rdBBTH/U1DXPFyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321681; c=relaxed/simple;
	bh=/68orq+82MfEUj9LravTOTcFWoW3WyvbchHMArmGtpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EifZtIq/6dqPV+o8Lo/TtZbrEgfn85+EzHrDKzwq9DLY9KqrS1jMwAhe/4zQPs9iSFoLG5Jfy6ptwo+gAraE98Kd2zKsUpcwivZ9WkJH4nyvj41/z06OcE15FXWN2G4Hu4KLpB9dH3uLH/n+NGTSruysaNzu9oSWScHEfthvA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VP4EYMRV; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VP4EYMRV"
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-85b41281b50so153316339f.3
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742321675; x=1742926475; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9yTXOpfspFFlX2dFyGqhYzfxOn0jR5JT6dXQU7Tt+c=;
        b=VP4EYMRVeAMP/JKDIZRUPZFYO8RfU2jIna2k4ZoN9gY1Ub5bv406OoxxKXVI0u4O+n
         mhLTL7KMbDbVl7NdDdbEi6F5wp1De9aDlJ/MaE9BRhRE7JHGn2Pc1o4Rc0zoc+dBjdiQ
         TdzsDm3kEaGQGp8Ahp9pVFVRvFtpvn1hlx039THUP1o0SvAGvoOA4HpLgD8km9bOpeLQ
         xiUpzCgw/INtvIB28aL1UqhTIN/Ntt/qIBCT0KHUYp/9WT427erMIiMJWuYVa6ecgnr6
         tm0s7nTrw77oKV3gRtH52RiPFScZHRA31ht283zCgYd8LIBcvH3M2X3/+u+5IAxFp8uh
         IgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742321675; x=1742926475;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9yTXOpfspFFlX2dFyGqhYzfxOn0jR5JT6dXQU7Tt+c=;
        b=Lh+nnokOn0NEYhogfRQprUnXwprFw4Bm+ArktRnTEHARE6DPZGCzAvkH87PK2XQ7Wo
         kiuedkPfhJf8GnDp49QOhvGxj2rkubWKC2L/RSCvbk1hn0rl76ZEN8vfyUpoFEMgzbfD
         L3aB/WLyEbeGvrksAbPxVD+I4oh2K1tvI+/XnsaXlfzJAxCSY5MrucL9sA+JuowidCSO
         06tbQ9oebqrZ7p6GjULMJ7o8eF0QQnYPYO6xrAIacfoaQnbU/sbhBV6jciY8/H/Wjw0o
         gekE0dqgwY1CVt1zDsQC9LDm6eeIkijZ2xPkGqzj4gGoeZV4iyhmrmp7DCsd+PpdFhRW
         CUng==
X-Gm-Message-State: AOJu0YxQqg0gasX2RomclDEAiEmHHbAv8kLPE1wsnI4LjUumRV4B+XBQ
	sW3w5yUWOq+AQyoOhjH1MUN/ocZoty39DMKFsKofJpYMo0wyrf+Kf0u3BdkfjxBqmnYskgRXq93
	5YlPwQfyoDBxvReaAhOoEXqZnIKjQDWP9
X-Gm-Gg: ASbGnctFfaPlScxddG+QA5nRuxwTrBUOCsEnAjngyeBtJDMiDPCio1S2qg0+NCBLQx3
	0IZeQ979oMqXIfS/SFh/7ryrvqZW0YJNDunjoOZrbEKqGzOEhguAVWm6P3EH2X3cLABtEyozdqt
	iLO4G31yfALnUp6u2vr9Ryup5o9lhsRVeDnVIVxngLjk4YrNWdAevcPdYwg35R5TPApJxFPhUmh
	fwJJSUjxp+8P2MNLUwcS9wXDeLYInoevWi7LUFd/mvVjFzEa/HcB3xa7p9HzC7tQiqHAt/UmoDN
	WWB0HXQxyg+2ZUCiPWIC7rEPsTkV8sNKEU1sr5NAjKeqa0tGag==
X-Google-Smtp-Source: AGHT+IGkA9gWSIylsb2QPaqPpZeHcbEZItdb7ElwkxRcjT6QHqKvSuGhVW9da9jJVSDo9jilDAWtKKKxfWXC
X-Received: by 2002:a05:6602:388d:b0:85b:41cc:f709 with SMTP id ca18e2360f4ac-85dc48cd649mr2181365439f.14.1742321675279;
        Tue, 18 Mar 2025 11:14:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f26373684dsm660721173.25.2025.03.18.11.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:14:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 63F883404BD;
	Tue, 18 Mar 2025 12:14:34 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 582CEE404C6; Tue, 18 Mar 2025 12:14:34 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 18 Mar 2025 12:14:17 -0600
Subject: [PATCH] ublk: remove io_cmds list in ublk_queue
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAPi32WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0ML3dKknOz4zPz45NyUYt1EEyNDM1Pj5NS0ZCMloJaCotS0zAqwcdG
 xtbUAezAVn14AAAA=
X-Change-ID: 20250318-ublk_io_cmds-a421653cefc2
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

The current I/O dispatch mechanism - queueing I/O by adding it to the
io_cmds list (and poking task_work as needed), then dispatching it in
ublk server task context by reversing io_cmds and completing the
io_uring command associated to each one - was introduced by commit
7d4a93176e014 ("ublk_drv: don't forward io commands in reserve order")
to ensure that the ublk server received I/O in the same order that the
block layer submitted it to ublk_drv. This mechanism was only needed for
the "raw" task_work submission mechanism, since the io_uring task work
wrapper maintains FIFO ordering (using quite a similar mechanism in
fact). The "raw" task_work submission mechanism is no longer supported
in ublk_drv as of commit 29dc5d06613f2 ("ublk: kill queuing request by
task_work_add"), so the explicit llist/reversal is no longer needed - it
just duplicates logic already present in the underlying io_uring APIs.
Remove it.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 46 +++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2955900ee713c5d8f3cbc2a69f6f6058348e5253..82c9d3d22f0ea5a0fad3f33837fa16146b5af7a9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -77,8 +77,6 @@
 	 UBLK_PARAM_TYPE_DMA_ALIGN)
 
 struct ublk_rq_data {
-	struct llist_node node;
-
 	struct kref ref;
 };
 
@@ -145,8 +143,6 @@ struct ublk_queue {
 	struct task_struct	*ubq_daemon;
 	char *io_cmd_buf;
 
-	struct llist_head	io_cmds;
-
 	unsigned long io_addr;	/* mapped vm address */
 	unsigned int max_io_sz;
 	bool force_abort;
@@ -1113,7 +1109,7 @@ static void ublk_complete_rq(struct kref *ref)
 }
 
 /*
- * Since __ublk_rq_task_work always fails requests immediately during
+ * Since ublk_rq_task_work_cb always fails requests immediately during
  * exiting, __ublk_fail_req() is only called from abort context during
  * exiting. So lock is unnecessary.
  *
@@ -1159,11 +1155,14 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
-static inline void __ublk_rq_task_work(struct request *req,
-				       unsigned issue_flags)
+static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd,
+				 unsigned int issue_flags)
 {
-	struct ublk_queue *ubq = req->mq_hctx->driver_data;
-	int tag = req->tag;
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_queue *ubq = pdu->ubq;
+	int tag = pdu->tag;
+	struct request *req = blk_mq_tag_to_rq(
+		ubq->dev->tag_set.tags[ubq->q_id], tag);
 	struct ublk_io *io = &ubq->ios[tag];
 	unsigned int mapped_bytes;
 
@@ -1238,34 +1237,11 @@ static inline void __ublk_rq_task_work(struct request *req,
 	ubq_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
 }
 
-static inline void ublk_forward_io_cmds(struct ublk_queue *ubq,
-					unsigned issue_flags)
-{
-	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
-	struct ublk_rq_data *data, *tmp;
-
-	io_cmds = llist_reverse_order(io_cmds);
-	llist_for_each_entry_safe(data, tmp, io_cmds, node)
-		__ublk_rq_task_work(blk_mq_rq_from_pdu(data), issue_flags);
-}
-
-static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
-{
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-	struct ublk_queue *ubq = pdu->ubq;
-
-	ublk_forward_io_cmds(ubq, issue_flags);
-}
-
 static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
-	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
+	struct ublk_io *io = &ubq->ios[rq->tag];
 
-	if (llist_add(&data->node, &ubq->io_cmds)) {
-		struct ublk_io *io = &ubq->ios[rq->tag];
-
-		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
-	}
+	io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
 }
 
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
@@ -1458,7 +1434,7 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 			struct request *rq;
 
 			/*
-			 * Either we fail the request or ublk_rq_task_work_fn
+			 * Either we fail the request or ublk_rq_task_work_cb
 			 * will do it
 			 */
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);

---
base-commit: 37f0c10318273bec83f373bbdad14fdc4e8ce79e
change-id: 20250318-ublk_io_cmds-a421653cefc2

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


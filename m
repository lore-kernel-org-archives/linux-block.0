Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E9178CCA
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502634; cv=none; b=Qbqf4uVBVlEKaKjJSstHmWVrlGWUijCAcKc5H0ufJGgAmx/zgU3th9UdJlhCZ7mXmmolKKdbZ4uhADSDYflVom3ewoUluLM2F02xtgsGSJFbXnp97dGPjmW3tb4GYxKN0KHYjO2O6qkKliq3CN4rIjMsA79hk788LX8Svs7vqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502634; c=relaxed/simple;
	bh=zwb3luirc86Hi8AK7fM/UvZ9BtNX3dhxcNAIfQv9kco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J7xwDa2RL9kVVW1ZxIYXMeP5g6ORj6Wutyea48gpU/WUDjeHwetwdFVjwXpXhRmlI7MuX6vMInNGR7VbVKLB3feVpgOdy/ZKulJb72YzK+u5fYkAxW3gdNRA21FOgu+MdSKxYVUbmjk1cimMaxbiTY7c65WSbtTkUYR9d7Uy6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UMTnLtMt; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UMTnLtMt"
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so973215e9.3
        for <linux-block@vger.kernel.org>; Wed, 09 Oct 2024 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1728502630; x=1729107430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rrep64xZTmY27N/s/TSCUZBm+UGau37V4VE/+KohdNQ=;
        b=UMTnLtMtesTgP5W0jSn6UaucUcUEwWDyKLyfE+hNkuFuMLaTCSc44vqGwsnd+hLDg3
         UWICiIVsbCn3odXpYLvMUnFVjIUnyzi0d1+ei/yuXoaCBW87/z6H0DPOl9e3SBYQq42q
         eY6bZOJruVpaeHl5h/Pd9imZVJCKf0k9gM1R3cgS3DVLJIgaOWyG/cpjHn/1w8HBAkEa
         3Mzld7df1F5VCLsozY8JMXvP00TC4tCXxN3HAa8QOLnY9Yw3xxhW+HsQvALCYpdqhqNc
         0MWws7NkQYK7KyhaXGdRMsAhP5aa4ppHzdynNjcnfMxtucM54Gj8heEjqSxhuMkiVH9F
         vW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728502630; x=1729107430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rrep64xZTmY27N/s/TSCUZBm+UGau37V4VE/+KohdNQ=;
        b=ll95aZnaHTKTneL2oTcalQ1PhjcRsJSGdo6kx04tgJ67zpnO5zgqb3M/jVoYrV+Czy
         jnGz3rhOByxbASRte+CGQR/e/se5PZMIERCWBt8Mjrm9PlPUATkBbvNvKZNqGEX54A8S
         Qq/kNJckLfEMkAyYUyQ6cmh3n78funbh9pFhc7XCmVjUMYhRilN2KVSqe4Y1fTo4YyLd
         GIIGblwsl3BlycJz3HaE8pslKf+VS6cbo22gfqazF50+04m5Xc8J0KhPzWBuKt5iERCK
         XXiRaL+iQoX3LTp9IvUU9V1nQhPsFBPU+SHdzpWfjqPv0ThraDFxeZ1QDHQ2Xo56bNpy
         xINg==
X-Forwarded-Encrypted: i=1; AJvYcCV02V1Gjsbxtj+GbdljI2xjssRpQDlbtaDw4Ly1NdlUbgG/bhxs2J6AgOME6s0eYb9iTG/g7VgBIR5O2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQhVDvDFEqsFS/IdB3z8K4uOTiLyD+oFwO3EF8uJy77Pt0yiy
	kge2wuljLQpg72i58p3nEU8MAPNskaoLTacIWhncFQpolH1vRdMUy9owq3MoXH2kKeWn+lhicgh
	SZC364eTUA1OJT9rRqws9LSciyCcMu0x8VKsta1U3wmMyTUuI
X-Google-Smtp-Source: AGHT+IHZKmh4xKpQfB1xPM70BK1nShjI9PIgc0iHVpQcHwnuuBO+smCn0LxZRypui+24zD/2g2bIBX2H3iwN
X-Received: by 2002:a05:600c:1f11:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-430d70a0ee5mr25744105e9.27.1728502630266;
        Wed, 09 Oct 2024 12:37:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-430d59b2c42sm344925e9.40.2024.10.09.12.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 12:37:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F1AB934063A;
	Wed,  9 Oct 2024 13:37:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E3E65E40EBC; Wed,  9 Oct 2024 13:37:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH] ublk: eliminate unnecessary io_cmds queue
Date: Wed,  9 Oct 2024 13:37:00 -0600
Message-Id: <20241009193700.3438201-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, ublk_drv maintains a per-hctx queue of requests awaiting
dispatch to the ublk server, and pokes the ubq_daemon to come pick them
up via the task_work mechanism when needed. But task_work already
supports internal (lockless) queueing. Reuse this queueing mechanism
(i.e. have one task_work queue item per request awaiting dispatch)
instead of maintaining our own queue in ublk_drv.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 60f6d86ea1e6..2ea108347ec4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -80,6 +80,7 @@ struct ublk_rq_data {
 
 struct ublk_uring_cmd_pdu {
 	struct ublk_queue *ubq;
+	struct request *req;
 	u16 tag;
 };
 
@@ -141,8 +142,6 @@ struct ublk_queue {
 	struct task_struct	*ubq_daemon;
 	char *io_cmd_buf;
 
-	struct llist_head	io_cmds;
-
 	unsigned long io_addr;	/* mapped vm address */
 	unsigned int max_io_sz;
 	bool force_abort;
@@ -1132,9 +1131,10 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
-static inline void __ublk_rq_task_work(struct request *req,
+static inline void __ublk_rq_task_work(struct io_uring_cmd *cmd,
 				       unsigned issue_flags)
 {
+	struct request *req = ublk_get_uring_cmd_pdu(cmd)->req;
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
@@ -1211,34 +1211,12 @@ static inline void __ublk_rq_task_work(struct request *req,
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
-
-	if (llist_add(&data->node, &ubq->io_cmds)) {
-		struct ublk_io *io = &ubq->ios[rq->tag];
+	struct ublk_io *io = &ubq->ios[rq->tag];
 
-		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
-	}
+	ublk_get_uring_cmd_pdu(io->cmd)->req = rq;
+	io_uring_cmd_complete_in_task(io->cmd, __ublk_rq_task_work);
 }
 
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)

base-commit: 7a84944a4bf7abda16291ff13984960d0df4e74a
-- 
2.34.1


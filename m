Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D291DE2C4
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185119; cv=none; b=JqbITlOI0Vx+KRS+3yLvBILpP/4skYH9WJkmpGDQFg873eiBny8GNJzpSFfVef79IJR4oSzcMMjFcT0G4BMSZYpIgQkqq4Z+Jk1rsFeQDrZKqZauIywr0hs6cdxyGxtC9VLUgazRk2m2j68pzznk4LBaNLdfUsY99eFm69plrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185119; c=relaxed/simple;
	bh=rX6aI6CfqNKgjOLNzaJ1NxOuUJze/mq2YTseKrDo0O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIDM+9qE2YisHt/2Q1brxMnrNOk9K21EOh2LR+H+9c4qXbzbLc7wTPuo3dBcnluT2CJcLHMWWaHuOjgptQNp5YNSEzs/7Nen2C1X4WKOGHbevkhU1wIO0Ku2IhJUl1RUMLBHNo9eg6WC1E0NcoW9J+KrQ+dDWie0c85pCBvVKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JoGN+PXI; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JoGN+PXI"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so566103a91.1
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743185116; x=1743789916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtpDew/eD8ba5wvcK2WBBEkoLN0/liTxOdyF+pn4Qyc=;
        b=JoGN+PXIi+t9V231MaIEtiilm6o9EGEaPlGVxIC2Qa4JROskcIndXGEUROycPjlqSU
         W3o9utUIQi8zC3/AHCN3adSJ9z+oODR9wWLqpBYsoSJaqPLZckCwS91MlJrI/kA24C6O
         nPmM0wqGSTFjX20YSiarCN8euJlsG7e4qgQPWw27SB2F/JnJpF7d3lrba2uPbm4FpA4a
         9j97rt6yRUCWYSuHG58uxd1D9MrMOFUa4V7AAq+dvLK0jbEXKa5BNn+cQd4B862XOrpB
         DbbBHXu3LuQ8seVttiFG7TYupnRiwO+Z8jk2WM3x7k+0wfT56bfGM6LqAAY7S9rREFYX
         l24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743185116; x=1743789916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtpDew/eD8ba5wvcK2WBBEkoLN0/liTxOdyF+pn4Qyc=;
        b=vLNVaMhrWJ1+4XEML79120sio4bd67BSGdXMg6myQ6STRXgZXfo0Y5ATKdzO1Bpn0k
         mQFFOOlPXpXF5RvOIlC59Vt+4vEowTPXENO0dGlq40JqnLAmAUi417yfrkhMBUv8lnPN
         +bPc1Y3CblDKiUU23uLJdyf6ONt4HMiYbLGEd7jD6hYiAYVRlscoS8cwp22Q8XlwzDXn
         7aiDV6BAYfBP+MOp02vrQn5pUnYAbgki66iGvnX4VpUJbkgr5vahyA2SfSz+NYaR0SKj
         obOEmP93KgyBus8W0fWs8F4szhI8o4F01b0vP0wpJcvpdP8/Clt3TWuNngtR9X+53Mas
         dVyQ==
X-Gm-Message-State: AOJu0YzaZjwJ6LX6Ufa40LWJHXFWcX2XoM13yjz1OCNvIT7NSyleX7Yz
	+JscxQDfuUrfw+r0p7NQnstx3g03CuTlH65McTn9B3N0lbjdelLXHRhk6dApH5VsuRqW3lf+F8P
	OmJKN4SelTrW301RxpLsELN3ZRlGIKXBQRsPc96q7sFgC1sDD
X-Gm-Gg: ASbGnctTpg/vxBuPJYCXQl/f2ylo+Ty/duANMavjpS1i8sYaGA2Cxq3RWi4GyIZfNrR
	LQ8OleDJyuKtZMN/NByDQIQMqRDNkkAtVvmFy5SaaUeukyFfPP/0y6DImXNy8FHseUs/8izjPPy
	Ac17mhPsHw9pLQ0z1jTVPk2gJGIONkU7zzZ5jS7q7Uy8px3+giGi386l0X+D1JycKXmUC5cYmn6
	1YZ24psAI10HkK+YQhl56E6dq/V1WlfPdFxIBGdkPmWC2yE16AdZjyroXIhucT501GnJAVgJd+B
	77ypsc+uvPLuGH3QcgmsCrMOHjPfC2+B7w==
X-Google-Smtp-Source: AGHT+IESDjVpHJqj9O/gJwm20/6fgVGc5WGyQTfH3ybkt3onnBkmBYQ3O5YYLMDEqF4wpu1Fan9NngLOzE57
X-Received: by 2002:a17:90b:388b:b0:2ff:6ac2:c5ae with SMTP id 98e67ed59e1d1-30531f7bef6mr146827a91.1.1743185115754;
        Fri, 28 Mar 2025 11:05:15 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-305175cae25sm308791a91.14.2025.03.28.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 11:05:15 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2FBB7340721;
	Fri, 28 Mar 2025 12:05:15 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 26A48E40ADA; Fri, 28 Mar 2025 12:04:45 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/5] ublk: remove unused cmd argument to ublk_dispatch_req()
Date: Fri, 28 Mar 2025 12:04:07 -0600
Message-ID: <20250328180411.2696494-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328180411.2696494-1-csander@purestorage.com>
References: <20250328180411.2696494-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_dispatch_req() never uses its struct io_uring_cmd *cmd argument.
Drop it so callers don't have to pass a value.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 355a59c78539..39efe443e235 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1183,11 +1183,10 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 	else
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
 static void ublk_dispatch_req(struct ublk_queue *ubq,
-			      struct io_uring_cmd *cmd,
 			      struct request *req,
 			      unsigned int issue_flags)
 {
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
@@ -1271,11 +1270,11 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
 	struct ublk_queue *ubq = pdu->ubq;
 	int tag = pdu->tag;
 	struct request *req = blk_mq_tag_to_rq(
 		ubq->dev->tag_set.tags[ubq->q_id], tag);
 
-	ublk_dispatch_req(ubq, cmd, req, issue_flags);
+	ublk_dispatch_req(ubq, req, issue_flags);
 }
 
 static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
 	struct ublk_io *io = &ubq->ios[rq->tag];
@@ -1290,15 +1289,13 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
 	struct request *rq = pdu->req_list;
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
 	struct request *next;
 
 	while (rq) {
-		struct ublk_io *io = &ubq->ios[rq->tag];
-
 		next = rq->rq_next;
 		rq->rq_next = NULL;
-		ublk_dispatch_req(ubq, io->cmd, rq, issue_flags);
+		ublk_dispatch_req(ubq, rq, issue_flags);
 		rq = next;
 	}
 }
 
 static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
-- 
2.45.2


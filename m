Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F49B640
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750641596; cv=none; b=WhUoYTW+HIeEBhYoo7YcjBhyAQ4C1Va+ejqSEM7MgFmj90p6PJR0dewDjI2yN7belQ8uh9v2K6kTG0giuHADmsNqnI3v5tv2gzmO51SGsc5LPX1fQeUBQUW2d++RJwVYFdvZjRdIz6k8hZOJoKmpivtRbIwNK8U5Inco4CybJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750641596; c=relaxed/simple;
	bh=GQq/xFoZ95/t+jgPnhLwXMvV+X+isiRh93d7xZqyRQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5Imn9QTfbCwm1W1et3ZUvrMosneIJ85Fj159x3K0PC6mZOgTR1fHzOLMpre+O4z2FQJA2loxsAzBHCpAIXc+WTwKBn5octbPOyIGxECJDMxSQMPk8xFRQZKVPu0e5oaVisu1iJyBW8lllAvqJbYTsmK9808GlQ4RSNGbjNluR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkCAmc0X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkCAmc0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750641593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/Nu2pMQ98PTf6PUPUR0So1hiHYmcIcY4Kqabe20v3M=;
	b=PkCAmc0X8soflRUzIjN4RRvyzO0cvYuBrx+Potkjoeg2smNtNxXk7LImlgxehnYaqAe0hp
	FwstRR8bw23nWQqQosmVZJfp2Y1mskBRWTJYWvI0IxvPzD2Xw+Wu5HXXA5klse6WpAMIgl
	nX1+xP99UDSQ0LJAe85pVjeK0iEZGQI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-v9RAax3MN9uFUFU-4m5bWw-1; Sun,
 22 Jun 2025 21:19:48 -0400
X-MC-Unique: v9RAax3MN9uFUFU-4m5bWw-1
X-Mimecast-MFC-AGG-ID: v9RAax3MN9uFUFU-4m5bWw_1750641587
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3670E1800287;
	Mon, 23 Jun 2025 01:19:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.88])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 119531956096;
	Mon, 23 Jun 2025 01:19:45 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] ublk: build per-io-ring-ctx batch list
Date: Mon, 23 Jun 2025 09:19:26 +0800
Message-ID: <20250623011934.741788-2-ming.lei@redhat.com>
In-Reply-To: <20250623011934.741788-1-ming.lei@redhat.com>
References: <20250623011934.741788-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

ublk_queue_cmd_list() dispatches the whole batch list by scheduling task
work via the tail request's io_uring_cmd, this way is fine even though
more than one io_ring_ctx are involved for this batch since it is just
one running context.

However, the task work handler ublk_cmd_list_tw_cb() takes `issue_flags`
of tail uring_cmd's io_ring_ctx for completing all commands. This way is
wrong if any uring_cmd is issued from different io_ring_ctx.

Fixes it by always building per-io-ring-ctx batch list.

For typical per-queue or per-io daemon implementation, this way shouldn't
make difference from performance viewpoint, because single io_ring_ctx is
often taken in each daemon.

Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")
Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue daemon")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c637ea010d34..e79b04e61047 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1336,9 +1336,8 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
 	} while (rq);
 }
 
-static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
+static void ublk_queue_cmd_list(struct io_uring_cmd *cmd, struct rq_list *l)
 {
-	struct io_uring_cmd *cmd = io->cmd;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
 	pdu->req_list = rq_list_peek(l);
@@ -1420,16 +1419,18 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
 {
 	struct rq_list requeue_list = { };
 	struct rq_list submit_list = { };
-	struct ublk_io *io = NULL;
+	struct io_uring_cmd *cmd = NULL;
 	struct request *req;
 
 	while ((req = rq_list_pop(rqlist))) {
 		struct ublk_queue *this_q = req->mq_hctx->driver_data;
-		struct ublk_io *this_io = &this_q->ios[req->tag];
+		struct io_uring_cmd *this_cmd = this_q->ios[req->tag].cmd;
 
-		if (io && io->task != this_io->task && !rq_list_empty(&submit_list))
-			ublk_queue_cmd_list(io, &submit_list);
-		io = this_io;
+		if (cmd && io_uring_cmd_ctx_handle(cmd) !=
+				io_uring_cmd_ctx_handle(this_cmd) &&
+				!rq_list_empty(&submit_list))
+			ublk_queue_cmd_list(cmd, &submit_list);
+		cmd = this_cmd;
 
 		if (ublk_prep_req(this_q, req, true) == BLK_STS_OK)
 			rq_list_add_tail(&submit_list, req);
@@ -1438,7 +1439,7 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
 	}
 
 	if (!rq_list_empty(&submit_list))
-		ublk_queue_cmd_list(io, &submit_list);
+		ublk_queue_cmd_list(cmd, &submit_list);
 	*rqlist = requeue_list;
 }
 
-- 
2.47.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C46F53E
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731666; cv=none; b=qOoKRo1ZkFkZliw/axcyCiiLBUogmKM4PLo7sCjpZcV43CVNgtGleF5l+pgCQG8U1hNVyqLjpCcVVoLItg+BLcKcItXhsB94PBKvZe3iauBa3CMu7EPeqjz1Q6+opaM3E8QGjkDaZYpOF7gEspzRy79dtE0rsa30cvtPHA1EUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731666; c=relaxed/simple;
	bh=G3i0fBiSLjkfGIGfx7O5YHKGkmDgzI+HWHTUZ+e8jtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXUsgmrZ5doEjAQrvFaP8vkXr8MIvs8rPgS156e6SVg8XXVTzYuIFUNKJSFM13yvHlTe4jrZCpGfcmtFCYGWduLra1fJDPk7a14BHa+VvMTTGDWbfP9m9dm5Zf/8/QYKodWybfyAfVUy5JRGc0sGonCIX0pSz46xWxYzfH75AhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDRxKMfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDRxKMfW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750731662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DHC53hFFch4rVMkDa1cnZAF2cnisRrFdIgpsQxVJCV8=;
	b=jDRxKMfWiO9xxip8IPjA7Z7Q0vPsw/bAvA2FuHp040Equ8Do30Ew0WczYrbu2kISDE54I6
	OD6tpsOfCzkYlBAsZL13RhcNmoTMzdqnDKvBxHex4w9BxWmjNHgcxm1KwU3adqao5+Erde
	2zSSi2VOrt5D3bDeYNw5f0VvC41F7Wc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-cJHRMyuuObyhcHV3lpf-qA-1; Mon,
 23 Jun 2025 22:20:58 -0400
X-MC-Unique: cJHRMyuuObyhcHV3lpf-qA-1
X-Mimecast-MFC-AGG-ID: cJHRMyuuObyhcHV3lpf-qA_1750731657
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E1D5195608E;
	Tue, 24 Jun 2025 02:20:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4438718003FC;
	Tue, 24 Jun 2025 02:20:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Changhui Zhong <czhong@redhat.com>
Subject: [PATCH] ublk: setup ublk_io correctly in case of ublk_get_data() failure
Date: Tue, 24 Jun 2025 10:20:49 +0800
Message-ID: <20250624022049.825370-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If ublk_get_data() fails, -EIOCBQUEUED is returned and the current command
becomes ASYNC. And the only reason is that mapping data can't move on,
because of no enough pages or pending signal, then the current ublk request
has to be requeued.

Once the request need to be requeued, we have to setup `ublk_io` correctly,
including io->cmd and flags, otherwise the request may not be forwarded to
ublk server successfully.

Fixes: 9810362a57cb ("ublk: don't call ublk_dispatch_req() for NEED_GET_DATA")
Reported-by: Changhui Zhong <czhong@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAGVVp+VN9QcpHUz_0nasFf5q9i1gi8H8j-G-6mkBoqa3TyjRHA@mail.gmail.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d36f44f5ee80..03ac394c69a7 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1148,8 +1148,8 @@ static inline void __ublk_complete_rq(struct request *req)
 	blk_mq_end_request(req, res);
 }
 
-static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req,
-				 int res, unsigned issue_flags)
+static struct io_uring_cmd *__ublk_prep_compl_io_cmd(struct ublk_io *io,
+						     struct request *req)
 {
 	/* read cmd first because req will overwrite it */
 	struct io_uring_cmd *cmd = io->cmd;
@@ -1164,6 +1164,13 @@ static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req,
 	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
 
 	io->req = req;
+	return cmd;
+}
+
+static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req,
+				 int res, unsigned issue_flags)
+{
+	struct io_uring_cmd *cmd = __ublk_prep_compl_io_cmd(io, req);
 
 	/* tell ublksrv one io request is coming */
 	io_uring_cmd_done(cmd, res, 0, issue_flags);
@@ -2148,10 +2155,9 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	return 0;
 }
 
-static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
+static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
+			  struct request *req)
 {
-	struct request *req = io->req;
-
 	/*
 	 * We have handled UBLK_IO_NEED_GET_DATA command,
 	 * so clear UBLK_IO_FLAG_NEED_GET_DATA now and just
@@ -2178,6 +2184,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
 	int ret = -EINVAL;
+	struct request *req;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
@@ -2237,10 +2244,19 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		io->addr = ub_cmd->addr;
-		if (!ublk_get_data(ubq, io))
-			return -EIOCBQUEUED;
-
-		return UBLK_IO_RES_OK;
+		/*
+		 * ublk_get_data() may fail and fallback to requeue, so keep
+		 * uring_cmd active first and prepare for handling new requeued
+		 * request
+		 */
+		req = io->req;
+		ublk_fill_io_cmd(io, cmd, io->addr);
+		io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
+		if (likely(ublk_get_data(ubq, io, req))) {
+			__ublk_prep_compl_io_cmd(io, req);
+			return UBLK_IO_RES_OK;
+		}
+		break;
 	default:
 		goto out;
 	}
-- 
2.49.0


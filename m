Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBA227E8C
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775709; cv=none; b=YnUMCUKB4MJ5DfKgg2b3+KXEJB1nQIm0b9HFHK3Tr1HnwQn5sgnbmp+oua7SAq9zyc9Hg4Y2c0q2TiS7QXkbUWWv54gQYNQT0920PnMkP78E218f0oZMjX0Gy4royXZqmCojP5YYAAEjF6+XV8gtIa+e4vYiAdWUWQdLLf+S6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775709; c=relaxed/simple;
	bh=v+FFiD/papFMMYuDyB2MUsGMRYMWgJFFkuiMYhbZu2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAjvflZbtnAiTgCvctVICJOv2/EYN9yncCqD1WOZ3ArbwAo6Tzl+nQ01xKcl4xf1YjL+d3oKoO5UOLqL2HuyRVZCZPPB5x5oNUEa4f+wEeNbBgt9mLM4mGw70QL/Q+6VVW/9xzxKqH0eiA2WbB2+z1CZvAunrqiemYPLdu5DcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayST7ExB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayST7ExB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744775703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KILrcwXdz+888fnlHOLvo5Tmh82UsUl/qqfsiKb1wL0=;
	b=ayST7ExBg3a7eE3sg6A/VxOeqExjd9qiiO+1GeWV9h2wfVxZYFhSShnLtfJXo8mx2CgdwM
	7O7uvEN77kGkU7DdcD9V9AkJWCjYv4d0WSywYIwcfalH8l10NbwgYBV7PRlXrqcgibtWnQ
	/c6q21lUSBPsQz8o3M2LtL15g8INZeo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-DrbMEXNIO6i_pSa7HP0g9A-1; Tue,
 15 Apr 2025 23:55:00 -0400
X-MC-Unique: DrbMEXNIO6i_pSa7HP0g9A-1
X-Mimecast-MFC-AGG-ID: DrbMEXNIO6i_pSa7HP0g9A_1744775699
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFF7419560BB;
	Wed, 16 Apr 2025 03:54:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EEC5180B489;
	Wed, 16 Apr 2025 03:54:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/8] ublk: properly serialize all FETCH_REQs
Date: Wed, 16 Apr 2025 11:54:35 +0800
Message-ID: <20250416035444.99569-2-ming.lei@redhat.com>
In-Reply-To: <20250416035444.99569-1-ming.lei@redhat.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Uday Shankar <ushankar@purestorage.com>

Most uring_cmds issued against ublk character devices are serialized
because each command affects only one queue, and there is an early check
which only allows a single task (the queue's ubq_daemon) to issue
uring_cmds against that queue. However, this mechanism does not work for
FETCH_REQs, since they are expected before ubq_daemon is set. Since
FETCH_REQs are only used at initialization and not in the fast path,
serialize them using the per-ublk-device mutex. This fixes a number of
data races that were previously possible if a badly behaved ublk server
decided to issue multiple FETCH_REQs against the same qid/tag
concurrently.

Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 77 +++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cdb1543fa4a9..bf47f9cb8329 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1832,8 +1832,8 @@ static void ublk_nosrv_work(struct work_struct *work)
 
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+	__must_hold(&ub->mutex)
 {
-	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
 		ubq->ubq_daemon = current;
@@ -1845,7 +1845,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
 		complete_all(&ub->completion);
-	mutex_unlock(&ub->mutex);
 }
 
 static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
@@ -1929,6 +1928,52 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
+static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
+		      struct ublk_io *io, __u64 buf_addr)
+{
+	struct ublk_device *ub = ubq->dev;
+	int ret = 0;
+
+	/*
+	 * When handling FETCH command for setting up ublk uring queue,
+	 * ub->mutex is the innermost lock, and we won't block for handling
+	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
+	 */
+	mutex_lock(&ub->mutex);
+	/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
+	if (ublk_queue_ready(ubq)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* allow each command to be FETCHed at most once */
+	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * FETCH_RQ has to provide IO buffer if NEED GET
+		 * DATA is not enabled
+		 */
+		if (!buf_addr && !ublk_need_get_data(ubq))
+			goto out;
+	} else if (buf_addr) {
+		/* User copy requires addr to be unset */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ublk_fill_io_cmd(io, cmd, buf_addr);
+	ublk_mark_io_ready(ub, ubq);
+out:
+	mutex_unlock(&ub->mutex);
+	return ret;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1985,33 +2030,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
-		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
-		if (ublk_queue_ready(ubq)) {
-			ret = -EBUSY;
-			goto out;
-		}
-		/*
-		 * The io is being handled by server, so COMMIT_RQ is expected
-		 * instead of FETCH_REQ
-		 */
-		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			goto out;
-
-		if (ublk_need_map_io(ubq)) {
-			/*
-			 * FETCH_RQ has to provide IO buffer if NEED GET
-			 * DATA is not enabled
-			 */
-			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-				goto out;
-		} else if (ub_cmd->addr) {
-			/* User copy requires addr to be unset */
-			ret = -EINVAL;
+		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
+		if (ret)
 			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-- 
2.47.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D7BA4A
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721002; cv=none; b=iSH2S2Rhjf7e5ZeYsIbjw24adNoQ7G2FfrwIkoicof6Ww9eVfLjSS+5kgqaLIFb5zP29WIwIRaQr4bb2HJqG9XUnGodL/V4HsJbAvQe7FTwYOI26OQvSOy66xOuWFGJrJq+br0LnJRQn6XKXY3I1QMBq0CSVfIK9HFO2cZqb3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721002; c=relaxed/simple;
	bh=ZwKXvn2NY6eh98SndTpjKIwaw10t82lluOPLflGP16A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvZiClarotQbge9aPCK9lr3otC8eA6mRQuaa/luoWR0TJzF77ntzn4hJvNY6OMiUe3ZVUFEzXxNFQAyPMmtuQyS+/8QOVU+h84DiAbebNNicgvVO2GEULf4PRVSz06XvkZAzuqM9+wgzA+69Z7HD2Hu6aavm37hjmA6SodclNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLsNzt6X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLsNzt6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756720999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BX37ilCsgLqpdYs8/AU294jP9cDK9d7yL2yp0hVovaI=;
	b=YLsNzt6XE+HmilOEiolhgIsGtaCj8AZVHTnLhm0jkT9TKzAXO6BTdQuetzIh++JiRv0qVF
	Yww8vA5Ii3PBmQ9hN889h7wDsXnd0nr5fQIXx0UWpr/FArbzmSo6riIlGH/PvvDNP48sDL
	4wwNYQvFDoXeDe/BMb3RcWEQvjn65mM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-eHUJrR8RMRqkRuKaKxB8Mg-1; Mon,
 01 Sep 2025 06:03:16 -0400
X-MC-Unique: eHUJrR8RMRqkRuKaKxB8Mg-1
X-Mimecast-MFC-AGG-ID: eHUJrR8RMRqkRuKaKxB8Mg_1756720995
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68B62195605C;
	Mon,  1 Sep 2025 10:03:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4DDAD19560B4;
	Mon,  1 Sep 2025 10:03:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 06/23] ublk: prepare for not tracking task context for command batch
Date: Mon,  1 Sep 2025 18:02:23 +0800
Message-ID: <20250901100242.3231000-7-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

batch io is designed to be independent of task context, and we will not
track task context for batch io feature.

So warn on non-batch-io code paths.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a0dfad8a56f0..46be5b656f22 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -261,6 +261,11 @@ static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
 	return false;
 }
 
+static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
+{
+	return false;
+}
+
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -1309,6 +1314,8 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 			__func__, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
 
+	WARN_ON_ONCE(ublk_support_batch_io(ubq));
+
 	/*
 	 * Task is exiting if either:
 	 *
@@ -1868,6 +1875,8 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (WARN_ON_ONCE(pdu->tag >= ubq->q_depth))
 		return;
 
+	WARN_ON_ONCE(ublk_support_batch_io(ubq));
+
 	task = io_uring_cmd_get_task(cmd);
 	io = &ubq->ios[pdu->tag];
 	if (WARN_ON_ONCE(task && task != io->task))
@@ -2233,7 +2242,10 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 
 	ublk_fill_io_cmd(io, cmd);
 
-	WRITE_ONCE(io->task, get_task_struct(current));
+	if (ublk_support_batch_io(ubq))
+		WRITE_ONCE(io->task, NULL);
+	else
+		WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub, ubq);
 out:
 	return ret;
@@ -2347,6 +2359,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	if (tag >= ubq->q_depth)
 		goto out;
 
+	WARN_ON_ONCE(ublk_support_batch_io(ubq));
+
 	io = &ubq->ios[tag];
 	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
 	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
-- 
2.47.0


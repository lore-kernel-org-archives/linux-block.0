Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61D8836
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417320; cv=none; b=ezeTs420SevnPytYYo0nTWvvd0rAz5/cH7Jpja0AqJF+HgMAJX3/8o8mNIuwEihcOY9EgSogZKdiU4JJw5MNBrwvVBaMZO7q8gonayVETBshKVERH21vbNSwAnQdDT8caQi2rpajr0yM+YpiGLSwcQug/e16Qv3TbiPwTUfu74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417320; c=relaxed/simple;
	bh=dzbkPE516w6k/iLm7yVoJrUCiCdWXU2i297I2FG4e8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnUtC74tKhnc89aGgsDUGp8URTv5f5YihPCfLuJ/aDN5bFVveTkO5XuOuoV6bHUEjyKonkc3AUhqlvXjUN/TeVkatoqGAFomez6YkWzaeT/UnR4/aZL2LyqiUEdTnFpfc5ZSTYg7NKSvHPqhwWeo+KY3vWUN0R9YnThV2NAvhpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmTBufDP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmTBufDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VR2yNtXlulHtdTDDu02l0EO+nzuREFGwC3YLdd0sD9E=;
	b=FmTBufDPt6oXUt1NUes0zI6UDR+E/AltK/SqxPMiThPSoCUw2OuQQl5uHFJ51zHB1le8eu
	xCP8dTgM6q6SWYrM8zb0eUpIhuN79mX8mXPrF3qrHiVhBwlklKS7swgnc4V6URrCh4hNjX
	Gaf/XgTi+JPQjUdhnQAahcZBF2nWG2A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-zISJpxYlNL6T79AGiYfFdg-1; Sun,
 13 Jul 2025 10:35:13 -0400
X-MC-Unique: zISJpxYlNL6T79AGiYfFdg-1
X-Mimecast-MFC-AGG-ID: zISJpxYlNL6T79AGiYfFdg_1752417312
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69FF519560AA;
	Sun, 13 Jul 2025 14:35:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AAA7180035C;
	Sun, 13 Jul 2025 14:35:08 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 09/17] ublk: remove ublk_commit_and_fetch()
Date: Sun, 13 Jul 2025 22:34:04 +0800
Message-ID: <20250713143415.2857561-10-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Remove ublk_commit_and_fetch() and open code request completion.

Consolidate accesses to struct ublk_io in UBLK_IO_COMMIT_AND_FETCH_REQ. When
the ublk_io daemon task restriction is relaxed in the future, ublk_io will
need to be protected by a lock. Unregister the auto-registered buffer and
complete the request last, as these don't need to happen under the lock.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1b22fd5f5610..252cae345b3a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -714,13 +714,12 @@ static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
 		__ublk_complete_rq(req);
 }
 
-static inline void ublk_sub_req_ref(struct ublk_io *io, struct request *req)
+static inline bool ublk_sub_req_ref(struct ublk_io *io, struct request *req)
 {
 	unsigned sub_refs = UBLK_REFCOUNT_INIT - io->task_registered_buffers;
 
 	io->task_registered_buffers = 0;
-	if (refcount_sub_and_test(sub_refs, &io->ref))
-		__ublk_complete_rq(req);
+	return refcount_sub_and_test(sub_refs, &io->ref);
 }
 
 static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
@@ -2243,21 +2242,13 @@ static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
 	return 0;
 }
 
-static void ublk_commit_and_fetch(const struct ublk_queue *ubq,
-				  struct ublk_io *io, struct io_uring_cmd *cmd,
-				  struct request *req, unsigned int issue_flags,
-				  __u64 zone_append_lba, u16 buf_idx)
+static bool ublk_need_complete_req(const struct ublk_queue *ubq,
+				   struct ublk_io *io,
+				   struct request *req)
 {
-	if (buf_idx != UBLK_INVALID_BUF_IDX)
-		io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
-
-	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = zone_append_lba;
-
 	if (ublk_need_req_ref(ubq))
-		ublk_sub_req_ref(io, req);
-	else
-		__ublk_complete_rq(req);
+		return ublk_sub_req_ref(io, req);
+	return true;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
@@ -2290,6 +2281,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	unsigned tag = ub_cmd->tag;
 	struct request *req;
 	int ret;
+	bool compl;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
@@ -2367,8 +2359,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		io->res = ub_cmd->result;
 		req = ublk_fill_io_cmd(io, cmd);
 		ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &buf_idx);
-		ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
-				      ub_cmd->zone_append_lba, buf_idx);
+		compl = ublk_need_complete_req(ubq, io, req);
+
+		/* can't touch 'ublk_io' any more */
+		if (buf_idx != UBLK_INVALID_BUF_IDX)
+			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
+		if (req_op(req) == REQ_OP_ZONE_APPEND)
+			req->__sector = ub_cmd->zone_append_lba;
+		if (compl)
+			__ublk_complete_rq(req);
+
 		if (ret)
 			goto out;
 		break;
-- 
2.47.0


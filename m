Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92474D8CE
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937512; cv=none; b=kmWrUMaBn3N4NrWd0dWhiku/a8rnf4yPQGaZ8UjWA4v8XzCEpWaHgGMEryvmq6IG5gZpW2fDR/+fFhVjyHOxrVAC8N3LLEJQhzNyVwz/F1wsiFcPnJQx8UGk/wUj2wrqQGkFbBlB27wsPYXiFbZ/I4gVCVjq2gibrs7xJ3Aks/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937512; c=relaxed/simple;
	bh=wp1Prw4/aCjFtcSChTH+qC+ZVIA3CiIT4WwgyJ2YtQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teADA/IpzwpSEU/JEVtkWTIIXHOwUoB6/RKfOAn5iOSCSB/V9vjd8fO7t5mGAGERabnAegMN71sEZ1RNyqDIVVR0Dr8Yt0jQVoeJJXuSg1EN9jvVoeAIBaItvErNO4krfrEbkCRTJgLTp37scJ4Fcz1rJd0D2l57I0PRBLylAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fov3GpIZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fov3GpIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NysqmRDkIJ8aL16EM+RU/6CsjxpBISlyBT69nFe1eC4=;
	b=fov3GpIZ9Z6azmqFbl0Eb5vKwpUMA/MLv39vzhauLyCJ6Y5qZCG4y8SDv1dNlY2fgHCbVk
	k3/klvGgDRpjDfHa8zJoyhFx6ZU9KaT+Rb6RKFB0Ta31JJUXjmEQlqWEO4N3aBhLNY9ysX
	tjaZ1M1jXSeVAsHOVSRAsolLINlpivs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-Zhvr5puhNMWfr2kkcbPETQ-1; Mon,
 07 Jul 2025 21:18:25 -0400
X-MC-Unique: Zhvr5puhNMWfr2kkcbPETQ-1
X-Mimecast-MFC-AGG-ID: Zhvr5puhNMWfr2kkcbPETQ_1751937503
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C81BC180028B;
	Tue,  8 Jul 2025 01:18:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC5B21956087;
	Tue,  8 Jul 2025 01:18:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 08/16] ublk: remove ublk_commit_and_fetch()
Date: Tue,  8 Jul 2025 09:17:35 +0800
Message-ID: <20250708011746.2193389-9-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Remove ublk_commit_and_fetch() and open code request completion.

Now request reference is stored in 'ublk_io', which becomes one global
variable, the motivation is to centralize access 'struct ublk_io' reference,
then we can introduce lock to protect `ublk_io` in future for supporting
io batch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0e12fb67867e..4fb5614a3910 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -713,13 +713,12 @@ static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
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
@@ -2242,21 +2241,13 @@ static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
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
@@ -2289,6 +2280,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	unsigned tag = ub_cmd->tag;
 	struct request *req;
 	int ret;
+	bool compl;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
@@ -2365,8 +2357,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		req = ublk_fill_io_cmd(io, cmd, ub_cmd->result);
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


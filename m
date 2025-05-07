Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8EE78C9C
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592785; cv=none; b=V0YgT0lWJdWTklq2sugtKTiL4lMMWoMqplVS1M2polJSXN+6TkDe+Tr4boyft7lHIImzNdGyqmlg2ivGRQDTDDN8Tj02hJc5m4XnpJYR9Ick8RC+9s9Er5uYfrxiBBfCt6ihZJ9xj3i3466XhZrxSDcTdpiWnvJ+LPxp4ckC9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592785; c=relaxed/simple;
	bh=+mN9RKh5wEc05XuFYT9UjzLJPXwVBhnC6AX0bVgc330=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJ8fOfdlEqzZQ7MywS3RTJCq4LK3mnCqvLvzjt/c14eLY3XxAFA8l3GxRljK9LWHUOcBVSEHsQssHfLrVPPle6kwFlaHh199ZoR09aCiIKTqnGyHp31VPiGlUHcz8ZJxh47Y6ReKFCzlOlnELozTx+exFsiU+x69BCw5qNCPphs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVew2UhV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVew2UhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746592783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heM7eK8qvsl1dfiClskybSFA2urX2CgbKN2highw1xU=;
	b=bVew2UhV8lUhiUqilaEKo1h9RJC3uFW5GNttaEWHLDZMw9KFnJwmBOzDnfpkwZcb8KQvtY
	uB5VhGBKUiuLxtq5GGm2y0M24/6ryXKZaqNjj1HLPJUmy7qwRRxEco8suByn4s+XCxbBvs
	9ZL7tT0weKb//HZCqt49iNLqlmlfb7g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-MWvjaFAZO0ePjokU05S31A-1; Wed,
 07 May 2025 00:39:34 -0400
X-MC-Unique: MWvjaFAZO0ePjokU05S31A-1
X-Mimecast-MFC-AGG-ID: MWvjaFAZO0ePjokU05S31A_1746592773
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B2161954198;
	Wed,  7 May 2025 04:39:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E01E819560AF;
	Wed,  7 May 2025 04:39:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/6] ublk: prepare for supporting to register request buffer automatically
Date: Wed,  7 May 2025 12:38:54 +0800
Message-ID: <20250507043859.2978132-4-ming.lei@redhat.com>
In-Reply-To: <20250507043859.2978132-1-ming.lei@redhat.com>
References: <20250507043859.2978132-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

UBLK_F_SUPPORT_ZERO_COPY requires ublk server to issue explicit buffer
register/unregister uring_cmd for each IO, this way is not only inefficient,
but also introduce dependency between buffer consumer and buffer register/
unregister uring_cmd, please see tools/testing/selftests/ublk/stripe.c
in which backing file IO has to be issued one by one by IOSQE_IO_LINK.

Prepare for adding feature UBLK_F_AUTO_BUF_REG for addressing the existing
zero copy limitation:

- register request buffer automatically to ublk uring_cmd's io_uring
  context before delivering io command to ublk server

- unregister request buffer automatically from the ublk uring_cmd's
  io_uring context when completing the request

- io_uring will unregister the buffer automatically when uring is
  exiting, so we needn't worry about accident exit

For using this feature, ublk server has to create one sparse buffer table

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 72 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 768de19cd7a5..87de455bec46 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -133,6 +133,14 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
 
+/*
+ * request buffer is registered automatically, so we have to unregister it
+ * before completing this request.
+ *
+ * io_uring will unregister buffer automatically for us during exiting.
+ */
+#define UBLK_IO_FLAG_AUTO_BUF_REG 	0x10
+
 /* atomic RW with ubq->cancel_lock */
 #define UBLK_IO_FLAG_CANCELED	0x80000000
 
@@ -205,6 +213,7 @@ struct ublk_params_header {
 	__u32	types;
 };
 
+static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
@@ -620,6 +629,11 @@ static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
 	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
 }
 
+static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
+{
+	return false;
+}
+
 static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_USER_COPY;
@@ -627,7 +641,8 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 
 static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
 {
-	return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq);
+	return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq) &&
+		!ublk_support_auto_buf_reg(ubq);
 }
 
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
@@ -638,8 +653,13 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 	 *
 	 * for zero copy, request buffer need to be registered to io_uring
 	 * buffer table, so reference is needed
+	 *
+	 * For auto buffer register, ublk server still may issue
+	 * UBLK_IO_COMMIT_AND_FETCH_REQ before one registered buffer is used up,
+	 * so reference is required too.
 	 */
-	return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq);
+	return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq) ||
+		ublk_support_auto_buf_reg(ubq);
 }
 
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
@@ -1156,6 +1176,34 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
+static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
+			      unsigned int issue_flags)
+{
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+	int ret;
+
+	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release, 0,
+				      issue_flags);
+	if (ret) {
+		blk_mq_end_request(req, BLK_STS_IOERR);
+		return false;
+	}
+	/* one extra reference is dropped by ublk_io_release */
+	refcount_set(&data->ref, 2);
+	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
+	return true;
+}
+
+static bool ublk_prep_buf_reg(struct ublk_queue *ubq, struct request *req,
+			      struct ublk_io *io, unsigned int issue_flags)
+{
+	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
+		return ublk_auto_buf_reg(req, io, issue_flags);
+
+	ublk_init_req_ref(ubq, req);
+	return true;
+}
+
 static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 			  struct ublk_io *io)
 {
@@ -1181,7 +1229,6 @@ static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 			mapped_bytes >> 9;
 	}
 
-	ublk_init_req_ref(ubq, req);
 	return true;
 }
 
@@ -1227,7 +1274,8 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
+	if (ublk_prep_buf_reg(ubq, req, io, issue_flags))
+		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
 }
 
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
@@ -1993,9 +2041,17 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	return ret;
 }
 
+static void ublk_auto_buf_unreg(struct ublk_io *io, struct io_uring_cmd *cmd,
+				struct request *req, unsigned int issue_flags)
+{
+	WARN_ON_ONCE(io_buffer_unregister_bvec(cmd, 0, issue_flags));
+	io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
+}
+
 static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 				 struct ublk_io *io, struct io_uring_cmd *cmd,
-				 const struct ublksrv_io_cmd *ub_cmd)
+				 const struct ublksrv_io_cmd *ub_cmd,
+				 unsigned int issue_flags)
 {
 	struct request *req = io->req;
 
@@ -2015,6 +2071,9 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		return -EINVAL;
 	}
 
+	if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
+		ublk_auto_buf_unreg(io, cmd, req, issue_flags);
+
 	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 
 	/* now this cmd slot is owned by ublk driver */
@@ -2046,6 +2105,7 @@ static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
 			__func__, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
 
+	ublk_init_req_ref(ubq, req);
 	return ublk_start_io(ubq, req, io);
 }
 
@@ -2124,7 +2184,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd);
+		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
 		if (ret)
 			goto out;
 		break;
-- 
2.47.0


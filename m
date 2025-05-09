Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E220E6F3
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803200; cv=none; b=A+22ybtCPDJazagYhceQgRv10i/ElS/GUB/FMxQPqzLTNhL9TuPYdNa6kNZo7sbzsRiewhnPwnW0S/u7bR6/6jfMipkfm4VjhMmARUilIOhDcvjPElZ9k625NofAM8Q1+ByVsYZlxAJKAlyPMIXRrlABOIOO/uyUaiZTsGjRB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803200; c=relaxed/simple;
	bh=kWwBTYcpgh8dGgbgjyzXErRrQhWiaQZi757tvq0BpW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF8Hr/HSbvRXnjGMcMfVidqq0DxEqy7xYALX9oqLXrqVS78jJU4oCZ/vwfAnr2K3HXjfJoy5JZYNkR2On78A4cczjImpUowTLVUU+TUUa5ugagiaJSK1eNrTm/0xPtOWcPPvrsX5oZWdkV10m7hRdKhPzfY4dmYQM7PJYRkuvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoirU8eU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoirU8eU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746803197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYeknLPs3CkYxEV0pRRQ6zitEWwOtd6e1AsC7OivXuM=;
	b=FoirU8eU0uVPeB3q5hd5TbXEwXj3BJvxWxYBgTrKLa6KxBDylrYPKL3PbEUlKj/4Y91zlW
	c6M+6MqaKdGW1E1udNdsjfeigBXvywfTJIaNKMqNi/70QYrKxJWge3z1RS1jGsfzdS3EkG
	jWo5rSvdXwi8in1W0R3sUpgNZA7IKxA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-QVIB8domPy2GVGeNOwxy4w-1; Fri,
 09 May 2025 11:06:34 -0400
X-MC-Unique: QVIB8domPy2GVGeNOwxy4w-1
X-Mimecast-MFC-AGG-ID: QVIB8domPy2GVGeNOwxy4w_1746803193
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 771FE1800874;
	Fri,  9 May 2025 15:06:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.140])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91289195607A;
	Fri,  9 May 2025 15:06:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/6] ublk: prepare for supporting to register request buffer automatically
Date: Fri,  9 May 2025 23:06:06 +0800
Message-ID: <20250509150611.3395206-4-ming.lei@redhat.com>
In-Reply-To: <20250509150611.3395206-1-ming.lei@redhat.com>
References: <20250509150611.3395206-1-ming.lei@redhat.com>
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
index ab5b0a5e98e9..1f98e561dc38 100644
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
@@ -619,6 +628,11 @@ static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
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
@@ -626,7 +640,8 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 
 static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
 {
-	return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq);
+	return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq) &&
+		!ublk_support_auto_buf_reg(ubq);
 }
 
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
@@ -637,8 +652,13 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
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
@@ -1155,6 +1175,35 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
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
+static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
+				   struct request *req, struct ublk_io *io,
+				   unsigned int issue_flags)
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
@@ -1180,7 +1229,6 @@ static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 			mapped_bytes >> 9;
 	}
 
-	ublk_init_req_ref(ubq, req);
 	return true;
 }
 
@@ -1226,7 +1274,8 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
-	ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
+	if (ublk_prep_auto_buf_reg(ubq, req, io, issue_flags))
+		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
 }
 
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
@@ -1992,9 +2041,16 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	return ret;
 }
 
+static void ublk_auto_buf_unreg(struct ublk_io *io, unsigned int issue_flags)
+{
+	WARN_ON_ONCE(io_buffer_unregister_bvec(io->cmd, 0, issue_flags));
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
 
@@ -2023,6 +2079,9 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ub_cmd->zone_append_lba;
 
+	if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
+		ublk_auto_buf_unreg(io, issue_flags);
+
 	if (likely(!blk_should_fake_timeout(req->q)))
 		ublk_put_req_ref(ubq, req);
 
@@ -2045,6 +2104,7 @@ static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
 			__func__, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
 
+	ublk_init_req_ref(ubq, req);
 	return ublk_start_io(ubq, req, io);
 }
 
@@ -2123,7 +2183,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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


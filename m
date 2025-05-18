Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC63FC7
	for <linux-block@vger.kernel.org>; Sun, 18 May 2025 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747574018; cv=none; b=Ug9mrz/HdZio7M+2NVhm0UON05wrhycy6dzoNOLGKr1zfkhYEzvHIqTdKxWUU6ISshw1gynD+qSF3+JPclTrAqjxOQVbtBAm2+JQsKUO6Qf7uIUisxBhlevdomzhcWd7xSkA72UpTXJ47oodgSYAyXCu352/2x3FHDVmTpyvKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747574018; c=relaxed/simple;
	bh=UFIjHjmU2QNhdcKBRaXcZ401JSuMqE9W04Y8bWlZvHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7+nFhw6BHH9jiX8jalWirlS//lD+3OFs/mMjT/CiBTnTzC46seC/yR/8LkucJtNBw/6LYT71uJpyvZz8ARHR/0cXK6t8kDoYXkpZIiZJ5wxn8l+RgA3CNGZWom8LVQmQzpumzNib4N26UVUODkefWrn34ivruDwrWox12fANTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BshTVhRn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BshTVhRn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747574015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWrgYKwoQSjxWhtAVslVV7zAEJZ+69GJu5xYo9xO3Qs=;
	b=BshTVhRnnL2UeIbN9MuyHGx41edilw5kE+AnsHXPY9/zUKIYBEli+J5dm57pkU6sgMWhPF
	sbC9FTjwFY8KnX6tHMZA2efddQklvEK95molC5bB/a4ksf6Q89PPgPk34y5GWqioTF0wMd
	ZG2Qkn3tZWMyLnXAHnTjKao+SuK731c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-ke1zUcz8PoyHF-xSdV7JdQ-1; Sun,
 18 May 2025 09:13:31 -0400
X-MC-Unique: ke1zUcz8PoyHF-xSdV7JdQ-1
X-Mimecast-MFC-AGG-ID: ke1zUcz8PoyHF-xSdV7JdQ_1747574010
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98AA31956089;
	Sun, 18 May 2025 13:13:30 +0000 (UTC)
Received: from localhost (unknown [10.72.116.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4272819560AA;
	Sun, 18 May 2025 13:13:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 2/6] ublk: prepare for supporting to register request buffer automatically
Date: Sun, 18 May 2025 21:12:57 +0800
Message-ID: <20250518131303.195957-3-ming.lei@redhat.com>
In-Reply-To: <20250518131303.195957-1-ming.lei@redhat.com>
References: <20250518131303.195957-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 71 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ae2f47dc8224..d0fd783c5404 100644
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
 
@@ -2110,7 +2169,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6175224256
	for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745660500; cv=none; b=H0QIybeYY1g6GacQtfj69cRRTjbkuCzEoe2hFzhvjNK9BwdvO1tdPzIjpT1uE/9yWdmRYv5V3ezG4hJblQ/3ilWZrWOgSJI77zWuXUg50Xla5nAAMnLAQk5TJfZppU/tvK2D8xSRFgCHK1MzxpjbTLEibXOYwQ1K+TyHmu51wRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745660500; c=relaxed/simple;
	bh=jnhhKwbCLcTfRMCKmqOs0ISMaU3PBGrpc2TRJb0Y2Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+S+nAko9ed2j2uAxv6RT3yWo4YvpjV8vTTjPJi9bXDOE7uifmwjQDoKVhWwaWG56ySgOASCZubG6iQ56F4ED8jkYmTETJWmnFMjLJjKUhcIQFZ1c6/08TWUZsiWwY3LoS7EYbpFIajVrlvXHFTzxYIZsvWhC9S5Q1BBTsUS+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNB5T6dv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNB5T6dv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745660496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XB4MPSEAcQ8AYhDGLJkDhSdX+H3l3D/5v1Tut47cIGQ=;
	b=CNB5T6dvMlNWf6E46//nPjIZqgeRNzBo24zDQw82FtU6hQuR1iM9gHrS5Z7YGDBQOpn/4G
	kMDlQGU+I0xBwPH0mZLzajv0tcyVTLH7V7xYRqqe1c4iXz7QKUpwC744Tz9+7zwA424XxS
	TaWIetBaBoVG1YIB6iP3spvUbyMqhag=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-Sn59mBD3NfCBRjb1ExcvqQ-1; Sat,
 26 Apr 2025 05:41:34 -0400
X-MC-Unique: Sn59mBD3NfCBRjb1ExcvqQ-1
X-Mimecast-MFC-AGG-ID: Sn59mBD3NfCBRjb1ExcvqQ_1745660493
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 465281956086;
	Sat, 26 Apr 2025 09:41:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63547180045B;
	Sat, 26 Apr 2025 09:41:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] ublk: add feature UBLK_F_AUTO_ZERO_COPY
Date: Sat, 26 Apr 2025 17:41:08 +0800
Message-ID: <20250426094111.1292637-4-ming.lei@redhat.com>
In-Reply-To: <20250426094111.1292637-1-ming.lei@redhat.com>
References: <20250426094111.1292637-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

UBLK_F_SUPPORT_ZERO_COPY requires ublk server to issue explicit buffer
register/unregister uring_cmd for each IO, this way is not only inefficient,
but also introduce dependency between buffer consumer and buffer register/
unregister uring_cmd, please see tools/testing/selftests/ublk/stripe.c
in which backing file IO has to be issued one by one by IOSQE_IO_LINK.

Add feature UBLK_F_AUTO_ZERO_COPY for addressing the existed zero copy
limit:

- register request buffer automatically before delivering io command to
ublk server

- unregister request buffer automatically when completing the request

- io_uring will unregister the buffer automatically when uring is
  exiting, so we needn't worry about accident exit

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 87 +++++++++++++++++++++++++++--------
 include/uapi/linux/ublk_cmd.h | 20 ++++++++
 2 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 347790b3a633..453767f91431 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -64,7 +64,8 @@
 		| UBLK_F_CMD_IOCTL_ENCODE \
 		| UBLK_F_USER_COPY \
 		| UBLK_F_ZONED \
-		| UBLK_F_USER_RECOVERY_FAIL_IO)
+		| UBLK_F_USER_RECOVERY_FAIL_IO \
+		| UBLK_F_AUTO_ZERO_COPY)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -131,6 +132,14 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
 
+/*
+ * request buffer is registered automatically, so we have to unregister it
+ * before completing this request.
+ *
+ * io_uring will unregister buffer automatically for us during exiting.
+ */
+#define UBLK_IO_FLAG_UNREG_BUF 	0x10
+
 /* atomic RW with ubq->cancel_lock */
 #define UBLK_IO_FLAG_CANCELED	0x80000000
 
@@ -207,7 +216,8 @@ static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 						   int tag);
 static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
 {
-	return ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
+	return ub->dev_info.flags & (UBLK_F_USER_COPY |
+			UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_AUTO_ZERO_COPY);
 }
 
 static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
@@ -614,6 +624,11 @@ static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
 	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
 }
 
+static inline bool ublk_support_auto_zc(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_AUTO_ZERO_COPY;
+}
+
 static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 {
 	return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
@@ -621,7 +636,7 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 
 static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
 {
-	return !ublk_support_user_copy(ubq);
+	return !ublk_support_user_copy(ubq) && !ublk_support_auto_zc(ubq);
 }
 
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
@@ -629,17 +644,21 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 	/*
 	 * read()/write() is involved in user copy, so request reference
 	 * has to be grabbed
+	 *
+	 * For auto zc, ublk server still may issue UBLK_IO_COMMIT_AND_FETCH_REQ
+	 * before one registered buffer is used up, so reference is
+	 * required too.
 	 */
-	return ublk_support_user_copy(ubq);
+	return ublk_support_user_copy(ubq) || ublk_support_auto_zc(ubq);
 }
 
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
-		struct request *req)
+		struct request *req, int init_ref)
 {
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		kref_init(&data->ref);
+		refcount_set(&data->ref.refcount, init_ref);
 	}
 }
 
@@ -667,6 +686,15 @@ static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
 	}
 }
 
+/* for ublk zero copy */
+static void ublk_io_release(void *priv)
+{
+	struct request *rq = priv;
+	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+
+	ublk_put_req_ref(ubq, rq);
+}
+
 static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_NEED_GET_DATA;
@@ -1231,7 +1259,22 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 			mapped_bytes >> 9;
 	}
 
-	ublk_init_req_ref(ubq, req);
+	if (ublk_support_auto_zc(ubq) && ublk_rq_has_data(req)) {
+		int ret;
+
+		/* one extra reference is dropped by ublk_io_release */
+		ublk_init_req_ref(ubq, req, 2);
+		ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release,
+					      tag, issue_flags);
+		if (ret) {
+			blk_mq_end_request(req, BLK_STS_IOERR);
+			return;
+		}
+		io->flags |= UBLK_IO_FLAG_UNREG_BUF;
+	} else {
+		ublk_init_req_ref(ubq, req, 1);
+	}
+
 	ubq_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
 }
 
@@ -1593,7 +1636,8 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 }
 
 static void ublk_commit_completion(struct ublk_device *ub,
-		const struct ublksrv_io_cmd *ub_cmd)
+		const struct ublksrv_io_cmd *ub_cmd,
+		unsigned int issue_flags)
 {
 	u32 qid = ub_cmd->q_id, tag = ub_cmd->tag;
 	struct ublk_queue *ubq = ublk_get_queue(ub, qid);
@@ -1604,6 +1648,15 @@ static void ublk_commit_completion(struct ublk_device *ub,
 	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
 	io->res = ub_cmd->result;
 
+	if (io->flags & UBLK_IO_FLAG_UNREG_BUF) {
+		int ret;
+
+		ret = io_buffer_unregister_bvec(io->cmd, tag, issue_flags);
+		if (ret)
+			io->res = ret;
+		io->flags &= ~UBLK_IO_FLAG_UNREG_BUF;
+	}
+
 	/* find the io request and complete */
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
 	if (WARN_ON_ONCE(unlikely(!req)))
@@ -1942,14 +1995,6 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
 }
 
-static void ublk_io_release(void *priv)
-{
-	struct request *rq = priv;
-	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-
-	ublk_put_req_ref(ubq, rq);
-}
-
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				struct ublk_queue *ubq, unsigned int tag,
 				unsigned int index, unsigned int issue_flags)
@@ -2124,7 +2169,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		}
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_commit_completion(ub, ub_cmd);
+		ublk_commit_completion(ub, ub_cmd, issue_flags);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
@@ -2730,6 +2775,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		return -EINVAL;
 	}
 
+	/* F_AUTO_ZERO_COPY and F_SUPPORT_ZERO_COPY can't co-exist */
+	if ((info.flags & UBLK_F_AUTO_ZERO_COPY) &&
+			(info.flags & UBLK_F_SUPPORT_ZERO_COPY))
+		return -EINVAL;
+
 	/*
 	 * unprivileged device can't be trusted, but RECOVERY and
 	 * RECOVERY_REISSUE still may hang error handling, so can't
@@ -2747,7 +2797,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		 * buffer by pwrite() to ublk char device, which can't be
 		 * used for unprivileged device
 		 */
-		if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY))
+		if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
+					UBLK_F_AUTO_ZERO_COPY))
 			return -EINVAL;
 	}
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 583b86681c93..d8bb5e55cce7 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -211,6 +211,26 @@
  */
 #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
 
+/*
+ * request buffer is registered automatically before delivering this io
+ * command to ublk server, meantime it is un-registered automatically
+ * when completing this io command.
+ *
+ * request tag has to be used as the buffer index, and ublk server has to
+ * pass this IO's tag as buffer index for using the registered zero copy
+ * buffer
+ *
+ * This way avoids extra uring_cmd cost, but also simplifies backend
+ * implementation, such as, the dependency on IO_REGISTER_IO_BUF and
+ * IO_UNREGISTER_IO_BUF becomes not necessary.
+ *
+ * For using this feature, ublk server has to register buffer table
+ * in sparse way, and buffer number has to be >= ublk queue depth.
+ *
+ * This feature is preferred to UBLK_F_SUPPORT_ZERO_COPY.
+ */
+#define UBLK_F_AUTO_ZERO_COPY 	(1ULL << 10)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.47.0


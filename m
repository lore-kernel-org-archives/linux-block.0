Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580F13AF2
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937532; cv=none; b=Mx1cqcQAKjOkid9uPNIX9xhS2M7ADu5SK/GUcBeS9PfKQbg5lrs9S1B7ZfEvl3xIq1QH2gcS32Z1YT0QlxGTM7nghCUCh1qjMnfgQ9g9F2NuyZJwNoXrfzr+fFydvzsJpCRi+dPWGAZ6FlI+/256LP//jELKIJMgHkm4//rjwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937532; c=relaxed/simple;
	bh=YGgTQjWggtbz+89Mi5v6iLG/IUVjL8HZ0iMxY1XGDNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3l2L3sJwoSmvrOuDkLLtwsBAl/Fcp4kz7aFneCnUc3wPdW3GGPDRZhtnCEZMhEGeVyBoneRTnhT1kY73ls4zlGxkzDjNrQSwbjVWr2RpzNSbXP8ceDo+t2JqL6paGcpgAoFIJQ2mjqmWwROXdjm6nojxW09R9zNYaNMdLd7K6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCbJP1v1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCbJP1v1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jQ/ehBs5900+o0xC/B7JrujQLSDwrC1RfvehwuIoLI=;
	b=BCbJP1v1gFXM56HhKpJMcDVm7l74rRwOELDRf6HHWVE/GbklBdUe1haHwZTROy4LY3QOVQ
	pvyr+5dPbDErIGsXxD/kR4CX0v67pb0wp+7Wbqi+CTpK29qe8aUi8DJ/npMl3rYjFbGIwu
	MhYBlKAHfBasR8v3Utwb2h02Ct48xgQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-ohzn82giN_Kq--bFAaVaBQ-1; Mon,
 07 Jul 2025 21:18:43 -0400
X-MC-Unique: ohzn82giN_Kq--bFAaVaBQ-1
X-Mimecast-MFC-AGG-ID: ohzn82giN_Kq--bFAaVaBQ_1751937522
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA91A1955EC3;
	Tue,  8 Jul 2025 01:18:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A59961956095;
	Tue,  8 Jul 2025 01:18:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 13/16] selftests: ublk: remove ublk queue self-defined flags
Date: Tue,  8 Jul 2025 09:17:40 +0800
Message-ID: <20250708011746.2193389-14-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove ublk queue self-defined flags, and use the uapi flags directly.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 25 +++++++++----------------
 tools/testing/selftests/ublk/kublk.h | 22 +++++++++++++++-------
 tools/testing/selftests/ublk/null.c  |  2 +-
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 944e0806ba05..e90260468652 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -441,17 +441,10 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 	unsigned long off;
 
 	q->tgt_ops = dev->tgt.ops;
-	q->state = 0;
+	q->flags = 0;
 	q->q_depth = depth;
-
-	if (dev->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_AUTO_BUF_REG)) {
-		q->state |= UBLKSRV_NO_BUF;
-		if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY)
-			q->state |= UBLKSRV_ZC;
-		if (dev->dev_info.flags & UBLK_F_AUTO_BUF_REG)
-			q->state |= UBLKSRV_AUTO_BUF_REG;
-	}
-	q->state |= extra_flags;
+	q->flags = dev->dev_info.flags;
+	q->flags |= extra_flags;
 
 	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
 	off = UBLKSRV_CMD_BUF_OFFSET + q->q_id * ublk_queue_max_cmd_buf_sz();
@@ -469,7 +462,7 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 		q->ios[i].flags = UBLKSRV_NEED_FETCH_RQ | UBLKSRV_IO_FREE;
 		q->ios[i].tag = i;
 
-		if (q->state & UBLKSRV_NO_BUF)
+		if (ublk_queue_no_buf(q))
 			continue;
 
 		if (posix_memalign((void **)&q->ios[i].buf_addr,
@@ -583,7 +576,7 @@ static void ublk_set_auto_buf_reg(const struct ublk_queue *q,
 	else
 		buf.index = q->ios[tag].buf_index;
 
-	if (q->state & UBLKSRV_AUTO_BUF_REG_FALLBACK)
+	if (ublk_queue_auto_zc_fallback(q))
 		buf.flags = UBLK_AUTO_BUF_REG_FALLBACK;
 
 	sqe->addr = ublk_auto_buf_reg_to_sqe_addr(&buf);
@@ -639,12 +632,12 @@ int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 	sqe[0]->rw_flags	= 0;
 	cmd->tag	= io->tag;
 	cmd->q_id	= q->q_id;
-	if (!(q->state & UBLKSRV_NO_BUF))
+	if (!ublk_queue_no_buf(q))
 		cmd->addr	= (__u64) (uintptr_t) io->buf_addr;
 	else
 		cmd->addr	= 0;
 
-	if (q->state & UBLKSRV_AUTO_BUF_REG)
+	if (ublk_queue_use_auto_zc(q))
 		ublk_set_auto_buf_reg(q, sqe[0], io->tag);
 
 	user_data = build_user_data(io->tag, _IOC_NR(cmd_op), 0, q->q_id, 0);
@@ -739,7 +732,7 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 
 	if (cqe->res < 0 && cqe->res != -ENODEV)
 		ublk_err("%s: res %d userdata %llx queue state %x\n", __func__,
-				cqe->res, cqe->user_data, q->state);
+				cqe->res, cqe->user_data, q->flags);
 
 	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (qid %d tag %u cmd_op %u target %d/%d) stopping %d\n",
 			__func__, cqe->res, q->q_id, tag, cmd_op,
@@ -911,7 +904,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	const struct ublksrv_ctrl_dev_info *dinfo = &dev->dev_info;
 	struct ublk_thread_info *tinfo;
-	unsigned extra_flags = 0;
+	unsigned long long extra_flags = 0;
 	cpu_set_t *affinity_buf;
 	void *thread_ret;
 	sem_t ready;
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index a4049984b055..9ecb63bc930e 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -178,12 +178,10 @@ struct ublk_queue {
 	const struct ublk_tgt_ops *tgt_ops;
 	struct ublksrv_io_desc *io_cmd_buf;
 
+/* borrow one bit of ublk uapi flags, which may never be used */
+#define UBLKSRV_AUTO_BUF_REG_FALLBACK	(1ULL << 63)
+	__u64 flags;
 	struct ublk_io ios[UBLK_QUEUE_DEPTH];
-#define UBLKSRV_NO_BUF		(1U << 2)
-#define UBLKSRV_ZC		(1U << 3)
-#define UBLKSRV_AUTO_BUF_REG		(1U << 4)
-#define UBLKSRV_AUTO_BUF_REG_FALLBACK	(1U << 5)
-	unsigned state;
 };
 
 struct ublk_thread {
@@ -437,12 +435,22 @@ static inline int ublk_completed_tgt_io(struct ublk_thread *t,
 
 static inline int ublk_queue_use_zc(const struct ublk_queue *q)
 {
-	return q->state & UBLKSRV_ZC;
+	return q->flags & UBLK_F_SUPPORT_ZERO_COPY;
 }
 
 static inline int ublk_queue_use_auto_zc(const struct ublk_queue *q)
 {
-	return q->state & UBLKSRV_AUTO_BUF_REG;
+	return q->flags & UBLK_F_AUTO_BUF_REG;
+}
+
+static inline int ublk_queue_auto_zc_fallback(const struct ublk_queue *q)
+{
+	return q->flags & UBLKSRV_AUTO_BUF_REG_FALLBACK;
+}
+
+static inline int ublk_queue_no_buf(const struct ublk_queue *q)
+{
+	return ublk_queue_use_zc(q) || ublk_queue_use_auto_zc(q);
 }
 
 extern const struct ublk_tgt_ops null_tgt_ops;
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 452dcc369c8b..f0e0003a4860 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -138,7 +138,7 @@ static int ublk_null_queue_io(struct ublk_thread *t, struct ublk_queue *q,
  */
 static unsigned short ublk_null_buf_index(const struct ublk_queue *q, int tag)
 {
-	if (q->state & UBLKSRV_AUTO_BUF_REG_FALLBACK)
+	if (ublk_queue_auto_zc_fallback(q))
 		return (unsigned short)-1;
 	return q->ios[tag].buf_index;
 }
-- 
2.47.0


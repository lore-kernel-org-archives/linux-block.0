Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30A13AF2
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937534; cv=none; b=To105rBeTWj7qC+2+01Z/jS0hZxwNlr8zbn4VIEBVmbpmMAHbFgkYK92Not/RbCscxSb9l/0rhAtFaV14MvFUBaMXrTQb7xrVCzK15H2NGCLdceL5G8F/K4eSA6CIAkZMmoY3xvP/aR8ZuM5nCfVYqHBtRvWt/v3fgpjImKzYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937534; c=relaxed/simple;
	bh=7/YFTrKvSvXq/E/5LPGt1sYWLRCqjKSt451lvzE02IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuIouRx37yMzRtH6N1z1oTOpR7/pdMwpZK7dWX0WlMXp2UI9XI8JJRqnwzBPm8pB7dG24DrqKqYqS/WmHP9w1VuZyI/yQOrcHuFjLEFqG4QvLR5fyN0DWhS0O2Qv5LXt7Ww+M1i1QnEdnV5I3Tm3xom4rDNBiq9YHaSAVn9zOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAn6Pct3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAn6Pct3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXvv2QZAj4do7bSIvtrfxo3ZF0V3gNDmfW3exEDyZSo=;
	b=ZAn6Pct3M13z3PGaHPymt1HJSX/q125yDUB7IIspfXalCLk6XlUXQIvbdE3QSmTSiYUlxV
	Bv0i89RQob52B2+GB9vn7vVrLfWejnY+7yO6td4jjJQi1RN5U83solb2ojZnGoVE5Sxz9Z
	CRCZHJE5eiNyZzUvScxNq6jORtQRJNY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-PbVlPnzoO9qxrGlt8Ok_xg-1; Mon,
 07 Jul 2025 21:18:51 -0400
X-MC-Unique: PbVlPnzoO9qxrGlt8Ok_xg-1
X-Mimecast-MFC-AGG-ID: PbVlPnzoO9qxrGlt8Ok_xg_1751937530
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C58919560AD;
	Tue,  8 Jul 2025 01:18:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2694419560AB;
	Tue,  8 Jul 2025 01:18:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 15/16] selftests: ublk: add helper ublk_handle_uring_cmd() for handle ublk command
Date: Tue,  8 Jul 2025 09:17:42 +0800
Message-ID: <20250708011746.2193389-16-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add helper ublk_handle_uring_cmd() for handling ublk command, and make
ublk_handle_cqe() more readable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 61 ++++++++++++++++------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 84307bc12f37..95188065b2e9 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -718,36 +718,14 @@ static inline void ublksrv_handle_tgt_cqe(struct ublk_thread *t,
 		q->tgt_ops->tgt_io_done(t, q, cqe);
 }
 
-static void ublk_handle_cqe(struct ublk_thread *t,
-		struct io_uring_cqe *cqe, void *data)
+static void ublk_handle_uring_cmd(struct ublk_thread *t,
+				  struct ublk_queue *q,
+				  const struct io_uring_cqe *cqe)
 {
-	struct ublk_dev *dev = t->dev;
-	unsigned q_id = user_data_to_q_id(cqe->user_data);
-	struct ublk_queue *q = &dev->q[q_id];
-	unsigned tag = user_data_to_tag(cqe->user_data);
-	unsigned cmd_op = user_data_to_op(cqe->user_data);
 	int fetch = (cqe->res != UBLK_IO_RES_ABORT) &&
 		!(t->state & UBLKS_T_STOPPING);
-	struct ublk_io *io;
-
-	if (cqe->res < 0 && cqe->res != -ENODEV)
-		ublk_err("%s: res %d userdata %llx queue state %x\n", __func__,
-				cqe->res, cqe->user_data, q->flags);
-
-	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (qid %d tag %u cmd_op %u target %d/%d) stopping %d\n",
-			__func__, cqe->res, q->q_id, tag, cmd_op,
-			is_target_io(cqe->user_data),
-			user_data_to_tgt_data(cqe->user_data),
-			(t->state & UBLKS_T_STOPPING));
-
-	/* Don't retrieve io in case of target io */
-	if (is_target_io(cqe->user_data)) {
-		ublksrv_handle_tgt_cqe(t, q, cqe);
-		return;
-	}
-
-	io = &q->ios[tag];
-	t->cmd_inflight--;
+	unsigned tag = user_data_to_tag(cqe->user_data);
+	struct ublk_io *io = &q->ios[tag];
 
 	if (!fetch) {
 		t->state |= UBLKS_T_STOPPING;
@@ -774,6 +752,35 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 	}
 }
 
+static void ublk_handle_cqe(struct ublk_thread *t,
+		struct io_uring_cqe *cqe, void *data)
+{
+	struct ublk_dev *dev = t->dev;
+	unsigned q_id = user_data_to_q_id(cqe->user_data);
+	struct ublk_queue *q = &dev->q[q_id];
+	unsigned cmd_op = user_data_to_op(cqe->user_data);
+
+	if (cqe->res < 0 && cqe->res != -ENODEV)
+		ublk_err("%s: res %d userdata %llx queue state %x\n", __func__,
+				cqe->res, cqe->user_data, q->flags);
+
+	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (qid %d tag %u cmd_op %u target %d/%d) stopping %d\n",
+			__func__, cqe->res, q->q_id, user_data_to_tag(cqe->user_data),
+			cmd_op, is_target_io(cqe->user_data),
+			user_data_to_tgt_data(cqe->user_data),
+			(t->state & UBLKS_T_STOPPING));
+
+	/* Don't retrieve io in case of target io */
+	if (is_target_io(cqe->user_data)) {
+		ublksrv_handle_tgt_cqe(t, q, cqe);
+		return;
+	}
+
+	t->cmd_inflight--;
+
+	ublk_handle_uring_cmd(t, q, cqe);
+}
+
 static int ublk_reap_events_uring(struct ublk_thread *t)
 {
 	struct io_uring_cqe *cqe;
-- 
2.47.0


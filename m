Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04D8836
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417352; cv=none; b=EudBO8P263Sf85/fSjQJnlEilNgo13wxaGqC1Aolx8fRsSt+rCp/QjUnt2G7EQSbBZwZTXkSG0IiHNqce7V2+Wq1zY9VNOMJHPucy6oOEwAz+xIY28i33UkLX8bL18KUKmOg5z7T/+VWwdeBkum8niA/OGy6pqzuSyHoaRWDD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417352; c=relaxed/simple;
	bh=7/YFTrKvSvXq/E/5LPGt1sYWLRCqjKSt451lvzE02IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tgx+STq9dRTy4CoysJ/83kQDEdr5IATw+M4salxKRQ5yhLpBdnn8/co6kinPq20ElPSG+87VR2RsuCUF84ko+wfD0R/k2lG970uxKf/2/OBDqnKdyRKuV6DS55UsYnJQSOyz2hy6yxmlxNDN/4cDPpwTaKAxHA1YUMhUirJChfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUUokDx2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUUokDx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXvv2QZAj4do7bSIvtrfxo3ZF0V3gNDmfW3exEDyZSo=;
	b=KUUokDx2vKtNxZl/k4wTvJo1H/eyaJDi4N7CXAbrNAJyrWT7G6RhkAu4GovVC2BVMkppV8
	6zuwLjfwi2wKVts+P+cMqpAr3KY2h19urpt/J/b12eqLNQXtalELmbT+G4q9VB3gP+mU7t
	wOR9HSu3kTJZP8DprGW6jOjLOMJNGGc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-v8cIWixDOg-OXgWAOCXHjQ-1; Sun,
 13 Jul 2025 10:35:45 -0400
X-MC-Unique: v8cIWixDOg-OXgWAOCXHjQ-1
X-Mimecast-MFC-AGG-ID: v8cIWixDOg-OXgWAOCXHjQ_1752417344
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CEF8180029E;
	Sun, 13 Jul 2025 14:35:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C2FE1956094;
	Sun, 13 Jul 2025 14:35:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 16/17] selftests: ublk: add helper ublk_handle_uring_cmd() for handle ublk command
Date: Sun, 13 Jul 2025 22:34:11 +0800
Message-ID: <20250713143415.2857561-17-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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


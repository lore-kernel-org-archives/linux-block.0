Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531C279795
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417292; cv=none; b=tStWdX1j+rWyLP1KaedP4SnumHYDCf0EsoL033D5xhW9AfehRxBfUpBXPa8DQNhv5i2snrotenUeEXJYEnwLyYo6Nrfdx+SS9satPd8amUL/H++83N9NSWTdj8aUp2rVZLUjU8Y/2ZlZ1DeU9Lbu162w5nXjjy/WGxTpy9mqAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417292; c=relaxed/simple;
	bh=Z31f5hJon4N1SRu3INenQJ0Pa0CLNCM14YDfN816Ndc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SusKYInJ//MsTfw581LlO+f7ikGzCEOTfpjTUdjzE+f4azATovDVOFqA59DSnYaBX9tcSjB6MRsNULP0SzjewCXGegd12Kk/g6zZa5J1ovRZYjAu+bdH7ZzJT1ZaZBpPMpelgqyTLAX4ri9k5tcVBMjr69XRuGNddzTzr1ci1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3zIGUru; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3zIGUru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49/WvqR/JICad3SoLnNeg9YAZmieZmRHhvb2HnIy+LI=;
	b=D3zIGUru6GE+9oEGXQF7+3EyUOVYYOYX2szUB19+Cka5+2FzyYdGUzJl38pLUWWi5dn0aQ
	0Jm8i2eLK2jh++0Y2OoG3zCdFMfzLvqwu+pt189t6Ls1ho9q87aQcIhsI2/FKeju7TLTQ7
	WoSP/YBFVhG1SmTrx8nUk3v8XLpKT1I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-DninFbEMNPWiKrs_-FHjWw-1; Sun,
 13 Jul 2025 10:34:46 -0400
X-MC-Unique: DninFbEMNPWiKrs_-FHjWw-1
X-Mimecast-MFC-AGG-ID: DninFbEMNPWiKrs_-FHjWw_1752417285
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 413691801BD8;
	Sun, 13 Jul 2025 14:34:45 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 186AB19560A3;
	Sun, 13 Jul 2025 14:34:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 05/17] ublk: avoid to pass `struct ublksrv_io_cmd *` to ublk_commit_and_fetch()
Date: Sun, 13 Jul 2025 22:34:00 +0800
Message-ID: <20250713143415.2857561-6-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Refactor ublk_commit_and_fetch() in the following way for removing
parameter of `struct ublksrv_io_cmd *`:

- return `struct request *` from ublk_fill_io_cmd(), so that we can
use request reference reliably in this way cause both request and
io_uring_cmd reference share same storage

- move ublk_fill_io_cmd() before calling into ublk_commit_and_fetch(),
so that ublk_fill_io_cmd() could be run with per-io lock held for
supporting command batch.

- pass ->zone_append_lba to ublk_commit_and_fetch() directly

The main motivation is to reproduce ublk_commit_and_fetch() for fetching
io command batch with multishot uring_cmd.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 44 ++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f251517baea3..62393c64f17d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2009,14 +2009,20 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 	return 0;
 }
 
-static inline void ublk_fill_io_cmd(struct ublk_io *io,
-		struct io_uring_cmd *cmd, unsigned long buf_addr)
+/* Once we return, `io->req` can't be used any more */
+static inline struct request *
+ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd,
+		 unsigned long buf_addr)
 {
+	struct request *req = io->req;
+
 	io->cmd = cmd;
 	io->flags |= UBLK_IO_FLAG_ACTIVE;
 	/* now this cmd slot is owned by ublk driver */
 	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
 	io->addr = buf_addr;
+
+	return req;
 }
 
 static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
@@ -2182,10 +2188,8 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	return ret;
 }
 
-static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
-				 struct ublk_io *io, struct io_uring_cmd *cmd,
-				 const struct ublksrv_io_cmd *ub_cmd,
-				 unsigned int issue_flags)
+static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
+				       struct ublk_io *io, __u64 buf_addr)
 {
 	struct request *req = io->req;
 
@@ -2194,10 +2198,10 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 		 * NEED GET DATA is not enabled or it is Read IO.
 		 */
-		if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
+		if (!buf_addr && (!ublk_need_get_data(ubq) ||
 					req_op(req) == REQ_OP_READ))
 			return -EINVAL;
-	} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
+	} else if (req_op(req) != REQ_OP_ZONE_APPEND && buf_addr) {
 		/*
 		 * User copy requires addr to be unset when command is
 		 * not zone append
@@ -2205,6 +2209,14 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
+				 struct ublk_io *io, struct io_uring_cmd *cmd,
+				 struct request *req, unsigned int issue_flags,
+				 __u64 zone_append_lba)
+{
 	if (ublk_support_auto_buf_reg(ubq)) {
 		int ret;
 
@@ -2230,11 +2242,8 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 			return ret;
 	}
 
-	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-	io->res = ub_cmd->result;
-
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = ub_cmd->zone_append_lba;
+		req->__sector = zone_append_lba;
 
 	if (ublk_need_req_ref(ubq))
 		ublk_sub_req_ref(io, req);
@@ -2340,7 +2349,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		return ublk_daemon_register_io_buf(cmd, ubq, io, ub_cmd->addr,
 						   issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
+		ret = ublk_check_commit_and_fetch(ubq, io, ub_cmd->addr);
+		if (ret)
+			goto out;
+		io->res = ub_cmd->result;
+		req = ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+		ret = ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
+					    ub_cmd->zone_append_lba);
 		if (ret)
 			goto out;
 		break;
@@ -2350,8 +2365,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		 * uring_cmd active first and prepare for handling new requeued
 		 * request
 		 */
-		req = io->req;
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+		req = ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
 			return UBLK_IO_RES_OK;
-- 
2.47.0


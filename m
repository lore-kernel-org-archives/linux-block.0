Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1284C7F
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 04:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429063; cv=none; b=pZsEHvzNou0A5LGxpHOxYk7u923PbJzYhLypYWHBACpWiVjac9R92KBGkCUo+4u5/GdXP4pRk86EplYWm0d+TEMI+qNLfKUHISuiMST+RqVcaDMhxyhlBBQ6V7AejFA/rXx0h2ey3BmkAyF49nqhGNAp2onxONYjgKMLndGvvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429063; c=relaxed/simple;
	bh=lE4GNDMLINnnOCjKAujkwJp/dkn0H3w+0kPqnkdNR7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdWueAMzHvDzv1Rslps1hMgTostgnQjrj/3fesAw9KE/sqLWkQsxkifov6gJ91Uj0fwku7jO/7acMLAkxzSJnHgoHguNzuaX3DiDmyk71aY/2E7k1CJ1lpcsyscAjwCYM+paFs4AnrpHUw1dxZ24ntbkNgS3znMRz13OrOOhsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaKdZoKu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaKdZoKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751429060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qYhPVhGG+DMrZkNyEe3/GLkhe/opYh8ZpZH1N5HkTdI=;
	b=LaKdZoKuqkY/4LqyvIuv2OdpDYfETos/RNkkIvDZLC5hjVNS8NDMc1qm6+WjNCivfmCxc6
	pWrSAK+AWSt6jaKgR8+U/uIjx+vUlrzgoJ791Xum6RXsSMAjIXdqDUlfC07tMExRAtWTi8
	JLDyiai04tpvyRxzPLWAh+aVw4YbnrA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-M-HTIZPcMwyloTuJhVL46A-1; Wed,
 02 Jul 2025 00:04:14 -0400
X-MC-Unique: M-HTIZPcMwyloTuJhVL46A-1
X-Mimecast-MFC-AGG-ID: M-HTIZPcMwyloTuJhVL46A_1751429054
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4F2E180136B;
	Wed,  2 Jul 2025 04:04:13 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C601219560A7;
	Wed,  2 Jul 2025 04:04:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 04/16] ublk: avoid to pass `struct ublksrv_io_cmd *` to ublk_commit_and_fetch()
Date: Wed,  2 Jul 2025 12:03:28 +0800
Message-ID: <20250702040344.1544077-5-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-1-ming.lei@redhat.com>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 43 ++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2dc6962c804a..1780f9ce3a24 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1983,10 +1983,13 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 	return 0;
 }
 
-static inline void ublk_fill_io_cmd(struct ublk_io *io,
-		struct io_uring_cmd *cmd, unsigned long buf_addr,
-		int result)
+/* Once we return, `io->req` can't be used any more */
+static inline struct request *
+ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd,
+		 unsigned long buf_addr, int result)
 {
+	struct request *req = io->req;
+
 	io->cmd = cmd;
 	io->flags |= UBLK_IO_FLAG_ACTIVE;
 	io->addr = buf_addr;
@@ -1994,6 +1997,8 @@ static inline void ublk_fill_io_cmd(struct ublk_io *io,
 
 	/* now this cmd slot is owned by ublk driver */
 	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
+
+	return req;
 }
 
 static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
@@ -2159,10 +2164,8 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
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
 
@@ -2171,10 +2174,10 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
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
@@ -2182,6 +2185,14 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
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
 
@@ -2207,10 +2218,8 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 			return ret;
 	}
 
-	ublk_fill_io_cmd(io, cmd, ub_cmd->addr, ub_cmd->result);
-
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = ub_cmd->zone_append_lba;
+		req->__sector = zone_append_lba;
 
 	if (ublk_need_req_ref(ubq))
 		ublk_sub_req_ref(io, req);
@@ -2316,7 +2325,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		return ublk_daemon_register_io_buf(cmd, ubq, io, ub_cmd->addr,
 						   issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
+		ret = ublk_check_commit_and_fetch(ubq, io, ub_cmd->addr);
+		if (ret)
+			goto out;
+		req = ublk_fill_io_cmd(io, cmd, ub_cmd->addr, ub_cmd->result);
+		ret = ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
+					    ub_cmd->zone_append_lba);
 		if (ret)
 			goto out;
 		break;
@@ -2326,8 +2340,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		 * uring_cmd active first and prepare for handling new requeued
 		 * request
 		 */
-		req = io->req;
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr, 0);
+		req = ublk_fill_io_cmd(io, cmd, ub_cmd->addr, 0);
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
 			return UBLK_IO_RES_OK;
-- 
2.47.0


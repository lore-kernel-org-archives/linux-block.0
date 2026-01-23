Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C229D29D
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176358; cv=none; b=aWF4MRW0/7R0rCcv+RY7LT6cppw3WkZrYb7EV8kYETo7Y1N+zt8wvsYqsb4BOTP2O3bBNL9i6RyXyyNCpfOtLGH5/j/d9hVu8aHiMEvSsDY3yNSx1pSjg0vOaNOvZq1zfqxbtoSCx9EYO4Nlv6A4VnJ/w9iYfVxCeDpEUU7KC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176358; c=relaxed/simple;
	bh=UbZrHrw3CK87NBy7r9RYILi1Kjx0bZ6MsjMI6o2mGvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqJgOXuqJKksfrMeGaZI0XKMOXPFfG0HEV9jI0zqufJlDO3GYGBnfKkx9DTxebOWiSt3f4OVh/b7JbRFPoYD+w0/ougrmtV7v4932PKw61OOXA2IZO7xOMTsPjXbBar64AQyAjSDTyw5bXsDxoQbJ5O4ymU5qxUz5dqp3MHmSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7jC5c29; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7jC5c29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769176355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhFG8QoNCBBDVA+KbY3vA7o0i6m2n85dweM8rvrz51Y=;
	b=D7jC5c29Lh3JFhuwrJ0N5uNEKLTm2BhF5Zv5rHXIAzNzDLt5XsXpWg2mkzEyEkyLgE3ti2
	q4xifVsFQ88dJfgJtAtwYSYAUiCKQgVm0i6E8hGt/aQ5P05ECKDc0+WCQ8SKEB6GBDz6zN
	pBGikl0C2IAeR2Mo3pknBbVIwlzt5xs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-ZU71vWZpMaORCsEtR5yexQ-1; Fri,
 23 Jan 2026 08:52:30 -0500
X-MC-Unique: ZU71vWZpMaORCsEtR5yexQ-1
X-Mimecast-MFC-AGG-ID: ZU71vWZpMaORCsEtR5yexQ_1769176348
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23A561886895;
	Fri, 23 Jan 2026 13:52:22 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9276A1958DFF;
	Fri, 23 Jan 2026 13:52:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] ublk: rename auto buffer registration helpers
Date: Fri, 23 Jan 2026 21:51:58 +0800
Message-ID: <20260123135205.2202474-2-ming.lei@redhat.com>
In-Reply-To: <20260123135205.2202474-1-ming.lei@redhat.com>
References: <20260123135205.2202474-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Rename the auto buffer registration functions for clarity:

- __ublk_do_auto_buf_reg()    -> ublk_auto_buf_register()
- ublk_prep_auto_buf_reg_io() -> ublk_auto_buf_io_setup()
- ublk_do_auto_buf_reg()      -> ublk_auto_buf_dispatch()

Add comments documenting the locking requirements for each function.

No functional change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 31fda782c47c..7981decd1cee 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1509,10 +1509,16 @@ enum auto_buf_reg_res {
 	AUTO_BUF_REG_OK,
 };
 
-static void ublk_prep_auto_buf_reg_io(const struct ublk_queue *ubq,
-				      struct request *req, struct ublk_io *io,
-				      struct io_uring_cmd *cmd,
-				      enum auto_buf_reg_res res)
+/*
+ * Setup io state after auto buffer registration.
+ *
+ * Must be called after ublk_auto_buf_register() is done.
+ * Caller must hold io->lock in batch context.
+ */
+static void ublk_auto_buf_io_setup(const struct ublk_queue *ubq,
+				   struct request *req, struct ublk_io *io,
+				   struct io_uring_cmd *cmd,
+				   enum auto_buf_reg_res res)
 {
 	if (res == AUTO_BUF_REG_OK) {
 		io->task_registered_buffers = 1;
@@ -1523,8 +1529,9 @@ static void ublk_prep_auto_buf_reg_io(const struct ublk_queue *ubq,
 	__ublk_prep_compl_io_cmd(io, req);
 }
 
+/* Register request bvec to io_uring for auto buffer registration. */
 static enum auto_buf_reg_res
-__ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
+ublk_auto_buf_register(const struct ublk_queue *ubq, struct request *req,
 		       struct ublk_io *io, struct io_uring_cmd *cmd,
 		       unsigned int issue_flags)
 {
@@ -1544,15 +1551,21 @@ __ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 	return AUTO_BUF_REG_OK;
 }
 
-static void ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
-				 struct ublk_io *io, struct io_uring_cmd *cmd,
-				 unsigned int issue_flags)
+/*
+ * Dispatch IO to userspace with auto buffer registration.
+ *
+ * Only called in non-batch context from task work, io->lock not held.
+ */
+static void ublk_auto_buf_dispatch(const struct ublk_queue *ubq,
+				   struct request *req, struct ublk_io *io,
+				   struct io_uring_cmd *cmd,
+				   unsigned int issue_flags)
 {
-	enum auto_buf_reg_res res = __ublk_do_auto_buf_reg(ubq, req, io, cmd,
+	enum auto_buf_reg_res res = ublk_auto_buf_register(ubq, req, io, cmd,
 			issue_flags);
 
 	if (res != AUTO_BUF_REG_FAIL) {
-		ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
+		ublk_auto_buf_io_setup(ubq, req, io, cmd, res);
 		io_uring_cmd_done(cmd, UBLK_IO_RES_OK, issue_flags);
 	}
 }
@@ -1627,7 +1640,7 @@ static void ublk_dispatch_req(struct ublk_queue *ubq, struct request *req)
 		return;
 
 	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
-		ublk_do_auto_buf_reg(ubq, req, io, io->cmd, issue_flags);
+		ublk_auto_buf_dispatch(ubq, req, io, io->cmd, issue_flags);
 	} else {
 		ublk_init_req_ref(ubq, io);
 		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
@@ -1648,7 +1661,7 @@ static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
 		return false;
 
 	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
-		res = __ublk_do_auto_buf_reg(ubq, req, io, cmd,
+		res = ublk_auto_buf_register(ubq, req, io, cmd,
 				data->issue_flags);
 
 		if (res == AUTO_BUF_REG_FAIL)
@@ -1656,7 +1669,7 @@ static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
 	}
 
 	ublk_io_lock(io);
-	ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
+	ublk_auto_buf_io_setup(ubq, req, io, cmd, res);
 	ublk_io_unlock(io);
 
 	return true;
-- 
2.47.0


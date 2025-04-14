Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953871714B3
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630004; cv=none; b=MAJ4ZOcmkkB1iM5NeXhpVlte8fvgNeZeFWpr4ctz0Einfstcp7axk8gKqU+hBVavv8Inm3GNOgxzQJrhYdeKzPiGcpmXJLBlejjNXXGJu0LBgg+yh7SHy59mM8gZR5dOx1oMEPhfaUckM1JCDr/tFVkK10W5ILBDyfFWA+D4/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630004; c=relaxed/simple;
	bh=xZAV/SfXnFY8x6lAwRW8BExFACohiXX+e6Ajp9Ey/JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4Rg74zN6jtB5sQ3m+zp5xGGj2TsWPUUyBhXnHpKicycxnTCZiVRhj3UNRQVulqXhSWCR21mYsR1ixWcIagkIiOko3NNt9IzrTszjxTkGLdYJKI+vu98gGPkE8zf87aFA07l/7MPQCrdbJQlRCz1ChuTGJESR5lO6sUh2i48J2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDt19CYm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDt19CYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744630001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2DVBCwroHX6W/sPAh7+aO4afv1Ief7Mhihr0Y7OWWg=;
	b=MDt19CYmovoA6BnX+2hWvGL8MpotSg8Ve+/OT7+LPEy5GRgsUNm9A7heR9t3uidawcmpmR
	+UI1+p8G2QQCwMS8TSRulBD62qYexTicevawqHMRMimRIZxSXgoMvwqCSTXHF4I4M6+kol
	3pwRc5waJRd+tv8oBtfqqIk3YXxJ6g4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-VbxcyH7mNxScgpy8LS133g-1; Mon,
 14 Apr 2025 07:26:38 -0400
X-MC-Unique: VbxcyH7mNxScgpy8LS133g-1
X-Mimecast-MFC-AGG-ID: VbxcyH7mNxScgpy8LS133g_1744629997
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03F6A1956055;
	Mon, 14 Apr 2025 11:26:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76C3D1956094;
	Mon, 14 Apr 2025 11:26:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 8/9] ublk: simplify aborting ublk request
Date: Mon, 14 Apr 2025 19:25:49 +0800
Message-ID: <20250414112554.3025113-9-ming.lei@redhat.com>
In-Reply-To: <20250414112554.3025113-1-ming.lei@redhat.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Now ublk_abort_queue() is moved to ublk char device release handler,
meantime our request queue is "quiesced" because either ->canceling was
set from uring_cmd cancel function or all IOs are inflight and can't be
completed by ublk server, things becomes easy much:

- all uring_cmd are done, so we needn't to mark io as UBLK_IO_FLAG_ABORTED
for handling completion from uring_cmd

- ublk char device is closed, no one can hold IO request reference any more,
so we can simply complete this request or requeue it for ublk_nosrv_should_reissue_outstanding.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 82 ++++++++++------------------------------
 1 file changed, 20 insertions(+), 62 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f827c2ef00a9..37a0cb8011c1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -122,15 +122,6 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
 
-/*
- * IO command is aborted, so this flag is set in case of
- * !UBLK_IO_FLAG_ACTIVE.
- *
- * After this flag is observed, any pending or new incoming request
- * associated with this io command will be failed immediately
- */
-#define UBLK_IO_FLAG_ABORTED 0x04
-
 /*
  * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
  * get data buffer address from ublksrv.
@@ -1083,12 +1074,6 @@ static inline void __ublk_complete_rq(struct request *req)
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
 
-	/* called from ublk_abort_queue() code path */
-	if (io->flags & UBLK_IO_FLAG_ABORTED) {
-		res = BLK_STS_IOERR;
-		goto exit;
-	}
-
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
 		io->res = -EIO;
@@ -1138,47 +1123,6 @@ static void ublk_complete_rq(struct kref *ref)
 	__ublk_complete_rq(req);
 }
 
-static void ublk_do_fail_rq(struct request *req)
-{
-	struct ublk_queue *ubq = req->mq_hctx->driver_data;
-
-	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
-		blk_mq_requeue_request(req, false);
-	else
-		__ublk_complete_rq(req);
-}
-
-static void ublk_fail_rq_fn(struct kref *ref)
-{
-	struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
-			ref);
-	struct request *req = blk_mq_rq_from_pdu(data);
-
-	ublk_do_fail_rq(req);
-}
-
-/*
- * Since ublk_rq_task_work_cb always fails requests immediately during
- * exiting, __ublk_fail_req() is only called from abort context during
- * exiting. So lock is unnecessary.
- *
- * Also aborting may not be started yet, keep in mind that one failed
- * request may be issued by block layer again.
- */
-static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
-		struct request *req)
-{
-	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
-
-	if (ublk_need_req_ref(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-		kref_put(&data->ref, ublk_fail_rq_fn);
-	} else {
-		ublk_do_fail_rq(req);
-	}
-}
-
 static void ubq_complete_io_cmd(struct ublk_io *io, int res,
 				unsigned issue_flags)
 {
@@ -1670,10 +1614,26 @@ static void ublk_commit_completion(struct ublk_device *ub,
 		ublk_put_req_ref(ubq, req);
 }
 
+static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
+		struct request *req)
+{
+	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
+
+	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
+		blk_mq_requeue_request(req, false);
+	else {
+		io->res = -EIO;
+		__ublk_complete_rq(req);
+	}
+}
+
 /*
- * Called from ubq_daemon context via cancel fn, meantime quiesce ublk
- * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
- * context, so everything is serialized.
+ * Called from ublk char device release handler, when any uring_cmd is
+ * done, meantime request queue is "quiesced" since all inflight requests
+ * can't be completed because ublk server is dead.
+ *
+ * So no one can hold our request IO reference any more, simply ignore the
+ * reference, and complete the request immediately
  */
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
@@ -1690,10 +1650,8 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 			 * will do it
 			 */
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
-			if (rq && blk_mq_request_started(rq)) {
-				io->flags |= UBLK_IO_FLAG_ABORTED;
+			if (rq && blk_mq_request_started(rq))
 				__ublk_fail_req(ubq, io, rq);
-			}
 		}
 	}
 }
-- 
2.47.0


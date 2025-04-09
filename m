Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A229D0B
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161313; cv=none; b=WxVOLfW2i/njFmpih5J2EaCG/cIOO1/046dmRaIMH6UDJzqYYB+JRabJ9iVRnbffQ1jBDCRRmo+wJS7JjSavNgb2yKbZ24uapLCv8Dyvb+cbnOxw+nae60rJ31PD4XT9fZ5X8nVAliSanXhwKktat4I2EPQenRIuRNo8dkFmC50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161313; c=relaxed/simple;
	bh=r1mF94r7Z3fUWlKbc5xhl132UZ6Cx/eXoW+RQguX7Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riFN7Gl75mwB/JahapO+iaEJgYy/8dDxN/ghMQmEGlJHA26xN1waumy/6LCANJOJVywEtgkrJeAppyqhSuPR2iSGjC+901cuCp115AJmWpl2+qxKO4FLDP10uu3NPFuK05SBhKfBp82sYc3iteVANCWncEeToyPVx8EciqPiNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdnFFK3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdnFFK3T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744161310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Xba994WYOGhS50pSRM9RJ/4u13+egpIjIArVtoTgz4=;
	b=SdnFFK3TfH7XNanajFgizDQqXcD503a1NUzB4+XdanBnyibB2H+vae+z3RSxsrEZ4ivnHu
	PqBkym8yOD1oaTinO7EEtIjbkVyRBP8uxyZG10xrgKiG5uz65gFLSHVEtHRWZLjwtv5Gh9
	cDo3op2i+JL9/YgO1rHriG7/N53tpkA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-skG8ORpROFS5QcIHf0JB2Q-1; Tue,
 08 Apr 2025 21:15:09 -0400
X-MC-Unique: skG8ORpROFS5QcIHf0JB2Q-1
X-Mimecast-MFC-AGG-ID: skG8ORpROFS5QcIHf0JB2Q_1744161308
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AD09180882E;
	Wed,  9 Apr 2025 01:15:08 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29209180B488;
	Wed,  9 Apr 2025 01:15:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/2] ublk: don't fail request for recovery & reissue in case of ubq->canceling
Date: Wed,  9 Apr 2025 09:14:42 +0800
Message-ID: <20250409011444.2142010-3-ming.lei@redhat.com>
In-Reply-To: <20250409011444.2142010-1-ming.lei@redhat.com>
References: <20250409011444.2142010-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

ubq->canceling is set with request queue quiesced when io_uring context is
exiting. USER_RECOVERY or !RECOVERY_FAIL_IO requires request to be re-queued
and re-dispatch after device is recovered.

However commit d796cea7b9f3 ("ublk: implement ->queue_rqs()") still may fail
any request in case of ubq->canceling, this way breaks USER_RECOVERY or
!RECOVERY_FAIL_IO.

Fix it by calling __ublk_abort_rq() in case of ubq->canceling.

Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Reported-by: Uday Shankar <ushankar@purestorage.com>
Closes: https://lore.kernel.org/linux-block/Z%2FQkkTRHfRxtN%2FmB@dev-ushankar.dev.purestorage.com/
Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 41bed67508f2..d6ca2f1097ad 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1371,7 +1371,8 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 	return BLK_EH_RESET_TIMER;
 }
 
-static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
+static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
+				  bool check_cancel)
 {
 	blk_status_t res;
 
@@ -1390,7 +1391,7 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
 	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
-	if (unlikely(ubq->canceling))
+	if (check_cancel && unlikely(ubq->canceling))
 		return BLK_STS_IOERR;
 
 	/* fill iod to slot in io cmd buffer */
@@ -1409,7 +1410,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	blk_status_t res;
 
-	res = ublk_prep_req(ubq, rq);
+	res = ublk_prep_req(ubq, rq, false);
 	if (res != BLK_STS_OK)
 		return res;
 
@@ -1441,7 +1442,7 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
 			ublk_queue_cmd_list(ubq, &submit_list);
 		ubq = this_q;
 
-		if (ublk_prep_req(ubq, req) == BLK_STS_OK)
+		if (ublk_prep_req(ubq, req, true) == BLK_STS_OK)
 			rq_list_add_tail(&submit_list, req);
 		else
 			rq_list_add_tail(&requeue_list, req);
-- 
2.47.0


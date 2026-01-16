Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE831BCA9
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573197; cv=none; b=Uy4OMQ3uldNWbi4wcd1ucJ6te8rZ0O/9PV6129AFFYjudPSWfnSat9zFKKamqVT7vELhGkxf6HT314okYxXuehX/fpCk9YKdGoZ+DsI56Pr0FZnCCMTUyeHiXtG7NXgks59pTSQDFSrQBw+3bFyo1TQiiQxMfTsA8eyxaS7wBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573197; c=relaxed/simple;
	bh=6mQ2ealNPStay6KQsf/08rTm8bCPM71xBEnBcd0Isb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5G4GcRDWr0a5S/iBxdzXVKGPSUAI7aUNVYUgYyuv3rBl7n56j9lE7bNUYajZo+e6CGWNB+qVwTllZofAqVVioe66CESDEXttxiGEiW5yejiz4mD5UICNNsRJnmgGHRx3vLoRE6GuDykaX8if9cLMtH9s5ZTkxPCDggTCN5C5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXGQhTb/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXGQhTb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9E2E7VcK9hSedtUaCJA9eW5iOGE7So2h+mvhvqVbM88=;
	b=iXGQhTb//CD9BA0mifi37T5RvRCB+H+XjuztCshHZJAegOvBEoOguEMzL8MoGrSST0j2KK
	9iUA5nR4FfFyl3EEkMJFJCKYtO3KUnj2HCi+53bcmz+TGhvzTcKBhJnvL3RQSxqDs5UK3g
	B5CuABebauF5A3UWHI5giJrNmkSCo8c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-ux1u7l5zO_Wv8fsvf468Ug-1; Fri,
 16 Jan 2026 09:19:53 -0500
X-MC-Unique: ux1u7l5zO_Wv8fsvf468Ug-1
X-Mimecast-MFC-AGG-ID: ux1u7l5zO_Wv8fsvf468Ug_1768573192
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F51018005AF;
	Fri, 16 Jan 2026 14:19:52 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C77E195419D;
	Fri, 16 Jan 2026 14:19:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 09/24] ublk: refactor ublk_queue_rq() and add ublk_batch_queue_rq()
Date: Fri, 16 Jan 2026 22:18:42 +0800
Message-ID: <20260116141859.719929-10-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Extract common request preparation and cancellation logic into
__ublk_queue_rq_common() helper function. Add dedicated
ublk_batch_queue_rq() for batch mode operations to eliminate runtime check
in ublk_queue_rq().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 56 +++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index aa1852bd6b77..5e960ff54714 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1975,16 +1975,22 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
 	return BLK_STS_OK;
 }
 
-static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
-		const struct blk_mq_queue_data *bd)
+/*
+ * Common helper for queue_rq that handles request preparation and
+ * cancellation checks. Returns status and sets should_queue to indicate
+ * whether the caller should proceed with queuing the request.
+ */
+static inline blk_status_t __ublk_queue_rq_common(struct ublk_queue *ubq,
+						   struct request *rq,
+						   bool *should_queue)
 {
-	struct ublk_queue *ubq = hctx->driver_data;
-	struct request *rq = bd->rq;
 	blk_status_t res;
 
 	res = ublk_prep_req(ubq, rq, false);
-	if (res != BLK_STS_OK)
+	if (res != BLK_STS_OK) {
+		*should_queue = false;
 		return res;
+	}
 
 	/*
 	 * ->canceling has to be handled after ->force_abort and ->fail_io
@@ -1992,14 +1998,44 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * of recovery, and cause hang when deleting disk
 	 */
 	if (unlikely(ubq->canceling)) {
+		*should_queue = false;
 		__ublk_abort_rq(ubq, rq);
 		return BLK_STS_OK;
 	}
 
-	if (ublk_support_batch_io(ubq))
-		ublk_batch_queue_cmd(ubq, rq, bd->last);
-	else
-		ublk_queue_cmd(ubq, rq);
+	*should_queue = true;
+	return BLK_STS_OK;
+}
+
+static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
+		const struct blk_mq_queue_data *bd)
+{
+	struct ublk_queue *ubq = hctx->driver_data;
+	struct request *rq = bd->rq;
+	bool should_queue;
+	blk_status_t res;
+
+	res = __ublk_queue_rq_common(ubq, rq, &should_queue);
+	if (!should_queue)
+		return res;
+
+	ublk_queue_cmd(ubq, rq);
+	return BLK_STS_OK;
+}
+
+static blk_status_t ublk_batch_queue_rq(struct blk_mq_hw_ctx *hctx,
+		const struct blk_mq_queue_data *bd)
+{
+	struct ublk_queue *ubq = hctx->driver_data;
+	struct request *rq = bd->rq;
+	bool should_queue;
+	blk_status_t res;
+
+	res = __ublk_queue_rq_common(ubq, rq, &should_queue);
+	if (!should_queue)
+		return res;
+
+	ublk_batch_queue_cmd(ubq, rq, bd->last);
 	return BLK_STS_OK;
 }
 
@@ -2122,7 +2158,7 @@ static const struct blk_mq_ops ublk_mq_ops = {
 
 static const struct blk_mq_ops ublk_batch_mq_ops = {
 	.commit_rqs	= ublk_commit_rqs,
-	.queue_rq       = ublk_queue_rq,
+	.queue_rq       = ublk_batch_queue_rq,
 	.queue_rqs      = ublk_batch_queue_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.timeout	= ublk_timeout,
-- 
2.47.0


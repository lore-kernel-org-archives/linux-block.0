Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A132AAAE
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573203; cv=none; b=No+pZhrsE3Oa19a17bUqOw5EMOvGgs8fyBJX1AIHiAB/HJXRaYjCavbK0jFGRhAEUTU/V62ujZk3roX6b55DdgPvTrXxW7yqenrkBPfELHwdSdlIS3H/ZCCy4c7Uz6iI6Y5SKzSZu8o2n/gPne9YfzoIjhD4maIe8bg7JhdoJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573203; c=relaxed/simple;
	bh=yuQxyQ/03mqS1zR1psKMFJejQYWQiKNuAcjUDWmGLwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ta2T3JhF6vLNHB3kpEUklP7cIzpCFRXyORXX8IGApF+waPf9OWW7ZRC30jyNeD2P5eYGNJXNoBtgSUplZnWY/rmKGErwdp9Z10+6FardO5fYRgnYGpaMfKDXd0PfED/vWVd2pnKb8nsRlNrNax2f2NoDx4CJHA01cHphd/6QBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKUOj7sm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKUOj7sm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkH4vVlGB2C+cPfKOnIyq5lhl9NPi4z1078Xy8OElCg=;
	b=iKUOj7smXQR73RwbgGP4SYTj2eHf0ZK6Guc9UJI8rtue2fPdtKEpUfnmeas93vvNijWQZK
	r57790OJBiKhT7o+/fFm4QIubKn8q//8WohaB9fzhq32TBe2zA9FBBmKVnvRAgZB5m4gZO
	xU551SJGpIR4a2ERJwMb5d9qffkUF6c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-6SVrbRpbOY-xfennFC6Fuw-1; Fri,
 16 Jan 2026 09:19:57 -0500
X-MC-Unique: 6SVrbRpbOY-xfennFC6Fuw-1
X-Mimecast-MFC-AGG-ID: 6SVrbRpbOY-xfennFC6Fuw_1768573196
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 699FE19560AF;
	Fri, 16 Jan 2026 14:19:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87556195419D;
	Fri, 16 Jan 2026 14:19:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 10/24] ublk: abort requests filled in event kfifo
Date: Fri, 16 Jan 2026 22:18:43 +0800
Message-ID: <20260116141859.719929-11-ming.lei@redhat.com>
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

In case of BATCH_IO, any request filled in event kfifo, they don't get
chance to be dispatched any more when releasing ublk char device, so
we have to abort them too.

Add ublk_abort_batch_queue() for aborting this kind of requests.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5e960ff54714..602666c0c676 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2470,7 +2470,8 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		struct request *req)
 {
-	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
+	WARN_ON_ONCE(!ublk_dev_support_batch_io(ub) &&
+			io->flags & UBLK_IO_FLAG_ACTIVE);
 
 	if (ublk_nosrv_should_reissue_outstanding(ub))
 		blk_mq_requeue_request(req, false);
@@ -2480,6 +2481,24 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 	}
 }
 
+/*
+ * Request tag may just be filled to event kfifo, not get chance to
+ * dispatch, abort these requests too
+ */
+static void ublk_abort_batch_queue(struct ublk_device *ub,
+				   struct ublk_queue *ubq)
+{
+	unsigned short tag;
+
+	while (kfifo_out(&ubq->evts_fifo, &tag, 1)) {
+		struct request *req = blk_mq_tag_to_rq(
+				ub->tag_set.tags[ubq->q_id], tag);
+
+		if (!WARN_ON_ONCE(!req || !blk_mq_request_started(req)))
+			__ublk_fail_req(ub, &ubq->ios[tag], req);
+	}
+}
+
 /*
  * Called from ublk char device release handler, when any uring_cmd is
  * done, meantime request queue is "quiesced" since all inflight requests
@@ -2498,6 +2517,9 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			__ublk_fail_req(ub, io, io->req);
 	}
+
+	if (ublk_support_batch_io(ubq))
+		ublk_abort_batch_queue(ub, ubq);
 }
 
 static void ublk_start_cancel(struct ublk_device *ub)
-- 
2.47.0


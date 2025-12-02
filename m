Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AE311C0C
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678070; cv=none; b=EF5J5LT7lS8soh/DlHoRHSWqJZkbT+PbCW0400vNsTYTmvC/wwF1RU47mqa3Vv2Uu/Ixd5RLfSJ5Jb7MrrLOnll+zYDcW1xk7IM6HkzfN6cuwdQYIyEx0MvRTUrOgvzkHMzWj+uIiu704z8gpPKno9RJ5qJmt6XQLtytb/0BOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678070; c=relaxed/simple;
	bh=repnR2VVte/6hsP+Z5SMumFmLC9Ms68aWUX2jNcUvmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El/aV/d492Q3sOQyVa6+MBGgsQLUaWLsCXSB0cS7Ujp9gS+AiD9pNF3Y8z5mNzIaSIbijtmv6HCXklac/8KylyTXC2voWq23O5244tK9bwYlit22/oEkiU+Qd+4yUOH+nkiGWo7YaXgo0CCKLdZazVd9I+MSBnlG2nFribZ3YYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsFrB7NI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsFrB7NI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764678065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX/swPEs7jtXbut9RQ6iUzLMHEqHeZQnHlblSfkxqGc=;
	b=OsFrB7NIjuxw0mrV8yvQGZ2SDbwZXYIJtsdPopxc13kyGPt3VBlYIUu/JQXjqrW59VKo2w
	QDUgQjxKxvYHmbPW7Oad/WA7ng2lrAXdKSOx/YVqsZgHSrZiWkUfa9RQ8E1oUpelh7ip2K
	kHOpd6BywcrKGKtiyMmE2q6mBQfZZa8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-qpmN9KSbMHukY8gZV3XrKA-1; Tue,
 02 Dec 2025 07:21:03 -0500
X-MC-Unique: qpmN9KSbMHukY8gZV3XrKA-1
X-Mimecast-MFC-AGG-ID: qpmN9KSbMHukY8gZV3XrKA_1764678062
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B3CB1800EF6;
	Tue,  2 Dec 2025 12:21:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A2DC30001A4;
	Tue,  2 Dec 2025 12:21:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 09/21] ublk: abort requests filled in event kfifo
Date: Tue,  2 Dec 2025 20:19:03 +0800
Message-ID: <20251202121917.1412280-10-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-1-ming.lei@redhat.com>
References: <20251202121917.1412280-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In case of BATCH_IO, any request filled in event kfifo, they don't get
chance to be dispatched any more when releasing ublk char device, so
we have to abort them too.

Add ublk_abort_batch_queue() for aborting this kind of requests.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index de6ce0e17b1b..3865edabe1e6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2265,7 +2265,8 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		struct request *req)
 {
-	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
+	WARN_ON_ONCE(!ublk_dev_support_batch_io(ub) &&
+			io->flags & UBLK_IO_FLAG_ACTIVE);
 
 	if (ublk_nosrv_should_reissue_outstanding(ub))
 		blk_mq_requeue_request(req, false);
@@ -2275,6 +2276,24 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
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
@@ -2293,6 +2312,9 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
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


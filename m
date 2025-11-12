Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B342C0264
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940378; cv=none; b=fx+82KOJ6oGyEMjmUSg3PjXP2xhVXyW984nGzR5MoLYSR0HiGff1SFUpL0DZJnSCzO2T9JtdW92LGJrvg7rgN7HHzrB9oiRW2lFoBA2/p8ilfsRSwbd8C4v8VJ2xDLMxuMATq823y2vNRHkmDVCwbJ9vddYj3hgHgEa/DcHxMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940378; c=relaxed/simple;
	bh=r6uquUyV+mW6FRaxpMLyghzrEKtpienYhKHetPACrhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QC9xEZJRCKlWGJXRt4mBGFZWMhYvYBSqzdFdqbuxIdPEVXmKSsJ6/QXqe/K1F9woGie9+cf2aL5Yisng5jB+ARniApgjlEiMv7tehfOgq13Bbk6cVniCFas4GF8SDaYYTJFzATCNX6+hHakpB8MrMGERaw/qJU5+D/H5JasqXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO9ZXC8V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO9ZXC8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPSlUx1wZSiPH7vP4X4w7o1k2d/N5eiULATumkhsqxU=;
	b=CO9ZXC8VzrJuuyqrWMZW6ibonb7uhVowss6su/367sdMuAh2ZrY5LCbntZrjDP9wQ5eyqY
	7y+rLYNXK1dx5V/iUmMvm5ErHcsqrFoBVG1l/ayNSGlnWIo9Snm4laDW1qA/oMfyoUy/v+
	ECbLLJsmoyIJC9OaTEkYr7far1SOgGE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-HGVygXePMPqWiekDzCnvuA-1; Wed,
 12 Nov 2025 04:39:32 -0500
X-MC-Unique: HGVygXePMPqWiekDzCnvuA-1
X-Mimecast-MFC-AGG-ID: HGVygXePMPqWiekDzCnvuA_1762940371
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5A4B1800357;
	Wed, 12 Nov 2025 09:39:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 077041800576;
	Wed, 12 Nov 2025 09:39:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 15/27] ublk: abort requests filled in event kfifo
Date: Wed, 12 Nov 2025 17:37:53 +0800
Message-ID: <20251112093808.2134129-16-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In case of BATCH_IO, any request filled in event kfifo, they don't get
chance to be dispatched any more when releasing ublk char device, so
we have to abort them too.

Add ublk_abort_batch_queue() for aborting this kind of requests.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 531a1754a0a4..c21ed4811767 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2178,7 +2178,8 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		struct request *req)
 {
-	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
+	WARN_ON_ONCE(!ublk_dev_support_batch_io(ub) &&
+			io->flags & UBLK_IO_FLAG_ACTIVE);
 
 	if (ublk_nosrv_should_reissue_outstanding(ub))
 		blk_mq_requeue_request(req, false);
@@ -2188,6 +2189,26 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 	}
 }
 
+/*
+ * Request tag may just be filled to event kfifo, not get chance to
+ * dispatch, abort these requests too
+ */
+static void ublk_abort_batch_queue(struct ublk_device *ub,
+				   struct ublk_queue *ubq)
+{
+	while (true) {
+		struct request *req;
+		short tag;
+
+		if (!kfifo_out(&ubq->evts_fifo, &tag, 1))
+			break;
+
+		req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+		if (req && blk_mq_request_started(req))
+			__ublk_fail_req(ub, &ubq->ios[tag], req);
+	}
+}
+
 /*
  * Called from ublk char device release handler, when any uring_cmd is
  * done, meantime request queue is "quiesced" since all inflight requests
@@ -2206,6 +2227,9 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
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


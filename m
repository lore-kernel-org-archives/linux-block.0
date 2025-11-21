Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EF1E51EB
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690411; cv=none; b=RIc36MetWmONgZFyKOaPwj7mDSwnfAw3kp2ji+a/Xfyr4jcGxeJkjbWlAursammJ4c6a3wtOg2VfoZ/hNhDBrVTJ4CN1u3G7Rhx8wlLALTluOirZg1y3si/JOCVRK/hRYFUX6qeQUeCH0p/TvGi+J1s1ltzB0chmwybJTeB0lUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690411; c=relaxed/simple;
	bh=Gbvg+CMUY2qwHXspBmVcG3os7q7yA1lItaymIz9quJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyEP7phedA4q7oUaaeCBfKHX0ULJP2noeSl4sUplTBSMIpn3kKvAWXGb2mkhtxSRV12UKTJQNbQToH3YK+Pf1jpacHwlPO/BllYMVmmUJDZ0rKECfrJyA+8AvjrFZOZDMW74OrjOJfx24GWN+proA0zzkfvLVdPcGxUcKlJ5j2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bS2tosAt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bS2tosAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqanJXBXu9s6vrgb1WAyKqNpSdxT6oHl0Om7j+YSClQ=;
	b=bS2tosAtjMBanvHYPNdZNL7YBA+sv23wOXzbGkS8qvZ6Dx6+7udgnLIEqlCVwERci1TxCy
	zwV0KKfxsA2a/6wjfHL+zJsAFGDE1G/8j8X9BA/Mrk6R7Dj7iV157aC0d/h07+IwYyEnqy
	q3jUXGHVc59qFTqSLkNxYoIY0FVct84=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-7YGyixZBPpiTW5Dvuat1lA-1; Thu,
 20 Nov 2025 21:00:05 -0500
X-MC-Unique: 7YGyixZBPpiTW5Dvuat1lA-1
X-Mimecast-MFC-AGG-ID: 7YGyixZBPpiTW5Dvuat1lA_1763690404
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9F001956072;
	Fri, 21 Nov 2025 02:00:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB2921956045;
	Fri, 21 Nov 2025 02:00:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 15/27] ublk: abort requests filled in event kfifo
Date: Fri, 21 Nov 2025 09:58:37 +0800
Message-ID: <20251121015851.3672073-16-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In case of BATCH_IO, any request filled in event kfifo, they don't get
chance to be dispatched any more when releasing ublk char device, so
we have to abort them too.

Add ublk_abort_batch_queue() for aborting this kind of requests.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2e5e392c939e..849199771f86 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2241,7 +2241,8 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		struct request *req)
 {
-	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
+	WARN_ON_ONCE(!ublk_dev_support_batch_io(ub) &&
+			io->flags & UBLK_IO_FLAG_ACTIVE);
 
 	if (ublk_nosrv_should_reissue_outstanding(ub))
 		blk_mq_requeue_request(req, false);
@@ -2251,6 +2252,26 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
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
@@ -2269,6 +2290,9 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
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


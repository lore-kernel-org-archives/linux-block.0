Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80B30E84E
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721028; cv=none; b=eRdkf41PndNlnlAdyUserG/HA//ZzJUMga8DsbSZubnO3YxdGVty4Kpdt7vLo8j25fiu9/YMuOGp5O2fzJRjseU/m6uC83POL84c1S1pr9msv6twuTrn4ZOi6qVoxFT1/PaLd811nZGNkBwIsjaUylsPIQU0UKEiJQ3u2ToqQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721028; c=relaxed/simple;
	bh=v6wQ7L2+k+7QITkhfQK0AGcGyJcfwweTVraKmhXqz/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQGl6aEFvnGUDwXc07GXW273/bcu9en2o7AQLesG0Kd1HIDkPW09d8af4qiNC38TF+5vEplEWDs8Q6aRKAhA9i+zUf9BUUn7+OEwx+oqQmlO+A0dNLav6WMq6Psu2XVQbk7qpPaXiN+mxQMTVqNOsp1OZ3KV7+ScNXB6z4nTjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I03f2VOx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I03f2VOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SHwrGzVTEoXr9jSH2OgZSRQnWOk0OqVne6BVsiVF/s=;
	b=I03f2VOxelQiWz7wvb+I+OAoP1IVSoH0ZxteVyHsy5/l5wqQb4GX9jFf3/lSd/st52+B/l
	BX3iFYAxs/UPgfv9bYyLs/DV+ImuQbiO3j2U7lFg/FiOMcO4RgYdzEWBXmK+S/V6r6JgV1
	5kcHa3faikkIP1hKfr1B00HChPzggBo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-1x0Mzl6NOiGDNi-6c558FA-1; Mon,
 01 Sep 2025 06:03:44 -0400
X-MC-Unique: 1x0Mzl6NOiGDNi-6c558FA-1
X-Mimecast-MFC-AGG-ID: 1x0Mzl6NOiGDNi-6c558FA_1756721023
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE12E18003FC;
	Mon,  1 Sep 2025 10:03:43 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B81291800447;
	Mon,  1 Sep 2025 10:03:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 13/23] ublk: abort requests filled in event kfifo
Date: Mon,  1 Sep 2025 18:02:30 +0800
Message-ID: <20250901100242.3231000-14-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
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
 drivers/block/ublk_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 60e19fe0655e..cbc5c372c4aa 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2143,6 +2143,26 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
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
+			__ublk_fail_req(ubq, &ubq->ios[tag], req);
+	}
+}
+
 /*
  * Called from ublk char device release handler, when any uring_cmd is
  * done, meantime request queue is "quiesced" since all inflight requests
@@ -2161,6 +2181,9 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			__ublk_fail_req(ubq, io, io->req);
 	}
+
+	if (ublk_support_batch_io(ubq))
+		ublk_abort_batch_queue(ub, ubq);
 }
 
 static void ublk_start_cancel(struct ublk_device *ub)
-- 
2.47.0


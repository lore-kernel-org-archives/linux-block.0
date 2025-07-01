Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF41EA6F
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354623; cv=none; b=Do/RqYZh/BntmN+AUpHm0bhlkQW4S88pYvBNZ5vNPzuPX8hvqnPwZxMKyX/PD7XaLWW+1Nnkc75SfD8lBiANvovwffNiklMGK7R0ba9ppCsn8g+9Yauxe10yUWBUjGLqZr8c1vAtEg0Sc1CdR2eWISK9nQoWbp1XMPHxTmt1nk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354623; c=relaxed/simple;
	bh=VBUNOGATFpGI9P5FZ4pQ1k9I4aqPI7c0FZAkj60+wPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbyAgWyPhort+zfAkLQw+allShasSO99ofWPDmIvwmhdXlSRgg/jvXXbpFeGDmjsnp1WtPzJlO9yxrzmW9k+RK1b3Fn6rMwSvrGuXJ9CHlCWcYCuJMGcC9YvXUdzWg3s/pv/iE/i+9uUJ/6yNqC7fJn5r7ZCPjwUdtqxY9EL5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vuo7hAXS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vuo7hAXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751354616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oXUQsEF3ubaPAB0Pf1RYwqgNynT7RM+QZeChQyxPzK0=;
	b=Vuo7hAXSzym88kgFSyWVdot82z/kxnu8fUQsrPWKPQvmZvcG0h4aDgtTdyU9EY9Orrha0z
	gxSnDOoZcSWKz93JaSsxVuM1FphWIysO7QmzCQAiX5xhSJrP4X3UbVQNJC2aSGkvBP1AqK
	SvqX11nwNCY5mzBysMUMCugvFs/wdiQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-1BxhevM5Pd6fxv6_q8i6Og-1; Tue,
 01 Jul 2025 03:23:33 -0400
X-MC-Unique: 1BxhevM5Pd6fxv6_q8i6Og-1
X-Mimecast-MFC-AGG-ID: 1BxhevM5Pd6fxv6_q8i6Og_1751354612
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2828C180047F;
	Tue,  1 Jul 2025 07:23:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.120])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1302718003FC;
	Tue,  1 Jul 2025 07:23:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Changhui Zhong <czhong@redhat.com>
Subject: [PATCH] ublk: don't queue request if the associated uring_cmd is canceled
Date: Tue,  1 Jul 2025 15:23:25 +0800
Message-ID: <20250701072325.1458109-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 524346e9d79f ("ublk: build batch from IOs in same io_ring_ctx and io task")
need to dereference `io->cmd` for checking if the IO can be added to current
batch, see ublk_belong_to_same_batch() and io_uring_cmd_ctx_handle(). However,
`io->cmd` may become invalid after the uring_cmd is canceled.

Fixes it by only allowing to queue this IO in case that ublk_prep_req()
returns `BLK_STS_OK`, when 'io->cmd' is guaranteed to be valid.

Reported-by: Changhui Zhong <czhong@redhat.com>
Fixes: 524346e9d79f ("ublk: build batch from IOs in same io_ring_ctx and io task")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c3e3c3b65a6d..9fd284fa76dc 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1442,15 +1442,16 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
 		struct ublk_queue *this_q = req->mq_hctx->driver_data;
 		struct ublk_io *this_io = &this_q->ios[req->tag];
 
+		if (ublk_prep_req(this_q, req, true) != BLK_STS_OK) {
+			rq_list_add_tail(&requeue_list, req);
+			continue;
+		}
+
 		if (io && !ublk_belong_to_same_batch(io, this_io) &&
 				!rq_list_empty(&submit_list))
 			ublk_queue_cmd_list(io, &submit_list);
 		io = this_io;
-
-		if (ublk_prep_req(this_q, req, true) == BLK_STS_OK)
-			rq_list_add_tail(&submit_list, req);
-		else
-			rq_list_add_tail(&requeue_list, req);
+		rq_list_add_tail(&submit_list, req);
 	}
 
 	if (!rq_list_empty(&submit_list))
-- 
2.47.1


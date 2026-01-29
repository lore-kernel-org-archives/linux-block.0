Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51597478
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656525; cv=none; b=Sx5H2wNUTT6NDRmTkg+A8RbFouQLMfdQh8WjTDade2sze1jT1I+rR1cswxSOcJt7fCF4Nlz+ojwxmQgq2f/5yGtVDzxc4JMt8CEB3MMK7PnJU4xPONZvb1OaB4v9SklS/yG64R7WGL7Wy01J7Q5tK2E/UnYLpNmBSy7yR431FAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656525; c=relaxed/simple;
	bh=/X46pN53uXiQUzG48wQG/B5as8466g88wesX7oBRXMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3RAAe1iWUI2+nh6lACOvTqhraxf1bdDE/yEIgo4eQ4xlEbTzSaSMtUmRkfZ4TZDD+uAQk96UpWDEnFHAD6uTunDdpmlwZ19G5RldeEmGn0Ql4DIwd1tDdNE3LOOTvCioxloP2zRa/cSFfZEDbVNjIkuL/kI4c2xXtMqBVHdXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJMBPLq5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJMBPLq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769656522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2fxepGSk+LrH8nsyr01ok9KdnB8gQjY3f/EehS+YB4=;
	b=jJMBPLq5VhiT8mJB9WNxEPZ4N4U1qDx2bK3GT1SZQNNxYwQLg0RodvirmzowL4epMXmHZz
	r+VoRD5JHQ5BIIOJNLaegqYZn06zIH1ozW2unbsh9xu0oqF9C/W8ZaK7gyDZQybv4JZ7Ox
	Pd7DKeX1cfRdFaCHEonrfvJatlWV6tA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-l2UL4gpgMDe4IyMM3dDS3A-1; Wed,
 28 Jan 2026 22:15:19 -0500
X-MC-Unique: l2UL4gpgMDe4IyMM3dDS3A-1
X-Mimecast-MFC-AGG-ID: l2UL4gpgMDe4IyMM3dDS3A_1769656518
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C91FB1955F2C;
	Thu, 29 Jan 2026 03:15:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9864F180086E;
	Thu, 29 Jan 2026 03:15:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/5] ublk: check list membership before cancelling batch fetch command
Date: Thu, 29 Jan 2026 11:14:55 +0800
Message-ID: <20260129031501.3403688-2-ming.lei@redhat.com>
In-Reply-To: <20260129031501.3403688-1-ming.lei@redhat.com>
References: <20260129031501.3403688-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add !list_empty(&fcmd->node) check in ublk_batch_cancel_cmd() to ensure
the fcmd hasn't already been removed from the list. Once an fcmd is
removed from the list, it's considered claimed by whoever removed it
and will be freed by that path.

Meantime switch to list_del_init() for deleting it from list.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8a5a6ba29a1d..94470a2ec05e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -738,7 +738,7 @@ static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
 					int res)
 {
 	spin_lock(&ubq->evts_lock);
-	list_del(&fcmd->node);
+	list_del_init(&fcmd->node);
 	WARN_ON_ONCE(fcmd != ubq->active_fcmd);
 	__ublk_release_fcmd(ubq);
 	spin_unlock(&ubq->evts_lock);
@@ -2693,6 +2693,16 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, issue_flags);
 }
 
+/*
+ * Cancel a batch fetch command if it hasn't been claimed by another path.
+ *
+ * An fcmd can only be cancelled if:
+ * 1. It's not the active_fcmd (which is currently being processed)
+ * 2. It's still on the list (!list_empty check) - once removed from the list,
+ *    the fcmd is considered claimed and will be freed by whoever removed it
+ *
+ * Use list_del_init() so subsequent list_empty() checks work correctly.
+ */
 static void ublk_batch_cancel_cmd(struct ublk_queue *ubq,
 				  struct ublk_batch_fetch_cmd *fcmd,
 				  unsigned int issue_flags)
@@ -2700,9 +2710,9 @@ static void ublk_batch_cancel_cmd(struct ublk_queue *ubq,
 	bool done;
 
 	spin_lock(&ubq->evts_lock);
-	done = (READ_ONCE(ubq->active_fcmd) != fcmd);
+	done = (READ_ONCE(ubq->active_fcmd) != fcmd) && !list_empty(&fcmd->node);
 	if (done)
-		list_del(&fcmd->node);
+		list_del_init(&fcmd->node);
 	spin_unlock(&ubq->evts_lock);
 
 	if (done) {
-- 
2.47.0


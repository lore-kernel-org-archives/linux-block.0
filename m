Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65321E8329
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159767; cv=none; b=lqLK+WX8XgR0IYP0Q44rnogn3DdaYoS9jbSyvDjSnPVOx811gXnm51WtQwvTJoMrs8jsiE8zMUWaSu5J58ZroMpUt97b6UZQcHP382sOLdZyO1LObxxNbmTVt1YQ5oopFbrZZz7Zc5AQUrjGGUrlMMqX9rwA3EEcJfSCkCgrJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159767; c=relaxed/simple;
	bh=tDAnNOS1UDUaolT0mQAdabILKlImaw6QdRuDnZtSbas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dF7m5w7zJ9uVlkwHWS4bD8+Ap8a91OqCexapZANObRy780CWmsWs9vHO7vmny+n6GffEJPZfD0oqxCPqpYK7+kh7ccLkfhVFgmodOJBtmCtdZyZwFm3ZBIdwkvRRUeUT2zfW4NlHtbmZ1usiokkkCFE9XWdSkdAuj+kSfRssSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFnMyOuQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFnMyOuQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769159765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1D1ajrVa3AMmAWZzx3yaekCqQZLmpHzTSc79+c28zU=;
	b=bFnMyOuQ05/2TurExFdanf+PbDkG4DuzpwVjIvrN0dfTGrfIzxQaMcvNgqYg8ky7+VV8pH
	mkmlwgTf72SbTMHO/pwJOKIpc2/cT1a17Cj/uQ2LFMza8rGvjtGlXK51hZk9i0uhNAcfa9
	J1Zbow10hQLCEZjMTfx9OUIB1JUFzyk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-WDtUTsLaMhmZCRitcV1fLQ-1; Fri,
 23 Jan 2026 04:16:01 -0500
X-MC-Unique: WDtUTsLaMhmZCRitcV1fLQ-1
X-Mimecast-MFC-AGG-ID: WDtUTsLaMhmZCRitcV1fLQ_1769159760
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F10DD19775FB;
	Fri, 23 Jan 2026 09:15:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 239D5195419B;
	Fri, 23 Jan 2026 09:15:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] ublk: fix canceling flag handling in batch I/O recovery
Date: Fri, 23 Jan 2026 17:15:43 +0800
Message-ID: <20260123091547.2164984-3-ming.lei@redhat.com>
In-Reply-To: <20260123091547.2164984-1-ming.lei@redhat.com>
References: <20260123091547.2164984-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Two issues with ubq->canceling flag handling:

1) In ublk_queue_reset_io_flags(), ubq->canceling is set outside
   cancel_lock, violating the locking requirement. Move it inside
   the spinlock-protected section.

2) In ublk_batch_unprep_io(), when rolling back after a batch prep
   failure, if the queue became ready during prep (which cleared
   canceling), the flag is not restored when the queue becomes
   not-ready again. This allows new requests to be queued to
   uninitialized IO slots.

Fix by restoring ubq->canceling = true under cancel_lock when the
queue transitions from ready to not-ready during rollback.

Reported-by: Jens Axboe <axboe@kernel.dk>
Fixes: 3f3850785594 ("ublk: fix batch I/O recovery -ENODEV error")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 31279a8238b8..31fda782c47c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2806,9 +2806,9 @@ static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
 	spin_lock(&ubq->cancel_lock);
 	for (j = 0; j < ubq->q_depth; j++)
 		ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
+	ubq->canceling = false;
 	spin_unlock(&ubq->cancel_lock);
 	ubq->fail_io = false;
-	ubq->canceling = false;
 }
 
 /* device can only be started after all IOs are ready */
@@ -3435,10 +3435,15 @@ static int ublk_batch_unprep_io(struct ublk_queue *ubq,
 
 	/*
 	 * If queue was ready before this decrement, it won't be anymore,
-	 * so we need to decrement the queue ready count too.
+	 * so we need to decrement the queue ready count and restore the
+	 * canceling flag to prevent new requests from being queued.
 	 */
-	if (ublk_queue_ready(ubq))
+	if (ublk_queue_ready(ubq)) {
 		data->ub->nr_queue_ready--;
+		spin_lock(&ubq->cancel_lock);
+		ubq->canceling = true;
+		spin_unlock(&ubq->cancel_lock);
+	}
 	ubq->nr_io_ready--;
 
 	ublk_io_lock(io);
-- 
2.47.0


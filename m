Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4FAD2D
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729816666; cv=none; b=CYugM74uJd9UKA5rtBfDY0t8roEvOeBCGUBSdWDkHPCUf6Nczza0ju3iJ6FSGEoVfKdpQJtpwUHdxzFTHHmXnf1c7O29PooRHycjBBhy/nQONWzgRZpl1rdt8TAAFiPGe5smTESA3f77ko8AM4bKIAbFcWOeXoRQPpYTsE743+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729816666; c=relaxed/simple;
	bh=11Oahn2ypsY9F4XTZWb/pSzCymj6l8lm6AtWq36ZMTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3H3m1IWAx8xuXHbajDAdGFqJDhLI3IohVlorJabhiHQWcGOH2G6ATjzOZ/G2R/bM2OraCtGJpbSm1dbDU9C71mjiWd4957CodsgbB8QDUWeAkgQeJB7RoDJGvyIUL0jG49QM07HlFN9V0TdntY5TxOUfy6RpTvOTmCzxYB9aSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlk5t2V4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlk5t2V4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729816663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMiEf8yyzauydStTLG5zgtGasdWM9okjoTqlIsOpDqo=;
	b=dlk5t2V4S1KXqReQaVSKvNgVkGsidexTxlYFFTUF7KVQFTgpI35I2OZ+gJXNrwoRJiHXvG
	dsvA6c1BGXlyHxj0aqdRSb8b2csqIdEA6uJHSOoU1K5V0l0ltBPEjTSStbJv1Rcy3A1Aje
	fHTuVqbYHsu9UPEGPpK2Zr/7dF3DEB4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-eFB_oBmvNYqNl9xir7Qrog-1; Thu,
 24 Oct 2024 20:37:40 -0400
X-MC-Unique: eFB_oBmvNYqNl9xir7Qrog-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0E0719560AA;
	Fri, 25 Oct 2024 00:37:38 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C51291956088;
	Fri, 25 Oct 2024 00:37:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/3] blk-mq: add non_owner variant of start_freeze/unfreeze queue APIs
Date: Fri, 25 Oct 2024 08:37:18 +0800
Message-ID: <20241025003722.3630252-2-ming.lei@redhat.com>
In-Reply-To: <20241025003722.3630252-1-ming.lei@redhat.com>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add non_owner variant of start_freeze/unfreeze queue APIs, so that the
caller knows that what they are doing, and we can skip lockdep support
for non_owner variant in per-call level.

Prepare for supporting lockdep for freezing/unfreezing queue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 20 ++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940f59..96858fb3b9ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -196,6 +196,26 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
+/*
+ * non_owner variant of blk_freeze_queue_start
+ *
+ * Unlike blk_freeze_queue_start, the queue doesn't need to be unfrozen
+ * by the same task.  This is fragile and should not be used if at all
+ * possible.
+ */
+void blk_freeze_queue_start_non_owner(struct request_queue *q)
+{
+	blk_freeze_queue_start(q);
+}
+EXPORT_SYMBOL_GPL(blk_freeze_queue_start_non_owner);
+
+/* non_owner variant of blk_mq_unfreeze_queue */
+void blk_mq_unfreeze_queue_non_owner(struct request_queue *q)
+{
+	__blk_mq_unfreeze_queue(q, false);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
+
 /*
  * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
  * mpt3sas driver such that this function can be removed.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4fecf46ef681..c5063e0a38a0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -925,6 +925,8 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
+void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
+void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
-- 
2.46.0


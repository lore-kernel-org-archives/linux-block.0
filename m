Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6001E411D
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292186; cv=none; b=sYLdGL9b+rD9haHkh1DAc6buMduSmba0KyEPTjTlglnKPtjHj6HTZZxuALS+Hzlv3u3V1rQqOinISlWr8TXvBqAwzLFdnKuJUY47yXy6wdacITZRRDUGR0YRTbmqZlI1UiMftEQKT92VOz0v8s417SE6KS4gsnHpGzgSUxyvIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292186; c=relaxed/simple;
	bh=cIpm7/Mv1/Dm5u3a5E2sIF9GhrybngbpYo4cGeWviDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrMVqpWsBcwGTFQ+Qn1fa/i+RS9bdUzPaVe0Ro4LdNUGm3ByAH4XS1CCrKaWAfP6UZxlfsQRdvwUuFgkEsPt4vwoGlvCRpX4HsgUGsatqq3cgiiFHHhtCPzcfKTSrK37cEVx5bN4ltKOUsUqOltUFT/fZ4TV+uP6DkIv+khgXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JoP+bus6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoP+bus6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730292183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApEMFDOrNDD/+MWPH551HnF0S8o5RB1vvdhPKMCWkUc=;
	b=JoP+bus6JKtVwZ6s6Xy7fetJhqqvk0E1+xp4xCwfTLm9nuPyUDZZPRuF7QnXEk50BfZqpw
	zug1iB8OW9pU2co+Ytc6T2LmzqK8/Wg5yyilrXw7peETny1obRgyOWyM/XDCVlhqHVB5kj
	DkYPbbeuxRWY6u7Fnwr6HBlX733QLGI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-MBdBJgmvN2iYW6NZ53nfyA-1; Wed,
 30 Oct 2024 08:43:00 -0400
X-MC-Unique: MBdBJgmvN2iYW6NZ53nfyA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5628019560BF;
	Wed, 30 Oct 2024 12:42:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.140])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDDFB19560AA;
	Wed, 30 Oct 2024 12:42:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/5] blk-mq: add non_owner variant of blk_mq_freeze_queue API
Date: Wed, 30 Oct 2024 20:42:34 +0800
Message-ID: <20241030124240.230610-3-ming.lei@redhat.com>
In-Reply-To: <20241030124240.230610-1-ming.lei@redhat.com>
References: <20241030124240.230610-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add non_owner variant of blk_mq_freeze_queue API for rbd.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 14 +++++++++++---
 include/linux/blk-mq.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5f4496220432..8e18284ede8f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -195,12 +195,20 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
 /*
- * non_owner variant of blk_freeze_queue_start
+ * non_owner variant of blk_mq_freeze_queue
  *
- * Unlike blk_freeze_queue_start, the queue doesn't need to be unfrozen
- * by the same task.  This is fragile and should not be used if at all
+ * Unlike blk_mq_freeze_queue, the queue doesn't need to be unfrozen by
+ * the same task. This is fragile and should not be used if at all
  * possible.
  */
+void blk_mq_freeze_queue_non_owner(struct request_queue *q)
+{
+	__blk_freeze_queue_start(q);
+	blk_mq_freeze_queue_wait(q);
+}
+EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_non_owner);
+
+/* non_owner variant of blk_freeze_queue_start */
 void blk_freeze_queue_start_non_owner(struct request_queue *q)
 {
 	__blk_freeze_queue_start(q);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2035fad3131f..ed15dc2e7bd6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -919,6 +919,7 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
+void blk_mq_freeze_queue_non_owner(struct request_queue *q);
 void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
 void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
-- 
2.47.0


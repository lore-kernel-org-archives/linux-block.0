Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB82F4A
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743568792; cv=none; b=RLIS8LAGVfPxfsxUYrXjNBCtT1sgPE5XmheEK5uqdlfUt4NN0/juL4ith9AwxE+6Z7NugCUGZer9ChdMf2D5sn0uym9TlQRTmVXXTaV9/GK5HL4YYI8XCuwZzQptMn+MntGGdPUL7Nzdz7JTbEzlduOl5FEQbQ1q3gDlB+/WPYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743568792; c=relaxed/simple;
	bh=f1y0yryZJU4h98bIM2gCVNNdwJmKBYSHHUO6JTn8o+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TStaDln4YCNlNZ2EiHd1UzQQmvFS+FjIHe9WZw9TlhRvAgp/xgv/xXL1J+O2tBeimUPLASFhSY5T9pyA1r5iBF5IZKZ8ldudjLYvo6Ty7dmE2opLiTPGENcb+G0xkzEwaaJD90MyrJP5r3ZXEWdqZz6PctJonWiRL1uRIF3OWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgdCZxIZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgdCZxIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743568789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oG+Y/T/9+lkc4sbaPiduxobTv0swNXrFUR3AE2EMjGE=;
	b=SgdCZxIZUWpbZwR03KK3Q8MdozCQX1wq/aRdvAHjKTieoKo134YK9LwUqSSeuywguWiW8x
	mQjukCJNlWU6LWvl0vVL2/z3G+ZxSvOxzoluk2qCE7uZcT6h72BIfb7BymKn7SnnmOsvbk
	N17X6CG4tRE2vqYdO1aNXdaWoUGM2L8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-GU7Cgs1NN2GmKSxtlHebTQ-1; Wed,
 02 Apr 2025 00:39:45 -0400
X-MC-Unique: GU7Cgs1NN2GmKSxtlHebTQ-1
X-Mimecast-MFC-AGG-ID: GU7Cgs1NN2GmKSxtlHebTQ_1743568784
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67C7E19560BC;
	Wed,  2 Apr 2025 04:39:44 +0000 (UTC)
Received: from localhost (unknown [10.72.120.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 128D219560AD;
	Wed,  2 Apr 2025 04:39:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] block: don't call freeze queue in elevator_switch() and elevator_disable()
Date: Wed,  2 Apr 2025 12:38:48 +0800
Message-ID: <20250402043851.946498-3-ming.lei@redhat.com>
In-Reply-To: <20250402043851.946498-1-ming.lei@redhat.com>
References: <20250402043851.946498-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Both elevator_switch() and elevator_disable() are called from sysfs
store and updating nr_hw_queue code paths only.

And in the two code paths, queue has been frozen already, so don't call
freeze queue in the two functions.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index b4d08026b02c..4d3a8f996c91 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -615,12 +615,10 @@ void elevator_init_mq(struct request_queue *q)
  */
 int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
-	unsigned int memflags;
 	int ret;
 
 	lockdep_assert_held(&q->elevator_lock);
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
@@ -641,7 +639,6 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 out_unfreeze:
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 
 	if (ret) {
 		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
@@ -653,11 +650,8 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 void elevator_disable(struct request_queue *q)
 {
-	unsigned int memflags;
-
 	lockdep_assert_held(&q->elevator_lock);
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	elv_unregister_queue(q);
@@ -668,7 +662,6 @@ void elevator_disable(struct request_queue *q)
 	blk_add_trace_msg(q, "elv switch: none");
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 }
 
 /*
-- 
2.47.0


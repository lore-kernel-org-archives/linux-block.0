Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545D4199BC
	for <linux-block@vger.kernel.org>; Sat,  1 Nov 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003911; cv=none; b=rx08/l3pkZb8rh75llNJurXnAXf6lZX11VRiMdCAqOgyTPEN9sPtmzYBgphs/GSgRisa3z6ET+7KJhS3ihO7anTIve8+Ea7NSAeYZ2MsGdzVGrOmbIY+gSL45PscI9h+kPkteQUgvIruHzNHO8uY5NllC82LZZCA9mTFrVgeHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003911; c=relaxed/simple;
	bh=XBtDMCQ8Z26PR87XHubAs9yPbzRTFjED7FepHdLHdCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Od9rrbTXmTEz7AKxw02y3fJM8K8JhjQXI1vlcc2Fy39NgLLSY+46VN72phddE2XnpfcgDZ7hK5SSrhXsLhmg8qJd1XL1sVPDsseuGNqGrrvkDCh6avcgHKRhWjkbIcW+Uub8bjyMAoYt3ycXE4/I46syD5wdiGEwwofZOOXsqcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Djnd1l9D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Djnd1l9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762003909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv8yrlwNcQgjmjBqS8jZZXx6Q0/npBLeSw5bM/zJaNQ=;
	b=Djnd1l9DUBT6H8gfXUcdeGGh/Vqfifad+TMc/XwCGRz582XUSiheZgEqNTW2SD2KrEemQh
	ohvzxoLi8KelSw5WBISF/8F/FP7fJF/05YqWZpnEvM9aEm9jNA1RhFROVMveJ7cdgt4iBR
	Y6IlY76dh8/3lKZEkv7RbzKZOGG9Tcg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-S6eWMbFvPO6Th0IWibPaLA-1; Sat,
 01 Nov 2025 09:31:47 -0400
X-MC-Unique: S6eWMbFvPO6Th0IWibPaLA-1
X-Mimecast-MFC-AGG-ID: S6eWMbFvPO6Th0IWibPaLA_1762003906
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEBBC180057A;
	Sat,  1 Nov 2025 13:31:46 +0000 (UTC)
Received: from localhost (unknown [10.72.120.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77C7E30001A1;
	Sat,  1 Nov 2025 13:31:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 3/5] ublk: use struct_size() for allocation
Date: Sat,  1 Nov 2025 21:31:18 +0800
Message-ID: <20251101133123.670052-4-ming.lei@redhat.com>
In-Reply-To: <20251101133123.670052-1-ming.lei@redhat.com>
References: <20251101133123.670052-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Convert ublk_queue to use struct_size() for allocation.

Changes in this commit:

1. Update ublk_init_queue() to use struct_size(ubq, ios, depth)
   instead of manual size calculation (sizeof(struct ublk_queue) +
   depth * sizeof(struct ublk_io)).

This provides better type safety and makes the code more maintainable
by using standard kernel macro for flexible array handling.

Meantime annotate ublk_queue.ios by __counted_by().

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d920f7cf4dad..96e07763cd28 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -203,7 +203,7 @@ struct ublk_queue {
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	spinlock_t		cancel_lock;
 	struct ublk_device *dev;
-	struct ublk_io ios[];
+	struct ublk_io ios[] __counted_by(q_depth);
 };
 
 struct ublk_device {
@@ -2700,7 +2700,6 @@ static int ublk_get_queue_numa_node(struct ublk_device *ub, int q_id)
 static int ublk_init_queue(struct ublk_device *ub, int q_id)
 {
 	int depth = ub->dev_info.queue_depth;
-	int ubq_size = sizeof(struct ublk_queue) + depth * sizeof(struct ublk_io);
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
 	struct ublk_queue *ubq;
 	struct page *page;
@@ -2711,7 +2710,8 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
 
 	/* Allocate queue structure on local NUMA node */
-	ubq = kvzalloc_node(ubq_size, GFP_KERNEL, numa_node);
+	ubq = kvzalloc_node(struct_size(ubq, ios, depth), GFP_KERNEL,
+			    numa_node);
 	if (!ubq)
 		return -ENOMEM;
 
-- 
2.47.0


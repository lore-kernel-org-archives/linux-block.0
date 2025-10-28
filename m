Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534422D5C61
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641827; cv=none; b=WZJksDl4ew2PihdBWaE6B/9jEJ3t6Nv/q4T94dPlYlr+8ySZNIjyZP4WtU3BooN5zpWKFqPJeZRyqzAtKLBPqNywzQbP7gKEvymmF4Y+r7UtyJLBNTn+cVIH6jnHNbw4gvyOiTQcRjdkZajJ0N6cm/beCIVtSezY3FbGOR2Y0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641827; c=relaxed/simple;
	bh=+XsoY/2XolODBt+42r7lUR75Q1/Vxkp9DjTMXy6oIqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXkrC9lfYRiPTrD9MYF9k0BsFx/O5QbEm/9lyilcbcv2lneV2bXn8mLv5uNNzzZoVAVJQxE7pYRHPuLh8nkzC4E74WcNb4IchekUH+Rid7HHLHDeDWCofvmJ8PLVaBeVJdKmv5TXOsIyYZDc8i55ylKHb27t+EiC9nq+jvK3Yts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwtpduqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwtpduqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761641825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/esdmGqzd/pFOeulx3/8IU5FKS0gldoST/MQnEzuTYE=;
	b=GwtpduqTOpL6+A8MhzsgemXoXqT5hbQx1nZ4ndHas6HOTgJwL952xXx0jYufNdEiIq/LqV
	3fbiiH1o3EhgA4uH3B8JZYnix9qhBKVbAzaYyVMVXCOzthk5MYWCO3oMlTSRlZjhInadv8
	cPf//LJxAJc6OPc/mX3uUMBD8Bv5QeI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-jurD_1xyPva8u0Lx2TcumQ-1; Tue,
 28 Oct 2025 04:56:59 -0400
X-MC-Unique: jurD_1xyPva8u0Lx2TcumQ-1
X-Mimecast-MFC-AGG-ID: jurD_1xyPva8u0Lx2TcumQ_1761641818
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E867818001E3;
	Tue, 28 Oct 2025 08:56:57 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCED419560AD;
	Tue, 28 Oct 2025 08:56:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/5] ublk: use flexible array for ublk_queue.ios
Date: Tue, 28 Oct 2025 16:56:32 +0800
Message-ID: <20251028085636.185714-4-ming.lei@redhat.com>
In-Reply-To: <20251028085636.185714-1-ming.lei@redhat.com>
References: <20251028085636.185714-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Convert ublk_queue to use DECLARE_FLEX_ARRAY for the ios field and
use struct_size() for allocation, following kernel best practices.

Changes in this commit:

1. Convert ios field from "struct ublk_io ios[]" to use
   DECLARE_FLEX_ARRAY(struct ublk_io, ios) for consistency with
   modern kernel style.

2. Update ublk_init_queue() to use struct_size(ubq, ios, depth)
   instead of manual size calculation (sizeof(struct ublk_queue) +
   depth * sizeof(struct ublk_io)).

This provides better type safety and makes the code more maintainable
by using standard kernel macros for flexible array handling.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 394e9b5f512f..cef9cfa94feb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -203,7 +203,8 @@ struct ublk_queue {
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	spinlock_t		cancel_lock;
 	struct ublk_device *dev;
-	struct ublk_io ios[];
+
+	DECLARE_FLEX_ARRAY(struct ublk_io, ios);
 };
 
 struct ublk_device {
@@ -2700,7 +2701,6 @@ static int ublk_get_queue_numa_node(struct ublk_device *ub, int q_id)
 static int ublk_init_queue(struct ublk_device *ub, int q_id)
 {
 	int depth = ub->dev_info.queue_depth;
-	int ubq_size = sizeof(struct ublk_queue) + depth * sizeof(struct ublk_io);
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
 	struct ublk_queue *ubq;
 	struct page *page;
@@ -2711,7 +2711,8 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
 
 	/* Allocate queue structure on local NUMA node */
-	ubq = kvzalloc_node(ubq_size, GFP_KERNEL, numa_node);
+	ubq = kvzalloc_node(struct_size(ubq, ios, depth), GFP_KERNEL,
+			    numa_node);
 	if (!ubq)
 		return -ENOMEM;
 
-- 
2.47.0


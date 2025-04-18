Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9E1DE89C
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994254; cv=none; b=DEC2tjtZhaUjUuGv41ELR6zAKhG1Exr5rp9WcjjMt8o7nBi0FEg5oEAJtBWdDFRPbD0jfRPOG/f9DFjv/00379gj3zjP6U5Z+J7YnlopRs3+Ct1V9WlPEbbmHVh0BrFKe4+rHpHxyRfUMI66CC0R8kUH12f7Jr/K2a1kJOzGRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994254; c=relaxed/simple;
	bh=OekWkbXXWVC2e0o7p+59vMG5DTG2K+6CkaptD60z0YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrjjEFXuvsup384RcywU7H3qRqfXNS63q9pvxXX09IQpfioXvLrl8w6nWUQOMSmN+UkS+0iiJmcSco/RZsGdWV3ZHNRPhcz2WoOhT2ouDr1QZ59PwV73ZrbIcPfxO2rj2sY0EocBbl3qhTxjS8qWQxNdoF8eWchg0qXUqj5Yf6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XP+uBi/q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XP+uBi/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKrc+xETT0qprHI8rv9ShF+wQAVxVxWdOFPF3+qK7/U=;
	b=XP+uBi/qTRa5TIJN5RtqOoqMY+GPTN0JdzQx09MhuUkeSTxll1aXg0kEDcuwxIXpm0IcN1
	7ZqG/TMr2r3VLJNBUT6L0DjlDVIEUiB0EZXshJOKTYfdXyTae+UXcF4q9zQwQFKLpPxT8Z
	WvsiUD+B/acHE+cNsLK0AovBx+w3OWo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-yFZtN0OOOhOBCHKZ1G70Kg-1; Fri,
 18 Apr 2025 12:37:28 -0400
X-MC-Unique: yFZtN0OOOhOBCHKZ1G70Kg-1
X-Mimecast-MFC-AGG-ID: yFZtN0OOOhOBCHKZ1G70Kg_1744994246
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B0621955DC6;
	Fri, 18 Apr 2025 16:37:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2850F180047F;
	Fri, 18 Apr 2025 16:37:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 01/20] block: move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue()
Date: Sat, 19 Apr 2025 00:36:42 +0800
Message-ID: <20250418163708.442085-2-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue(), and publish
this request queue to tagset after everything is setup.

This way is safe because BLK_MQ_F_TAG_QUEUE_SHARED isn't used by
blk_mq_map_swqueue(), and this flag is mainly checked in fast IO code
path.

Prepare for removing ->elevator_lock from blk_mq_map_swqueue() which
is supposed to be called when elevator switch isn't possible.

Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Closes: https://lore.kernel.org/linux-block/567cb7ab-23d6-4cee-a915-c8cdac903ddd@linux.ibm.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e0fe12f1320f..7cda919fafba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4561,8 +4561,8 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->nr_requests = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
-	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
+	blk_mq_add_queue_tag_set(set, q);
 	return 0;
 
 err_hctxs:
-- 
2.47.0


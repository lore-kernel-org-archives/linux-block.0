Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875DF18DB26
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454705; cv=none; b=k5lNd2qR3t1WZt3aRaTSd7E8i2E+UvVnUUpbyuu4Efev5ZAP+DxGSuRpcikxELvmmO8nYBB/9AToFh/tQQp4X+SwYS5g/TISME9cibNKJMd/fM/6t8vDFUZIk3TPoM9WUtVDAyp6kJFqXzBnZJZEwLItpBpf8IttXIuUyBr2sEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454705; c=relaxed/simple;
	bh=zlKEVOR7meRZe0ht/QaQPO+q/Fm7zgXOoIgcWX0AjSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDG/4Iifm+zukC/9409WE65abFxqFqjVh4gvozBFp2lrimp8EBIpvECuuu6g9x1d6fxiEJgbj+BvPYdg6cD0kYPknJd/5yFIXcB4RCjVWSxCHu/YZ/qeJdwPbdu2YKEcG1LQWL9Ht9nkeTRRexvgjuZ+7bzosE6Fry03Cuf7txg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8KbY9V6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8KbY9V6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RotmYvAN13an/RGbb+NCZ7OQoPB1EuYmwvYdNOwZ0kI=;
	b=f8KbY9V6tUioETJpL5ovo2VC2bONTp+UVWlZuu8l/OpgfDI9vij9SMT6aLRIQhKegTyC/o
	Ohb4LbiSg1U+knePzueRZ/P8wjGXlatIKr8Syk5956k7xa57wj91eIw8UwvIyW+kDc2yTb
	kNsvcGWwT1sl2kHFMWFshoTPOURy/P4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-3wzjpx1yOC6_ntzms_AQuw-1; Mon,
 05 May 2025 10:18:19 -0400
X-MC-Unique: 3wzjpx1yOC6_ntzms_AQuw-1
X-Mimecast-MFC-AGG-ID: 3wzjpx1yOC6_ntzms_AQuw_1746454697
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F4321800360;
	Mon,  5 May 2025 14:18:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36F0230001A2;
	Mon,  5 May 2025 14:18:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 01/25] block: move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue()
Date: Mon,  5 May 2025 22:17:39 +0800
Message-ID: <20250505141805.2751237-2-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue(), and publish
this request queue to tagset after everything is setup.

This way is safe because BLK_MQ_F_TAG_QUEUE_SHARED isn't used by
blk_mq_map_swqueue(), and this flag is mainly checked in fast IO code
path.

Prepare for removing ->elevator_lock from blk_mq_map_swqueue() which
is supposed to be called when elevator switch can't be done.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Closes: https://lore.kernel.org/linux-block/567cb7ab-23d6-4cee-a915-c8cdac903ddd@linux.ibm.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 796baeccd37b..3292f2c4147a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4627,8 +4627,8 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->nr_requests = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
-	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
+	blk_mq_add_queue_tag_set(set, q);
 	return 0;
 
 err_hctxs:
-- 
2.47.0


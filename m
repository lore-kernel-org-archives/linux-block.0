Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F61EEFC
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 04:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709093350; cv=none; b=BKohFm+a/XIfwU7NnzeIG/ERBzd3wwDW2r7YNFgmT6qbEf/RyyMYCUeXjPvBUqm4tPUeNcZKO9pOk6N66Oaf6F2FPxiQsWxwGMm48c1q6bwLOQs8BTCyDBrav4tcHkvwDli52/6ZncN28h9bfRvsGjAto/nWeuJPzWoYQegTCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709093350; c=relaxed/simple;
	bh=aQmo9I1e9soWAtnVNAnQYdUBUetl+2D/dVQPsruzHGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zi9JcB5jVFdIEQBWiDxIHFBWeEmmrOGL2ZL0PJHU9BUCXiiF06hfAltAI+O6xe/Uf9/EJpin8P3m5wRYAL0FwYXQvFAl5cnfribHBPTvUSmLGlZ94bfbffmnCIdK84UmKp5G4Ga/ED4Wd73UfgcSKumLRWG8y6x8XO58t0Tps5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6Srkdnt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6Srkdnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709093347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VGz7vKJt0O6V8rmO5PTcq0k+tHE+PbvVY8N9P3/7HAc=;
	b=C6Srkdnt6iQ8uAhYvBLnuq6cr8hHvEOF+ik/qnlBBhC80FdW3/G7rkvJb83rE71Kwc+/CC
	eQOGhFK0I1hwUkhy/VrmrCyMdzNnV0aNLUWjFBUjQyg0qPX1JSGCwUAK7ebp2H9r6pep85
	IbrwcqKGnY1bU5HqAesA/xsFZnvT04A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-qxwrW69tOgSwos2dmrHU6g-1; Tue, 27 Feb 2024 23:09:02 -0500
X-MC-Unique: qxwrW69tOgSwos2dmrHU6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B894582DFE6;
	Wed, 28 Feb 2024 04:09:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B51781807;
	Wed, 28 Feb 2024 04:09:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Wen Xiong <wenxiong@us.ibm.com>
Subject: [PATCH] blk-mq: don't change nr_hw_queues and nr_maps for kdump kernel
Date: Wed, 28 Feb 2024 12:08:57 +0800
Message-ID: <20240228040857.306483-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

For most of ARCHs, 'nr_cpus=1' is passed for kdump kernel, so
nr_hw_queues for each mapping is supposed to be 1 already.

More importantly, this way may cause trouble for driver, because blk-mq and
driver see different queue mapping since driver should setup hardware
queue setting before calling into allocating blk-mq tagset.

So not overriding nr_hw_queues and nr_maps for kdump kernel.

Cc: Wen Xiong <wenxiong@us.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6abb4ce46baa..be5f6380d46d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4391,7 +4391,7 @@ static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 	if (set->nr_maps == 1)
 		set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;
 
-	if (set->ops->map_queues && !is_kdump_kernel()) {
+	if (set->ops->map_queues) {
 		int i;
 
 		/*
@@ -4490,14 +4490,12 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 
 	/*
 	 * If a crashdump is active, then we are potentially in a very
-	 * memory constrained environment. Limit us to 1 queue and
-	 * 64 tags to prevent using too much memory.
+	 * memory constrained environment. Limit us to  64 tags to prevent
+	 * using too much memory.
 	 */
-	if (is_kdump_kernel()) {
-		set->nr_hw_queues = 1;
-		set->nr_maps = 1;
+	if (is_kdump_kernel())
 		set->queue_depth = min(64U, set->queue_depth);
-	}
+
 	/*
 	 * There is no use for more h/w queues than cpus if we just have
 	 * a single map
@@ -4527,7 +4525,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 						  GFP_KERNEL, set->numa_node);
 		if (!set->map[i].mq_map)
 			goto out_free_mq_map;
-		set->map[i].nr_queues = is_kdump_kernel() ? 1 : set->nr_hw_queues;
+		set->map[i].nr_queues = set->nr_hw_queues;
 	}
 
 	blk_mq_update_queue_map(set);
-- 
2.41.0

